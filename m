Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A3319D093
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728774582; cv=none; b=pkK3fXX2CLMv6bEHTALkYwSLVbWRVVkQApNsdynUP4RVTunmkMRtLbbG4cFnwjvYnKPv/LxXpV6aFtKfUNRvjANAck4KmcWWOzv8bOi+Ehw7dUNRRI2Fhq+UbWjhb2/KrphCV1el0/on5FSjulhNFkRo9AtW7SxGtAhzPyDCPqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728774582; c=relaxed/simple;
	bh=7bpQVogFRZba4WJYe1GBYmR8qgJSoJW70VY5OPh60DI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lcqbdNLCWUMjnaNTfSNKYdU6WciZhGF0uAXeggbteWpOXJNRl2P426lZLh4M1qMmepOHP7m04147ENG1DLbTDAAFulqiVZrdYKiKNbqxgNlYKkKnYF9QRDud/aI5HorvqsJzR/MIHdtuEUgfqQzXHsfR/Lxs4lLkzUlCamfVbaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QISWxOQ8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QISWxOQ8"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9693dc739so863212a12.3
        for <git@vger.kernel.org>; Sat, 12 Oct 2024 16:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728774578; x=1729379378; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixC0PykCG8fT0v2MCRNh7cdq1tQKAbrAjjYPXFEUFio=;
        b=QISWxOQ8DVJnnUPx8OuSvPOvVZ1zNuITW+EdKsi7KUiDatR/vXpfwen8Px44LJKepW
         93f7ueplnFrz6tiH3JH2WHUeulrP6JCUXFe7EWbYoqynRv4C8Ay/OjI6YKaJYPwbCMEO
         MTZUI1ePWW44wVIRV1o9bq6iMc8MzkOitzxx51siLdheAKsEeb1IN1+np7H+t23S09yS
         P6sPw6Kgk34i9e1/L54nbADhvu9NibpBnPkTvAJ3aRxQBBaJIk0MDmoZ7NXqZ393nSMv
         sz9wqMYA1Goj/+1T2N/1vsIUMdaQP0OAn8Pcc9cc544ae7FveYb/HlQy5+ETu/4INGC/
         kX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728774578; x=1729379378;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixC0PykCG8fT0v2MCRNh7cdq1tQKAbrAjjYPXFEUFio=;
        b=SonVGRexCnS0zOJeLX/wS32AjetW18nTVlZztye3Juo50zODOHZzEjCu6la+bz1K7N
         jhs8iwNENenOo5i2HNyPN/FIXIeCNgonUW/hYbneW9kIbMum76IwzaeSWntjKp19H7cO
         hQdrGYY2Jrx/4yuZ6isQWGzCM2N8qQQezw4RBNjJGzKT25i8hbhq1aKNjmdaAI1y0gyj
         5gEoYuXAREiEad1ba+yTViemCtWM98GNKa5Djh7aAAnPpEvS6f9gaJM8tLs0JA+6VN7L
         6lMmxijkOdTPlwMDLUj86bwBie1kvC6fVM8/uZ1GIBWkKBa1G7/HUpdHs4Nyy0JTpgoO
         3mPA==
X-Gm-Message-State: AOJu0YyUYCrufATDIEsBH4uUGSKyRe1Q0bUA2vLuxO7tbaDvV+/3ZLJR
	dX4HavqHhBCE8pSN30WARZxsBssB1KxEYTudmuaEo+ppSdcgpetjL7YLQw==
X-Google-Smtp-Source: AGHT+IHLt/OobXcAI+fNKM1Zs8OYovlq2Z337LW98JFQXr3bFolmVYAuUYJIFJPSnApH2YLR6/wzPA==
X-Received: by 2002:a05:6402:27d3:b0:5c9:5737:ddf2 with SMTP id 4fb4d7f45d1cf-5c95abf2c9emr2002291a12.6.1728774578348;
        Sat, 12 Oct 2024 16:09:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937151e50sm3257512a12.43.2024.10.12.16.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 16:09:37 -0700 (PDT)
Message-Id: <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 12 Oct 2024 23:09:34 +0000
Subject: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Replace unsafe uses of atoi() with strtoul_ui() for unsigned integers
and strtol_i() for signed integers across multiple files. This change
improves error handling and prevents potential integer overflow issues.

The following files were updated:
- daemon.c: Update parsing of --timeout, --init-timeout, and
  --max-connections
- imap-send.c: Improve parsing of UIDVALIDITY, UIDNEXT, APPENDUID, and
  tags
- merge-ll.c: Enhance parsing of marker size in ll_merge and
  ll_merge_marker_size

This change allows for better error detection when parsing integer
values from command-line arguments and IMAP responses, making the code
more robust and secure.

This is a #leftoverbit discussed here:
 https://public-inbox.org/git/CAC4O8c-nuOTS=a0sVp1603KaM2bZjs+yNZzdAaa5CGTNGFE7hQ@mail.gmail.com/

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>

