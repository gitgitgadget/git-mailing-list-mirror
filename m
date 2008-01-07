From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Test "git log --diff-filter"
Date: Sun, 06 Jan 2008 17:58:22 -0800
Message-ID: <7vabni2y81.fsf@gitster.siamese.dyndns.org>
References: <1198580807-18802-1-git-send-email-arjen@yaph.org>
	<200801060033.03672.jnareb@gmail.com>
	<7vmyrj7kq5.fsf@gitster.siamese.dyndns.org>
	<200801070131.57722.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Arjen Laarhoven <arjen@yaph.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 02:59:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBhGe-0004X7-BZ
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 02:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbYAGB6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 20:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbYAGB6l
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 20:58:41 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbYAGB6l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 20:58:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 616BAA62B;
	Sun,  6 Jan 2008 20:58:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E2F37A62A;
	Sun,  6 Jan 2008 20:58:33 -0500 (EST)
In-Reply-To: <200801070131.57722.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 7 Jan 2008 01:31:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69753>

Jakub Narebski <jnareb@gmail.com> writes:

> Am I mistaken in thinking that the rest of git always use terminators,
> and not separators for records output?

Actually, for normal "git log", separator semantics is the right
thing to use.  You do not want to add an additional trailing
newline when you show only one.  Compare these two to see what I
mean:

	$ git log -1
        $ git log -2

The problem is with --pretty=format.

        
