Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2088F1F404
	for <e@80x24.org>; Thu, 19 Apr 2018 22:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753765AbeDSWOX (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 18:14:23 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:38790 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753755AbeDSWOW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 18:14:22 -0400
Received: by mail-io0-f177.google.com with SMTP id h9-v6so8407925iob.5
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 15:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=716aIeSZ4w0KmEWdvD2Q0ssWwFhquiWu0KtcKofhw58=;
        b=rc1TtMw8MW99S72NGPQzZSmJ2L8BOGq8P/KQtt1pAg3keR83sWPXOnF7OgkhwxHyrO
         Kvx+IqJpnC8OHY1FwVFfM7wAPSpFw0SxN0l2qlm+PcXINz+2iPp4VagAPEhwmzM1+qaA
         AEdf8uQzsd/R0u/FKzisjCAQdSh12U5HXQ68/sxlXCh6rDkRpi05rBgCelmymMy1X/lG
         q8CAA+cl42+gjXR2P0ah3u89cODIN8v0EDIHBeXHOXQL2LO/Y27LS/CQA2Q9VbvbawBV
         EMH61WGdmX11DLya6c32uCm3LIDYeH4qKRCBeBjlcOnfSZZsHD76veH+gUHID7q1mD3z
         KXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=716aIeSZ4w0KmEWdvD2Q0ssWwFhquiWu0KtcKofhw58=;
        b=MnO+ce6oTt/OVk9XhvgGn8C92f2NsAbNBZbByMRq2MwoErEEkIU3dDfv9zCOXjN1+G
         vcbPF1RLG5w3MEyoTEGQhd5WZ5B7PunoBi7loeyf7CjTBEtZiSYO0Xt2bCRTl/CAJAJm
         jtUVAOHhqPOMtLMGN8STKhPW09+ZZVJv2iRET48fGSZxDHznZ/iHTaM8bVQT6Xmw2KgK
         f4mV+U9nl73IWPBGnOuV5RIHwHpgC0VoTa4lCegxgqtJKhoQILTHHHJJqJOg7MJmMIBz
         NpYWvqMYhF2Sb4Y7llJd1XLi0J0bXUN9+ucB0uX6S0XleNpR3/03drgfM0InBbCFJmoM
         WDcw==
X-Gm-Message-State: ALQs6tA3up1vv4YHycGYyEYSErvFnCf0/V1hKDbt8b7L51z2WbnyIrR1
        jfocce0u6gJ8EgkaQv3Zgtc8etWhKvZdEa9RWPJyHVMDHcM=
X-Google-Smtp-Source: AB8JxZphdwG6X3sDcQB459TmwGxZaWtrEer8sx2FWpn+RUF85orIrAc4PpVOZzUr5qEb+ZWd/hgCipksdw1dVROejIc=
X-Received: by 2002:a6b:b68a:: with SMTP id g132-v6mr7882672iof.182.1524176060933;
 Thu, 19 Apr 2018 15:14:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.97.20 with HTTP; Thu, 19 Apr 2018 15:14:20 -0700 (PDT)
In-Reply-To: <adc410f016e8405fb81fa92e45675e2a@standardlife.com>
References: <adc410f016e8405fb81fa92e45675e2a@standardlife.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Thu, 19 Apr 2018 15:14:20 -0700
Message-ID: <CAGyf7-G7GDX6DtpAqQvQ-8Rwad1VS6_xdDw_Rt_p5kT-C7dFZA@mail.gmail.com>
Subject: Re: Bug Report - Pull remote branch does not retrieve new tags
To:     Andrew Ducker <andrew_ducker@standardlife.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrew,

On Thu, Apr 19, 2018 at 6:55 AM, Andrew Ducker
<andrew_ducker@standardlife.com> wrote:
>
> What happens:
> When I create a new tag on the remote (changing nothing else)
> "git pull origin master" produces the following:
>   From git.internal.company.com:team/testrepo
>    * branch            master     -> FETCH_HEAD
>   Already up-to-date.
>
> If I instead do a "git pull" I get:
>   From git.internal.company.com:team/testrepo
>    * [new tag]         Testing11  -> Testing11
>   Already up-to-date.
>
> What I think should happen:
> The "git pull origin master" should retrieve the tag.
>
> This is with 2.16.2.windows.1, but also occurred on my previously installed version (2.12.2.windows.2)
>
> My understanding is that "git pull" and "git pull $repo $currentbranch" should function identically.
>
> Is this a bug, or am I misunderstanding the manual page?

Looks like a misunderstanding, to me. Perhaps I can help clarify.

"git pull" without arguments fetches from the "origin" repository
using the configured "fetch" refspecs, which typically looks something
like "fetch = +refs/heads/*:refs/remotes/origin/*". It _doesn't_
actually fetch all tags, but any tag referencing any object/commit
included in the branches is brought along for the ride. This is
documented on "git pull":

--no-tags

    By default, tags that point at objects that are downloaded from
the remote repository are fetched and stored locally. This option
disables this automatic tag following. The default behavior for a
remote may be specified with the remote.<name>.tagOpt setting. See
git-config(1).

By comparison, on your "git pull $repo $currentBranch", what you're
calling "$currentBranch" is actually "[<refspec>...]" from the
documentation. In other words, by passing "master", you've told "git
pull" to fetch _nothing but "master"_, ignoring the configured
refspec(s). Additionally, since you haven't told "git pull" where to
_put_ "master" once it's fetched, it writes it to "FETCH_HEAD". If you
have a tracking branch setup, "git pull origin master" will also
update the tracking branch. For example, the same command for me
produces:

$ git pull origin master
From ...
 * branch                    master     -> FETCH_HEAD
   aca5eb0fef5..ad484477508  master     -> origin/master

As you can see, both FETCH_HEAD and origin/master were updated, since
my local "master" tracks "origin"'s "master":

[branch "master"]
        remote = origin
        merge = refs/heads/master

Hope this helps!
Bryan
