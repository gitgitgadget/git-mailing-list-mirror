Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794085875;
	b=LSa/Fnc5iN/U5DHQ1NvPQrHQumbvRf5oz+rNFo6v7LYnzevnUWoI3ibPnrbAw6eKdzGW
	 XCWx7rJv/cFB2Fm1Mxp5O8kvd86VSzOhIeyhdAg6NQqHPNd88wS+G+VVfqbOhMot4PR09
	 Y+CCdc06UfoiIsbfmZc4LP15Vv9A+TxmrIkFh7OWaWdlUZJ3C9VlRT/opuGhnC6J9ZO/n
	 7zMotkZvsytzVmvLE4WTusw6d1kp50VRJM96D5dPjDGra1j/HLANe+FDMxN8jEcVO8OW2
	 E7/n+37vjHsexo+UZzhmqeV/HrW27XXOahwRd2PlEtTl2+GjJW8Ph01FRD7uRLBXUNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794085875;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=1kfSisbQylpCbT+K6GwaJ0J0zdzgWoYDzgStDrosgDg=;
	b=hVkcnsv4X8W5tv+ct/buLvTWapZx4mDwsbPA/S7OaLJid3oq4nV2N08GgeIO/VUPNxHT
	 ncPtNSoDAR3A/UD48L3E4QoJDj5W38DCIkTj8omSZ+kLI4adloK6qzj7Sahu+3n+czIfU
	 LEzDNlIbl/fWZXVw1HPdDPi98akbb9S+447m0gw1kMNf1ixX523T6XRmxX20VqwOfSXvs
	 HjXBrcvu3fvJBFi8moxE4x9E7XWaozlI1VnyllNMsinasKHe5a81z/nQwJbG9NnQUOyGy
	 ThtwwIUsbqx61VXrmWJixakgh4qPE1ubRA5raxRcRPJbeCVz52MJ80+UcmCHGu5Eg7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="cm6Ek/l1";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.47
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F6C606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 21:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4F6C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cm6Ek/l1
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4ad587ba293so22666fac.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 13:11:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794085873; cv=none;
        d=google.com; s=arc-20260327;
        b=MqxkQZLYWCKrznMjLQomfFFHvr93U6dCWldodcHcDFMhrSvel1OQgUSXkwVAmiwkpo
         ORZ6U8DA+u6CHHwZs4AR2kum1KWJtQVJVoNjZWCHKBXx5MalyWdUjpW+GoTTqhozSbrN
         wsIFn6IOUfbCqbV2XGxmKHlvaF9nEUikaytfeIi+SGqqwbz+wP42yueRehD8bgGNaLtD
         kJtV7NVPU7bKj9EXhqQWSJRuyEz7mjMrBs1tYP1HpCpyoI/dTjUAcv7MQGpjwmnIDdDb
         s7fuXIpXre+X06lTqR5sCim6js3Bh2wTMB3SG7j+bwV6j4XUZ0/QaNJywr9/Xjhz6V3y
         N9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1kfSisbQylpCbT+K6GwaJ0J0zdzgWoYDzgStDrosgDg=;
        fh=uLroqYqcx80GBCiwIGXxfGNsg5J6DEKTsHj898AfvWc=;
        b=LoRNYbYuklGcznpfpGilm511GxFkXU5fYFac2tERK6CMD7SXl/che84Y+Ww/QHgsFj
         eon8+s8/TM2Y2bVcaKLbMuGszlA69WO7D5SyCi7TGBfLMtEULrXkNFnrOHBup5+sIz+v
         ox555vN6hga0nc73Wx5vtOEn16c5o3gJqd40IPlNFD2oJRrtnvxlwxOdTXqe0cXc1cnL
         Vcui9LGS1kBjaTvn6CPVk07CL5qLK4eKaGkuXE+IANOBvMzjzORvxfUYnIyFHHFhP7Y2
         PHAtP5CJrza6HnrP6KXyNhOZyiWb8cNjZUvOjO0rStavCHRpAN3oSvLzXMCsDYqoOnyN
         RbZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794085873; x=1794690673; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1kfSisbQylpCbT+K6GwaJ0J0zdzgWoYDzgStDrosgDg=;
        b=cm6Ek/l1AVcebJrOAVwE7nTUuymRfg1ejc6mVJLAdWC2NC8nrxfVqJrq7f+X4jt0iA
         96sMvqGuZQfcrH2jNkLBKproZ95K2S7c0P7DA2ZpwzSJkCm+V9w2o449FeNe7KoYAN3V
         oaWiBSXqYDAbCFOkj7v2ao7HHtKMBF5He2L6e31S6KZtWOaAzGOxDUOBhitMtOpoVVVv
         XWOvdzKYDbv1Pl+Hw/e34bXMyz5SjIY+Jc0pozgyIQi/7plebwNGu5G8uPCE4DtYjgO6
         QOAF32FT7nmr5Q7nWGBjIfu9XXxsBXC4KsS0gestlsGnzfPH5BJtkeRd3Xfi1FKvGQ8y
         JRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794085873; x=1794690673;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1kfSisbQylpCbT+K6GwaJ0J0zdzgWoYDzgStDrosgDg=;
        b=J8dGOKDPKMK2SkwQEu/l/Jg4ezcnrez8kVSX65/GcHX6vkhTyL9/qMZkBC+tsXvi66
         0HFZLu47kfUp0z73EAplb+VROq2qvUMZg7jTzn6BDlCVWkDOQdwSq1JQflfGhM4RnPDd
         RuYdoYfCEU1LpyD19K0Q3wJ+qJ4k+15XchIHO3NF6DFGhOWB7XlPZ6p2wKGl1brHFZn2
         HraagJEMUH012mxovrrBzN1vhcEJINh/SCdXXrtDcOh82vArYptaSFQKg6APxm0RZNv+
         20LQKJ8xuA+C05wJklj9oXX7ZiAnPrGzDAcrM/surYN6+5Ihtcczx7HA4JKIoIQmc3Rm
         V9sw==
