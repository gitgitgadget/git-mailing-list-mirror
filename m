Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502951;
	b=CjcYOcrByBQ9Yzovcbgcj0GRoBI49+aX0kZQwBoTMJqWPrOiSyCKBJQrgRIKJFkWgQcl
	 h+WkWSusKzJIXDnMMAceUlJn0EHVX2S0aYc7ZPR1racdcve/II5+oYXLjoUKL3TTL3nQz
	 92GyKF3siNVm1QsXSYxiu90UMjJuGTdH/dQvqkgbDrH+xVx0oWg/y3A3VwWmcW7JN5M03
	 73aEvez6Nl87zPqotiBogjfDca41TT1MOfAzNnbrFsoyYU58wbTpomG7l6vQ5e3Gmw6sh
	 n8x1zBUUDjh9M6JusqkF6tmhGK6UKp6oqFewX47gMtm7DO+8JSPUWLR47Jc+hYZVVIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mZ0GtOicRbRUKr5sSRH/XM5f0SvV2ByRoT2VB811qgY=;
	b=rHlrIMS6/TsSwMnVY2YiflxiebnUf8SCRV6cj/Ls53MGOn2jQPdpY49tLHQBdu5ofpg9
	 7SRyaLnlE7uACuN9r/RWxZb1kCzhXd9jCVabfsVXWZ/qekR4YFtNlFtF++2jHovQZVQ49
	 Alor2T6/XYNWhtFT3s0c5lu24Rnk8+Fb5XdV1q0LQKMpbGx8Hzm7P2reeGANGj0HEPv8t
	 S0dLoaagZ/fWRJgt7jALiqe+/P3/CSylR0qGc1TVc89gEkxRieHn7ZOeIBA7yLN3b+ae2
	 NPT7h942oCilMmXqouvRe11zZ7UmQtGrwNDA0TfY8EM7QDC5c2EtmJhMgvWe2FWUQfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lp8uBj1g;
	arc=none smtp.remote-ip=209.85.161.49
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7E4606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA7E4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lp8uBj1g
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-704597ef1d8so965882eaf.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792502950; x=1793107750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mZ0GtOicRbRUKr5sSRH/XM5f0SvV2ByRoT2VB811qgY=;
        b=lp8uBj1g+X1Frm6X0vq63eNCzZn6WOh1ImPN8B7ObVxYsj6UzrO1WLEmBeeRLV2na4
         uyqp2V5mGt++lQc46mGZ42U/4IavIEXp2fwTehJvsS/QJIQ6itxiQMpQ7M27fp1uJilQ
         eh9vwOqKKN6+bRYPtJ6t3gOhKdximwJ0CcPuh3k4b4Nxvl9pCiFnAniQFd0FR5JqNpM8
         N4dIqXmtpF7xc3j1XD5OZoywFri3uTaaiHGxinYf8ulmlKswEPrJiwq+KAkzvgn/vh2P
         OQChEan55dAXIfzxyAnIL5jSsB/5aVZBdU9+cR9G3gw9i4SWnzzZnyIlKzZJ3jybMcWk
         M/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792502950; x=1793107750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mZ0GtOicRbRUKr5sSRH/XM5f0SvV2ByRoT2VB811qgY=;
        b=I511Ij5knr58wJtsrjCc3/JNJIQfdtN7NkWS2MwwxVA8oklHhoDiQSKECJ+LANZBA9
         N0QCsF/V6fn17vE2hHn7iD872cSk1LGhJ6GDPGN3VLRhgow8nwkA2nLIiKDTa2Csy7r0
         stJy7BKhhzABEp6X+412SYoeADW7o8Qp9F/vFCMSJ0H5HHCQLlqT02MjAhY7nMKdxt4P
         VotBTLwP4ylU2q9cKor/y5m2mKTBLQJ99ffi4miIzvWHYUiq/4tTwPLOVbAa08ffeVLt
         4R0FVEj31/Gvqxd0iDDngtV1KwfOVL/Jbay68VxYzMM8XHglI+3qco/AfW/0ElLBLIOU
         ZAfw==
