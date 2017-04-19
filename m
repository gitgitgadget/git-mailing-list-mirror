Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 406411FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 17:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966266AbdDSR2m (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 13:28:42 -0400
Received: from mout.web.de ([212.227.17.12]:52540 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966094AbdDSR2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 13:28:40 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQ6PP-1cveKz2dhT-005K9O; Wed, 19
 Apr 2017 19:28:30 +0200
Subject: Re: [PATCH v3 1/2] use HOST_NAME_MAX to size buffers for
 gethostname(2)
To:     Jonathan Nieder <jrnieder@gmail.com>,
        David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
References: <20170418215743.18406-1-dturner@twosigma.com>
 <20170418215743.18406-2-dturner@twosigma.com>
 <20170419012824.GA28740@aiede.svl.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <c0333c81-d3b2-ca2d-a553-75642d8fb949@web.de>
Date:   Wed, 19 Apr 2017 19:28:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <20170419012824.GA28740@aiede.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:PPANgdTmlsbC6OJMXQW6ZH3ZCVqYNqL/tgHVlnK/oCxd7+vpp9M
 kr+exxmiqRwPMP187xm9yox9YC4hUP2qtbR/A2gSKMSH7I/5e2GqaKbMMX5Y+7HNf2NFJQX
 eB48i2iQ2tWhsF/aXng8/p8/bXJr3uG4FmoEqKZYi2CxC22RNqE9K07VsLN1iZNq53pg9g+
 02Tt2GAHAUIawjri1F2zQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:clmT3QeYd2Y=:t4NZZ2zv1g7Mnn+v/SNL7w
 cT/paq0F0Tdv9dTFmDxbaKivExLlBAK9KAKrN1PAPr9puquqxR1LI3ULc6DsTcKb7dewDUQQH
 2mt7k4SZK5TWbIX/mjoDfTcDfIeO8OMdCy0Z+xTbmNeEEWYQ5ro+xbhziJGXfrIp/QN55uMd9
 gLsxl7kDKS7n/qwE3zwLgyv6LzGMd1iD17baBE1MdX2B5QGnDTvxMQg7pnDfbed7/xQ5/Cakf
 NgxO9ANh5NaeDXGbOvLmwRm6pomL2ATWnbxfEQAUM7R87VZR5JtdIh/CD4JTuZPDKMhJzfiMZ
 bsN/qLIL9t1G+hsP8fXSmqRKRa+CGtHzQSY5Y/z1BkaBzY1OIosfPjErhNQ7eHwybtFzUwmF+
 5JvKRvHBtk0HLJcZ9kFNJa84yxanvzXEdu7p8BDh5PLKAMYR2hYp3y6DOr9gEBljfGvqZSj/f
 f/E4XwbVbwkeiFBWdX8UjqWYJJxdDRWpcrrvP1BQY1qo9QXP9N1W3NGJQcujvH5MfRuO7567S
 M1LNOmK4Rw2V1ODUx+vNDyozniE9faoENfY6BzkMRa65WrXTFJhPI7ad5cJMAy2gQ3OM6z4NI
 8pcuJ8mVDfDp7GDr4slEH+kLBCKPOPKggacYbIA3bfizozciw9LgQEAdkiEBT8EUbqWxTey50
 yJ09GkCGwI//LD+KvZOZVCcjESsNFIgSPiUe2tJSi8FFcgCLJWvehTBgb9DUvEkOU5qiV0d0E
 ceVZZILTkPk5VRe47lG5Z/mHNLX70gu3VbQl93GEHbLTU7U/OtvF4QlUd4B8+1TiyDobTc6bh
 IS2jatL
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.04.2017 um 03:28 schrieb Jonathan Nieder:
> David Turner wrote:
>> @@ -274,7 +278,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
>>   			 * running.
>>   			 */
>>   			time(NULL) - st.st_mtime <= 12 * 3600 &&
>> -			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
>> +			fscanf(fp, scan_fmt, &pid, locking_host) == 2 &&
> 
> I hoped this could be simplified since HOST_NAME_MAX is a numeric literal,
> using the double-expansion trick:
> 
> #define STR_(s) # s
> #define STR(s) STR_(s)
> 
> 			fscanf(fp, "%" SCNuMAX " %" STR(HOST_NAME_MAX) "c",
> 			       &pid, locking_host);
> 
> Unfortunately, I don't think there's anything stopping a platform from
> defining
> 
> 	#define HOST_NAME_MAX 0x100
> 
> which would break that.
> 
> So this run-time calculation appears to be necessary.

I had another look at this last night and cooked up the following
patch.  Might have gone overboard with it..

-- >8 --
Subject: [PATCH] gc: support arbitrary hostnames and pids in lock_repo_for_gc()

git gc writes its pid and hostname into a pidfile to prevent concurrent
garbage collection.  Repositories may be shared between systems with
different limits for host name length and different pid ranges.  Use a
strbuf to store the file contents to allow for arbitrarily long
hostnames and pids to be shown to the user on early abort.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/gc.c | 151 +++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 111 insertions(+), 40 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 2daede7820..4c1c01e87d 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -228,21 +228,99 @@ static int need_to_gc(void)
 	return 1;
 }
 
+struct pidfile {
+	struct strbuf buf;
+	char *hostname;
+};
+
+#define PIDFILE_INIT { STRBUF_INIT }
+
+static void pidfile_release(struct pidfile *pf)
+{
+	pf->hostname = NULL;
+	strbuf_release(&pf->buf);
+}
+
+static int pidfile_read(struct pidfile *pf, const char *path,
+			unsigned int max_age_seconds)
+{
+	int fd;
+	struct stat st;
+	ssize_t len;
+	char *space;
+	int rc = -1;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return rc;
+
+	if (fstat(fd, &st))
+		goto out;
+	if (time(NULL) - st.st_mtime > max_age_seconds)
+		goto out;
+	if (st.st_size > (size_t)st.st_size)
+		goto out;
+
+	len = strbuf_read(&pf->buf, fd, st.st_size);
+	if (len < 0)
+		goto out;
+
+	space = strchr(pf->buf.buf, ' ');
+	if (!space) {
+		pidfile_release(pf);
+		goto out;
+	}
+	pf->hostname = space + 1;
+	*space = '\0';
+
+	rc = 0;
+out:
+	close(fd);
+	return rc;
+}
+
+static int parse_pid(const char *value, pid_t *ret)
+{
+	if (value && *value) {
+		char *end;
+		intmax_t val;
+
+		errno = 0;
+		val = strtoimax(value, &end, 0);
+		if (errno == ERANGE)
+			return 0;
+		if (*end)
+			return 0;
+		if (labs(val) > maximum_signed_value_of_type(pid_t)) {
+			errno = ERANGE;
+			return 0;
+		}
+		*ret = val;
+		return 1;
+	}
+	errno = EINVAL;
+	return 0;
+}
+
+static int pidfile_process_exists(const struct pidfile *pf)
+{
+	pid_t pid;
+	return parse_pid(pf->buf.buf, &pid) &&
+		(!kill(pid, 0) || errno == EPERM);
+}
+
 /* return NULL on success, else hostname running the gc */
-static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
+static int lock_repo_for_gc(int force, struct pidfile *pf)
 {
 	static struct lock_file lock;
 	char my_host[128];
 	struct strbuf sb = STRBUF_INIT;
-	struct stat st;
-	uintmax_t pid;
-	FILE *fp;
 	int fd;
 	char *pidfile_path;
 
 	if (is_tempfile_active(&pidfile))
 		/* already locked */
-		return NULL;
+		return 0;
 
 	if (gethostname(my_host, sizeof(my_host)))
 		xsnprintf(my_host, sizeof(my_host), "unknown");
@@ -251,34 +329,27 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	fd = hold_lock_file_for_update(&lock, pidfile_path,
 				       LOCK_DIE_ON_ERROR);
 	if (!force) {
-		static char locking_host[128];
-		int should_exit;
-		fp = fopen(pidfile_path, "r");
-		memset(locking_host, 0, sizeof(locking_host));
-		should_exit =
-			fp != NULL &&
-			!fstat(fileno(fp), &st) &&
-			/*
-			 * 12 hour limit is very generous as gc should
-			 * never take that long. On the other hand we
-			 * don't really need a strict limit here,
-			 * running gc --auto one day late is not a big
-			 * problem. --force can be used in manual gc
-			 * after the user verifies that no gc is
-			 * running.
-			 */
-			time(NULL) - st.st_mtime <= 12 * 3600 &&
-			fscanf(fp, "%"SCNuMAX" %127c", &pid, locking_host) == 2 &&
+		/*
+		 * 12 hour limit is very generous as gc should
+		 * never take that long. On the other hand we
+		 * don't really need a strict limit here,
+		 * running gc --auto one day late is not a big
+		 * problem. --force can be used in manual gc
+		 * after the user verifies that no gc is
+		 * running.
+		 */
+		const unsigned max_age_seconds = 12 * 3600;
+
+		if (!pidfile_read(pf, pidfile_path, max_age_seconds)) {
 			/* be gentle to concurrent "gc" on remote hosts */
-			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno == EPERM);
-		if (fp != NULL)
-			fclose(fp);
-		if (should_exit) {
-			if (fd >= 0)
-				rollback_lock_file(&lock);
-			*ret_pid = pid;
-			free(pidfile_path);
-			return locking_host;
+			if (strcmp(pf->hostname, my_host) ||
+			    pidfile_process_exists(pf)) {
+				if (fd >= 0)
+					rollback_lock_file(&lock);
+				free(pidfile_path);
+				return -1;
+			}
+			pidfile_release(pf);
 		}
 	}
 
@@ -289,7 +360,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 	commit_lock_file(&lock);
 	register_tempfile(&pidfile, pidfile_path);
 	free(pidfile_path);
-	return NULL;
+	return 0;
 }
 
 static int report_last_gc_error(void)
@@ -344,8 +415,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	int auto_gc = 0;
 	int quiet = 0;
 	int force = 0;
-	const char *name;
-	pid_t pid;
+	struct pidfile pf = PIDFILE_INIT;
 	int daemonized = 0;
 
 	struct option builtin_gc_options[] = {
@@ -420,12 +490,13 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	} else
 		add_repack_all_option();
 
-	name = lock_repo_for_gc(force, &pid);
-	if (name) {
-		if (auto_gc)
+	if (lock_repo_for_gc(force, &pf)) {
+		if (auto_gc) {
+			pidfile_release(&pf);
 			return 0; /* be quiet on --auto */
-		die(_("gc is already running on machine '%s' pid %"PRIuMAX" (use --force if not)"),
-		    name, (uintmax_t)pid);
+		}
+		die(_("gc is already running on machine '%s' pid %s (use --force if not)"),
+		    pf.hostname, pf.buf.buf);
 	}
 
 	if (daemonized) {
-- 
2.12.2

