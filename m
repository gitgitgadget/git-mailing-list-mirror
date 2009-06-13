From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] teach am and rebase -q/--quiet
Date: Sat, 13 Jun 2009 16:05:53 -0700
Message-ID: <7vk53fvini.fsf@alter.siamese.dyndns.org>
References: <1244924500-27391-1-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 14 01:06:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFcIZ-000097-UD
	for gcvg-git-2@gmane.org; Sun, 14 Jun 2009 01:06:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759740AbZFMXFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 19:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758809AbZFMXFw
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 19:05:52 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34118 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758469AbZFMXFw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 19:05:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090613230554.VCNC17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 13 Jun 2009 19:05:54 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 3b5t1c0064aMwMQ03b5tH0; Sat, 13 Jun 2009 19:05:53 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=uoIjCrTgn_IA:10 a=KdErG-BSOSEA:10
 a=pGLkceISAAAA:8 a=31Kd6CgI1ObAoO5jtN8A:9 a=aMv4MyecFsBhH5OAuP8A:7
 a=ejxIafxjQCXmCqaDlA4ztAt8eIwA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <1244924500-27391-1-git-send-email-bebarino@gmail.com> (Stephen Boyd's message of "Sat\, 13 Jun 2009 13\:21\:38 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121525>

Stephen Boyd <bebarino@gmail.com> writes:

> I am not sure why "current branch $branch is up to date" and
> "Fast-forwarded $branch to $onto" is echoed to stderr, but I've
> wrapped those in a quiet check because it doesn't seem to be
> an error. Maybe those should be changed to stdout?

There are many valid cases where it makes sense to use stderr for messages
that are not errors (e.g. diagnostics, prompts, progress reports, and
informational messages that otherwise would clutter machine parsable
output meant to go to stdout).

I do not understand why some people seem to think stderr is only for
errors.  I think we even saw a broken interpretive language environment
where the system considers it an error if a program it launched said
anything to stderr, instead of correctly diagnosing the exit status from
it?

It is a disease.
