From: "Timothy Schaeffer" <tschaeffer@dramail.com>
Subject: RE: git-svn error: RA layer request failed: PROPFIND requestfailed on '/svn/stf/branches/dev/sw%2Fdpemu%2Finclude%2FNetCnxn.h':
Date: Mon, 27 Jul 2009 09:44:18 -0400
Message-ID: <138905EB75AB0D44B6A0ECD251A92EA7011BAA76@sdra00198.intranet.dra-inc.net>
References: <20090725093633.GA15880@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <git@vger.kernel.org>
To: "Eric Wong" <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Jul 27 15:46:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVQXB-0000Yj-Lf
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 15:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347AbZG0NqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 09:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754114AbZG0NqM
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 09:46:12 -0400
Received: from dramail.com ([66.195.237.160]:54297 "EHLO
	sdra00198.intranet.dra-inc.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754044AbZG0NqM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 09:46:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20090725093633.GA15880@dcvr.yhbt.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-svn error: RA layer request failed: PROPFIND requestfailed on '/svn/stf/branches/dev/sw%2Fdpemu%2Finclude%2FNetCnxn.h':
Thread-Index: AcoNDf+brBCewIQRQDi68a1d93y5UwBsgpgg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124167>

 

> -----Original Message-----
> From: Eric Wong [mailto:normalperson@yhbt.net] 
> Timothy Schaeffer <tschaeffer@dramail.com> wrote:
> > Git-svn has been giving me the following error for some 
> time when calling "git svn dcommit":
> > 
> > RA layer request failed: PROPFIND request failed on 
> '/svn/stf/branches/dev/sw%2Fdpemu%2Finclude%2FNetCnxn.h': 
> > PROPFIND of 
> '/svn/stf/branches/dev/sw%2Fdpemu%2Finclude%2FNetCnxn.h': 
> > 302 Found (https://oursvnrepo.net) at 
> > /usr/local/libexec/git-core/git-svn line 508
> > 
> > This only occurred when git detected a rename or copy.
> > 
> > Following the lead into git-svn.perl, and noticing that some of the 
> > '/'s in the path were hex-encoded and some were not, I changed the 
> > regex used to find chars to hex-encode in the relative part of the 
> > path to exclude '/'.
> > It works, so far.  
> > I have included a patch.
> 
> Hi Timothy,
> 
> Thanks for the bug report and patch, i'll push it out 
> shortly.  I'm curious, do you happen to know which version of 
> Subversion the server was running?  I'm unable to reproduce 
> the problem, but I wouldn't be surprised if it's only a 
> problem with newere versions.  Thanks.
> 
> --
> Eric Wong
> 

The server is running svn 1.4.6.
