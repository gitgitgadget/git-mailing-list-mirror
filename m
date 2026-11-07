Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794045618;
	b=bWllXkNFF0r5JqVEeCXGubOVfqH92T2whINsNhOZvwfNL6gaV1qlxKLuIHZw2GH4kWi/
	 rYTVjqD5PgHSILcM1fYzhsswsn+rOmwoll786eFcdpiAryVbVuGtrompMDPIC5HaQKyLy
	 NzL5jveGLl4f9w30S8a7hJOT95YQYMJV0whKQkAjAkNk2k+MRzFlTXg5Eg0qXzAyT2efL
	 iniH7clT4GByEmdeEx4/XHv8v6KF4H9HBXTDPrYkyuaUA/I/7NBsl7DoTV9gAakHqSwNS
	 wyVdMxikDXPdqptVRlmL/tqxDhVEu55gJz7UEf8a5l3hZel4ftR40LoChjaAHDWIc0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=A7nUQoSuPweirMTqxonWsCi2E/cnbOHkhZVEdNW9WfA=;
	b=VlWd9+8dXlNZUs1WvNi940R9Fk+J6/JSwAPZslDpN7kV8sqePGDaB9xHercdpHb0qNw7
	 F/nU9FBFaPlOQzQzkxRv4/We6WSCtoDIH91dqgUi+el1dOtdF4IgHi2Ir/q5olhU3Du9T
	 HkaJml6pErnJ+JuIdCQ77c6arJSzzJTNgzdYe4EwzFIGnnfl5kw/KuiH4amd2cZ5qsrxJ
	 aePLu7RmWyxdDtpwUwE6ing/DYmaFRud9JQOmhT4WUXxCIqLByykX/eZ4AFcpP6m2Sept
	 mNi23fQn/jJca0p7/tr7AEFSEBXj2RLXi91ARMLXRgKKpp2sPz1UU3p6cy4MtUuFLzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nZu5n6Xp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75710606A32D
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 10:00:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75710606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nZu5n6Xp
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so2231116a12.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 02:00:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794045617; cv=none;
        d=google.com; s=arc-20260327;
        b=bRFeO2hmsnyFQdZ/lft9yD5yKkcGom6jdwgXQ0puVhO5l0eLgbcpMYEbf3zTAObD2m
         QZYJcjE8vhRlovLtLiDEBT7IMllEnXCpp77PIbn1gEnq5sC0aGsnSCqAS8U0hbtSmXDH
         YP7bjeg1kbZOsF6Fion7nNuNtuYlXk1tjRGha3nMj6C11wsU6Itjoa35Op3QqtonLRCo
         gh6hkix9+YhoqAT3aHAPes8lkSDejVgFxcdBHjUi7ZoNAWcq3sM+Js+9D3eidOx/G8X3
         EzL1t79tXa/zwwjq4UQoADwcKeMgYE+v6LmynssMS/nrvXc2LKZkaAYq58mk6dqU5cux
         JpJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=A7nUQoSuPweirMTqxonWsCi2E/cnbOHkhZVEdNW9WfA=;
        fh=+F8YtQEFwZBcMGKUq4TTYE667BTYW1KPCZdLl6K6U3c=;
        b=K/rljba2Cegmt2Ljy8jQ69wA15fExDweqKGWsPRxtDUctrtYAGA10bHMq6DvbpKxzL
         X61NZ8tmqsAKjbZeifilswflMjfqPeReMM2ZdYFpL+s/YD1g8M8YnqM1nBmgQLXqIOfa
         VgLvSHWn33jGQncq27gOvmYSjavUvekjtx8Kfl2CVY8KbvXJfms8UNBDlSlmBx3LwpU8
         T/rFbi9nmV0ZwDs1wOAOZ7zOaDpB4no2VL9nZDZD0n9xZu45NYRx8lSvIcoD4cCn3GPl
         a9OjHddbMa0NdIUMtCDMDQTHAj01t0AKAFat/vRjk5C5ftrSQs8n+/qDlHTiREfiY6Vq
         ycWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794045617; x=1794650417; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7nUQoSuPweirMTqxonWsCi2E/cnbOHkhZVEdNW9WfA=;
        b=nZu5n6XpRcwYFA5Rq5JGWIvn7X9FJb6YvTZYcOOyxJOG7PlcvvYbxfOodsl7pAqe69
         C2RknIZtVkAnMmgCBtSRa2WB9AFzLFRbdnFRY8OO7XRTVSvBFioamuXfG5Iaf+HYfWtK
         Gi0Dcm3yfFGfAx0/J6/8dbQt4g88Ow+n/tauJTuQxP2xOPiqXGtQdA+n851B9U0kKtwK
         zMI8RxEhMb/7AwOxxxfbZf2iSekB/DxmZz5tmRyXAogFZHaH4oHRfOPlekUQ7fLGIZW5
         M5Ih1XKX/fFjcIi8lRPRGI42gmrWoG8JX7OOTVkyVGoEGa8i29xwsXtduIMGqKEx1Ja+
         7mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794045617; x=1794650417;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A7nUQoSuPweirMTqxonWsCi2E/cnbOHkhZVEdNW9WfA=;
        b=piQoVlcW7AJ8tYEVvq8NMhEhSNkTOU29GXR8sQCwrwtIhiANQPpTf5/5f9ZPBnfkz3
         vYY3QBsZnxi4HQnQpJGxlyjk2DrpDZ1cpqqsFa3k9glshmGxIdoqcwXggEbRyHxdfBAn
         ilQoQRK9JODn0O+KRNYwpc2CeMACp2Lxd20ikFcNpFZMngNK/vyssGeYGkMGPJWVNugD
         GQXJVeUuPsb5x23+3rCLztdATAIx2S4vEwNFpBhSxcoXiO5mBZmZMACxHH+exPG2AJTZ
         N3UWZy4K2YkZLUH4Ouz6x/Eq7aXqxu9w7M1zcehJ5zk98679L+1XLNZZ1PNdFOHIsdBt
         VPcQ==
