From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 08/67] add reentrant variants of sha1_to_hex and
 find_unique_abbrev
Date: Wed, 16 Sep 2015 10:15:02 +0200
Organization: gmx
Message-ID: <c62ef479c559cb040628fc4ede5b151b@dscho.org>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915152629.GH29753@sigill.intra.peff.net>
 <55F84D9B.90004@ramsayjones.plus.com>
 <20150915175027.GA31091@sigill.intra.peff.net>
 <xmqqh9mvtai5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 10:15:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc7sb-0001Uk-Cd
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 10:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709AbbIPIPm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 04:15:42 -0400
Received: from mout.gmx.net ([212.227.17.22]:55777 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbbIPIPh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 04:15:37 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LtVLE-1YdnYb1Ayy-010wJx; Wed, 16 Sep 2015 10:15:05
 +0200
In-Reply-To: <xmqqh9mvtai5.fsf@gitster.mtv.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:E6fnBAbjOOmbqVkKE5TaIGrf3eEr4WHKK+Cya35GCRRA1G4aw+7
 LKxavAZY0et6TMzDIM8ziAU5jBlwNXtbNyapyHkS8Oh94dG8jCR8kIafv0QPtEjF4RNflqr
 XehRb5FV0X8L6cA4I6PKHUC9L75P9ZFTT0Z1VZwSp2Ewi6P/uLkw5MxNa4fGG0zwDXv2ANn
 eAxr/9PZDNqleF74QPZkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TCi/huM5GzY=:JvG7GbbXmeByITq0CAY2CK
 B/GzBjs/jzLxZ2GgEs9ibbzk4uuyFUuyYWP8K/WqUAVgqMCQJoFwslQERenTS058qEkJbR/Gr
 kXtxMg0/00nglX/DUco1NuVedJusLGTqCJPqV8yYM4gafK6dbd866PRsG6Rf5IComqjkgfqpT
 or7Vm2AR7AFrmFmY95bTYwTosheU/XjtwdMxXcbOrjNXHYRveziGzfo37ltnJbMoDAngDo3BH
 soT11o5KXwarMw+93zd9r1Mu+tv4EFS8/xXShfMpqVxg6A9Yvv2+B+A8uJkKETtxpho5buuAc
 7ZlvaJC4xzzKcq11x1Ijg6CSh/0L6HAZOY7wV2O3x3YxKEMMj0p0qKb0xWD5EwdKTSsaGr/OO
 VSCDrIWjAdQgv2uGzjVaj1Du9OdGq0mmlgNaT8+OqIof9sUyZTLqCSIYJfzpVWNP02eGaR08G
 YoKgDyQkwWZ2HmG4S6i2ncltfMtRFB857Efdw1kvteK4mXeuzj69hBetBI8pGQj6iow8inbof
 UhvpCOJFZXme1lZkyuOJ/POrU8ClP64XXYZnczitaxw5H6Or02/mWLEO+YEIw+VuRFniXvqr2
 mqWrlx0yecISLizzEXSwaXti8f2lSSLdNHNyr7Vnq1V5d846gCMUaXptqBh9Sc9LiOZNgf+9k
 9Wa6BUFJbRWTAtcj86Lr9mjGaw5PpzvmZE8976T+nN+THbMOLMMqgvGBAS0RZWEGk1GwNjugR
 xANGig/Ob/AhiRPW1uh7J0+jGOH6yJPcVnCeJQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278007>

Hi Junio, Jeff & Ramsay,

On 2015-09-16 03:32, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>>> Hmm, I haven't read any other patches yet (including those which use these
>>> new '_to' functions), but I can't help feeling they should be named something
>>> like 'sha1_to_hex_str()' and 'find_unique_abbrev_str()' instead.  i.e. I don't get
>>> the '_to' thing - not that I'm any good at naming things ...
>>
>> I meant it as a contrast with their original. sha1_to_hex() formats into
>> an internal buffer and returns it. But sha1_to_hex_to() formats "to" a
>> buffer of your choice.
> 
> I think that naming makes perfect sense.

I have to admit that I needed the explanation.

Maybe we should stick to the established practice of the many, many reentrant POSIX functions following the *_r() naming convention? I.e. the reentrant version of localtime() is called localtime_r(), the reentrant version of random() is called random_r() etc.

So I could see myself not needing an explanation if I had read sha1_to_hex_r(...).

Ciao,
Dscho
