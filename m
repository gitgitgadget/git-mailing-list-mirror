Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD043202A3
	for <e@80x24.org>; Wed, 18 Oct 2017 20:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbdJRUFK (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Oct 2017 16:05:10 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:49404 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdJRUFJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Oct 2017 16:05:09 -0400
Received: by mail-qt0-f181.google.com with SMTP id k31so11828808qta.6
        for <git@vger.kernel.org>; Wed, 18 Oct 2017 13:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tWxv2FOJ8qv9fUtZemMOJrAXrts6z5+gXbvw9scuKqo=;
        b=VFbQZ8+ec8FuoNZPIEWYK4EXnFBPQp6Of+CMgH942jp2szhOcjFna+oFuCKh7rVTn5
         dYq3TnNab272Gu1klXeWhGj0thzzHLb7lQDM3aJj/dq5i4WDtE+3ml1Pwm3MhdBT6mkE
         LLvqsMHdFNyHDASThrjDkI8WVL1x2sGkgAKCedsfsEdA+V/hgDJxRg3670Jj/cach0ck
         4NYE+/VmACbWi/JVTxPPwuukTDt9KfJ3H+Okm8TcWziGJJCt5aXqvB7C+HGncXMfjaEA
         mcwoucTj+ySzxtErFoRNy/qDGFbJeyoNI0fIQbIl1wCU64iRiTr7HYX1YUjnVq3+Tdlq
         pp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tWxv2FOJ8qv9fUtZemMOJrAXrts6z5+gXbvw9scuKqo=;
        b=EBCqo+f+KSn1CrpCCvBf283eIAhrWe2oqmVyPufLMdex3cufp7Ftu7gSpjK38NhAqq
         BIiohyvq1p5boqePEeN6oXhdU2rI6X6I6grfRzlHq+X4ezh6hrISnbV5K4Lat/OEkEu2
         VBu2OcU6+lR0/4Hvqe4mCRikk4wU8sypTOzvzwowkQ6zCe6Pb3dcJDXCnz2nXNrp5PYq
         LijWQFwjmMnuAtu7Ne6X3MJY1UljAU3C2EE1aeVlmMjBOHAKxRw4RMpkHeC86kLHde0I
         u9aSINuUTAPWu+DkAZBtwkLTByGpgTKy/t3Wkggmy3NLs/LqGDqLqUI6VQUU8zRp3hW8
         9+2w==
X-Gm-Message-State: AMCzsaUrOSyjKjrpISUcQGWzLhLS7skgeqme95yS3LpYOMqxCvm/rlKJ
        5SsMWt36LIEFvipHnVTAZ5MGMBeLzX4BuWcyRYrBpLAdhqw=
X-Google-Smtp-Source: ABhQp+SWU/DzIUIbD/t5TWTv1Quf5lB5H52QZBXSALaZr8xOwchJFP1IhlYb6qgJLcYPEfl1R1Pof+kWeHtbJkiB8pY=
X-Received: by 10.237.53.137 with SMTP id c9mr5278218qte.125.1508357108763;
 Wed, 18 Oct 2017 13:05:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 18 Oct 2017 13:05:08 -0700 (PDT)
In-Reply-To: <0102015f310e24b9-b96378f3-a029-4110-80dd-e454522e2cb7-000000@eu-west-1.amazonses.com>
References: <0102015f310e24b9-b96378f3-a029-4110-80dd-e454522e2cb7-000000@eu-west-1.amazonses.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 18 Oct 2017 13:05:08 -0700
Message-ID: <CAGZ79kZG=nk+U815mWhSMDHqa=UHSwCc_PbQcaTRBA8DBKoWrw@mail.gmail.com>
Subject: Re: [PATCH] use filetest pragma to work with ACL
To:     Guillaume Castagnino <casta+github@xwing.info>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 18, 2017 at 12:55 PM, Guillaume Castagnino
<casta+github@xwing.info> wrote:
> From: Guillaume Castagnino <casta@xwing.info>
>
> as stated in comment in https://github.com/git/git/commit/46a13857fc036b54ac2ddd0a218e5cc171aa7bd9#diff-00703a794a540acf45e225abd6aeda3b the referenced commit is broken when using ACL and not basic UNIX rights.
> this commit handle ACL too

Thanks for contributing to Git!

Please see Documentation/SubmittingPatches for details,
tl;dr:
* If you can legally agree with
   https://developercertificate.org/
   add a line "Signed-off-by: NAME <email>"
* Please give a more descriptive commit message.
  Usually we phrase the commit subject as
  "area: do thing", you have the "do thing" part,
  but the area is unclear. Maybe:
      gitweb: use filetest to allow ACLs

* Keep the message text roughly at 70 characters per line,
  as that is easier to read in e.g. git-show.

* Instead of linking to github, we usually only refer to the commit, e.g.

   In commit 46a1385 (gitweb: skip unreadable subdirectories, 2017-07-18)
   we forgot to handle non-unix ACLs as well. Fix this.

* Do we need a test/documentation for this?

Thanks,
Stefan

> ---
>  gitweb/gitweb.perl | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9208f42ed1753..0ee7f304ce2b1 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3072,6 +3072,7 @@ sub git_get_projects_list {
>                                 # only directories can be git repositories
>                                 return unless (-d $_);
>                                 # need search permission
> +                               use filetest 'access';
>                                 return unless (-x $_);
>                                 # don't traverse too deep (Find is super slow on os x)
>                                 # $project_maxdepth excludes depth of $projectroot
>
> --
> https://github.com/git/git/pull/416
