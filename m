From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/17] Clean up how fetch_pack() handles the heads list
Date: Sat, 25 Aug 2012 09:05:26 +0200
Message-ID: <50387936.1000205@alum.mit.edu>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu> <20120823092624.GG6963@sigill.intra.peff.net> <49DEA56853C64B9B900D3C7F886D4FA6@PhilipOakley> <20120823195648.GB15268@sigill.intra.peff.net> <20120823203152.GA1810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010907070209050505050605"
Cc: Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 25 09:06:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5ARm-0000rx-Mq
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 09:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774Ab2HYHFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 03:05:32 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:52125 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752591Ab2HYHFa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Aug 2012 03:05:30 -0400
X-Greylist: delayed 1217 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Aug 2012 03:05:29 EDT
X-AuditID: 12074412-b7f216d0000008e3-c7-50387939902d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id C3.CB.02275.93978305; Sat, 25 Aug 2012 03:05:29 -0400 (EDT)
Received: from [192.168.69.140] (p57A257CD.dip.t-dialin.net [87.162.87.205])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7P75Q9K012401
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 Aug 2012 03:05:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <20120823203152.GA1810@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsUixO6iqGtZaRFgsH49m0XXlW4mi4beK8wW
	P1p6mC06p8o6sHgsX7qO0eNZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M5Y259Q8MSt
	YtW9LawNjAcsuhg5OCQETCQ+zfXuYuQEMsUkLtxbz9bFyMUhJHCZUeLntzUsEM4ZJomOe4+Z
	Qap4BbQlrvz+C2azCKhKLO6/xQhiswnoSizqaWYCsUUFQiTWfJvCCFEvKHFy5hMWEFtEQFbi
	++GNYHFmgSyJeRvfgs0RFvCWePO7nQli2X9GiS3LD7ODJDgFrCQ6Tq5mhWgIkHja0Ms2gZF/
	FpK5s5CkZgE9xCygLrF+nhBEWF5i+9s5zBC2rcS6xwsZMcXdJB7t+Mu2gJF9FaNcYk5prm5u
	YmZOcWqybnFyYl5eapGumV5uZoleakrpJkZITAjtYFx/Uu4QowAHoxIP740z5gFCrIllxZW5
	hxglOZiURHmvl1gECPEl5adUZiQWZ8QXleakFh9ilOBgVhLh/c4AlONNSaysSi3Kh0lJc7Ao
	ifP+XKzuJySQnliSmp2aWpBaBJOV4eBQkuA1qABqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1L
	SS1KLC3JiAfFe3wxMOJBUjxAe/tA2nmLCxJzgaIQracYjTn+nzx5l5Hj81MgKcSSl5+XKiXO
	ywFSKgBSmlGaB7cIlgxfMYoD/S3MywZSxQNMpHDzXgGtYgJaVe5qDrKqJBEhJdXA6OVd+fzm
	2lcOl9i/Sgr6vJyebPG2ssA0So37nNq9hr1d7gV3I4tZlfplynr7jTtnrHwn8K9p 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204267>

This is a multi-part message in MIME format.
--------------010907070209050505050605
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/23/2012 10:31 PM, Jeff King wrote:
> I think part of the confusion of this code is that inside the loop over
> the refs it is sometimes checking aspects of the ref, and sometimes
> checking invariants of the loop (like args.fetch_all). Splitting it into
> separate loops makes it easier to see what is going on, like the patch
> below (on top of Michael's series).
> 
> I'm not sure if it ends up being more readable, since the generic "cut
> down this linked list" function has to operate through callbacks with a
> void pointer. On the other hand, that function could also be used
> elsewhere.
> [...]

Despite requiring a bit more boilerplate, I think that your change makes
the logic clearer.

*If* we want to switch to using callbacks, then we can get even more
bang for the buck, as in the attached patch (which applies on top of my
patch v2).  Beyond your suggestion, this patch:

* Inlines your filter_refs() into everything_local(), because (a) it's
short and (b) the policy work implemented there logically belongs
higher-up in the call chain.

* Renames your filter_refs_callback() to filter_refs().

* Moves the initialization of the filter_by_name_data structure
(including sorting and de-duping) all the way up to fetch_pack(), and
passes a filter_by_name_data* (rather than (nr_heads, heads)) down to
the callees.

If you like this change, let me know and I'll massage it into a
digestible patch series.

Michael
-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

--------------010907070209050505050605
Content-Type: text/x-patch;
 name="jk-filter-callback.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="jk-filter-callback.patch"

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index db77ee6..d1dabcf 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -521,51 +521,91 @@ static void mark_recent_complete_commits(unsigned long cutoff)
 	}
 }
 
