From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/8] get-repack --max-pack-size: write_object() takes 'limit' arg
Date: Mon, 09 Apr 2007 13:09:44 -0700
Message-ID: <7v3b39z4vr.fsf@assigned-by-dhcp.cox.net>
References: <46197994.70009@gmail.com>
	<alpine.LFD.0.98.0704082034060.28181@xanadu.home>
	<56b7f5510704091151l70cc74b1la82e0c5a67d6885f@mail.gmail.com>
	<alpine.LFD.0.98.0704091455100.28181@xanadu.home>
	<56b7f5510704091220w69529e72n2f982c097c4e26a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>, "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 00:15:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb0Bi-0004WM-40
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 22:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965461AbXDIUJq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 16:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965485AbXDIUJq
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 16:09:46 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:57373 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965461AbXDIUJp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 16:09:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409200944.UULG373.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Apr 2007 16:09:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id l89k1W00Z1kojtg0000000; Mon, 09 Apr 2007 16:09:45 -0400
In-Reply-To: <56b7f5510704091220w69529e72n2f982c097c4e26a0@mail.gmail.com>
	(Dana How's message of "Mon, 9 Apr 2007 12:20:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44069>

"Dana How" <danahow@gmail.com> writes:

> For testing, I've been using git-fsck/git-verify-pack/git-unpack-objects .

Among the above, verify-pack does not do much more than what the
normal object reading path does already these days.  Also
unpack-objects (especially with -n) omits a lot of object
integrity checks, and not very appropriate test.

We have some tests for packfiles in t/ (make test) but I would
not be surprised if we do not have enough.  Most of the existing
tests are done on loose objects the tests themselves produce
without repacking, because their focus is not about packs and
they test whatever they are interested in, assuming that the
lowest level object layer is correctly functioning.
