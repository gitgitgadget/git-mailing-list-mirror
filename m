From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow trees
Date: Mon, 16 Apr 2007 21:55:23 +0100
Message-ID: <200704162155.25114.andyparkins@gmail.com>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> <200704161003.07679.andyparkins@gmail.com> <7vwt0crts2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 18:52:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdquq-00039W-2t
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 18:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031181AbXDQQwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 12:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031182AbXDQQwZ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 12:52:25 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:61441 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031181AbXDQQwW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 12:52:22 -0400
Received: by ug-out-1314.google.com with SMTP id 44so216303uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 09:52:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dhDQnOsx9Ou84Rvdagf5UnSXWknvAr8xFiBSaQtuCPnwRCWcYTMn8og1cfWUoKh9yQs2lEVWUrxUcf3v2do2kzTP618oSGn1jiobOM4zuMS2CwMrPaY7q3ufvekuL+fZmsS0HqfldaAjR41KOiNCl2yhNudQNebq9wEUtQsa5hM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Naink1oxg1WkcWv/AaVwptbRHl3c7qTuLH+GhUXhC+ie56lFDvGTHmT5hrC/9zpydPi1hAQvvRM3jmzht8zBq0x7jbNdMHTL5P+FdxmjsotAGTXNq8Wnwygtqj9x5HojVvcFy6CetmRLR6jtnF5fQ6CG+UTpAUXUYJ8ZOdR5N2I=
Received: by 10.67.22.2 with SMTP id z2mr615593ugi.1176828741063;
        Tue, 17 Apr 2007 09:52:21 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id 59sm1394200ugf.2007.04.17.09.52.19;
        Tue, 17 Apr 2007 09:52:19 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <7vwt0crts2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44796>

On Monday 2007, April 16, Junio C Hamano wrote:

> In your workflow, when do you "print"?

After a save and commit.  Otherwise - as you point out, the id is wrong.

> the final "cvs diff" would say you have such and such changes to
> the drawing file you just printed since the checked-in version.
> However, doesn't "$Id: ... $" embedded in the printed copy say
> it is from the last checked-in version?

Yep.  You will get no argument from me that keywords are by no means 
definitive.

> Is inkscape aware of the "$Id: ... $" keyword and modifies such
> string by munging it to "$Id: ..., modified $", once you make a

Nope.  Inkscape knows nothing about the expansion.  However, even if I 
wasn't careful to only print out checked in files, it would still 
narrow down the possible versions to one of two.

> local modification to the document?  Otherwise you cannot tell
> if the printed copy is pristine and match what the $Id$ keyword
> claims it is.

Correct.  Every user of keywords is aware that the keyword doesn't 
update all the time - in fact there's nothing to stop you changing the 
keyword yourself to an utter lie.  I think the assumption is that you 
aren't fighting your own tools though.

> Or maybe in your workflow, such a local modification may not
> actually matter because you made a habit of not making a drastic
> edit before printing.

Yep.

> Or perhaps maybe you never print a locally modified copy.

Yep.  In fact, for me, most of the time I'm printing a diagram that was 
checked in a number of revisions ago.  It's not the case that I 
modify-print.  However, that's just me.

> Does Inkscape have a batch mode operation?  It might be an
> option to have something like this in the Makefile if it does (I
> do not know if it does, and if so what the syntax is, so this is
> totally made up):

I think it does as it happens; and your little script is just the sort 
of thing I will use when I get around to fixing this hole.

However, it's missing the point to take my example as an unsolved 
problem - there are plenty of ways I can get what I want; I brought it 
up merely as a counter to the statement that there were no valid 
situations for wanting keyword expansion.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
