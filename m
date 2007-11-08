From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Refactor working tree setup
Date: Thu, 08 Nov 2007 15:34:50 -0800
Message-ID: <7vr6j0z4yt.fsf@gitster.siamese.dyndns.org>
References: <1194088993-25692-1-git-send-email-mh@glandium.org>
	<87bqa4gy2h.fsf@catnip.gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:01:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIFC-00047A-Om
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:01:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760870AbXKHXfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 18:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756221AbXKHXfA
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 18:35:00 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33513 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753450AbXKHXe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 18:34:59 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6B8972F2;
	Thu,  8 Nov 2007 18:35:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E74093A60;
	Thu,  8 Nov 2007 18:35:14 -0500 (EST)
In-Reply-To: <87bqa4gy2h.fsf@catnip.gol.com> (Miles Bader's message of "Fri,
	09 Nov 2007 07:41:10 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64093>

Miles Bader <miles@gnu.org> writes:

> Mike Hommey <mh@glandium.org> writes:
>> Create a setup_work_tree() that can be used from any command requiring
>> a working tree conditionally.
> ...
>> +void setup_work_tree(void) {
>> +	const char *work_tree = get_git_work_tree();
>
> Hi, could you please not use this "function begin brace at EOL" style?

Hmm.  I should have been more careful.

-- >8 --
[PATCH] Style: place opening brace of a function definition at column 1

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 bundle.c    |    3 ++-
 daemon.c    |    6 ++++--
 dir.c       |    3 ++-
 help.c      |    3 ++-
 quote.c     |    3 ++-
 setup.c     |    3 ++-
 transport.c |    6 ++++--
 utf8.c      |    3 ++-
 8 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/bundle.c b/bundle.c
index 0869fcf..e4d60cd 100644
--- a/bundle.c
+++ b/bundle.c
@@ -23,7 +23,8 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
 }
 
 /* returns an fd */
-int read_bundle_header(const char *path, struct bundle_header *header) {
+int read_bundle_header(const char *path, struct bundle_header *header)
+{
 	char buffer[1024];
 	int fd;
 	long fpos;
diff --git a/daemon.c b/daemon.c
index b8df980..41a60af 100644
--- a/daemon.c
+++ b/daemon.c
@@ -406,7 +406,8 @@ static struct daemon_service daemon_service[] = {
 	{ "receive-pack", "receivepack", receive_pack, 0, 1 },
 };
 
-static void enable_service(const char *name, int ena) {
+static void enable_service(const char *name, int ena)
+{
 	int i;
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		if (!strcmp(daemon_service[i].name, name)) {
@@ -417,7 +418,8 @@ static void enable_service(const char *name, int ena) {
 	die("No such service %s", name);
 }
 
-static void make_service_overridable(const char *name, int ena) {
+static void make_service_overridable(const char *name, int ena)
+{
 	int i;
 	for (i = 0; i < ARRAY_SIZE(daemon_service); i++) {
 		if (!strcmp(daemon_service[i].name, name)) {
diff --git a/dir.c b/dir.c
index 5bcc764..01790ab 100644
--- a/dir.c
+++ b/dir.c
@@ -298,7 +298,8 @@ int excluded(struct dir_struct *dir, const char *pathname)
 	return 0;
 }
 
-static struct dir_entry *dir_entry_new(const char *pathname, int len) {
+static struct dir_entry *dir_entry_new(const char *pathname, int len)
+{
 	struct dir_entry *ent;
 
 	ent = xmalloc(sizeof(*ent) + len + 1);
diff --git a/help.c b/help.c
index 855aeef..8217d97 100644
--- a/help.c
+++ b/help.c
@@ -79,7 +79,8 @@ static void uniq(struct cmdnames *cmds)
 	cmds->cnt = j;
 }
 
-static void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes) {
+static void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
+{
 	int ci, cj, ei;
 	int cmp;
 
diff --git a/quote.c b/quote.c
index 919d092..0455783 100644
--- a/quote.c
+++ b/quote.c
@@ -131,7 +131,8 @@ static signed char const sq_lookup[256] = {
 	/* 0x80 */ /* set to 0 */
 };
 
-static inline int sq_must_quote(char c) {
+static inline int sq_must_quote(char c)
+{
 	return sq_lookup[(unsigned char)c] + quote_path_fully > 0;
 }
 
diff --git a/setup.c b/setup.c
index df006d9..1e2c55d 100644
--- a/setup.c
+++ b/setup.c
@@ -206,7 +206,8 @@ static const char *set_work_tree(const char *dir)
 	return NULL;
 }
 
-void setup_work_tree(void) {
+void setup_work_tree(void)
+{
 	const char *work_tree = get_git_work_tree();
 	const char *git_dir = get_git_dir();
 	if (!is_absolute_path(git_dir))
diff --git a/transport.c b/transport.c
index d44fe7c..fa5cfbb 100644
--- a/transport.c
+++ b/transport.c
@@ -380,7 +380,8 @@ static int disconnect_walker(struct transport *transport)
 }
 
 #ifndef NO_CURL
-static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags) {
+static int curl_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags)
+{
 	const char **argv;
 	int argc;
 	int err;
@@ -646,7 +647,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 	return 0;
 }
 
-static int git_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags) {
+static int git_transport_push(struct transport *transport, int refspec_nr, const char **refspec, int flags)
+{
 	struct git_transport_data *data = transport->data;
 	const char **argv;
 	char *rem;
diff --git a/utf8.c b/utf8.c
index 4efef6f..8095a71 100644
--- a/utf8.c
+++ b/utf8.c
@@ -11,7 +11,8 @@ struct interval {
 };
 
 /* auxiliary function for binary search in interval table */
-static int bisearch(ucs_char_t ucs, const struct interval *table, int max) {
+static int bisearch(ucs_char_t ucs, const struct interval *table, int max)
+{
 	int min = 0;
 	int mid;
 
