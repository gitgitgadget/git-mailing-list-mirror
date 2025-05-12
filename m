Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0C32905
	for <git@vger.kernel.org>; Mon, 12 May 2025 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054150; cv=none; b=qswO3v1Cm+4e85nCgYLBPBnbNViUfCHZ+YXZb7EX3ihSyAQzR9qKIkQEjjwXRl7y2umK8kV+TPyNrCKd7k8kNHM/ucoziRYNfDrEG40BO5eMZ3f9TmGqtZzfS1QZOhxRZpEUoHJmVBClV3gcvUcxsqWodqjYsUoz8lPlwCwRq3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054150; c=relaxed/simple;
	bh=sYa7+lo2Lvp2oNBT1Dja7XHW9vlFcSPWAfIIUvO8qF8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=kP4qrHkPxUJ6EbQDyWwLKA5SRqLEzHmv+s1RDLjEAHwfXfI7oYRALYGSSLIrWbzdffO5Y/wGGSbiBu7sSS5cbnqBpkn6ssCN3XSV79W3sFsKDAbHzZLiDGQxPTluef/Y8h0ClgYLB1xA02nZsBZBk/mTYj9u97QXfQA+SUy//Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBp8zYGb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBp8zYGb"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so32528755e9.2
        for <git@vger.kernel.org>; Mon, 12 May 2025 05:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747054147; x=1747658947; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddrFfdBWw2FNpbTYcWtgw8aOQbGmRqj2M/TMc0c9d94=;
        b=iBp8zYGbgADz/t+qQ2A55/lSvluTofrQwSMkFeUg3KOYPWS2M2ZgHJa/v3INqm1mNl
         gzBx4XBVgBXOS8fJOsjWPjjcYOWR21JUJoOfzmQNr2ObX2qLHLVNo8DMy+rXi6DjBL01
         jTGAti6LvKEoQKsAxL7eUn8BgJbBFoiBAlwXRzXn3T2YjFOeoPU5ZHZAhybbggoLkUAC
         5GRrgY/r2WgdPNr4AfjdS8L47qlrZEOGr7WA5ICqt8YBxgZCm9AqbhV33SokPVv2+jiI
         TwY3jvCqUMoZKqrGDQPoAABMbg95cDVwtfYTP07ynO+0gT6qw+VC5vRVJQHXZsXgMhNe
         THFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747054147; x=1747658947;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddrFfdBWw2FNpbTYcWtgw8aOQbGmRqj2M/TMc0c9d94=;
        b=oRefWBrV+9mWKXllDfg4l3Wvl7FZ4DzDk+fx8EmC4NxpaUzsGrzerJAL9Qy+ZPEJah
         zGQIw1oM6KvsLGEWXPlnLjRVEjQ9rle1B6bT9O7419j/bOx36oBm+O676Ukm7VhxWRcx
         SGRE9uwyqmatuKWx15enrj6C+Y/Jmeqbbg/28flYrMyt5cesiPibw4KExO+HvKrCL5BO
         yEqOf0XOvdcC9k25rfkXcMcmTW2NJyovAAecapQz3Doy8Urb4bqb6DPJUsFBfEggB8YY
         /yPZoUSr3hBdqVyLmNk+GBaX3PZoVQh2eqbNzmW92I3Fdn/J2MRdMEErXkX8DONQVy2u
         6aYg==
X-Gm-Message-State: AOJu0Yx+dgvzeJHn4yARJyrYU3eIhP+kmDUY4NIgSh4RPZuosBqUHiQD
	1buYOwRN3ET1YekTSy3mPM5kzHBb+5bxTiKSCZlG11HhozE+DHbQceYtog==
X-Gm-Gg: ASbGnctyZEIkL+iIxiux2NUnfjdTOCe5etDcZHZY2w0K3bcUIz1TNSk8J4oXtvtpmvm
	fbCLPWPHNLCQVZxfLE08qLxuxDNjp+780sgvxnAqbYA8aaVQh2/S8szEP1oznNW9jQA+c9BX8G6
	S7bTCGNS34hUX/BUBF/udT2qBoOHO9iYa0PunYsletx3bJZKJG4wLejCi4uzpFCRspeUi/qQlxi
	E1gfAgVZET/mmGvgfQ5NDnkZMUFUUvZ2rygvwQhTqeewlMWo/LGaU8S5WXMO9EM1FIjSmn000Sh
	e6l2J/iFk9s4LKEnV4k11bJK5Mn4keZ+/4gZFuCexK6RAzI7/rVo
X-Google-Smtp-Source: AGHT+IFXMoWHpSJjug/JJeISnADr4Ny9VjAIbSGRn9UxtUxxPgkptSUA01TZ3SME8rFG0nZshhtDqA==
X-Received: by 2002:a05:600c:510f:b0:442:e9ec:4654 with SMTP id 5b1f17b1804b1-442e9ec46a2mr6977065e9.8.1747054146530;
        Mon, 12 May 2025 05:49:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d68585d1sm125685025e9.31.2025.05.12.05.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 05:49:06 -0700 (PDT)
Message-Id: <pull.1958.v3.git.git.1747054145.gitgitgadget@gmail.com>
In-Reply-To: <pull.1958.v2.git.git.1746980165245.gitgitgadget@gmail.com>
References: <pull.1958.v2.git.git.1746980165245.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 May 2025 12:49:02 +0000
Subject: [PATCH v3 0/2] reftable/writer: fix memory leak when write fails
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
    Lidong Yan <502024330056@smail.nju.edu.cn>

Lidong Yan (2):
  reftable/writer: fix memory leak when `padded_write()` fails
  reftable/writer: fix memory leak when `writer_index_hash()` fails

 reftable/writer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1958%2Fbrandb97%2Ffix-reftable-padded-write-leak-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1958/brandb97/fix-reftable-padded-write-leak-v3
Pull-Request: https://github.com/git/git/pull/1958

Range-diff vs v2:

 1:  9329ae2d478 ! 1:  13ebdd672ff reftable/writer: fix memory leak if write fails
     @@ Metadata
      Author: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## Commit message ##
     -    reftable/writer: fix memory leak if write fails
     +    reftable/writer: fix memory leak when `padded_write()` fails
      
          In reftable/writer.c:padded_write(), if w->writer failed, zeroed
          allocated in `reftable_calloc` will leak. w->writer could be
     @@ Commit message
          some write error. Simply add reftable_free(zeroed) will solve this
          problem.
      
     -    In reftable/writer.c:writer_index_hash(), if `reftable_buf_add` failed,
     -    key allocated by `reftable_malloc` will not be insert into `obj_index_tree`
     -    thus leaks. Simple add reftable_free(key) will solve this problem.
     -
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      
       ## reftable/writer.c ##
     @@ reftable/writer.c: static int padded_write(struct reftable_writer *w, uint8_t *d
       
       		w->pending_padding = 0;
       		reftable_free(zeroed);
     -@@ reftable/writer.c: static int writer_index_hash(struct reftable_writer *w, struct reftable_buf *has
     - 
     - 		reftable_buf_reset(&key->hash);
     - 		err = reftable_buf_add(&key->hash, hash->buf, hash->len);
     --		if (err < 0)
     -+		if (err < 0) {
     -+			reftable_free(key);
     - 			return err;
     -+		}
     - 		tree_insert(&w->obj_index_tree, key,
     - 			    &obj_index_tree_node_compare);
     - 	} else {
 -:  ----------- > 2:  64f778ce2ba reftable/writer: fix memory leak when `writer_index_hash()` fails

-- 
gitgitgadget
