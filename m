Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752DB3AA1A7
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786521805; cv=none; b=lYsqt4Gid/pHzpFFGFlSAdO0Fr2i7wQMfMpqaErpTThmv0sNWxek+PMZzQ7JrCk77FthtFfPZw+F1ubSfUwL6AsCepeoMzpXF6H7Nujfe+22J0Wn8vf7Q9/JZie5XZpsNhkZnLB7O9u300/89lHLwTubKQ8QCV1nqqa5XQ8z3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786521805; c=relaxed/simple;
	bh=SAn1dJUyAGJS4tW7CM9h9KMNHeFK8t5/eKrClyrz66U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=nLSuo/yr8zi20kvK4s5CE4XDtM81glaAOyQ9o8Gu9Lkj6/u+Y9PzwXIFTD++2ZjfoPo0EdDjPS6UG5+UYETGsBT0KlNjJJVSb9QZjT9jn9ixlhfoqO5zIFjaFkGnZmQPjaLOvPOezWFSQdocsupFg/qG7DapAogcan+XGr7qxng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=De5zqTGc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De5zqTGc"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d004f135b1so11070515ad.3
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786521804; x=1787126604; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kRkl335VEQUTzoFjOArGlywDUJ8MzxXDgd44PuMnzbw=;
        b=De5zqTGcIti+MwzPWY+L/Q8Pas/kuJmztFSa1VbNEIZ13E+WeHK+Iz1fu1R4NUdPNx
         kCrct987m5EZU8M+9tnMgX4Z7G8nZ4WRzpEhqdMhYpTwqOvHptqrTW6KQa7YJrKkxFm/
         e+RZ+0+eJCxrui5mgfI3r4ZalldEeBl7sskQl4Vb0Qj+0B1BwuZDBfGgP3DhrJBjY+7v
         umSeHe7H3Bx1Vvu8YRE2euEgWA8tBILZdzSn/jhBtJJcSS0E1MBL5fTu2EdInZgFbrMj
         12zd4UPW4HZL2qIsJVbrE8/ItBbR6f/Aote3CZvXHZlkd2NjGnRobzoHdgfl7ISkzx0s
         jO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786521804; x=1787126604;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRkl335VEQUTzoFjOArGlywDUJ8MzxXDgd44PuMnzbw=;
        b=d4IqRo46oEuMeZ8eydZqNV2VSszuXOPGAa4Fq/nllR4Zp8zkTwOIdkItjBsGkMqbmR
         8DEQsXu4w1Fp4eyeNxjX+MEeun+5tiBFE3EQVt2oxMYUd5FdYJZRRjJWDH7Ow+aKlVae
         autfxdFUCmYtyrGCCMRcLL20qMDSWH7qn0ZU1zqKJZoCasu7bQFOMwjvYdwoixc6SWsL
         tXvcHLxpkuDwN1K7hJctzoc+OAEvqEzVDUGcIYae3boXOcnWTVqpHsdxz0zuxFWa/beX
         ayu/LWTu3TOL7+sIaQNnuSUtfYkIReCNZQnbivF1RmousZNTSOOdZPZcr3fibONL4VPd
         M9hQ==
X-Gm-Message-State: AOJu0YxzIYe+x+XfM7qtfrUZDHONK9i7cNaO1lA1tivykcfPAjNaUsX3
	njU2J9laxHOz1/MsCHop+6BrI0nimrZdQodVyF7kntM6eXxJeO5zuxIpO+CyPtvf
X-Gm-Gg: AR+sD10pQkzp/3ZaqvOJOGV9fezsqeqddF6EZQbUXKZS7uANl86I73rjEsSRlJ5SEzI
	2N0ETky4nEkVchxCxfP6UA6bOiM2FNuDDLjCQUWX+7SZfyoMQwEUygQzvnGVBL28lCBtMijLfPe
	6lVwZWMq4x59XA7dFvy1kJNjIrCOlJWGm8h9BtBYD2fUyCPegH/F+F1wX8bE826qhLG1plMsQGi
	qbIkXMY++AXvDpN2F4Vlgcx4Uhk2OPtXVBxc9qkc8umUuypM8VgnI0xKqX7XSha9sX4cWvmq7LA
	8deXMMTbcv2Yq6MsKsciydkOgcQe968L0go11MbDoEOezObXQES77KbsnC2uTPxxIvuc47tP4hg
	Sxpildhj+RIHQiue57Y+unYwLYMLALcrEI+0QMH9Yj3cbQGN09G7yY4nczISIP+u74Wj+jKwZ3R
	C//kDbkBuCsgivU+eMbcGvIQgjEGX/k7m73slDFVTg17fD6EiaF6LIKN3kCuKczg==
X-Received: by 2002:a17:903:320a:b0:2c9:fb11:1bf4 with SMTP id d9443c01a7336-2d3452da551mr38245555ad.7.1786521803570;
        Wed, 12 Aug 2026 01:03:23 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d350fb09e2sm2954435ad.5.2026.08.12.01.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 01:03:22 -0700 (PDT)
Message-Id: <pull.2179.v3.git.1786521801.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 12 Aug 2026 08:03:08 +0000
Subject: [PATCH v3 00/12] coverity: fix unchecked returns
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
    Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

This is the next batch of fixes in response to issues reported by Coverity.