X-Forwarded-Encrypted: i=1; AL+hErHO/AygY3Bag1DBS5L2hKAFmmeqY680Sr19DEBKOXBz+EU0TvI9bu6N9Q5gPeoARGs5Pf4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FDHGiYylj2hmdDAA+mIskIIm2TVzUry+Q5GW3TkQU2+alUjqu
	lrIRaVtJTuYgOv7xrGxT0WK7O0wuQjI0b6Y2WkmWDJsyzAZLxDdu0ATawxnb+rvNCe1R3o66Y/W
	sA1lk6+txftcsD9KjPP35jk/Ig9BYIJ8=
X-Gm-Gg: AYBFou1AweEPWO7MrA+h6E6iwFNRSL5s7eKfDpRN856/VkVLg1oKI4UwTXFsDBkg9ok
	ifKs+MZ9s9QZNf1Po3rl/CliuplUylu9+pWr+66av1HyxhTXWT7bDYpc+Tw4QZa0cCaF+m5iDtJ
	pyQN3hcuX4cZgdqpK89XD8rXNo6eGI1dPsM2UkC9rzWt+41nk5LGZaFW3vBWD2s+m91fW/l0a7o
	rT4j2D4nltDl9OobgEhbuQlkjEVBmI/GHfMpCVDvmgh9xIdFfVViRPnlGEpWmB7wCRagMu4p3vs
	hDMJD9rN8WJyQ9Y+O24tUaKJRpsRQIg8XvSuqLDclca3LbMsvuJeZVQ0K7YgjsWc+9TljkLhtsO
	NphuwGCwZeH2ZYw1y5QpUgCtUwMIAeDFJZhgS
X-Received: by 2002:a05:6402:2348:b0:6b7:1c:eae6 with SMTP id
 4fb4d7f45d1cf-6b7001cec74mr661946a12.10.1794045616695; Sat, 07 Nov 2026
 02:00:16 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v4.git.git.1793826938.gitgitgadget@gmail.com> <edd1c36a-bd2a-4bcf-a6b1-3e08dfcda344@gmail.com>
In-Reply-To: <edd1c36a-bd2a-4bcf-a6b1-3e08dfcda344@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 7 Nov 2026 10:59:39 +0100
X-Gm-Features: AclHuK-8_FxawT9hxBChIBXpul3gNmH_uXmBWzA7vkrByhJ3bQW6tydMwvJlB5Y
Message-ID: <CAHwyqnXNjM03XgFXtbLq-QH=ABdy2T2U7tfLDucezkY2EjTECQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] reflog: add format %gb
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Good point, and thanks a lot for the failing test!


Harald