X-Gm-Message-State: AFq9FYL98kdpeWAlxzBq/K0NhhI2f0y4Ji7vmDsrKhu/ZkuDJvzkhZIP
	AHMzpoytUGshnSKVM9zoYG7I5TXZUkQ2quaeWPnFRrTbZ4+VhozVRzc/t1AS+w==
X-Gm-Gg: AYBFou2cXXjWnFGgSfbJuJpNA53x+V2xm9fNMF7HsxAupFoZL1JTSlCb87U2AFVrGvb
	PzBdcLn+E+kjZanM0R9YCUZCYLczd45XK/cjQNf46t0muCrpIicm1Ei6qS0qfTPWncHJ11pvE9l
	BI/ZRqcQOH+HgBXGvDo8gsMNJwMUCC532JSsHnEIRn8/x9J0smviJF1GeiwoAEa/j/+FAYiwCJ+
	LkVguQigny/8fjVnqUymENqhr6ToH6R61aDp3M6QiRuZoT921V0GNxZxu9jYQ/Bgq8lqjW3nmLA
	ZSjUM11ts8ipdZbMOJKl5PcvhCd82/2KHwDe/yzJ4cvTYkCzYYjAu3PsGDSun0CJ51O3Yt6dlRa
	kygvz4LN0JYhLaL+tJioG+2qGaRGlwLpJ/di+vvyYFL2F9wIL03Xms9Y4sn2p9CPQxMcr8shqnz
	TddiU7eTVk5OBpgaHz25qZ0GB3KgC9PZeyePuNNrz3PfqK4speQMgptbTxHSOE2SBoIUlkzh4+b
	J/Xt7+Xsg7Iv/4PDo+2Jm0EN0CSwBYbg5CGpw==
X-Received: by 2002:a05:6820:3502:10b0:6f8:22d8:6543 with SMTP id 006d021491bc7-70356898723mr4991359eaf.50.1792502949652;
        Tue, 20 Oct 2026 06:29:09 -0700 (PDT)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7018f2e0d89sm9973129eaf.6.2026.10.20.06.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:29:09 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/4] pack-write: make index-pack output comment hash agnostic
Date: Tue, 20 Oct 2026 08:28:57 -0500
Message-ID: <20261020132900.1208343-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
In-Reply-To: <20261020132900.1208343-1-jltobler@gmail.com>
References: <20261016213716.593278-1-jltobler@gmail.com>
 <20261020132900.1208343-1-jltobler@gmail.com>
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

The code comment in `index_pack_lockfile()` explains the expected format
of output from git-index-pack(1). As written it explicitly mentions
SHA1, but both the git-index-pack(1) output and the parsing are not
specific to SHA1 and also support SHA256.

Update the comment explanation to be hash agnostic accordingly.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 pack-write.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/pack-write.c b/pack-write.c
index 85674e4b72..b1311c9923 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -476,11 +476,15 @@ char *index_pack_lockfile(struct odb_source *source, int ip_out,
 	const int len = source->odb->repo->hash_algo->hexsz + 6;
 
 	/*
-	 * The first thing we expect from index-pack's output
-	 * is "pack\t%40s\n" or "keep\t%40s\n" (46 bytes) where
-	 * %40s is the newly created pack SHA1 name.  In the "keep"
-	 * case, we need it to remove the corresponding .keep file
-	 * later on.  If we don't get that then tough luck with it.
+	 * The first thing we expect from index-pack's output is
+	 * "pack\t<name>\n" or "keep\t<name>\n", where <name> is the hexadecimal
+	 * name of the packfile it has just written. The line is therefore five
+	 * bytes of prefix, `hexsz` bytes of name, and a trailing newline. A
+	 * "keep" prefix tells us that index-pack has also created the
+	 * corresponding ".keep" file.
+	 *
+	 * In the "keep" case, we need it to remove the corresponding ".keep"
+	 * file later on. If we don't get that then tough luck with it.
 	 */
 	if (read_in_full(ip_out, packname, len) == len && packname[len-1] == '\n') {
 		const char *name;
-- 
2.56.0.173.gf57c9a7388

