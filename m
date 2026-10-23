Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757050;
	b=gcJjRLGhlqsgLrNmj58JFLWW9WTA9PcBraXdRIU1KHPbh+heevfcchBebRbQlc5lUSF2
	 7BJAgepvHK74zUi00SvvyO7ThMuAOlQvhcHXxSuLnE/zNjaCg3j8v7XQQh5teqKkGdhme
	 sAI7UOhjzY/9WJ2KNeIV1wA05N5/zOaEAn6fMVows+HQOAgnRN2zLpq43jMK+1JaM51FV
	 2s+ShiVdYaSjskCc/rsPelsEDNXpTieDnQeScLxRn3sj21aov1BGoYvRS2SbIUCoKO5zD
	 24BcrGNBlhu0DMNePqA5QonQTisY+exAwzkPZSJknVA1JBjXfl/hX1GuH7/zqRT2wYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lDmrrYsEBjIITycYeBm5etjSYYNPsZMJ4UIiUKTPMIY=;
	b=KOFWovM320YnFnnZajttf1lrAL4DCijdM2rHCoHTKG4RATwQMU3KirC0D0Hzfff5uRE3
	 Thijnxfv1BBVd8XfX2YPg5tRzxYkX10az4umsgVzRjUuMf7ADkP5Xe3JKCfAmiRVPfjgd
	 5XtaQK5lgqD/uBWowQYx+O5Wy9MYkE/GjdZPKN2oyCY4qh4bjzDG+lu7T4E5DZe28cYLB
	 NFubkIdA7rghqFolPc+IkWeFj/Rbd4LNnG5t9x6enMUH4dN42tdAjH1o8XFx8UTMDGH5U
	 3ulgaEriMrYobBQ9qUbuAEJ0Kyv/IKFwubwAnfJ1TzhTfyjzu5zAT6UlrgqMcIZaamQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sy5GJo2t;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1AC606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD1AC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Sy5GJo2t
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48c4d870d54so530457f8f.2
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792757048; x=1793361848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lDmrrYsEBjIITycYeBm5etjSYYNPsZMJ4UIiUKTPMIY=;
        b=Sy5GJo2tk0JhZR0PSAdtR/H+0VIvmIehzZaqAgJMs63qcOhme1ZGS5DX01QazA/Ttb
         TpWL12zG5Wdcdk2vGbmixB01Ep/OovbT3icNR+Vu3fLVRxaOQwX+BQ7nQgqpkwkoB/WO
         kdddJHEe0JXgkppHTsk+8uJmBPTyFrzFe2RjsHrNpa2plXAqtQgW2y5ulfK5sSNpvXfU
         UD9mJMAdKs0NpqJdqE0scY5Fxohn3HOTbNXqf9iOwZnqaJf3Ez8RF6bqI6BA8xgeC0pS
         YlmBzFWlkuHMLuCkEU/wlDWg2SkALNO5NtVFZBBLrjTnCJTdj7tXNj9sdqbUeD09CeK0
         cFtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792757048; x=1793361848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lDmrrYsEBjIITycYeBm5etjSYYNPsZMJ4UIiUKTPMIY=;
        b=T4dEkkQ9/mfp30LEvfeLOZ6griWPx3PMSjTtcXJjYs/gh+p3jj6mq1iX4/DkLci+9t
         e/1bJkbR7qbU04axX7vf42IBpkEbMd2o2jUSzQbKcMwBGF16putVkihdCjZdz8K573UA
         Optf+DAa9pkUT/sRFbex+ANR4fU9k1Febb29cmpAtHkeYA/wbL6SDwHxzleXRmXIsxuq
         yvo6cVn5t1nvLfIzBwpPDnnuxQDyuglT3b9d5e96GsdgEQoI/8CNL2f2tGyJiq5NyzpU
         xtKeZaDSYvuhIbbrfZ1eLq/jmn29y7Wbbtnmwq3PpUIaDve5Ca7ouR8QjuNT38k+MplF
         bhGA==
X-Forwarded-Encrypted: i=1; AKwUvBwtgActCc3OVOg011VM/NCbqCSiuNfdTlCrDmgqtdmhKBmvH1ZJ4PIWta9n9a3TXVXGA+o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVFK3bxuHGmSbWiJ3FkvPfQC96ogaJBVN+94bx37sflWFiVv7a
	ScjYCAExPm0Qzp4eUXQ/KdUBsJ8O3YS9kNHEJcBtdV46OWQeB7F9LXQH
X-Gm-Gg: AYBFou1l5zojNF7ZF8TdBzbAxfCHzFcJ9U3CNJ7lJ4yn178zbm2r68gkGPapatTnSb8
	DocPeWOYJolQveEErODe07l77S0o5g5H1zoLbcxcEsie1IZ+s8WWmjcfaEAIQp+zM9eT6/hzYOm
	qzhgOxvthBJz9ZipSayoN5n1YTiGVYtYVp4ugBFn7sVs3ZP2WfR08z9ctIm+1DNNBkmNLbxfsAo
	RMTnFj0FBAXNHQyF4lgXg1pKxUQb/uf9vIpdhcufm03j7HBTipZ2qSaEokS9aPKHzbVb5/i4xTL
	FwTDMcUyRyKQBV8kFQd74ael8x0AOai9NHDByQChcwFfxbkhkHhj8svwi/xWyVpuhn8PiUcuJAH
	Da3ZHCzh17feg5ff4oB2wV40xX+JQj7xR5e+l/URfkePCm4uXh4sxsycsDJ4MiCKZWBilpudTdG
	BN5Avde/iCKYyBSnR8fwl/kiNqdakvai6MASoh7MBuaZ6B8WyUByVaISpRNFjal5zlMWIpKn9G8
	PIuaWuXWU0A+jhxscEUIQ/nLpgedfOA2ZnH//1ACRvoMqj6TeU9jtJnmr4RhRYH/ZN/XictwAZI
	WRbt
X-Received: by 2002:a05:6000:184d:b0:48d:f984:4a7f with SMTP id ffacd0b85a97d-48e387c3368mr3577242f8f.24.1792757047578;
        Fri, 23 Oct 2026 05:04:07 -0700 (PDT)
Received: from DESKTOP-0SUCFI3.localdomain ([129.0.81.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37edce44sm4855570f8f.3.2026.10.23.05.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:04:06 -0700 (PDT)
From: kerylefondji7@gmail.com
To: gitster@pobox.com
Cc: phillip.wood123@gmail.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	git@vger.kernel.org,
	Keryle Fondji <kerylefondji7@gmail.com>
Subject: [PATCH v5 0/1] archive-zip: refactor 'path too long' error message to use Q_()
Date: Fri, 23 Oct 2026 13:03:57 +0100
Message-ID: <20261023120358.8061-1-kerylefondji7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqq1p9hhbue.fsf@gitster.g>
References: <xmqq1p9hhbue.fsf@gitster.g>
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

From: Keryle Fondji <kerylefondji7@gmail.com>

This v5 corrects the line alignment and indentation issues reported
by Phillip Wood and Junio C Hamano:

- Pure tabs are used for structural indentation on all primary lines.
- Tabs combined with spaces are used for alignment on the continuation
  line ((int)pathlen...) to align arguments under the opening parenthesis.

In previous attempts, mixing tabs and spaces incorrectly caused formatting
errors, but this structure now matches the expected Git style.

Keryle Fondji (1):
  archive-zip: refactor 'path too long' error message to use Q_()

 archive-zip.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.53.0

