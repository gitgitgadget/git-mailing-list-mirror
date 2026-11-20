Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795170936;
	b=IFn2u0DSzWUUN8MrDi9CNiM8b0VYaCqmIAHnJWht/eHx4dhk+KNMPhzht7U3RgUitP1b
	 3tau1SoXAKlTlOlhPpApfIbGwL5TOJoqO5BnQcSQzIAS97DqcTiS0+6Esq6aBoHbhPGyH
	 duq+AE+ay15bY5sH7RSOPsDuO7dFrf05pLKsyq3XanUQSk3lucK/e0ttuaXHBd4AQCSUk
	 2t0rlDrqPk77chdiHN5TItJRGmyVRJg93VEaM3FrL0wdGz//s+HipAxP3XBM2VV56ie82
	 XzpjecttDkixvh02kcdv9FnYjBQFcvhdjSZ4gLjfVA2YNBC6N+2llJqlhvxEQzo+67w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795170936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=thgmRtCdNWM3/3eFmrd3sXf65yxKOQwndR0NtdaUY4s=;
	b=BJx/sb/ZUojal13SDmi+6wyQ4S0bTPn9fX6tTq7sSsD8yxIphadFKt5fkrJcodoqiNBc
	 79Q/t2bQVDtX21DIH9byqOFJpA66TNlXMU1xBJRu4a+aZSvA8hN6tUoolH4IkKQN3+mIU
	 wZadrYzMP/SUgMxAuGLmAbEMZn+nyVgV7Hf7FswlzjkCKe9N/ZH1z3CXQGp8+irpCGi0x
	 uakMn2HbAzb7LBPwdiQa3MXd8d0N1vCAfUka0/2kkHtfxzADB2A0pybvPAOrbrWEG/eQj
	 6UZ5QUbYGRlFM2Qe5kNM7jO0t3jHOYX78FHlZg0RgIfqCLf1/LlfAZTtzFdTik5zuSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zqDIrDsi;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC17606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 10:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFC17606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zqDIrDsi
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8c5ebbc5150so620814b3a.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 02:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795170935; x=1795775735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=thgmRtCdNWM3/3eFmrd3sXf65yxKOQwndR0NtdaUY4s=;
        b=zqDIrDsiIC9A5XwMm/C5XLsqzThtrmSlp9QXhZHFB/DLpyrwlXhouJ3y8qnxs4rbEr
         6lm30WBLFB1Z7vIlP7J0+qxPVnEEUnbAVNa9y6cr6QnXQB+jxyw6QnqehVBeSGVCepmq
         bMBNKR/p0eTXuCn7L8GdmoVExF/sT9M17hF4/yTd0J5dFlB5yeAdzYqnhje644Oz/Exs
         WKzPJH/U+8i55+k1Z6tRnta0ykFffEkGF2WqmTbv2eKFC6MjgTYFu5IbOtvTaxeLufAN
         Xrm43QsMjVfxZA8HAY3FncGvgmu0+FAsu0RNGj6OGSZMgoLCFg7pbD2UK00pdJIhkVBD
         Xj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795170935; x=1795775735;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thgmRtCdNWM3/3eFmrd3sXf65yxKOQwndR0NtdaUY4s=;
        b=rbAvU49+aAmJ1HP/ry8+a2GywysnP6iwemdcaFI//A196Z3z5UYQPCtOj0HsFzhmlv
         N/Eji9HaH61rQA9g/qVl9OW3ZRF2AUrNDVIMvRYD2DsY4ErO4HfoaUFbf2k3uxv0r88T
         YKG4WogBfj2XTTeltPWNYkT4OoXFaAflQ5IyinM8ZyhshKp3VeDFDL4ltEEct3HExXed
         X/0AqstXGaJbVnIn7EB6dq2Hx4PKomQ+oa9n/mosqXNflKGOQt7uar5fM7Q8G86v0rc9
         Ws/1iKnlvqTFOcflMQlKsingDsNTHk9C4isq5BtI/DU67ysuAStAIsHwdYnuva3mihX5
         xUSg==
X-Gm-Message-State: APuU4Z+a+oTOI9hHam2t/hXIZsbBVJqSIX43lrglx3ldvYUdlJaT9oHx
	RFTLB2yjLe4SPPfzCiJCGva6OrFlj+BBhb1m3eAU/Q0uwgiIOeZf/g7GdI6IoVos
