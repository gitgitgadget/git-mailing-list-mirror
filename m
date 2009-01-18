From: Mike Hommey <mh@glandium.org>
Subject: Re: [WIP Patch 02/12] Some cleanup in get_refs_via_curl()
Date: Sun, 18 Jan 2009 20:19:28 +0100
Organization: glandium.org
Message-ID: <20090118191928.GA23108@glandium.org>
References: <20090118074911.GB30228@glandium.org> <1232265877-3649-1-git-send-email-mh@glandium.org> <1232265877-3649-2-git-send-email-mh@glandium.org> <1232265877-3649-3-git-send-email-mh@glandium.org> <alpine.DEB.1.00.0901182005230.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 18 20:21:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOdCh-0003gW-8x
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 20:21:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbZARTTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 14:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbZARTTk
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 14:19:40 -0500
Received: from vuizook.err.no ([85.19.221.46]:59721 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540AbZARTTj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 14:19:39 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOdBD-00081h-0P; Sun, 18 Jan 2009 20:19:33 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOdBB-0006OD-5T; Sun, 18 Jan 2009 20:19:29 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901182005230.3586@pacific.mpi-cbg.de>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106262>

On Sun, Jan 18, 2009 at 08:06:17PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Sun, 18 Jan 2009, Mike Hommey wrote:
> 
> > diff --git a/transport.c b/transport.c
> > index 56831c5..6919ff1 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -508,6 +508,8 @@ static struct ref *get_refs_via_curl(struct transport *transport)
> >  		free(ref);
> >  	}
> >  
> > +	http_cleanup();
> > +	free(refs_url);
> >  	return refs;
> >  }
> 
> You cannot http_cleanup() here, as http-push calls that function, but 
> continues to want to use curl.

Are you really sure? It doesn't seem so, to me.

Mike
