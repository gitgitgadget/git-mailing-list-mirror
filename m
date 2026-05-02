Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A302C0294
	for <git@vger.kernel.org>; Sat,  2 May 2026 05:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777699728; cv=none; b=LSpSnFd+06JmK8lCiQHXuSGu8brVggSDOr+j8af2YdoYdMNYzymIBxeuqWbd99JlopwCZXQRes4lNCBfB2yVLhFNknIRiETjgU+a0Fk0MOcs3p0fOS4HSmEKSK/Z107JkLR/voI+inrP35LZRq6ccASz1ULBKEDv4AdDCkOLr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777699728; c=relaxed/simple;
	bh=l0tlNdf+upsmV/F2s+3E4DuQ+w8kAc45xqeRAbGJmNY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=ZLL9NelXms7MWTSdF7Hl4uE1nmqyyL5QmgylxYzNSuvsybeO2Ll+VF1dygViyaPRk6/1Tcuy2WRoL7mQ+ooY4EyWgNdf+Q97FZfQAle6km7hmEn7Xff8yizS7MvQ0zf29iMBfavPuk/EG9t/BIeFnvCb7b3mDKLQlXnicaYPIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRFwaaJo; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRFwaaJo"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8b5232009a6so15632696d6.1
        for <git@vger.kernel.org>; Fri, 01 May 2026 22:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777699725; x=1778304525; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubQTVqhLBqKIanSEYTjmaZoP9FiAPOOqVMMpqgoaLQ4=;
        b=nRFwaaJojFLKDeCWPhIE+zbh784N68MdQA4K4Uool//0PptmMExAdeYtfaVa9oLdFq
         Mgg2UV4xigmUJBssyD1ZeuOH1YrC/3VAaMhLfosAvzEuCY7lvNRkEGONnQhTfrfIVRd4
         /cZ0xQigFZSpXFvZyZthbrYLm84tbyqF0dAdxRX9SZs7I2LxCq7b2TpvkyYUJ/MmuSCP
         mEEa2ibCWno4azqRiRtbmPA/kw6UhWFfqhZn4+JSOWB0rR6YiUhvwgDNjj9FwD4qLO6p
         ZmseLPv4Nt7lmYuWlVGJ0+18i6xu7kn0194YCybQp9vMWF3OGPskX2CfOlPraEN+fqYh
         HJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777699725; x=1778304525;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubQTVqhLBqKIanSEYTjmaZoP9FiAPOOqVMMpqgoaLQ4=;
        b=H+fKQku5eRnMCgk/mPe+iOUWFvGkzL9fSMr/ddRujDV+gaXg+jxQgy/rOafTWeRyC6
         pZGEqH/Rt9Vj81dvHvCKS0AcUZ2HbaTDSpY0BS+NOaAj1SZO0gZKeFulYv+CaZ9r62nJ
         rPbiIc5d/7d2vTSXyoDY8R3v9QxAIm2uixzsj2Vf+3Vte117/4QdYJxtB6ZU61u95uEk
         CXc8A6mI1DiJftZ8FJea88vj9EyyXU7VrEVgzkEFoNJK9J9T13Dj0moxWrNyBAkFt+fr
         vref1GK5e2rtwlLMeo7GKazP7+HjyZb9Rnr8lsEXC7dz7YeECGPXt4Qe8BwvK1x+l146
         AnfA==
X-Gm-Message-State: AOJu0YwWcr4gZh2so7ZAEEpy3+Zg8jB+4Ck3uBH3Fuwz7THxPMTD5QiG
	ws2e7ETBBCDtmz/GjNcpafUNyL52taSF3rdQPhRGoaXqi1yAgj/W5hGK7QRwNQ==
X-Gm-Gg: AeBDies9KBlNSifkk/Ryaw0jWTlg2V/qXAo3aQbrC8WkQTfJwjGHSn2QY0pSr5sjv+A
	4mjWq3GBKr7kOff1MVgFdH5nhJ3LJm5akeyMEbHe9r75CmBNlzPU8z+l5vkPkd0sW4FPEdu0aQ8
	CTE8gUDdqRIp2PT8o6b0xyEAu9i6Rrb3CK7bxh3WoW6Z0+gRG+59CmfwCwIlfLSqHW7ogtR8W3c
	iFdxSgDGzgLvsCVBlVlq08jHv0rt4lT/d3wD/OWCbiCQ7wjRel7n04XAzKS3VHHQzT0L9v+cG3E
	cLtckuSwDbnMRf/OVYdaNR6zWkAbD7adAjNU3lFAKQdiUX1P7/vyKLb+IeHQLvoAathIOyAbjME
	FdqJ1mF15X0RpT1MuvReZJM7DZ9pq4ojZdvYaMrHYhf8icC5AcRwTOAmqz3TaiMtatL5nCKE/oz
	bysViQvX0/pFM1LnLjXGAGT+5Uv+CHu8CamdXU3Ag=
