From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] am: Allow passing exclude and include args to apply
Date: Sun, 19 Dec 2010 14:56:58 -0200
Message-ID: <AANLkTik5-oJYsfEoeYjy8E9v4T4_7VBsoGnqg7oXwnbC@mail.gmail.com>
References: <1292775461-26762-1-git-send-email-max@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	klibc@zytor.com
To: maximilian attems <max@stro.at>
X-From: git-owner@vger.kernel.org Sun Dec 19 17:57:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUMZH-0003XR-Ou
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 17:57:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643Ab0LSQ5B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Dec 2010 11:57:01 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:65204 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab0LSQ5A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Dec 2010 11:57:00 -0500
Received: by bwz16 with SMTP id 16so2600678bwz.4
        for <git@vger.kernel.org>; Sun, 19 Dec 2010 08:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=unMA1SQpsv2Sm622l+N3caFpBBXIy2eGG0hXqfossco=;
        b=kxq3kJazpc7RzXaZvhsdMnuyeJiNLS0guZpqnnEv8tK+a60bCwEyMOf7FC5NJYAM30
         vUq7VZlhI8hDK2OasX9RmJv1aZEHf7jgjDac4kpqtm5Mc1Nq3DMZplldPUe9wMLiNa6E
         ZYGuxPD0CC/oYonFdygXpUqv8Wpv6z/Qs1Xns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PidAzQDXb/E3N+v7C6e7EGv35lI8O8+Lqum1Z+tYacDDMrrjlQfahiqNnPh31vVCJY
         +5B3NmT6w9o9m8Dzdj6L0wUy0Yq1VP8qQcSYNxlGlGJXIzeOmVLahwoORXEOuRHor7+q
         21adrPgVVdKKmmlqsbtnbg5TtzU9R+xRcuEmQ=
Received: by 10.204.99.69 with SMTP id t5mr2677778bkn.124.1292777818386; Sun,
 19 Dec 2010 08:56:58 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Sun, 19 Dec 2010 08:56:58 -0800 (PST)
In-Reply-To: <1292775461-26762-1-git-send-email-max@stro.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163960>

On Sun, Dec 19, 2010 at 2:17 PM, maximilian attems <max@stro.at> wrote:
> When porting patches from dash git to klibc git,
> where dash has a different directory structure those
> switches are handy:
> Exported with format-patch on dash side and used am
> as import for klibc side.
>

I don't know, but this commit message doesn't look good. Can you be
more specific about what the patch does, and what it's trying to fix.
Describing a use case is good, but in this case it isn't help me much
(maybe for others the issue here is clear, but for my taste no).

> Signed-off-by: maximilian attems <max@stro.at>
> ---
> =C2=A0Documentation/git-am.txt | =C2=A0 =C2=A05 ++++-
> =C2=A0git-am.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A04 +++-
> =C2=A02 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> index 51297d0..4c65dba 100644
> --- a/Documentation/git-am.txt
> +++ b/Documentation/git-am.txt
> @@ -13,7 +13,8 @@ SYNOPSIS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--3way] [--interactive] [--committer-dat=
e-is-author-date]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--ignore-date] [--ignore-space-change | =
--ignore-whitespace]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [--whitespace=3D<option>] [-C<n>] [-p<n>]=
 [--directory=3D<dir>]
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0[--reject] [-q | --quiet] [--scissors | =
--no-scissors]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0[--exclude=3DPATH] [--include=3DPATH] [-=
-reject] [-q | --quiet]
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0[--scissors | --no-scissors]
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 [(<mbox> | <Maildir>)...]
> =C2=A0'git am' (--continue | --skip | --abort)
>
> @@ -87,6 +88,8 @@ default. =C2=A0 You can use `--no-utf8` to override=
 this.
> =C2=A0-C<n>::
> =C2=A0-p<n>::
> =C2=A0--directory=3D<dir>::
> +--exclude=3D<path-pattern>::
> +--include=3D<path-pattern>::
> =C2=A0--reject::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0These flags are passed to the 'git apply' =
(see linkgit:git-apply[1])
> =C2=A0 =C2=A0 =C2=A0 =C2=A0program that applies
> diff --git a/git-am.sh b/git-am.sh
> index df09b42..174f6a2 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -22,6 +22,8 @@ whitespace=3D =C2=A0 =C2=A0 pass it through git-app=
ly
> =C2=A0ignore-space-change pass it through git-apply
> =C2=A0ignore-whitespace pass it through git-apply
> =C2=A0directory=3D =C2=A0 =C2=A0 =C2=A0pass it through git-apply
> +exclude=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0pass it through git-apply
> +include=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0pass it through git-apply
> =C2=A0C=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass it th=
rough git-apply
> =C2=A0p=3D =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pass it th=
rough git-apply
> =C2=A0patch-format=3D =C2=A0 format the patch(es) are in
> @@ -340,7 +342,7 @@ do
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0--resolvemsg)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shift; resolve=
msg=3D$1 ;;
> - =C2=A0 =C2=A0 =C2=A0 --whitespace|--directory)
> + =C2=A0 =C2=A0 =C2=A0 --whitespace|--directory|--exclude|--include)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git_apply_opt=3D=
"$git_apply_opt $(sq "$1=3D$2")"; shift ;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0-C|-p)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git_apply_opt=3D=
"$git_apply_opt $(sq "$1$2")"; shift ;;
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
