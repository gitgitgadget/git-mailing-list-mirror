Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D308BC433B4
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8DBD611CD
	for <git@archiver.kernel.org>; Thu, 22 Apr 2021 15:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbhDVPvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 11:51:25 -0400
Received: from mout.web.de ([212.227.15.4]:51353 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230005AbhDVPvY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 11:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1619106648;
        bh=eSKDsQlZxpDuxHUNj8WNHGA1IEWLuA3/tyAtTcVP8Lk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=dvrPtM4GD6tSfM4I8q7NJNBFsi9wV8iHbgQN4xUCpQlcvxMT0HicdD/qiuUi0yeRV
         gJTZoZzQIRrxHyVtUx1D7natFuc77HkPBJK5wXJRAI5L93LHJiyN/BMVqsB0bRjkOC
         lAgrzuSAii4ALT3KU9KGGDc7kqwjXNYHshoLoJRg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MUir6-1m7miR3yZg-00YAeS; Thu, 22
 Apr 2021 17:50:48 +0200
Date:   Thu, 22 Apr 2021 17:50:47 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] add git-p4.fallbackEncoding config setting, to
 prevent git-p4 from crashing on non UTF-8 changeset descriptions
Message-ID: <20210422155047.3unltvv3mh5uq7wp@tb-raspi4>
References: <CAKu1iLWfaAaKH4Uui4wfa0STFEaXqqtc304b5V0ZNtmBg78J+w@mail.gmail.com>
 <20210422050504.441-1-tzadik.vanderhoof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210422050504.441-1-tzadik.vanderhoof@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:dmVj88rMsBwn/5oEpfIABsAEOgyIp+Gau1iK/KLsovXNu+dld3c
 XHFoH0oX+7FydTcsGvRGGcfpQHSf+C3iCuJXNs65F1BcAZQDmfPnQKTeYEm6l2gLJ636Uch
 PiLDDafxHb9aOQy23pXkLV3cixKNgjppUFRYE6H693mIN9wCCf+xnVR3aOReThs6hTaWvpw
 +kJU3dxMVntsexzQk0mmg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:06TzArGJVbo=:rUw6P/fmFAKVVY5rtEBH7m
 fxbJebldzoRezsG692W4x4Z+mR89t9gVReN0jVUEHTS6JYkpFM0zpeAZY6DMMzSxj8nkFZKxq
 L3C42xJNDKwE6H+A8oORH2EUOMhM2kemHhtMOZOjS1AkkZfqCOv2lQ//pS76mta8l4aEsvuKS
 ghA31RRdXzM5h2zaA4BrRsZ5ZAJ9rF+a4tyyQhudv8Dqn8zmsD1Pexm6l7DJlRBRinoDhypJg
 4Fati6ZUyu6cBqFzaEUuzZCn7DQQGZlVmLrJIjFGlY6TCUOonzVrb9FGNj9Kwwn9LilzXBg2P
 DhcH9B4xZGkgWuFEO0fOvF+2mi51bxWdrcWEgFBs+pJMEjyGVpF9vBG77j7pX2Dy82FSlIcaX
 1mFTgXPLmDqtH+rodxdxj0Rmijkmpb4eaMemtPwn/nfE52MHPYHtEgsSv8VHoUxwlPUADZCPT
 QILXe/wnfk+RiMpETMN3ItiYaFoQvj0AhVRToSWRv5VM9y7CNzUjhy8eL5o51ktT/CCPAzQPW
 9keiGwqmR0hcFctUfBQd8EYgPM7z6+sMTuSjOaNS0ua3W0478h/jHdsl5UDERTEyvAV5oHU3J
 Zse2HJjSZWQSJtrA2WyCWHT2EKYc6y0aV9jv1O+KB5kYAdxMG6+dD4UM0dgxkRNv3GrpYgqQd
 XBPaH/1VlQuJmMSci4tw11QJ0LeI3K0dS/4GLxRJ8NTzTzoIWtFsUnVMqA+syHwpDrLmFjEU6
 /QsFBCNzzdnuzBAa0afJUYpyUnpghpwH+Am9dbK+GSpnco5P0rv8+pNYA33JZAgE92ddOvT6a
 8f3HnxwFfbPeEivJb6hssmD5oxRWe/EV/Fn2m2YMHGbCwjHLZRNgUhegE3qn/zp7dkhBc/+wf
 b+XadChWrrZeb+6tCaNZKQjB3lioX/ZwWQelqPg58IvA/ITLK5Y0nnsKHii3NR+RaNR52K7dz
 dNveG0CN547px+Fgfq+4k87BSRxxErs6hYX1o83e5pIkBHrgeX/RgzTI9V73dPRMojzorRAzp
 8qRemj6iltIm+vMvkOhWz+EMy+B0E62S81uak49hqKVKjZw+0JFhFCD1rgXhrk2xK2zGh77Jn
 AhQBkm6hclTyUD9omQxLwiDegtSY0tjnxDnmaoldE6kvq4RO+LWXIkU8cqtvfmIJNtN14dz1I
 7NKJnVfNQUr8XbJYt4/aOqrGd1beDPjWFHdwvreRDqjtaMPB9TQrOQPd54p9r2gXO92iQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 10:05:04PM -0700, Tzadik Vanderhoof wrote:

Thanks for V3, please see some comments inline.

> When git-p4 reads the output from a p4 command, it assumes it will be
> 100% UTF-8. If even one character in the output of one p4 command is
> not UTF-8, git-p4 crashes with:
>
> File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
>     value =3D value.decode() UnicodeDecodeError: 'utf-8' codec can't
> decode byte Ox93 in position 42: invalid start byte
>
> This is especially a problem on the "git p4 clone ... @all" command,
> where git-p4 needs to read thousands of changeset descriptions, one of
> which may have a stray smart quote, causing the whole clone operation
> to fail.
>

> This pull request adds a new config setting, allowing git-p4 to try
> another encoding (for example, "cp1252") and/or use the Unicode replacem=
ent
> character, to prevent the whole program from crashing on such a minor pr=
oblem.

"This pull request" is somewhat superflous wording.
How about:

Add a new config setting, allowing git-p4 to try a fallback encoding
(for example, "cp1252") and/or use the Unicode replacement character,
to prevent the whole program from crashing on such a minor problem.

Documentation is good (and needed, and neccessary).
Probably this is then not needed:
> See the documentation included in the patch for more details of how
> the new config setting works.

>
> Signed-off-by: Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
> ---
>  Documentation/git-p4.txt                   | 10 ++++
>  git-p4.py                                  | 11 +++-
>  t/t9835-git-p4-config-fallback-encoding.sh | 65 ++++++++++++++++++++++
>  3 files changed, 85 insertions(+), 1 deletion(-)
>  create mode 100755 t/t9835-git-p4-config-fallback-encoding.sh
>
> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
> index f89e68b..e0131a9 100644
> --- a/Documentation/git-p4.txt
> +++ b/Documentation/git-p4.txt
> @@ -638,6 +638,16 @@ git-p4.pathEncoding::
>  	to transcode the paths to UTF-8. As an example, Perforce on Windows
>  	often uses "cp1252" to encode path names.
>
> +git-p4.fallbackEncoding::
> +	Perforce changeset descriptions can be in a mixture of encodings.
> +	Git-p4 first tries to interpret each description as UTF-8. If that
> +	fails, this config allows another encoding to be tried. You
> +	can specify, for example, "cp1252".

That looks OK according to
https://docs.python.org/3/library/codecs.html#standard-encodings

> + If instead of an encoding,
> +	you specify "replace", UTF-8 will be used, with invalid UTF-8
> +	characters replaced by the Unicode replacement character. If you
> +	specify "none" (the default), there is no fallback, and any non
> +	UTF-8 character will cause git-p4 to immediately fail.
> +

May be, that is a matter of taste:

> + If git-p4.fallbackEncoding is "replace" ", UTF-8 will be used, with in=
valid UTF-8
> +	characters replaced by the Unicode replacement character.
> +	The default is "none": there is no fallback, and any non
> +	UTF-8 character will cause git-p4 to immediately fail.
> +



