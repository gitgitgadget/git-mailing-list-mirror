From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive and tar options
Date: Mon, 18 Jul 2011 22:50:28 +0200
Message-ID: <4E249C94.3040002@lsrfire.ath.cx>
References: <ivla29$liu$1@dough.gmane.org> <20110714015656.GA20136@sigill.intra.peff.net> <4E1F2468.6080409@lsrfire.ath.cx> <20110714172718.GA21341@sigill.intra.peff.net> <4E2477E1.5090406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Neal Kreitzinger <neal@rsss.com>,
	git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 22:50:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiumB-0004bE-Fx
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 22:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580Ab1GRUun convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jul 2011 16:50:43 -0400
Received: from india601.server4you.de ([85.25.151.105]:34845 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab1GRUun (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 16:50:43 -0400
Received: from [192.168.2.106] (p4FFDB1F3.dip.t-dialin.net [79.253.177.243])
	by india601.server4you.de (Postfix) with ESMTPSA id 834642F80F6;
	Mon, 18 Jul 2011 22:50:41 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <4E2477E1.5090406@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177408>

Am 18.07.2011 20:13, schrieb Neal Kreitzinger:
> HEAD:$subdir worked on my bare repo.  I ran it for each transformant
> pathspec and then combined the archives with tar --catenate:
>=20
> # git archive --format=3Dtar --prefix=3DmyWeb/myRoot/myAPP/Templates/
> HEAD:WebPortal/Templates/ >myAPP.myTag.tar
> # git archive --format=3Dtar --prefix=3Dopt/mySTUFF/v01/SCRIPTS/
> HEAD:SCRIPTS/ >SCRIPTS.tar
> # tar --file=3DmyAPP.myTag.tar -A SCRIPTS.tar
>=20
> However, the permissions also need to change to 777 and tar --mode wo=
uld
> not effect this in combination with --catenation or -x.  Is there a w=
ay
> I can change the permissions without having to untar->chmod->retar, a=
nd
> without having to use a non-bare repo as an intermediary?

You can use the configuration setting tar.umask to affect the
permissions of the archive entries.  Set it to 0 to pass the permission
bits from the repo unchanged.

Ren=C3=A9
