Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92D451FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 21:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755601AbcHWV0s (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:26:48 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35425 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755627AbcHWV0q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:26:46 -0400
Received: by mail-it0-f43.google.com with SMTP id x131so173362182ite.0
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7zzSozWWfYmkkLPlL0gJmmgPB0XThfwuLXE2p/u7Flo=;
        b=IYI/frywCoQ1z9tgSyN2BUbSO9xcLyLoNJtmJk69HI26OQiqFeeohAreyh2QB89/fx
         L+xiPkC/IWMq0n7XqERSCH2VNfnId+omn/eCy0CZny4cbyCBla0RxUS63kzWr0t98Wuf
         D9bPUw1rXVWbTqAFD6CK5jvmzet8isI9Jrea2BOo3ICzgOsZZMh1TsjQysKUzO4PO+AO
         +GwfeOVYIybQfK7J43gUCbgSWWzZCxDBLQ+7K9cebhH1n806e6ynLZqb5zMGvhSSc5Ux
         c2SE4a/+YcNJPVX4j7GHN3rcF3MCyzyVbEYlyHlb7KsHv7lgwEpiqiCenmoStOLJitmf
         24QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7zzSozWWfYmkkLPlL0gJmmgPB0XThfwuLXE2p/u7Flo=;
        b=Rv9lwQAUJYUtQDKleWebUZHyNpJYtq8bUJmQH4eIK07PcSpdFlFGlt1JvRb8Ipsx27
         wWNS/ciq0Bypjn+7WZYCLnU8az6i0NUlAIp4OtZ/1ymU6jD/mZufpM20kfajikdvA5mQ
         sHOAEYBk4hRtggkC2T8jmRBsUcDrv93Q2CPo2yO7tIoMmma/e6ZYCCcY82BTSGSg4Lye
         8SyNVOApBSetbrxBRy6KJvKvCD0fM7+n30CxWUjQqafke/hIyWhq29nvb+N/NTQIO2Yl
         JAI9IkOsay6fuyjlF+F6eBTOmFEQp2Pm2PLjy+7WkSrA4vqQsHSX1YozxpQ4/Q2I/LJz
         JFyg==
X-Gm-Message-State: AEkoouteMy5Uw8Ok9JlQU3Rvn2H1RIjwm400tCtSPC+2KBYJ2lZSDkQlhaY/1xtNRvtaW4R9IcXMNV4xK2QF4QH9
X-Received: by 10.36.227.7 with SMTP id d7mr56567ith.97.1471987582736; Tue, 23
 Aug 2016 14:26:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 23 Aug 2016 14:26:22 -0700 (PDT)
In-Reply-To: <20160823203446.40abfd37@labs-064.localdomain>
References: <20160823203446.40abfd37@labs-064.localdomain>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 23 Aug 2016 14:26:22 -0700
Message-ID: <CAGZ79kbkyupBJfvyX3Hj_R5ZW36+3ufOnnLC-Dpic40nPJAxDA@mail.gmail.com>
Subject: Re: Getting "The following submodule paths contain changes that can
 not be found on any remote" when they are in the remote
To:     Leandro Lucarella <leandro.lucarella@sociomantic.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 11:34 AM, Leandro Lucarella
<leandro.lucarella@sociomantic.com> wrote:
> Hi, I'm getting very often, but not always, with many different
> projects using submodules, the message:
>
>   The following submodule paths contain changes that can
>   not be found on any remote:
>     <module>
>
>   Please try
>
>         git push --recurse-submodules=on-demand

Check if push.recurseSubmodules is set (in the project, globally,
in the home dir?)

    git config --list | grep push.recurseSubmodules

>
>   or cd to the path and use
>
>         git push
>
>   to push them to a remote.
>
>   fatal: Aborting.
>
> This even happens after doing a:
>
> git submodule deinit <module>
> rm -fr <module>
> rm -fr .git/modules/<module>
> git submodule update --init
>
> So I am getting the reference from the remote, but when pushing a new
> change (that doesn't touch the submodules) I keep getting this error.

So the submodule did not change, but you still get the error?
That sounds like a bug.

Can you provide a sample repository that demonstrates this bug?
Maybe there are 'dangling' submodule pointers in past commits
that trigger this problem?

>
> I tried to get more information about why this is happening but I
> couldn't. Googling didn't help either, so I'm resorting to ask here.

If you are sure it is bug and not your fault, you can overwrite
the push.recurseSubmodules setting locally in your repository
to be "no" or "on-demand", see the git config documentation[1].

[1] e.g. https://www.kernel.org/pub/software/scm/git/docs/git-config.html

>
> I would also like to report a tiny bug, when using push --quiet, I do
> get all the message above except for the <module> name, which is quite
> confusing.

This sounds like a second bug.

See https://github.com/git/git/blob/master/transport.c#L767

So there are a few issues:

* the printf in the loop should be an fprintf(stderr,...)  for consistency.
* die_with_unpushed_submodules that is called from transport_push
  doesn't respect the transport->verbose setting.

The second bug can be explained with these issues; the first one
could hint at a bug in find_unpushed_submodules in submodule.c

Thanks for reporting a bug!
Stefan
