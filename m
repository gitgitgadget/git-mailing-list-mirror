Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B6CC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 14:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiG2O34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 10:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236342AbiG2O3z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 10:29:55 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002241EEC1
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 07:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659104989;
        bh=GXyoFo0P6keVjAf7+3MdVT20q372CcE2qHGtgEWf9g0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FApaYjMhplRJvR6sqbFa4WvrvDRbUCCRbHo61JybyYtzu1ujaeO1VNK/eiQCWq4SV
         gRAyGsXhqG5WcHTE212QmTIsQaqf2lGavT18orH/nXyCTEEALdRHB/+cwZGOQGrpP6
         4z7pZGijKok9ffEthtIqAZgI9BAsg4cosJDJXxYs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.244.62] ([89.1.214.237]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXXuH-1nxoJf3aGd-00Z1Lc; Fri, 29
 Jul 2022 16:29:48 +0200
Date:   Fri, 29 Jul 2022 16:29:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] mingw: include the Python parts in the build
In-Reply-To: <xmqqczdpcfhx.fsf@gitster.g>
Message-ID: <0s3o2pr2-o0q3-q394-83n3-n117355o8o29@tzk.qr>
References: <pull.1306.git.1659016906707.gitgitgadget@gmail.com> <xmqqczdpcfhx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vpld/dRmsHRizXCFtN6twvWqyxq/Gd4V8vPF1Dao8IYT57HhF8O
 ZjvhnPAd6nknwwHhgzFRkhYHI5JIEhjGe1fC4BStm/OFq0vq6E3DHqzDS3YNTicdr3oSErV
 h7165S7iClYcYTE0FZj/118Gse0Szc5+6j49sxkjVsaIcZ0HzRfF3fM41xb7lfkOIun0+x4
 GL0+z9M0pznIuTjh27Zgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JmJZfd/3hnE=:IGd2zUEtanYloL97nYQOsM
 2NKwEN7Q4BBLJmTRJf4D84+x69QlS2Oa4kDnHqFyncl9WJFtATxFoXyRtu9IWADC8HJEh5AQK
 Rfvd1SnVo5rVlqi3p+yINICDx4s7B90a8wYtn7HRI9WrkxZ2T52l7g1UPRZx2ovLyJgpQVWUi
 CTy3x/h1Y+6jGkX6o0aqdQA1gJvIzWAS/dyIrd8OaoHVEnLRf5pcclIvyY3vGdFgNyVb+ysHD
 9UseFJ6aj0PskYxcNw3p+JdjYoc8jBAYz5MmL9655/qQgG7ZVugeU9Lq7JTTgitQwQ56riv/S
 aKTWOKWPMOGZ+OG4Ws6qS1QeBKzIAP3eyAZQxG6vyXCG4V+WWn7KQzkoTXmdnA9eTSgA7lPEF
 Z5VNw2DvMJ/5O9H0zLRr5uqR6gKPfAYjHOtdDyzcerR7+8hbOB+fA++BgDwTpeugmNXGCYHrb
 AlBJ6oEo4QUwK8NENS7qXNmNjcPKq/WENCN3m4eivSS6tDCUM2/VFdstkeg59iCPluTC2/1Bt
 0JIbxcRFN6RNUATfCYKAeDqjK0G/1f2topMjoRpM10U/WrDzECDBp497eNY1gvv532T61Jn9z
 EwVh2ScedBoWzdJa8Bj14YAuRQGjVjqmbCU2hpzuH69WzfHZ1SeoM0OT+Q7UVPDoJfWAwEAwf
 xr9Lw8aiRU7RTMWQQIuc1/P8+d2X2q6LM9fHefgy7DTZeRj8Q+ft96dbzN80au0uZZK7KwVqX
 n/mSB8cqGwuyisHAnZW5Azt/nIFfeS+db6Mny8EISseu2Q9oHNs7vOiQ+qZwBYY2xuzoj5i6a
 kj7/zsJ4YuFm5e0IHzMw1LFwLOkTV6X2bngH2yI9V4wEanlUJnMeT/GqiMs1TJ3tz5wH/JQCB
 gcGQyTuKfq5FEDrDXEFLuy9QpZ5rp1D6ZQBc6dfu3A1bEfhP7/ntf9H1GuYGVgCNKTbjjbASt
 73zLeuK/HS/8lK/Rtizhvk3uCkBoNxvJur8ciCehHV1vG4V7FTxGURLQimoPJyycq0S+Qcmix
 jh+baheNzjhlJSAYeRuD737MXjjWW4AAV77lxWAWdqgAf/yvjNRju9hR++C4JUrxHKE0OGOzX
 zaIDqb0LCQeO/IY7zpEJnKMgy+yvyDtOrXi7psyeM8vXV4yPME2p8SRcg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 28 Jul 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > While Git for Windows does not _ship_ Python (in order to save on
> > bandwidth), MSYS2 provides very fine Python interpreters that users ca=
n
> > easily take advantage of, by using Git for Windows within its SDK.
>
> It may be an accurate description of the world and there may not be
> anything incorrect in the above statement, but it took quite an
> effort to try matching that statement to what the patch does.
>
> I think
>
>     Builds on $uname_S=3D=3DMINGW by default sets NO_PYTHON=3DYesPlease
>     and it benefits Git for Windows by allowing to omit Python.
>     However, when "Git for Windows" is used within MSYS2's SDK, we
>     can allow users to take advantage of Python interpreter that
>     comes with it.  Override NO_PYTHON when the presence of
>     ../THIS_IS_MSYSGIT indicates that we are in that situation.
>
> is how the logic in this patch can be explained, but I have to
> wonder if a more natural and easier-to-understand solution is to
> move NO_PYTHON=3DYesPlease into "if we do not have ../THIS_IS_MSYSGIT,
> do these things" ifneq() block, like the attached patch.

