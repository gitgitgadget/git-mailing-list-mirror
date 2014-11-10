From: =?UTF-8?Q?Vanja_Radovanovi=C4=87?= <elvanja@gmail.com>
Subject: Re: [PATCH] Custom prompt colors
Date: Mon, 10 Nov 2014 11:37:35 +0100
Message-ID: <CAC2nwfdU5i+=JugCjoLjRo0uwWMTt-_+H0akYpdmiWoK+mFSSg@mail.gmail.com>
References: <CAC2nwfcuPLKr-kpt-G1uUmMoZs8T+pg9uJWP5oxMea60xg09=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 10 11:37:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnmLv-00062J-0z
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 11:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbaKJKhh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Nov 2014 05:37:37 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:59750 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751584AbaKJKhh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Nov 2014 05:37:37 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so5499249lbv.40
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 02:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=cuffcQxIUDOAq41+CPQz4Dq2v3/5tEdbe4JJOjkQb2s=;
        b=YaYRemuAeRPrHhCredRgDIRowvQuvqa5ekAU8VYScxp2rBbTR2yi1c3Ad7I/C3OL/W
         EXKAReN3TZ+O2tA0a7zhhHvquqdDMW2B2YKpzdQA3p0whz113KgQuieXm6QSagtLLfuU
         pYCpp79GIZipamxJHkPcG/6JXIwJFbl+Y+q1E71joEvPrqy6Sec7FIksGrrmB7hfdu7p
         /8/y5Tok2QW3Z66jOcUZomipVsK1FrP/9T0vcCaNhJHF58qLkuNfhk5hNgBlf0Zgf8Im
         gtpoLeJ6fkrMOkIFJddy9owFD3qjXi8sxrlPNTCkktDcDvo8e8OVH7NahLe4MJYn1YCt
         4E1w==
X-Received: by 10.152.8.100 with SMTP id q4mr27860369laa.48.1415615855394;
 Mon, 10 Nov 2014 02:37:35 -0800 (PST)
Received: by 10.112.184.76 with HTTP; Mon, 10 Nov 2014 02:37:35 -0800 (PST)
In-Reply-To: <CAC2nwfcuPLKr-kpt-G1uUmMoZs8T+pg9uJWP5oxMea60xg09=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

http://git.661346.n2.nabble.com/PATCH-Custom-prompt-colors-td7620939.ht=
ml
=E2=80=9CArt has no limits.
Just like me!=E2=80=9D
by Ponce


On Mon, Nov 10, 2014 at 10:42 AM, Vanja Radovanovi=C4=87 <elvanja@gmail=
=2Ecom> wrote:
> From 41e9edae533306b4a50570e32dbbdd291a4a5fbf Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?Vanja=3D20Radovanovi=3DC4=3D87?=3D <elvanja@gmail.c=
om>
> Date: Sun, 9 Nov 2014 20:05:48 +0100
> Subject: [PATCH] contrib/completion: custom git prompt colors
>
> Allow git prompt colors to be customized.
> Accept globally set colors, use defaults otherwise.
>
> Note: requires /usr/lib/git-core/git-sh-promp to be
> removed or commented out, so custom git-prompt.sh
> can be used.
> ---
>  contrib/completion/git-prompt.sh | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/gi=
t-prompt.sh
> index c5473dc..ff5b04b 100644
> --- a/contrib/completion/git-prompt.sh
> +++ b/contrib/completion/git-prompt.sh
> @@ -84,6 +84,10 @@
>  # GIT_PS1_SHOWCOLORHINTS to a nonempty value. The colors are based o=
n
>  # the colored output of "git status -sb" and are available only when
>  # using __git_ps1 for PROMPT_COMMAND or precmd.
> +# Colors can be overridden; just set GIT_PS1_BAD_COLOR,
> +# GIT_PS1_OK_COLOR and/or GIT_PS1_FLAGS_COLOR to the color of your c=
hoice.
> +# Make sure you use appropriately escaped color codes, see
> +# __git_ps1_colorize_gitstring function for details/defaults.
>
>  # check whether printf supports -v
>  __git_printf_supports_v=3D
> @@ -240,9 +244,21 @@ __git_ps1_colorize_gitstring ()
>   local c_lblue=3D'\[\e[1;34m\]'
>   local c_clear=3D'\[\e[0m\]'
>   fi
> +
>   local bad_color=3D$c_red
> +  if [ -n "${GIT_PS1_BAD_COLOR-}" ]; then
> +    bad_color=3D$GIT_PS1_BAD_COLOR
> +  fi
> +
>   local ok_color=3D$c_green
> - local flags_color=3D"$c_lblue"
> +  if [ -n "${GIT_PS1_OK_COLOR-}" ]; then
> +    ok_color=3D$GIT_PS1_OK_COLOR
> +  fi
> +
> +  local flags_color=3D"$c_lblue"
> +  if [ -n "${GIT_PS1_FLAGS_COLOR-}" ]; then
> +    flags_color=3D$GIT_PS1_FLAGS_COLOR
> +  fi
>
>   local branch_color=3D""
>   if [ $detached =3D no ]; then
> --
> 2.1.3
