Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988713;
	b=LFX0wnzGU9ZfuSKyQ4Ju87qSNxIXgO2VcE74aY6TJmJWWD0hizMEgjGZNTyd6UicKir7
	 9EGp8wrDjRlnsidbhkHkXgmfRZNcbc6i6LVExQNN7oejYf8S0I2XhrllcCTqiDw00ynPB
	 PGyGoG3/fEFVtT/AQwuIwxipjOz4gU+RaGtaWXu4lfDjkTOAXx8hIu3z2vvHXnsRwzI72
	 tgoYm7WzGkWYV8Bg6qfcDCwsiEE0v0DUs5poY12Y7N+03dgL2rC3Vk860KXQ5Q3Ip7QO4
	 POdTtkp+lzfTLaCOBa6Y5EhJ++Yr7AE/XhDVVOIO5ltyq0ZLgJ8sQ+gkvufRDscLoaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jR1H4zpjVP8SFfcRAmUZllbP1msrA9GzjzE1AN4ejQo=;
	b=VQfz+rz9hKWLj3szUQ1hPJBJMLzSYc9YGeWKulXmWKdY6TnHgw21eW2qTWjUDQSsG31V
	 VaJHiaO+t3Q1EmJBZ9Yvu8oMBwSLDFwClvrVwsZBincztPtasmGTo99W9a/vNYFeNcpcC
	 Qhr9W5KgUXFW5xWyXC/gcdTVbJ+z9sfJWtj3hn0RcHHhriYlEKRwU3L8SrXwbuCKRoPzD
	 +R/s3khJ/37ZkWNdsvHlKzTs5iiAEfd1lM+9l+Mt2FYhYH9szqHX4IkbR0wM8dRpxoGgR
	 2VhvV2CTORYiwFhPDNccfazyJiSq6123bXtxSW5YWzIH9zhRhGA0MR9drtlcg2HatnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wIdE1AAa;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FFD606A329
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 18:11:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9FFD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wIdE1AAa
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1a2761c69fbso2164352c88.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 10:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988712; x=1794593512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jR1H4zpjVP8SFfcRAmUZllbP1msrA9GzjzE1AN4ejQo=;
        b=wIdE1AAaP/AS97MAGIvGftqfDGncC3MRh5O+D+81sIjYj8k9OlLLKAN8ijlaxGo1TQ
         fbDsNE25u0KwDvookxzb1qMQxQHlTHp1jEzxKnryKKWPfI+1w2UeIKnw5Mqbu3bTwoks
         ieo1GwWe8A8t3MBoBjNAR+OhtxUQLvGlXTPVcyGNhvpwrJLtXhInq6sTryJujVEHNcCH
         biEUXlp4Vd2QiBH9ymr9fsCqE2ByTeWmTu96DfUo/S7bYhjIV2/IcRp91EUZv8WHS1bC
         KFBtO9nDXetNB5i+u4PnRKUNSLs/JqMa3DGrO/kdfWVURUaj4s3AJatQ2XTWVjpcc0y4
         HHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988712; x=1794593512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jR1H4zpjVP8SFfcRAmUZllbP1msrA9GzjzE1AN4ejQo=;
        b=A1Nole9AhRUKQjKxR/HKzVq6lo5YowQvHwt23uc1bZwwn6OZ+Q+uDa/hKUHysPMOWk
         szSSPThnVnp0Q+F6SuDkLLGBSEwIauuQnsHkHPA9KkXYzjOdYOqMruF9Rqnf9SDEOptZ
         UXyhYQxkCXuqFdirJHQv6YfPr2CkWWFkeN5N22xAw54BunP3GEhbrEuEAhMmFsuu9Jn3
         B6oagzQIGM8ebkiSxjX2wYUoyAQ+DOhYtg0yVVNJBgghVQul0CbsqDftkdYCOcVGzx+v
         T2L/dCdgMllltQuZnYi4PKKjxSjrRvM0IVGwdmnkVNXmM3DHDNnNbrvJ1o97+ckZZ8ug
         NRpw==
X-Gm-Message-State: APuU4Z/blvNl0wGkSv5gy75wVWkrj0WgZL+0djDQqyPC+2PTC0gjkEnP
	rB1T5JM189w3m8To5iTKnoA5L4NylGUChz5qwC+9X6bNNYN751NVo+9L
X-Gm-Gg: AYBFou0T50Xe7IekYnFx2mKgM9GiARv7PF/Ic0phG2UvUi2R/c95xmMf0yCVTuEbT4c
	hzZubms+Q41E8hBBCBWE1kB/HfhVOn2MWUtTGmEnhWYQrtm3M5JJzdmJSl2mGWX6kqJbMhK4b4Y
	wblJRBnUfkBLRErVsIEKvzzZfSTPCr7PnCxjXQN+yKJ0N7MECpBGdEfoSOpjOmFzr+Dx/yvXwML
	Vq8xOwttRup6zkP7GL3VG/x88zF+0CVTl7uSx9oXz5bXLeCGNtjjiSRNBB/zQikKnIiElDlZhOt
	RxT/hDvjDEHehlvYfZ+I6IPWbqkjpd54Cwxh7A+ZO3U0k5cs9lMlJvCzUnoyy/p/R7YwbTKdchW
	9MYvH8qCXogo0vmaJ1RaM1YoVhXw4tPjOTaK/8R+l8xullobBB/dmCXt659nqJImf+nP76flrrw
	5KwkUmSjL2qhjb+yMw2Pj5VguPVasZvIRfdsrVSFa6NbvhGkkvJuBXXneo0C7ODw6EFfaChM34y
	WRnvgtI/IA66cYfV93gyon5287gyLU4iO4HEvYfjwWPRyqg0yA1dyGV+Xt03Idx+ZGvlL3rL6x0
	YEHcsZC7k+FnzsiAYHt7ZukJHJMAvWtiSqj/N8IsVkQG8bSJi+COshaG3IL3Cgo+et/3wniCEQ=
	=
X-Received: by 2002:a05:701b:4246:10b0:153:21e5:4328 with SMTP id a92af1059eb24-1b25d31ef2bmr4026794c88.17.1793988711874;
        Fri, 06 Nov 2026 10:11:51 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4c41eesm11412133c88.15.2026.11.06.10.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:11:51 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: =?UTF-8?q?Hannes=20Brandst=C3=A4tter-M=C3=BCller?= <hannes.mueller@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] git apply: pure rename followed by edit fails with core.fileMode=false
Date: Fri,  6 Nov 2026 18:11:45 +0000
Message-ID: <20261106181145.1070831-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <CANuH12niCO_tU+=dikanZ9Wf30NFsz4jpnZBXW6OyeQfD26jtg@mail.gmail.com>
References: <CANuH12niCO_tU+=dikanZ9Wf30NFsz4jpnZBXW6OyeQfD26jtg@mail.gmail.com>
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

Hi Hannes,

I was able to repro this. One thing I noticed: taking the whole mode
from patch->old_mode also takes the file type, so the "wrong type"
check can no longer fail. With a pure rename of a regular file followed
by a hand-made patch that says it is a symlink, core.fileMode=true
rejects it but =false applies it and turns the file into a symlink.

Would S_IFREG | (patch->old_mode & 07777) be better? That passed your
test and the other apply tests for me.

Thanks,
Aniket
