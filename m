Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09223442FDF
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242989; cv=none; b=KdkOTIL6h4VWdR3XoFrgvP7Jtj9bjYC9FCYkwqKqwndjiEua5Xj3aaFRa93U2NkKDRdFB4Jc/tD1PZ4Q2fC67bF8tCuF61XD/oAXOviPiGJy3AFpUiQIMEHAaRECwNuC0Evn7DwsYmysIpyoVbW7ZdOcM1BVRAvnq48Uv1nYudQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242989; c=relaxed/simple;
	bh=9SpCs6LUbdS5LKjjWnGagPLfBFEOeLNHsmMdhrvqOyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HoPTsx3y+Rz0/8g70OlhUnMeDvb9zwlgX3R0fcz7MuZ4Z3+bzmH9+mdGMMaXpMdSn2HbkH6K1UlE7D5R9EXqXRYFgO19vlrWgPRZc0TIQU4DdSKvnmSCOTWIDp6ODR0zwg1Rs60Obmm357iE5eYVszGKcNSHlkhrerwW9D1FbI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrAFWAjN; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrAFWAjN"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a64c7cdb46so3038637a12.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 02:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242978; x=1790847778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4iqZZ8WhsStqjgTqpLfcfwscUaNjWBCS0JrvbCWCUuA=;
        b=PrAFWAjN3lcbh4If1ujhs1omljq+HNOH823bOpSPhoazQI3AR5Toi1az5TsK+EMsIA
         zXaY9wtrUGG8dArj37BWxk8hZOoqll8m+Fi9KrJxO2EKw73s0Ma/j9RpEHXkSiN7pSWK
         J4DItphzM9Yr4kvLVRh90DuZUsx6vimEOqGJnftP1gjyNYq1zoSoYUzSX9jSOqvzElUS
         4h/ml793n0elN9xWTZvvaoAk/nTdyWyOREKDqV1zcOejDcq7xEDbU0wQ9KV1lmeYDeDp
         /Di/kSwmYOuAIav14YhcVdXCdk1Iv/CNRQYtVB6gpyK15NGkX618n19lcKCaXLXhFMVx
         cTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242978; x=1790847778;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4iqZZ8WhsStqjgTqpLfcfwscUaNjWBCS0JrvbCWCUuA=;
        b=YE0O3XJ5k29NAOzOPyA4rkCXC4+MuE7ZQeStFJxqppj2c7UYSFB4QW3i0JC2o5OvEe
         q/kN2RUrhKwT9oaMMKKzwn7bXFBAV7tRXD2BtkybO2U53es5l+FInmLqpBBqBtA1l0z2
         dYRANaxloMoD6lUWH9YjbwynjPMpPKe8dA3qg3o4NPPkf3zWINzHQDtR/WOZgLqpBRDZ
         4ove9vMlNs/tN7Ytbvbn/VZdajIJA5D2rKH795k3Hc6LVJx5nNG7gr89nIccK6QhLP71
         AQTHlPKCgz39HdxxNpzr9ddJCV1aI1FaXGkO8nrfTiVAisD59a+FbVKKNjd3mccm2S8z
         1uYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzllcrSsxqa0Wm311ica9HysTzxHT3G4uq2r1w1r6mhwFfkXhoc8gw4vL1bMtWkdYuzM7o=@vger.kernel.org
X-Gm-Message-State: AFuF++lHxTSkEeET+pghC+dJ5g3fuB0tkK2rAkZfZbcUmhP8P/1KgxxT
	Trxwmrp7gMCmZD0J4nBukhsKMARm6IxtNln4t7uE2wa7G0TeIHyKRJlrhodmRChK
X-Gm-Gg: AYBFou16pWnvAOn2qPyhmgKF66ovFxu941C2FsvHfiCL2t0tVUjYkg50GPZfmWc7ejt
	6fe77l9J4K4foY/fk1ucgmz1FeFmSa+6+FFTL87zcjUOPbN2/j6TfLiipBnIsqFsDHDkLfARNC/
	3VlzfDHSRjurcT4WCWxGU929x/TDuu5qO+NhKqaI1zlNneNugEv8cxaLvjDDKNLAKsUBZKcpYDx
	nJJkBx9fU+eETVmKpfEeyQWrUQTWo2/zDLgmHQjX7KWqpb1a0MV/OfWR3NRa0ly6121d8Y3+bbB
	KQv314xoke8eB4ty8lisu397ABkvqnUtRb4KBDeUe65af3CXgBpNWa4ui2a8aB23WaHgU0znzab
	C3DzMe2JZWXOM/JDmLr7VTB6UxQQ5oXy7LNqaNT12BAmWNpYLq0KGwbu4LAILNIeiqn14CKaGlP
	Oi9Us5XkptLpDQVLV8VKsfVZXEdbt0hB8xceJGS2V4Q8QyBPzUZs+43D/4ANDB73bQNXr3N+v71
	HaS73DztRnQh5WG3HK6IwjdjUR4js617+Fppsq+Hu2nBzkctpLKLQ==
X-Received: by 2002:a17:907:86ab:b0:c29:3ea4:a219 with SMTP id a640c23a62f3a-c2ac254cca4mr157084966b.44.1790242977666;
        Thu, 24 Sep 2026 02:42:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae5c8a44sm261168366b.20.2026.09.24.02.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:42:57 -0700 (PDT)
Message-ID: <232f2bf6-04d8-4a54-b4e9-51b5ee79799f@gmail.com>
Date: Thu, 24 Sep 2026 10:42:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] t: test failed "stash apply --index"
To: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Cc: Eli Barzilay <eli@barzilay.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Victoria Dye <vdye@github.com>,
 Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
 <cover.1790168285.git.ben.knoble@gmail.com>
 <5bd4b78cace8ba8c8887c78f739bde3513dfda28.1790168285.git.ben.knoble@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <5bd4b78cace8ba8c8887c78f739bde3513dfda28.1790168285.git.ben.knoble@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 23/09/2026 13:58, D. Ben Knoble wrote:
> The next commit will refactor index handling for applied stashes, so
> let's make sure we cover conflicted index merging, too.
> 
> Signed-off-by: D. Ben Knoble <ben.knoble@gmail.com>
> ---
>   t/t3903-stash.sh | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 721158606f..3958ab3c8d 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -374,6 +374,24 @@ setup_stash() {
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'stash apply --index leaves everything untouched on failure' '
> +	git reset --hard &&
> +	echo test >other-file &&
> +	git add other-file &&
> +	git stash &&
> +	echo unrelated >file &&
> +	echo unrelated >another-file &&
> +	git add another-file &&
> +	git diff-files >expect &&

diff-files shows the worktree blobs as null object ids, so comparing 
this before and after stashing only tells us that the same set of files 
have unstaged changes, not that the unstaged changes are the same. 
Adding "-p" would check the worktree files are unchanged.

> +	echo conflict >other-file &&
> +	git add other-file &&

I wonder if we should to add "git diff-index --cached HEAD 
 >expect-index" here so we can check the index is unchanged as well. For 
the paths that have unstaged changes we're already checking the index 
object ids via "diff-files", but I think in theory it would be possible 
to have an identical change in the index and worktree that is not picked 
up by that.

Thanks for adding this test, it is a useful improvement in our coverage.

Phillip

> +	test_must_fail git stash apply --index 2>err &&
> +	test_grep "conflicts in index. Try without --index" err &&
> +	git diff-files >actual &&
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'stash -k' '
>   	echo bar3 >file &&
>   	echo bar4 >file2 &&

