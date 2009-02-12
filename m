From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFH] How to review patches: Documentation/ReviewingPatches?
Date: Fri, 13 Feb 2009 00:45:57 +0100
Message-ID: <200902130045.59395.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 13 00:47:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXlHS-00025E-Ex
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 00:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759437AbZBLXqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 18:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759118AbZBLXqE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 18:46:04 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:45676 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753948AbZBLXqC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 18:46:02 -0500
Received: by fg-out-1718.google.com with SMTP id 16so319331fgg.17
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 15:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Iu6EYe6PNWIbHqGEiaDnA5jvLOu3hgDGHdAuTW9FuDs=;
        b=BzMJZ5B6rnudBESMqrkfrXLd0Q3v+5GsAOBYD2DxtQsHVm2GFczfQ8/f6Yv9xLHAyp
         Am2IMDP9QsrfaCcO1Jf1pUj2Bkm+HnxBiiMW0EL4teh1n9r962rojdT8twbUKMTYiHL8
         c8MCge9HDgjF3CLmVElBamfYvx3El+mKMDJdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=tdH9CHgUC0Ob/GrZ687L4GZVrLYigDPb+SOPY+vRKX5NaIhMyeBnsPejAwdUFvwyda
         6IX2queHa6mRyiECjfvBIiOXqDBE27fIL5ki2bNyWt9oy2yy86XgSbISrVzIQH80KxaU
         HJUOzrk/IV2XdFn6tCR4hkXIX0qxYyZ+e3dqc=
Received: by 10.86.78.4 with SMTP id a4mr557557fgb.64.1234482360576;
        Thu, 12 Feb 2009 15:46:00 -0800 (PST)
Received: from ?192.168.1.13? (abxc167.neoplus.adsl.tpnet.pl [83.8.252.167])
        by mx.google.com with ESMTPS id 12sm480299fgg.53.2009.02.12.15.45.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Feb 2009 15:46:00 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109683>

Thanks to Documentation/SubmittingPatches we have gathered in one place 
information and checklist on how to write good patches that have chance 
to be accepted.  Thanks to Documentation/CodingGuidelines we have 
gathered in one place guidelines to keep to the code (with the most 
important one "imitate the existing code" ;-)).  (And thanks to 
todo:MaintNotes we know how maintainer works...).

What I'd like to have is Documentation/ReviewingPatches to help with (at 
least technical side of) reviewing patches, which is very important but 
a hard work, c.f. http://www.kroah.com/log/linux/ols_2006_keynote.html

A few questions that it would be nice to have answered in proposed 
future document: 
 * who can add 'Acked-by:', and when it could be added
 * when one can (and should) add 'Tested-by:'.
 * when to resend patches, how long to wait for review,
   and when to send reminder (ping or resend, and when use which).

There is for example question whether (or when) to quote whole patch;
I think that for shorter patches it is better to quote them verbatim 
wholesame, even if you refer only to parts of it, or only have comments 
to the commit message.  But for longer patches I think it makes sense 
to quote selectively only the parts you are commenting on.

What about patch series? In my opinion if patch series has cover letter, 
and doesn't use chained replies (i.e. all patches are replies to cover 
letter), it leads to much more readable review discussion, but this 
might be just me.  Should one (if applicable) reply to cover letter 
first with the impressions on the patch series as whole?

In my last review I have put summary of status for each patch in series 
as reply to cover letter, in the shortlog for series (a summary of 
comments).  I think it is a good idea, and helps maintainer who doesn't 
have then to read individual responses (subthreads) carefully... so I 
guess it should be in Documentation/ReviewingPatches to make this 
practice more widespread.


The other side is advice for patch authors how to respond to reviewers 
comments... and warn them that they might be grumpy.  To give 
guidelines how to decide when reviewer is putting a request, giving an 
alternate solution (perhaps better, perhaps worse), and when he/she 
have doubts... or just makes idle discussion.


But perhaps such document (Documentation/ReviewingPatches) is not 
needed? Reviewers should know the code in question well, so they 
perhaps all are long-time contributors, and know all those rules by 
heart...
-- 
Jakub Narebski
Poland
