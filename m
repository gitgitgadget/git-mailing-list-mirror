Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com [74.125.228.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B554B95A3
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 12:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597705; cv=none; b=RJlCwVTorU74GUTSxEyYM9HsCJYzPvBxG2f7YHJsgXz33WdLEh92ioAn8hcTcMrccrBit32huTN0Z3l7lg2yUMjc1S0/sLQ6khtWN7OhVceD1FNrFW9MVvcHfoeUrmfXHPVhvqzaErqYkwsIZx72DkheMpqvmDm7KJjxW9qjxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597705; c=relaxed/simple;
	bh=E/PIUyGX/NvpenN5YQL+Rfob0w5P5Zu3XFI+Zav6eHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F8CZOoC/nnnvqbNNev2PGywPw34ibmsCRUabUenTRZqam8YiQlgY1iAQWtk4Ofh7maNPxJeOthrpp1KKW0A/LvkwMKAUjSwhfufd/9kJ4xQtZ8ga0WKfujmfkcUluDfI3+z//drlCjmSnTfTuDj5uOoV4Jpxj+Zl28ByL57eX8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekmnzBJb; arc=none smtp.client-ip=74.125.228.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekmnzBJb"
Received: by mail-pz2-f38.google.com with SMTP id 41be03b00d2f7-cc7a15ba46fso491662a12.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 05:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790597703; x=1791202503; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=grqLywWvdCOt6B6STnJEuRk9qVMTNY23Phg0UxlQ3o0=;
        b=ekmnzBJbP0DFg4YzgDbZ5DC0LhfFB3pTIyo3dLs+GdUkO36QtBHW4o9BHfCzxfN7cA
         dcX9t/kfhLYXG4SveItWgQ4jRlJwYi5T2xQH7Ktx9iinzbVkvzmgq2oVvVG/+PC10Yfp
         sr/s8Wj+Q2dS3JCvCzNHEiwNZuRca29TLokO02XLXBcpRX4Idb5WCZU3QpzIKumk9EsR
         CjCyTKqAuAEChoEK5qEPHdLdo74KuHqZvf6Tc1ZH3dntZbU8d8kJYjK3iDYD6LMkH10F
         hHmAwZWceHjTxqIR+2HQNFhY0n/Ro+z8k8Ua9U28gYfUJ33eT+nz7hCeTaBKxsH/7vaD
         wfCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790597703; x=1791202503;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=grqLywWvdCOt6B6STnJEuRk9qVMTNY23Phg0UxlQ3o0=;
        b=SaqL7JtUCPbtaI7MGaQ94LzUcd8r/1sR+DsSrZqt73bh8Me0tdSruNqgPfan/5wlaN
         PtNFq/yCagP2uKbFJjpt0LXD3sOBxgGrezdBR/x64Pqdi7PlhV6UdUxjXNnicBLY208/
         LJptn9yUJTyURjgvpKkOvu6FHjzxTSozkSFKKwzDFtf9kvKSawr8+bcDu/ttHWLdffLh
         sQUioyJl2+jOlFjTGAtCPi7zZVSXTaDo4FLeLomNep19yVdlYB2C9sDHSEdCdvaCsnKx
         llMvTSfY/eGh5TJxvyHfC0u5GyEAp8t8jxEQQn3By2tGAF04yRhU6bxuTm4Hsf+PzgUH
         rmRw==
X-Forwarded-Encrypted: i=1; AKwUvBwE2o1IyEEcyzfHZ5D+EloeEqq6ftqr2T86yqXHP3S3upKn2zMjAIa3j4jAAWSoWUewQ8o=@vger.kernel.org
X-Gm-Message-State: AFuF++kyBUysFEDccuwxGxTetg6eb1LjoH0nCF5tVtmDWebFcnseOG7/
	a87FLOr/4JcHy4POU6Xf2YEOrxc4tMaee7xkH3vS6Djd03eOhNsNuvhu
X-Gm-Gg: AYBFou0fEulnQ08JVdQ7d4nEInERRz8VM5HRLhOx/tjpG3VqWXFYCgeBoUWrCroWNQW
	sWSr6l3TmNSRBZmVtEINhE3HWTJ+M52hxRyDdPdAUfbOwAk/RWiHOleoWs5Ry1ps7ZWATcOIjTT
	ksKu9TtgTAytfkJ6hQlB3OpiVppkZH7eq4GFGDlxtCiQIoMKUCtDdvF4OLHPbJ8AvUf2llvxS5a
	3wVrZAs61fhY8Pu/hQ7X8zx1zSCNz70lxqgShJ2FIiYpwiG/gmFw9eTfI638LSTbd86TMRFVbhe
	rA2Kih+79KYCX4X8brO5TTA9AfDuCm1hS6cYFYgM+YOol27Qjr525hTnFGnAqgwxzqMJSZK3tO4
	bKPHUR2ThCpYRx2IMvAWyg6zjrjJ6V9grDQ39INT4uatg8Bn6aAFP3EfbZG/ucri0A5l8v3TfX3
	ANd42ROBx0/iDmfcYGm5ymAdPx+xuXVlvwqXH0PRM6/mriMj4Z/jZUnVDenLQbY4IBH2tVWz1xk
	srZZTHLcjzgLj8TvyjKGSZyjjarJqYeIge0GTnd3UCjBG7Ke2dAW/28BQ==
X-Received: by 2002:a05:6a21:2c01:b0:3dd:a197:7368 with SMTP id adf61e73a8af0-3de0e8df2dfmr10216672637.65.1790597703420;
        Mon, 28 Sep 2026 05:15:03 -0700 (PDT)
Received: from ?IPV6:2401:4900:7b76:dc42:a0ca:6d18:81af:86ab? ([2401:4900:7b76:dc42:a0ca:6d18:81af:86ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea889d20sm3982115b3a.28.2026.09.28.05.15.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 05:15:03 -0700 (PDT)
Message-ID: <b0ec2ef9-7aef-4f7d-b31b-7141b39c2d24@gmail.com>
Date: Mon, 28 Sep 2026 17:45:00 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] setup: enforce repo passed to
 `create_repository()` has no state
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 15:21, Patrick Steinhardt wrote:
> 
> [... snip ...]
 >
> 3:  3a7c197f1b = 3:  8dd89f144a builtin/init: refactor messy creation of leading directories
> 4:  c3ced666bd = 4:  f37db1b17d builtin/init: move handling of "core.sharedRepository" into "setup.c"
> 5:  25918a4ff6 = 5:  db76d32f2c builtin/clone: don't apply "core.sharedRepository" to leading dirs
> 6:  a742852675 ! 6:  19388a188c repository: adapt `repo_clear()` to fully reset the repository
>      @@ Commit message
>           some state because we don't make sure to clear the whole structure.
>       
>           Refactor the function to set the whole repository to all-zeroes to avoid
>      -    any kind of leaking state. While at it, make it a bit more robust when
>      -    called on an already-blank repository.
>      +    any kind of leaking state. Replace calls of `FREE_AND_NULL()` to instead
>      +    use free(3p) to avoid zeroing out the data twice.
>

s/free(3p)/free/
Rest of the inter-diff looks neat.

-- 
Sivaraam

