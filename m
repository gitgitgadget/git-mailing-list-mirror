Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794129129;
	b=hn8ixqeiWseFDiL/fyrRlg6TaaYtpLMKx02xRhR7A3XS+veXLKdUhN5HcqpDYx9rqZCN
	 1ejFeQU0L8A6lTdsKbgUZN9g73gdz8v8wI2JL0XaPhk44qENh+DFCp5RDhUiKBCaNEAuM
	 JbrfI0MDq3tfW1L3FM709c+wtQpikurRSeq5AnLvgkNexdH3HTh3oTXqOJjjNnS5kMAY1
	 OCssdxyYjIl6foN3xTBg4XdTSlINojMUdipprKhpSstEWWwCrp2cPN5UaN4W0xUjjk4NC
	 tdC+EhoSrSS9KFCAtCL5XGE994TKOzxYsKrme3qwK25SV8Sk1mYRhGmat/6WyhRAF9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794129129;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ismZUmLm5VyVmSaclLKx9RFnOSFPKE/k9uHFxNVRl7g=;
	b=YHT9HoSBB/tOQzNnpZniQ89TJaaEoId6/LIQEwfdG20bgD8jfTMYjqvn5ja3Gy1K1a3s
	 KfcWFKAfLuPXczMVaOGLK4VXeN/qkonRCro6bLaprnMrZgqnQQWoQytFCIjbJ0wKoP+WI
	 k2sPRdH8LMYqOM7DfaL+gEYU7ZcJ72lfcvPXCb4rSoKf0D2j9ZhTQkdp8bxhO6DFjyHWd
	 F1Wg5L13MhWX7a2A6VZ05U08S++ybSplyWM3hjC7aorsEYszXx2K/RjlEkNEBgF8BX/GJ
	 wZP9LNSmCmnc3c708QvneD7ueL2RwDtKgPtbeDG8Rfi8UBqYIjaRtWFgbn7jSOGxriw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=PytS2F31;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C082606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 09:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C082606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=PytS2F31
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4c9abc1824so125166b.1
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 01:12:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794129127; cv=none;
        d=google.com; s=arc-20260327;
        b=doRemBJm5P/nbrzMTaNqHzkl/Z6j3o367Q9tvC80g27oBueac6IsT5nO3rnxs2tZQb
         RqHObRI3XEaAHTFxcSTEKdqNeVfshoRghKH9/bRxahYgyXCjbbKYj0mcrwYMyTSoXGdY
         xRSWCjdeSTT0pPH/JaV+tmxtLo1dvD151ApiDOuIdES/3j3svOhoUd4jNdJfAbNLBYDE
         puKu/5HI811qZYb986Fl4O5Kj/tDQyZw1vS4CrO1aaKh9+L+GftxG7lXbHc3kguUkX4f
         fmGRNrj4ftjLYb+UXdrBQgl0qNCz1lDrJ4JDHKwTbPxASqpkSjX2ayTENTU2tndXzZqe
         Kaig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ismZUmLm5VyVmSaclLKx9RFnOSFPKE/k9uHFxNVRl7g=;
        fh=nlneC7k9r42m336VNi0MB6vpxqEZQ/aKjgrc+eRGtjc=;
        b=rNq51UzNK3FIv/yHni/iHTrlSIGT8robfguDYMCOnuz8UVj/Bzmez2Vggw5TZn6dIN
         NM7l22bIG8W6W70+OM1Wh0BA7uSbzTKQl1ORDRb4YWS3qLhPtnaMgVlN4OSUE9PKq9S+
         RS2iS2pbkN06+zJnsqD47qZKExqJYdnxWu8ZNBTkcn3ojmPMqdE+we0thHMdaS/0l7I4
         h8RGBGGaq0VVsKSQqZO1hA79Cvo9o7+j3pp2kiMHCi/ti9M/oGubkjAOMV/EzX2e7v0N
         KydPdbbgAMAjdcrTsl1qJ2/qkQG3KyRz9zKg3YAVR09KLVUF9dKRVV6TVlk0L1t76AgI
         tiAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794129127; x=1794733927; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ismZUmLm5VyVmSaclLKx9RFnOSFPKE/k9uHFxNVRl7g=;
        b=PytS2F310Yb2skU85Cs9fXihWGFJRFSHZ/NoKlawIzvIyIYgnLgJouOtWXSNIolh6o
         4qeibqf01zRPgsP3NVdAms0D/cJ7V1jw6XLso5Kd031Oi6fHcZVH9mOsHZRC1Mv5OENM
         ItaLdAG/mCbs7fEQsUtVHQaprvCF4vTz9xu0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794129127; x=1794733927;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ismZUmLm5VyVmSaclLKx9RFnOSFPKE/k9uHFxNVRl7g=;
        b=M4h1x4onpnvpyHijMh1ZM75SJw242jSR7gQKP4scGePqpQYt9NfEbs+s0dOmoltXG5
         QLAoyIc0MriVmnswcofd+ElaGUcagsVdPywKMSLPAQ7ogNt+VG6/acTbJv/Q777wU5op
         9GgDg++YdC8hUH1SZmKfZoCiSQ/lyXH89GiQhM8S1h19y1aYb48qX7ROgYU7GCFchj52
         Tqy4SWDJDfdVkE3effsn1iSC/C7SQ9nW4t/YiqjxvGx0wM4pF14H7Ba4NC8nUuO2LdG+
         A54DROiNEx+Cs7hrkXGhkUYdVn6bFawCZ1yWwhW5LlY04tDPp53q13NnLMN9d1qmcl/m
         G4MQ==
