From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] (minor) "git status ." reports added files as untracked
Date: Mon, 04 Feb 2008 13:26:27 -0800
Message-ID: <7v7ihkjtvg.fsf@gitster.siamese.dyndns.org>
References: <vpqtzko8ws2.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:27:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8qg-0001Nh-18
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 22:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756449AbYBDV0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755774AbYBDV0g
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:26:36 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568AbYBDV0f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:26:35 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 76A9346AC;
	Mon,  4 Feb 2008 16:26:34 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EC26D469C;
	Mon,  4 Feb 2008 16:26:31 -0500 (EST)
In-Reply-To: <vpqtzko8ws2.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	04 Feb 2008 18:19:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72573>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Indeed, I've always considered the fact that "git status ." reports
> untracked files outside the current directory as a bug, but I'm not
> sure whether this is intended or not.

It is intended.

"git status $args" was designed as "show me what happens if I
ran 'git commit $args' now", and because a commit is a whole
tree operation, 

It is a different matter if the intention matches the
expectation you picked up from somewhere on how "scm status"
should work (it most likely doesn't).  It also is a different
matter if it is justifiable to have such a mismatch.
