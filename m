From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 02/39] api-lockfile: revise and expand the documentation
Date: Fri, 26 Sep 2014 12:08:02 +0200
Message-ID: <1411726119-31598-3-git-send-email-mhagger@alum.mit.edu>
References: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 12:09:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XXSSY-0003Vh-CO
	for gcvg-git-2@plane.gmane.org; Fri, 26 Sep 2014 12:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480AbaIZKI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2014 06:08:57 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61410 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754372AbaIZKIy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Sep 2014 06:08:54 -0400
X-AuditID: 12074413-f79ed6d000002501-c8-54253b365a5c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id CF.B9.09473.63B35245; Fri, 26 Sep 2014 06:08:54 -0400 (EDT)
Received: from michael.berhq.github.net ([178.19.210.163])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8QA8lLl013914
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 26 Sep 2014 06:08:53 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1411726119-31598-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1DWzVg0xmPZdwqLrSjeTRUPvFWaL
	J3PvMlu8vbmE0eL2ivnMFj9aepgt/k2osejs+MrowOHx9/0HJo+ds+6yeyzYVOrx8FUXu8ez
	3j2MHhcvKXt83iTncfvZNpYAjihum6TEkrLgzPQ8fbsE7ow9q1+xF8z3q3i4aAdjA2OvQxcj
	B4eEgInE4974LkZOIFNM4sK99WxdjFwcQgKXGSWOfb3GCOFsYpJ4Ne8WM0gVm4CuxKKeZiYQ
	W0RATWJi2yEWkCJmgcVMEhMObWIDSQgLeEt83/eYBcRmEVCVWPf8ECOIzSvgInFt/V82iHVy
	Eht2/weLcwq4SjRuvwZmCwHVtKyfzDKBkXcBI8MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1z
	vdzMEr3UlNJNjJBgFN7BuOuk3CFGAQ5GJR7eG+tUQoRYE8uKK3MPMUpyMCmJ8n6xUA0R4kvK
	T6nMSCzOiC8qzUktPsQowcGsJMJ7xwgox5uSWFmVWpQPk5LmYFES51Vbou4nJJCeWJKanZpa
	kFoEk5Xh4FCS4L1oCdQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4qN+GJgdICk
	eID2clmB7C0uSMwFikK0nmLU5VjX+a2fSYglLz8vVUqc9wjIDgGQoozSPLgVsNTzilEc6GNh
	3hsgVTzAtAU36RXQEiagJUpHlEGWlCQipKQaGFsMHM7NaZbI1W64N/XAf4PQxnOhM9y/19qf
	Zne0eJil6uB886iNeGaD495Ah3vtV6p38Yjm+aY/Y9rxxrmPfWLd3M6F+nckNqhX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257506>

Document a couple more functions and the flags argument as used by
hold_lock_file_for_update() and hold_lock_file_for_append().
Reorganize the document to make it more accessible.

Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 Documentation/technical/api-lockfile.txt | 199 ++++++++++++++++++++++---------
 1 file changed, 145 insertions(+), 54 deletions(-)

diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index dd89404..c14fca5 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -3,20 +3,124 @@ lockfile API
 
 The lockfile API serves two purposes:
 
