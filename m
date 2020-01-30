Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CB2C33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 11:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94ED206D3
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 11:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kRvP6ZRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbgA3LaW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:30:22 -0500
Received: from mout.gmx.net ([212.227.15.18]:35273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgA3LaW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 06:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580383817;
        bh=J43wk+W++9ZM3lTNKLASEnpAG1wWn21U8kBx4VYpJZc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kRvP6ZRDcety0Br/c8B+YJeD8us7NSFK7mi1b5H2ZTFxjHhDNvz5oYJ+zm61xzW5M
         l9QwFrvJ2nh0dNv1s4ubBZkPeRhkVNi1uKBybi/76ZXGPz4XdzlgEcxlDGGdFb74vc
         wWCBQhc6kTUxs1/Ll5cC0VwIHHVGhSB+K/WmwkWQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWASe-1j3BUh1yEk-00Xdyr; Thu, 30
 Jan 2020 12:30:17 +0100
Date:   Thu, 30 Jan 2020 12:30:17 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     abhishek kumar <abhishekkumar8222@gmail.com>
cc:     shouryashukla.oo@gmail.com, git@vger.kernel.org, gitster@pobox.com
Subject: Re: [GSoC] Doubts in an issue
In-Reply-To: <CAHk66fs+FX_W+MwOCOF1_zw_vPz73D+0HbTrb7sXTHzgnWhzQQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001301210410.46@tvgsbejvaqbjf.bet>
References: <CAHk66fs+FX_W+MwOCOF1_zw_vPz73D+0HbTrb7sXTHzgnWhzQQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9ygQ7W/KXnHCel31pLESsMlE4yPCNlw7W6ZPOWFuMr6x93yFLG4
 RTYYdnYjQJWNM6Qk8q7hllOCL/8EVfMqNFp0wpcY3C8VQv0IZiZdjijmyyofh5oJ8RLOM36
 DMwDd0TH5RQBramRa97IbfDm8viqA1Ko2m19GdTLxLxL6ONC71LX3tIvpVxSHPN3jJwQZda
 3svzIeh5BCGvhzJ4pIjmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FBIFrXdU5hc=:3eAJ9BzmYyWZtXyQ+AJcG0
 7/dgQk2aeExppjDrOFgJ7CTQr86pCyloFSPqPP3JMqpo/Oz+Hpj/50VfGyMfFHG/dOpEtF65w
 sTX2yIyHQzpXf9LeoB+T96gi3r+RmFc9GPP4ogXOdFocy6JlrfT1ekkFhv2X3vMaHtSPJGIrO
 XHeI4rLDC6qJrPvWOsbeu2N76uyIGG/Q/pKzNy42vJsIuwznGC5p3u+oT+EqiJIYhMKNpM4IE
 XuCobQOucUeVFMngwB1K5GPGN4kG4BUow2nqBqtfiJu1ZMJfp4d23IMYzs0yMhdxzxvdiI2Xs
 h48mKfayv0xF3RJV2eq0DOgSO9T/uF1PhtFbeZ2615JHRXngkD59h0eTVGZyzUrs+LvmJ/DLx
 j2r73oga+0OLWECH5DcEBsLQvHfMkOrqdueYcSnqQ5Wr4CMtrDFadg6id4WlUx7bOc9/vQYx+
 B97g0e4IvuMt5i3T50wfayvUGFOoRSxLXxwNOxYk/idpBqBMgzvba7tnDvegTTdY1oDSSwgOM
 RdY7wN68SokKtqdRcw5j4/7yE6M998uyaBT5g9TZzSQ+Ndx2sSHOqniH9q9MuV0f3PyA5SRwY
 8NXyeZybofg4GaECX0ok7tvVrVzV08W813L9T5p2P+a+Xk+k8p2koKXsNj74t/7CLVE4zoBhW
 c/L87RnXRGKotHIOcDPupKRWYEkUjSTSWvzkwnVjz080XnfuRhEWa/IqAedPV82jjUgAcMVo/
 baHXWSYeA0lK0+KNFa6yy/oNpyq4LLTJfgfPx/WA+4PLKab57n9KmKOQs4OOjNt/mcxST1QvH
 XXWYM++W152F96Bu/cjiZ/a0g9yxOk3JLBZfoxLjVVC3ABUPCikqf0i8rCyW8T64P7NTAZJtv
 MT3YUmqAC6KMOiS/c5yW0VYtZBh0U75viN7tO+uBdguDA7a3V7TB7aosIBpfwYjyHaJP4SWi6
 45t3rOq645aCI0imnIJSnfZ7xDdcNSNnIyIpb7TNrsFe6a17Cc7H8gYte/RDAiyh3xD/DHByS
 mAr1cMrhKMph2xD72ywFjkXcWXSXOAewEgJEW+hpIcZCKxP5xYUcmqAULWKcikMZpG5ot9039
 T4rYnwWL2yLneoylILXijef/4TCmLGNpyh6X+X++7X9eIO2A7nfmqEvl3l35LnhZCiHkiVs9F
 nKrYRLrLnvQ7jIm0X4rq1sqOFUYOq6ll1oEyGWIistq7ilovMQik7JFfUp1rtKAQXo88TKmHc
 qcU8ZHHMbQ+GzMq9X
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 28 Jan 2020, abhishek kumar wrote:

> Greetings Shourya

Thanks for jumping in!

> I am not exactly Johannes (just another GSoC applicant) but here's what
> I understood from the issue and your thread:
>
> > And what exactly do we mean by "built-ins" here(does it refer to the
> > "dashed" commands)?
>
> "Built-in" refers to commands implemented in C [1][2]. The more common
> use of "built-in" which is a command that the shell (bash, sh, ksh)
> carries out itself [3]. The name draws out the similarity between shell
> builtins and git builtins, both written in C and executable through the
> shell.

It is _slightly_ more complicated than that. There are Git commands that
are implemented in C and that are _not_ built-ins, for example `git
fast-import` or `git remote-https`. The reasons are sometimes historical,
sometimes not so (for example, we keep `remote-https` separate to avoid
the startup cost of linking libcurl for _every_ `git` invocation).

But yes, the built-in commands are the ones covered by the `git`
executable, i.e. `git` does not have to spawn another executable or script
to perform the command.

> Therefore, "hardlink built-in to the corresponding dashed forms" is to
> create a hard link with the dashed form name to the C program.

Right. For historical context, the "dashed form" was originally the only
form: commands like `git show` were implemented in scripts/executables
whose name was `git-show`. Eventually the number of such
scripts/executables got too ridiculous to leave in the `PATH`, so they
were squirreled away into the `<prefix>/libexec/git-core/` directory. So
if your `git` executable lives in `/usr/local/bin/git`, those
scripts/executables would live in `/usr/local/libexec/git-core/`.

At some point, we started to consolidate most of the commands that were
_already_ implemented in C into the set of built-ins. Meaning that the
`git` executable would first figure out under which name it was called,
and then perform the appropriate function.

This allowed us to hard-link `git` to, say, `git-show` and not waste disk
space.

At some point we had so many built-ins that the "dashed form" was
deprecated. It _already_ only worked in scripted sub-commands (you can
implement your own Git subcommand by implemeting a script whose name
starts with `git-` and then putting it into the `PATH`, for example
`git-cinnabar` would be picked up by `git cinnabar` and would
automatically append the `libexec/git-core/` directory to the `PATH`
before running that script) unless you added the libexec directory to your
`PATH` explicitly.

=46rom that point on, we encouraged power users who automate their workflo=
w
via shell scripts to use `git rev-list` instead of `git-rev-list` in their
scripts.

This has been going on for _quite_ a while, so at this point it should be
safe to stop hard-linking those built-ins. It should be enough that the
`git` executable knows how to run the program, there does not really need
to be a hardlink in `libexec/git-core/`.

> > where is the <<libexec/git-core/>> directory?
>
> As the makefile suggests, the programs and scripts are installed at
> `gitexecdir`. I couldn't find it but instead found `GIT_EXEC_PATH`
> which point to pretty much the same thing. You can find it by `git
> --exec_path` [4].
>
> > Now, whenever we call scripts whose "dashed" version exists, it will
> > sort of link the "dashed" version as well for I guess historical
> > reasons? ;)
>
> No. Creating hard links is done during the build process. But calling
> `git-<script-name>` through `git <script-name>` makes `git` prepend
> `libexec/gitcore` which is necessary to find the hard link. So, you
> are half-right :).

To add to this, I already had provided a head-start in
https://github.com/gitgitgadget/git/pull/411...

Shourya, if you want to complete it, be my guest. I left a comment what
still needs to be done. If in doubt, just ping me in the ticket (or if I
am slow, ask for help on this here mailing list).

Ciao,
Johannes

> Regards
> Abhishek
>
> [1]: https://github.com/msysgit/msysgit/wiki/Why-Is--libexec--so-huge%3F
> [2]: https://github.com/git/git/blob/master/builtin.h
> [3]: https://unix.stackexchange.com/a/11465
> [4]: https://git-scm.com/book/en/v2/Git-Internals-Environment-Variables
>
