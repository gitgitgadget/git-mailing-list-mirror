From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Document clone of clone loosing branches?
Date: Sat, 14 Jun 2008 15:18:08 -0700
Message-ID: <7vr6azfyov.fsf@gitster.siamese.dyndns.org>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
 <4853D967.5080903@gmail.com>
 <20080614.233645.71097102.hanzl@noel.feld.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: lewiemann@gmail.com, jnareb@gmail.com, peff@peff.net,
	git@vger.kernel.org
To: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
X-From: git-owner@vger.kernel.org Sun Jun 15 00:19:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7e5i-0004fU-I4
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 00:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755114AbYFNWS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 18:18:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754983AbYFNWS0
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 18:18:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878AbYFNWSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 18:18:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DF7F35311;
	Sat, 14 Jun 2008 18:18:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id F0355530E; Sat, 14 Jun 2008 18:18:16 -0400 (EDT)
In-Reply-To: <20080614.233645.71097102.hanzl@noel.feld.cvut.cz> (Vaclav
 Hanzl's message of "Sat, 14 Jun 2008 23:36:45 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CD24C03E-3A5F-11DD-A6AE-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85047>

Vaclav Hanzl <hanzl@noel.feld.cvut.cz> writes:

> I am not sure that the term 'branch' can be reasonably expected to
> mean 'regular branch' unless specified otherwise. For example, 'man
> git' says:
>
>        git-branch(1)
>           List, create, or delete branches.
>
> It can also list remote-tracking branches, cannot it? Or:
>
>        git-show-branch(1)
>           Show branches and their commits.
>
> Can also show remote-tracking branches, cannot it?

These fall into "quibbling" category, but that judgement can only be made
by people who know the history.

Updates to glossary and other introductory documents might be necessary.
For example, the entry about "tracking branch" in the glossary still talks
about the ancient convention of copying 'master' to 'origin' as a regular
branch:

    [[def_tracking_branch]]tracking branch::
            A regular git <<def_branch,branch>> that is used to follow changes from
            another <<def_repository,repository>>. A tracking
            branch should not contain direct modifications or have local commits
            made to it. A tracking branch can usually be
            identified as the right-hand-side <<def_ref,ref>> in a Pull:
            <<def_refspec,refspec>>.

This does _not_ reflect post v1.3.0 reality at all.  No git more recent
than Apr 2006 has used a "regular git branch" for tracking.

It probably is enough to say:

        A ref that is used to follow changes from another repository.
	In modern git, they are found in `refs/remotes/` hierarchy.

because you cannot add "direct modifications or have local commits" to
them anymore.
