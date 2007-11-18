From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Advance Warning PATCH] Move gitk to its own subdirectory
Date: Sat, 17 Nov 2007 17:18:40 -0800
Message-ID: <7vabpcz6z3.fsf@gitster.siamese.dyndns.org>
References: <7vsl34u1iv.fsf@gitster.siamese.dyndns.org>
	<20071117232519.GA7664@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 02:19:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItYoR-0004zF-7u
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 02:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbXKRBSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 20:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754767AbXKRBSq
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 20:18:46 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40054 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbXKRBSp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 20:18:45 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 666622EF;
	Sat, 17 Nov 2007 20:19:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 04C0A96F15;
	Sat, 17 Nov 2007 20:19:03 -0500 (EST)
In-Reply-To: <20071117232519.GA7664@steel.home> (Alex Riesen's message of
	"Sun, 18 Nov 2007 00:25:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65331>

Alex Riesen <raa.lkml@gmail.com> writes:

> You made it part of "all" target, which we will have to change if gitk
> is to become a subproject: Makefile better handle absence of the
> Makefile under gitk-git, and continue build.

Not necessarily.

The policy is completely up to the superproject (which is
git.git).  Currently, the policy is "make all" and "make
install" in git.git builds and installs what are considered core
parts of the system which includes git-gui and gitk.

gitk nor git-gui should not become useless without being in
git.git (iow, their build procedure better not depend on things
outside their subtree), but I do not think that is a hard
requirement either.  Shawn *chose* to keep git-gui buildable and
installable separately as well as as part of git.git.  Again I
think that policy is up to individual subprojects.
