From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Another bench on gitweb (also on gitweb caching)
Date: Wed, 13 Feb 2008 13:17:46 +0100
Message-ID: <200802131317.48815.jnareb@gmail.com>
References: <20080210030919.GA32733@c3sl.ufpr.br> <20080213004528.GB31455@c3sl.ufpr.br> <1202864493.17207.24.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>, git@vger.kernel.org
To: "J.H." <warthog9@kernel.org>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Feb 13 13:18:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPGZV-0008S5-4I
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 13:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464AbYBMMSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 07:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755168AbYBMMSE
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 07:18:04 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:33854 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbYBMMSC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 07:18:02 -0500
Received: by ug-out-1314.google.com with SMTP id z38so725052ugc.16
        for <git@vger.kernel.org>; Wed, 13 Feb 2008 04:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=B0SpmhndYHwClVWCMH5jyev3awZBw5vl/yDSu5hTH/o=;
        b=gLBgvfDN+/BbpfyPDadyNMlfnsV0OM/sEtc3KS8fKWE2xktFJoDziDNprsgFrLJDNyeksjiyLhujO/RxlS1QQycKxg6/Ml/tFY9SoHyu97cPieO6lfpazQXKDZx7QppQdjIrSqNnSwEN60amOh867FTXism1aCqI7dNyVS/8S6w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=E7JzbKXJtGQgM7EDcRFx3xXT8qjRGv2DJx4PI+eTIM2iQHh2yaISEZK+q/ax+fc7/oNVpNYtODmJoJULvwPlqvChwIBbXqcFqKKjYn9/8/czGo9ausknGzxghbE5wUxliwYPksUSw834p+2BFlI2xqd60yFQiKNxsLNeFlLGyWI=
Received: by 10.78.186.9 with SMTP id j9mr4752117huf.24.1202905076962;
        Wed, 13 Feb 2008 04:17:56 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.196.88])
        by mx.google.com with ESMTPS id v30sm612522hub.26.2008.02.13.04.17.53
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Feb 2008 04:17:54 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <1202864493.17207.24.camel@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73780>

On Wed, 13 Feb 2008, J.H. "Warthog9" wrote:
> Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:
>> On Mon, Feb 11, 2008 at 04:44:23PM -0800, Jakub Narebski wrote:

>>> Kernel.org even run modified version of gitweb, with some caching
>>> support; Cgit (git web interface in C) also has caching support.
>> 
>> Is this gitweb version for kernel.org available somewhere?
>> 
> 
> It's available from my git tree on kernel.org
> http://git.kernel.org/?p=git/warthog9/gitweb.git;a=summary
> 
> or
> 
> git://git.kernel.org/pub/scm/git/warthog9/gitweb.git
> 
> Mind you my performance on the non-cache state is not going to be any
> better than normal gitweb, however the performance on a cache-hit is
> orders of magnitude faster - though at a rather expensive cost - disk
> space.  There is currently something like 20G of disk being used on one
> of kernel.org's machines providing the cache (this does get flushed on
> occasion - I think) but that is providing caching for everything that
> kernel.org has in it's git trees (or 255188 unique urls currently).  My
> code base is now, horribly, out of date with respect to mainline but it
> works and it's been solid and reasonably reliable (though I do know of
> two bugs in it right now I need to track down - one with respect to a
> failure of the script - and one that is an array out of bounds error)

BTW. did you consider using cgit (C/Caching git web interface) instead
or in addition to gitweb? Freedesktop.org uses it side by side with
gitweb. I wonder how it would perform on kernel.org...

(Almost) every optimization should begin with profiling. Could you tell
us which gitweb pages are most called and perhaps which pages generate
most load for kernel.org? How new projects are added (old projects
deleted)? Do you control (can add to or can add multiplexing) to update
or post-receive hooks?

Without this data we could concentrate on things which are of no
importance. BTW. I wonder if slitting projects_list page would help...

-- 
Jakub Narebski
Poland
