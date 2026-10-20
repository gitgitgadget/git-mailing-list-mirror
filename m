Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481371;
	b=eAVRnHrqbkY/rKhnMPMPfMA9efojld9Y4JjzoB3NSNCGx8JndVFvkV4HVjfhoxIBXIax
	 BSOruYJEYEhA3QBNzpqpShfcKodmNaIWx/n66VH91bQB8oXbfaVI1KqSaCKgtyoly218z
	 xSfbSJGjDf2gjFM2tYZm/smn4+b3S40bCbVZPL/I3wgjrbx1M5xlWHuTZF7/GLtP3liGC
	 H1MzjFFU2+sZebW7+nS92V/1PggvjHSNK+44iYiYWbcejcc6IMmYdV2i6L9wsBs+S6ye1
	 hINdkAASe9jsv8cR7Xb6OF8a0kekUMGeFvHgjoiiVMFgSi8I14YiIVCeev5MFLT37DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481371;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=XXRYCyKRAQ/TzlkPybSyeHH10us0Mm/wtlwRTTTPWKw=;
	b=tzD0Y0xBxPmZzH8qiU5jNSp//wQxOhSGgwAm6EPtGBAqJtaFaXVJ5RVW/liatQvny7KK
	 danlcVH9AMfSO3kKDhbFrFPlmS9QzOoQsJQ5fGyxBTZ7D+BqRbc89/bIQYweqE9B0HMYl
	 LLvcdi9cmnnRjrJz/3iDDAvIz9nC2JD5MlCGEQcdtyt4GulXtNoWHBXRlmsmN2nTtIrhJ
	 uCAeVoPZfVrn2GWQHmGBdhN3TQuGV45Zs+0Rhwhf4htKEy4QLeIT9JcLybIHiNk7X2WlB
	 8isUgFoU/30be+ZOnZAq73BjHkMwvV9SW72JhlmOlQHK3vXECGJR3yvh4gyujEgeqdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="m/d4O2Yu";
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E2C606A321
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 07:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77E2C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m/d4O2Yu
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso1726727f8f.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 00:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792481370; x=1793086170; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XXRYCyKRAQ/TzlkPybSyeHH10us0Mm/wtlwRTTTPWKw=;
        b=m/d4O2YuGk7N8UoYTJ7NfgUdOQkN4GFGa6jiwjcMZIOzG3lXB32o/95f2d7jD6j/71
         PJpfytGfEjbt5xZWRtbRZL0hLV3Ybik65bJYmPtiVKnhpVCO/ubHBRHnFrwpQiz9l7k+
         268qTdVRTN3bjuDuH4I6Zty90cBk3E591jaxmkMWHV71jyrKRd3Cp1gxR3PRySdE40Iv
         q3baVhcizf9qiC0mcryrVxP+Qmcl3pCD+4nZkFxYyKIkGrXTng6oGBQ9/Kkzw/WegcfN
         9cSfpQWxZ0WdTYfR7Ucqgv7Ni9McvKbKL3RxSIWu4Tv6kd+JTd6IQaazG6y1TySk4Vj/
         DhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481370; x=1793086170;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XXRYCyKRAQ/TzlkPybSyeHH10us0Mm/wtlwRTTTPWKw=;
        b=URhvJwgyTcUgZd2X4WP446WhXxrFDlr64LN84/9tKPVu4Pvo5AZPkUd2wTjjGo8Ngl
         iW0v+nbXGHXlkRhmHCPxHWCAsYmRLYMYBBgh4BJQovVRAFHqywqQ4kguEmvDyyTUJKiq
         f5V8tZwQrGO/7hADeGXCElr/vlmj74j9rGfnzOTdnx1ArDyCF2xsZQVYbOw8Sy2ELVH4
         BImriAiYn4YWgSqttrxXl2l7X8iEeuaeEMTmLGrJatlFrY9AkVNMF27v7A1XC8ntX4lY
         E6oGdCBFSVOJuG+1V2me0d1OeokrnLX3Y9VmIU9l1l5v9riaN+4aiwG6gCtktSH4hgBI
         DzJw==
X-Gm-Message-State: AFq9FYIxI0NkXcaUyoxBK6tQ1YBR3EzgLZa2GAAb8fCThHUOFGT7Cs7f
	Gzz8vCAxD2DDVw6gT+zeO9fErtVaKmFzQY9hCHLhf6Ol8V28rKJMxr2K
