Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B394AEEA
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743081; cv=none; b=FMo6/ZPsz+wF3z2qfgibOz8k+L6xEpsdc/N8wlnxVMBaneeusqRxjJVXW1LSexv/zjWrfTlMiEOxov53zFKq2YVYc3LZwios+yAHAbNpRlPT8Yno5aAFWg/KHqr5xAhc878yzIWyiQn4JFx6hishmONijqh5x7WdvQfjBeEDOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743081; c=relaxed/simple;
	bh=EWML87h6ljJXrIlxO9LFVvpFdZbaI1U/3r8cSLaNKus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxJwSWNKsNKumyKsNY0qsitOFJO5FmG8ktY7zvxpBy5U1I2yKVAhoXc2sE+2mVQlftoCvlpmMOt9l1A7NtnQ0GwgGyiQj2LH69Ngvw++bcdfv3yvP1hKXPE8ydx+vR23qijIxJZeMIxyDmDYpMaUKndip9EfJ398/VDOT4WAsfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=cOgI56Do; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="cOgI56Do"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e116a5c3922so1164363276.1
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 10:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723743079; x=1724347879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJ8Z7O/zPtyXpw4716G96D3gWfWki+pC0qTXiuxwIIY=;
        b=cOgI56DoZdktdZ+9BcEIeXqvn45F1kjEpa7rzsOa0cTYyjOGUrKlxGM93SFY7R2ey4
         qxlfasQtYRCow0xb9jSUhxxMUPRN6LNO30wc4/14RzathvJHACYB0VpHq7zSJWCeeMG7
         2GWuJ+s/6SbBXrKKFVJYBag0+Nys29A/gkaQpW1lcpfTp8TkVwEvuOG/jUHQ098bRouV
         1BSGgElhL+VnFLlLWxZWrOnash0MgKSHlmi14kmR4fcoYmk1SP74z/o19YKPRnALCxX5
         CWJw/4NA9SthdtWlItRSbi9CK/GUWOoyECPZc9jhb9xIo7SIwiHaucnqBkA8TfPXkjh4
         mEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743079; x=1724347879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJ8Z7O/zPtyXpw4716G96D3gWfWki+pC0qTXiuxwIIY=;
        b=JDz2iBWZr4IqaxCZ3nrJ/3ZmtmNPyM5WG46kqxGb6oHZre/2eKTX2qZ6oOmy0v3mTi
         pAAGlQog00Mco5odKPWy5uSQi1xTeszvsW4kltNHq/+nrYbaiPz7i5f24qZstWX66Vv/
         NY+Rxwgqa3sCF9gOG3ut5TKiKBPqk05LLZjJyNB0Z7PBHcdRF9ohiEfhOGx/PN2lvboD
         VjPzud5CPxLQ0DfFBCwEfluDT+jTAbtBuSpH0DFF2r2UJ77DTEuSqvHSRdL03KommgjN
         M2HDuHc/w7JFV2s0o83CeM3Yw5ZonxY9fkl/c5t8YZXn/d01Br5dQkfG6aYjMJyWK2yF
         A/aA==
X-Gm-Message-State: AOJu0Yw7OIInTMojNccHHdrrxKicx5oYT17QFQom1qqTyD9/6vHyXIGC
	cuX1AyfaCAAbywlRVZzeSrU7QKT2oAbmHei1UW7qROdMeeAuoFS5NdcV7j4Z830evXEdDSMDbjP
	3
X-Google-Smtp-Source: AGHT+IGw8Uv3nwE9UYP8JZAIKPpnQ7R3vjZRv7n/StrO+cj09eX6yvvg04YE8BjrlJzaB4U1mAlmeA==
X-Received: by 2002:a05:690c:48c4:b0:6b1:9815:b51f with SMTP id 00721157ae682-6b1b9594722mr4466347b3.24.1723743079112;
        Thu, 15 Aug 2024 10:31:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af99410fc4sm3238537b3.13.2024.08.15.10.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 10:31:18 -0700 (PDT)
Date: Thu, 15 Aug 2024 13:31:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/8] pseudo-merge.c: do not generate empty pseudo-merge
 commits
Message-ID: <c7e0ee0712034f654f018361f52c09b1043a8441.1723743050.git.me@ttaylorr.com>
References: <cover.1723743050.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723743050.git.me@ttaylorr.com>

The previous commit demonstrated it is possible to generate empty
pseudo-merge commits, which is not useful as such pseudo-merges carry no
information.

Ensure that we only generate non-empty groups by not pushing a new
commit onto the bitmap_writer when that commit has no parents.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pseudo-merge.c                  | 11 +++++++----
 t/t5333-pseudo-merge-bitmaps.sh |  2 +-
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/pseudo-merge.c b/pseudo-merge.c
index f0fde13c47..6422be979c 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -357,8 +357,10 @@ static void select_pseudo_merges_1(struct bitmap_writer *writer,
 			p = commit_list_append(c, p);
 		} while (j % group->stable_size);
 
-		bitmap_writer_push_commit(writer, merge, 1);
-		writer->pseudo_merges_nr++;
+		if (merge->parents) {
+			bitmap_writer_push_commit(writer, merge, 1);
+			writer->pseudo_merges_nr++;
+		}
 	}
 
 	/* make up to group->max_merges pseudo merges for unstable commits */
@@ -398,8 +400,9 @@ static void select_pseudo_merges_1(struct bitmap_writer *writer,
 			p = commit_list_append(c, p);
 		}
 
-		bitmap_writer_push_commit(writer, merge, 1);
-		writer->pseudo_merges_nr++;
+		if (merge->parents) {
+			bitmap_writer_push_commit(writer, merge, 1);
+			writer->pseudo_merges_nr++; }
 		if (end >= matches->unstable_nr)
 			break;
 	}
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 0288691340..aa1a7d26f1 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -390,7 +390,7 @@ test_expect_success 'pseudo-merge reuse' '
 	)
 '
 
-test_expect_failure 'empty pseudo-merge group' '
+test_expect_success 'empty pseudo-merge group' '
 	git init pseudo-merge-empty-group &&
 	(
 		cd pseudo-merge-empty-group &&
-- 
2.46.0.54.gc9a64b1d2a

