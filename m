Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 956201F406
	for <e@80x24.org>; Thu, 11 Jan 2018 11:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933626AbeAKLOR (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 06:14:17 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:37465 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932861AbeAKLOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 06:14:16 -0500
Received: by mail-pf0-f175.google.com with SMTP id p1so1407995pfh.4
        for <git@vger.kernel.org>; Thu, 11 Jan 2018 03:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/scoU1YFAeO9JWFtL2vB3I4idw78iNxyyhIRg0yWMWM=;
        b=skqk344wgLKrYYxHY6vSay5AnD5fQKZqVMzYdQHDLyx2UA3Se0p0j4d7bdB7BteY1W
         EXpBg+1pvoEJQNoG2hvQxYB0xEaNZzFQZW0L6vYgteHtfU8bez1kXsQ5fP61LoOeGTpD
         +HjNMdD1RZawPJU1PFtlKWucr4sL7qyBItnh31+lPgzplF7mkqH9ElKBg55jC3IVbtK9
         b0LzxusRUWACWCYDUjmbP6H5HhvoMLlyKSD7G/rD1q59RffQXWk3iRN3vufcdhd6HTWQ
         QPpC9SVjhgOeX3K4o+XK/pIWkb698Kk3sObSAvSQdtlqzuRYlrshBgaeCL6YGJMBA3wZ
         CIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/scoU1YFAeO9JWFtL2vB3I4idw78iNxyyhIRg0yWMWM=;
        b=FePLbTcWC8FDo2zQmNk8BTGecuXeTE6vZlxp/UmA0bHTzEtCj/XWDEmQS1KZvzii9J
         eVxwvdZIyfIQgLXJ0XBfVpGH32fw4NgOePGh8S1qM01EVPQGLU0NQ3bdEjqWkQwWANp2
         EJY0r333LIi57CzVKDi2WeFATxI/kOARM4Yo5UrtM6zMFcUd4y4lmBrJKBTPLrDHs4aG
         sPNwPmwpkVfQLztKHA2OyzCPLaaxJdaxP+NABdtLVGCLMW9j0rwy0bRY+AyYWHLql69h
         JY1fukJLtWdVA1HxB50NAqIo41jHC2RtXU6p1/Qbfd2llvc6vXwncTebQGK7VmST1XrD
         +JOA==
X-Gm-Message-State: AKGB3mLToUXHMqAcSDiXUDN78tyTjN6sqy7iPBs9EbGlrtaue1Ua/kWN
        EfxLuy6IftrRIFo5WtLAymbWre5lrvbfrYzMyA8=
X-Google-Smtp-Source: ACJfBovwaMg754gvC8HXGm8WoFMnT2uy6DbdnD8wFLY96sjQdUA1DkDUxbZRlhU4+ua5pdFywj8yfwf+SnMWSX6S5Ug=
X-Received: by 10.84.252.8 with SMTP id x8mr22248111pll.190.1515669256200;
 Thu, 11 Jan 2018 03:14:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.183.106 with HTTP; Thu, 11 Jan 2018 03:13:45 -0800 (PST)
In-Reply-To: <20180111100734.GA17274@sigill.intra.peff.net>
References: <20180110104835.22905-1-pclouds@gmail.com> <20180111100734.GA17274@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 11 Jan 2018 18:13:45 +0700
Message-ID: <CACsJy8Beq2gx8K8Hk7NMVj_1Cgn5v-tuN9eZtDRCuOxB_urcWw@mail.gmail.com>
Subject: Re: [PATCH] run-command.c: print env vars when GIT_TRACE is set
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 5:07 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jan 10, 2018 at 05:48:35PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> Occasionally submodule code could execute new commands with GIT_DIR set
>> to some submodule. GIT_TRACE prints just the command line which makes it
>> hard to tell that it's not really executed on this repository.
>>
>> Print env variables in this case. Note that the code deliberately ignore
>> variables unsetting because there are so many of them (to keep git
>> environment clean for the next process) and really hard to read.
>
> I like this, and I'm pretty sure it would have helped me debug at least
> once in the past. I did notice one funny thing, though I think it was
> largely there before.
>
> The output for a single command is pretty shell-like due to the quoting:
>
>   $ GIT_TRACE=3D1 ./git upload-pack . >/dev/null
>   [...]run_command: 'git-upload-pack' '.'
>
> You could copy and paste that to a shell if you wanted.  And with
> environment variables, that remains so:
>
>   $ GIT_TRACE=3D1 ./git ls-remote https://github.com/git/git >/dev/null
>   [...]run_command: 'GIT_DIR=3D.git' 'git-remote-https' 'https://[...]'
>
> But if we're actually running a command via the shell, it all gets
> quoted as one argument:
>
>   $ GIT_TRACE=3D1 GIT_PAGER=3D'foo | bar' ./git log
>   [...]run_command: 'LV=3D-c' 'foo | bar'
>
> which is kind of weird, as that's not something that can be run in a
> shell. This isn't introduced by your patch at all, but I noticed it more
> because of the shell-like environment variable output.

I think you just found an argument to change my "meh" with regards to
quoting to "need to fix" because I also often copy/paste these
commands. I thought about it and assumed shells would still recognize
'name=3Dvalue' assignments without actually testing it.

> We actually used to print a separate:
>
>   exec: /bin/sh -c 'foo | bar'
>
> line when we invoked a shell, which would arguably be the right place to
> show the env variables for such a case. But that went away with
> 3967e25be1 (run-command: prepare command before forking, 2017-04-19).
>
> I think it might be helpful if we added back in "/bin/sh -c" to the
> run_command line when "use_shell" is in effect (and when we're not doing
> our "skip the shell" trickery).  But that's totally orthogonal to your
> patch.
>
> And anyway, it's just tracing output, so I don't think it's incredibly
> important either way. It was just something I noticed while looking at
> your patch's output.

Noted. I might do it if it's not super complex.
--=20
Duy
