From: Mike Hommey <mh@glandium.org>
Subject: Re: gc considered dangerous
Date: Mon, 9 Feb 2009 07:59:19 +0100
Organization: glandium.org
Message-ID: <20090209065919.GB13257@glandium.org>
References: <200902080347.25970.robin.rosenberg.lists@dewire.com> <alpine.DEB.1.00.0902081551290.10279@pacific.mpi-cbg.de> <7vhc34y9za.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 08:01:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWQ8f-0000cD-BT
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 08:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbZBIG7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 01:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753570AbZBIG7i
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 01:59:38 -0500
Received: from vuizook.err.no ([85.19.221.46]:37638 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060AbZBIG7i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 01:59:38 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LWQ74-0004Y2-2H; Mon, 09 Feb 2009 07:59:28 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LWQ6x-0003yn-Va; Mon, 09 Feb 2009 07:59:19 +0100
Content-Disposition: inline
In-Reply-To: <7vhc34y9za.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109048>

On Sun, Feb 08, 2009 at 12:00:57PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > My preliminary guess is that this code in pack-write.c needs to use the 
> > lock file paradigm:
> >
> >         if (!index_name) {
> > 		[...]
> >         } else {
> >                 unlink(index_name);
> >                 fd = open(index_name, O_CREAT|O_EXCL|O_WRONLY, 0600);
> >         }
> 
> Whoa.  That particular code has been (and is still) correct.

Don't both unlink and open fail in the case the index file is locked in
Windows ?

Mike
