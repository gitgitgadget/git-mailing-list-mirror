From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn error: RA layer request failed: PROPFIND request
	failed on '/svn/stf/branches/dev/sw%2Fdpemu%2Finclude%2FNetCnxn.h':
Date: Sat, 25 Jul 2009 02:36:33 -0700
Message-ID: <20090725093633.GA15880@dcvr.yhbt.net>
References: <138905EB75AB0D44B6A0ECD251A92EA7011BA99E@sdra00198.intranet.dra-inc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Timothy Schaeffer <tschaeffer@dramail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 11:36:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUdgP-0008Du-WB
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 11:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbZGYJgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 05:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbZGYJgl
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 05:36:41 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43715 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751088AbZGYJgl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 05:36:41 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 6819B1F4E8;
	Sat, 25 Jul 2009 09:36:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <138905EB75AB0D44B6A0ECD251A92EA7011BA99E@sdra00198.intranet.dra-inc.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123999>

Timothy Schaeffer <tschaeffer@dramail.com> wrote:
> Git-svn has been giving me the following error for some time when calling "git svn dcommit":
> 
> RA layer request failed: PROPFIND request failed on '/svn/stf/branches/dev/sw%2Fdpemu%2Finclude%2FNetCnxn.h': 
> PROPFIND of '/svn/stf/branches/dev/sw%2Fdpemu%2Finclude%2FNetCnxn.h': 
> 302 Found (https://oursvnrepo.net) at /usr/local/libexec/git-core/git-svn line 508
> 
> This only occurred when git detected a rename or copy.
> 
> Following the lead into git-svn.perl, 
> and noticing that some of the '/'s in the path were hex-encoded 
> and some were not, 
> I changed the regex used to find chars 
> to hex-encode in the relative part of the path 
> to exclude '/'.  
> It works, so far.  
> I have included a patch.

Hi Timothy,

Thanks for the bug report and patch, i'll push it out shortly.  I'm
curious, do you happen to know which version of Subversion the server
was running?  I'm unable to reproduce the problem, but I wouldn't be
surprised if it's only a problem with newere versions.  Thanks.

-- 
Eric Wong
