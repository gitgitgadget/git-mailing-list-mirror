From: Junio C Hamano <gitster@pobox.com>
Subject: Re: docs and completion and dashless commands
Date: Fri, 22 Aug 2008 14:34:05 -0700
Message-ID: <7vr68g7n02.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.0.999999.0808221550100.11892@mojave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: dherring@ll.mit.edu
X-From: git-owner@vger.kernel.org Fri Aug 22 23:35:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWeHt-0006Gh-9i
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 23:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbYHVVeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 17:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752611AbYHVVeM
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 17:34:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53910 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbYHVVeM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 17:34:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F50D691D8;
	Fri, 22 Aug 2008 17:34:10 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4670A691D5; Fri, 22 Aug 2008 17:34:07 -0400 (EDT)
In-Reply-To: <alpine.LNX.0.999999.0808221550100.11892@mojave>
 (dherring@ll.mit.edu's message of "Fri, 22 Aug 2008 16:26:32 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0E89B8AA-7092-11DD-8800-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93376>

dherring@ll.mit.edu writes:

> First off, I'm not too keen on these dashless commands.
> - We now have `man git-X` but can't run `git-X`
> - A separate completion script must be installed for bash
> - Lose completion for all other shells
> - History expansion is complicated (e.g. `!git-push` vs `!git push`)

Please stop and leave the dead horse lie in piece.  You are more than a
year too late.

> Anyway, could someone modify INSTALL to mention
> contrib/completion/git-completion.bash and putting `git --exec-path`
> in PATH for other shells?

And please nobody waste time on the latter.  "git-foo" form for builtins
will be removed from the filesystem eventually and at that point:

	#!/bin/sh

	PATH=$(git --exec-path):$PATH
        .. do its thing ..
        git-commit -a -m 'funny wrapper created commit'

will _stop_ working.  If somebody is starting a new script there is no
point using the form only to later update to the dashless form.

> These docs might also instruct users to call
> git-config and set their global username and email.

Please read the first few paragraphs of gittutorial(7).
