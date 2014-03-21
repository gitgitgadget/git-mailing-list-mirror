From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 08/10] t4018: test cases for the built-in cpp pattern
Date: Fri, 21 Mar 2014 22:07:20 +0100
Message-ID: <83db40e0bf4cfd107841a5f87275eca53419874c.1395433874.git.j6t@kdbg.org>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:09:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR6gj-0003fP-NW
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbaCUVJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:09:06 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:49473 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751291AbaCUVJD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 17:09:03 -0400
Received: from bsmtp.bon.at (unknown [192.168.181.102])
	by lbmfmo03.bon.at (Postfix) with ESMTP id EEE2ECEA73
	for <git@vger.kernel.org>; Fri, 21 Mar 2014 22:09:01 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id C69B9A7EB7;
	Fri, 21 Mar 2014 22:08:49 +0100 (CET)
Received: from dx.sixt.local (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 6EB8019F6A4;
	Fri, 21 Mar 2014 22:08:49 +0100 (CET)
X-Mailer: git-send-email 1.8.5.2.244.g9fb3fb1
In-Reply-To: <cover.1395433874.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244745>

A later patch changes the built-in cpp pattern. These test cases
demonstrate aspects of the pattern that we do not want to change.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t4018/cpp-c++-function               | 4 ++++
 t/t4018/cpp-class-definition           | 4 ++++
 t/t4018/cpp-class-definition-derived   | 5 +++++
 t/t4018/cpp-function-returning-pointer | 4 ++++
 t/t4018/cpp-skip-access-specifiers     | 8 ++++++++
 t/t4018/cpp-skip-comment-block         | 9 +++++++++
 t/t4018/cpp-skip-labels                | 8 ++++++++
 t/t4018/cpp-struct-definition          | 9 +++++++++
 t/t4018/cpp-void-c-function            | 4 ++++
 9 files changed, 55 insertions(+)
 create mode 100644 t/t4018/cpp-c++-function
 create mode 100644 t/t4018/cpp-class-definition
 create mode 100644 t/t4018/cpp-class-definition-derived
 create mode 100644 t/t4018/cpp-function-returning-pointer
 create mode 100644 t/t4018/cpp-skip-access-specifiers
 create mode 100644 t/t4018/cpp-skip-comment-block
 create mode 100644 t/t4018/cpp-skip-labels
 create mode 100644 t/t4018/cpp-struct-definition
 create mode 100644 t/t4018/cpp-void-c-function

diff --git a/t/t4018/cpp-c++-function b/t/t4018/cpp-c++-function
new file mode 100644
index 0000000..9ee6bbe
--- /dev/null
+++ b/t/t4018/cpp-c++-function
@@ -0,0 +1,4 @@
+Item RIGHT::DoSomething( Args with_spaces )
+{
+	ChangeMe;
+}
diff --git a/t/t4018/cpp-class-definition b/t/t4018/cpp-class-definition
new file mode 100644
index 0000000..11b61da
--- /dev/null
+++ b/t/t4018/cpp-class-definition
@@ -0,0 +1,4 @@
+class RIGHT
+{
+	int ChangeMe;
+};
diff --git a/t/t4018/cpp-class-definition-derived b/t/t4018/cpp-class-definition-derived
new file mode 100644
index 0000000..3b98cd0
--- /dev/null
+++ b/t/t4018/cpp-class-definition-derived
@@ -0,0 +1,5 @@
+class RIGHT :
+	public Baseclass
+{
+	int ChangeMe;
+};
diff --git a/t/t4018/cpp-function-returning-pointer b/t/t4018/cpp-function-returning-pointer
new file mode 100644
index 0000000..ef15657
--- /dev/null
+++ b/t/t4018/cpp-function-returning-pointer
@@ -0,0 +1,4 @@
+const char *get_it_RIGHT(char *ptr)
+{
+	ChangeMe;
+}
diff --git a/t/t4018/cpp-skip-access-specifiers b/t/t4018/cpp-skip-access-specifiers
new file mode 100644
index 0000000..4d4a9db
--- /dev/null
+++ b/t/t4018/cpp-skip-access-specifiers
@@ -0,0 +1,8 @@
+class RIGHT : public Baseclass
+{
+public:
+protected:
+private:
+	void DoSomething();
+	int ChangeMe;
+};
diff --git a/t/t4018/cpp-skip-comment-block b/t/t4018/cpp-skip-comment-block
new file mode 100644
index 0000000..3800b99
--- /dev/null
+++ b/t/t4018/cpp-skip-comment-block
@@ -0,0 +1,9 @@
+struct item RIGHT(int i)
+// Do not
+// pick up
+/* these
+** comments.
+*/
+{
+	ChangeMe;
+}
diff --git a/t/t4018/cpp-skip-labels b/t/t4018/cpp-skip-labels
new file mode 100644
index 0000000..b9c10ab
--- /dev/null
+++ b/t/t4018/cpp-skip-labels
@@ -0,0 +1,8 @@
+void RIGHT (void)
+{
+repeat:		// C++ comment
+next:		/* C comment */
+	do_something();
+
+	ChangeMe;
+}
diff --git a/t/t4018/cpp-struct-definition b/t/t4018/cpp-struct-definition
new file mode 100644
index 0000000..521c59f
--- /dev/null
+++ b/t/t4018/cpp-struct-definition
@@ -0,0 +1,9 @@
+struct RIGHT {
+	unsigned
+	/* this bit field looks like a label and should not be picked up */
+		decoy_bitfield: 2,
+		more : 1;
+	int filler;
+
+	int ChangeMe;
+};
diff --git a/t/t4018/cpp-void-c-function b/t/t4018/cpp-void-c-function
new file mode 100644
index 0000000..153081e
--- /dev/null
+++ b/t/t4018/cpp-void-c-function
@@ -0,0 +1,4 @@
+void RIGHT (void)
+{
+	ChangeMe;
+}
-- 
1.8.5.2.244.g9fb3fb1
