From: Ivan Kanis <expire-by-2010-08-14@kanis.fr>
Subject: Excessive mmap [was Git server eats all memory]
Date: Mon, 09 Aug 2010 12:12:34 +0200
Message-ID: <wesy6cgm6wd.fsf_-_@kanis.fr>
References: <wesfwyupgrg.fsf@kanis.fr>
	<AANLkTimwy6GumHYSTo2je_hOUO80KEpx4_8z3iOoZyc0@mail.gmail.com>
	<87ocdhlgbl.fsf@kanis.fr>
	<AANLkTikt7LuhxHhOqPm2P-2hzXP54YThX5FRxF4yCFZu@mail.gmail.com>
	<AANLkTi=tf51FWkZZFw9cF=pcCyadgp7a9EXK=KQ6GSQS@mail.gmail.com>
	<87hbj74pve.fsf@kanis.fr>
	<AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ivan Kanis <expire-by-2010-08-11@kanis.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	jaredhance@gmail.com, Avery Pennarun <apenwarr@gmail.com>,
	jnareb@gmail.com, git <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 12:13:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiPM0-0004X2-Ja
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 12:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab0HIKNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 06:13:08 -0400
Received: from elysmail.net ([188.165.214.80]:64385 "EHLO elysmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836Ab0HIKNG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 06:13:06 -0400
Received: from IVAN (reverse.completel.net [92.103.229.106]) by elysmail.net with SMTP;
   Mon, 9 Aug 2010 11:12:36 +0100
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
In-Reply-To: <AANLkTinyX9cABkEDy3HBZoDVNWos2djNBSaw2Hg_yzAO@mail.gmail.com>
	(Dmitry Potapov's message of "Sat, 7 Aug 2010 10:42:08 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (windows-nt)
X-Antivirus: avast! (VPS 100808-1, 08/08/2010), Outbound message
X-Antivirus-Status: Clean
X-Declude-Sender: expire-by-2010-08-14@kanis.fr [92.103.229.106]
X-Declude-Spoolname: 11021150.eml
X-Declude-RefID: str=0001.0A0B0202.4C5FD4A0.010C,ss=1,fgs=0
X-Declude-Note: Scanned by Declude 4.10.53 "http://www.declude.com/x-note.htm"
X-Declude-Scan: Outgoing Score [-4] at 11:12:49 on 09 Aug 2010
X-Declude-Tests: None
X-Country-Chain: FRANCE->destination
X-Declude-Code: 1f
X-HELO: IVAN
X-Identity: 92.103.229.106 | reverse.completel.net | gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152961>

Dmitry Potapov <dpotapov@gmail.com> wrote:

> On Fri, Aug 06, 2010 at 07:23:17PM +0200, Ivan Kanis wrote:
>>
>> I expected the malloc to take 4G but was surprised it didn't. It seems
>> to be mmap taking all the memory. I am not familiar with that function,
>> it looks like it's mapping memory to a file... Is it reasonable to mmap
>> so much memory?
>
> AFAIK, Git does not need to mmap the whole pack to memory, but it
> is more efficient to mmap the whole pack wherever possible, because
> it has a completely random access, so if you store only one sliding
> window, you will have to re-read it many times. Besides, mmap size
> does not mean that so much physical memory is used. Pages should
> be loaded when they are necessary, and if you have more than one
> client cloning the same repo, this memory should be shared by them.

I have clone identical repositories and the system starts to swap. I
think it shows that cloning two repository doesn't share mmap.

I saw this constant defined in git-compat-util.h

/* This value must be multiple of (pagesize * 2) */
#define DEFAULT_PACKED_GIT_WINDOW_SIZE \
        (sizeof(void*) >= 8 \
                ?  1 * 1024 * 1024 * 1024 \
                : 32 * 1024 * 1024)

If I read this correctly git is allocating 1G of mmap on 64 bit
architecture. Isn't that a bit much? I am running on a 64 bit server so
I have bumped DEFAULT_PACKED_GIT_WINDOW_SIZE down to 64M but, alas, the
pack command still takes over 4G...

I'll keep investigating today,

Take care,
-- 
Ivan Kanis

Nothing in life is to be feared. It is only to be understood.
    -- Marie Curie 
