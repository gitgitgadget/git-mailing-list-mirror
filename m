From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] diff-cache path restriction fix.
Date: Wed, 25 May 2005 10:07:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505250948340.2307@ppc970.osdl.org>
References: <7vu0ksrv1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505241757280.2307@ppc970.osdl.org> <7vekbwru6x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505241814220.2307@ppc970.osdl.org> <7v3bscqdlr.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0505242002340.2307@ppc970.osdl.org> <20050525090616.GB27025@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 19:07:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DazIk-0000WW-2Q
	for gcvg-git@gmane.org; Wed, 25 May 2005 19:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbVEYRFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 13:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbVEYRFj
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 13:05:39 -0400
Received: from fire.osdl.org ([65.172.181.4]:25484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261479AbVEYRF1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 13:05:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4PH5HjA006513
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 25 May 2005 10:05:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4PH5Gi0003867;
	Wed, 25 May 2005 10:05:17 -0700
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050525090616.GB27025@elte.hu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 25 May 2005, Ingo Molnar wrote:
>
> Like it or not, most of the code reading we do is all automatism, if we
> had to _think_ about the visual structure of the code we'd be much less
> effective.

Absolutely. And you _should_ like it, because it means that you can 
concentrate on the big problems.

I suspect I react more strongly to some coding style issues than most, 
exactly because I've been so involved with just one language and one style 
for so long that I've got more of an auto-pilot than most: normally my 
brain just coasts past 99% of all code, without having to be very 
conscious about it at all, exactly because the patterns have become so 
ingrained.

In contrast, somebody who works on different projects and with many
different languages is likely to have many more patterns, but they are
probably less deep, so breaking them isn't as disturbing.

>             But if someone has a strong math background (Junio?) then
> the "1 < x < 5" syntax could be the natural thing he got used to.

Actually, even in math (in fact, very _much_ in math) I'd say that people
always aim to put the variable on the left side, and you very much tend to
try to aim for canonical formats (sort by exponent and variable name). 
You'd never see anybody write "y + x = 5" or "x + x^2", because there's a 
canonical format for it, and people use it.

The "1 < x < 5" syntax is very much the odd man out, and that order for
the first part is _only_ used for two-sided comparisons afaik. Math people
(at least all math texts I've ever seen, and I had math as a strong minor
although admittedly that is some time ago) will invariably write the
variable on the left side if there's just one comparison.

In fact, in math, I'd expect a person to often tend to take the canonical
format even further, and sort _everything_ to the left side, and aim to
leave the right side totally empty (ie "0"), exactly because that makes
certain combinations much easier. So it wouldn't surprise me at all to see
a math person change "x > 1" into "x - 1 > 0", but it _would_ surprise me
to see a math person change it into "1 < x" unless it is to combine it
with _another_ comparison with "x".

				Linus
