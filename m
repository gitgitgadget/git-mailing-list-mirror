From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Fri, 10 Dec 2010 13:59:50 -0800
Message-ID: <7v4oalcmqx.fsf@alter.siamese.dyndns.org>
References: <7v62v8ufyl.fsf@alter.siamese.dyndns.org>
 <20101206082948.1403cc5a@chalon.bertin.fr>
 <buopqtfmi85.fsf@dhlpc061.dev.necel.com>
 <20101206092122.21c19011@chalon.bertin.fr>
 <AANLkTimPC3-x1XFJ+t9uiFFXV6fg812ugF5vz9p=4GWB@mail.gmail.com>
 <20101206094806.10ae1ff2@chalon.bertin.fr>
 <AANLkTinJu0KzXZ2Rjbs2+XH7T=Gq5MOajxo51DHtqoGZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <dirson@bertin.fr>, git list <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Dec 10 23:00:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRB0d-0002RS-Dr
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 23:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158Ab0LJWAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 17:00:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35244 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756034Ab0LJWAD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 17:00:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 702583035;
	Fri, 10 Dec 2010 17:00:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sGb7NYTivkctCfhRAxz90vyPLQ8=; b=tikhRw
	St3W9tFnCyrW36Vp0ggLHl/C4YZY7qAKH3zln57MEer0BNVwssZpzDvK4UT47JAq
	7LHwPCjaZ7LxFyv5RAXC6bRkS5jUsDHnwlTkMh8zsk8SBQ2eb8cZFwvkIMrYybNl
	nSvqp4pG9SIvnEbOKA3RN1y8pme/m/xAUdyKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oeXAvLDue3c/IMoi6tJ74Q8K35HvACDm
	tPYt2gJ/KuO0RaQAVVNSuwNLT4Qi/urYVQTkTTgSBqTcMRo3P0Rqp6Wa9a5CrH+g
	JmQbA9qV/wB+lnQoLjnAJ/+gw6fCMO6N/oFxtI24oODlq/K+O8utekZZj7tXMTwe
	1X2YZ3CT5CE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D2B03034;
	Fri, 10 Dec 2010 17:00:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BEFAF3030; Fri, 10 Dec 2010
 17:00:18 -0500 (EST)
In-Reply-To: <AANLkTinJu0KzXZ2Rjbs2+XH7T=Gq5MOajxo51DHtqoGZ@mail.gmail.com>
 (Miles Bader's message of "Mon\, 6 Dec 2010 18\:13\:06 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E317D5C8-04A8-11E0-9098-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163442>

Miles Bader <miles@gnu.org> writes:

> Maybe if you renamed every option simultaneously, there would be
> confusion, but seriously, it's only one option.  It's not going to be
> a problem.

Well, let's avoid all of that trouble before it is too late, by putting
this on top of what is in 'next' and ship 1.7.4 with it.

Between "find" and "detect", I do not have much preference either way.  It
may sound more active to "find" them, but if told to "detect" them, git
goes ahead and actively changes its internal behaviour in order to do so,
which amounts to an active "find"ing anyway, so...

-- >8 --
From: Yann Dirson <ydirson@altern.org>
Date: Wed, 10 Nov 2010 21:27:12 +0100
Subject: [PATCH] diff: use "find" instead of "detect" as prefix for long forms of -M and -C

It is more consistent with existing --find-copies-harder; luckily "detect"
variant has not appeared in any officially released version of git.

Signed-off-by: Yann Dirson <ydirson@altern.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/diff-options.txt |    5 ++---
 diff.c                         |   18 +++++++++---------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7246e10..c93124b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -230,7 +230,7 @@ eligible for being picked up as a possible source of a rename to
 another file.
 
 -M[<n>]::
---detect-renames[=<n>]::
+--find-renames[=<n>]::
 ifndef::git-log[]
 	Detect renames.
 endif::git-log[]
@@ -246,12 +246,11 @@ endif::git-log[]
 	hasn't changed.
 
 -C[<n>]::
---detect-copies[=<n>]::
+--find-copies[=<n>]::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
 	If `n` is specified, it has the same meaning as for `-M<n>`.
 
 --find-copies-harder::
---detect-copies-harder::
 	For performance reasons, by default, `-C` option finds copies only
 	if the original file of the copy was modified in the same
 	changeset.  This flag makes the command
diff --git a/diff.c b/diff.c
index dee0bd8..b5ef1ec 100644
--- a/diff.c
+++ b/diff.c
@@ -3150,14 +3150,14 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
 			return -1;
 	}
-	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--detect-renames=") ||
-		 !strcmp(arg, "--detect-renames")) {
+	else if (!prefixcmp(arg, "-M") || !prefixcmp(arg, "--find-renames=") ||
+		 !strcmp(arg, "--find-renames")) {
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return -1;
 		options->detect_rename = DIFF_DETECT_RENAME;
 	}
-	else if (!prefixcmp(arg, "-C") || !prefixcmp(arg, "--detect-copies=") ||
-		 !strcmp(arg, "--detect-copies")) {
+	else if (!prefixcmp(arg, "-C") || !prefixcmp(arg, "--find-copies=") ||
+		 !strcmp(arg, "--find-copies")) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
 			DIFF_OPT_SET(options, FIND_COPIES_HARDER);
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
@@ -3194,7 +3194,7 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_OPT_SET(options, TEXT);
 	else if (!strcmp(arg, "-R"))
 		DIFF_OPT_SET(options, REVERSE_DIFF);
-	else if (!strcmp(arg, "--find-copies-harder") || !strcmp(arg, "--detect-copies-harder"))
+	else if (!strcmp(arg, "--find-copies-harder"))
 		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
 	else if (!strcmp(arg, "--follow"))
 		DIFF_OPT_SET(options, FOLLOW_RENAMES);
@@ -3380,12 +3380,12 @@ static int diff_scoreopt_parse(const char *opt)
 			opt += strlen("break-rewrites");
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'B';
-		} else if (!prefixcmp(opt, "detect-copies")) {
-			opt += strlen("detect-copies");
+		} else if (!prefixcmp(opt, "find-copies")) {
+			opt += strlen("find-copies");
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'C';
-		} else if (!prefixcmp(opt, "detect-renames")) {
-			opt += strlen("detect-renames");
+		} else if (!prefixcmp(opt, "find-renames")) {
+			opt += strlen("find-renames");
 			if (*opt == 0 || *opt++ == '=')
 				cmd = 'M';
 		}
-- 
1.7.3.3.710.g2d012
