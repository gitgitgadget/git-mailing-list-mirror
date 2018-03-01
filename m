Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418011F404
	for <e@80x24.org>; Thu,  1 Mar 2018 18:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033982AbeCASbJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 13:31:09 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:37451 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033892AbeCASbH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 13:31:07 -0500
Received: by mail-qk0-f171.google.com with SMTP id y137so8797167qka.4
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 10:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TxrtQi3LDIbdMopn7x/Yp7g47jpka7N40VU/fZuuQ0I=;
        b=lSsbd/bXwCnxzKYftqprWyghs49xN/zU+WyLGOQDMPwQnnuZglKT3j9iVhHatMD02D
         OvC8GLbCTSkGsfXLafEB+FiQo1KoxkxKbgGDayiCgHm4mikFO8eMZNWx4xKFHIKgKBzm
         wX+RAfAozAmC+zY094wJQX6jkvDO/HDiJiU5yO3w5kEdqmchyNryhZiY9dMSRzEbBBHR
         HF5nzCbe3PBUSUYNaPML/buTXSsay7xojh9AWBLZVjskLzP1vp14t7ruPCZESX7+0EHm
         gRDrEP6pIqMnB1J+KnJzhGanCpK+iAN3KmInSqOr3AY5A8vsLIA2ZP9hkrv2i0vQLKeu
         jw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TxrtQi3LDIbdMopn7x/Yp7g47jpka7N40VU/fZuuQ0I=;
        b=i7v4mAcM8LzgbFULCu7K3niSbkbQPG7wO+KTAYAUYANuiM5IvM+gAmattXiO/m96F9
         JCModS+1FtA59eqwW5xyD6TuycA+WjUF69nczHiOZv7zhLKFM/HCtIaEwBcqwdIgofyd
         2WmKqelBYWufxHqTrE7JB5n3fXvP+znSwSE6E6NQaPfHgA2NfwLS0JdZPiEjsGF9iVvx
         82CP5vrSLWDP+B1tG0+PCuXFRFPF1KrBBh0+JmBQGAZLDiy1Ypr6Me9BiRFE16YbOlsp
         FCBObX470cuuWYAcXJ7AwYp2E6ixpN2IfY3FTbeF8xwm9JgSyAczQDr25v58RwSpabHV
         o2dg==
X-Gm-Message-State: AElRT7GV+nlecEPTccc3EQYrDVFXXPib0rP/4FwBqKMoXTR7gk0S1t0z
        5OFqQv7pjCvMEZvQf+00RSj2vEmDXihDX7Psf8o=
X-Google-Smtp-Source: AG47ELvKKUWFe9Wt9YGdjT4M5tm04MRLXLag7ILEcYBmZErAfOOFDVvif1u0Uqmw8evwQJIomkPKnYMIm9koT5P3qzo=
X-Received: by 10.55.132.67 with SMTP id g64mr4349739qkd.28.1519929066504;
 Thu, 01 Mar 2018 10:31:06 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Thu, 1 Mar 2018 10:31:06 -0800 (PST)
In-Reply-To: <20180301143904.28652-1-birgersp@gmail.com>
References: <CAGr--=LxMtz5RRP4742u3VsrADRsWARE2SitCSOWATySOn2LcQ@mail.gmail.com>
 <20180301143904.28652-1-birgersp@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 1 Mar 2018 13:31:06 -0500
X-Google-Sender-Auth: wYh0o5sKTAYhItXeYdVzhrhscRo
Message-ID: <CAPig+cRt+u4yEnFLM3kUB_J54Xvt6V9ceb6rwqfHC3kb=fttGg@mail.gmail.com>
Subject: Re: [PATCH] git-gui: bind CTRL/CMD+numpad ENTER to do_commit
To:     Birger Skogeng Pedersen <birgersp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 1, 2018 at 9:39 AM, Birger Skogeng Pedersen
<birgersp@gmail.com> wrote:
> ---

Please sign-off on your patch. See Documentation/SubmittingPatches.

Also, it would be helpful to write at least a short commit message
justifying the change. The reason you gave in your lead-in email[1]
might be sufficient:

    In git-gui, we can hit CTRL/CMD+ENTER to create a commit. However,
    using the numpad ENTER does not invoke the same command.

(assuming people don't argue that numpad ENTER should be saved for
some other function).

Thanks.

[1]: https://public-inbox.org/git/CAGr--=LxMtz5RRP4742u3VsrADRsWARE2SitCSOWATySOn2LcQ@mail.gmail.com/

> diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
> index 91c00e648..6de74ce63 100755
> --- a/git-gui/git-gui.sh
> +++ b/git-gui/git-gui.sh
> @@ -3867,6 +3867,7 @@ bind .   <$M1B-Key-equal> {show_more_context;break}
>  bind .   <$M1B-Key-plus> {show_more_context;break}
>  bind .   <$M1B-Key-KP_Add> {show_more_context;break}
>  bind .   <$M1B-Key-Return> do_commit
> +bind .   <$M1B-Key-KP_Enter> do_commit
>  foreach i [list $ui_index $ui_workdir] {
>         bind $i <Button-1>       { toggle_or_diff click %W %x %y; break }
>         bind $i <$M1B-Button-1>  { add_one_to_selection %W %x %y; break }