-static void filter_refs(struct ref **refs, int *nr_heads, char **heads)
+static void filter_refs(struct ref **refs,
+			int (*want)(struct ref *, void *),
+			void *data)
 {
-	struct ref *newlist = NULL;
-	struct ref **newtail = &newlist;
+	struct ref **tail = refs;
 	struct ref *ref, *next;
-	int head_pos = 0, unmatched = 0;
 
 	for (ref = *refs; ref; ref = next) {
-		int keep_ref = 0;
 		next = ref->next;
-		if (!memcmp(ref->name, "refs/", 5) &&
-		    check_refname_format(ref->name, 0))
-			; /* trash */
-		else if (args.fetch_all &&
-			   (!args.depth || prefixcmp(ref->name, "refs/tags/")))
-			keep_ref = 1;
-		else
-			while (head_pos < *nr_heads) {
-				int cmp = strcmp(ref->name, heads[head_pos]);
-				if (cmp < 0) { /* definitely do not have it */
-					break;
-				} else if (cmp == 0) { /* definitely have it */
-					free(heads[head_pos++]);
-					keep_ref = 1;
-					break;
-				} else { /* might have it; keep looking */
-					heads[unmatched++] = heads[head_pos++];
-				}
-			}
-
-		if (keep_ref) {
-			*newtail = ref;
-			ref->next = NULL;
-			newtail = &ref->next;
-		} else {
+		if (want(ref, data))
+			tail = &ref->next;
+		else {
 			free(ref);
+			*tail = next;
 		}
 	}
+}
 
-	/* copy any remaining unmatched heads: */
-	while (head_pos < *nr_heads)
-		heads[unmatched++] = heads[head_pos++];
-	*nr_heads = unmatched;
+static int ref_name_is_ok(struct ref *ref, void *data)
+{
+	return memcmp(ref->name, "refs/", 5) ||
+		!check_refname_format(ref->name, 0);
+}
+
+static int ref_ok_for_shallow(struct ref *ref, void *data)
+{
+	return prefixcmp(ref->name, "refs/tags/");
+}
+
+static int compare_heads(const void *a, const void *b)
+{
+	return strcmp(*(const char **)a, *(const char **)b);
+}
+
+static int remove_duplicates(int nr_heads, char **heads)
+{
+	int src, dst;
+	for (src = dst = 1; src < nr_heads; src++)
+		if (strcmp(heads[src], heads[dst-1]))
+			heads[dst++] = heads[src];
+		else
+			free(heads[src]);
+	return dst;
+}
 
-	*refs = newlist;
+struct filter_by_name_data {
+	char **heads;
+	int *nr_heads;
+	int head_pos;
+	int unmatched;
+};
+
+static void filter_by_name_init(struct filter_by_name_data *f,
+			 int *nr_heads, char **heads)
+{
+	memset(f, 0, sizeof(*f));
+	f->heads = heads;
+	f->nr_heads = nr_heads;
+	qsort(f->heads, *f->nr_heads, sizeof(*f->heads), compare_heads);
+	*f->nr_heads = remove_duplicates(*f->nr_heads, f->heads);
+}
+
+static int filter_by_name_want(struct ref *ref, void *data)
+{
+	struct filter_by_name_data *f = data;
+
+	while (f->head_pos < *f->nr_heads) {
+		int cmp = strcmp(ref->name, f->heads[f->head_pos]);
+		if (cmp < 0) /* definitely do not have it */
+			return 0;
+		else if (cmp == 0) { /* definitely have it */
+			free(f->heads[f->head_pos++]);
+			return 1;
+		} else /* might have it; keep looking */
+			f->heads[f->unmatched++] = f->heads[f->head_pos++];
+	}
+	return 0;
+}
+
+static void filter_by_name_finish(struct filter_by_name_data *f)
+{
+	/* copy any remaining unmatched heads: */
+	while (f->head_pos < *f->nr_heads)
+		f->heads[f->unmatched++] = f->heads[f->head_pos++];
+	*f->nr_heads = f->unmatched;
 }
 
 static void mark_alternate_complete(const struct ref *ref, void *unused)
@@ -573,7 +613,8 @@ static void mark_alternate_complete(const struct ref *ref, void *unused)
 	mark_complete(NULL, ref->old_sha1, 0, NULL);
 }
 
