From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push: push <remote> :<branch> deletes remote branch
Date: Tue, 19 Feb 2008 14:24:11 +0100
Organization: glandium.org
Message-ID: <20080219132410.GA6553@glandium.org>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080219125840.GA14049@localhost> <alpine.LSU.1.00.0802191313290.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:25:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRSSz-0003LF-BE
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 14:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737AbYBSNYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 08:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751736AbYBSNYZ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 08:24:25 -0500
Received: from vuizook.err.no ([85.19.215.103]:34007 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbYBSNYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 08:24:24 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JRSSE-0008Jf-Rb; Tue, 19 Feb 2008 14:24:21 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1JRSSB-0001i6-E7; Tue, 19 Feb 2008 14:24:11 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802191313290.30505@racer.site>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74401>

On Tue, Feb 19, 2008 at 01:17:24PM +0000, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Tue, 19 Feb 2008, Clemens Buchacher wrote:
> 
> > On Mon, Feb 18, 2008 at 05:34:45PM +0000, Johannes Schindelin wrote:
> >
> > > Thanks for the patch, I think it good.  Now, if we only had automated 
> > > tests... ;-)
> > 
> > Thank you. Implementing a test should be fairly difficult, since we need 
> > at least a WebDAV capable webserver, right? Do you having something in 
> > mind?
> 
> Actually, thinking about it again, it should not be _that_ difficult.  We 
> would need to ship a httpd.conf.in, pick a port (maybe 8111, because that 
> is already used in t5703-daemon.sh), generate httpd.conf and then start 
> Apache with that.
> 
> If Apache does not want to start, skip this test.  (This might happen due 
> to Apache not being installed, or the DAV modules not being installed, or 
> Apache not finding them, or...)

Except that means coping with the fact that modules are probably not
installed in the same place on all distros, or can have been built in
apache instead of being DSOs, etc.
The server itself doesn't even have the same name across distros (httpd vs.
apache vs. apache2)

Mike
