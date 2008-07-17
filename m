From: Junio C Hamano <gitster@pobox.com>
Subject: Contributors, please check your names
Date: Thu, 17 Jul 2008 01:22:01 -0700
Message-ID: <7v8ww0j4ye.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 17 10:23:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJOla-00051d-6b
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 10:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752288AbYGQIWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 04:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbYGQIWL
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 04:22:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169AbYGQIWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 04:22:10 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 08A8F272E6;
	Thu, 17 Jul 2008 04:22:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 58F5E272E5; Thu, 17 Jul 2008 04:22:06 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 72377C5A-53D9-11DD-BB51-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88818>

A handy way to look at the list of contributors is:

	$ git shortlog -s --since=6.month

This shows the number of patches in our history for each contributor.  The
patch author name (excluding e-mail part) is used for summarizing, and
this allows the same person to send patches under more than one e-mail
address and still count these patches as authored by one person.

Your name however can appear more than once in different spellings, if you
sent patches using different human-readable names on From: line of your
patch submission from the same (or different) e-mail address.  E.g. these
two patches are counted under different authors:

	Author: A. U. Thor <author@example.xz>
        Date:   Wed Jul 09:23:06 2008 -0700

	The first patch...

        Author: A U Thor <author@example.xz>
        Date:   Wed Jul 09:23:07 2008 -0700

	The second patch...

There is a "mailmap" mechanism to consolidate them; it allows us to
specify what human-readable name should be used for given e-mail address.
The hypothetical Mr. Thor might want to say "I am A. U. Thor; some commits
from me, <author@example.xz>, are marked without abbreviating periods in
my name", and we can add this entry to the toplevel .mailmap file to fix
it:

	A. U. Thor <author@example.xz>

It tells the shortlog (and --pretty=format:%aN in recent enough git)
mechanism to give huma readable name "A. U. Thor" anytime it sees
<author@example.xz> e-mail address, regardless of what the Author:
header in the commit object says.

If your name appears more than once in the output from the "shortlog"
command at the beginning of this message, you may want to tell me to fix
it.

Thanks.
