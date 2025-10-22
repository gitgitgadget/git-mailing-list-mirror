Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED14C1F2BA4
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136832; cv=none; b=NXRKMT1TnQk7Xt91d96lL+eIZDmyxr6gRe44ytHrO+6gMNTQj2LmE4cMxcT+ShLBFwWljRJFev1HqdE5iUcaXmMkbNEGaf/TB8Ivvwd4zmclE8Sd9ZSFFv4zNGtRXrqNJNO/7sxHhQTv1Q+iJcquiZeK4mzwmeqsV5Vjj2Jt/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136832; c=relaxed/simple;
	bh=+w4fxepe6MhKTHhhQLA0I8BzPW0tsGIz1vJSTw20RA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2aGrjANGZqVADO7owvQa8wbqOTdG/B93Ogzj+GENOT1tAxb9jM9dwfVPVBQ1dIXIOH/XQ5T0x/BCTUT/Q07MPNmaq72lzo5F/22O4QK2b4dKYmhlpN6RZbFRzoGMndYPCVNUjEoYAt70icLCC5LMM70N+5YMVMav6fvvwENTpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/p+khMc; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/p+khMc"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47117f92e32so45781965e9.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761136828; x=1761741628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBP+uxI7bNvwVxR5THCqftPAm746+tgQwOyv4Z+Oqzw=;
        b=h/p+khMcr5OBdRCUoHwjXT41Fm+kUDhue/jJn1ULnhuhlvb45pB8hkm4JmDuWngMI6
         ND04fQllmL7JlQpR2XEA0nm6PnEg8By4VzxEUr340xSIAjblMULr+8wsAp+iwxSjHLKS
         oZxdGiYqKkrgYpANXApj/j16pqp5RNQOZENkA/kW7F3poWCoBSKvKipTT5RPeqako24h
         5ZyZibxRxj1pY6nOp+CdfLgBsemAVdjbegE3p8XusfKDDqaoGtdy0Oj9GCrrlDp55KNJ
         v2eHpoTLG8pHLkchDzBOn9gCwksXDjRIrxAmc8ZFjqEKA5HKZVCAT6QY2M0MBsZXhpig
         xClg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761136828; x=1761741628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBP+uxI7bNvwVxR5THCqftPAm746+tgQwOyv4Z+Oqzw=;
        b=OAHBqd5sCsosHmAGSO4qQUyq/8NWG+xcj6iIHWfmTornleyUc2FFN1dpMPk/Ep4eRI
         AaxHmxPwVAY48A9hzf2pgp6SwQB3a8fh/CyG4OOr+PNIgZGd0O9SFxklpLydlu9B+btp
         4AJBKByyq0+B4wwW6WgmFomFiURn/3huCv7I3/w9LakjMAu+9kjpy3ItHYktb756DqGD
         3KmzVOq3+01PsdOCQ59WQyr03my0SeyoGAFAjRu9eYhyo5n9d2jxJiGdnwZTSoyA5Kqy
         V+5E0kEDPwEAEwovHSW2WjfMu84uSWeP8nKa1nHkUJFb9ZEv5GUBR6rq4uGSBPrYyd3/
         b8FQ==
X-Gm-Message-State: AOJu0Yz4UsYVC5xunop/5uumbwCdPjxvA1NeDwuIp4/xl+LTmkaDtHlq
	G+Js70yZqn0jFuuvOwdn5XQYzYMa8rxowHj5hr/2etW4AsUlCdI9ceZw
