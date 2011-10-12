From: Marcus Karlsson <mk@acc.umu.se>
Subject: Re: [PATCH v3] gitk: Teach gitk to respect log.showroot
Date: Wed, 12 Oct 2011 16:36:39 +0200
Message-ID: <20111012143639.GA22316@kennedy.acc.umu.se>
References: <20111004200813.GA16596@kennedy.acc.umu.se>
 <20111008064704.GA27056@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: zbyszek@in.waw.pl, gitster@pobox.com, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Oct 12 16:36:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDzvL-0001oY-5v
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 16:36:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623Ab1JLOgm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 10:36:42 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:53796 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab1JLOgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 10:36:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id BF569DBA;
	Wed, 12 Oct 2011 16:36:40 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: from kennedy.acc.umu.se (kennedy.acc.umu.se [130.239.18.157])
	by mail.acc.umu.se (Postfix) with ESMTP id 0BF97DB9;
	Wed, 12 Oct 2011 16:36:40 +0200 (MEST)
Received: by kennedy.acc.umu.se (Postfix, from userid 24678)
	id D6B5199; Wed, 12 Oct 2011 16:36:39 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20111008064704.GA27056@bloggs.ozlabs.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183372>

On Sat, Oct 08, 2011 at 05:47:04PM +1100, Paul Mackerras wrote:
> On Tue, Oct 04, 2011 at 10:08:13PM +0200, Marcus Karlsson wrote:
> > Teach gitk to respect log.showroot.
> 
> Sounds reasonable, ...
> 
> > -	set cmd [concat | git diff-tree -r $flags $ids]
> > +	set cmd [concat | git diff-tree -r]
> > +	if {$log_showroot eq true} {
> > +	    set cmd [concat $cmd --root]
> > +	}
> > +	set cmd [concat $cmd $flags $ids]
> 
> but is there any reason not to do it like this?
> 
> 	if {$log_showroot} {
> 	    lappend flags --root
> 	}
> 	set cmd [concat | git diff-tree -r $flags $ids]
> 
> I.e., do you particularly want the --root before the other flags?
> 
> Paul.

Not really, that would work very well.

Marcus
