Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E970208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 14:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754203AbdHUOHZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 10:07:25 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:35136 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753546AbdHUOHX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 10:07:23 -0400
Received: by mail-qt0-f195.google.com with SMTP id e2so1376876qta.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 07:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CgzJTLQbv/Y5MI+fuvb9cn5sVmztmbSaCzTp6ZCcZK0=;
        b=Ho+/SM9MseCrVbFW3LYyCrYckEGkecLR20tzXm4AwbWxdRE0Fpouakil+AlOD4R9Bs
         rUiqNOMiYFm3AwkZk3iySIkv2io5g560E5ixYCPAarSBv8UK1zbrNWpNBfYwI/aU5zSX
         zVog97dsUMo4upD6I3fRBl2OJUoEZG7ECmVPFKS5o95fzU+QNrnH2P8Nkupea50WJY9v
         TPOVrt2uUUD8ooVuGkEaIGSNa9MKR0ZqHhhc/U90nEdAHQMzx/C+HXs25GUN6ErCvOMu
         Ra+Lspyu6C8VfnyrRfIdPWg+iGqUicKh99xauirAycAUy6cx2+JYNWY6denn3Z1wa6Qb
         HQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CgzJTLQbv/Y5MI+fuvb9cn5sVmztmbSaCzTp6ZCcZK0=;
        b=uEv3njKp4HRr9/LOYZx+ow/qQPW/Lk4CHAmC9lOFl40MXcH56bE4fl5Q7nCxQUG9MX
         H8Y2K09hhiONlb5+MUUbiDGUQ/zw5czW2Ed4tjBqMNlZM232Dt9cvQSZ48vfmGekU718
         hbspZ+MR+D7lDimmMG1VbJ1QNuFyafxbEfRulaQ1UoFge47F1Br4GzJQa7jLvnmo7jAB
         hmJYdKuJO8O+1j7mbNj13e1xCtLs4DoafHQIg5dfU8yLWxqSaFTcSxvdlkOSTPNtUkrP
         GXjtQjK4pDSavI/wxd2V+wW+oFfifldwcBVPz/I95DDEIEvFeFnSOFhVFrVzUmjVs5rf
         QBmA==
X-Gm-Message-State: AHYfb5gcf5iCkgdC/QuMdiP6B380FYjdLEcKn1arUGT0U3CiIV/kK0mW
        qVrKUqzZltBQKm7Woz5+WuP8kPuiQw==
X-Received: by 10.237.52.6 with SMTP id w6mr26090108qtd.197.1503324442428;
 Mon, 21 Aug 2017 07:07:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.16.242 with HTTP; Mon, 21 Aug 2017 07:07:01 -0700 (PDT)
In-Reply-To: <20170821104425.geetdgi7q2uqycyt@hanna.meerval.net>
References: <20170802185901.GA27243@Vurt.local> <20170820180332.GC39363@Vurt.local>
 <CAOxFTcxOt878uDYj1Y0QMDNe8mNkfX3ZaZayOH3Njp9RWCJo0Q@mail.gmail.com> <20170821104425.geetdgi7q2uqycyt@hanna.meerval.net>
From:   Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Date:   Mon, 21 Aug 2017 16:07:01 +0200
Message-ID: <CAOxFTcxaxRjdsd0OSQX9E9ncEnO4XFLoa-0puXm2AByv6dZUow@mail.gmail.com>
Subject: Re: [PATCH] Add 'raw' blob_plain link in history overview
To:     Job Snijders <job@instituut.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        yashi@atmark-techno.com, Jakub Narebski <jnareb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Mon, Aug 21, 2017 at 12:44 PM, Job Snijders <job@instituut.net> wrote:
> On Mon, Aug 21, 2017 at 12:19:38PM +0200, Giuseppe Bilotta wrote:
> Thank you for your feedback, good point. Please see below:

This looks fine
> ---
>
> Add a 'raw' blob_plain link in history overview
>
> Signed-off-by: Job Snijders <job@instituut.net>
> ---
>  gitweb/gitweb.perl | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9208f42ed..c43bbe331 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5967,6 +5967,9 @@ sub git_history_body {
>                       $cgi->a({-href => href(action=>"commitdiff", hash=>$commit)}, "commitdiff");
>
>                 if ($ftype eq 'blob') {
> +                       print " | " .
> +                               $cgi->a({-href => href(action=>"blob_plain", hash_base=>$commit, file_name=>$file_name)}, "raw");

Nitpick: gitweb uses tabs for nested indents, but spaces for
alignment. For this line here, the last tab should be replace with
spaces (to align the $ with the quotes above.)

With that fixed, you can add

Reviewed-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>


-- 
Giuseppe "Oblomov" Bilotta
