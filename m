From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 09/13] Allow helpers to report in "list" command that
 the ref is unchanged
Date: Wed, 5 Aug 2009 17:18:35 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0908051717580.2147@iabervon.org>
References: <alpine.LNX.2.00.0908050056000.2147@iabervon.org> <alpine.DEB.1.00.0908052258440.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:18:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYnsj-0000l1-SH
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 23:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbZHEVSf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 17:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751946AbZHEVSf
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 17:18:35 -0400
Received: from iabervon.org ([66.92.72.58]:44224 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751374AbZHEVSf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 17:18:35 -0400
Received: (qmail 17376 invoked by uid 1000); 5 Aug 2009 21:18:35 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Aug 2009 21:18:35 -0000
In-Reply-To: <alpine.DEB.1.00.0908052258440.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124989>

On Wed, 5 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Wed, 5 Aug 2009, Daniel Barkalow wrote:
> 
> > +			if (strstr(eon + 1, "unchanged")) {
> 
> I guess we'll want to have a helper like this already:
> 
> 	static int has_attribute(const char *tail, const char *attr) {
> 		int len;
> 
> 		if (!tail)
> 			return 0;
> 
> 		len = strlen(attr);
> 		for (;;) {
> 			const char *space = strchrnul(tail, ' ');
> 			if (len == space - tail && !strncmp(tail, attr, len))
> 				return 1;
> 			if (!*space)
> 				return 0;
> 			tail = space + 1;
> 		}
> 	}
> 
> This guards against attributes that are substrings of other attributes.  
> (You want to future-proof the attributes system, after all, i.e. handle 
> helpers returning attributes unknown to the current Git.)

Good point.

	-Daniel
*This .sig left intentionally blank*
