From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce light weight commit annotations
Date: Mon, 11 Jun 2007 00:43:51 -0700
Message-ID: <7vbqfnrl54.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706091854330.4059@racer.site>
	<alpine.LFD.0.99.0706102206590.12885@xanadu.home>
	<81b0412b0706110024mf975011t27b23555f6a23cc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com,
	"Johan Herland" <johan@herland.net>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 09:44:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxeZG-00060O-9y
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 09:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbXFKHnx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 03:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751608AbXFKHnx
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 03:43:53 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57530 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbXFKHnx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 03:43:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070611074351.EUDK18396.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Mon, 11 Jun 2007 03:43:51 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id A7jr1X00H1kojtg0000000; Mon, 11 Jun 2007 03:43:52 -0400
In-Reply-To: <81b0412b0706110024mf975011t27b23555f6a23cc6@mail.gmail.com>
	(Alex Riesen's message of "Mon, 11 Jun 2007 09:24:36 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49828>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> It is still a reference, really. Besides, if it is not under refs/, we'd
> have to change fetch/push to allow distribution of the notes/annotations
> (there are special assumptions regarding reference names starting
> with "refs/"). Right now it just works.

Two issues.

One is that it is unclear is how the reachability rules should
be.  Should an ??/?{38} entry in the refs/annotations/commits
protects the commit the entry talks about (i.e. ???{38}) from
getting pruned?

Another is how different kinds of annotations on the same commit
should be managed.  Should different commits and their histories
pointed at by refs/annotations/{frotz,xyzzy,...} be used for
that?  Or perhaps we should make ??/?{38} a tree that has
multiple files underneath it?
