Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDD9C282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 13:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA6D2077C
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 13:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="H6pplT/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgAJNvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:51:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:57577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727458AbgAJNvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 08:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578664289;
        bh=HF/7L592zPnPUE/Nrudo4rWDX6TcJfzFCBYwrxnMcJw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H6pplT/93uJmGuszaB0SdNIo/Kia00OGmvM7NwNWCtHVqwWlVgYo2GjzlvdGM8b+z
         1SahLD+iMk/lFUXHu8bZ8YXsx68VeYAiDUNdZmwFpiZcSEJV5H3VkiiEZ3p7pGw+6V
         iiqwRT4Q+rJJ8U1hXwan3z0kIjuhMVEjcZHFfF9E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVNAr-1jILR93GTv-00SRQ6; Fri, 10
 Jan 2020 14:51:28 +0100
Date:   Fri, 10 Jan 2020 14:51:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Ryan Zoeller via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Ryan Zoeller <rtzoeller@rtzoeller.com>
Subject: Re: [PATCH] userdiff: add Julia to supported userdiff languages
In-Reply-To: <pull.521.git.1578625810098.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001101449410.46@tvgsbejvaqbjf.bet>
References: <pull.521.git.1578625810098.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Xtn++JShM1en5o4+DE441MsyFI/q7bZtHRQyI5RFVX/pzRSS525
 0VjFjEze/mcGglnaYd6zv3q/atK4GZuahTP3d9Ik+ZNpqKCpBz9pnK804CxL7Jxz53zYLHQ
 1VkrSXjHd9gCpHXyKVhOl8tyQgEWVD4YhV9StsyEz1ERa1eonZIVTD8QRM3IG+j9s7x3Js5
 OmVDiCjgj0bx/bC0St3aA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Er+cme0DCDw=:K2O/NhlHTop9qzUTQYSLGd
 XcotKKv2zzSpJEBwQT+wDJiphE9F+84oKSXPkFnMjQR8xhvXGPoRKUfE2sQLyVqNd805QxyAg
 ogfMHDH7FAUOIIG2SYpPi6O1uiMiZBudLfv+GDZ1MuEWahOB0semI4LuqYsc4C1KWgZTOZvIS
 MhhwLynOxGXL0j+fU9pBopBi7DigSji/HMpPba+iurAARjB0h2/thUhmExvVjdd11QPqAUKZm
 QtVXm0E+9lfwXrmLdOqyZ0gE0L0y7hLr+9QWBs8Iqy1SWPLlqX0StjXaPJcJ1FV96pbfz0lA1
 tF8oob60YEyZsh7tet8DqSfcsVXgLi66+S5h5ZCrOwTC2oevm0A033LOTjUyG2Ds2zzydpDkj
 buBR8rVIhnfmP5V5yEUl9MG32JsRRmuc+BLPmns5GGSEycyUikH0j8q6GEEF9MewDPfZI8Xiy
 Q9L2rBx0YnSj6j7ph4DhgzpmkKH5HyI9lwKe2vK+eG+s2gcZwvmputVU+RpdxhP5lDGCWsf92
 KrRxA2AWjqCNngY35iiLCmS7aAefH1XG+1NDIlsrPEZwIZL7s5f6/tpCHZzrEGgskMJqfenIP
 Gw8bC/f8TaKHAfEO3nDPXkOyfkRgPj4HT4oOBOnRlMwWmcxhWIZ/TpFbtbx9nkGbWwXRu/Q5I
 q9XzdDwqO08uA7AV1WkrGM95JgkPFsEPFMcfzpNFcDWrHxnbg9QEMzTYHSBKQnF4+j+QfNMDf
 2+kjV4FSsR/eFOhV77PUw3OOaav4y2loHh5WQVsVPJACmis9ugj/5i9Jr8an333yy0HekLUle
 Zi5ctpxyH1YHoC4LxFKztVmmF3ZflzYCYOfL6hlIRQWFeDbTpwh7REQXollS0aiaOb0j6KVWJ
 4sS4FOBUvqxsnoTrAgRqinvRjPwvBUcZntrEyUDIulDxiUa6ojIQaatnYu580A147OqkKXaQr
 1Bin98e25nDBLinrFofj7KbLge4TwrfZyKaTHs0LPaWlmZlL6vO+CefRWBo1RnfMPQPjQYsuN
 3ulHon6w7IZEkRDDmVq+Mjq7OEtBy4vAyp1QDKG6J6bNrwZQEMg/5o/hdaY3OFN/tWuKHwaMv
 AxmR2gBv+BHcA4IKKLfWLbpZvWeYg/CWAahc/m2lAR5p8RB4hELSdGgZPvrVoOCkcbgDh8DC6
 MBpEI9rWly4uNgTfr0MBz+kfr4k4bulpmQu0ca1jPFTFickSOakQtQGle2hWml7y1kizYo7sY
 +Phn2I/snPolIeuiUvK1wuKlMVA6AYBnpdRnFvUNnQVWhuW23dxQ7okXTo7Y=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 10 Jan 2020, Ryan Zoeller via GitGitGadget wrote:

> Add xfuncname and word_regex patterns for Julia[1],
> which is a language used in numerical analysis and
> computational science.
>
> The default behavior for xfuncname did not allow
> functions to be indented, nor functions to have a
> macro applied, such as @inline or @generated.
>
> [1]: https://julialang.org
>
> Signed-off-by: Ryan Zoeller <rtzoeller@rtzoeller.com>
> ---
>     userdiff: add Julia to supported userdiff languages
>
>     Add xfuncname and word_regex patterns for Julia1 [https://julialang.=
org]
>     , which is a language used in numerical analysis and computational
>     science.
>
>     The default behavior for xfuncname did not allow functions to be
>     indented, nor functions to have a macro applied, such as @inline or
>     @generated.
>
>     Signed-off-by: Ryan Zoeller rtzoeller@rtzoeller.com
>     [rtzoeller@rtzoeller.com]

Sorry about that. In my recent work to fold in the cover letter into
single-patch contributions, it was mentioned that this could come back to
bite us: By default, GitHub uses the commit message of single-commit PRs
as PR description, and if contributors do not change that, it essentially
repeats the commit message.

Sadly, I won't be able to justify working even more on GitGitGadget this
week (it took a sizable chunk out of my time budget and I have to make up
for that first).

Ciao,
Johannes

