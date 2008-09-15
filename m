From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Optional shrinking of RCS keywords in git-p4
Date: Mon, 15 Sep 2008 00:43:50 -0700
Message-ID: <7vy71tetvt.fsf@gitster.siamese.dyndns.org>
References: <16219.81556.qm@web95005.mail.in2.yahoo.com>
 <20080915063521.GA1533@linode.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dhruva <dhruva@ymail.com>, GIT SCM <git@vger.kernel.org>,
	Simon Hausmann <simon@lst.de>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Mon Sep 15 09:45:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kf8m8-0005rY-6f
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 09:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbYIOHoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 03:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752272AbYIOHoJ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 03:44:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbYIOHoI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 03:44:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5369D619B3;
	Mon, 15 Sep 2008 03:44:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 98BAE619AE; Mon, 15 Sep 2008 03:43:59 -0400 (EDT)
In-Reply-To: <20080915063521.GA1533@linode.davidb.org> (David Brown's message
 of "Sun, 14 Sep 2008 23:35:21 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 13988E1E-82FA-11DD-8FF7-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95888>

David Brown <git@davidb.org> writes:

> ...  As far as I can tell, P4 completely
> ignores whatever the $Id: ...$ headers happen to be expanded to at the
> time of checking.  You can put garbage there, and it check in fine.
> ...
> I guess it isn't a problem to make this optional in git-p4, but I
> don't think this patch is solving the right problem.

Hmm.  I do not do p4, but what I am guessing is that there probably is a
configuration switch on the p4 side that lets you check in files with
"$Id: garbage $" in them, while dhruva hasn't turned that switch on.

It could be (1) not flipping the switch on is a user mistake and dhruva
can just flip it to fix his problem, or (2) the policy of dhruva's project
mandates the switch to stay off, and he needs the patch to work around the
issue.

I cannot judge which is the case myself, but if the situation is the
former, we would need a documentation to suggest that magic p4 switch as a
workaround that would work for everybody without hurting anybody.  On the
other hadn, if the situation is the latter, we would need this patch in
addition to the suggestion of the magic p4 switch that the user _may_ be
able to flip depending on the project policy on the p4 side.
