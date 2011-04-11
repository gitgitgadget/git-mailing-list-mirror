From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/9] Some more sparse patches
Date: Mon, 11 Apr 2011 19:21:13 +0100
Message-ID: <4DA34699.5080200@ramsay1.demon.co.uk>
References: <4D9DFF61.8090302@ramsay1.demon.co.uk> <4D9EB61B.6010302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 20:25:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9LoD-0001iO-PT
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 20:25:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261Ab1DKSZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 14:25:51 -0400
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:42684 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755258Ab1DKSZu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Apr 2011 14:25:50 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1Q9Lo5-00079o-XI; Mon, 11 Apr 2011 18:25:49 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4D9EB61B.6010302@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171347>

Stephen Boyd wrote:
> Yeah I was sitting on a few of these since I didn't have the time or
> effort to sort them out. Plus I have to wade through all the warnings
> that ULONG_MAX and LONG_MAX causes on my 64 bit system causing me to
> miss some things. Thanks for picking it up.

I've been thinking of getting a new laptop soon; when I do, I'll have to
face this myself. Until then I'm firmly in 32-bit land, so I'm afraid
that I can't help :-(

> I pulled these patches down and gave them a test. It looks good to me,
> except I see this when I check http.c:
> 
> $ make http.sp
>     SP http.c
> builtin:1:9: warning: preprocessor token GIT_HTTP_USER_AGENT redefined
> builtin:1:9: this was the original definition
> 
> Any ideas?

Hmm, sorry no. I'm not seeing this on any of my platforms. On Linux and
Cygwin sparse is silent, and on MinGW (which has NO_CURL defined BTW) I
see a few legitimate warnings, thus:

    $ make http.sp
        SP http.c
    http.c:806:25: warning: expression using sizeof on a function
    http.c:815:25: warning: expression using sizeof on a function
    http.c:1139:9: warning: expression using sizeof on a function
    http.c:1303:9: warning: expression using sizeof on a function

Again, these warnings are legit (they relate to an insane "inline"
optimization macro which uses sizeof on a function pointer).

ATB,
Ramsay Jones