>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-521%2F=
rtzoeller%2Fjulia_userdiff-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-521/rtzoe=
ller/julia_userdiff-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/521
>
>  Documentation/gitattributes.txt |  2 ++
>  t/t4018-diff-funcname.sh        |  1 +
>  t/t4018/julia-function          |  5 +++++
>  t/t4018/julia-indented-function |  8 ++++++++
>  t/t4018/julia-inline-function   |  5 +++++
>  t/t4018/julia-macro             |  5 +++++
>  t/t4018/julia-mutable-struct    |  5 +++++
>  t/t4018/julia-struct            |  5 +++++
>  userdiff.c                      | 15 +++++++++++++++
>  9 files changed, 51 insertions(+)
>  create mode 100644 t/t4018/julia-function
>  create mode 100644 t/t4018/julia-indented-function
>  create mode 100644 t/t4018/julia-inline-function
>  create mode 100644 t/t4018/julia-macro
>  create mode 100644 t/t4018/julia-mutable-struct
>  create mode 100644 t/t4018/julia-struct
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribut=
es.txt
> index 508fe713c4..d39dc727e3 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -824,6 +824,8 @@ patterns are available:
>
>  - `java` suitable for source code in the Java language.
>
> +- `julia` suitable for source code in the Julia language.
> +
>  - `matlab` suitable for source code in the MATLAB and Octave languages.
>
>  - `objc` suitable for source code in the Objective-C language.
> diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
> index c0f4839543..d4613eb7d2 100755
> --- a/t/t4018-diff-funcname.sh
> +++ b/t/t4018-diff-funcname.sh
> @@ -38,6 +38,7 @@ diffpatterns=3D"
>  	golang
>  	html
>  	java
> +	julia
>  	matlab
>  	objc
>  	pascal
> diff --git a/t/t4018/julia-function b/t/t4018/julia-function
> new file mode 100644
> index 0000000000..a2eab83c27
> --- /dev/null
> +++ b/t/t4018/julia-function
> @@ -0,0 +1,5 @@
> +function RIGHT()
> +    # A comment
> +    # Another comment
> +    return ChangeMe
> +end
> diff --git a/t/t4018/julia-indented-function b/t/t4018/julia-indented-fu=
nction
> new file mode 100644
> index 0000000000..2d48aabcdb
> --- /dev/null
> +++ b/t/t4018/julia-indented-function
> @@ -0,0 +1,8 @@
> +function outer_function()
> +    function RIGHT()
> +        for i =3D 1:10
> +            print(i)
> +        end
> +        # ChangeMe
> +    end
> +end
> diff --git a/t/t4018/julia-inline-function b/t/t4018/julia-inline-functi=
on
> new file mode 100644
> index 0000000000..5806f224fb
> --- /dev/null
> +++ b/t/t4018/julia-inline-function
> @@ -0,0 +1,5 @@
> +@inline function RIGHT()
> +    # Prints Hello, then something else.
> +    println("Hello")
> +    println("ChangeMe")
> +end
> diff --git a/t/t4018/julia-macro b/t/t4018/julia-macro
> new file mode 100644
> index 0000000000..1d18bc2750
> --- /dev/null
> +++ b/t/t4018/julia-macro
> @@ -0,0 +1,5 @@
> +macro RIGHT()
> +    # First comment
> +    # Second comment
> +    return :( println("ChangeMe") )
> +end
> diff --git a/t/t4018/julia-mutable-struct b/t/t4018/julia-mutable-struct
> new file mode 100644
> index 0000000000..db82017ba0
> --- /dev/null
> +++ b/t/t4018/julia-mutable-struct
> @@ -0,0 +1,5 @@
> +mutable struct RIGHT
> +    x
> +    y::Int
> +    ChangeMe
> +end
> diff --git a/t/t4018/julia-struct b/t/t4018/julia-struct
> new file mode 100644
> index 0000000000..d3d2bda8cb
> --- /dev/null
> +++ b/t/t4018/julia-struct
> @@ -0,0 +1,5 @@
> +struct RIGHT
> +    x
> +    y::Int
> +    ChangeMe
> +end
> diff --git a/userdiff.c b/userdiff.c
> index efbe05e5a5..b5e938b1c2 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -79,6 +79,21 @@ PATTERNS("java",
>  	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
>  	 "|[-+*/<>%&^|=3D!]=3D"
>  	 "|--|\\+\\+|<<=3D?|>>>?=3D?|&&|\\|\\|"),
> +PATTERNS("julia",
> +	 "^[ \t]*(((mutable[ \t]+)?struct|(@.+[ \t])?function|macro)[ \t].*)$"=
,
> +	 /* -- */
> +	 /* Binary literals */
> +	 "[-+]?0b[01]+"
> +	 /* Hexadecimal literals */
> +	 "|[-+]?0x[0-9a-fA-F]+"
> +	 /* Real and complex literals */
> +	 "|[-+0-9.e_(im)]+"
> +	 /* Should theoretically allow Unicode characters as part of
> +	  * a word, such as U+2211. However, Julia reserves most of the
> +	  * U+2200-U+22FF range (as well as others) as user-defined operators,
> +	  * therefore they are not handled in this regex. */
> +	 "|[a-zA-Z_][a-zA-Z0-9_!]*"
> +	 "|--|\\+\\+|<<=3D?|>>>=3D?|>>=3D?|\\\\\\\\=3D?|//=3D?|&&|\\|\\||::|->=
|[-+*/<>%^&|=3D!$]=3D?"),
>  PATTERNS("matlab",
>  	 /*
>  	  * Octave pattern is mostly the same as matlab, except that '%%%' and
>
> base-commit: 042ed3e048af08014487d19196984347e3be7d1c
> --
> gitgitgadget
>