X-Gm-Message-State: APuU4Z8EGm/zUxvM16M4aCe6Lu10yGcwbydZWZwTsduJdbLL1g3GdXgP
	GOLDp4mA3SU5PT/i6Gf6oW6Y8Cj3h+ypu8WAYowBLamyIDvJpcFayjgPFUsoTuQhg/G1fyR/jG8
	1fJrLLEqqiH2jRTw6yKWegUvvCIPTGzgF1A1S13RG8g==
X-Gm-Gg: AYBFou0Eyzro19UwWjiTV4iV86J2/7nltwSwz1pZjkCSehiXFj8jTN6zD+joF2Y60ek
	1mfAxsQSH4Qx6zkXBiLzQb57ON9zDjNSTMM4u3rfU1FTSVswvRLc4wgXlEwlyWXQbPKvX3ZoBa0
	r/BsRLSF3WZCx5x3U/W516XWALyxE1sE3SUBOauiqRomPRAaOWQismnd1T3sTwszJZU399VVdoQ
	rfvCAG6Gxun5P35I14V28c+qtlAItoIyeOyFzn/hD5T+bAW/yUBd44OYE5OPXECfrVZn/djKgvX
	284UA4u0b2rZZbiF96Df54hpMhdMDHVae/Hk3suE5C985cRhSoHnuvwqQCtqQM+P6pdu7ob9LRa
	4ZxALzxdyLq9VWlNS/r0aU4Gsf33ZGQ1vPbe9omEWXQY51SaREOBEHNggQoEOtrne5tgKPVtC9W
	uK5lkzbqB72cLm9/2MWy56gCnqWfeo95TQH9Bt/ro9oRZjs8VmatY8
X-Received: by 2002:a05:6871:c920:b0:488:5278:e2f5 with SMTP id
 586e51a60fabf-4ad98b4ffb0mr3561100fac.30.1794085873591; Sat, 07 Nov 2026
 13:11:13 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107121119.2995843-1-andy.koppe@gmail.com>
In-Reply-To: <20261107121119.2995843-1-andy.koppe@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Sun, 8 Nov 2026 00:10:36 +0300
X-Gm-Features: AclHuK_3tbBZ-6zRwa3vAK5Wv6c8R-FsCeqLclbodm7Au5VVUgfXPpc-QsWDjvI
Message-ID: <CAKrRMNpaBrOybe0hw_B+RTZ5GWeUASpR+sRte0OLL2x6xJba8g@mail.gmail.com>
Subject: Re: [BUG] splitIndex with skipHash corrupts index and crashes status
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

Thank you for the bug report and the clear reproduction steps.

I was able to reproduce both cases on master (fb255012ac).

On Sat, 7 Nov 2026 at 15:16, Andy Koppe <andy.koppe@gmail.com> wrote:
>   $ ls .git | grep index
>   index
>   sharedindex.0000000000000000000000000000000000000000
>
> Note the unexpected null OID.

It seems to be caused by write_shared_index() naming the file after
the shared index's trailing checksum. With index.skipHash, that
checksum is written as zeros, so the file is named
sharedindex.0000000000000000000000000000000000000000,
which is the file you saw.

The entries disappear because the split index then records a null
base, and read_index_from() treats a null base as "no shared index"
(read-cache.c:2381), so the entries stored in the shared index are
lost.

I'm working on a fix and would be more than happy to send it, unless
you are already working on one.

Thanks,
Tanga
