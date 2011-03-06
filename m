From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] unpack-trees.c: check return value of lstat()
Date: Sun, 06 Mar 2011 20:29:11 +0100
Message-ID: <vpqfwr0hwu0.fsf@bauges.imag.fr>
References: <201103062013.52793.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: drizzd@aon.a, git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 06 20:29:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwJdp-0001jC-U0
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 20:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab1CFT3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Mar 2011 14:29:16 -0500
Received: from mx2.imag.fr ([129.88.30.17]:38928 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454Ab1CFT3P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 14:29:15 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p26JTAAu023182
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 Mar 2011 20:29:10 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PwJdg-0003Ec-72; Sun, 06 Mar 2011 20:29:12 +0100
In-Reply-To: <201103062013.52793.tboegi@web.de> ("Torsten =?iso-8859-1?Q?B?=
 =?iso-8859-1?Q?=F6gershausen=22's?=
	message of "Sun, 6 Mar 2011 20:13:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sun, 06 Mar 2011 20:29:10 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p26JTAAu023182
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1300044550.52228@kQaI7Pp+xUqgWtaHftaFsA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168525>

Torsten B=F6gershausen <tboegi@web.de> writes:

> +		if (!lstat(path, &st))
> +			return check_ok_to_remove(path, len, DT_UNKNOWN, NULL, &st,
> +			                          error_type, o);
>  	} else if (!lstat(ce->name, &st))

What happens if lstat returns a non-0 value?

Anyway, this seems to have been fixed by a93e53018 (Wed Jan 12 20:28:09
2011, unpack-trees: handle lstat failure for existing file) already.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
