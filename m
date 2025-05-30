Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60682BAF9
	for <git@vger.kernel.org>; Fri, 30 May 2025 01:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748569961; cv=none; b=Hte2DElnmzfgMdxYw/SLVJgrV/Zi5kyPXSuQvQjN/pGPmCYYn+BjYvo1OuLGafqzjVLDDVWmtQU+shYgucKRWF7cFxxQqctFc0Qv9CcGCHs2TrErQTFegd0vVACHP5FGjWn6mhexvpAtoz8o6NPa6/HuIxFzNK5rKMKSAxjWoyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748569961; c=relaxed/simple;
	bh=e1MBAgpD28U8s/XBzjZMejFb3JvTzkSnAqOfOnSBm1U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HW2cDt/D3xVfVGg8Bkp613OxQzZEgxDBaZ4cFRf/hBWvJe2Fc0DXJ7rOnQn4W0svDEDn6ccvuQcc68yVlSoQrbJj7I53fdBTH/RnE9EwsFXehhybQkRjHJbGbsZWIVTBanC52fD1Ogvb4v2nMXhs91Wa3eWXwqI6t9taTnfyTxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CB3efDSZ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB3efDSZ"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a36e950e41so986291f8f.0
        for <git@vger.kernel.org>; Thu, 29 May 2025 18:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748569958; x=1749174758; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUfuX7uFbJDNNNcXa0WzEGIK5p2KfH3F+nJWX4eEu7Y=;
        b=CB3efDSZHkaKI66eLiYseqJD+ErNQrB/8UGjXjqTOusZw8e9Tr783by4cD9KP+faYO
         xXU00m1Es1kfH1fWAfefBeOh6MMsHEg9T2EDFtV8dy5NamV3u1/W0oh1o4aAIiv81e30
         fzkcJh24KkzgwRNocLQchH3RPbSWOfUTevoKnoW4jdV8LNnBUaiVyywKHCFGD3Dg083A
         1XMhdDaHouERJ13p3jKugRmA02u89zJ4pQ4ElGNLeeXyr8HOMyeB7/zy9zUcPEarCNJO
         GE2N3u7zqCWIVRgnQ29D0+7S/MMqP9o+3rUGZEFRw2crDu0Lu6SYRJ/CFj8g6+QetsTx
         CbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748569958; x=1749174758;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUfuX7uFbJDNNNcXa0WzEGIK5p2KfH3F+nJWX4eEu7Y=;
        b=pG/qTvTlNit1YwrWt9etwxjBQjtvlzHIeuHre/YrB0+d4VJp9Fk4ON0CARUm8FhpTI
         fCjUKN+uIJTdvv2F0iDG4KJanL8cLwIOC6X/O+tXRlEHFHa6p7b4ak4ZxBjz5hcQAek/
         KffyPg49wRhgjZ93AjSfEEhoga6qh+UAJhINfEnB6MoV5rEse/jCDCp7S0kooWwe0jht
         PBsPe6MDvaGwM33StqIsK0fC41k5J4OeEN3mWRAw3oRM+0dEF4apfVRxYt2vKS59x4xT
         HtLnXtQwd0psv1bB53P+4G8ai2PgYW2PE3gHMUKZrfHT/8Xq7ao/JyNMc+5PhkbuTgBN
         YpEw==
X-Gm-Message-State: AOJu0Yzm6mSxEIy+TeGjeTm1NLvTqdN/gt0JU3Zdam7+fL2Q9/5tCzmC
	XR1AYpReupCa6zqs1ESDsz3Zp5VTFncUzL4T0Rpzan3n2Ra+WtBWmjDzr7v15Q==
X-Gm-Gg: ASbGnculhc/Q20lqBm3guW3gDaB07T4a5RMFIgUwcIZkL2ZzPHe6MHwSr/QHMoCIe9R
	tsoRxUfZcgMUAdwnO231ZQzPYhYmqZZc3BeeHaAy5lnp15TRYIWyoNwKEcHZZ16n9JTUxU37DOi
	Qfa8oyKb0c87NZpEvtdsh5udNx6TMHkjmqnFshrAqgew68C4AtCd/fs97KaapBtoPiJWTqrP9pj
	o2hBzXSx4d1GN+vvsJfigKQdtcGAcU+X821WqkE8TaOFBCwHPSAe4wZcNJo4r5H1fLf+kn2gPfr
	Y03qMmGkxttZOyyH5Gredk1j4ra4d14hfs0O+maDdDN8OgBvxdy4
X-Google-Smtp-Source: AGHT+IGUgwCNLAZz+tul1zvHPITI2EcT3w41+H0q76pHvqMrKIEWddc3Kwu4wiZbe0MS5p6/1MVPUQ==
X-Received: by 2002:a05:6000:2313:b0:3a3:7593:818b with SMTP id ffacd0b85a97d-3a4f7a4d333mr893639f8f.21.1748569957670;
        Thu, 29 May 2025 18:52:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe74165sm3552696f8f.53.2025.05.29.18.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 18:52:37 -0700 (PDT)
Message-Id: <b812f973d18fbef104f2d30f4719fcc58c8578c0.1748569955.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v3.git.git.1748569955.gitgitgadget@gmail.com>
References: <pull.1964.v2.git.git.1748168353204.gitgitgadget@gmail.com>
	<pull.1964.v3.git.git.1748569955.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 30 May 2025 01:52:34 +0000
Subject: [PATCH v3 1/2] sequencer: replace error() with BUG() in
 update_squash_messages()
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

In sequencer.c, caller only pass TODO_SQUASH or TODO_FIXUP to
update_squash_messages(), any other command passed in should be
considered as BUG. Thus I think `return error('unknown command')`
should be replaced as `BUG('unknown command')`.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
 sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1ee0abbd4514..93e1732504c1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2067,6 +2067,9 @@ static int update_squash_messages(struct repository *r,
 	const char *message, *body;
 	const char *encoding = get_commit_output_encoding();
 
+	if (!is_fixup(command))
+		BUG("unknown command: %d", command);
+
 	if (ctx->current_fixup_count > 0) {
 		struct strbuf header = STRBUF_INIT;
 		char *eol;
@@ -2134,8 +2137,7 @@ static int update_squash_messages(struct repository *r,
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body),
 					   comment_line_str);
-	} else
-		return error(_("unknown command: %d"), command);
+	}
 	repo_unuse_commit_buffer(r, commit, message);
 
 	if (!res)
-- 
gitgitgadget

