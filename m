From: "Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>
Subject: AW: Understanding behavior of git blame -M
Date: Fri, 15 Aug 2014 20:57:14 +0000
Message-ID: <71BF70CE41AEE741896AF3A5450D86F11F28C793@DEFTHW99EH3MSX.ww902.siemens.net>
References: <71BF70CE41AEE741896AF3A5450D86F11F28C762@DEFTHW99EH3MSX.ww902.siemens.net>
 <xmqq7g291y21.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 22:57:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIOZ5-0001Jg-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 22:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbaHOU5b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2014 16:57:31 -0400
Received: from goliath.siemens.de ([192.35.17.28]:43273 "EHLO
	goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbaHOU5a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Aug 2014 16:57:30 -0400
Received: from mail2.sbs.de (localhost [127.0.0.1])
	by goliath.siemens.de (8.14.3/8.14.3) with ESMTP id s7FKvIxT020745;
	Fri, 15 Aug 2014 22:57:19 +0200
Received: from DEFTHW99ERHMSX.ww902.siemens.net (defthw99erhmsx.ww902.siemens.net [139.22.70.133])
	by mail2.sbs.de (8.14.3/8.14.3) with ESMTP id s7FKvFmZ018891
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Fri, 15 Aug 2014 22:57:15 +0200
Received: from DEFTHW99ERAMSX.ww902.siemens.net (139.22.70.72) by
 DEFTHW99ERHMSX.ww902.siemens.net (139.22.70.133) with Microsoft SMTP Server
 (TLS) id 14.3.195.1; Fri, 15 Aug 2014 22:57:15 +0200
Received: from DEFTHW99EH3MSX.ww902.siemens.net ([169.254.1.177]) by
 DEFTHW99ERAMSX.ww902.siemens.net ([139.22.70.72]) with mapi id
 14.03.0195.001; Fri, 15 Aug 2014 22:57:15 +0200
Thread-Topic: Understanding behavior of git blame -M
Thread-Index: Ac+4jUNF6aAz44SIRIyypexOO2EquAAAPv+AAAdNScYAB+9L8A==
In-Reply-To: <xmqq7g291y21.fsf@gitster.dls.corp.google.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.22.70.50]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255305>

No. The distance seems to have no influence. In the meantime I've found=
 out (as mentioned in my other reply) that the movements are detected i=
f at least three lines are moved.

-----Urspr=FCngliche Nachricht-----
Von: Junio C Hamano [mailto:gitster@pobox.com]=20
Gesendet: Freitag, 15. August 2014 19:08
An: Sokolov, Konstantin (ext)
Cc: git@vger.kernel.org
Betreff: Re: Understanding behavior of git blame -M

"Sokolov, Konstantin (ext)" <konstantin.sokolov.ext@siemens.com>
writes:

>>git blame -s -n -f -w -M20 file.txt
> ^2cd9f7f 1 1) AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
> ^2cd9f7f 3 2) CCCCCCCCCCCCCCCCCCCCCCCC2222222222222222222222222
> ^2cd9f7f 4 3) DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD
> d4bbd97e 4 4) BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB
> ^2cd9f7f 5 5) EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
> ^2cd9f7f 6 6) GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG
> ^2cd9f7f 7 7) FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
>
> I wonder, why line B is not recognized as moved. According to the=20
> documentation, I would expect git blame to report that it originates=20
> from line 2 in revision 2cd9f7f. Can anybody explain the behavior?

Interesting.  Would it make a difference if you move B further away fro=
m lines A and C?
