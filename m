Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741057;
	b=ckp3nNyTqYHbKRl3trAZwE9BrwF21NZOdBU6BOL8E3jUiueQDjJDXjlEUswl9kJB2jFx
	 MeQmPKF7zz/y4jV+je5dTXMHyQF3odEbZbVWO+gxZ1WTSu/7K90+30+IXXwImrQnEx9ZZ
	 N+Xjxd8kh563p/bHRoXtmMilwRo+pqHpM2tuSvNkN6+7aFOOzLB0rZQXspTIfWHERwQqE
	 OUIBENeMw/4QeVsRimht2ef1rA4rXtrgpoMWU7nOPGPZ2cbBLp5YcuuBbLA4wg0sG6iCJ
	 CNhz09HRxeeDwM10oLVk5us24OeEe/gqN89zTguvjIgMN33vOxhFHjQEoCbDn9xWsRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741057;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y8dPjdUAy3k5k46yIciIjl0P3kjY/GqfP66BCK5Bfdo=;
	b=u74UCp2GUm/n64jyXBO6YwSWXx78p6rISAkexD55tGukJLWUYJDRheesZrLgeHVptvev
	 hhFKc3n6J/tUEe3byx+RAHEBtBYqqrqw+7HjdIzHMkBLzvJJ+sizjB8SOZ0P2WYyPq75h
	 7eB6F8DbFjVwEZSHMHpBJbScqI1wE2Cuz2ujluiibOGgeJwwp4tUMfl0IPf7CBW09ES6j
	 BL1lzM+K66EkFjlCXdocX3GxDTj3C3bVAcGaPORssFv2BohbBa4krWnFd3AcEH3SadZOa
	 iTMFxRXtEZp/0QAAYjhyKgO+LNuzXpg9t/mrn4dfKjbGlhG2IkxHXqggwB+kHWYsYWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=baNo1VdD;
	arc=none smtp.remote-ip=209.85.167.177
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC1606A329
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 21:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66CC1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=baNo1VdD
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4f66bb2ab57so19247b6e.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 13:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793741056; x=1794345856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y8dPjdUAy3k5k46yIciIjl0P3kjY/GqfP66BCK5Bfdo=;
        b=baNo1VdD9RJo1SLDIKpSztS8Ur3GkI8H2T07/AJ6Sh9Osgfa5hLxwwUuuQZAi7AYzQ
         fhCX5rdv070e+Ynhubn5X9wamwngQux2zEXOXwMPdARHVz3976tFty//3/hQucVVrjCH
         sSzawmFyjwXUKux3Le8HvG1XQLBEiAnda6QHF8xJ6RE4oOFQgX1jOmGoW1rxk2028Le4
         MxGJ7piwmCvsamJxe4iQHreu6KeXQfR1izH8hZpIutqrWRhJGVKrOtUjuJSpVvPW0/4H
         M5gSseEx1VJdtYkZpHg5h6xSviMguU+QfEUcD9xbFS/xkATy3AOx1I45tKE44ENZqBST
         kxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793741056; x=1794345856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y8dPjdUAy3k5k46yIciIjl0P3kjY/GqfP66BCK5Bfdo=;
        b=mSIkmlZL7DgpWRKQIYY9FiQqgYqRLMOv4cpDI1xG0FMdpR4qGNc3ofNwdMtWfBnsmg
         epF55bqBQnA/TKZYyJlKyKSdDY7RwxA5fA83Vr4qdbmxhmABNDgozscRBKyWj8xpbhNv
         0MOxxP2FOSj6AzaKBrSRXnn2oLuaSffGSSrV2ss+OPsYMg5oE9+3RisrEDAM7HCynWp7
         3S1tqp254P+UaEuqsha9c2Rphim0Z3v+68xQJ+cW0P9cDWZfV4Xcf4eYcZZjcxysITHy
         QNltqwb1j+kbV1v/bikLTlZk9UFu7PcR6XYMrM9pTmMW/5fpp7MT03zEzv77RERczfl+
         kCpg==
X-Gm-Message-State: APuU4Z97GiWum9O8apROoTclIb9mAGz70KDT2gsjMwOv9uMtwh4XMEVI
	6zSDEVP0OrPNtvoQH8J9fmDDcA6HXNF3cBKXsy4Qi/x/S5d/ibBwVI/UiO1fgA==