The outline is:

ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
	[...]
else
        ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
                # MSys2
		[...]
	else
		[...]
	endif
endif

By moving it into the `THIS_IS_MSYSGIT` part, you changed the behavior of
the MSys part (which is in the `else` block of that `uname_R`
conditional).

Now, I vaguely remember that j6t said that they switched to MSYS2 some
time ago, but all I found on the Git mailing list was
https://lore.kernel.org/git/6c2bbca7-7a8f-d3d8-04b6-31494a3e1b43@kdbg.org/
which says that in 2017, MSys1 was still used by the person who apart from
myself did the most crucial work to support Git on Windows (and that
counts a lot in my book, so in this instance I am willing to bear a bit
more maintenance burden than I otherwise would for a single person, even
if the Windows-specific part of `config.mak.uname` is quite messy, I
admit).

Hannes, do you still build with MSys1?

> I didn't touch it but NO_GETTEXT does not appear in the common
> section above "do we have ../THIS_IS_MSYSGIT?", and gets set
> after "we do not have ../THIS_IS_MSYSGIT", so I do not think
> we need "NO_GETTEXT =3D " that clears it in the "we do have
> ../THIS_IS_MSYSGIT" part.

True. This is my mistake: in f9206ce2681 (mingw: let's use gettext with
MSYS2, 2016-01-26), I should have looked more closely and realized that
`NO_GETTEXT` is not defined in the MSYS2-specific part of
`config.mak.uname`, and hence the line should not have changed to
`NO_GETTEXT =3D` but it should have been removed instead.

I'll revamp the patch and send another iteration (but please do not expect
any further work from me this coming week, I plan on staying off of work).

Ciao,
Dscho

> We may want to see if there are other things that needs cleaning up
> around this area.
>
>  config.mak.uname | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git i/config.mak.uname w/config.mak.uname
> index ce83cad47a..999a7ae270 100644
> --- i/config.mak.uname
> +++ w/config.mak.uname
> @@ -656,7 +656,6 @@ ifeq ($(uname_S),MINGW)
>  	UNRELIABLE_FSTAT =3D UnfortunatelyYes
>  	OBJECT_CREATION_USES_RENAMES =3D UnfortunatelyNeedsTo
>  	NO_REGEX =3D YesPlease
> -	NO_PYTHON =3D YesPlease
>  	ETAGS_TARGET =3D ETAGS
>  	NO_POSIX_GOODIES =3D UnfortunatelyYes
>  	DEFAULT_HELP_FORMAT =3D html
> @@ -686,6 +685,7 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
>  	INTERNAL_QSORT =3D YesPlease
>  	HAVE_LIBCHARSET_H =3D YesPlease
>  	NO_GETTEXT =3D YesPlease
> +	NO_PYTHON =3D YesPlease
>  	COMPAT_CFLAGS +=3D -D__USE_MINGW_ACCESS
>  else
>  	ifneq ($(shell expr "$(uname_R)" : '1\.'),2)
>
