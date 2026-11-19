Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101282;
	b=zXur7uTVG7v+QWVRimO0k+LbMCc3OtDm2UOZsqkTMSlJVE3oOG+743dAduxR1YY2XaTY
	 29mhh/eFUXs7BFgACs6evvDR7aUYEnV5VL2gEp9U14W444I7stmlC+eCcKx/LVKbunHJp
	 QSnwoAOflMvJxBUG6QYtYZjGZb8hjGZ1e/D5m8Z+3XiQfyO/BdWg+ED5pr3Rv5KQ7hl0w
	 kDPBINVqzrXMgvwUhGOePh0kfxA7kTozJZufOPUNfu5aVwwWvUfhoelYtysFDKSc9QVt5
	 Zowl/Qy75wjO5vihw64aPVjgcqPAQ+QQwrXQ2U6w4mZirGoEYvsrb/igTPMA95kM/yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6YBk2u0n84qTWR5L3ETU6MyJ/TfvAuPYFc0pt1MFIps=;
	b=nELAlNS2dW4H8DRj2sKCdcNWn/MSmEEMs7QgKp74wHLT4bjkD//5DY8vmdunoQ9Jnn8Y
	 4VVgEMWDCXceuLrIrXdnhgNJRMnnfCWIZFH6mV+frCB9/rnpkL6XjXpqFI+jUhO40sEKG
	 x4cdglPUExPg/1SI9sMNUzGPDR6zwErEZdxocumF9nbn6dw6P6LG+PdLFF3diecKTH+6P
	 zBF1VmLc71oRGWmsirvoXOmZ6o1MRzj2B9WPJ3Q2l7Q+cm2tbFS5h4izgJ5t03P2psp4j
	 xJsUDl8gEYe6S4TfHKCp1DYr6RlQtCAUAm1TQlBypBD+/+9Ffhz+n9Wzrez81Al0W6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=OUc2lEAx;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A62606A32A
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 15:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7A62606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=OUc2lEAx
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-55c35262674so17064711cf.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1795101281; x=1795706081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6YBk2u0n84qTWR5L3ETU6MyJ/TfvAuPYFc0pt1MFIps=;
        b=OUc2lEAx3x4MokbutrgsYb/65Z4HjTeGFVS2sThbc754xUEABIOK/0Nw/ZO29x51X7
         J/wk5HWZ5fnO+7db/dPp95ptO+v0Scv81kXjTIpjG6x5mLqhusG65jfdpwalIJffeZiW
         SakTucAdcTg7H/+Bb+/TM0Q2DsoB1QNYgP+BYPCPSkLH40q8zVD+V753rKB+wmQxsHYx
         fUvUxtjcidj6GdCH5U+dOX8U/ix7kGbVEsHo/ZMaE8EK+ezJvE/Byc6DYlPJ+kxehdrV
         N78RVjEi4kYlVcAMk64aJrmOrelRvdYT6C3B4ZMJEcTGyLQqp6V1srQnASDDEF8O6uQT
         Ht+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101281; x=1795706081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6YBk2u0n84qTWR5L3ETU6MyJ/TfvAuPYFc0pt1MFIps=;
        b=Q1fnQDSSkltm1lkThEUH/hr1j6elNlpgy4gyB49Zz0jyFMW/LbqG+6ds8Akk+TXjRf
         1HGdiGtgfKLtA3+zhXVD8aQdWZkbOrnd0IHzTihnUV4orXw3jO/p0gWOY5ebmzcY3dE5
         Sd/eN0Vk3uuux/oQpEa1khxrJBz+/x1EbASeil0vTA4WAm/bd06pAxNv97zTRPorj/Hz
         9Qfrt2NX9ub7dHaUXIuUzps4NbbmZXmd2+D2m7jlgPXeNwQxm3E1EGhDzND72DPNOjON
         J1BTDDLIDyh5atASp33guruTRp2VVFPkcMX6o0llbocbp/Gxng4wcWBmAgVlFgThLuFy
         dsuw==
X-Forwarded-Encrypted: i=1; AL+hErHZCuzj8YKgUa06GaBZs3Lj5QKnGQIHO4uiuIgNEvlHmdS1qREJbdaBHP4MQbxcos6Kp10=@vger.kernel.org
X-Gm-Message-State: APuU4Z/pDvkA8jt+3b4I83Ga36Q/Hdc1QCuOpCan8HGmElJ4N7vDbylr
	l9Z8XJ804w8xTJq2Z8QIE3nM0dPMSzC6UL/iMg5fxQxZJOK1L/mocYIGl7WixNzjQ9sQgj5ECWi
	zQhWwAX6FL+0/ln+VFFyp2zLMGVMBvOgtG5oP218uhLcKkYGAN59/+jC1m/lT1mwFGHv7T9hYum
	bDd+3HGWwlbPW/qoB7+CcmLHJCd10usA8=