X-Received: by 2002:a05:6214:2481:b0:8ac:ac3a:f1a6 with SMTP id 6a1803df08f44-8b665c140a9mr39696756d6.5.1777699725365;
        Fri, 01 May 2026 22:28:45 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.103])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53cd827c5sm57212716d6.40.2026.05.01.22.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 22:28:44 -0700 (PDT)
Message-Id: <38f797362d268a51b979efaa1d435d9f7a3378f6.1777699722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
	<pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 05:28:35 +0000
Subject: [PATCH v3 1/8] connect: rename enum protocol to url_scheme
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

RFC 1738 names the part of a URL before the colon a "scheme".
connect.c calls it "protocol", which is more generic
and collides with the unrelated enum protocol_version.

Rename:

    enum protocol -> enum url_scheme
    PROTO_*       -> URL_SCHEME_*
    prot_name     -> url_scheme_name
    get_protocol  -> url_get_scheme

The local variables in parse_connect_url and git_connect
are renamed accordingly, from protocol to scheme.

No behavior change. The user-visible diagnostics
and translated error messages are preserved:

    "Diag: protocol=..."
    "protocol '%s' is not supported"
    "unknown protocol"

This rename also prepares for moving the scheme-detection functions
to a shared header so that a future plumbing command can parse URLs
using the same logic as the connect path.

Suggested-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 connect.c | 68 +++++++++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/connect.c b/connect.c
index fcd35c5539..46da89905e 100644
--- a/connect.c
+++ b/connect.c
@@ -700,11 +700,11 @@ int server_supports(const char *feature)
 	return !!server_feature_value(feature, NULL);
 }
 
-enum protocol {
-	PROTO_LOCAL = 1,
-	PROTO_FILE,
-	PROTO_SSH,
-	PROTO_GIT
+enum url_scheme {
+	URL_SCHEME_LOCAL = 1,
+	URL_SCHEME_FILE,
+	URL_SCHEME_SSH,
+	URL_SCHEME_GIT
 };
 
 int url_is_local_not_ssh(const char *url)
@@ -715,33 +715,33 @@ int url_is_local_not_ssh(const char *url)
 		(has_dos_drive_prefix(url) && is_valid_path(url));
 }
 