X-Gm-Gg: ASbGnctf5wySVMUY0k4BD++iZt1X65hrsQ58Lrqpb0j64Xtj7QnDaa6MLdC80pXvDJm
	JL4T2Phhyq8xcVU+lDkWn2ZvHQCI1NuLM8E9M55ZkYgugodqDg3cDQxKMIbLNPw11eqdLWzJtd+
	WZaoWJ2wmbWACL/CZEkJs/SMkoWlPeFcZPtSZH0odYi1Q1+3cwG51Bi+Y4aKQBRfegyNojycIBk
	4d/w76HSoWYaTy5Lod5thsB+d7dw+8mSPotWOFZksGYV/xjOHBTtnc+4oJiaVH9lGypXMbA9weT
	YRxeTop3YCN+Xc/uDwvKpAqkORX+2oDS7OR3dAsd/FqkA1BvwAHLvBBxnzpwKVFeVQWz5lT5b5Y
	sfLTXTDenb9EJUxaTsfdgBHI8QHzzr4I/vOKgr/Wb7YMsr2R0mtZWl5mjTf3HKnLBEp4JDvrRKs
	xhVh/2lmawKy5mjg==
X-Google-Smtp-Source: AGHT+IHxavHsbvpqa3mwuXJU7nD/B/mfa3Eii5jxaZ17BBNDnjMD4glIiXCBUxtx7kekK3L19kOz6Q==
X-Received: by 2002:a05:600c:3e17:b0:46f:c576:189a with SMTP id 5b1f17b1804b1-4711791c3c3mr162789485e9.29.1761136827775;
        Wed, 22 Oct 2025 05:40:27 -0700 (PDT)