X-Gm-Gg: AYBFou2MaZOY1FbmC0dKC2CCX1bEOTD44eaw4zh5fkmXECU7K3RgjJZg8fC7x1lKScg
	KEbHwpLpbubF2g2ef72CPaXVEObgbzvpoO705xc8RJ6X8M5qzAc2QMc42bIIaDY2Kmnzh9cO0w2
	ERxa94coi1bt80M5LAI3Wux4iGMgqoatZdUIISo4H1ck8s6B1PYy4GYij7eEo6WlLU4TVoXMlkl
	WdSgpGyXCUDhssoNCGvf6oXpDDBi67UC7UfyljOQbzoM18IfmxLJP5DEQWx3t8xMBvjlyM+NqMW
	6iCmRjhAhQsXIlw5dvByBnlG5Xt9vecS7T9wRLCQjd04O3Sr3Pu19QwAlcwTiNUDuALDjsCxA4+
	zCgxMC0+BDqe8S+l3R9rbPpq1HbmGU9xKhTyvqk3gopHhLvbQBTHqpkWQRhjSYnAhro1XPi8iBm
	Nef5jUFXJrL+DHF7K0x9Kqf/0UVC/+qq2IYWbz5LYkFTqcnLhtzhq3v/qAbFUy/GiOnfm7r8p3r
	oh1KItAIqf3lyJgLD2NGn/944/4RmrITiX70SrCgps7pD1msxFWK6Wvu3KTDZxWpwM/D8U8S81U
	73JieyahVe8qlI1bX9PGf/bX5gMMS7bh0/KIfGkpBpUP3RqgXPvOeiYaFsQ6PvUgLz3zzct13bt
	0Vlu/3Av+2WUAdkIL7mvv6RqBiOZcjSnOQVPLqxa4dk89y3Qy1pxHUbwSI2D6sni7NC08GaCxLq
	3YaZPJDu9hGXgTM/bTGmL+q6J5D1NkSunhovTHAXCZ1HSqqPdGRRaGG+RNZ1Kdi+IZuU+TBbQoz
	lK2odYCKtE=
X-Received: by 2002:a05:622a:c15:b0:532:af50:8d7d with SMTP id d75a77b69052e-55d769f2c23mr3334111cf.33.1795101280548;
        Thu, 19 Nov 2026 07:14:40 -0800 (PST)
Received: from remus ([69.43.65.112])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d669b7075sm25479431cf.2.2026.11.19.07.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:14:39 -0800 (PST)
From: Jasper Mayone <me@jaspermayone.com>
To: gitster@pobox.com,
	git@vger.kernel.org
Cc: haraldnordgren@gmail.com,
	phillip.wood123@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	taahol@utu.fi,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v8 4/4] branch: let --delete-integrated find branches merged onto changed files
Date: Thu, 19 Nov 2026 10:14:36 -0500
Message-ID: <20261119151436.86191-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqqik1t2119.fsf@gitster.g>
References: <xmqqik1t2119.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> ... this code to call merge_keeps_upstream(), causing read_mmfile()
> on the gitlink commit from submodule object database, leading to a
> crash, no?
>
> Or am I misreading the code flow?

You are reading it right. I tried it on v8: the upstream has "lib" as
a gitlink, the branch replaces it with a regular file, and the
upstream replaces it with a different regular file. Then

  $ git branch --delete-integrated origin/main
  fatal: unable to read blob object dae1aadd914ecfe1e09b3adb3c15abdd0085e238

It does not segfault, because read_mmblob() checks the object type
and dies, but the command stops and no branch is deleted.

Recording the mode of the base and requiring a regular file there too
fixes it for me. The branch is then kept, and t3200 still passes:

--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -864,7 +864,7 @@ enum change_state {
 struct branch_change {
 	char *path;
 	struct object_id base_oid, branch_oid, upstream_oid;
-	unsigned short branch_mode;
+	unsigned short base_mode, branch_mode;
 	enum change_state state;
 };
 
@@ -901,6 +901,7 @@ static void collect_branch_changes(struct landing_search *search,
 		       &p->one->oid : null_oid(the_hash_algo));
 		oidcpy(&change->branch_oid, DIFF_FILE_VALID(p->two) ?
 		       &p->two->oid : null_oid(the_hash_algo));
+		change->base_mode = p->one->mode;
 		change->branch_mode = p->two->mode;
 	}
 	diff_flush(&diffopt);
@@ -943,7 +944,8 @@ static enum change_state change_state_at(struct branch_change *change,
 	if (is_null_oid(&change->base_oid) ||
 	    is_null_oid(&change->branch_oid) ||
 	    oideq(&change->upstream_oid, &change->base_oid) ||
-	    mode != change->branch_mode || !S_ISREG(mode))
+	    mode != change->branch_mode || !S_ISREG(mode) ||
+	    !S_ISREG(change->base_mode))
 		return CHANGE_MISSING;
 	return CHANGE_NEEDS_MERGE;
 }

Harald, a test for this case in t3200 would be good too.

Thanks
Jasper
