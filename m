From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Documentation fix: git log -p does not imply -c.
Date: Tue, 08 Mar 2011 16:58:19 -0800
Message-ID: <7vtyfdaz4k.fsf@alter.siamese.dyndns.org>
References: <7vsjuyzckd.fsf@alter.siamese.dyndns.org>
 <1299545378-22036-1-git-send-email-haircut@gmail.com>
 <7vmxl5e6ur.fsf@alter.siamese.dyndns.org> <4D7695A9.8070403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 01:58:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px7jf-0000IA-0F
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 01:58:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927Ab1CIA6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 19:58:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611Ab1CIA6g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 19:58:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DDB534B01;
	Tue,  8 Mar 2011 19:59:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2Uh3I5sZRpx9CnRDS+THbrIZP+Y=; b=vL7I3U
	MLhLmX+3p9VL3yJHZBY+rl0ZdQwY3c8MfImaPBHihPygRv1vWDZXlm9IMOhQOU9j
	3GembhCo+CYwaALUi791PqFajwOC0KzLkMDmswatWUREFU02Z0vPxtzFCJVAcg+5
	aMO+Bp4l2/aS1kAz0PSkptmxL3jR9kYTJgI6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SBtyHI5WA624SbKcmjaAezjUkAU9OR5E
	Uyni4LYoM+K6UuHKyXCM/EVTrku9nrCNOx0gON5vh82LX1fnEw/kTQJHqqDR7c/L
	Hc7xK01bCOmz3BRSe7mTwCIMU3vz1zv9Hki+XCd7SkXHU5l4ElXWjEjWZwqY8ika
	ovdhXilskjY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9A7474B00;
	Tue,  8 Mar 2011 19:59:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 43AA74AFE; Tue,  8 Mar 2011
 19:59:47 -0500 (EST)
In-Reply-To: <4D7695A9.8070403@gmail.com> (Adam Monsen's message of "Tue, 08
 Mar 2011 12:46:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BA72DC2-49E8-11E0-8B29-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168717>

Adam Monsen <haircut@gmail.com> writes:

> I read some stuff before writing it (like
> Documentation/SubmittingPatches), but what I should have done is just
> thumb through the log. Many commit messages are as you say they should be.

See below...

> The suggested *format* of a commit message is covered in DISCUSSION in
> git-commit(1). This guide covers philosophy of commit messages.
>
> - Read previous commit messages. Emulate the best ones.

I thought you were trying to teach new people how to gauge the "goodness"
with this list.  How would they know which ones are "best"? ;-)

> - Answer questions you anticipate others will ask.

Not quite sure.  I'd rather see people ask questions to themselves while
working on the change, so that the end product does not have even a room
for questioning.

> - Reveal your intentions.
> - Imagine you are reading this same commit message 10 years from now.
>   What would be most helpful for you to quickly recall why these
>   changes were made?
> - Imagine someone else is reading this same commit message 10 years
>   from now. What would be most helpful for them to quickly understand
>   what this commit changes and why it was done?