-* Mutual exclusion.  When we write out a new index file, first
-  we create a new file `$GIT_DIR/index.lock`, write the new
-  contents into it, and rename it to the final destination
-  `$GIT_DIR/index`.  We try to create the `$GIT_DIR/index.lock`
-  file with O_EXCL so that we can notice and fail when somebody
-  else is already trying to update the index file.
-
-* Automatic cruft removal.  After we create the "lock" file, we
-  may decide to `die()`, and we would want to make sure that we
-  remove the file that has not been committed to its final
-  destination.  This is done by remembering the lockfiles we
-  created in a linked list and cleaning them up from an
-  `atexit(3)` handler.  Outstanding lockfiles are also removed
-  when the program dies on a signal.
+* Mutual exclusion and atomic file updates. When we want to change a
+  file, we create a lockfile `<filename>.lock`, write the new file
+  contents into it, and then rename the lockfile to its final
+  destination `<filename>`. We create the `<filename>.lock` file with
+  `O_CREAT|O_EXCL` so that we can notice and fail if somebody else has
+  already locked the file.
+
+* Automatic cruft removal. If the program exits after we lock a file
+  but before the changes have been committed, we want to make sure
+  that we remove the lockfile. This is done by remembering the
+  lockfiles we have created in a linked list and setting up an
+  `atexit(3)` handler and a signal handler that clean up the
+  lockfiles. This mechanism ensures that outstanding lockfiles are
+  cleaned up if the program exits (including when `die()` is called)
+  or if the program dies on a signal.
+
+Please note that lockfiles only block other writers. Readers do not
+block, but they are guaranteed to see either the old contents of the
+file or the new contents of the file (assuming that the filesystem
+implements `rename(2)` atomically).
+
+
+Calling sequence
+----------------
+
+The caller:
+
+* Allocates a variable `struct lock_file lock` in the bss section or
+  heap, initialized to zeros. It cannot be an auto variable allocated
+  on the stack. Because the `lock_file` structure is used in an
+  `atexit(3)` handler, its storage has to stay throughout the life of
+  the program, even after the file changes have been committed or
+  rolled back.
+
+* Attempts to create a lockfile by passing that variable and the path
+  of the final destination (e.g. `$GIT_DIR/index`) to
+  `hold_lock_file_for_update` or `hold_lock_file_for_append`.
+
+* Writes new content for the destination file by writing to the file
+  descriptor returned by those functions (also available via
+  `lock->fd`).
+
+When finished writing, the caller can:
+
+* Close the file descriptor and rename the lockfile to its final
+  destination by calling `commit_lock_file`.
+
+* Close the file descriptor and remove the lockfile by calling
+  `rollback_lock_file`.
+
+* Close the file descriptor without removing or renaming the lockfile
+  by calling `close_lock_file`, and later call `commit_lock_file` or
+  `rollback_lock_file`.
+
+At this point, the `lock_file` object must not be freed or altered,
+because it is still registered in the `lock_file_list`. However, it
+may be reused; just pass it to another call of
+`hold_lock_file_for_update` or `hold_lock_file_for_append`.
+
+If the program exits before you have called one of `commit_lock_file`,
+`rollback_lock_file`, or `close_lock_file`, an `atexit(3)` handler
+will close and remove the lockfile, essentially rolling back any
+uncommitted changes.
+
+If you need to close the file descriptor you obtained from a
+`hold_lock_file_*` function yourself, do so by calling
+`close_lock_file`. You should never call `close(2)` yourself!
+Otherwise the `struct lock_file` structure would still think that the
+file descriptor needs to be closed, and a later call to
+`commit_lock_file` or `rollback_lock_file` or program exit would
+result in duplicate calls to `close(2)`. Worse yet, if you `close(2)`
+and then later open another file descriptor for a completely different
+purpose, then a call to `commit_lock_file` or `rollback_lock_file`
+might close that unrelated file descriptor.
+
+
+Error handling
+--------------
+
+The `hold_lock_file_*` functions return a file descriptor on success
+or -1 on failure (unless `LOCK_DIE_ON_ERROR` is used; see below). On
+errors, `errno` describes the reason for failure. Errors can be
+handled by passing `errno` to one of the following helper functions:
+
+unable_to_lock_message::
+
+	Append an appropriate error message to a `strbuf`.
+
+unable_to_lock_error::
+
+	Emit an appropriate error message using `error()`.
+
+unable_to_lock_die::
+
+	Emit an appropriate error message and `die()`.
+
+
+Flags
+-----
+
+The following flags can be passed to `hold_lock_file_for_update` or
+`hold_lock_file_for_append`:
+
+LOCK_NODEREF::
+
+	Usually symbolic links in the destination path are resolved
+	and the lockfile is created by adding ".lock" to the resolved
+	path. If `LOCK_NODEREF` is set, then the lockfile is created
+	by adding ".lock" to the path argument itself. This option is
+	used, for example, when locking a symbolic reference, which
+	for backwards-compatibility reasons can be a symbolic link
+	containing the name of the referred-to-reference.
+
+LOCK_DIE_ON_ERROR::
+
+	If a lock is already taken for the file, `die()` with an error
+	message. If this option is not specified, trying to lock a
+	file that is already locked returns -1 to the caller.
 
 
 The functions
