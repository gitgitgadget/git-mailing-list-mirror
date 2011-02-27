From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCHv2 3/3] git-add: rename -u to -a
Date: Sun, 27 Feb 2011 23:38:42 +0700
Message-ID: <AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com>
References: <cover.1298821535.git.git@drmicha.warpmail.net>
 <4D68D630.9000608@drmicha.warpmail.net> <711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Feb 27 17:39:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtjeQ-0003rz-Gq
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 17:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab1B0QjO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Feb 2011 11:39:14 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46857 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408Ab1B0QjN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Feb 2011 11:39:13 -0500
Received: by wwb22 with SMTP id 22so2197658wwb.1
        for <git@vger.kernel.org>; Sun, 27 Feb 2011 08:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=MOHYVj2bk9P+ZEP/9Thzbx0PHxq0QkTTOLWZTbzF8cE=;
        b=dPGT/2hRdfvYPc0Q2fghr9LoJmadFcugb21GxWTcyV2togRJiUdu5Nx6UFLNsbDbp6
         1FVtP20bldN23LpechMAAY4xwFS77EDa7lTWGXS2FIB92EjWxiq9GrNyax83JwOBGFB8
         IFYJkmeREM16C9wSf1EwnYu4e0zYUb5cPIVwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JLUCSVSq9H1B8g5AMHJ9pYE/mcyuLN43Pg0tU8TvAjv1Lzh7xDBWzJC3BIW6mb4aop
         8XAnwd5CykyvS/rxTnbX+W5BHXPurDy10zAOEPOvBwuhdFbW6eaCIeHnYJ0uO9MD+CTr
         uNDKN0Y+4anIofYaNK9iOfLv1r6clMBxV2HD8=
Received: by 10.216.181.76 with SMTP id k54mr1411935wem.58.1298824752046; Sun,
 27 Feb 2011 08:39:12 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Sun, 27 Feb 2011 08:38:42 -0800 (PST)
In-Reply-To: <711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168042>

On Sun, Feb 27, 2011 at 10:50 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> @@ -320,8 +320,9 @@ static struct option builtin_add_options[] =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_BOOLEAN('p', "patch", &patch_interacti=
ve, "select hunks interactively"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_BOOLEAN('e', "edit", &edit_interactive=
, "edit current diff and apply"),
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT__FORCE(&ignored_too, "allow adding oth=
erwise ignored files"),
> - =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN('u', "update", &take_worktree_chan=
ges, "update tracked files"),
> + =C2=A0 =C2=A0 =C2=A0 { OPTION_BOOLEAN, 'u', "update", &take_worktre=
e_changes, NULL, "update tracked files", PARSE_OPT_HIDDEN | PARSE_OPT_N=
OARG },
> =C2=A0 =C2=A0 =C2=A0 =C2=A0OPT_BOOLEAN('N', "intent-to-add", &intent_=
to_add, "record only the fact that the path will be added later"),
> + =C2=A0 =C2=A0 =C2=A0 OPT_BOOLEAN('a', "all-tracked", &take_worktree=
_changes, "add changes from all tracked files"),

Should -u now print warnings to help script writers migrate to -a? Or
do we plan to keep hidden -u forever?
--=20
Duy
