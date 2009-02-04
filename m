From: Mike Hommey <mh@glandium.org>
Subject: Re: segfault during clone via http
Date: Wed, 4 Feb 2009 22:39:13 +0100
Organization: glandium.org
Message-ID: <20090204213913.GA7806@glandium.org>
References: <loom.20090204T160827-822@post.gmane.org> <76718490902041000x3cda2390t25254e8372c9af50@mail.gmail.com> <loom.20090204T183407-350@post.gmane.org> <alpine.DEB.1.00.0902042132110.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Thorsen <adam.thorsen@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 04 22:41:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUpUK-0000At-SK
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 22:40:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbZBDVj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 16:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754495AbZBDVj0
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 16:39:26 -0500
Received: from vuizook.err.no ([85.19.221.46]:51430 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753489AbZBDVj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 16:39:26 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LUpSn-0001AI-FK; Wed, 04 Feb 2009 22:39:20 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LUpSj-00023A-3K; Wed, 04 Feb 2009 22:39:13 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0902042132110.10279@pacific.mpi-cbg.de>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108440>

On Wed, Feb 04, 2009 at 09:34:36PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 4 Feb 2009, Adam Thorsen wrote:
> 
> > 
> > Here is the stack trace:
> > 
> > Program received signal EXC_BAD_ACCESS, Could not access memory.
> > Reason: KERN_INVALID_ADDRESS at address: 0x00494000
> > 0x0015bb04 in multi_runsingle ()
> > (gdb) bt
> > #0  0x0015bb04 in multi_runsingle ()
> > #1  0x0015d5af in curl_multi_perform ()
> > #2  0x000b8782 in step_active_slots () at http.c:450
> > #3  0x000b881c in run_active_slot (slot=0x50a450) at http.c:474
> > #4  0x000bac5c in fetch (walker=0x5008d0, 
> > sha1=0x4a791c "?u^?9l?\003?5??#??X\"?XL") at http-walker.c:846
> 
> FWIW I think the issue is related to the double cleanup I mentioned to 
> Mike Hommey earlier.  At least when I undo the double cleanup, I do not 
> get any segfaults anymore.

I thought it was not applied, in the end ?

Mike
