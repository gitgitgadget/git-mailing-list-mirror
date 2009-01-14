From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH next v2] git-notes: add test case for multi-line notes
Date: Wed, 14 Jan 2009 18:14:31 +0100
Message-ID: <496E1D77.6000307@viscovery.net>
References: <alpine.DEB.1.00.0901141627440.3586@pacific.mpi-cbg.de> <496E129B.3020502@trolltech.com> <20090114165633.GC15758@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yIEFybmUgVmVzdGLDuA==?= <tavestbo@trolltech.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 14 18:16:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN9La-0003bt-SA
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 18:16:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762571AbZANROm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 12:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762644AbZANROm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 12:14:42 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:8523 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762530AbZANROl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 12:14:41 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LN9K7-000384-Le; Wed, 14 Jan 2009 18:14:36 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4DCB3A865; Wed, 14 Jan 2009 18:14:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <20090114165633.GC15758@coredump.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105666>

Jeff King schrieb:
> On Wed, Jan 14, 2009 at 05:28:11PM +0100, Tor Arne Vestb=C3=B8 wrote:
>=20
>> +MSG=3D${MSG//%/}
>> +printf "$MSG" > "$1"
>> +printf "$MSG" >& 2
>=20
> Substitution parameter expansion is a bash-ism, IIRC. How about just
>=20
>   printf %s "$MSG" ?

A the point was that $MSG contains \n, which should be turned int LF. I=
MO,
the easiest way to achieve this is:

MSG=3D'b3
c3c3c3c3
d3d3d3'

test_expect_success ' ... ' '
   ...
   MSG=3D"$MSG" git notes edit
'

and go back to using echo in the part cited above.

-- Hannes