Changes since v2:

 * Added a new commit to handle block-writer initialization errors (instead
   of ignoring them).
 * The bw->zstream attribute is now also deinitialized in the error case, as
   suggested by Junio.
 * The commit message of "reftable/block: check deflateInit() return value"
   was rephrased to stop suggesting that silent corruption by zlib would be
   possible before that patch: This turned out to be provably incorrect.
 * When aborting the bisect because dup2() failed, a left-over saved_stdout
   is now also cleaned up.

Changes since v1:

 * The last-modified patch is now more careful to clean up a commit slab
   when parsing the commit failed.
 * When the "good" bisect term was read successfully, but not the "bad" one,
   the "good" one is now cleaned up.
 * Instead of detecting failed get_terms() calls indirectly, the return
   value is now checked.
 * Failures when bisect_run() calls dup2() are now handled properly, too.

Johannes Schindelin (12):
  http: die on curl_easy_duphandle failure in get_active_slot
  config: propagate launch_editor() failure in show_editor()
  reftable: handle block-writer initialization errors
  reftable/block: check deflateInit() return value
  reftable tests: check reftable_table_init_ref_iterator() return
  last-modified: handle repo_parse_commit() failures
  compat/pread: check initial lseek for errors
  transport-helper: check dup() return in get_exporter
  transport-helper: warn when export-marks file cannot be finalized
  bisect: check strbuf_getline_lf return when reading terms
  bisect: check get_terms return at all call sites
  bisect: handle dup() failure when redirecting stdout

 bisect.c                        |  6 +++--
 builtin/bisect.c                | 44 ++++++++++++++++++++++++---------
 builtin/config.c                |  5 +++-
 builtin/last-modified.c         |  9 ++++---
 compat/pread.c                  |  2 ++
 http.c                          |  2 ++
 reftable/block.c                |  5 +++-
 reftable/writer.c               |  8 +++++-
 t/unit-tests/u-reftable-table.c |  6 +++--
 transport-helper.c              |  6 ++++-
 10 files changed, 70 insertions(+), 23 deletions(-)


base-commit: 55526a18268bbc1ddaf8a6b7850c33d984eac9e9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2179%2Fdscho%2Fcoverity-fixes-unchecked-returns-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2179/dscho/coverity-fixes-unchecked-returns-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2179

Range-diff vs v2:

  1:  e653255de1 =  1:  e653255de1 http: die on curl_easy_duphandle failure in get_active_slot
  2:  0692704d45 =  2:  0692704d45 config: propagate launch_editor() failure in show_editor()
  -:  ---------- >  3:  c689148aef reftable: handle block-writer initialization errors
  3:  9bf7e737c7 !  4:  66953a65d0 reftable/block: check deflateInit() return value
     @@ Commit message
          z_stream is left in an undefined state.
      
          Subsequent deflate() calls in block_writer_finish() then operate
     -    on this uninitialized stream. Depending on the zlib
     -    implementation, this can produce silently corrupted compressed
     -    data (which would be written to the reftable file and discovered
     -    only when a later reader fails to inflate) or crash outright.
     +    on this uninitialized stream. Current zlib/zlib-ng versions handle
     +    such a stream gracefully, by returning `Z_STREAM_ERROR`, so in
     +    practice it would likely not result in catastrophic error.
      
     -    The function already uses REFTABLE_ZLIB_ERROR for deflate()
     -    failures later in the code path (lines 171, 199), so returning
     -    the same error code for deflateInit() failure is consistent.
     +    The function already uses REFTABLE_ZLIB_ERROR for deflate() failures
     +    later in the code path, so returning the same error code for
     +    deflateInit() failure is consistent.
      
          Pointed out by Coverity.
      
          Assisted-by: Claude Opus 4.6
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## reftable/block.c ##
     @@ reftable/block.c: int block_writer_init(struct block_writer *bw, uint8_t typ, ui
       		if (!bw->zstream)
       			return REFTABLE_OUT_OF_MEMORY_ERROR;
      -		deflateInit(bw->zstream, 9);
     -+		if (deflateInit(bw->zstream, 9) != Z_OK)
     ++		if (deflateInit(bw->zstream, 9) != Z_OK) {
     ++			REFTABLE_FREE_AND_NULL(bw->zstream);
      +			return REFTABLE_ZLIB_ERROR;
     ++		}
       	}
       
       	return 0;
  4:  711671c3ab =  5:  a49af20d30 reftable tests: check reftable_table_init_ref_iterator() return
  5:  72a74c76be =  6:  bf06239732 last-modified: handle repo_parse_commit() failures
  6:  f0b1e13979 =  7:  6e2295b8f0 compat/pread: check initial lseek for errors
  7:  0facb9e8ca =  8:  689bb48fe5 transport-helper: check dup() return in get_exporter
  8:  2b0e4f32fd =  9:  ad6ea19737 transport-helper: warn when export-marks file cannot be finalized
  9:  7f2b963103 = 10:  7db6ac2ab0 bisect: check strbuf_getline_lf return when reading terms
 10:  9a9103096a = 11:  aefdbe2bdf bisect: check get_terms return at all call sites
 11:  829cd82177 ! 12:  258dbb0fbd bisect: handle dup() failure when redirecting stdout
     @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, co
      +		if (saved_stdout < 0 ||
      +		    dup2(temporary_stdout_fd, 1) < 0) {
      +			res = error_errno(_("could not duplicate stdout"));
     ++			if (saved_stdout >= 0)
     ++				close(saved_stdout);
      +			close(temporary_stdout_fd);
      +			break;
      +		}

-- 
gitgitgadget