@@ -24,51 +128,38 @@ The functions
 
 hold_lock_file_for_update::
 
-	Take a pointer to `struct lock_file`, the filename of
-	the final destination (e.g. `$GIT_DIR/index`) and a flag
-	`die_on_error`.  Attempt to create a lockfile for the
-	destination and return the file descriptor for writing
-	to the file.  If `die_on_error` flag is true, it dies if
-	a lock is already taken for the file; otherwise it
-	returns a negative integer to the caller on failure.
+	Take a pointer to `struct lock_file`, the path of the file to
+	be locked (e.g. `$GIT_DIR/index`) and a flags argument (see
+	above). Attempt to create a lockfile for the destination and
+	return the file descriptor for writing to the file.
+
+hold_lock_file_for_append::
+
+	Like `hold_lock_file_for_update`, but before returning copy
+	the existing contents of the file (if any) to the lockfile and
+	position its write pointer at the end of the file.
 
 commit_lock_file::
 
-	Take a pointer to the `struct lock_file` initialized
-	with an earlier call to `hold_lock_file_for_update()`,
-	close the file descriptor and rename the lockfile to its
-	final destination.  Returns 0 upon success, a negative
-	value on failure to close(2) or rename(2).
+	Take a pointer to the `struct lock_file` initialized with an
+	earlier call to `hold_lock_file_for_update` or
+	`hold_lock_file_for_append`, close the file descriptor and
+	rename the lockfile to its final destination. Return 0 upon
+	success or a negative value on failure to `close(2)` or
+	`rename(2)`.
 
 rollback_lock_file::
 
-	Take a pointer to the `struct lock_file` initialized
-	with an earlier call to `hold_lock_file_for_update()`,
-	close the file descriptor and remove the lockfile.
+	Take a pointer to the `struct lock_file` initialized with an
+	earlier call to `hold_lock_file_for_update` or
+	`hold_lock_file_for_append`, close the file descriptor and
+	remove the lockfile.
 
 close_lock_file::
-	Take a pointer to the `struct lock_file` initialized
-	with an earlier call to `hold_lock_file_for_update()`,
-	and close the file descriptor.  Returns 0 upon success,
-	a negative value on failure to close(2).
-
-Because the structure is used in an `atexit(3)` handler, its
-storage has to stay throughout the life of the program.  It
-cannot be an auto variable allocated on the stack.
-
-Call `commit_lock_file()` or `rollback_lock_file()` when you are
-done writing to the file descriptor.  If you do not call either
-and simply `exit(3)` from the program, an `atexit(3)` handler
-will close and remove the lockfile.
-
-If you need to close the file descriptor you obtained from
-`hold_lock_file_for_update` function yourself, do so by calling
-`close_lock_file()`.  You should never call `close(2)` yourself!
-Otherwise the `struct
-lock_file` structure still remembers that the file descriptor
-needs to be closed, and a later call to `commit_lock_file()` or
-`rollback_lock_file()` will result in duplicate calls to
-`close(2)`.  Worse yet, if you `close(2)`, open another file
-descriptor for completely different purpose, and then call
-`commit_lock_file()` or `rollback_lock_file()`, they may close
-that unrelated file descriptor.
+
+	Take a pointer to the `struct lock_file` initialized with an
+	earlier call to `hold_lock_file_for_update` or
+	`hold_lock_file_for_append`, and close the file descriptor.
+	Return 0 upon success or a negative value on failure to
+	close(2). Usually `commit_lock_file` or `rollback_lock_file`
+	should be called after `close_lock_file`.
-- 
2.1.0
