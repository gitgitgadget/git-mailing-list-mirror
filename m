From: Ivan Kanis <expire-by-2010-08-09@kanis.fr>
Subject: Re: Git server eats all memory
Date: Wed, 04 Aug 2010 19:50:46 +0200
Message-ID: <87iq3qgtc9.fsf@kanis.fr>
References: <wesfwyupgrg.fsf@kanis.fr> <vpqwrs6fk46.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 04 20:24:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ogidi-00037K-SV
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 20:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758009Ab0HDSU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 14:20:28 -0400
Received: from kanis.fr ([75.127.73.245]:4056 "EHLO kanis.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757946Ab0HDSUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 14:20:25 -0400
X-Greylist: delayed 1775 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Aug 2010 14:20:25 EDT
Received: from [89.83.137.164] (helo=tao)
	by kanis.fr with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <expire-by-2010-08-09@kanis.fr>)
	id 1Ogi76-0005hI-JF; Wed, 04 Aug 2010 13:50:48 -0400
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
In-Reply-To: <vpqwrs6fk46.fsf@bauges.imag.fr> (Matthieu Moy's message of "Wed,
	04 Aug 2010 17:55:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152592>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> The standard followup question in your case is: is the repository
> fully packed on the server? If not, maybe "git gc" or "git gc
> --aggressive" (expansive, but a one-time operation) could help.

Hi Mathieu,

I'll give it a shot when I get back to work.

I have done the following:

git repack -adf --window=100 --depth=20 --window-memory=50m

It greatly helps the compression stage that used up all the memory. The
problem is in the next phase when receiving objects. It is a bit strange
as receiving objects should not take up any memory on the server.

Take care,
-- 
Ivan Kanis
http://kanis.fr

Email is a wonderful thing for people whose role in life is to be on
top of things. But not for me; my role is to be on the bottom of
things. What I do takes long hours of studying and uninterruptible
concentration.
    -- Donald Knuth                                                 
