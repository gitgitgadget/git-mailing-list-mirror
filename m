From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix 'git cvsexportcommit -w $cvsdir ...' when used with relative $GIT_DIR
Date: Mon, 11 Feb 2008 12:10:41 -0800
Message-ID: <7vhcgf8da6.fsf@gitster.siamese.dyndns.org>
References: <200802110228.05233.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 21:11:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOf00-0001n1-Vc
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 21:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbYBKUK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 15:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbYBKUK5
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 15:10:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697AbYBKUK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 15:10:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E08AC53C5;
	Mon, 11 Feb 2008 15:10:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E303539F;
	Mon, 11 Feb 2008 15:10:43 -0500 (EST)
In-Reply-To: <200802110228.05233.johan@herland.net> (Johan Herland's message
	of "Mon, 11 Feb 2008 02:28:05 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73578>

Johan Herland <johan@herland.net> writes:

> When using the '-w $cvsdir' option to cvsexportcommit, it will chdir into
> $cvsdir before executing several other git commands. If $GIT_DIR is set to
> a relative path (e.g. '.'), the git commands executed by cvsexportcommit
> will naturally fail with "fatal: Not a git repository".
>
> Therefore, if $GIT_DIR is relative, prepend $PWD to $GIT_DIR before the
> chdir to $cvsdir.

That sounds like a correct thing to do.  Robin?