X-Gm-Gg: AYBFou0SWlYO9afmIpZte2EODm/C+HcL+wjU5vogNlMTkb9msnWavCQW25a88yQUyWh
	QuXnGO19KgKfdEUv1BvH1vW2M3m3lmCV3qQA5cF6d3Oy3BR8QsRJqP5VYPHLSzhdySq4+7UR5pu
	hJOkOGCRCOJ4AJUAMSJ8t0pWV1r3/ZhnBsgM+NRZKyN6PYcLjycaiv8xUEpmsJGD+w6x7KRBEmJ
	3QUyD7JiYgjpqDHiSAo/JAl7mqPcD8QCf9vmMwmdVGv4w/5oHzEzUW+d/kTG/iOn6WPnD7jCE4O
	MuNnQFFzbAn/3KyKTRbIdfWlTlGvbPPZ943/LB/Md9eV3W9Rn5LONaK5Cv6Q0Hva/OHVoAvbHd9
	ldq9ZLHoJCZKdddnbpLiTAd39j1CY+QK4d0hhbwdDhVH0fT6Y4pUMi33MhOn0xm5CBdY/q/btz6
	7WFUVYvuTyElXquhtkXf0Oj4bywrGNIYB5mZ/cC2tsfLadQn2KbvHvb2Lg3heec/mpN8Gwvi0sL
	d8q+BiUNKoEgZekjgyvCZdST54bKg/b/uZTHLb3dr3+5DmjGcT2px6UeKrkuYaH+kFHGw15FUE8
	7+7cK6XqweXsnb01gcnlBiKYGSZl
X-Received: by 2002:a05:6a21:4849:b0:3fa:5900:6e51 with SMTP id adf61e73a8af0-4014d4559e4mr2142805637.31.1795170934913;
        Fri, 20 Nov 2026 02:35:34 -0800 (PST)
Received: from aeron-host ([103.177.178.109])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d0818c1sm1089321a12.30.2026.11.20.02.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 02:35:34 -0800 (PST)
From: Abhishek Agarwal <agab0323@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [GSoC PATCH v2] add-patch: use Q_() for split hunk translation
Date: Fri, 20 Nov 2026 16:03:17 +0530
Message-ID: <20261120103317.160931-1-agab0323@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110193804.76958-1-agab0323@gmail.com>
References: <20261110193804.76958-1-agab0323@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The "Split into %d hunks." message uses _(), so a translation can
have only one form for every count. Some languages need more than
that. In Polish, 2 and 5 take different plural forms: the current
translation "Podzielono na %d skrawków" uses the form for 5, so a
split into 2 hunks reads "2 skrawków" instead of "2 skrawki".

Use Q_() and pass splittable_into as the count, so that gettext can
pick the form that fits the number.

Translators of a language with just a singular and a plural form,
such as German, now have to translate this message twice. In
exchange, translators of languages that need different forms for
"2 hunks" and "5 hunks" can get them right.

Signed-off-by: Abhishek Agarwal <agab0323@gmail.com>
---

Notes:
    Changes since v1:
    
     - Replaced the last sentence ("keeping the English output
       unchanged") with the trade-off for translators, as Junio
       suggested for a similar patch [1].
     - Author and sign-off now use my real name instead of "aeron-gh".
     - Rebased on current master. No code change.
    
    The count is always 2 or more here, because "s" is only offered
    when hunk->splittable_into > 1, so English never shows the
    singular string. Q_() still needs it, and translators fill in
    their own forms for the counts that do occur.
    
    [1] https://lore.kernel.org/git/xmqqv76vnd5h.fsf@gitster.g/

 add-patch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index f27edcbe8d..4e75e2ceda 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1942,7 +1942,9 @@ static size_t patch_update_file(struct add_p_state *s,
 			} else if (!split_hunk(s, file_diff,
 					     hunk - file_diff->hunk)) {
 				color_fprintf_ln(stdout, s->cfg.header_color,
-						 _("Split into %d hunks."),
+						 Q_("Split into %d hunk.",
+						    "Split into %d hunks.",
+						    splittable_into),
 						 (int)splittable_into);
 				rendered_hunk_index = -1;
 			}
-- 
2.56.0

