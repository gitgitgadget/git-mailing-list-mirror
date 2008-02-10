From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 10 Feb 2008 14:09:52 -0800
Message-ID: <7vr6fkea4v.fsf@gitster.siamese.dyndns.org>
References: <7v7ihmuwzi.fsf@gitster.siamese.dyndns.org>
	<7vodavd9qw.fsf@gitster.siamese.dyndns.org>
	<7vbq6tset4.fsf@gitster.siamese.dyndns.org>
	<7vmyq9gk94.fsf@gitster.siamese.dyndns.org>
	<m3wspcg4hg.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 23:10:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOKO0-0005fk-1X
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 23:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbYBJWKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 17:10:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbYBJWKQ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 17:10:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752128AbYBJWKP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 17:10:15 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E2852227F;
	Sun, 10 Feb 2008 17:10:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D4134227D;
	Sun, 10 Feb 2008 17:10:06 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73425>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * jc/submittingpatches (Sun Feb 3 17:02:28 2008 -0800) 3 commits
>>  + Documentation/SubmittingPatches: What's Acked-by and Tested-by?
>>  + Documentation/SubmittingPatches: discuss first then submit
>>  + Documentation/SubmittingPatches: Instruct how to use [PATCH]
>>    Subject header
>> 
>> These I think are sensible but they did not see much discussion,
>> so they are parked here for now.
>
> I thing first and last are good to go, while second could get
> improved. This means I guess either resending second patch for further
> discussion, or adding it as is, and wait for further improvements; it
> is better than nothing.

Ok.  As you can see above it's already merged to 'next', so here
is an update with pieces taken from my earlier response to your
question.

-- >8 --
[PATCH] Documentation/SubmittingPatches - a suggested patch flow

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/SubmittingPatches |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 0661293..0e155c9 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -230,6 +230,41 @@ to modify.  "Tested-by:" says the patch was tested by the person
 and found to have the desired effect.
 
 ------------------------------------------------
+An ideal patch flow
+
+Here is an ideal patch flow for this project the current maintainer
+suggests to the contributors:
+
+ (0) You come up with an itch.  You code it up.
+
+ (1) Send it to the list and cc people who may need to know about
+     the change.
+
+     The people who may need to know are the ones whose code you
+     are butchering.  These people happen to be the ones who are
+     most likely to be knowledgeable enough to help you, but
+     they have no obligation to help you (i.e. you ask for help,
+     don't demand).  "git log -p -- $area_you_are_modifying" would
+     help you find out who they are.
+
+ (2) You get comments and suggestions for improvements.  You may
+     even get them in a "on top of your change" patch form.
+
+ (3) Polish, refine, and re-send to the list and the people who
+     spend their time to improve your patch.  Go back to step (2).
+
+ (4) The list forms consensus that the last round of your patch is
+     good.  Send it to the list and cc the maintainer.
+
+ (5) A topic branch is created with the patch and is merged to 'next',
+     and cooked further and eventually graduates to 'master'.
+
+In any time between the (2)-(3) cycle, the maintainer may pick it up
+from the list and queue it to 'pu', in order to make it easier for
+people play with it without having to pick up and apply the patch to
+their trees themselves.
+
+------------------------------------------------
 MUA specific hints
 
 Some of patches I receive or pick up from the list share common
