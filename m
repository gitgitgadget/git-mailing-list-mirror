From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 02:21:02 +0300
Message-ID: <20080121232102.GG14871@dpotapov.dyndns.org>
References: <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <20080121205615.GY14871@dpotapov.dyndns.org> <DEC058ED-EBF0-4A1E-BF7B-448B16DBBD6E@sb.org> <20080121224131.GD14871@dpotapov.dyndns.org> <DC78D5CB-18FF-4504-BD8B-985D8B202817@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:22:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5y0-0007Ez-6S
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 00:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761554AbYAUXVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 18:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761849AbYAUXVJ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 18:21:09 -0500
Received: from smtp02.mtu.ru ([62.5.255.49]:57217 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761832AbYAUXVH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 18:21:07 -0500
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 6E54C3147C;
	Tue, 22 Jan 2008 02:21:01 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-102.pppoe.mtu-net.ru [85.141.188.102])
	by smtp02.mtu.ru (Postfix) with ESMTP id 1ECC0313F5;
	Tue, 22 Jan 2008 02:21:01 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JH5ws-0008NJ-49; Tue, 22 Jan 2008 02:21:02 +0300
Content-Disposition: inline
In-Reply-To: <DC78D5CB-18FF-4504-BD8B-985D8B202817@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71373>

On Mon, Jan 21, 2008 at 05:53:50PM -0500, Kevin Ballard wrote:
> 
> I would go look up specifics to back me up, but my DNS is screwing up  
> right now so I can't access most of the internet.

Then you are lucky that your mails reach this ML without problem.

> In any case, there  
> are 4 standard normalization forms - NFC, NFD, NFKC, NFKD. If there  
> are others, they aren't notable enough to be listed in the resource I  
> was reading. HFS+ uses a variant on NFD - it's a well-defined variant,  
> and thus can safely be called its own normalization form. I fail to  
> see how this means it's not "normalization".

The defining property of normalization is producing binary identitical
strings for equivalent strings, IOW, normalization allows you to tell
what strings are equivalent and what are not just by binary comparision.
HFS+ decomposition lacks that property, because strings are not fully
decomposed thus being comparision of equivalent strings may give false
result.

> 
> I'm not talking about assigning engineers, I'm saying developing a new  
> filesystem, especially one that's proven itself to be usable and  
> extendable for the last decade, is something that only smart engineers  
> would be capable of doing.

You know, many people still use FAT, but somehow I don't think that
FAT is good despite of it being extendable for more than a decade...
Apparently, HFS+ was not worst part of the Copland project, but I
see no evidence to think that it was developed by the best engineers.


> >>And
> >>Copland didn't fail because of stupid engineers anyway. If I had to
> >>blame someone, I'd blame management.
> >
> >But if the code was so good then why was most of that code thrown away
> >later when management was changed? Still bad management?
> 
> Yes. Even the best of engineers will produce crap code when overworked  
> and required to implement new features instead of fixing bugs and  
> stabilizing the system. 

I don't think that anyone asked them to implement so much new features.
AFAIK, it was very difficult (nearly impossible) to get anyone to work
on stabilizing existing software and fixing existing bugs in it.

> Copland is well-known to have suffered from  
> featuritis, to the extent that it was practically impossible to test  
> in any sane fashion.

Exactly. IMHO, both management and developers are equally responsible
for that feature-mania.

> Bad management can kill any project regardless of  
> how good the engineers are.

Sure.

> >Byte sequences are not an issue here. If the filesystem used UTF-16 to
> >store filenames, that would NOT cause this problem, because characters
> >would be the same even though bytes stored on the disk were different.
> >So, what you actually lose here is the original sequence of  
> >*characters*.
> 
> I've already talked about that, but you are apparently incapable of  
> understanding.

Well, it is *you* who is incapable of understanding anything, even
basic terms as encoding and normalization...

Dmitry
