Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521300;
	b=5gDMAvq0SITtkmMKA+IxIrXyyDAE03oPAh8T3FAtjZ/LzNWvuBGy3+uxBdZreX+g7eth
	 l/U+I/Zv9vwEtwpfAmW2wg8G1A5T8WJPvKY9o5BlzT0ebsUSKA8OchjP4MTRgIxRUI6bN
	 i0+ghynQxCJqESNel37w6xipNVMPH0+kIBmvWDKHE8U0Jjm3K/PNDzPGm23SYkE2bfG2G
	 mLU+tfUsQimWnmyo6fbVj1MOMhMqAttRaJM1Zw8ri1l3HkUFUCoyHoN31ZOwLLznEW7yW
	 G1Iy8Y4F7iOoBwgLCGel/xBVoPH7pAxGuHP5nGzVWP3moowAP9fMSqShT+MwtESYFlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=MyQC+H+vA82ndXqdaEiYGHjhep2Ezq3UNSewBr3mbD8=;
	b=QtuiMTkyVfbW/+PJTh2bQF9Ae3CJLzGBfxcAgGXM/FgR8IQAGKg0fmCR+MOFx/+kodhm
	 K5dYNogo7HTjV82I5h1T0L/lRgPT90KXYbWof7OeW0+A7fjPjqoUcgo+Z/8byTJt5A6XV
	 mZs/TfsIUzaWAgc3AEHOt6RxfmZ9Qsg+BeXYn7makccd1XmY+KGJfo0l6Iz8fhFuKXkD8
	 4/eH2195IKFp4kFgEy/476mfeRPbEJPiNwvg2pnj70HwXZsqdutHhgHjB3XbXJRc9IcNY
	 C7APDqulDcnTYSWxYTkdHWCoh/z+ljShCpYLuQBojKTFCgPAWqMUsCrO9ILy3yvdM/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CcGJBwVX;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07161606A324
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 08:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07161606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CcGJBwVX
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5364c951da4so20771541cf.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 01:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793521299; x=1794126099; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MyQC+H+vA82ndXqdaEiYGHjhep2Ezq3UNSewBr3mbD8=;
        b=CcGJBwVXiEIO/pAJXBWupPpXCwNlG1ijJFR12GNvpxN/0qtSrv7/56R30Tnge6bCRI
         K+zbrd3oSm+GCvzeIEOrxloY9v7U2cyx7pkppwuJ5dgwOCQfX4fGxN3fS5sarpWZQEpl
         21QcZHsKrWXIEUme31VEUEUVw436aLkRT4/s99TWoQmL1zYoZuWEvXdIsYo9G4zhuEz7
         d3WHBGpowMth2Yb1lAqYQk1XjwOiCOV/djV3kRO9t5ycIzR6y/SljqRUH7CCfPsZDAAN
         338/HKy7NZE6rUIWJa8h7sRLpD3a/mC9IUU050lTqeGnWiiAoSBfQVE51DpvU0VAAKvh
         ysSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793521299; x=1794126099;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MyQC+H+vA82ndXqdaEiYGHjhep2Ezq3UNSewBr3mbD8=;
        b=MMAM4NZCV0ClAMN5LGvey2pwfNtLu7DKUQxq2lwNDt7+EE2P1C/aGdF9ICfZ0mMvmf
         /qOsUNePZ19UC1YIP2nW8XQ9njDhXyuSbwgOlKGxoxG0pgzIEKbfAZcXog+AXPddRfqW
         h785ZemDZjIsP/d9VZCrJkF4ZZNYWSQ/Dk/Ze1hqH2e//5eAYYGuIqZcYNYRw0fQH8KS
         4em3zBvDNYM3lzBSYlES4P881yBW06b8BnFe2PbUAeHhlXle3h4G8o2nOr7Mnoy4dNfK
         /BGFLcuUdeTrMAwOS6o0UJXWeKWfZOWqBPIPV2Afhb9quysKXEmJkkg/Qa7Xz0JCnJqZ
         jlJQ==
X-Gm-Message-State: AFq9FYJbKtntu3uU5zvgWaisJq5mmr/UiW7JoSOPNdhZCfJ3+96C42al
	8MJFXL7/3ES+/LIOWqU44IWR9kXMnBGwFd0LctoQRwmdIUPLzM8m4ZfFVCssxpFxUkc=
X-Gm-Gg: AYBFou1uEbaGlP9ZYa+KK4zFKcCvD4qfpDLOGAd2NtGSt+uSKK/MRLPIxf3s8KLUJmn
	NTS6ZH6h7Jsxs7Jn+1clBw/B4LBvoNKFMtrm2L9HmWAN+fGSxGHdqVCLtY/Fcp+sh+G5GpvR7D5
	w7Wgx3it3mPDiCyhQq1tjGodpBQtf8p7do2YD+HD1PKS6p3VyBs4nmpe6SLgcP2ShiFE6n0ucUz
	nssuVvui/W285YUBK9TeUFnBbu1qOWPWaDEkpmvKISbJG6i/o8S8a9KEs+K1n/hb+RXl63cPNvz
	fSnlD8lCge88UNfgBjyvLNrkEdjMt/2K/eW1GjM1ZO5fUY/qKys5auLhRp3WWqoivuqFgrO6bEs
	oK7iDSWrVfJAkmdbzH4MQGDNBs0Oez+m+dht0lWJGSVtmSWoflJhIWJOjbWwTL0S3eG392vOHdm
	v8s7vUIesiCZlwS5Iy2TDzqG0s6iSd/M1FHxc8PGsS4ekdIvJ2Nrk5fDln5NX9XxIzSzA8cicQy
	W4g6wG8mBilb1gqk3yIOSu5Lw/0I0GF+e1881Axwjlw2HMinJKnR5EGyhmt67CIjtZu3COXt6kT
	x369UJT525qY73PGOZL9HvR23iqtjjNh
