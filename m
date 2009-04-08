From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 6/8] archive: use index instead of parsing tree directly
Date: Wed, 08 Apr 2009 22:39:51 +0200
Message-ID: <49DD0B97.6040403@lsrfire.ath.cx>
References: <1239185133-4181-1-git-send-email-pclouds@gmail.com> <1239185133-4181-2-git-send-email-pclouds@gmail.com> <1239185133-4181-3-git-send-email-pclouds@gmail.com> <1239185133-4181-4-git-send-email-pclouds@gmail.com> <1239185133-4181-5-git-send-email-pclouds@gmail.com> <1239185133-4181-6-git-send-email-pclouds@gmail.com> <1239185133-4181-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 22:41:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lreae-0006NR-Ec
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 22:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762118AbZDHUkI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Apr 2009 16:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761140AbZDHUkG
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 16:40:06 -0400
Received: from india601.server4you.de ([85.25.151.105]:60824 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757579AbZDHUkF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 16:40:05 -0400
Received: from [10.0.1.101] (p57B7EF55.dip.t-dialin.net [87.183.239.85])
	by india601.server4you.de (Postfix) with ESMTPSA id 67EC92F8043;
	Wed,  8 Apr 2009 22:40:03 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1239185133-4181-7-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116120>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> +		/* It's not really pathspec, so match_pathspec can't be used */
> +		for (path =3D args->pathspec;!match && *path;path++) {
> +			for (str =3D ce->name, prefix =3D *path;*prefix && *str =3D=3D *p=
refix; str++, prefix++)
> +				;
> +			if (!*prefix && *str =3D=3D '/')
> +				match =3D 1;
> +		}

This works with, e.g.:

	git archive HEAD Documentation

but not with:

	git archive HEAD Makefile

or:
	git archive HEAD Documentation/

Ren=C3=A9
