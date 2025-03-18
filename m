Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71838191F92
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317336; cv=none; b=XvE2tJsgkhb9z8YkyGqp2l2JZYdVdX/dez1hMRqgGdrzL8gZ+QqLYVtyCUmJNUjXvJRfseZTB9856VRTlprCp/5P2yoTp6BrpNrGENkEcqRf9BuvnLtHK8evTmDI/k9klWgWrZFjPaIfX2WDVKb/e9uRd3jWEKWGLHZg8SnCleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317336; c=relaxed/simple;
	bh=/GEqP6967RXFqRHmIUwWEEJHCG6xwKpWDb0n5mJIyDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGaz+ZN/rcdVfYpIHnxbg73vqTkwntvrrgXQ06rYQXget8Z0ABXeIV8OoExBjjsppDSKcIHvjVTSYUiMqvwVGEZHFhp14O34U+Nd4/qkVBoGH70k//IPtlptqVGWtn+BM70qD4pj0OtR6ZQd3MQdtVeWZpZ5ZT6Iw6bMdULJBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJSFoOyO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJSFoOyO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso17824345e9.3
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742317329; x=1742922129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=omJvNua4fr1d7IhlWS/0cEUm755WAhX+R4367SucrtE=;
        b=LJSFoOyOGKN1JumRAJPAwkkGrxmLrV9n90BjThKNqJ4eqPrlRt+1Sqrd/WcBHt4zY/
         hV0KrBTerze+zNLP9Q7+WNJb8pHIDvoH8KPNg4LtU6CFb5jdu5QAMCi3b7mAAGgpQK5f
         6LZScmjh8VMaDl1NvP6qmpR7Ql/xGlnid/XGoeTy1C4UKPz0bW0yNqSUviYrBDEeHBYg
         5EH9Siyk5CV8E1FhcOvWjrmirGwF138dMmwHG5qg5pjDNwXEJdVrIVjt8vDK4rCR+IqG
         DCPydIbzcuVsNqRwhHf5bb/+CQduq1YwiccKzZAZhiOIM5nGkGlMeVeBrUWAxofPSgpV
         d3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742317329; x=1742922129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omJvNua4fr1d7IhlWS/0cEUm755WAhX+R4367SucrtE=;
        b=KHiWYTepyfK2haGXFSZhsBX3RcHCf4cCvgNuCIVYiKcApNDFkROa+xhwBWAUz2leKS
         eg0YxGqiHMcxmxt5mmy2NC8NKE2JWRF7iAIEYOGTzJcgAAYPh+1plkseXvbM9aoXh2to
         Ug8kloBRxOtnS4aqxIvQBMdl7r4w7GgBsiyIsWwTzSz+Ra2p+jhPZC8Sl8KY6x2y43HC
         ep7yemHgLFX/JD/yJ/gX11jKQcWc1O2SX/JX9rVrirwtiG1fLgBoJ9nMOn7M9ew824wE
         Bqj/SSCtHdmVMIUIwY06UqYTjWw0fNDER1rALUU/sfK1S8KivYk8jqe3KB2HloVgKUuJ
         dyAw==
X-Forwarded-Encrypted: i=1; AJvYcCWtMurYikb4zYYe3Y0tTXwbKrgCjznVQsMMOZL9c4QMNmfH5cGIyCEDQ+v0oj8yquZOTL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84TsxM8yLk2iomarziEfzI14fzrZiOaretM9iQgB1UD88JlKu
	cTF+YcHhJ4/fBUl8EzczfVLh4B4llvYYeyTomDuFVI/E04BWoeze
X-Gm-Gg: ASbGncucrvy8tobBMoHfgQkP4pjz/TO/yH8KQqUsPN391rsB1Ow1ESpOJMV4KxtIwWO
	GQHPl9vWHrFXilaYWb62nJR7vwH98TaiQzCgm86d/IF4zLGfY9vIjYc7Qz1rl1NAAnQQ9qmFpWW
	/szufrAuWvtvKJ0KZuhUBX8y5/u8ksIipiNksa6GmQ96C6zmq2M/x67nsLqTIojB0n0Pa6NuMFg
	rkAQZeDt/r46wsDMqJg+q6vqHyP8BjdWm3dc+lVNPILpRT8GmgRURkLTmRfh8j5uODxScZMo+UU
	swvpaAmgeAgdcQKTsukIz2xSLGC/+WcvWd61LpbqUFYxXiKsZ9D2Ldc8Q9bN3FCTVmhN+XSR7lb
	nRMBWAbJfJZVvZ3tc72bT
X-Google-Smtp-Source: AGHT+IFKNU+T2sulbpkzYsYDKoAG8VpMZlNim6ZPOI5EjEM6DOMppU4dfnTAEsCMx+2npSTVnT+kgQ==
X-Received: by 2002:a05:600c:1c02:b0:43d:abd:ad1c with SMTP id 5b1f17b1804b1-43d3b94ff70mr30772985e9.6.1742317328244;
        Tue, 18 Mar 2025 10:02:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a32sm18957270f8f.33.2025.03.18.10.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 10:02:07 -0700 (PDT)
Message-ID: <d6945541-c106-49a2-8072-2a4e1b8903eb@gmail.com>
Date: Tue, 18 Mar 2025 17:02:03 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] completion: fix bugs with slashes in remote names
To: Junio C Hamano <gitster@pobox.com>,
 David Mandelberg <david@mandelberg.org>
Cc: David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <1587533591c81d38977e62165784f8eb@mandelberg.org>
 <c80d20d93c92422437150084f402ac36@mandelberg.org>
 <xmqqo6y3dzno.fsf@gitster.g>
 <015b89f8-63eb-4203-8d43-47c9a6d65cda@mandelberg.org>
 <xmqq34ffdwnl.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq34ffdwnl.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2025 23:23, Junio C Hamano wrote:
> 
> Entirely up to you.  I do not plan to perform an in-detail review on
> the topic (I do not consider myself quite qualified), but others who
> saw earlier rounds of the patch may want to say "now this is perfect"
> or "now this is perfect with this and that changes", and if you do not
> think the differenes between v3 and your upcoming v4 are small enough,
> it may be more efficient to wait for a bit to collect more comments.

I'm not an expert on our completion script but from a general shell 
scripting perspective this version looks fine to me.

Best Wishes

Phillip
