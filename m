From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Sun, 9 May 2010 00:49:34 +0400
Message-ID: <20100508204934.GA25566@dpotapov.dyndns.org>
References: <alpine.LFD.2.00.1005071240590.901@i5.linux-foundation.org>
 <g2s32541b131005071258s92e058bakc8f3a4df1e1dc634@mail.gmail.com>
 <alpine.LFD.2.00.1005071303040.901@i5.linux-foundation.org>
 <alpine.LFD.2.00.1005071306190.901@i5.linux-foundation.org>
 <576B55DC-C92D-4FEB-B4E8-4A042D6F024B@gmail.com>
 <alpine.LFD.2.00.1005071355380.901@i5.linux-foundation.org>
 <384AA932-227B-43B0-9D38-560A3567918A@gmail.com>
 <alpine.LFD.2.00.1005071421340.901@i5.linux-foundation.org>
 <m2z32541b131005071430vcd851ac8yd3c783429a84f875@mail.gmail.com>
 <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	hasan.aljudy@gmail.com, kusmabite@googlemail.com, prohaska@zib.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 08 22:49:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAqy2-0002L7-Bs
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 22:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab0EHUtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 16:49:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:8750 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab0EHUtj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 16:49:39 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1139032fga.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 13:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=P6NkNq/H7TWr/6gTEsjaqTZwXTPkTYXsACCoDf2A17c=;
        b=ZXEkpdGkrjb8DAbCxHaEqNIvXUanZGH/A+0uzOUAWXIaiGmsNvEq7pe0ROR1x+De/P
         DdEr4IVblvyp7z6bZYTR3/Q1dK4tYqLOoyrI++gs8k6isrxvn+Dh/6OP8DRcHZYieeKg
         aqvxbtcNTTFdyMqxLfV7zI7GiD7nITD/OqnLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bWcUjHKu8rIM4rm06P+uHUR0z7rboTS/x7/k4gK2YPf7grXOVFmNS5GlH4Yx1OSvRO
         d0SmYigOWngHxZA9/LaG/bLhDuCpCqGdsCR1z84sPWh8E8k9cF1pL4/blIsJf1BW3YeX
         0YWpTEQbL1h0k2UFrnzGPfvUv8cxypM4DKC2o=
Received: by 10.103.80.5 with SMTP id h5mr994377mul.82.1273351778019;
        Sat, 08 May 2010 13:49:38 -0700 (PDT)
Received: from localhost (ppp85-141-234-94.pppoe.mtu-net.ru [85.141.234.94])
        by mx.google.com with ESMTPS id u26sm13798229mug.25.2010.05.08.13.49.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 13:49:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005071441341.901@i5.linux-foundation.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146672>

On Fri, May 07, 2010 at 02:54:40PM -0700, Linus Torvalds wrote:
> 
>  (a) you should try to avoid do things like that in the first place. For 
>      something like an attribute file, you should just list the files you 
>      want to convert. That's the _point_ of an attribute. So it's much 
>      nicer if you instead actually are explicit about it, ie
> 
> 	*.[ch] crlf
> 	*.txt crlf
> 	*.jpg -crlf
> 
>      should be the _primary_ way you do it, since the autocrlf thing is a 
>      bit dangerous in theory.
> 
>  (b) But let's say that you want to do it anyway (because you're lazy 
>      and because autocrlf works pretty damn well in practice), isn't that 
>      a really ugly and crazy thing to add _another_ attribute name for 
>      that?
> 
>      IOW, if you really want to say "do automatic crlf for this set of 
>      paths", the natural syntax for that would be
> 
> 	* crlf=auto
> 
>      No? Not some totally new attribute name.

I like your proposal and it makes perfect sense to me, but I am not new
to git and core.autocrlf. I have observed that many people who were new
to Git often got confused by meaning of the crlf attribute. In essence,
at first, they thought that it means what you would probably describe as
crlf=force. Thus, seeing something like this:

    *.sln -crlf

baffled them, because sln files have CRLF as ending. So, it was very
counter-intuitive for them. Of course, you can explain that Git stores
text files with LF internally, and why it is the sane thing to do, and
why sln files are not exactly text files (at least, non-text in sense
of eol-conversion), etc... but I believe that all those discussion and
explanation could be easily avoided by renaming 'crlf' as 'eol'.  Now,
if you look at this:

      *.sln -eol
      *.jpg -eol
      *.txt eol
      *.[ch] eol

it is clear that .sln and .jpg files are stored "as is", while Git does
the end-of-line conversion for others files in accordance with user's
preference. Why should users bother at all how Git stores text files
internally? They do not need to know that Git stores text files with LF
internally. They just want to checkout those files with the right ending
for their platform.

So, perhaps, 'eol' would be a better name than 'crlf' for new Git users.



Dmitry
