Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.33.87.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216794;
	b=RG1SZFOQP3Nv3xGQX9KJZBEPa3C7Z1+WIgdrGb194sTA9wFnBPn/IdKjRw60ozRi123P
	 veKbFhwLqqi8Fnf3yalUOmIW6CY4PFcJamsEYdLHIWlFXl+VgvfRGWyLGm9NYHyiLZVEK
	 Xsx4ZDZ45bfauz+GTUSy/CJdht5sW59cZjuSnLzFIpOP7Iq809uz6NoOvGFUNjQmD3mk5
	 quhsjjBwEU4IyZT4guCquf4REPmCZeT3IjGTrzwUjtd6YcxuJPSmsQtl+WyOtXpDvcw0j
	 MKQWSkiHR99a0X8IKHswo4ychRt9NgHYmo5aI2Rw2myB1/YZHAyNyUiXnPrtBmsTUrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216794;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=z3W3Qg8QFXCjIuK9W5vq/n+2Rzg3/vXzcbXPulAAASo=;
	b=fAEI9GDCUPy+kZQLnisbPix8UwJJXkNxMXYcOoDLtGm6FZ7m1ufXKSDbYpv8QR5HxOD5
	 w37bcRSh8LTyWuvU1DaCGKOlE7d3gwZG9kbnM8TmcYsfZvc5CQlL+7R7zwr+WJQ7FJT3j
	 XlfhNGIW5wAQafrxa2xe68c7ejn1L5Gib6eoWh4cyPQMVoCOi06lKmd+EdRovl/V462pa
	 VXzO/aDQz+JX+kq74EeI8965CSbZuo1LM87+a0sgjytu/jwZKaqTHGHhygtTATKxlOjG4
	 MitUv/AQp/ezhq/caxQzuL0RXJJ4KldxzA7zAeKU3cQiUNuB1STGiKfZRfvSjYHIZfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kdbg.org;
	spf=pass smtp.mailfrom=kdbg.org;
	arc=none smtp.remote-ip=213.33.87.14
Received: from bsmtp.bon.at (bsmtp.bon.at [213.33.87.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78C5606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:33:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E78C5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.102] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4jNPhv5B8MzRrZy;
	Mon,  9 Nov 2026 10:33:03 +0100 (CET)
Message-ID: <ddea802a-d4f4-4de9-9108-e68201841bc4@kdbg.org>
Date: Mon, 9 Nov 2026 10:33:03 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
From: Johannes Sixt <j6t@kdbg.org>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
 <50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org>
 <CAL71e4NFyAShDZPW9JRB7Bpg3aLY5mY4wdn5m_ZYoLQjHZw_jA@mail.gmail.com>
 <6992b7e9-8721-4e1f-9c00-9fd0e0704e80@kdbg.org>
 <CAL71e4NKsTZNoLFOuSPfiJPf7oS57S01MpM5V+UOr+bgMGjOkQ@mail.gmail.com>
 <c8688e1a-17b6-4d0b-ba9a-fc1e0fa8938b@kdbg.org>
Content-Language: en-US
In-Reply-To: <c8688e1a-17b6-4d0b-ba9a-fc1e0fa8938b@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 08.11.26 um 17:34 schrieb Johannes Sixt:
> Am 08.11.26 um 13:24 schrieb Kristofer Karlsson:
>> -       test-tool genzeros 2147483649 | tr "\000" "1" >expect &&
>> +       printf 000000000%02147483640d 0 >expect &&
>>
>> I tried this out and it works on Linux but fails on macOS[1].  What
>> happens is that printf only outputs the nine literal zeros
>> ("000000000") there, and silently ignores the very large padding.
> 
> Fair enough.
> 
>> [1] https://github.com/gitgitgadget/git/actions/runs/42475956442/job/128717309586

Well, this patch passed for me[2], but I have no idea whether the
particular tests were skipped due to the EXPENSIVE prerequisite or not.

[2] https://github.com/j6t/git/actions/runs/42583623620/job/129048078411



diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 01b97c8888..5dedb9054e 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -1182,7 +1182,8 @@ unfold () {
 '
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'set up huge commit' '
-	test-tool genzeros 2147483649 | tr "\000" "1" >expect &&
+	# 3 * 715827883 == 2147483649
+	printf %0715827883d 0 0 0 >expect &&
 	huge_commit=$(git commit-tree -F expect HEAD^{tree})
 '
 