Cc: gitster@pobox.com
Cc: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood123@gmail.com
Cc: Christian Couder <christian.couder@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
Cc: Taylor Blau <me@ttaylorr.com>
---
 daemon.c    | 14 +++++++++-----
 imap-send.c | 13 ++++++++-----
 merge-ll.c  |  6 ++----
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/daemon.c b/daemon.c
index cb946e3c95f..3fdb6e83c40 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1308,17 +1308,21 @@ int cmd_main(int argc, const char **argv)
 			continue;
 		}
 		if (skip_prefix(arg, "--timeout=", &v)) {
-			timeout = atoi(v);
+			if (strtoul_ui(v, 10, &timeout) < 0) {
+				die("'%s': not a valid integer for --timeout", v);
+			}
 			continue;
 		}
 		if (skip_prefix(arg, "--init-timeout=", &v)) {
-			init_timeout = atoi(v);
+			if (strtoul_ui(v, 10, &init_timeout) < 0) {
+				die("'%s': not a valid integer for --init-timeout", v);
+			}
 			continue;
 		}
 		if (skip_prefix(arg, "--max-connections=", &v)) {
-			max_connections = atoi(v);
-			if (max_connections < 0)
-				max_connections = 0;	        /* unlimited */
+			if (strtol_i(v, 10, &max_connections) != 0 || max_connections < 0) {
+				max_connections = 0;  /* unlimited */
+			}
 			continue;
 		}
 		if (!strcmp(arg, "--strict-paths")) {
diff --git a/imap-send.c b/imap-send.c
index ec68a066877..33b74dfded7 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -668,12 +668,12 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		return RESP_BAD;
 	}
 	if (!strcmp("UIDVALIDITY", arg)) {
-		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &ctx->uidvalidity) != 0) {
 			fprintf(stderr, "IMAP error: malformed UIDVALIDITY status\n");
 			return RESP_BAD;
 		}
 	} else if (!strcmp("UIDNEXT", arg)) {
-		if (!(arg = next_arg(&s)) || !(imap->uidnext = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || strtol_i(arg, 10, &imap->uidnext) != 0) {
 			fprintf(stderr, "IMAP error: malformed NEXTUID status\n");
 			return RESP_BAD;
 		}
@@ -686,8 +686,8 @@ static int parse_response_code(struct imap_store *ctx, struct imap_cmd_cb *cb,
 		for (; isspace((unsigned char)*p); p++);
 		fprintf(stderr, "*** IMAP ALERT *** %s\n", p);
 	} else if (cb && cb->ctx && !strcmp("APPENDUID", arg)) {
-		if (!(arg = next_arg(&s)) || !(ctx->uidvalidity = atoi(arg)) ||
-		    !(arg = next_arg(&s)) || !(*(int *)cb->ctx = atoi(arg))) {
+		if (!(arg = next_arg(&s)) || (strtol_i(arg, 10, &ctx->uidvalidity) != 0) ||
+			!(arg = next_arg(&s)) || (strtol_i(arg, 10, (int *)cb->ctx) != 0)) {
 			fprintf(stderr, "IMAP error: malformed APPENDUID status\n");
 			return RESP_BAD;
 		}
@@ -773,7 +773,10 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
 			if (!tcmd)
 				return DRV_OK;
 		} else {
-			tag = atoi(arg);
+			if (strtol_i(arg, 10, &tag) != 0) {
+				fprintf(stderr, "IMAP error: malformed tag %s\n", arg);
+				return RESP_BAD;
+			}
 			for (pcmdp = &imap->in_progress; (cmdp = *pcmdp); pcmdp = &cmdp->next)
 				if (cmdp->tag == tag)
 					goto gottag;
diff --git a/merge-ll.c b/merge-ll.c
index 8e63071922b..2bfee0f2c6b 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -427,8 +427,7 @@ enum ll_merge_result ll_merge(mmbuffer_t *result_buf,
 	git_check_attr(istate, path, check);
 	ll_driver_name = check->items[0].value;
 	if (check->items[1].value) {
-		marker_size = atoi(check->items[1].value);
-		if (marker_size <= 0)
+		if (strtol_i(check->items[1].value, 10, &marker_size) != 0 || marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
 	driver = find_ll_merge_driver(ll_driver_name);
@@ -454,8 +453,7 @@ int ll_merge_marker_size(struct index_state *istate, const char *path)
 		check = attr_check_initl("conflict-marker-size", NULL);
 	git_check_attr(istate, path, check);
 	if (check->items[0].value) {
-		marker_size = atoi(check->items[0].value);
-		if (marker_size <= 0)
+		if (strtol_i(check->items[0].value, 10, &marker_size) != 0 || marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 	}
 	return marker_size;
-- 
gitgitgadget