X-Gm-Gg: AYBFou3qy9zyMqqBCjBHVzB0xZ66tDPDPigz5Lbk4AylujYPkZl3tVjXGqGtDaPj36w
	Uw4Ur2kzzGSsOkemCoin5OiHdoPs/lfMC4cuSjZu+PxwHCJ+Iolk81oVMqX0ZJzy+yGVkX4RTQE
	XszX0y1qcGcZ287BnWpA9MUz0bZ9gebVzV7cvrowhCUjEvC1bVnioTCSQ8SozJ986C866IMum8l
	h9pW7HkA+IvVOLNVFSl1Bjj7VBO8hgW38vfwlIMmeYJaXIUvJL/+0RVbNIfoORMy45MJdaSxgV5
	VZK3srllZ8RYJ5rJiB79Zc1N5GQZHSydLrr9e/Dzu27YiDHgLDG0Gbt6l+aTmLeXcuFKUEkar0S
	B9YBeH6ZqCLe1PSvV930G5C+8Br1M3WZ0eVYt6sTAVM9h+77dSJutVBzh8CNPf3hDbTGIDNd1Sk
	kAysLBBG3yI6A9eqjxksxAUM5b4CpbnYfGLHA/T9LAA8n9r93dkqoqCah7HOukgUYgoaUkbEvtH
	mZxyTfIkq8VV/Si9a/QOyNHBwsHCw==
X-Received: by 2002:a05:6000:60b:b0:487:1662:cf4c with SMTP id ffacd0b85a97d-48e0797ffddmr21359685f8f.7.1792481369507;
        Tue, 20 Oct 2026 00:29:29 -0700 (PDT)
Received: from ubuntu26lts1.example.com ([151.28.1.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d8214cbsm4178574f8f.43.2026.10.20.00.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:29:28 -0700 (PDT)
From: Elia Pinto <gitter.spiros@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	Harald Nordgren <haraldnordgren@gmail.com>,
	=?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] status: reword message for a missing upstream branch
Date: Tue, 20 Oct 2026 09:29:24 +0200
Message-ID: <20261020072924.42026-1-gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqzew91i5g.fsf@gitster.g>
References: <20261019175722.5223-1-gitter.spiros@gmail.com> <xmqqzew91i5g.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Ahh, "does not exist".  Clever.  That does cover both cases and
> reads reasonably natural.  If we wanted to have something short that
> we can reuse elsewhere (like inside [] in place of [gone]), we could
> say which is "missing", perhaps.

"missing" sounds good to me for the short form. I'd rather keep it
out of this patch, though; see below for why the bracketed label
needs a bit more care than the long message.

> Do we emit "git push" suggestion unconditionally (meaning, does "git
> push" immediately in this state always create the "upstream" that
> does not exist yet), or do we have to check if "git push" will
> create it before saying so?

We check, as the next paragraph of the log says: the hint is given
only when @{push} resolves to the upstream itself, and push.default
is not "matching".

The check errs on the side of not giving the hint. For example, with
push.default=matching but an explicit remote.<name>.push refspec,
"git push" uses the refspec and would create the upstream, but we
still do not suggest it, because push_creates() looks at push.default
without checking whether a refspec overrides it. I'll fix that in v2
by checking push.default only when the remote has no push refspec
and is not a mirror, which is the same order branch_get_push_1()
follows.

> Does this refer to what wt_shortstatus_print_tracking() says?  It is
> _(translated), so in a sense it is a fair game to be improved.

Yes, and you are right, the justification in the log message is
wrong for some of the commands it lists. Looking more closely:

 - "git status -sb" uses LABEL(N_("gone")) in
   wt_shortstatus_print_tracking(), so it is translated (e.g.
   "[sparito]" in Italian).

 - "git status --porcelain -b" goes through the same function, but
   wt_porcelain_print() sets s->no_gettext, so it always says
   "[gone]". That one has to stay.

 - "git status --porcelain=v2" never says "gone"; it prints
   "# branch.upstream" and omits the "# branch.ab" line.

 - "%(upstream:track)" in "git for-each-ref" uses the untranslated
   "gone" from ref-filter.c, which is documented in
   git-for-each-ref.adoc, so that one has to stay too. But "git
   branch" (and "git tag") call setup_ref_filter_porcelain_msg(),
   so "git branch -vv" and "git branch --format=%(upstream:track)"
   show the translated label.

So "scripts may depend on it" is true only for --porcelain and
for-each-ref. The other two are human-readable output and could be
changed.

I am still hesitant to change the label in "git branch -vv" as part
of this patch. Translated or not, under LC_ALL=C it says "gone", and

    git branch -vv | grep ': gone]'

is a very common recipe for finding branches whose upstream was
pruned. To keep the porcelain output as "gone" while changing the
human output, wt_shortstatus_print_tracking() also could not keep
using LABEL() with a single msgid.

So for v2 I plan to leave the bracketed label alone and correct the
log message to say what is really going on. If we want "[missing]"
in "git status -sb" and "git branch -vv", I'd do it as a separate
follow-up patch, where we can discuss the compatibility question
separately.

Thanks for the review.
