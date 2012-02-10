From: Ted Ts'o <tytso@mit.edu>
Subject: Re: Git documentation at kernel.org
Date: Fri, 10 Feb 2012 14:57:36 -0500
Message-ID: <20120210195736.GA5381@thunk.org>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
 <20120208213410.GA5768@ecki>
 <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
 <vpqbop6tyj6.fsf@bauges.imag.fr>
 <FC56A942-EE70-48B7-A2D3-CF53A189A55E@mit.edu>
 <1328900154.3171.27.camel@i5.mricon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Konstantin Ryabitsev <icon@mricon.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 20:57:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvwbO-0000z9-SU
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 20:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759965Ab2BJT5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 14:57:46 -0500
Received: from li9-11.members.linode.com ([67.18.176.11]:51587 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758542Ab2BJT5p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 14:57:45 -0500
Received: from root (helo=tytso-glaptop.cam.corp.google.com)
	by test.thunk.org with local-esmtp (Exim 4.69)
	(envelope-from <tytso@thunk.org>)
	id 1RvwbC-0000pe-Cq; Fri, 10 Feb 2012 19:57:38 +0000
Received: from tytso by tytso-glaptop.cam.corp.google.com with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1RvwbA-0001Ww-VC; Fri, 10 Feb 2012 14:57:36 -0500
Content-Disposition: inline
In-Reply-To: <1328900154.3171.27.camel@i5.mricon.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on test.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190443>

How about this as something *way* simpler?  Define a way of marking
the top of a particular directory hierarchy as a tree.  Then the
*only* way of updating that tree is all or nothing.  That is, someone
submits a signed tarball; then after the signed tarball has its
signature checked, it gets unpacked into a dir.new, and then we rename
dir to dir.old, rename dir.new to dir, and then dir.old gets removed.

That way there's no conflicts between directories that are managed via
the kup-servers PUT and DELETE commands, and those where they get
uploaded as a single tarball to create or replace a specific directory
hierarcy, or which can be deleted only as a entire directory hierarcy.

What do you think?

						- Ted
