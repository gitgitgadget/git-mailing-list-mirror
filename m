From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] whatchanged: document its historical nature
Date: Fri, 09 Aug 2013 13:01:48 -0700
Message-ID: <7v38qi63bn.fsf_-_@alter.siamese.dyndns.org>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<52027B17.7040602@googlemail.com>
	<7vtxj1crv6.fsf@alter.siamese.dyndns.org>
	<CALkWK0kTfQYZG8R1EMuV37pdJ-aj9btXmfJ1Fb4QoMeZ1QucAw@mail.gmail.com>
	<vpqfvukdy39.fsf@anie.imag.fr>
	<CALkWK0kD=adWKVf+zb+Pnjz-HBkhks8ZvmQ3eYSpdXvahr=e4g@mail.gmail.com>
	<vpqvc3gcijh.fsf@anie.imag.fr>
	<7vwqnw9jv6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Aug 09 22:02:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7sso-0005Ma-Nw
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:01:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030921Ab3HIUBz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 16:01:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030899Ab3HIUBy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 16:01:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 657DF37BB0;
	Fri,  9 Aug 2013 20:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0MXStymYr/Hy8CfmtoxejotjWY8=; b=ukzJLQ
	9ijmntoUWZwHVEx5wx24X+PmeWpfXqXNteGuYgWDsfmLwvykZ0bvX2MipNg74tXY
	RhMUVlE9rSs6lA3pCFPoR1o3z51HmQbETaO3t5XktfizHCzEzq0KNoNYtyjCYnOk
	ok/5fAburnIfgfNAmReINhoxxRV/LMtfJrm80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T/cUqvGSY7B3vLuCxMsq8yFwwoWLNPwX
	w+M+8W6A8hLm4rtUzSUhryQwscKEHE8talGM7kuKwq26h6/amqDmE6pNjOfO/1oJ
	HD/Kb8XSy704fGJg4IPAn8DJD4MDtfoTatFtNazstMY408Hc1aNYvaqAZu189cj9
	9IGrI3Jk+T8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5810737BAF;
	Fri,  9 Aug 2013 20:01:51 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6081A37BAE;
	Fri,  9 Aug 2013 20:01:50 +0000 (UTC)
In-Reply-To: <7vwqnw9jv6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 08 Aug 2013 10:23:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 87772AD6-012E-11E3-A3D8-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232017>

After doing a bit of archaeology, I now know why "whatchanged" with
an unwieldy long name persisted in the user's mindset for so long.

My conclusions are:

 - It is better to encourage new users to use `log` very early in
   the document;

 - It is not sensible to remove the command at this point yet.
   After having used to `log` that does not take diff options for
   close to a year, it is understandable why there are many people
   who are used to type `whatchanged`.

It could be argued that deprecation and retraining of fingers are
doing favors to the long-time users.  But the presense of the
command is not hurting anybody, other than the new people who may
stumble upon both and wonder what their differences are.  By clearly
indicating that these two are essentially the same, we would help
the new people without harming anybody.

-- >8 --
Subject: [PATCH] whatchanged: document its historical nature

Encourage new users to use 'log' instead.  These days, these
commands are unified and just have different defaults.

'git log' only allowed you to view the log messages and no diffs
when it was added in early June 2005.  It was only in early April
2006 that the command learned to take diff options.  Because of
this, power users tended to use 'whatchanged' that already existed
since mid May 2005 and supported diff options.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Documentation/git-whatchanged.txt | 41 ++++++++-------------------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index c600b61..6faa200 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -13,43 +13,18 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Shows commit logs and diff output each commit introduces.  The
-command internally invokes 'git rev-list' piped to
-'git diff-tree', and takes command line options for both of
-these commands.
 
-This manual page describes only the most frequently used options.
+Shows commit logs and diff output each commit introduces.
 
+New users are encouraged to use linkgit:git-log[1] instead.  The
+`whatchanged` command is essentially the same as linkgit:git-log[1]
+run with different defaults that shows a --raw diff outputat the
+end.
 
-OPTIONS
--------
--p::
-	Show textual diffs, instead of the Git internal diff
-	output format that is useful only to tell the changed
-	paths and their nature of changes.
+The command is kept primarily for historical reasons; fingers of
+many people who learned Git long before `git log` was invented by
+reading Linux kernel mailing list are trained to type it.
 
--<n>::
-	Limit output to <n> commits.
-
-<since>..<until>::
-	Limit output to between the two named commits (bottom
-	exclusive, top inclusive).
-
--r::
-	Show Git internal diff output, but for the whole tree,
-	not just the top level.
-
--m::
-	By default, differences for merge commits are not shown.
-	With this flag, show differences to that commit from all
-	of its parents.
-+
-However, it is not very useful in general, although it
-*is* useful on a file-by-file basis.
-
-include::pretty-options.txt[]
-
-include::pretty-formats.txt[]
 
 Examples
 --------
-- 
1.8.4-rc2-195-gb76a8e9
