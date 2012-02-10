From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/4] diff --stat: use the real terminal width
Date: Fri, 10 Feb 2012 13:15:35 +0700
Message-ID: <CACsJy8APGeTNv_E3qD=xFCiLC25M_nm3aJbq6YU73J=X0Wxh2w@mail.gmail.com>
References: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl> <1328831921-27272-4-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Feb 10 07:16:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvjmL-0007sl-6R
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 07:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab2BJGQJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 01:16:09 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:37247 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab2BJGQI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 01:16:08 -0500
Received: by werb13 with SMTP id b13so1765783wer.19
        for <git@vger.kernel.org>; Thu, 09 Feb 2012 22:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7lzPiXSF/cDmUTgoJHWdvqvsnDknRKOaKpeK81g6508=;
        b=kBXvZ6LcnlhgR3qg0AXa5VwVt2NZqT2Pv4MZJiXvRSIzwLb1uaGOBo7W7JJx1MrakM
         hw8Pg0PR6O/G5NB6lCAHBUtGqjs/riDpsizd+ZT8BGsCOQoEyrGAvaAFQIv2gg8u9Yi4
         MvLv43wYyMy9eSbCjsCl5uguSXFrUQDy0c0dY=
Received: by 10.216.132.214 with SMTP id o64mr255849wei.26.1328854566243; Thu,
 09 Feb 2012 22:16:06 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Thu, 9 Feb 2012 22:15:35 -0800 (PST)
In-Reply-To: <1328831921-27272-4-git-send-email-zbyszek@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190383>

2012/2/10 Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl>:
> @@ -1341,7 +1342,7 @@ static void show_stats(struct diffstat_t *data,=
 struct diff_options *options)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0line_prefix =3D=
 msg->buf;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> - =C2=A0 =C2=A0 =C2=A0 width =3D options->stat_width ? options->stat_=
width : 80;
> + =C2=A0 =C2=A0 =C2=A0 width =3D options->stat_width ? options->stat_=
width : term_columns();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0name_width =3D options->stat_name_width ? =
options->stat_name_width : 50;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0count =3D options->stat_count ? options->s=
tat_count : data->nr;

I tried this in the past and "git log -p" looked ugly on git.git
mainly because commit messages are still ~70 char long lines on my 279
char wide terminal. If this is project dependent, perhaps a config
key? Also the "50" below the changed line, maybe you want to change it
to 0.6 * width.
--=20
Duy
