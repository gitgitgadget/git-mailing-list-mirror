From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Fri, 07 Sep 2007 13:54:55 +0200
Message-ID: <46E13C0F.8040203@op5.se>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <D7BEA87D-1DCF-4A48-AD5B-0A3FDC973C8A@wincent.com> <46E0EEC6.4020004@op5.se> <Pine.LNX.4.64.0709071155570.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Wincent Colaiuta <win@wincent.com>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 07 13:55:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITcQW-0005Rg-LX
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 13:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbXIGLzD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 07:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbXIGLzB
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 07:55:01 -0400
Received: from mail.op5.se ([193.201.96.20]:44798 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965244AbXIGLzA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 07:55:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 0DEBC1943F2;
	Fri,  7 Sep 2007 13:54:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fRcGG4AL7991; Fri,  7 Sep 2007 13:54:57 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 00910194040;
	Fri,  7 Sep 2007 13:54:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <Pine.LNX.4.64.0709071155570.28586@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58031>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 7 Sep 2007, Andreas Ericsson wrote:
> 
>> Wincent Colaiuta wrote:
>>> El 7/9/2007, a las 2:21, Dmitry Kakurin escribi?:
>>>
>>>> I just wanted to get a sense of how many people share this "Git should
>>>> be in pure C" doctrine.
>>> Count me as one of them. Git is all about speed, and C is the best choice
>>> for speed, especially in context of Git's workload.
>>>
>> Nono, hand-optimized assembly is the best choice for speed. C is just
>> a little more portable ;-)
> 
> I have a buck here that says that you cannot hand-optimise assembly (on 
> modern processors at least) as good as even gcc.
> 


http://www.gelato.unsw.edu.au/archives/git/0504/1746.html

I win. Donate $1 to FSF next time you get the opportunity ;-)

Hand-optimized asm is faster because the optimizer in the compiler is a
general-purpose one that has to guess and make assumptions about the code
and its input to make the correct decisions. While it gets things right
in as many as 80% of the cases, there's still the 20% where it doesn't.
A human can, with sufficient research and effort, make the same optimizations
where they are correct but avoid the 20% erroneous ones.

If the compiler gets it wrong inside your innermost loop, it might be worth
shaving those extra 0.0001 seconds off of each iteration, because in the long
run, world-wide, it might save several weeks worth of CPU-time every day.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
