Received: from mail-108-mta226.mxroute.com (mail-108-mta226.mxroute.com [136.175.108.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FEB3A1E7F
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 11:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767700051; cv=none; b=McrTuhW1/S7TDuNlWiBb4KAXVGDXxOWX7Fw2BKFJtVa6L5xHBmxAbb7m8kS1B2XUBTXK5ZnGP9bhjiC7/OZnp4TFZf3rPt6wQqx+oNqkOXBOQQSDGma5XZhKY6RbbAs9swDSiliqgfgXxVelLJzM4iPvIvzOt95OsM5H2xHFbPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767700051; c=relaxed/simple;
	bh=6GqlJaFzXA5bzQTTR5yWeTFqHDhFcjiLrkxpOk6hfTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jS7Y66XtIklSvrVpAmGceQXdcezrjlsJpDY5bSZnEDV2BwlU3ZBT4pPWldNrJF3pTD9mQT2OYqGdkiu9oY90OHbaKu+ZTNMMU6GOnIVjAsHxuYM4NZQHMjPglAm/R7jizlOIg78+vzoaDC/OnXLshxdjI4S1U2n+EUh/zTN8c/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me; spf=none smtp.mailfrom=ashlesh.me; dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b=ClRpHkKf; arc=none smtp.client-ip=136.175.108.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ashlesh.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ashlesh.me header.i=@ashlesh.me header.b="ClRpHkKf"
Received: from filter006.mxroute.com ([136.175.111.3] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta226.mxroute.com (ZoneMTA) with ESMTPSA id 19b931d5b1a0004eea.003
 for <git@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 06 Jan 2026 11:42:13 +0000
X-Zone-Loop: c89db96fb4ffaf1f77e74fb387fcd6451797a8168361
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=ashlesh.me;
	s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=uFVrEp/9WwOKBz5dB3fhGNgdBhuLKWQykD5PZjmy1zE=; b=ClRpHk
	KfvIGJajXpQz9Jy4/4UYBZhZfShVK/dhyf2aPbJuiFMCR8gfHphBdg74GUHSVXjbIHGsxrhirZqtH
	WPypxU7bdFxZy9vbXr84Si+ll4hkZzleWPXD6lsK9gbHZiOReQigf3H8f/wURju2FhBzToHrN77PE
	d8X7gvo/W62n1an06/vET2ycTlLWBT2f/OcP7D6NgIlkuXhdiZuZpIXl2Im7qgOImhmFNv5wnzhhx
	O/OQH6TVekEuDO75SAj0Qh2w+VFk17aLzoRz16ZI3zz5+8R0LmjJu0ymnD6Q6kVtWdbDhViOAJm+8
	cBOjfpdE1vn6X+ube4t9xKQVWdOg==;
From: Ashlesh Gawande <git@ashlesh.me>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	gitster@pobox.com,
	Ashlesh Gawande <git@ashlesh.me>
Subject: [PATCH v2] t5550: add netrc tests for http 401/403
Date: Tue,  6 Jan 2026 17:10:29 +0530
Message-ID: <20260106114029.763351-1-git@ashlesh.me>
In-Reply-To: <20260106093451.748761-1-git@ashlesh.me>
References: <20260106093451.748761-1-git@ashlesh.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: info@ashlesh.me

Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
---
Range-diff against v1:
1:  27e112ea42 ! 1:  0b68f1d1af t5550: add netrc tests for http 401/403
    @@ Commit message
         Signed-off-by: Ashlesh Gawande <git@ashlesh.me>
     
      ## t/lib-httpd.sh ##
    -@@ t/lib-httpd.sh: set_askpass() {
    +@@ t/lib-httpd.sh: setup_askpass_helper() {
    + 	'
    + }
    + 
    +-set_askpass() {
    ++set_askpass () {
    + 	>"$TRASH_DIRECTORY/askpass-query" &&
    + 	echo "$1" >"$TRASH_DIRECTORY/askpass-user" &&
      	echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
      }
      
    -+set_netrc() {
    +-expect_askpass() {
    ++set_netrc () {
     +	# $HOME=$TRASH_DIRECTORY
    -+	echo "machine $1 login $2 password $3" > $TRASH_DIRECTORY/.netrc
    ++	echo "machine $1 login $2 password $3" >"$TRASH_DIRECTORY/.netrc"
     +}
     +
    -+clear_netrc() {
    -+	rm "$TRASH_DIRECTORY/.netrc"
    ++clear_netrc () {
    ++	rm -f "$TRASH_DIRECTORY/.netrc"
     +}
     +
    - expect_askpass() {
    ++expect_askpass () {
      	dest=$HTTPD_DEST${3+/$3}
      
    + 	{
     
      ## t/lib-httpd/apache.conf ##
     @@ t/lib-httpd/apache.conf: SSLEngine On
    @@ t/t5550-http-fetch-dumb.sh: test_expect_success 'cloning password-protected repo
      '
      
     +test_expect_success 'using credentials from netrc to clone successfully' '
    ++	test_when_finished clear_netrc &&
     +	set_askpass wrong &&
     +	set_netrc 127.0.0.1 user@host pass@host &&
     +	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
     +	expect_askpass none
     +'
    -+clear_netrc
     +
     +test_expect_success 'netrc unauthorized credentials (prompt after 401)' '
    ++	test_when_finished clear_netrc &&
     +	set_askpass wrong &&
     +	set_netrc 127.0.0.1 user@host pass@wrong &&
     +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-401 &&
     +	expect_askpass both wrong
     +'
    -+clear_netrc
     +
     +test_expect_success 'netrc authorized but forbidden credentials (fail on 403)' '
    ++	test_when_finished clear_netrc &&
     +	set_askpass wrong &&
     +	set_netrc 127.0.0.1 forbidden-user@host pass@host &&
     +	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-403 2>err &&
     +	expect_askpass none &&
     +	grep "The requested URL returned error: 403" err
     +'
    -+clear_netrc
     +
      test_expect_success 'http auth can use user/pass in URL' '
      	set_askpass wrong &&

 t/lib-httpd.sh             | 13 +++++++++++--
 t/lib-httpd/apache.conf    |  4 ++++
 t/lib-httpd/passwd         |  1 +
 t/t5550-http-fetch-dumb.sh | 25 +++++++++++++++++++++++++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 5091db949b..5f42c311c2 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -319,13 +319,22 @@ setup_askpass_helper() {
 	'
 }
 
-set_askpass() {
+set_askpass () {
 	>"$TRASH_DIRECTORY/askpass-query" &&
 	echo "$1" >"$TRASH_DIRECTORY/askpass-user" &&
 	echo "$2" >"$TRASH_DIRECTORY/askpass-pass"
 }
 
-expect_askpass() {
+set_netrc () {
+	# $HOME=$TRASH_DIRECTORY
+	echo "machine $1 login $2 password $3" >"$TRASH_DIRECTORY/.netrc"
+}
+
+clear_netrc () {
+	rm -f "$TRASH_DIRECTORY/.netrc"
+}
+
+expect_askpass () {
 	dest=$HTTPD_DEST${3+/$3}
 
 	{
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index e631ab0eb5..6b8c50a51a 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -238,6 +238,10 @@ SSLEngine On
 	AuthName "git-auth"
 	AuthUserFile passwd
 	Require valid-user
+
+	# return 403 for authenticated user: forbidden-user@host
+	RewriteCond "%{REMOTE_USER}" "^forbidden-user@host"
+	RewriteRule ^ - [F]
 </Location>
 
 <LocationMatch "^/auth-push/.*/git-receive-pack$">
diff --git a/t/lib-httpd/passwd b/t/lib-httpd/passwd
index d9c122f348..3bab7b6423 100644
--- a/t/lib-httpd/passwd
+++ b/t/lib-httpd/passwd
@@ -1 +1,2 @@
 user@host:$apr1$LGPmCZWj$9vxEwj5Z5GzQLBMxp3mCx1
+forbidden-user@host:$apr1$LGPmCZWj$9vxEwj5Z5GzQLBMxp3mCx1
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index ed0ad66fad..9530f01b9e 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -102,6 +102,31 @@ test_expect_success 'cloning password-protected repository can fail' '
 	expect_askpass both wrong
 '
 
+test_expect_success 'using credentials from netrc to clone successfully' '
+	test_when_finished clear_netrc &&
+	set_askpass wrong &&
+	set_netrc 127.0.0.1 user@host pass@host &&
+	git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc &&
+	expect_askpass none
+'
+
+test_expect_success 'netrc unauthorized credentials (prompt after 401)' '
+	test_when_finished clear_netrc &&
+	set_askpass wrong &&
+	set_netrc 127.0.0.1 user@host pass@wrong &&
+	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-401 &&
+	expect_askpass both wrong
+'
+
+test_expect_success 'netrc authorized but forbidden credentials (fail on 403)' '
+	test_when_finished clear_netrc &&
+	set_askpass wrong &&
+	set_netrc 127.0.0.1 forbidden-user@host pass@host &&
+	test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-netrc-403 2>err &&
+	expect_askpass none &&
+	grep "The requested URL returned error: 403" err
+'
+
 test_expect_success 'http auth can use user/pass in URL' '
 	set_askpass wrong &&
 	git clone "$HTTPD_URL_USER_PASS/auth/dumb/repo.git" clone-auth-none &&
-- 
2.43.0

