From: Mike Hommey <mh@glandium.org>
Subject: Re: [RFC/PATCH] Add a --nosort option to pack-objects
Date: Fri, 7 Dec 2007 22:44:26 +0100
Organization: glandium.org
Message-ID: <20071207214426.GA13170@glandium.org>
References: <1197061832-8489-1-git-send-email-mh@glandium.org> <alpine.LFD.0.99999.0712071622150.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Dec 07 23:07:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0lLo-0006C5-W6
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 23:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbXLGWG4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 17:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752862AbXLGWG4
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 17:06:56 -0500
Received: from smtp19.orange.fr ([80.12.242.1]:38820 "EHLO smtp19.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752457AbXLGWGz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 17:06:55 -0500
X-Greylist: delayed 1341 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Dec 2007 17:06:55 EST
Received: from smtp19.orange.fr (mwinf1901 [172.22.129.23])
	by mwinf1905.orange.fr (SMTP Server) with ESMTP id C33F95C031DD
	for <git@vger.kernel.org>; Fri,  7 Dec 2007 22:45:14 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1901.orange.fr (SMTP Server) with ESMTP id 4990A5400097
	for <git@vger.kernel.org>; Fri,  7 Dec 2007 22:44:31 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf1901.orange.fr (SMTP Server) with ESMTP id 2842F5400094;
	Fri,  7 Dec 2007 22:44:31 +0100 (CET)
X-ME-UUID: 20071207214431165.2842F5400094@mwinf1901.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J0kzj-0006zW-Pc; Fri, 07 Dec 2007 22:44:27 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.99999.0712071622150.555@xanadu.home>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67479>

On Fri, Dec 07, 2007 at 04:24:17PM -0500, Nicolas Pitre wrote:
> On Fri, 7 Dec 2007, Mike Hommey wrote:
> 
> > While most of the time the heuristics used by pack-objects to sort the
> > given object list are satisfying enough, there are cases where it can be
> > useful for the user to sort the list with heuristics that would be better
> > suited.
> 
> Could you please elaborate on those cases where the current heuristic 
> would be unsatisfactory?

I imagine it could be useful when importing a huge tree in the first commit,
when some data in the tree is redundant with (or similar to) others in the
same tree. I guess there could be some other VCS use-cases.

The real case where I've been using this is that I use git to store my debian
build logs in an efficient manner, and having a custom-sorted list of objects
ends up being much faster and less memory consuming than using a huge
window (and 1GB of logs became less than 10MB).

Mike
