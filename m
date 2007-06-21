From: "Dave O'Neill" <dmo@roaringpenguin.com>
Subject: Re: [PATCH] Let git-svnimport clean up SVK commit messages.
Date: Thu, 21 Jun 2007 17:58:08 -0400
Message-ID: <20070621215808.GD21065@magnesium.roaringpenguin.com>
References: <1182392095394-git-send-email-dmo@roaringpenguin.com> <4679EE45.2080605@midwinter.com> <20070621141415.GA21065@magnesium.roaringpenguin.com> <1182438000.4031.11.camel@lt21223.campus.dmacc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 21 23:58:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1UfO-00036O-IL
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 23:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075AbXFUV6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 17:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755958AbXFUV6K
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 17:58:10 -0400
Received: from www.roaringpenguin.com ([206.191.13.82]:4431 "EHLO
	www.roaringpenguin.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbXFUV6J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 17:58:09 -0400
Received: from magnesium.roaringpenguin.com (ottawa-hs-64-26-171-99.s-ip.magma.ca [64.26.171.99])
	by www.roaringpenguin.com (8.14.1/8.14.0) with ESMTP id l5LLw8uW010460
	for <git@vger.kernel.org>; Thu, 21 Jun 2007 17:58:08 -0400
Received: from magnesium.roaringpenguin.com (localhost.localdomain [127.0.0.1])
	by magnesium.roaringpenguin.com (8.12.10/8.12.10) with ESMTP id l5LLw8Wo006416
	for <git@vger.kernel.org>; Thu, 21 Jun 2007 17:58:08 -0400
Received: (from dmo@localhost)
	by magnesium.roaringpenguin.com (8.12.10/8.12.10/Submit) id l5LLw83C006414
	for git@vger.kernel.org; Thu, 21 Jun 2007 17:58:08 -0400
Content-Disposition: inline
In-Reply-To: <1182438000.4031.11.camel@lt21223.campus.dmacc.edu>
User-Agent: Mutt/1.4.1i
X-Scanned-By: CanIt (www . roaringpenguin . com) on 206.191.13.82
X-Scanned-By: MIMEDefang 2.57 on 192.168.10.12
X-Spam-Score: undef - spam scanning disabled
X-CanItPRO-Stream: outgoing (inherits from default)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50657>

On Thu, Jun 21, 2007 at 10:00:00AM -0500, Jeffrey C. Ollie wrote:
> This quickie Python script should convert the "tag branches" to regular
> Git tags:
> 
>         import os
>         refs = os.popen('git-for-each-ref --format="%(objectname)%00%(refname)%00" refs/remotes/tags')
>         for line in refs:
>             [sha, ref] = line.split('\0')[:2]
>             os.system('git tag %s %s' % (ref[18:], sha))

Thanks!  I'll give that a try.  It would be nice if this sort of cleanup
were part of git-svn in some way, though.  I doubt I'll be the last
person wanting an easy conversion from SVN.

Cheers,
Dave