These three points are important and are the same thing.  I often
encourage people to write their logs while keeping these points in mind:

 (1) Remember that only the first paragraph is shown in MUA (as Subject:)
     and output from tools like "git shortlog", "git log --oneline", "gitk"
     and "gitweb".  Say what the change is about concisely and clearly
     there.

     A good "Subject:" greatly helps me writing Release Notes; if shortlog
     output does not remind me what the change is about, I would need to
     go back to "git show", which is very time consuming.

 (2) Explain the problem you are trying to solve first.  Don't stop at
     saying "'git xyzzy' ran with the --frotz option does not work".

     Clearly define why you think the current behaviour is broken and what
     you think is expected.  I.e. say "'git xyzzy' ran with the --frotz
     option does not show nitfol from its output; it should" instead of
     just "does not work".

     You may discuss earlier design decisions that you do not agree with
     (e.g. "The commit that introduced the option explains why nitfol does
     not matter under --frotz mode, but it is useful to have in this use
     case...") here.

     The second paragraph is primarily to make sure that future people
     reading the log know what effect the change _wanted_ to make, in case
     the code gets broken later and started doing different things, or the
     change is buggy from day one and didn't work as advertised in the
     commit log message.

     A good problem description also helps the reviewers to spot X-Y
     problem at the design level.  A patch that addresses a non-existent
     problem is not worth reading nor commenting on---the time is better
     spent on giving an alternative solution to the real problem the patch
     author wanted to address.

 (3) Then describe your solution.  You may want to give observations on
     the current code (e.g. "This is because the code in the frotz()
     function that calls xyzzy_output() forgets to set the nitfol flag")
     if this is about an implementation bug whose solution is subtle.

     Optionally discuss alternative approaches you considered, if any, and
     state the reason you ended up solving the problem differently.

     This section is to give hints to later people about other approaches
     already attempted and failed (or not tried due to lack of time, but
     may be worth pursuing).

 (4) If it is a performance fix/enhancement, benchmarking result would
     come here.

I try to give this list to new contributors early in their initiation
process (ideally before their patches hit the codebase).  That is probably
why many of the existing commits you saw in "git log" more or less
conformed to the recommendation.

> - Be verbose!

Please don't.  We want sufficiently detailed description, but we don't
want verbosity.

> If you want a guide like this, some questions:
> * do you want asciidoc, something else, or don't care?
> * name it Documentation/CommitMessageGuide ? or something else?

I think people who wrote the existing "Checklist" section on "Commits:"
meant to outline what constitutes a good commit log message (look for "the
body should").  It already says "motivation" and "contrast with previous
behaviour".  Cf.  47afed5 (SubmittingPatches: itemize and reflect upon
well written changes, 2009-04-28).

I unfortunately don't seem to be able to parse what the last part of what
47afed5 brought in is trying to say.  Perhaps a bad cut-and-paste job?

How about this as a not-too-verbose compromise?

-- >8 --
Subject: SubmittingPatches: clarify the expected commit log description

Earlier, 47afed5 (SubmittingPatches: itemize and reflect upon well written
changes, 2009-04-28) added a discussion on the contents of the commit log
message, but the last part of the new paragraph didn't make much sense.
Reword it slightly to make it more readable.

Update the "quicklist" to clarify what we mean by "motivation" and
"contrast".  Also mildly discourage external references.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 72741eb..c3b0816 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -10,10 +10,18 @@ Checklist (and a short version for the impatient):
 	  description (50 characters is the soft limit, see DISCUSSION
 	  in git-commit(1)), and should skip the full stop
 	- the body should provide a meaningful commit message, which:
-		- uses the imperative, present tense: "change",
-		  not "changed" or "changes".
-		- includes motivation for the change, and contrasts
-		  its implementation with previous behaviour
+	  . explains the problem the change tries to solve, iow, what
+	    is wrong with the current code without the change.
+	  . justifies the way the change solves the problem, iow, why
+	    the result with the change is better.
+	  . alternate solutions considered but discarded, if any.
+	- describe changes in imperative mood, e.g. "make xyzzy do frotz"
+	  instead of "[This patch] makes xyzzy do frotz" or "[I] changed
+	  xyzzy to do frotz", as if you are giving orders to the codebase
+	  to change its behaviour.
+	- try to make sure your explanation can be understood without
+	  external resources. Instead of giving a URL to a mailing list
+	  archive, summarize the relevant points of the discussion.
 	- add a "Signed-off-by: Your Name <you@example.com>" line to the
 	  commit message (or just use the option "-s" when committing)
 	  to confirm that you agree to the Developer's Certificate of Origin
@@ -90,7 +98,10 @@ your commit head.  Instead, always make a commit with complete
 commit message and generate a series of patches from your
 repository.  It is a good discipline.
 
-Describe the technical detail of the change(s).
+Give an explanation for the change(s) that is detailed enough so
+that people can judge if it is good thing to do, without reading
+the actual patch text to determine how well the code does what
+the explanation promises to do.
 
 If your description starts to get too long, that's a sign that you
 probably need to split up your commit to finer grained pieces.
@@ -99,9 +110,8 @@ help reviewers check the patch, and future maintainers understand
 the code, are the most beautiful patches.  Descriptions that summarise
 the point in the subject well, and describe the motivation for the
 change, the approach taken by the change, and if relevant how this
-differs substantially from the prior version, can be found on Usenet
-archives back into the late 80's.  Consider it like good Netiquette,
-but for code.
+differs substantially from the prior version, are all good things
+to have.
 
 Oh, another thing.  I am picky about whitespaces.  Make sure your
 changes do not trigger errors with the sample pre-commit hook shipped
