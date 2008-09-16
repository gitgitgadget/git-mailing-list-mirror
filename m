From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: warn against merging in a dirty tree
Date: Mon, 15 Sep 2008 17:06:34 -0700
Message-ID: <7vprn57y45.fsf@gitster.siamese.dyndns.org>
References: <200809160048.31443.trast@student.ethz.ch>
 <1221518994-26111-1-git-send-email-trast@student.ethz.ch>
 <1221518994-26111-2-git-send-email-trast@student.ethz.ch>
 <7vtzch7z7u.fsf@gitster.siamese.dyndns.org>
 <32541b130809151653w27d7876fp35e0967d597ae2a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Thomas Rast" <trast@student.ethz.ch>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 02:08:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfO6m-00020K-DQ
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 02:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbYIPAGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 20:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753998AbYIPAGt
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 20:06:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47635 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752583AbYIPAGs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 20:06:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8FD8B61871;
	Mon, 15 Sep 2008 20:06:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A3F9A6185B; Mon, 15 Sep 2008 20:06:37 -0400 (EDT)
In-Reply-To: <32541b130809151653w27d7876fp35e0967d597ae2a9@mail.gmail.com>
 (Avery Pennarun's message of "Mon, 15 Sep 2008 19:53:07 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5974DBB6-8383-11DD-BADF-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95963>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> But how do you abort a *failed* merge in a situation like Linus's
> example?  "git reset --hard HEAD" would destroy the unstaged Makefile
> change.

"All of your work tree changes are easily reproducible" implies you do not
mind losing them, Ok?

Also "git reset HEAD" (that is, without --hard) would not touch the work
tree changes.  You need to remove the work-tree cruft left by new files
yourself, if you go this route, though.  New files are rare enough so it
may be more appropriate (and you can "git clean -n $that_subdirectory" to
enumerate them).

It all depends on your workflow.