Received: from ubuntu ([105.117.1.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4342373sm48893115e9.12.2025.10.22.05.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 05:40:27 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v5 0/2] do not use misdesigned strbuf_split*()
Date: Wed, 22 Oct 2025 12:40:18 +0000
Message-ID: <cover.1761135129.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
In-Reply-To: <cover.1760997183.git.belkid98@gmail.com>
References: <cover.1760997183.git.belkid98@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch series by Junio Hamano with link below,
https://public-inbox.org/git/20250731225433.4028872-1-gitster@poddbox.com/,
notices that the array of strbufs that calls to strbuf_split*() provides
are merely used to store the strings gotten from the split and no edit are
done on these resulting strings making the strbuf_split*() unideal
for this usecase.

Commit d6fd08bd (sub-process: do not use strbuf_split*(), 2025-07-31) for
example, in the series, observes that the subprocess_read_status() reads
one packet line and tries to find "status=<foo>" by splitting the line
into two strbufs which is an overkill to extract <foo>.

This series continues on this cleanup, by replacing instances of
strbuf_split_max() with strchr() to get the required token around the
delimiter where the token from the split is merely returned as char *
and not strbufs and no edits are done on them.
This makes the code cleaner, faster and more efficient.

Tests have also been performed on the commits on Github CI. The link is shown below

https://github.com/git/git/pull/2080

Changes in v5:
==============
 - Modify commit messages to provide proper context for commit reference
 - Correct reviewer's name and email address
 - correct code logic by assigning `fingerprint_stdout.buf` to `begin` in
   first call to strchr in patch 1
 - Modify logic in call to strchr() when no '\n' is found by passing '\0'
   to get the end of first line.
 - use die() in place of die_errno() in failed calls to strchr(), retaining
   die_errno() before the string is split


Olamide Caleb Bello (2):
  gpg-interface: do not use misdesigned strbuf_split*()
  gpg-interface: do not use misdesigned strbuf_split*()

 gpg-interface.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

Range diff versus v4
====================

1:  2879d9be36 ! 1:  df8fbbd3a5 gpg-interface: do not use misdesigned strbuf_split*()
    @@ Commit message
     
         In get_ssh_finger_print(), the output of the `ssh-keygen` command is
         put into `fingerprint_stdout` strbuf.
    -
    -    The string in fingerprint_stdout is then split into up to 3 strbufs using
    -    strbuf_split_max(), however they are not modified after the split thereby
    -    not making use of the strbuf API as the fingerprint token is merely
    -    returned as a char * and not a strbuf, hence they do not need to be
    +    The string in `fingerprint_stdout` is then split into up to 3 strbufs
    +    using strbuf_split_max(). However they are not modified after the split
    +    thereby not making use of the strbuf API as the fingerprint token is
    +    merely returned as a char * and not a strbuf. Hence they do not need to be
         strbufs.
     
         Simplify the process of retrieving and returning the desired token by
         using strchr() to isolate the token and xmemdupz() to return a copy of the
    -    token.
    -    This removes the roundabout way of splitting the string into strbufs, just
    -    to return the token.
    +    token. This removes the roundabout way of splitting the string into
    +    strbufs just to return the token.
     
         Reported-by: Junio Hamano <gitster@pobox.com>
         Helped-by: Christian Couder <christian.couder@gmail.com>
    -    Helped-by: Junio Hamano <gitster@pobox.com>
    -    Helped-by: Krisoffer Haughsbakk
    +    Helped-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
         Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
     
      ## gpg-interface.c ##
    @@ gpg-interface.c: static char *get_ssh_key_fingerprint(const char *signing_key)
     -	if (!fingerprint[1])
     -		die_errno(_("failed to get the ssh fingerprint for key '%s'"),
     +	begin = fingerprint_stdout.buf;
    -+	delim = strchr(fingerprint_stdout.buf, ' ');
    ++	delim = strchr(begin, ' ');
     +	if (!delim)
    -+		die_errno(_("failed to get the ssh fingerprint for key %s"),
    ++		die(_("failed to get the ssh fingerprint for key %s"),
      			  signing_key);
     -
     -	fingerprint_ret = strbuf_detach(fingerprint[1], NULL);
    @@ gpg-interface.c: static char *get_ssh_key_fingerprint(const char *signing_key)
     +	begin = delim + 1;
     +	delim = strchr(begin, ' ');
     +	if (!delim)
    -+	    die_errno(_("failed to get the ssh fingerprint for key %s"),
    ++	    die(_("failed to get the ssh fingerprint for key %s"),
     +			  signing_key);
     +	fingerprint_ret = xmemdupz(begin, delim - begin);
      	strbuf_release(&fingerprint_stdout);
2:  a830de15ec ! 2:  5df667227b gpg-interface: do not use misdesigned strbuf_split*() [Part 2]
    @@ Metadata
     Author: Olamide Caleb Bello <belkid98@gmail.com>
     
      ## Commit message ##
    -    gpg-interface: do not use misdesigned strbuf_split*() [Part 2]
    +    gpg-interface: do not use misdesigned strbuf_split*()
     
         In get_default_ssh_signing_key(), the default ssh signing key is
         retrieved in `key_stdout` buf, which is then split using
    @@ Commit message
     
         Reported-by: Junio Hamano <gitster@pobox.com>
         Helped-by: Christian Couder <christian.couder@gmail.com>
    -    Helped-by: Junio Hamano <gitster@pobox.com>
    -    Helped-by: Krisoffer Haughsbakk
    +    Helped-by: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
         Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
     
      ## gpg-interface.c ##
    @@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
      	int n;
      	char *default_key = NULL;
      	const char *literal_key = NULL;
    -+	char *begin, *new_line, *first_line;
    ++	char *begin, *new_line, *first_line, *end;
      
      	if (!ssh_default_key_command)
      		die(_("either user.signingkey or gpg.ssh.defaultKeyCommand needs to be configured"));
    @@ gpg-interface.c: static char *get_default_ssh_signing_key(void)
     -		if (keys[0] && is_literal_ssh_key(keys[0]->buf, &literal_key)) {
     +		begin = key_stdout.buf;
     +		new_line = strchr(begin, '\n');
    -+		first_line = xmemdupz(begin, new_line - begin);
    ++		end = new_line ? new_line : strchr(begin, '\0');
    ++		first_line = xmemdupz(begin, end - begin);
     +		if (is_literal_ssh_key(first_line, &literal_key)) {
      			/*
      			 * We only use `is_literal_ssh_key` here to check validity

-- 
2.51.0.463.g79cf913ea9