-static int everything_local(struct ref **refs, int *nr_heads, char **heads)
+static int everything_local(struct ref **refs,
+			    struct filter_by_name_data *filter_by_name_data)
 {
 	struct ref *ref;
 	int retval;
@@ -624,7 +665,14 @@ static int everything_local(struct ref **refs, int *nr_heads, char **heads)
 		}
 	}
 
-	filter_refs(refs, nr_heads, heads);
+	filter_refs(refs, ref_name_is_ok, NULL);
+
+	if (args.fetch_all) {
+		if (args.depth)
+			filter_refs(refs, ref_ok_for_shallow, NULL);
+	} else if (filter_by_name_data) {
+		filter_refs(refs, filter_by_name_want, filter_by_name_data);
+	}
 
 	for (retval = 1, ref = *refs; ref ; ref = ref->next) {
 		const unsigned char *remote = ref->old_sha1;
@@ -754,9 +802,9 @@ static int get_pack(int xd[2], char **pack_lockfile)
 }
 
 static struct ref *do_fetch_pack(int fd[2],
-		const struct ref *orig_ref,
-		int *nr_heads, char **heads,
-		char **pack_lockfile)
+				 const struct ref *orig_ref,
+				 struct filter_by_name_data *filter_by_name_data,
+				 char **pack_lockfile)
 {
 	struct ref *ref = copy_ref_list(orig_ref);
 	unsigned char sha1[20];
@@ -796,7 +844,7 @@ static struct ref *do_fetch_pack(int fd[2],
 			fprintf(stderr, "Server supports ofs-delta\n");
 	} else
 		prefer_ofs_delta = 0;
-	if (everything_local(&ref, nr_heads, heads)) {
+	if (everything_local(&ref, filter_by_name_data)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
@@ -816,21 +864,6 @@ static struct ref *do_fetch_pack(int fd[2],
 	return ref;
 }
 
-static int remove_duplicates(int nr_heads, char **heads)
-{
-	int src, dst;
-
-	if (!nr_heads)
-		return 0;
-
-	for (src = dst = 1; src < nr_heads; src++)
-		if (strcmp(heads[src], heads[dst-1]))
-			heads[dst++] = heads[src];
-		else
-			free(heads[src]);
-	return dst;
-}
-
 static int fetch_pack_config(const char *var, const char *value, void *cb)
 {
 	if (strcmp(var, "fetch.unpacklimit") == 0) {
@@ -1030,11 +1063,6 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	return ret;
 }
 
-static int compare_heads(const void *a, const void *b)
-{
-	return strcmp(*(const char **)a, *(const char **)b);
-}
-
 struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		       int fd[], struct child_process *conn,
 		       const struct ref *ref,
@@ -1045,6 +1073,7 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 {
 	struct stat st;
 	struct ref *ref_cpy;
+	struct filter_by_name_data name_data, *filter_by_name_data;
 
 	fetch_pack_setup();
 	if (&args != my_args)
@@ -1054,16 +1083,20 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 			st.st_mtime = 0;
 	}
 
-	if (heads && *nr_heads) {
-		qsort(heads, *nr_heads, sizeof(*heads), compare_heads);
-		*nr_heads = remove_duplicates(*nr_heads, heads);
-	}
-
 	if (!ref) {
 		packet_flush(fd[1]);
 		die("no matching remote head");
 	}
-	ref_cpy = do_fetch_pack(fd, ref, nr_heads, heads, pack_lockfile);
+	if (heads && *nr_heads) {
+		filter_by_name_data = &name_data;
+		filter_by_name_init(filter_by_name_data, nr_heads, heads);
+	} else
+		filter_by_name_data = NULL;
+
+	ref_cpy = do_fetch_pack(fd, ref, filter_by_name_data, pack_lockfile);
+
+	if (filter_by_name_data)
+		filter_by_name_finish(filter_by_name_data);
 
 	if (args.depth > 0) {
 		struct cache_time mtime;

--------------010907070209050505050605--
