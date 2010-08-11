From: Ivan Kanis <expire-by-2010-08-16@kanis.fr>
Subject: Re: Git server eats all memory
Date: Wed, 11 Aug 2010 17:54:50 +0200
Message-ID: <wesd3tpxhyt.fsf@kanis.fr>
References: <wesfwyupgrg.fsf@kanis.fr>
	<robbat2-20100810T004153-279468425Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: srabbelier@gmail.com, Sam Vilain <sam@vilain.net>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	jaredhance@gmail.com, Avery Pennarun <apenwarr@gmail.com>,
	jnareb@gmail.com, git <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Wed Aug 11 17:55:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjDeH-0003SR-6L
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 17:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab0HKPzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 11:55:20 -0400
Received: from elysmail.net ([188.165.214.80]:64059 "EHLO elysmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221Ab0HKPzT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 11:55:19 -0400
Received: from IVAN (reverse.completel.net [92.103.229.106]) by elysmail.net with SMTP;
   Wed, 11 Aug 2010 16:54:47 +0100
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAAXNSR0IArs4c6QAAAB5QTFRF
 IBkXUxMTOCwoTC4qcUY8iFxQmmper31txpaJ/v/8aKZ1oAAAAcVJREFUOMt100tu2zAQAFDCXnUZ
 oAcIqG68LZULVLQBbwuSiffm6AIRRyeotAySJoVu2+FPpJWWC3/4NKOZocSW/yxWfnJ2+Bdwzhj7
 8gleWVy7DXC2rkMNr2V/zRbghXIwthf3VbIA9Ffc71vZCSFyCEsBggtNS8ludwvfmhYA0Vn9o4DP
 zMWxR7+cPWzAYFzwM0ModtdmcDbDS6i/hT7L+RZof5yCXGrYe5jn2YO6BYMjgY+51tCIAqHgBLwR
 pwLnGuRjAKyBJkuN4yd4U92uCY1vUr2D/c5b8DuxyQwfOHUeaLqDJhnkkuGXbB56h2C1IVBdgncc
 bBi6feroa9B6jUDojnQPQKupbyXyeeCE1oT7Oqrt+SnfY3mkiyGA/3AmD3H5g32CcBx6hY8pRkwJ
 9PpcjRGobUfprFnhAa1vepwcgMOhwG+pdSgKHFU9HAvoAH6XUl7lDUCCq5Qb6GMbVm3Aj++qDYCt
 wdBc/YHgOFCmS3mjDMRcSE2qY4E3Q3PVIQRQmeodNH4QEbRUFZzW+VotzwX4yTcRTySOML1qjcE5
 hTirVqDHkMAP0PjAywp3d18JZtqzvr9zDYD+GaSKtE6Zlr/DLPNFmOcvBAAAAABJRU5ErkJggg==
In-Reply-To: <robbat2-20100810T004153-279468425Z@orbis-terrarum.net> (Robin
	H. Johnson's message of "Tue, 10 Aug 2010 00:46:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (windows-nt)
X-Antivirus: avast! (VPS 100811-0, 11/08/2010), Outbound message
X-Antivirus-Status: Clean
X-Declude-Sender: expire-by-2010-08-16@kanis.fr [92.103.229.106]
X-Declude-Spoolname: 11035026.eml
X-Declude-RefID: str=0001.0A0B0205.4C62C7D6.004B,ss=1,fgs=0
X-Declude-Note: Scanned by Declude 4.10.53 "http://www.declude.com/x-note.htm"
X-Declude-Scan: Outgoing Score [-4] at 16:55:01 on 11 Aug 2010
X-Declude-Tests: None
X-Country-Chain: FRANCE->destination
X-Declude-Code: 1f
X-HELO: IVAN
X-Identity: 92.103.229.106 | reverse.completel.net | gentoo.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153260>

Hi Robin,

"Robin H. Johnson" <robbat2@gentoo.org> wrote:

> On Wed, Aug 04, 2010 at 04:57:39PM +0200,  Ivan Kanis wrote:
>> I am wondering if anyone has seen this behavior? I'll do whatever I can
>> to troubleshoot the problem. I know C but I just don't know where to
>> look at. Any help would be very much appreciated.
>
> Multiple concurrent full clones push the server into swap. We had 16GiB
> of RAM, and this was still occurring.

Glad I am not the only one seeing this :D

> Our temporary solution plan is via hooks, if you're asking for a item
> before a certain point, throw an error telling you to download a
> git-bundle from a given URL instead (as a bonus you can resume that
> trivially).

I don't understand the solution... Do you have snippet of the hook?

Take care,
-- 
Ivan Kanis
http://kanis.fr