X-Forwarded-Encrypted: i=1; AL+hErGo2oKiicYjTRVh3i9DH6PjjUDgL/Lj3NBaL/Y+Q/hN1ir9BZQQQ954Wf0xQzMl9XjdnvY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8BXqZ3Br4MBYy3Wf2IaDowOmD9FgrrjjmWqrgzqnmK0SV2ngk2
	Js1HGClNFvn/aj6Odm0PdoplIoTEiSKNg8JBgkRR0qea7pkmkR3UvQL8eJfRNeAYkZuj5qOwRvx
	HbXevgzz4z2Lkc7ctLzF/vsR2QAZfRG2DvkbPsWAu+A==
X-Gm-Gg: AYBFou1zS9fZIvuyIsQJZGLnqsG68StG1MSkJx0zC0FD1SO+kNC384DgB3FCKvctK2R
	he7VKp5biIGAhy5AByzx9VNV8oqGWfI+rOz6ekV0hSGqWe3H/NAtDN36Go8OhK/tBJ40N3q8mW/
	C8cuywhkaeSFsm5t9IvSfYw4ayeyTdQQL9Xe3OUOvXI1ZMH02VUSXhpQuCc1+bBkEVwXMGbQH+R
	N4pTNHljGYcl7SNSAeouucNlBIcwbpBiNd1Gu6dkefNrIxw6JRR7IC79cGXRfrYwE/KDPqdL4E9
	JkCQD6f+UC+j8J6/6WTRhgTOHr6f82+wuC9CNs9La7p5Rtm8fBly5GTzexkDfEbtywGQ2d82UCH
	VgvqgxGqLex42P/4OjLnJ1lsbjOFFBopEzNU+hA==
X-Received: by 2002:a17:907:f815:b0:c4d:167d:dcee with SMTP id
 a640c23a62f3a-c4d6db1eab5mr77342466b.40.1794129127440; Sun, 08 Nov 2026
 01:12:07 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com> <xmqq1p8w9rbf.fsf@gitster.g>
In-Reply-To: <xmqq1p8w9rbf.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 8 Nov 2026 10:11:50 +0100
X-Gm-Features: AclHuK9yWQuc4n73zY-vV_0XzweTTXxVB0ts2j7RqCyOjGodl_qh5F2SNaFCtYk
Message-ID: <CAL71e4PXCY6bDEW6LyXKkskurzRTjbfK_zf6DqPiRMVAt=Yixw@mail.gmail.com>
Subject: Re: [PATCH 0/3] t: add "test-tool genbytes" to avoid slow tr(1) on macOS
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Nov 2026 at 00:04, Junio C Hamano <gitster@pobox.com> wrote:
>
> Just being curious.  Would forcing C locale on it help?  I.e.,
>
>         genzeros | LANG=C LC_ALL=C tr ...
>

No, test-lib-functions.sh already sets those env variables,
but the macos implementation of tr always executes the slow path
unfortunately.

Thanks,
Kristofer
