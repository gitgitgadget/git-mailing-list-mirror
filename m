From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 14/29] refs: make error messages more consistent
Date: Wed, 27 Apr 2016 18:57:31 +0200
Message-ID: <48602160ce11b6173c01769cac142a47b7f364b4.1461768689.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:59:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSoa-0004HG-Gq
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:59:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbcD0Q7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:59:48 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:62997 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752989AbcD0Q61 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:27 -0400
X-AuditID: 1207440f-8a7ff700000008e4-2d-5720efb2d709
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 78.9F.02276.2BFE0275; Wed, 27 Apr 2016 12:58:26 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6R022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:25 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqLvpvUK4wbEluhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oxjh16yF5x1rfjSvYO9gfGzWRcjJ4eEgInEjfcP
	GbsYuTiEBLYySrzeMoEFwjnOJHF/8QRmkCo2AV2JRT3NTCC2iICDxPKVv9hBipgFmpgkvi9v
	YgFJCAMl/v78ClTEwcEioCrx5o8XSJhXIEri8MEFbBDb5CQuT38AZnMKWEh8aX3LCGILCZhL
	LHmwmn0CI88CRoZVjHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCEhxr+DsWu9
	zCFGAQ5GJR7eAgmFcCHWxLLiytxDjJIcTEqivEvOAoX4kvJTKjMSizPii0pzUosPMUpwMCuJ
	8E5/A5TjTUmsrEotyodJSXOwKInzqi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwlr8DahQsSk1P
	rUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHxUB8MTAKQFI8QHtLQdp5iwsSc4GiEK2nGBWl
	xHkXgCQEQBIZpXlwY2GJ4xWjONCXwrxTQap4gEkHrvsV0GAmoMGXD8mCDC5JREhJNTBq2vv7
	uv1+7X7RZXnwUs87k8sn/luc2TJpgfP+c/sOiD9ZP23Xy/mrYuzTJTwWNXbbzciuunAyxG3X
	JjkX1l/MrU0KLU1aP5LX/WXc7VISlJOz3PytdvtBbeP6FdJtlvesef8zbsgNfi1y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292768>

* Always start error messages with a lower-case letter.

* Always enclose reference names in single quotes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
This change is not strictly needed, but I wanted to fix the old error
messages before I started adding new ones (otherwise, should the new
error messages be made to look like the old ones or should they be
corrected?) By the way, should these be internationalized?

 refs.c                |  8 ++++----
 refs/files-backend.c  | 32 ++++++++++++++++----------------
 t/t1400-update-ref.sh |  4 ++--
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index b18d995..ba14105 100644
--- a/refs.c
+++ b/refs.c
@@ -504,7 +504,7 @@ static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 	filename = git_path("%s", pseudoref);
 	fd = hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
 	if (fd < 0) {
-		strbuf_addf(err, "Could not open '%s' for writing: %s",
+		strbuf_addf(err, "could not open '%s' for writing: %s",
 			    filename, strerror(errno));
 		return -1;
 	}
@@ -515,14 +515,14 @@ static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 		if (read_ref(pseudoref, actual_old_sha1))
 			die("could not read ref '%s'", pseudoref);
 		if (hashcmp(actual_old_sha1, old_sha1)) {
-			strbuf_addf(err, "Unexpected sha1 when writing %s", pseudoref);
+			strbuf_addf(err, "unexpected sha1 when writing '%s'", pseudoref);
 			rollback_lock_file(&lock);
 			goto done;
 		}
 	}
 
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len) {
-		strbuf_addf(err, "Could not write to '%s'", filename);
+		strbuf_addf(err, "could not write to '%s'", filename);
 		rollback_lock_file(&lock);
 		goto done;
 	}
