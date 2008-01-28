From: Mike Hommey <mh@glandium.org>
Subject: Re: Is there a reason to keep walker.c ?
Date: Mon, 28 Jan 2008 08:17:49 +0100
Organization: glandium.org
Message-ID: <20080128071749.GA12488@glandium.org>
References: <20080127204535.GA4702@glandium.org> <alpine.LNX.1.00.0801271603280.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 08:16:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJODq-0007r2-1G
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 08:16:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbYA1HPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 02:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbYA1HPc
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 02:15:32 -0500
Received: from vuizook.err.no ([85.19.215.103]:53504 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbYA1HPb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 02:15:31 -0500
Received: from aputeaux-153-1-85-206.w86-205.abo.wanadoo.fr ([86.205.43.206] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JJODj-000881-0J; Mon, 28 Jan 2008 08:16:01 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JJOFZ-0003SR-Dw; Mon, 28 Jan 2008 08:17:49 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0801271603280.13593@iabervon.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71855>

On Sun, Jan 27, 2008 at 04:23:17PM -0500, Daniel Barkalow wrote:
> On Sun, 27 Jan 2008, Mike Hommey wrote:
> 
> > Hi,
> > 
> > While working on the http code refactoring, I got to wonder if the
> > walker.c "wrapper", that is only used for the http transport, is still
> > worth keeping. If there are plans for others transport to use this code,
> > obviously, it would be worth keeping, but on the contrary, I think it
> > would simplify the http transport code even more. What do you think ?
> 
> It would be a good base for sftp (i.e. dumb file access over ssh). In 
> fact, I think stuff should ideally be moved into walker.c such that the 
> HTTP-specific code just handles access to files by filename and the logic 
> of what files to request in what order is in walker.c. I think this would 
> get the simplification you're looking for while making it easy to add sftp 
> or any other situation where you have only slow remote filesystem-like 
> access to the repository.

I like this idea. I'll probably implement that, then.

Mike
