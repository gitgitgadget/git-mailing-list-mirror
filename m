From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 2 Mar 2007 22:21:30 +0000
Message-ID: <200703022221.38309.andyparkins@gmail.com>
References: <200703011206.47213.andyparkins@gmail.com> <200703021937.33648.andyparkins@gmail.com> <Pine.LNX.4.64.0703021249010.3953@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 23:24:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNGB4-0003EP-T0
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 23:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030636AbXCBWYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 17:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030630AbXCBWYd
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 17:24:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:2754 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030636AbXCBWYc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 17:24:32 -0500
Received: by ug-out-1314.google.com with SMTP id 44so832372uga
        for <git@vger.kernel.org>; Fri, 02 Mar 2007 14:24:30 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=taN95GEb/51Co2kAbJLYKC5FH6Bo5XeFqbhht+sP54WjS0iL2tnS43wL2cmB7YtaFHJV0m+jUT0omt3/1x7ejztcFk9zgMkHDPoSH9k3H7nMt4HitCrsx8FojpwWRRstqesQT6rt44kt8CQoW6SwNiOFkxAQwrGou4i7WknHJyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=FWnwwGM9h0n/jjerc2AH/j0/IOOMiy+S7EDfMXLKQSmlbK1pzIsunFl/XkAcANa0OhjH9/B3NHAAwKe1hMHlS4yzezMO8Di6BvkUkTn2XGhW0XuQmvPRqTAJ6vjosrixaLRnKfW9pSEU2Y+rq2VyC0X3WpW4W+JOo9hCzxmZQUM=
Received: by 10.67.97.7 with SMTP id z7mr3931430ugl.1172874270340;
        Fri, 02 Mar 2007 14:24:30 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id u6sm3585710uge.2007.03.02.14.24.27;
        Fri, 02 Mar 2007 14:24:27 -0800 (PST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0703021249010.3953@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41254>

On Friday 2007, March 02, Linus Torvalds wrote:
> On Fri, 2 Mar 2007, Andy Parkins wrote:
> > On Friday 2007, March 02, Linus Torvalds wrote:
> > > Yes. How about just having the built-in git pager do the right
> > > thing?
> >
> > Perfect.  This is absolutely the right thing to do I think.
>
> Well, it would be perfect, except it's rather hard to do. Right now
> we simply don't have any way to tell the pager what to do with the
> data, and we'd need to do some communications passing thing to let it
> know.

There is an alternative.  pager.c:run_pager() runs a select() to wait 
for data before it actually exec()s the pager.  What if after the 
select() the process didn't exec(), but read the first line to decide 
what pager to exec?

Then, when pager_in_use is true, the sending process writes, say, a 
handler identifier which tells the pager process what to exec().



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
