From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: poll() emulation in git
Date: Wed, 5 Sep 2012 14:57:31 +0200
Message-ID: <00cf01cd8b66$034793c0$09d6bb40$@schmitz-digital.de>
References: <00c001cd8b59$028e41c0$07aac540$@schmitz-digital.de> <50474001.5030407@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
	"'Erik Faye-Lund'" <kusmabite@gmail.com>, <bug-gnulib@gnu.org>
To: "'Paolo Bonzini'" <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 14:57:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9FAy-0005Oe-B2
	for gcvg-git-2@plane.gmane.org; Wed, 05 Sep 2012 14:57:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985Ab2IEM5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Sep 2012 08:57:40 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:65460 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab2IEM5j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2012 08:57:39 -0400
Received: from DualCore (dsdf-4db50426.pool.mediaWays.net [77.181.4.38])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0LroR0-1TaHio30bG-0134oJ; Wed, 05 Sep 2012 14:57:37 +0200
In-Reply-To: <50474001.5030407@gnu.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIgUOmy4ZEsU7RI7VRx80YFphUkTAI89tULlsQ0qHA=
Content-Language: de
X-Provags-ID: V02:K0:/bdWg8Zus9G/8RZiAhTXm5LdW5gAlcTJcIfwBptzPgJ
 QdQi7i3mjZgx5zFqbzH7MWVn5l/5tEWGATpqpGPl8r7T9iIxln
 tlQmeVwbKbdAh6BjN3S8SGJpK1INBxaaJB6FMlg4mRIPoCFr+J
 wTXTLJJzelax7MTCZeGQV2gEthUCCQ8HtMY/F+WczbFWPasZ1I
 Z0jHaRcKhOSRx1bMKEMj8hi2i0WKu5rHNmJnpRhxUBD7OLSyXb
 fIwQsyMUmR3/44MT9wgGl5oHjP0q520Slau1be64jhFTyqBg1z
 MpkC0Wzv6RjvhevYPzqV0hSFy4RpGWBdX4xA03pr2bTk20Yu8U
 Vu0xfR2FNo1rNR2zu7kUnUJOMVQiA24f0xvFfdcZ/4P8pLdc9b
 1OGvwjdxjgzew==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204822>

> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
> Sent: Wednesday, September 05, 2012 2:05 PM
> To: Joachim Schmitz
> Cc: 'Junio C Hamano'; git@vger.kernel.org; 'Erik Faye-Lund'; bug-gnulib@gnu.org
> Subject: Re: poll() emulation in git
> 
> Il 05/09/2012 13:24, Joachim Schmitz ha scritto:
> > However: this poll implementation, while compiling OK, doesn't work properly.
> > Because it uses recv(...,MSG_PEEK), it works on sockets only (returns ENOTSOCK on anything else), while the real poll() works on
all
> > kind if file descriptors, at least that is my understanding.
> 
> Actually recv(...,MSG_PEEK) on most Unix variants works on non-sockets
> too.  The trick is taken from GNU Pth in turn.
> 
> > Here on HP NonStop, when being connected via an non-interactive SSH, we get a set of pipes (stdin, stdout, stderr) instead of a
> > socket to talk to, so the poll() just hangs/loops.
> 
> Does your system have a working FIONREAD ioctl for pipes?

It does have FIONREAD ioctl. Whether it works properly is to be determined...
I'll test if you could show me how?


Bye, Jojo