-static const char *prot_name(enum protocol protocol)
+static const char *url_scheme_name(enum url_scheme scheme)
 {
-	switch (protocol) {
-		case PROTO_LOCAL:
-		case PROTO_FILE:
+	switch (scheme) {
+		case URL_SCHEME_LOCAL:
+		case URL_SCHEME_FILE:
 			return "file";
-		case PROTO_SSH:
+		case URL_SCHEME_SSH:
 			return "ssh";
-		case PROTO_GIT:
+		case URL_SCHEME_GIT:
 			return "git";
 		default:
 			return "unknown protocol";
 	}
 }
 
-static enum protocol get_protocol(const char *name)
+static enum url_scheme url_get_scheme(const char *name)
 {
 	if (!strcmp(name, "ssh"))
-		return PROTO_SSH;
+		return URL_SCHEME_SSH;
 	if (!strcmp(name, "git"))
-		return PROTO_GIT;
+		return URL_SCHEME_GIT;
 	if (!strcmp(name, "git+ssh")) /* deprecated - do not use */
-		return PROTO_SSH;
+		return URL_SCHEME_SSH;
 	if (!strcmp(name, "ssh+git")) /* deprecated - do not use */
-		return PROTO_SSH;
+		return URL_SCHEME_SSH;
 	if (!strcmp(name, "file"))
-		return PROTO_FILE;
+		return URL_SCHEME_FILE;
 	die(_("protocol '%s' is not supported"), name);
 }
 
@@ -1083,14 +1083,14 @@ static char *get_port(char *host)
  * Extract protocol and relevant parts from the specified connection URL.
  * The caller must free() the returned strings.
  */
-static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
-				       char **ret_path)
+static enum url_scheme parse_connect_url(const char *url_orig, char **ret_host,
+					 char **ret_path)
 {
 	char *url;
 	char *host, *path;
 	char *end;
 	int separator = '/';
-	enum protocol protocol = PROTO_LOCAL;
+	enum url_scheme scheme = URL_SCHEME_LOCAL;
 
 	if (is_url(url_orig))
 		url = url_decode(url_orig);
@@ -1100,12 +1100,12 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	host = strstr(url, "://");
 	if (host) {
 		*host = '\0';
-		protocol = get_protocol(url);
+		scheme = url_get_scheme(url);
 		host += 3;
 	} else {
 		host = url;
 		if (!url_is_local_not_ssh(url)) {
-			protocol = PROTO_SSH;
+			scheme = URL_SCHEME_SSH;
 			separator = ':';
 		}
 	}
@@ -1116,13 +1116,13 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	 */
 	end = host_end(&host, 0);
 
-	if (protocol == PROTO_LOCAL)
+	if (scheme == URL_SCHEME_LOCAL)
 		path = end;
-	else if (protocol == PROTO_FILE && *host != '/' &&
+	else if (scheme == URL_SCHEME_FILE && *host != '/' &&
 		 !has_dos_drive_prefix(host) &&
 		 offset_1st_component(host - 2) > 1)
 		path = host - 2; /* include the leading "//" */
-	else if (protocol == PROTO_FILE && has_dos_drive_prefix(end))
+	else if (scheme == URL_SCHEME_FILE && has_dos_drive_prefix(end))
 		path = end; /* "file://$(pwd)" may be "file://C:/projects/repo" */
 	else
 		path = strchr(end, separator);
@@ -1138,7 +1138,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	end = path; /* Need to \0 terminate host here */
 	if (separator == ':')
 		path++; /* path starts after ':' */
-	if (protocol == PROTO_GIT || protocol == PROTO_SSH) {
+	if (scheme == URL_SCHEME_GIT || scheme == URL_SCHEME_SSH) {
 		if (path[1] == '~')
 			path++;
 	}
@@ -1149,7 +1149,7 @@ static enum protocol parse_connect_url(const char *url_orig, char **ret_host,
 	*ret_host = xstrdup(host);
 	*ret_path = path;
 	free(url);
-	return protocol;
+	return scheme;
 }
 
 static const char *get_ssh_command(void)
@@ -1434,7 +1434,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 {
 	char *hostandport, *path;
 	struct child_process *conn;
-	enum protocol protocol;
+	enum url_scheme scheme;
 	enum protocol_version version = get_protocol_version_config();
 
 	/*
@@ -1451,14 +1451,14 @@ struct child_process *git_connect(int fd[2], const char *url,
 	 */
 	signal(SIGCHLD, SIG_DFL);
 
-	protocol = parse_connect_url(url, &hostandport, &path);
-	if ((flags & CONNECT_DIAG_URL) && (protocol != PROTO_SSH)) {
+	scheme = parse_connect_url(url, &hostandport, &path);
+	if ((flags & CONNECT_DIAG_URL) && (scheme != URL_SCHEME_SSH)) {
 		printf("Diag: url=%s\n", url ? url : "NULL");
-		printf("Diag: protocol=%s\n", prot_name(protocol));
+		printf("Diag: protocol=%s\n", url_scheme_name(scheme));
 		printf("Diag: hostandport=%s\n", hostandport ? hostandport : "NULL");
 		printf("Diag: path=%s\n", path ? path : "NULL");
 		conn = NULL;
-	} else if (protocol == PROTO_GIT) {
+	} else if (scheme == URL_SCHEME_GIT) {
 		conn = git_connect_git(fd, hostandport, path, prog, version, flags);
 		conn->trace2_child_class = "transport/git";
 	} else {
@@ -1481,7 +1481,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 		conn->use_shell = 1;
 		conn->in = conn->out = -1;
-		if (protocol == PROTO_SSH) {
+		if (scheme == URL_SCHEME_SSH) {
 			char *ssh_host = hostandport;
 			const char *port = NULL;
 			transport_check_allowed("ssh");
@@ -1492,7 +1492,7 @@ struct child_process *git_connect(int fd[2], const char *url,
 
 			if (flags & CONNECT_DIAG_URL) {
 				printf("Diag: url=%s\n", url ? url : "NULL");
-				printf("Diag: protocol=%s\n", prot_name(protocol));
+				printf("Diag: protocol=%s\n", url_scheme_name(scheme));
 				printf("Diag: userandhost=%s\n", ssh_host ? ssh_host : "NULL");
 				printf("Diag: port=%s\n", port ? port : "NONE");
 				printf("Diag: path=%s\n", path ? path : "NULL");
-- 
gitgitgadget