>  git-p4.largeFileSystem::
>  	Specify the system that is used for large (binary) files. Please note
>  	that large file systems do not support the 'git p4 submit' command.
> diff --git a/git-p4.py b/git-p4.py
> index 09c9e93..3364287 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -771,7 +771,16 @@ def p4CmdList(cmd, stdin=3DNone, stdin_mode=3D'w+b'=
, cb=3DNone, skip_info=3DFalse,
>                  for key, value in entry.items():
>                      key =3D key.decode()
>                      if isinstance(value, bytes) and not (key in ('data'=
, 'path', 'clientFile') or key.startswith('depotFile')):
> -                        value =3D value.decode()
> +                        try:
> +                            value =3D value.decode()
> +                        except UnicodeDecodeError as ex:
> +                            fallbackEncoding =3D gitConfig("git-p4.fall=
backEncoding").lower() or 'none'
> +                            if fallbackEncoding =3D=3D 'none':
> +                                raise Exception("UTF8 decoding failed. =
Consider using git config git-p4.fallbackEncoding")
> +                            elif fallbackEncoding =3D=3D 'replace':
> +                                value =3D value.decode(errors=3D'replac=
e')
> +                            else:
> +                                value =3D value.decode(encoding=3Dfallb=
ackEncoding)
>                      decoded_entry[key] =3D value
>                  # Parse out data if it's an error response
>                  if decoded_entry.get('code') =3D=3D 'error' and 'data' =
in decoded_entry:
> diff --git a/t/t9835-git-p4-config-fallback-encoding.sh b/t/t9835-git-p4=
-config-fallback-encoding.sh
> new file mode 100755
> index 0000000..56a245e
> --- /dev/null
> +++ b/t/t9835-git-p4-config-fallback-encoding.sh
> @@ -0,0 +1,65 @@
> +#!/bin/sh
> +
> +test_description=3D'test git-p4.fallbackEncoding config'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./lib-git-p4.sh
> +
> +if test_have_prereq !MINGW,!CYGWIN; then
> +	skip_all=3D'This system is not subject to encoding failures in "git p4=
 clone"'
> +	test_done
> +fi

Out of curiosity: Why are Windows versions (MINGW, CYGWIN) excluded ?

> +
> +test_expect_success 'start p4d' '
> +	start_p4d
> +'
> +
> +test_expect_success 'add cp1252 description' '
> +	cd "$cli" &&
> +	echo file1 >file1 &&
> +	p4 add file1 &&
> +	p4 submit -d documentaci=C3=B3n
> +'
> +
> +test_expect_success 'clone fails with git-p4.fallbackEncoding unset' '
> +	test_might_fail git config --global --unset git-p4.fallbackEncoding &&
> +	test_when_finished cleanup_git &&
> +	(
> +		test_must_fail git p4 clone --dest=3D"$git" //depot@all 2>> actual &&
Should this be >actual ?
And please no ' ' between the '>' and the filename.

> +		grep "UTF8 decoding failed. Consider using git config git-p4.fallback=
Encoding" actual
> +	)
> +'
> +test_expect_success 'clone fails with git-p4.fallbackEncoding set to "n=
one"' '
> +	git config --global git-p4.fallbackEncoding none &&
> +	test_when_finished cleanup_git &&
> +	(
> +		test_must_fail git p4 clone --dest=3D"$git" //depot@all 2>> actual &&
Same here
2 >actual

> +		grep "UTF8 decoding failed. Consider using git config git-p4.fallback=
Encoding" actual
> +	)
> +'
> +
> +test_expect_success 'clone succeeds with git-p4.fallbackEncoding set to=
 "cp1252"' '
> +	git config --global git-p4.fallbackEncoding cp1252 &&
> +	test_when_finished cleanup_git &&
> +	(
> +		git p4 clone --dest=3D"$git" //depot@all &&
> +		cd "$git" &&
> +		git log --oneline >log &&
> +		desc=3D$(head -1 log | awk '\''{print $2}'\'') &&	[ "$desc" =3D "docu=
mentaci=C3=B3n" ]

Style nit:
See Documentation/CodingGuidelines: - We prefer "test" over "[ ... ]".

desc=3D$(head -1 log | awk '\''{print $2}'\'') &&	test "$desc" =3D "docume=
ntaci=C3=B3n"

> +	)
> +'
> +
> +test_expect_success 'clone succeeds with git-p4.fallbackEncoding set to=
 "replace"' '
> +	git config --global git-p4.fallbackEncoding replace &&
> +	test_when_finished cleanup_git &&
> +	(
> +		git p4 clone --dest=3D"$git" //depot@all &&
> +		cd "$git" &&
> +		git log --oneline >log &&
> +		desc=3D$(head -1 log | awk '\''{print $2}'\'') &&	[ "$desc" =3D "docu=
mentaci=EF=BF=BDn" ]
> +	)
> +'
> +
> +test_done
> --
> 2.31.1.windows.1
>

Are there any more comments from the p4 experts ?
