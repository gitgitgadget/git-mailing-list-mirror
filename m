Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A731125BB
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 03:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658319; cv=none; b=RSO4w84ellHVzjSFEvPIt/SeBF6yL28rAl7tHUcWsMVuWRpcpVZHpo4g/J/AhIuMDUIYt7RrAJocgfGaa57jqHQd2T07XQSc8YdKaR7ku4rpKu38PIPkIUHX/PqWHSwvkFYDLevwomkn9HRb4hRA49IytTDfipabzGOGHF/ZlRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658319; c=relaxed/simple;
	bh=wenlDgWd6xp5kLI74cnxWSVlMSL4epGy890Z23C+Vfw=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZKGJpZlHvjsc3y2xwkA417+Uva04mlAzJYE1CaxMOVAijFtdP4RUde9muuJpXDAcM6WCq+UDu7L92VIGoW35E95cQUeFR8tTpSTMzBthUatmGy6p5cC3GGM1yTULTltVrUk6TPr76Z6SsGCbGUaP0F8AfF2qcTeW+6WllyYXh8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2FtFMzA; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2FtFMzA"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d0a4e1789cso5499581fa.3
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 19:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708658314; x=1709263114; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4vxl+e4kjsc1pnVlVusgP+oJtIwbeNpM+m4Xm3V/q4=;
        b=Y2FtFMzAGT+gv7yP3/kWhznA9uC9Z/p9FRKyG/7G6X1uq7L6JoQ7wSYvMJv5zdIBYx
         HnfsaHbcGNxdzZfpfd/daxFAb1TWcCsU5rIlMMK/EABp6dImF2nFeXHr+2qfc8Xi09VJ
         fJnpDRr5m7Ew28VJ0xo4WBFUNmAhUIbbo54QQrSzsoOHIFSKtUIZBKft8cdQvuy82QQf
         Y92FklfnQ7Twcuyk0neOilBBSDHP4quVNd22OaQpuVpwanClrpgWFnHblyKuL1t3UTHP
         Wv48ZbAkTed97MKTlN4JCbehOjuvP4o1EQQJGmyxBvUm0xCnknZFJdpvQmOnok9iwp2E
         wHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658314; x=1709263114;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4vxl+e4kjsc1pnVlVusgP+oJtIwbeNpM+m4Xm3V/q4=;
        b=Il/uDcMHIdOikrQDHs4hW8tXVM6pBpqbNvlQ6YqExJYcdPegO7cc7qCApx1fQo6RQ+
         Tdax2ClEy7iD5a0TO4HLP2iq3yDw+5hX6QvareUiyOND47CR4BcoJLGFB7wASdJect5U
         frxaB8vo6X1Qqkk6CeW3vRkxLwqdPogjhv+M97E0de8V/VvHvPXaGW0RiIKR0V8mGFtF
         PJ43cjFrSvbKKBq2gfx9L5+lbzkuh2AiLj8Ek0z+iX0g1nZzMXCUaOEEdumivKFUK3v/
         qGAlbmpDTT7oIpwhS/iX8/5hBmji2W63iw3VrDW3Oo5b3wXpwvMmjWomaj5rhaJKMXDl
         rULQ==
X-Gm-Message-State: AOJu0Yz6uQd8U8rEGKH3PMx5JY226g1a7bgekxhBVaKhxZW7k0blw+3r
	mHNtrYjg1x6BZ15Vd+GE3NRi+ZoPEsv62Fh8bIsJIlcqwwHCx00wfmHXTGnx
X-Google-Smtp-Source: AGHT+IF4tmrYQnPmS0OTre6Cs7KFIO3M6p4nYz5tLQ1YnZBGkLgqnTz2tgBheDNIDVpgZ8IxbRl5Qg==
X-Received: by 2002:a05:651c:1547:b0:2d2:2c31:3370 with SMTP id y7-20020a05651c154700b002d22c313370mr588980ljp.1.1708658313861;
        Thu, 22 Feb 2024 19:18:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2-20020a05600c20c200b004126a6ee498sm580657wmm.12.2024.02.22.19.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 19:18:33 -0800 (PST)
Message-ID: <f77d68c78ada02bfb4b96759f6ad82ebff00b35b.1708658300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
From: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 03:18:16 +0000
Subject: [PATCH v2 12/16] fsmonitor: return invalided cache-entry count on
 non-directory event
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Jeff Hostetler <git@jeffhostetler.com>,
    Jeff Hostetler <jeffhostetler@github.com>,
    Jeff Hostetler <jeffhostetler@github.com>

From: Jeff Hostetler <jeffhostetler@github.com>

Teah the refresh callback helper function for unqualified FSEvents
(pathnames without a trailing slash) to return the number of
cache-entries that were invalided in response to the event.

This will be used in a later commit to help determine if the observed
pathname was (possibly) case-incorrect when (on a case-insensitive
file system).

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 fsmonitor.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index a51c17cda70..c16ed5d8758 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -196,8 +196,10 @@ static size_t handle_path_with_trailing_slash(
  * do not know it is case-correct or -incorrect.
  *
  * Assume it is case-correct and try an exact match.
+ *
+ * Return the number of cache-entries that we invalidated.
  */
-static void handle_path_without_trailing_slash(
+static size_t handle_path_without_trailing_slash(
 	struct index_state *istate, const char *name, int pos)
 {
 	/*
@@ -218,7 +220,9 @@ static void handle_path_without_trailing_slash(
 		 * at that directory. (That is, assume no D/F conflicts.)
 		 */
 		istate->cache[pos]->ce_flags &= ~CE_FSMONITOR_VALID;
+		return 1;
 	} else {
+		size_t nr_in_cone;
 		struct strbuf work_path = STRBUF_INIT;
 
 		/*
@@ -232,8 +236,10 @@ static void handle_path_without_trailing_slash(
 		strbuf_add(&work_path, name, strlen(name));
 		strbuf_addch(&work_path, '/');
 		pos = index_name_pos(istate, work_path.buf, work_path.len);
-		handle_path_with_trailing_slash(istate, work_path.buf, pos);
+		nr_in_cone = handle_path_with_trailing_slash(
+			istate, work_path.buf, pos);
 		strbuf_release(&work_path);
+		return nr_in_cone;
 	}
 }
 
-- 
gitgitgadget