@@ -792,7 +792,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
 	if (new_sha1 && !is_null_sha1(new_sha1) &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		strbuf_addf(err, "refusing to update ref with bad name %s",
+		strbuf_addf(err, "refusing to update ref with bad name '%s'",
 			    refname);
 		return -1;
 	}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b8c1779..9faf17c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1730,7 +1730,7 @@ static int verify_lock(struct ref_lock *lock,
 			  lock->old_oid.hash, NULL)) {
 		if (old_sha1) {
 			int save_errno = errno;
-			strbuf_addf(err, "can't verify ref %s", lock->ref_name);
+			strbuf_addf(err, "can't verify ref '%s'", lock->ref_name);
 			errno = save_errno;
 			return -1;
 		} else {
@@ -1739,7 +1739,7 @@ static int verify_lock(struct ref_lock *lock,
 		}
 	}
 	if (old_sha1 && hashcmp(lock->old_oid.hash, old_sha1)) {
-		strbuf_addf(err, "ref %s is at %s but expected %s",
+		strbuf_addf(err, "ref '%s' is at %s but expected %s",
 			    lock->ref_name,
 			    sha1_to_hex(lock->old_oid.hash),
 			    sha1_to_hex(old_sha1));
@@ -1819,7 +1819,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		if (last_errno != ENOTDIR ||
 		    !verify_refname_available_dir(orig_refname, extras, skip,
 						  get_loose_refs(&ref_cache), err))
-			strbuf_addf(err, "unable to resolve reference %s: %s",
+			strbuf_addf(err, "unable to resolve reference '%s': %s",
 				    orig_refname, strerror(last_errno));
 
 		goto error_return;
@@ -1857,7 +1857,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		/* fall through */
 	default:
 		last_errno = errno;
-		strbuf_addf(err, "unable to create directory for %s",
+		strbuf_addf(err, "unable to create directory for '%s'",
 			    ref_file.buf);
 		goto error_return;
 	}
@@ -2478,7 +2478,7 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 	strbuf_git_path(logfile, "logs/%s", refname);
 	if (force_create || should_autocreate_reflog(refname)) {
 		if (safe_create_leading_directories(logfile->buf) < 0) {
-			strbuf_addf(err, "unable to create directory for %s: "
+			strbuf_addf(err, "unable to create directory for '%s': "
 				    "%s", logfile->buf, strerror(errno));
 			return -1;
 		}
@@ -2492,7 +2492,7 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 
 		if (errno == EISDIR) {
 			if (remove_empty_directories(logfile)) {
-				strbuf_addf(err, "There are still logs under "
+				strbuf_addf(err, "there are still logs under "
 					    "'%s'", logfile->buf);
 				return -1;
 			}
@@ -2500,7 +2500,7 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 		}
 
 		if (logfd < 0) {
-			strbuf_addf(err, "unable to append to %s: %s",
+			strbuf_addf(err, "unable to append to '%s': %s",
 				    logfile->buf, strerror(errno));
 			return -1;
 		}
@@ -2569,13 +2569,13 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
 				  git_committer_info(0), msg);
 	if (result) {
-		strbuf_addf(err, "unable to append to %s: %s", logfile->buf,
+		strbuf_addf(err, "unable to append to '%s': %s", logfile->buf,
 			    strerror(errno));
 		close(logfd);
 		return -1;
 	}
 	if (close(logfd)) {
-		strbuf_addf(err, "unable to append to %s: %s", logfile->buf,
+		strbuf_addf(err, "unable to append to '%s': %s", logfile->buf,
 			    strerror(errno));
 		return -1;
 	}
@@ -2616,14 +2616,14 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 	o = parse_object(sha1);
 	if (!o) {
 		strbuf_addf(err,
-			    "Trying to write ref %s with nonexistent object %s",
+			    "trying to write ref '%s' with nonexistent object %s",
 			    lock->ref_name, sha1_to_hex(sha1));
 		unlock_ref(lock);
 		return -1;
 	}
 	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
 		strbuf_addf(err,
-			    "Trying to write non-commit object %s to branch %s",
+			    "trying to write non-commit object %s to branch '%s'",
 			    sha1_to_hex(sha1), lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -2633,7 +2633,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 	    write_in_full(fd, &term, 1) != 1 ||
 	    close_ref(lock) < 0) {
 		strbuf_addf(err,
-			    "Couldn't write %s", get_lock_file_path(lock->lk));
+			    "couldn't write '%s'", get_lock_file_path(lock->lk));
 		unlock_ref(lock);
 		return -1;
 	}
@@ -2654,7 +2654,7 @@ static int commit_ref_update(struct ref_lock *lock,
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, flags, err) < 0)) {
 		char *old_msg = strbuf_detach(err, NULL);
-		strbuf_addf(err, "Cannot update the ref '%s': %s",
+		strbuf_addf(err, "cannot update the ref '%s': %s",
 			    lock->ref_name, old_msg);
 		free(old_msg);
 		unlock_ref(lock);
@@ -2689,7 +2689,7 @@ static int commit_ref_update(struct ref_lock *lock,
 		}
 	}
 	if (commit_ref(lock)) {
-		strbuf_addf(err, "Couldn't set %s", lock->ref_name);
+		strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
 	}
@@ -3038,7 +3038,7 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	for (i = 1; i < n; i++)
 		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {
 			strbuf_addf(err,
-				    "Multiple updates for ref '%s' not allowed.",
+				    "multiple updates for ref '%s' not allowed.",
 				    refnames->items[i].string);
 			return 1;
 		}
@@ -3142,7 +3142,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			 * Close it to free up the file descriptor:
 			 */
 			if (close_ref(update->lock)) {
-				strbuf_addf(err, "Couldn't close %s.lock",
+				strbuf_addf(err, "couldn't close '%s.lock'",
 					    update->refname);
 				goto cleanup;
 			}
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index af1b20d..40b0cce 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -479,7 +479,7 @@ test_expect_success 'stdin fails with duplicate refs' '
 	create $a $m
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
+	grep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed." err
 '
 
 test_expect_success 'stdin create ref works' '
@@ -880,7 +880,7 @@ test_expect_success 'stdin -z fails option with unknown name' '
 test_expect_success 'stdin -z fails with duplicate refs' '
 	printf $F "create $a" "$m" "create $b" "$m" "create $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
+	grep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed." err
 '
 
 test_expect_success 'stdin -z create ref works' '
-- 
2.8.1
