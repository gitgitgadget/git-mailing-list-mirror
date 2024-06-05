Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234FA1922E8
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583411; cv=none; b=R7FOOCYmktE1CANRnVL5U117mv5Z2F+4seP6FcD02MOjg++KQoU63MHkaNtWPSa6d/j3kZirFvNbQ/3H5H6Fj7hvTfPgchrxKH6RfIHjnf/IAqbGpO3pa9INlh/W8LoFN89cXuJIeQuEA6cMGkpJjazhxy+BA78rpFVRdcF8L/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583411; c=relaxed/simple;
	bh=1d0IPOvgedX9NXw+CYdoCrJtcKhxgrdIbu+aP+FYI3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luFvJRATuY8OScBfxyb8GUrkYXFvlRi61rILSxEqpLkR0umf9Ic+OLcFD0d1Uuk5nBnGwODkXm2WupbP7eGxqmAbNEddbB1FlawoUdJEbrjltJVfYeztpBDKmrlU981Ba60C9UcYYfH/FcUE8D+0NxnWkownQiS311TndJRP1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grZtg1f/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grZtg1f/"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6265d48ec3so697093366b.0
        for <git@vger.kernel.org>; Wed, 05 Jun 2024 03:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717583408; x=1718188208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AT0ydthns/0I9sX6W7m+LQkEY8uS7Qu/OV5UVfBKgWQ=;
        b=grZtg1f/s+h20X9B4PY2TlBvGdXlMjuceRgwyi/9ShPTYZ70UsdS+PkalY79YhuGRX
         em/FoVltTneVVDYhw4PRWOMFUeEB8FOy+7jbqxGs1rDb012stUjWvSRRt/O3vhisZfGZ
         EzISD/o+7kqJNSxasTyFeLQ78I2Ilg+VJ8eW1Qjd88TeGVxpdU8xaYCo/nm6c6D11WAr
         JNKZ3sWvMGpyseIAt16iUq32/slUwhFCoy2FLgSlmRoRaDvBMfoJShO6Gkmp9b3Y4pFA
         3vNZ9PUFHbxT12KOsjqNtNasXYBv7eQ/YBRkV3ulUpT/MAV0/BSNmJy0v6feGrlBBCqS
         dXHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717583408; x=1718188208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AT0ydthns/0I9sX6W7m+LQkEY8uS7Qu/OV5UVfBKgWQ=;
        b=Tzo+rCq/PLpha8Q7M9F0Uo8M41BmD/wQCAskQNrscdqoqP22Zi4zEV5giiHJvw5eAs
         UIv7DDkOyCdm5IGyilRrreuwjf9af3d73jCIcdysFEu9pvnwdj9S2CHYGeTxrNNEDTUB
         EaGRNUMEIo7trH0MD84FWYLE/xXqu3Oz7SttiqZagrBR1YEEX3BmDvuLhb7ZX58pNW2T
         xtmt9TXIdpGx+AdGeg6AZ6III10y3hZsylOWPmQ51nFanCX9cw+/j1eh1dPi39fMY3v2
         m1WSMfT6OFRr+oInPuG2ITRBKlFNgvffD6YlHEB8t0Scj9eK1GBRF2wJoCL+tDKjyi9K
         nrDw==
X-Gm-Message-State: AOJu0YxJIqgl7bO+43WfnqS+dn0EMqCku7BmbJmnLN3Y7hrDd0GfIhkl
	3ELfaiPZtdXXB6+Hss3hLNqAi2r5nEgX6nzmbjvxwsiqg3w/BW6CgX1C4mZ9
X-Google-Smtp-Source: AGHT+IEvAiT90CLpTJgoHY+899mLMC54nlPowGy86+pDt83JXhxPx1EItyMKN2A6ZX07fvfDooPRiA==
X-Received: by 2002:a17:906:bc4e:b0:a61:ab74:413e with SMTP id a640c23a62f3a-a699fcf5204mr137309966b.46.1717583408435;
        Wed, 05 Jun 2024 03:30:08 -0700 (PDT)
Received: from localhost.localdomain ([185.223.147.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f0e03cfdsm510453166b.195.2024.06.05.03.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 03:30:07 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im
Subject: [PATCH v4 6/7] reftable: pick either 'oid' or 'target' for new updates
Date: Wed,  5 Jun 2024 12:29:57 +0200
Message-ID: <20240605102958.716432-7-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <https://lore.kernel.org/r/20240530120940.456817-1-knayak@gitlab.com>
References: <https://lore.kernel.org/r/20240530120940.456817-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

When creating a reference transaction update, we can provide the old/new
oid/target for the update. We have checks in place to ensure that for
each old/new, either oid or target is set and not both.

In the reftable backend, when dealing with updates without the
`REF_NO_DEREF` flag, we don't selectively propagate data as needed.
Since there are no active users of the path, this is not caught. As we
want to introduce the 'symref-update' command in the upcoming commit,
which would use this flow, correct it.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/reftable-backend.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index bd89ce8d76..fee7a9904b 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -895,8 +895,9 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
 				 */
 				new_update = ref_transaction_add_update(
 					transaction, referent.buf, new_flags,
-					&u->new_oid, &u->old_oid, u->new_target,
-					u->old_target, u->msg);
+					u->new_target ? NULL : &u->new_oid,
+					u->old_target ? NULL : &u->old_oid,
+					u->new_target, u->old_target, u->msg);
 
 				new_update->parent_update = u;
 
-- 
2.43.GIT