X-Gm-Gg: AYBFou3xh0CsaiW4+pA3WiMOM2v8RsEuQW5zIdqHxRT0ZZ7M16oguaAALipIrHrsCDE
	Lb2EaylJXzIykLTY8NQPwmhria+3d4LC33pEeATs/FkYsTJoIImf8S4CvRCblRRIOpgprzgmkH2
	kQ/RLxUbHuRTQ7qCfDWN+CsB7wOZVZZoeiMPJy9Pk1XS8rMlxSCW9dS8Giqg05SdfXCepD9w7sZ
	tN5F1onZ6KQfoZV/NroAWmoLFS5jOWy7uejwxQlbSLaPtKfEzzcrlPLp/C3oI1gCkI182iUWgNd
	W7FKdV/V4vqkwKH4R02UXriE9kBio89x47bJNFJHGfLoyrznR0bRBv61w3zWmXKEEl/RBEvvb5z
	apGkclulE6oAZBJ+mqzfuZ2xPuwKH0bLOg/gjDJPHKX978Z7p1zoca/bxAF6B6w9UC3/WHFmMKv
	KHhnkeJdH3nwRUJsP3smnW2LX/VcnVitKliGHD8IMTPvK2PCzy591u5yq3NeRT6g80QnXC2QHGt
	ArSHDisFhIMTdh0ke9CY84T4XCpmHsIv9JLTJbKfUBpmKM0D5oGUgrI3fbJqkkeiTwYVY/ae/Vf
	UiiZzUkjnOfWlye+RNNMWy0cGNxSE33zT/sJ8jIRvgWOa/Ie8EcfeIH5iTcU2JnpZTTv
X-Received: by 2002:a05:6808:130a:b0:4e9:4aab:be24 with SMTP id 5614622812f47-5640def1723mr9369397b6e.48.1793741056379;
        Tue, 03 Nov 2026 13:24:16 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-567a9c7bbcesm15628b6e.1.2026.11.03.13.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 13:24:15 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/2] object-file: return error on index-pack abnormal exit
Date: Tue,  3 Nov 2026 15:24:10 -0600
Message-ID: <20261103212410.1389988-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261103212410.1389988-1-jltobler@gmail.com>
References: <20261103212410.1389988-1-jltobler@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When git-index-pack(1) exits abnormally after reporting the packfile
name, `odb_transaction_files_write_pack()` records an error message in
`err_msg` but still returns success. Current callers ultimately discard
the return value, so this does not cause any issues at present, but the
return value should still reflect the failure.

Update `odb_transaction_files_write_pack()` to return an error value in
this case accordingly. While at it, simplify how the child process exit
statuses are checked.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 object-file.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/object-file.c b/object-file.c
index a9800143bd..e04ce0bc11 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1429,8 +1429,7 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 	struct pack_header hdr;
 	const char *hdr_err;
 	int err_fd = opts->err_fd;
-	int ret = -1;
-	int status;
+	int ret;
 
 	hdr_err = parse_pack_header(&hdr, pack_fd);
 	if (hdr_err) {
@@ -1462,12 +1461,13 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 		child.in = pack_fd;
 		child.err = err_fd;
 		child.git_cmd = 1;
-		status = run_command(&child);
-		if (status) {
+		if (run_command(&child)) {
 			strbuf_addstr(err_msg, "unpack-objects abnormal exit");
 			return -1;
 		}
 	} else {
+		int report_err;
+
 		strvec_pushl(&child.args, "index-pack", "--stdin", NULL);
 		push_header_arg(&child.args, &hdr);
 
@@ -1487,24 +1487,24 @@ static int odb_transaction_files_write_pack(struct odb_transaction *base,
 		child.in = pack_fd;
 		child.err = err_fd;
 		child.git_cmd = 1;
-		status = start_command(&child);
-		if (status) {
+		if (start_command(&child)) {
 			strbuf_addstr(err_msg, "index-pack fork failed");
 			return -1;
 		}
 
-		ret = read_index_pack_report(repo, child.out, &pack_name, NULL);
+		report_err = read_index_pack_report(repo, child.out, &pack_name, NULL);
 
 		close(child.out);
 
-		status = finish_command(&child);
-		if (status) {
+		if (finish_command(&child)) {
 			strbuf_addstr(err_msg, "index-pack abnormal exit");
+			ret = -1;
 			goto out;
 		}
 
-		if (ret) {
+		if (report_err) {
 			strbuf_addstr(err_msg, "index-pack failed to report pack name");
+			ret = -1;
 			goto out;
 		}
 
-- 
2.56.0.173.gf57c9a7388

