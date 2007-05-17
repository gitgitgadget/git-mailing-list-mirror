From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 08:51:25 +0100
Message-ID: <200705170851.26548.andyparkins@gmail.com>
References: <11793556363795-git-send-email-junkio@cox.net> <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 17 09:51:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hoam2-0003hY-6V
	for gcvg-git@gmane.org; Thu, 17 May 2007 09:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394AbXEQHvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 03:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754537AbXEQHvi
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 03:51:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:26365 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbXEQHvh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 03:51:37 -0400
Received: by ug-out-1314.google.com with SMTP id 44so280621uga
        for <git@vger.kernel.org>; Thu, 17 May 2007 00:51:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NFV/P5kq7fm2KAaQYcpeG+1ekjsq1u49QC/eov3cyoc3VYqTRtSr/UswCFgDaAvfC/dJ42XomUCIb3F8b9WDHi3Yrr72jxvANJe7hRBBhCVEWmaVEFgZVFsvuyNMTwWGCbglAfypXZwkf9DUL1l5bIzaB2KUZeJI7QCVg5OY/30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=p23i2NFIw/inA04jSOCWlP8BpkkRhGXVJhbZxXvLeNSx+uSZWugIgptsDpDu9dbk0K3Jir03bWLneBldyNdYzIFXH5WRGJDTKDQ375p28W8u7tdm80OMcPdxeyB4aKgTnQraKQr6ikiP9KhzzqMZ7Mc8IMx6iQBONoLnsUHDdO8=
Received: by 10.67.32.16 with SMTP id k16mr71370ugj.1179388291180;
        Thu, 17 May 2007 00:51:31 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm65384ika.2007.05.17.00.51.29;
        Thu, 17 May 2007 00:51:30 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47506>

On Thursday 2007 May 17, Junio C Hamano wrote:

> I think that depends _WHY_ the URL recorded .gitmodules are
> updated.  It would perfectly be reasonable for release #1 of an
> appliance project to bind linux 2.4 tree at kernel/ subdirectory
> while release #2 source to have 2.6 one; they come from two
> different repository URLs.  When you seek the superproject back
> to release #1, you would still want to fetch from 2.4 upstream
> if you are updating.

That's a very good point; I hadn't considered that there was a case for 
recording a change.

> What I was "handwaving" (or "envisioning") was to have something
> like this in .gitmodules:

Sorry, "handwaving" was a bit rude - I certainly didn't mean that you weren't 
supplying sufficient detail for the circumstance; I meant that in the sense 
of the tricky bits being papered over with user overrides and questions about 
which URL to /really/ use.  The fact that you even felt it necessary to 
mention those overrides signals, I think, that something is wrong.

> 	[subproject "kernel/"]
>         	URL = git://git.kernel.org/pub/linux-2.4.git
>
> (or 2.6, depending on the revision of the superproject) and per
> repository configuration would maps this with these two entries:

So now - running with your example - I'm in a project with a 2.6 URL 
in .gitmodules and config; now I check out a past revision.  .gitmodules is 
updated to show the URL at that time (2.4) - what happens to config, which 
must have higher precedence?  Am I meant to update that myself?  So, as I hop 
around between branches you expect that I will be updating the config file 
for each checkout?

> 	[subproject "git://git.kernel.org/pub/linux-2.4.git"]
>         	URL = http://www.kernel.org/pub/linux-2.4.git
>
> 	[subproject "git://git.kernel.org/pub/linux-2.6.git"]
>         	URL = http://www.kernel.org/pub/linux-2.6.git

Now this part I love.  _That_ is a proper solution.  To me though, these are a 
completely different category from the [subproject] above.  I think that 
should be highlighted with a different section name like "[urlmap]".
     
> The intent is
>
> 	(1) "kernel/" directory is found to be a gitlink in the
>             tree/index; .gitmodules is consulted to find the
>             "URL", which is just a handle and the initial hint

In which case that [subproject "kernel/"] section is not needed (I think it 
would be better to simply say "URL not found for submodule kernel/" or 
something if there is no .gitmodules rather than supplying that override).

> 	(2) That "initial hint" is used to look up the
>             subproject entry from the configuration, to find the
>             "real" URL that is used by this repository

Yes.  Excellent; the "hint" now becomes a lookup key into the url mappings.

> which hopefully is already answered by the above handwaving ;-).

Absolutely.  I'm very impressed.  It solves both the temporal and spatial 
changes problem because one can remap every URL that was ever used in the 
history of the .gitmodules file if one wanted.

> in your .git/config.  After the repository migrates to
> git.sf.net, you would update that existing entry and also add
> another entry, so that .git/config would have these two entries:
>
> 	[subproject "git://git.or.cz/sub.git"]
>         	URL = git://git.sf.net/sub.git
>
> 	[subproject "git://git.sf.net/sub.git"]
>         	URL = git://git.sf.net/sub.git

I don't suppose the second one is needed; wouldn't the default be $key = $url, 
when no override is found?

This also raises the point that these mappings would probably be 
order-dependent; because it may be that I want to do:

  [subproject "git://git.or.cz/sub.git"]
    URL = git://git.sf.net/sub.git

  [subproject "git://git.sf.net/sub.git"]
    URL = /home/andyp/git/mycopyofsub.git

In conclusion: I think that's a first class solution to the problem (and 
probably what you had in mind all along, and me screaming around wasn't 
helpful :-)).



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
