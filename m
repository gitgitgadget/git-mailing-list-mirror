Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BE2267B07
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894014; cv=none; b=c/qQIhqNYKyLE9hwm0xqFlzuqMfbbL987SQ2yg9gAffCXrQh5N9k4t+Zk3Pri1iRJ/JIMXc0AqLOGVPjB5x0yFsWXojA4huZoYO5pfdVjoUvmYz0u81FVKy/HcXK5sdXXB6+7ybtfNuSetotcrAmfcFE9xkS/EFnhN54bfSYxEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894014; c=relaxed/simple;
	bh=/AXPkqVi2CoAG17Z9q9u56J0QTYWGnGLTX1xGfFxjRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AUqRD739d9Aho+h0XdVWzNOYt76oy5RAhNe35+21OeKr0C4hoNU/xztJsNpAjSTgkXbYtPdxXSv7hLp+wmyImfKgwpiKck1Eeu7vNW7RDCsu4rRrHa1MBtYixvue12phBOxSiuntPt2KOp/JjdgJnpUH/KNaBndk0pHQFHch0vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxOih4B+; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxOih4B+"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-91a57bd6efeso600710241.3
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758894012; x=1759498812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cnlq66arSc3lZu5bGJYVO4SQBuSdWyrJEf4GovFUng4=;
        b=WxOih4B+RcMsnNBsLUoFjha27wZgzu/3YEPN21TkfDieUIRJRLSI4gkkP6qg52wx1a
         iRBJ6a8EAmA6KBwl1azQk6B21Rj5r+3PAJeGAcTrQYtIP7xo4mzm/6YBwg5YXTpS72i2
         JhvkNfedXAaW+KoVzDvA9fuymfs3eNARkY7Bg+p/rmEpecyz4zOng2tjeqf6VALFfw6y
         Ak/RUdXNN6ed0cQbARSjhIsRjtIvEfQTVSH+byAJ/nmHT1eWLgpejs9+5vpgsgV8zk8R
         fKpwXqThAF9z/7HP4V3I8P9GOg7Gz9dNN12kiFPjEqZAqxH8XLDp/9pbajrlbwlJ1URe
         tw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758894012; x=1759498812;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cnlq66arSc3lZu5bGJYVO4SQBuSdWyrJEf4GovFUng4=;
        b=XhsLopgEUuYxNL0I5C1RvUPZI6AX/ZxgrdFSSCLJHAcUKf5yM2TApOQa92ZwrYHboW
         bMqlihEsERp3qyLij8GCVf/vSNJscI5nuLTNF18Lf2VGU9EYD3QiJeYsgi2pH03NPQni
         3ODbR8Ih1m57M5Nn1XoGeN3NHM9GAKlRrbNqcdGHGLIDcpwDmlOJ/KsfNNmvAqqRJ5Q4
         AU0R2r6mQ+jEF0qJcx9M2qs/Wr7QvY5usYOUeQqWUMH0eww0zlVRYThErBJjZA5dDhM6
         Tp+v1ESWw4I1oxkUS9VINwpcCo08Ly486/4qLdK4Z6pK9vQGvEYqA5JFOHCnp+J/nn1P
         RH5g==
X-Gm-Message-State: AOJu0YypmNdwdXbysgS8wMdYHgCA7JDfhglce2Oy/cdHcEF/RSrpL3c4
	bjqnM1U0bpG7//zxb+oj1fjAgPqrID+eDnWSPyNMCD15gnfj7nTJgTZI
X-Gm-Gg: ASbGncuowKakJZnn82Ner4dFw3w4m5WZ1fRek5yqWQzzQ1RfNHl2ZQvQi0rk3ruw1ZW
	NV1p7Rly+nVmhD5wZvSZGVxA1Kl8MPBnC0ZeV2XmyYZsRcW+qVnT68g5oPQVOHdm8SjGhT7Nm/G
	2saAyF/iBH0UlKj7KH/kOjrfIkhsmueovdNNauobYE7UYUf+iT+w35ihWn8xZAvvPBXOVB4aKTI
	exoaqTTnj15YJN1bBw6OwEco5qYif3rwN9XMk9Q/Cheh916V7AAuI+6f+mAAf1jXfSkJunoLlyn
	kAD8dM94jINWDPoiukLq+WRmG8/QW7NP3gq91I8UcgRWceKvvnmqIumC/N2xqvfHG+DEt1ym1+d
	rrvm/uUl/OOez9aLXoNUvwMF6hmA9HzuFxRveJhBpk4X+5UuKHVoRTSG6qgEteFesq0MCv80=
X-Google-Smtp-Source: AGHT+IE0SwEyjhwqoR1Iv9vxfmNtZ6yj76amZ71ZjGWIdeN4CUIAPFouvvKUonw0KnJDyQWG/TH/LA==
X-Received: by 2002:a05:6122:308e:b0:544:9414:105f with SMTP id 71dfb90a1353d-54bea0b83d9mr2910658e0c.2.1758894011757;
        Fri, 26 Sep 2025 06:40:11 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:74ae:976a:4e3f:7fa? ([2605:a601:a6de:d300:74ae:976a:4e3f:7fa])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54bed881ea0sm897680e0c.1.2025.09.26.06.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Sep 2025 06:40:11 -0700 (PDT)
Message-ID: <71c5d266-18ff-4ad3-81a3-30b9a1fefde2@gmail.com>
Date: Fri, 26 Sep 2025 09:40:10 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] sparse-checkout: add 'clean' command
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
 <xmqq348rodiw.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq348rodiw.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/12/2025 12:12 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> NEW: This series is rebased on a recent master to remove dependence on the
>> updates to the global variables used by the sparse-checkout system.
>>
>> When using cone-mode sparse-checkout, users specify which tracked
>> directories they want (recursively) and any directory not part of the parent
>> paths for those directories are considered "out of scope". When changing
>> sparse-checkouts, there are a variety of reasons why these "out of scope"
>> directories could remain, including:
>>
>>  * The user has .gitignore or .git/info/exclude files that tell Git to not
>>    remove files of a certain type.
>>  * Some filesystem blocker prevented the removal of a tracked file. This is
>>    usually more of an issue on Windows where a read handle will block file
>>    deletion.
> 
> The updated documentation was easeier to follow (even though I had a
> "Huh?" moment with "Opportunistically" a bit).  Comparing with the
> previous version (with my rebase to get rid of the dependence on the
> other topic) and this one, I see a few more code paths have learned
> to pass "struct repository *" pointers throughout the callchain,
> which is very nice.

I'm hoping to see some feedback from Elijah whose feedback on v2 was
very helpful. Here is a ping to see if he's available.

Thanks,
-Stolee

