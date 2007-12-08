From: Mike Hommey <mh@glandium.org>
Subject: Re: [RFC/PATCH] Add a --nosort option to pack-objects
Date: Sat, 8 Dec 2007 09:54:29 +0100
Organization: glandium.org
Message-ID: <20071208085429.GB13432@glandium.org>
References: <1197061832-8489-1-git-send-email-mh@glandium.org> <7v4peu19kr.fsf@gitster.siamese.dyndns.org> <20071207214627.GB13170@glandium.org> <alpine.LFD.0.99999.0712071707250.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Dec 08 09:55:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0vSb-00076x-TB
	for gcvg-git-2@gmane.org; Sat, 08 Dec 2007 09:54:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757578AbXLHIyd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 03:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754864AbXLHIyc
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 03:54:32 -0500
Received: from smtp27.orange.fr ([80.12.242.96]:27382 "EHLO smtp27.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754824AbXLHIyb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 03:54:31 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2719.orange.fr (SMTP Server) with ESMTP id 487AB1C0009C
	for <git@vger.kernel.org>; Sat,  8 Dec 2007 09:54:30 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2719.orange.fr (SMTP Server) with ESMTP id 262FD1C00096;
	Sat,  8 Dec 2007 09:54:30 +0100 (CET)
X-ME-UUID: 20071208085430156.262FD1C00096@mwinf2719.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J0vS9-0003dz-CJ; Sat, 08 Dec 2007 09:54:29 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0712071707250.555@xanadu.home>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67532>

On Fri, Dec 07, 2007 at 05:20:59PM -0500, Nicolas Pitre wrote:
> On Fri, 7 Dec 2007, Mike Hommey wrote:
> 
> > As you can seen from my other message, I'm *actually* not sure this is
> > really material for git as a VCS. I will add documentation unrelated to
> > --nosort to pack-objects anyways.
> 
> Well, I have serious doubts about this patch in the first place.
> 
> I think it is simply unneeded.
> 
> If you want pack-objects not to change the sort order because you have 
> some sorting of your own, externally implemented, then you simply have 
> to run git-pack-objects feeding it the list of object SHA1s along with a 
> tag of your own which will effectively impose the sorting you want, 
> based on that tag.
> 
> Objects with the same tag will still be sorted amongst themselves which 
> is still a good thing.
> 
> for example, you may have something like:
> 
> 	git rev-list --all --objects |
> 	sed -e 's|foo/logs/.*|LOGS|' |
> 	git pack-objects ...
> 
> This will effectively cluster all foo/logs/* files together for delta 
> compression regardless of their actual name.  Maybe that's what you 
> really want?

I've been thinking about this, but I'm not sure the list won't be
mixed up with the rest of the sort... I'll just try to see what the
sorted list look like...

Mike
