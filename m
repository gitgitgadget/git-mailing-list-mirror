From: Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>
Subject: Re: [PATCH] Update bash completions to prevent unbound variable
	errors.
Date: Mon, 12 Jan 2009 22:25:44 +0100
Message-ID: <20090112212544.GA24941@chistera.yi.org>
References: <496BA0E4.2040607@tedpavlic.com> <200901121435.35547.bss@iguanasuicide.net> <496BB204.2040109@tedpavlic.com> <496BA0E4.2040607@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 22:27:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMUJT-0007TO-1D
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 22:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbZALVZr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Jan 2009 16:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbZALVZr
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 16:25:47 -0500
Received: from 226.Red-80-25-139.staticIP.rima-tde.net ([80.25.139.226]:4894
	"EHLO etc.inittab.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbZALVZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 16:25:47 -0500
Received: from chistera.yi.org (unknown [192.168.254.34])
	by etc.inittab.org (Postfix) with ESMTP id 99EA5801C078;
	Mon, 12 Jan 2009 22:25:45 +0100 (CET)
Received: from userid 1000 by justin with local (Exim 4.69) 
	  id 1LMUI4-0006Zf-Mc; Mon, 12 Jan 2009 22:25:44 +0100
Content-Disposition: inline
In-Reply-To: <496BB204.2040109@tedpavlic.com>
X-No-CC: Please respect my Mail-Followup-To header
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105384>

* Ted Pavlic [Mon, 12 Jan 2009 16:11:32 -0500]:

>> That looks ugly to me.  Any reason we shouldn't just "set +u" at the=
 top of
>> the script?

> As already discussed, because the script must be sourced, then the "s=
et =20
> +u" has global scope.

> I suppose that the option could be tested and then reset as appropria=
te =20
> at the end of the script.

That does not help, because appart from being global, it of course take=
s
effect at run time. In other words, it doesn't matter if set -u is
active or not at function definition time, but at function invoation
time.

> (note: for some reason Mercurial's bash completion script does not ha=
ve =20
> this problem; they use $1 directly without bash complaining)

Because (from a quick look) their completion script never expands a
variable which is not known to be set.


--=20
Adeodato Sim=C3=B3                                     dato at net.com.=
org.es
Debian Developer                                  adeodato at debian.or=
g
=20
A hacker does for love what other would not do for money.
