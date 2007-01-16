From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [RFC] Git config file reader in Perl (WIP)
Date: Tue, 16 Jan 2007 23:17:46 +0100
Message-ID: <dbfc82860701161417r650bc47fva92fa940b4e2cfc0@mail.gmail.com>
References: <200701150144.56793.jnareb@gmail.com>
	 <7vwt3nxnak.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.63.0701161206050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <200701161514.47908.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Junio C Hamano" <junkio@cox.net>,
	"Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 23:18:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6wdS-0004Av-2X
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 23:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbXAPWRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 17:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbXAPWRu
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 17:17:50 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:5176 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbXAPWRt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 17:17:49 -0500
Received: by nf-out-0910.google.com with SMTP id o25so14102nfa
        for <git@vger.kernel.org>; Tue, 16 Jan 2007 14:17:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=PDvPpMgl/HWhwRFFQ4Groe8MD90hLLfyoaoSAGxWVU6efM6tzifJQNQmjx/35KiJQO1Ws7fiikYGrREg9NgbD0ugRMdBMgDIONPkFEzi+oU8y0DkTTNByev8G12uaPolzb+dF5MBzXZEebuYJy9g1IpVlxYHpCLYgswSII7im0s=
Received: by 10.78.201.2 with SMTP id y2mr843193huf.1168985867076;
        Tue, 16 Jan 2007 14:17:47 -0800 (PST)
Received: by 10.78.200.7 with HTTP; Tue, 16 Jan 2007 14:17:46 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <200701161514.47908.jnareb@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 81937e54151c69bb
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36972>

On 1/16/07, Jakub Narebski <jnareb@gmail.com> wrote:
> Johannes Schindelin wrote:
>
> > On Tue, 16 Jan 2007, Junio C Hamano wrote:
> >
> >> "Nikolai Weibull" <now@bitwi.se> writes:
> >>
> >>> If we're going down this slippery slope, why not just give up and add
> >>> a --xml switch instead?  Readable by all...
> >>
> >> Perhaps all except humans.
> >>
> >> At least YAML, please...

> > P.S.: The more I think about it, we should just use the output of
> > "repo-config -l".

> It wouldn't work. Subsection and value are (almost) free form, and
> they can contain '=' in them.

Sadly, yes.  It would be very nice if -l gave unambiguous output for
all cases, but perhaps -l is more for parsing by people than by seds.

> But I agree that XML is serious overkill...

I don't know if it was clear from my first mail, but I wasn't
suggesting --xml as a serious alternative.  My point was that if we're
going to go through all the fuss of adding all these switches for
outputting the configuration file in some fixed format, why not go
with one that at least is universal in some sense (not necessarily
XML).  And, as Johannes already pointed out, it's very disturbing
having to dump a configuration file so that it is more easily read by
other programs.  That would suggest that the ini-based format for
git's configuration file is suboptimal.

Of course, once git is librified (which is still a long-term goal,
right?), languages could create bindings to the git library, which
would provide access functions to the configuration file.  Then we
would truly have that one parser to rule them all.

  nikolai