X-Received: by 2002:ac8:5f85:0:b0:535:fc2d:b7c2 with SMTP id d75a77b69052e-542b7044dc6mr116750331cf.33.1793521298973;
        Sun, 01 Nov 2026 01:21:38 -0700 (PDT)
Received: from [127.0.0.1] ([20.119.79.64])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54312a5da26sm56330761cf.25.2026.11.01.01.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 01:21:38 -0700 (PDT)
Message-Id: <pull.2456.v5.git.git.1793521297.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 01 Nov 2026 08:21:33 +0000
Subject: [PATCH v5 0/4] imap-send: fix with reordered message headers
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Harald Nordgren <haraldnordgren@gmail.com>

git imap-send rejected patches sent with git send-email, such as ones
fetched from lore with b4, because it expected Date before Subject.

Changes in v5:

 * End the header block at an empty line in a CRLF mbox as well, so headers
   in the body or in later messages no longer count. Add a test.

Changes in v4:

 * Store the tunnel as an allocated pointer, so it is only finished when it
   was started, and drop the local tunnel variable
 * Add a test for lowercase from:, date: and subject: headers
 * Explain in the commit message why dropping the From git-send-email
   special case is fine for mboxes written by other scripts

Changes in v3:

 * Split concerns into different commits, commit message explains what they
   do.
 * Handle tunnel leak in the proper place.

Changes in v2:

 * Case insensitive header match according to RFC 822/2822/5322.

Harald Nordgren (4):
  imap-send: wait for the tunnel command to finish
  imap-send: accept messages with Subject before Date
  imap-send: check git send-email copies like other messages
  imap-send: match header names case insensitively

 imap-send.c           | 61 ++++++++++++++++++++-------------------
 t/t9001-send-email.sh | 66 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+), 29 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2456%2FHaraldNordgren%2Ffix%2Fimap-send-header-order-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2456/HaraldNordgren/fix/imap-send-header-order-v5
Pull-Request: https://github.com/git/git/pull/2456

Range-diff vs v4:

 1:  8941ae12bb = 1:  cb27ac3a27 imap-send: wait for the tunnel command to finish
 2:  ad3158b336 ! 2:  fa90c64a5c imap-send: accept messages with Subject before Date
     @@ Commit message
          and git send-email writes Subject before Date.
      
          Accept the three headers in any order within the header block of each
     -    message.
     +    message, which ends at the first empty line whether the mbox uses LF or
     +    CRLF line endings.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ imap-send.c: static void wrap_in_html(struct strbuf *msg)
      +{
      +	bool from = false, date = false, subject = false;
      +
     -+	while ((line = strchr(line, '\n')) && *++line != '\n') {
     ++	while ((line = strchr(line, '\n')) &&
     ++	       *++line != '\n' && !starts_with(line, "\r\n")) {
      +		if (starts_with(line, "From: "))
      +			from = true;
      +		else if (starts_with(line, "Date: "))
     @@ t/t9001-send-email.sh: test_expect_success $PREREQ '--compose handles to headers
      +	test_grep "^Sending 1 message to INBOX folder" err &&
      +	test_grep "(1/1) done" err
      +'
     ++
     ++test_expect_success $PREREQ 'imap-send ignores headers in the body of a CRLF mbox' '
     ++	test_config imap.tunnel ./fake-imap-server &&
     ++	q_to_cr >crlf.mbox <<-\EOF &&
     ++	From mboxrd@z Thu Jan  1 00:00:00 1970Q
     ++	From: Example <from@example.com>Q
     ++	Subject: Fwd: originalQ
     ++	Q
     ++	---------- Forwarded message ---------Q
     ++	From: Someone <someone@example.com>Q
     ++	Date: Thu, 1 Jan 1970 00:00:00 +0000Q
     ++	Subject: originalQ
     ++	EOF
     ++	test_must_fail git imap-send --folder=INBOX <crlf.mbox 2>err &&
     ++	test_grep "no messages found to send" err
     ++'
      +
       test_done
 3:  919e38c31d ! 3:  8646185486 imap-send: check git send-email copies like other messages
     @@ imap-send.c: static int count_messages(struct strbuf *all_msgs)
       			break;
      
       ## t/t9001-send-email.sh ##
     -@@ t/t9001-send-email.sh: test_expect_success $PREREQ 'imap-send accepts a sent patch from the list archiv
     - 	test_grep "(1/1) done" err
     +@@ t/t9001-send-email.sh: test_expect_success $PREREQ 'imap-send ignores headers in the body of a CRLF mbo
     + 	test_grep "no messages found to send" err
       '
       
      +test_expect_success $PREREQ '--imap-sent-folder stores a copy of the sent patch' '
 4:  5b4a08bbda ! 4:  e7d1d7cd72 imap-send: match header names case insensitively
     @@ Commit message
      
       ## imap-send.c ##
      @@ imap-send.c: static bool has_required_headers(const char *line)
     - 	bool from = false, date = false, subject = false;
       
     - 	while ((line = strchr(line, '\n')) && *++line != '\n') {
     + 	while ((line = strchr(line, '\n')) &&
     + 	       *++line != '\n' && !starts_with(line, "\r\n")) {
      -		if (starts_with(line, "From: "))
      +		if (istarts_with(line, "From: "))
       			from = true;

-- 
gitgitgadget
