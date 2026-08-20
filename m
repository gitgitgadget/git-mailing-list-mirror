Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DDB3750DB
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237240; cv=none; b=fSGkCyZdl4dJXTP0HuH86Opf+gYEqBiZXs7JxWMcLVZFs6+L+pZhtLqyMaUB+Gg9AA2va3UcWb/yN44xB0vZH5/vasOcm2xl9hPAE0WDtRNwxW6RXhsRlhlM9i+fn2dYAmMLhsbxsysgmNwFoItcDp3NkCP6M+zFcuJIKTBY98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237240; c=relaxed/simple;
	bh=HgPwnoyjtdMaV4w43xDlvqPEPtzi6Yw0WIkG34PqFf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t30Wll05CPNMOGBhjB1mGyqIt5vtYnT+Y/22B98HvVYe0XjKK6oGtkeNoxS73JaGUfnlzpyDGM3pz9OMFq0ti7Uk7IQYyEEb90ZeZbYG7auhfvlymrCaQm06LTRmgPua8UMc2kzWTIdAZ48ktVy7dTFQ0XaEEzVtzNBi+EHj5C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VscBW1zJ; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VscBW1zJ"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66c4e9769bdso2872362d50.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 07:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787237238; x=1787842038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ISpCNXJq7GshYbPt15peQL57xGfyR8F5voLAgtHLpeY=;
        b=VscBW1zJJGEY0iBp+vNq3m7cB/ucr20Kbe91MzVmAqTCwslAEH7PlQRiJbEdqy1Mvk
         aUTQkSGq+ffqMC1vAuuTMJi0r42fYOU3U30UZLPYpmapoHQH0sVWrzqyAY3/QPRbl/qJ
         iehXCuYEHJW8fMBd83EyIHx8BX6keVwCEsHJ2NBjVik+UmMZsKUe1WCAzWmLaVZxLyh2
         OI4cIuioyflqBgjjjbTAqs9fG+p8DOgyH6wsvVqL3EdufAb/i42lzOegqnBFB0GG01Zd
         o2co3+3uDlgYDV/pZn+1gePqJdksZ9U1fTyTzQ2GVCmZOJMgqInyl0G0fe/KV0aWaQKb
         f8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787237238; x=1787842038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ISpCNXJq7GshYbPt15peQL57xGfyR8F5voLAgtHLpeY=;
        b=kvmaoXITClFAyoyeMZVtc9pDrnFla8IJIdpPjUSltXXSyz8HDx0BY3r8rGlE5v5gYJ
         RqvkBcYejKl+M6DAimXCWHI2qso/0fMRftGEXbEPK1ZKIIZPcLNOTLdhs/MTXqDJTJjV
         Hdo2PxIB0eclgRwItTgHsWuNWRAn1ZsiX5Nq1nfpe6ReCP+oBhs4cg/nixV0l9EMauAo
         OaxEKRW4SM3M31hTfo4AWT1TjCEogMD7lrhYl9Sk1G/dSSt0EVRemyMxG9zxTidnMike
         IR4+ty2b9U3JmVKH8ljd+mHRZ9V9+lzBwDgzsFUpaowJuntbNfd+1WeoIAKCvZM2HEHs
         03TA==
X-Gm-Message-State: AFuF++n5N9hfcQA7nM7oQE2cC57Dd7hqHvtRZHqyuso2RDmHxknHQHti
	B/k67WYrHm6J9a+BXXe7r5Pw0sCU639DEhy3ZcnhmYj+yvO7RreAFtb9q43QXg==
X-Gm-Gg: AR+sD11q0gO4Dw5Y5NUVxhVd6TQNHFFyMSmTH7WR4ZdsrOkkPnkYo96roHgz+vojJXQ
	rQ1lneci8Miwz7RtAxg9e4+RA31kAiCANZFQnFe3WHAYuErryQjZArQ6Wijg15gF0vsJI5sjhEM
	YsXh5HJCfToKWUYpyxaBiC0pH6jHOLZKt67qLyBxJpjZXCcf0Ej+Ylw5gOzLS9ZJhKeTukUuSO7
	jI5Gjig2+Mh1yVj/lSrhxipWYq10K7Nz5xDYRxiRSATD51dBkZgOCVCKLwt8RFDDW1wbnEJ2tw1
	J0atJAJec+O+cosmT6HFLEkbAkvJ5xuLRhmUkwth3NPJqmtweCtSBr5P2OwKRnVAyTeJ/bKgOS3
	dFdpO9ee9sL1rCLoLLk130bkrRM1/mbE6fhPbg/V+AQf3GZfWZWhRXWDvJswtFiqgJv1k0/NZdd
	Bq6zTM1qdOL02oRZl3f4GddZaUKLz53/0w7n5yMsJXbXpTl1YcVHXjipg9WU2DuDSx8MEWZpTDP
	JMXjs3gS78ZD15dQcPcggGCPxZUzaSsLAsoobWiBTNkdJ+jZ2LIGIFuvO7g2sMNOxqXuwXMqk1g
	1sAdGx/YpOf7yAH5VcxrnVR60vXo9HLhYLISsQ==
X-Received: by 2002:a05:690e:2441:b0:667:bb60:78b2 with SMTP id 956f58d0204a3-66ccb6f070bmr3376605d50.34.1787237238423;
        Thu, 20 Aug 2026 07:47:18 -0700 (PDT)
Received: from localhost.localdomain (99-71-100-228.lightspeed.milwwi.sbcglobal.net. [99.71.100.228])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-845188b28f2sm25767407b3.38.2026.08.20.07.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:47:17 -0700 (PDT)
From: Nikolaus Schuetz <nikolauspschuetz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] t1402: test forbidden characters in refnames
Date: Thu, 20 Aug 2026 09:46:37 -0500
Message-ID: <20260820144648.47267-1-nikolauspschuetz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqqo6exuagw.fsf@gitster.g>
References: <aoWRZhO6BVy7uPLI@pks.im> <xmqqo6exuagw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> True.  And c does not have to be a single byte. ".." can also be
> part of the repertoire.

Agreed and updated accordingly: forbidden chars are looped over,
and I folded ".." in along with "\" (the same forbidden-char list).
The other refname rules enforced by refs.c are well covered,
so I kept the loop to the embedded forbidden tokens.

> By the way, one weird bit: is it intentional that all of these really
> use "heads/something" instead of "refs/heads/something"?

Not intentional -- the file already mixes them (e.g. 'refs/heads/foo.'
vs 'heads/foo..bar'). check-ref-format validates each component
regardless of a refs/ prefix, so it doesn't change what's tested; I
kept 'heads/' to match the neighbours.

Thanks,
Nikolaus
