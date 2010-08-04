From: Ivan Kanis <expire-by-2010-08-09@kanis.fr>
Subject: Git server eats all memory
Date: Wed, 04 Aug 2010 16:57:39 +0200
Message-ID: <wesfwyupgrg.fsf@kanis.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 17:13:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogfee-0000zz-NT
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 17:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174Ab0HDPNL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 11:13:11 -0400
Received: from elysmail.net ([188.165.214.80]:57182 "EHLO elysmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759Ab0HDPNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 11:13:09 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Aug 2010 11:13:09 EDT
Received: from IVAN (reverse.completel.net [92.103.229.106]) by elysmail.net with SMTP;
   Wed, 4 Aug 2010 15:57:39 +0100
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
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (windows-nt)
X-Antivirus: avast! (VPS 100804-0, 04/08/2010), Outbound message
X-Antivirus-Status: Clean
X-Declude-Sender: expire-by-2010-08-09@kanis.fr [92.103.229.106]
X-Declude-Spoolname: 10996335.eml
X-Declude-RefID: str=0001.0A0B0206.4C597FEC.0053,ss=1,fgs=0
X-Declude-Note: Scanned by Declude 4.10.53 "http://www.declude.com/x-note.htm"
X-Declude-Scan: Outgoing Score [-1] at 15:57:50 on 04 Aug 2010
X-Declude-Tests: None
X-Country-Chain: FRANCE->destination
X-Declude-Code: f
X-HELO: IVAN
X-Identity: 92.103.229.106 | reverse.completel.net | vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152584>

Hello,

I am running git 1.7.0.4 on Debian stable. I have compiled git from
source. I am cloning using ssh.The client and the server are running
the same version. The bare repository is 4.5G with various binary files,
I have 6G of memory on my server.

I am having problem with memory ballooning when receiving object
from the server. The amount of memory used on the server seems to be same
size as the object received.

I have been discussing this quite a bit on #git at freenode. Hilary said
it was maybe due to file mmap that caused the memory reported on top to
be skewed.

I have ran two clones side by side and noticed that the server started
to swap and performance were awful. This means that if two developers
are doing a clone at the same time they will notice the slowness. 

Another worry is that we're planning to have more repositories of the
same size and the server just won't scale.

I am wondering if anyone has seen this behavior? I'll do whatever I can
to troubleshoot the problem. I know C but I just don't know where to
look at. Any help would be very much appreciated.

Kind regards,
-- 
Ivan Kanis

Let a fool hold his tongue and he will pass for a sage.
    -- Publilius Syrus 
