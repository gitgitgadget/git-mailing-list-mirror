From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Tue, 02 Sep 2008 13:39:22 -0700
Message-ID: <7vk5dujn9h.fsf@gitster.siamese.dyndns.org>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Tue Sep 02 22:40:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kacfx-0007kU-QT
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 22:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbYIBUj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 16:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbYIBUj1
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 16:39:27 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbYIBUj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 16:39:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C9C1E71390;
	Tue,  2 Sep 2008 16:39:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 091FC7138D; Tue,  2 Sep 2008 16:39:23 -0400 (EDT)
In-Reply-To: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Tue, 2 Sep 2008 21:31:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3C01F8C4-792F-11DD-B227-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94709>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> Sometimes I work on a detached HEAD and then forget about it. If I then create
> some commits and checkout another branch, I have to dig through my reflog to
> find the older commits. I know that "git commit" adds has a "Not currently on
> any branch", but it's not very noticeable and also doesn't work when you
> specify a commit message on the command line.
>
> I suggest to add some extra output to the STDOUT after a commit if we're on a
> detached HEAD. The quick patch below adds output like:
>
> Vienna:git pieter$ ./git commit --allow-empty -m"test"
> Created commit 6ce62c8b: test
> You are on a detached head, so this commit has not been recorded in a branch.
> If you don't want to lose this commit, checkout a branch and then run:
> 	git merge 6ce62c8bfcfb341106f3587d1c141c3955c2544c
>
> Are there any comments to this / strong opinions against such a change?

Unconditionally doing this is too loud for my taste.  You probably can do
this in your post-commit hook.
