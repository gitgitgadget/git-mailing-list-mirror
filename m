From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Sun, 22 Jul 2012 11:50:56 -0400
Message-ID: <20120722155056.GA22641@sigill.intra.peff.net>
References: <20120719213225.GA20311@sigill.intra.peff.net>
 <20120719213311.GA20385@sigill.intra.peff.net>
 <50092993.6010203@alum.mit.edu>
 <20120720154403.GB2862@sigill.intra.peff.net>
 <6F148977-4F57-47FF-B43B-0997694F3891@gmail.com>
 <20120722131448.GA16104@sigill.intra.peff.net>
 <61E46C90-5C8F-4E11-8CB7-0A05F1D62A8A@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Alexey Muranov <alexey.muranov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 17:51:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsyQx-0006DQ-F3
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 17:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816Ab2GVPu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 11:50:58 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:58179 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751791Ab2GVPu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 11:50:58 -0400
Received: (qmail 27443 invoked by uid 107); 22 Jul 2012 15:50:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 22 Jul 2012 11:50:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Jul 2012 11:50:56 -0400
Content-Disposition: inline
In-Reply-To: <61E46C90-5C8F-4E11-8CB7-0A05F1D62A8A@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201853>

On Sun, Jul 22, 2012 at 04:40:14PM +0200, Alexey Muranov wrote:

> >  3. Most importantly, it does not resolve D/F conflicts (it has the
> >     same problem as "logs/refs/heads/a~"). If you delete "foo/bar", you
> >     will end up with "logs/refs/heads/foo/bar@{...}". That will prevent
> >     D/F conflicts with a new branch "foo/bar/baz", but will still have
> >     a problem with just "foo".
> 
> Unfortunately i do not really follow this, because i have not seen any
> directories in "logs/refs/heads/", i only saw files named after local
> branches there. I do not know how directories are used there.

The user is free to have branch names with slashes, in which case they
are represented in the filesystem as directories. Even without using
slashes in your branch names, you already have subdirectories in
refs/remotes.

-Peff
