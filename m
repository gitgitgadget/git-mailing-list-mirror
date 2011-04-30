From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] t0081-*.sh: Fix failure of the 'long read' tests
Date: Sat, 30 Apr 2011 18:25:13 +0100
Message-ID: <4DBC45F9.7090804@ramsay1.demon.co.uk>
References: <4DB70972.20308@ramsay1.demon.co.uk> <20110426234850.GC32491@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 30 19:29:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGDzM-0000t0-0u
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 19:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758004Ab1D3R3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Apr 2011 13:29:47 -0400
Received: from anchor-post-2.mail.demon.net ([195.173.77.133]:57841 "EHLO
	anchor-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751334Ab1D3R3q (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2011 13:29:46 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1QGDxL-00010q-lG; Sat, 30 Apr 2011 17:27:48 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20110426234850.GC32491@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172524>

Jeff King wrote:
> Yeah, that syntax is handled just fine by my bash and dash:
> 
>   $ cat >foo.sh <<'EOF'
>   i=1
>   : $((i = $i + 1))
>   echo $i
>   EOF
> 
>   $ bash foo.sh
>   2
>   $ bash --version | head -n 1
>   GNU bash, version 4.1.5(1)-release (x86_64-pc-linux-gnu)
> 
>   $ dash foo.sh
>   2

Er, ... yeah, it works for my bash and (up-to-date) dash too!
[not the installed dash, of course, for which it is a syntax error]

Ahem ... *blush*

> But I think your i=$(($i + 1)) is the right solution.

Yes, this fixes the problem and does not introduce a regression.

So, the patch is correct, but (apart from the last sentence) the
commit message is *absolute rubbish*. I won't bore you with the
details of my lunacy! :-P

However, I much prefer Jonathan's patch which removes this test
completely!

ATB,
Ramsay Jones
