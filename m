From: Michael <barra_cuda@katamail.com>
Subject: Re: [PATCH] Further changes, thanks to <tp@lists.linux.it>
Date: Wed, 8 Aug 2007 23:04:53 +0200
Message-ID: <200708082304.53867.barra_cuda@katamail.com>
References: <20070808172739.5647a81b@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 23:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIshE-000682-MX
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 23:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762332AbXHHVD4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 8 Aug 2007 17:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760561AbXHHVD4
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 17:03:56 -0400
Received: from slim-3a.inet.it ([213.92.5.124]:46880 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755990AbXHHVDz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Aug 2007 17:03:55 -0400
Received: from host12-57-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.57.12]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.57.12+nG60FO7nBDgt; Wed, 08 Aug 2007 23:03:52 +0200
User-Agent: KMail/1.9.4
In-Reply-To: <20070808172739.5647a81b@paolo-desktop>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55366>

On Wednesday 08 August 2007 17:27, Paolo Ciarrocchi wrote:
> Further changes, thanks to <tp@lists.linux.it>
>=20
> Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
> ---

Is it just me, or this patch is corrupted?

>  po/it.po |  130
> ++++++++++++++++++++++++++++++++------------------------------ 1 file=
s
> changed, 67 insertions(+), 63 deletions(-)

git-am says:

	Applying Further changes, thanks to <tp@lists.linux.it>

	fatal: corrupt patch at line 13
	Patch failed at 0001.

git-gui-i18n$ grep ^- .dotest/0001 | wc
     66     434    3074
git-gui-i18n$ grep ^+ .dotest/0001 | wc
     27     105     955

I think there's a problem somewhere...

> diff --git a/po/it.po b/po/it.po
> index e87263e..1950b56 100644
> --- a/po/it.po
> +++ b/po/it.po
> @@ -2,18 +2,21 @@
>  # Copyright (C) 2007 Shawn Pearce
>  # This file is distributed under the same license as the git-gui
> package. # Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, 2007

Whitespace/newline corruption?

> -"Content-Type: text/plain; charset=3DUTF-8\n"
> -"Content-Transfer-Encoding: 8bit\n"
> +"Content-Type: text/plain; charset=3Diso-8859-1\n"
> +"Content-Transfer-Encoding: 8bit"

I'd guess the previous version is better :)

> @@ -34,9 +37,9 @@ msgid ""
>  "\n"
>  "Assume '%s' is version 1.5.0?\n"
>  msgstr ""
> -"La versione di GIT non pu=C3=B2 essere determinata.\n"
>  "\n"
> -"%s sostiene che la versione =C3=A8 '%s'.\n"
>  "\n"
>  "%s richiede almeno Git 1.5.0 o superiore.\n"
>  "\n"

Here and in many other places there are unneeded deletions... Is
that what you wanted? I don't think so, since the hunk header says
"@@ -34,9 +37,9 @@". I guess gmail has done a mess with your
patch: git-am had some problems parsing the headers too.

You should try to mail the same patch to yourself and re-apply that on
your tree to see if it fails.
