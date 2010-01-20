From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 13:59:36 -0800
Message-ID: <7v3a201lpz.fsf@alter.siamese.dyndns.org>
References: <20100120050343.GA12860@gnu.kitenet.net>
 <201001201148.11701.johan@herland.net>
 <20100120182438.GB31507@gnu.kitenet.net>
 <7vhbqg376b.fsf@alter.siamese.dyndns.org>
 <20100120195626.GA6641@gnu.kitenet.net>
 <7vska01qrt.fsf@alter.siamese.dyndns.org>
 <4B576F5C.2050102@drmicha.warpmail.net>
 <7veilk1o3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 22:59:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXiaj-0002g8-63
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 22:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab0ATV7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 16:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751954Ab0ATV7x
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 16:59:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab0ATV7w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 16:59:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11E4992A6C;
	Wed, 20 Jan 2010 16:59:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SDa2RyaSpkEtgFr+HL7xsiH0KMc=; b=Xc4iSZ
	v+BVSewHJ9wmWyFJR7QPctF62qtnFJvycxfnv8MIFNr9j44cErw9/dJLIlj7cOv1
	T0ziMP2FgFuuUZkgca0dR8UYTRx577BOOms2qzKAdlns7g6mRXVTvXLnvTWosf7p
	KhrFaxPyOmzMJFwy6Ve8FzdXpC8LrJKvZFXek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tRcEV8O4VqGOI1AQ+3EIqya3p/7g5Lyx
	F2chldjvqqz9sWpQXFGTWPuMw7NBlzUg+ukfYudBJvZ6c1wP6oHVRaPPaoFqhc8e
	TRxCEUHBXFYF4NVbqWEiaRDaOnG9AT7EHHbQCWwxjeiY4RRK9/+dkXBU0oFb9H3g
	aFH7o8oJsI0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A39C092A6A;
	Wed, 20 Jan 2010 16:59:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5390992A67; Wed, 20 Jan
 2010 16:59:38 -0500 (EST)
In-Reply-To: <7veilk1o3s.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 20 Jan 2010 13\:08\:07 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1E42310A-060F-11DF-964C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137590>

Junio C Hamano <gitster@pobox.com> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> No, but outputting the note as part of the log is the standard. So for
>> example, when you do a format-patch | apply cycle, format-patch will
>> insert the note as part of the commit message, and apply will *store*
>> the note text (including Note:\n) as part of the commit message of the
>> new commit.
>
> Thanks; that was the kind of breakage report I was looking for (and wished
> to have heard a lot earlier).  Personally I find it is unexcusable that
> format-patch defaults to giving notes.
>
>> So, I would say the notes feature is not that well integrated right now,
>
> No question about it.

How about solving it this way?

It _could_ break some tests, if the set of tests were carefully written to
cover not only the positive ("I am showing off my shiny new toy") cases
but also the negative ("These commands share the same codepath touched by
the series, but I don't intend to change their behaviour, and here is to
make sure the new toy does not affect them") cases and the latter set
assumed it is ok to sprinkle notes in commit log messages without being
asked, but I haven't tried running the test suite yet.

---
Subject: Fix "log" family not to be too agressive about showing notes

Giving "Notes" information in the default output format of "log" and
"show" is a sensible progress (the user has asked for it by having the
notes), but for some commands (e.g. "format-patch") spewing notes into the
formatted commit log message without being asked is too aggressive.

Enable notes output only for "log", "show", "whatchanged" by default;
other users can ask for it by setting show_notes field to true.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-log.c |    2 ++
 commit.h      |    1 +
 log-tree.c    |    1 +
 pretty.c      |    2 +-
 revision.c    |    4 ++++
 revision.h    |    1 +
 6 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 41b6df4..da0ba1d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -41,6 +41,8 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	if (fmt_pretty)
 		get_commit_format(fmt_pretty, rev);
+	else
+		rev->show_notes = 1;
 	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->show_root_diff = default_show_root;
diff --git a/commit.h b/commit.h
index e5332ef..2c0742b 100644
--- a/commit.h
+++ b/commit.h
@@ -70,6 +70,7 @@ struct pretty_print_context
 	const char *after_subject;
 	enum date_mode date_mode;
 	int need_8bit_cte;
+	int show_notes;
 	struct reflog_walk_info *reflog_info;
 };
 
diff --git a/log-tree.c b/log-tree.c
index 0fdf159..27afcf6 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -284,6 +284,7 @@ void show_log(struct rev_info *opt)
 	struct pretty_print_context ctx = {0};
 
 	opt->loginfo = NULL;
+	ctx.show_notes = opt->show_notes;
 	if (!opt->verbose_header) {
 		graph_show_commit(opt->graph);
 
diff --git a/pretty.c b/pretty.c
index 8f5bd1a..b2ee7fe 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1094,7 +1094,7 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	if (fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	if (fmt != CMIT_FMT_ONELINE)
+	if (context->show_notes)
 		get_commit_notes(commit, sb, encoding,
 				 NOTES_SHOW_HEADER | NOTES_INDENT);
 
diff --git a/revision.c b/revision.c
index 25fa14d..03c280f 100644
--- a/revision.c
+++ b/revision.c
@@ -1165,6 +1165,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if (!prefixcmp(arg, "--pretty=") || !prefixcmp(arg, "--format=")) {
 		revs->verbose_header = 1;
 		get_commit_format(arg+9, revs);
+	} else if (!strcmp(arg, "--show-notes")) {
+		revs->show_notes = 1;
+	} else if (!strcmp(arg, "--no-notes")) {
+		revs->show_notes = 0;
 	} else if (!strcmp(arg, "--oneline")) {
 		revs->verbose_header = 1;
 		get_commit_format("oneline", revs);
diff --git a/revision.h b/revision.h
index d368003..4167c1e 100644
--- a/revision.h
+++ b/revision.h
@@ -80,6 +80,7 @@ struct rev_info {
 	/* Format info */
 	unsigned int	shown_one:1,
 			show_merge:1,
+			show_notes:1,
 			abbrev_commit:1,
 			use_terminator:1,
 			missing_newline:1,
