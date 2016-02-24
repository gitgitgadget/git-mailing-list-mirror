From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Wed, 24 Feb 2016 10:34:00 -0800
Message-ID: <xmqqtwkyt0tj.fsf@gitster.mtv.corp.google.com>
References: <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
	<xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
	<20160223014741.GA21025@wfg-t540p.sh.intel.com>
	<xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
	<20160223091740.GA3830@wfg-t540p.sh.intel.com>
	<20160223103253.GE5273@mwanda>
	<20160223120015.GA10488@wfg-t540p.sh.intel.com>
	<20160223133135.GF5273@mwanda>
	<20160224025519.GB16562@wfg-t540p.sh.intel.com>
	<xmqqpovmmxhv.fsf@gitster.mtv.corp.google.com>
	<20160224070727.GA23808@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dan Carpenter <dan.carpenter@oracle.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>, git@vger.kernel.org,
	ying.huang@intel.com, philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Christoph Hellwig <hch@lst.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Fengguang Wu <fengguang.wu@intel.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 24 19:34:24 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYeGW-0007Id-6A
	for glk-linux-kernel-3@plane.gmane.org; Wed, 24 Feb 2016 19:34:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758761AbcBXSeO (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 24 Feb 2016 13:34:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62873 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757550AbcBXSeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Feb 2016 13:34:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9CC9D45B8D;
	Wed, 24 Feb 2016 13:34:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=//Ou9cIWQH6MLuYvRftokA1UC0Y=; b=G5enff
	o+fa+0ALRDEQhBrNWmWOpCY6bkfwOMcmrad8U61MRzvVJJkhaUYhHfLB+yKWxbKz
	LDh8a8w41+BPX0ETZJJKCKnoHoopCjy6h5ZeIAOKMbXF55ih+5xrDF0topJv3Niw
	oLfVxQy+Dc7aprBgv2DZBF+x5MuZrHcbMReNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rehf4uZaBfdhnthu2JtIdAhOpvojAFcq
	6Zo9W5krvVtrOFOYdpDpwnFCw5ifveG+IR0dwE6mFhkiqPNn6DeMSBjAvDHSfYSb
	tqRCxV+TcuRNwMcNB26MUebQajJGumCezHVRkyqHmCdJTN/50i68OyCzFP4yI/UM
	zsQulMnH2Dg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2EA8345B8C;
	Wed, 24 Feb 2016 13:34:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0A9DA45B8A;
	Wed, 24 Feb 2016 13:34:01 -0500 (EST)
In-Reply-To: <20160224070727.GA23808@wfg-t540p.sh.intel.com> (Fengguang Wu's
	message of "Wed, 24 Feb 2016 15:07:27 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D0C7424-DB25-11E5-BA96-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287214>

Fengguang Wu <fengguang.wu@intel.com> writes:

>> This starts to sound more like something you would want to write in
>> the cover letter, or the trailer block next to Signed-off-by: at the
>> end of the first patch in the series.
>
> Yes, that's roughly what the current patch does, except in the latter
> case we add new info after diffstat.
>
>> Or even after the mail
>> signature at the very end of the message (incidentally that would
>> probably minimize the damage to the Git codebase needed for this
>> addition--you should be able to do this without touching anything
>> other than builtin/log.c).
>
> That's an interesting place. It looks worth trying. 

Here is an outline of such a structure.  The idea is for a history
of this shape, where "P" is the well-known public commit (e.g. one
in Linus's tree), "X", "Y", "Z" are prerequisite patches in flight,
and "A", "B", "C" are the work being sent out for testing,

	 ---P---X---Y---Z---A---B---C

the submitter would say "format-patch --base=P -3 C" (or variants
thereof, e.g. with "--cover" or using "Z..C" instead of "-3 C" to
specify the range), and the identifiers for P, X, Y, Z are appended
at the end of the _first_ message (either the cover letter or the
first patch in the series).

You are welcome to steal this as a skeleton and take authorship, as
I do not plan to spend too much more time on actually implementing
prepare_bases() function myself unless I run out of things to do and
get bored, but I think there are already sufficient helper functions
to do this (you may want to make commit_patch_id() in patch-ids.c a
public helper function).

 builtin/log.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 069bd3a..8f6cc17 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1182,6 +1182,59 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+struct base_tree_info {
+	struct object_id base_commit;
+	int nr_patch_id, alloc_patch_id;
+	struct object_id *patch_id;
+};
+
+static void prepare_bases(struct base_tree_info *bases,
+			  const char *base_commit,
+			  struct commit **list)
+{
+	/*
+	 * If you are given --base=$commit command line argument, that
+	 * names commit 'P' when you are formatting A, B and C in this
+	 * history (i.e. "format-patch --base=P Z..C"):
+	 *
+	 * ---P---X---Y---Z---A---B---C
+	 *
+	 * where "P" is the well-known public commit (e.g. one in
+	 * Linus's tree), "X", "Y", "Z" are prerequisite patches in
+	 * flight whose patch-ids are well-known, and "A", "B", "C"
+	 * are the work being sent out for testing, you would compute
+	 * base_commit=P, patch_ids[] = map(commit_patch_id, [X, Y,
+	 * Z]) here and stuff them in bases structure.
+	 *
+	 * Be sure to check error (e.g. invalid base_commit) and die()
+	 * here as necessary.
+	 */
+	
+}
+
+static void print_bases(struct base_tree_info *bases)
+{
+	int i;
+
+	/* Only do this once, either for the cover or for the first one */
+	if (is_null_oid(&bases->base_commit))
+		return;
+
+	printf("** base-commit-info **\n");
+
+	/* Show the base commit */
+	printf("base-commit: %s\n", oid_to_hex(&bases->base_commit));
+
+	/* Show the prerequisite patches */
+	for (i = 0; i < bases->nr_patch_id; i++)
+		printf("base-patch-id: %s\n", oid_to_hex(&bases->patch_id[i]));
+
+	free(&bases->patch_id);
+	bases->nr_patch_id = 0;
+	bases->alloc_patch_id = 0;
+	oidclr(&bases->base_commit);
+}
+
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
 {
 	struct commit *commit;
@@ -1205,6 +1258,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int reroll_count = -1;
 	char *branch_name = NULL;
 	char *from = NULL;
+	char *base_commit = NULL;
+	struct base_tree_info bases;
+
 	const struct option builtin_format_patch_options[] = {
 		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
 			    N_("use [PATCH n/m] even with a single patch"),
@@ -1265,6 +1321,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
+		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
+			   N_("add prerequisite tree info to the patch series")),
 		OPT_FILENAME(0, "signature-file", &signature_file,
 				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
@@ -1496,6 +1554,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		signature = strbuf_detach(&buf, NULL);
 	}
 
+	if (base_commit) {
+		memset(&bases, 0, sizeof(bases));
+		prepare_bases(&bases, base_commit, list);
+	}
+
 	if (in_reply_to || thread || cover_letter)
 		rev.ref_message_ids = xcalloc(1, sizeof(struct string_list));
 	if (in_reply_to) {
@@ -1509,6 +1572,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, use_stdout,
 				  origin, nr, list, branch_name, quiet);
+		print_bases(&bases);
 		total++;
 		start_number--;
 	}
@@ -1574,6 +1638,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				       rev.mime_boundary);
 			else
 				print_signature();
+			print_bases(&bases);
 		}
 		if (!use_stdout)
 			fclose(stdout);
