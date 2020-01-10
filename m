Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_SBL,
	URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A124EC282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 18:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734432080D
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 18:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rtzoeller.com header.i=@rtzoeller.com header.b="pLHf+Vxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgAJSPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 13:15:38 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:13061 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgAJSPi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 13:15:38 -0500
Date:   Fri, 10 Jan 2020 18:15:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rtzoeller.com;
        s=protonmail; t=1578680134;
        bh=7TX8mELXmt0zoYkBrdYPUezE60mZfSCgfdA+WO6xvGg=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=pLHf+VxgD/gx6IFjUb10cdPzDroi8c3eVde6TXKlnuj//qQw4Vh4kal+pjNDAVx3Z
         /aWiLcu8Mb6gZHuUITpZJiUZIq2+ZdQmjR9scKoEciZO1g5ypHtgtG0LZqI8E3kNK6
         tnozPfPCpD6cdJOshFMGn435ZHTypStl/YmoRwIY=
To:     Johannes Sixt <j6t@kdbg.org>
From:   Ryan Zoeller <rtzoeller@rtzoeller.com>
Cc:     Ryan Zoeller via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Reply-To: Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: Re: [PATCH] userdiff: add Julia to supported userdiff languages
Message-ID: <YqXJB_En1hjDpzUmawtrEYBztOGh_1uSmwxsQyQ646RtwGnYppq-xg26rwM0x5pu6E8PMVq22HwfSSFXN9aaD9BowSUH1YfztHRUomhOe6E=@rtzoeller.com>
In-Reply-To: <49decf8e-87a9-120f-4c2b-cafc5aa1d466@kdbg.org>
References: <pull.521.git.1578625810098.gitgitgadget@gmail.com>
 <49decf8e-87a9-120f-4c2b-cafc5aa1d466@kdbg.org>
Feedback-ID: 5lXL4isi_bB7akFXEJdPfZpYbYvbql9sUm7DncVynCuPL4cE1Rg6bOqeL_KEatLB2bvICXFl96SiwTflhcrixQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, January 10, 2020 11:43 AM, Johannes Sixt <j6t@kdbg.org> wrote:

> Am 10.01.20 um 04:10 schrieb Ryan Zoeller via GitGitGadget:
>
> > Add xfuncname and word_regex patterns for Julia1,
> > which is a language used in numerical analysis and
> > computational science.
> > The default behavior for xfuncname did not allow
> > functions to be indented, nor functions to have a
> > macro applied, such as @inline or @generated.
> >
> > Signed-off-by: Ryan Zoeller rtzoeller@rtzoeller.com
> >
> > ----------------------------------------------------
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-521%2=
Frtzoeller%2Fjulia_userdiff-v1
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-521/rtzo=
eller/julia_userdiff-v1
> > Pull-Request: https://github.com/gitgitgadget/git/pull/521
> > Documentation/gitattributes.txt | 2 ++
> > t/t4018-diff-funcname.sh | 1 +
> > t/t4018/julia-function | 5 +++++
> > t/t4018/julia-indented-function | 8 ++++++++
> > t/t4018/julia-inline-function | 5 +++++
> > t/t4018/julia-macro | 5 +++++
> > t/t4018/julia-mutable-struct | 5 +++++
> > t/t4018/julia-struct | 5 +++++
> > userdiff.c | 15 +++++++++++++++
> > 9 files changed, 51 insertions(+)
> > create mode 100644 t/t4018/julia-function
> > create mode 100644 t/t4018/julia-indented-function
> > create mode 100644 t/t4018/julia-inline-function
> > create mode 100644 t/t4018/julia-macro
> > create mode 100644 t/t4018/julia-mutable-struct
> > create mode 100644 t/t4018/julia-struct
>
> The tests all look good.
>
> > diff --git a/userdiff.c b/userdiff.c
> > index efbe05e5a5..b5e938b1c2 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -79,6 +79,21 @@ PATTERNS("java",
> > "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
> > "|[-+*/<>%&^|=3D!]=3D"
> > "|--|\\+\\+|<<=3D?|>>>?=3D?|&&|\\|\\|"),
> > +PATTERNS("julia",
> >
> > -   "^[ \t](((mutable[ \t]+)?struct|(@.+[ \t])?function|macro)[ \t].)$"=
,
>
> Looks good to me.
>
> > -   /* -- */
> > -   /* Binary literals */
> > -   "[-+]?0b[01]+"
> > -   /* Hexadecimal literals */
> > -   "|[-+]?0x[0-9a-fA-F]+"
>
> These two could be merged into
>
> /* Binary and hexadecimal literals */
> "|0[bx][0-9a-fA-F]+"

I was trying to avoid `0b` being followed by hex characters from being reco=
gnized, e.g. 0bFF. This is admittedly not really a concern, so I'm fine mak=
ing this change to simplify the regular expression.

>
> Note that I did not insert [-+]? at the front. Even though most if not
> all patterns allow a sign, they are usually wrong to do so, because they
> misclassify a change from 'a+1' to 'a+2' as 'a[-+1-]{++2+}' instead of
> the correct 'a+[-1-]{+2+}'.

I'm fine dropping the leading `[-+]?`.

>
> > -   /* Real and complex literals */
> > -   "|[-+0-9.e_(im)]+"
>
> I am curious: is '(1+2i)' a single literal -- including the parentheses?
> The expression would also mistake the character sequence '-1)+(2+' as a
> single word; is it intended?

This part of the regular expression has a pretty major mistake due to me mi=
sunderstanding how the parentheses were being interpreted. It should be som=
ething along the lines of `([-+0-9.e_]|im)+`.

Julia uses `im` as the designation for an imaginary value; this regex was i=
ntended to admit e.g. 1+2im, in addition other numeric values such as 1_000=
_000 and 1e10.

>
> > -   /* Should theoretically allow Unicode characters as part of
> > -   -   a word, such as U+2211. However, Julia reserves most of the
> > -   -   U+2200-U+22FF range (as well as others) as user-defined operato=
rs,
> > -   -   therefore they are not handled in this regex. */
> > -   "|[a-zA-Z_][a-zA-Z0-9_!]*"
> > -   "|--|\\+\\+|<<=3D?|>>>=3D?|>>=3D?|\\\\\\\\=3D?|//=3D?|&&|\\|\\||::|=
->|[-+*/<>%^&|=3D!$]=3D?"),
>
> The last sub-expression permits single-character operators in addition
> to their forms with a '=3D' appended (computing assignment, I presume).
> You could remove the trailing ? because single non-whitespace characters
> are always a word of their own, even if they are not caught by the word
> regexp.

Agreed, I'll drop the trailing ?.

>
> > PATTERNS("matlab",
> > /*
> > * Octave pattern is mostly the same as matlab, except that '%%%' and
> > base-commit: 042ed3e048af08014487d19196984347e3be7d1c
>
> -- Hannes

Thanks for the feedback,
Ryan Zoeller

