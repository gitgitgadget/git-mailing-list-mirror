From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] pack.indexversion config option now defaults to 2
Date: Wed, 25 Jun 2008 07:56:05 +0200
Organization: glandium.org
Message-ID: <20080625055605.GD28563@glandium.org>
References: <alpine.LFD.1.10.0806250025130.2979@xanadu.home> <alpine.LFD.1.10.0806242130450.22069@hp.linux-foundation.org> <7vd4m66rfp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 07:57:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBO0c-00029K-Nl
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 07:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbYFYF4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 01:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbYFYF4j
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 01:56:39 -0400
Received: from vuizook.err.no ([194.24.252.247]:58672 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbYFYF4i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 01:56:38 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KBNzN-00075R-Qa; Wed, 25 Jun 2008 07:56:24 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KBNzB-0007uT-Gq; Wed, 25 Jun 2008 07:56:05 +0200
Content-Disposition: inline
In-Reply-To: <7vd4m66rfp.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86238>

On Tue, Jun 24, 2008 at 09:59:06PM -0700, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > On Wed, 25 Jun 2008, Nicolas Pitre wrote:
> >> 
> >> Git older than version 1.5.2 (or any other git version with this option
> >> set to 1) may revert to version 1 of the pack index by manually deleting
> >> all .idx files and recreating them using 'git index-pack'.  Communication
> >> over the git native protocol is unaffected since the pack index is never
> >> transferred.
> >
> > Rather than talk about when it does _not_ matter, wouldn't it be better to 
> > talk about when it _can_ matter?
> >
> > Namely when using dumb protocols, either http or rsync, with the other end 
> > being some ancient git thing (and it is worth mentioning version of what 
> > counts as 'ancient' too, I can't remember, probably means that pretty much 
> > nobody else can either).
> 
> I agree with you that the description of the change (in the commit log)
> and the instruction (in the documentation) could be more helpful and
> explicit.
(...)

Wouldn't it be a good idea to add a warning in git update-server-info
when it detects pack.indexVersion is not 1, too ?

Mike
