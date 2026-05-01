Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAADC33F5AE
	for <git@vger.kernel.org>; Fri,  1 May 2026 23:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777677318; cv=none; b=Fju1Bcz3p1lYshP6zQInLZUM2fis8fvaxUhGx4xzebwkhahLIbAxHLmtpSXrzTXzIwI7WM5GFWu9KpQeqvAeb28aNyC/3rfd+RLa35KBDzENWL26AyfY8BoSHXfL6UaX8XB/Amngkfr4hm01n/Z6CKdB4TsSpUN8sylBKthobMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777677318; c=relaxed/simple;
	bh=l0tlNdf+upsmV/F2s+3E4DuQ+w8kAc45xqeRAbGJmNY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=PheuBHYRh0fJzuvT9eoTvgISQnoO5GdO9dmEHL7hAz83fD95ozB2qoDpABHVGPoNJKfpWk1zety6kp0dNPB30FqVEtMQzA/0g9Xs9JNShAEuXNkR50rwgCcYnrYS3Q++n/UFjTjQptCWCGrI67bOTlnD4lmX4lg+6+3KeQR/xNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC3eWIdR; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC3eWIdR"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2d868d014a5so2495236eec.1
        for <git@vger.kernel.org>; Fri, 01 May 2026 16:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777677315; x=1778282115; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ubQTVqhLBqKIanSEYTjmaZoP9FiAPOOqVMMpqgoaLQ4=;
        b=iC3eWIdRVpTKhFla4NSmC8wJNpGSRwT/OVmjHOBXWDXFf6/n9tZwLmx8lEhnRU8/zJ
         lI5B4IZW0iu+r0Luo9f4kOKU0HIjKmFbLBHAR5veMZJqRCwXqrI/CtNRKmlKOF1HML17
         NbamurqrFjwMf+R+YMjTj8s7Ng0uUtPju1eT4Y6lrQYA0A2NMwClA3f0CwRxwu9oe5dn
         xyKyZUVEDCJ/UJUwfCTE1Zhmq1WJpCAu6xR59qeDJ08T8DZjqcd3j9jxC+PHvWQpYaf2
         rOnsTpcSAglJN5fH2vfnqMsn/3ik+oHk4EvublH2/l/yMPDjHB293SXSPnrzHTrB1ETg
         QmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777677315; x=1778282115;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ubQTVqhLBqKIanSEYTjmaZoP9FiAPOOqVMMpqgoaLQ4=;
        b=TwyqF3eaUhVp8h+o5907FfZ2kiN67Un9VWO/IFefOmCbGezNa+OmuZsMbWwkZnoHrZ
         cQe7Wp0Sk8Bn6IwHjV7cD4iDm7WaPai36zkOyPYqJWTEt3jPzRkI9yn1y0BY8v7iuvIB
         UDNwzIRkpGg6eQ29uAVyok+X/X/okb4c1FwB/is3tCzMJhqbDUa44EmQ5SrNyWx0H9ST
         D4vhd7wcBHbWx4NIwiF6czcGQ8wTTOyuFZRgnmFDUu3ZHbjzpxZAgINhjp9iXmzxU4Q8
         9XZ0+2XK/IxlmebEuxw1S+nCWxcj6PGmn9f9W1yhHifFfZnjnFHJeF03DxgSSSiTbWaX
         aaiA==
X-Gm-Message-State: AOJu0YxepUFHb+jYYgaejGTh74Ol6VNQTuKFGRRAuEAkc8oeUhfd209d
	TrLriDJAEe2oaavK2f+QWh8CW3SjuahnuX37wGVEadk5UdG3qPrWWHg836QH3QrF
X-Gm-Gg: AeBDiesHB0Oh4p+G0eoAsvNyRWdG5iFl7Ss6Yz5TnEimlgHqHugSCbd69WmZrH/re6O
	01QWD39j5CGEQIZmhFtKFPx9YEM+LNLFK++bYjVM86TOotnjZLE+OtsXxJbja5+Qgf3ce0o8dUd
	DglXi1FfuXwVQgrKWQ3be1Itfc4KcOH7G33nQE1mBgRdlbNTKRNbErVZ+eQTIYBRG7/xARVcWdq
	aPlGRfQOOttTeAyJzys49ffOsAZmRMpfZz7TTRddWMDyWF5GdeSxPO7TAfuAu488qGqt01p5wrS
	j+lnA1Hb0b1pKTGESPLrRSisUV+kz1zYNQk9Ekho5bVaLtWhW/8huaEm8R6/fy6TXChJ+mhL4cH
	HRAmt14mhkGCLoeE3sOmsPHAmqG4GGIfxUdOC5sgjuG3QbcaStp8uuO+OqGHwkS3yiOcnDt1SrL
	XOUor3TeqAHwrbcM3jML5odJopQQZ3JH8ONrvlVXo=
X-Received: by 2002:a05:7300:ec0a:b0:2df:c5bb:3720 with SMTP id 5a478bee46e88-2efb8998ae0mr612221eec.15.1777677314390;
        Fri, 01 May 2026 16:15:14 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.231.147])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bf6811fsm6110821eec.29.2026.05.01.16.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 16:15:13 -0700 (PDT)
Message-Id: <38f797362d268a51b979efaa1d435d9f7a3378f6.1777677310.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
	<pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 01 May 2026 23:15:03 +0000
Subject: [PATCH v2 1/8] connect: rename enum protocol to url_scheme
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

