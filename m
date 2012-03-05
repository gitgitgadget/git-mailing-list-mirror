From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A possible fmt-merge-msg update?
Date: Mon, 05 Mar 2012 11:04:21 -0800
Message-ID: <7vipii27ka.fsf@alter.siamese.dyndns.org>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org>
 <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Mar 05 20:04:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4dCx-0007jf-5G
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 20:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757475Ab2CETEZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 14:04:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757336Ab2CETEY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 14:04:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A55806F0D;
	Mon,  5 Mar 2012 14:04:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wJcS8+7f6eCwLJG0rVY3CV59dfE=; b=NFzaac
	UTS1Q06W4ncNYcYcbgMJ7Z5uXx/81h4aNR2FYmTuAtVhmiUGgHcHohYelh+FcEVP
	LdtbyVwXNufBy/NFMeAiNtjOJupA7mB9ByCaiyQZyk6dg1kFULHI6iKZRB4ZN4ZO
	nSDrjPZ0AcPv2MwAtZpF/M2w1uCQRvm4oa2Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HX4+oHUTIwaCScyGQ6IEADq+oTgzCma8
	AKSREOPMHWdUd0fQIBimwLbajfjpIngs7vbpHT38EA4lQjDN3fl8C4CPbYLFIvpr
	R4pspRTwY1+7LKuxVmUlsu/m7Y9xk2bisWwnzXQAEnix9tv7syQmZNvEkDkrsOVK
	soWd6ZiDz2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C36B6F0B;
	Mon,  5 Mar 2012 14:04:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E7906F0A; Mon,  5 Mar 2012
 14:04:22 -0500 (EST)
In-Reply-To: <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com> (Linus
 Torvalds's message of "Sun, 4 Mar 2012 21:24:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 04D0A702-66F6-11E1-A3F7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192263>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, Mar 4, 2012 at 7:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Having observed a handful of your recent merge messages, I am wondering if
>> it would help to teach fmt-merge-msg to include "from Wim Van Sebroeck" in
>> its output by taking the committer of the MERGE_HEAD into account.
>>
>> Not worth the trouble?
>
> Hmm. Maybe worth it.
> ...
> It might be interesting if the pre-written commit message had the top
> committer in a comment (the same way pulling a tag has the tag author
> in the comment about the tag verification). That way the information
> would be right there when I edit the message, and since it's correct
> 99% of the time it would make it easier to just edit it in the editor
> than have to cut-and-paste it from the email. But because it's not a
> sure thing,...

The attached would give me:

| Merge branch 'jl/maint-submodule-relative'
| 
| # Jens Lehmann (3) and Johannes Sixt (1)
| * jl/maint-submodule-relative:
|   submodules: fix ambiguous absolute paths under Windows
|   submodules: refactor computation of relative gitdir path
|   submodules: always use a relative path from gitdir to work tree
|   submodules: always use a relative path to gitdir

It would be a sure thing for the commit-authorship, so we could use
"By " instead of "# " above, but it should be obvious either way.

The existing test vectors need to be taught about this change if we
were to do something like this.

-- >8 --
Subject: [PATCH] fmt-merge-msg: show primary authors of a merged series

As we already walk the history of the branch that gets merged to
come up with a short log, let's label it with names of the primary
authors, so that the user who summarizes the merge can easily give
credit to them in the log message.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fmt-merge-msg.c |   61 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index c81a7fe..7eea066 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -180,6 +180,63 @@ static void add_branch_desc(struct strbuf *out, const char *name)
 	strbuf_release(&desc);
 }
 
+static void record_author(struct string_list *authors, struct commit *commit)
+{
+	char name_buf[MAX_GITNAME], *name, *name_end;
+	struct string_list_item *elem;
+
+	name = strstr(commit->buffer, "\nauthor ");
+	if (!name)
+		return;
+	name += strlen("\nauthor ");
+	name_end = strchrnul(name, '<');
+	if (*name_end)
+		name_end--;
+	while (isspace(*name_end) && name <= name_end)
+		name_end--;
+	if (name_end < name || name + MAX_GITNAME <= name_end)
+		return;
+	memcpy(name_buf, name, name_end - name + 1);
+	name_buf[name_end - name + 1] = '\0';
+
+	elem = string_list_lookup(authors, name_buf);
+	if (!elem) {
+		elem = string_list_insert(authors, name_buf);
+		elem->util = (void *) 0;
+	}
+	elem->util = (void*)(((intptr_t)elem->util) + 1);
+}
+
+#define util_as_int(elem) ((intptr_t)((elem)->util))
+
+static int cmp_string_list_util_as_int(const void *a_, const void *b_)
+{
+	const struct string_list_item *a = a_, *b = b_;
+	return util_as_int(b) - util_as_int(a);
+}
+
+static void add_author_info(struct strbuf *out, struct string_list *authors)
+{
+	if (!authors->nr)
+		return;
+	qsort(authors->items, authors->nr, sizeof(authors->items[0]),
+	      cmp_string_list_util_as_int);
+
+	strbuf_addstr(out, "\n# ");
+	if (authors->nr == 1)
+		strbuf_addf(out, "%s", authors->items[0].string);
+	else if (authors->nr == 2)
+		strbuf_addf(out, "%s (%d) and %s (%d)",
+			    authors->items[0].string,
+			    (int)util_as_int(&authors->items[0]),
+			    authors->items[1].string,
+			    (int)util_as_int(&authors->items[1]));
+	else
+		strbuf_addf(out, "%s (%d) and others",
+			    authors->items[0].string,
+			    (int)util_as_int(&authors->items[0]));
+}
+
 static void shortlog(const char *name,
 		     struct origin_data *origin_data,
 		     struct commit *head,
@@ -190,6 +247,7 @@ static void shortlog(const char *name,
 	struct commit *commit;
 	struct object *branch;
 	struct string_list subjects = STRING_LIST_INIT_DUP;
+	struct string_list authors = STRING_LIST_INIT_DUP;
 	int flags = UNINTERESTING | TREESAME | SEEN | SHOWN | ADDED;
 	struct strbuf sb = STRBUF_INIT;
 	const unsigned char *sha1 = origin_data->sha1;
@@ -212,6 +270,7 @@ static void shortlog(const char *name,
 		if (commit->parents && commit->parents->next)
 			continue;
 
+		record_author(&authors, commit);
 		count++;
 		if (subjects.nr > limit)
 			continue;
@@ -226,6 +285,7 @@ static void shortlog(const char *name,
 			string_list_append(&subjects, strbuf_detach(&sb, NULL));
 	}
 
+	add_author_info(out, &authors);
 	if (count > limit)
 		strbuf_addf(out, "\n* %s: (%d commits)\n", name, count);
 	else
@@ -246,6 +306,7 @@ static void shortlog(const char *name,
 	rev->commits = NULL;
 	rev->pending.nr = 0;
 
+	string_list_clear(&authors, 0);
 	string_list_clear(&subjects, 0);
 }
 
-- 
1.7.9.2.413.ge58a8e
