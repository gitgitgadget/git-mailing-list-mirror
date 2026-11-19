Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090958;
	b=dkK6aDRPu1RgU/hvlwOgTqDFcqnSkm9Oq8OLpOo9J7K4VcGIZMUt2r6PxTVDrCg9RLvv
	 csRNTUhSGSlCrPVo/5zOs4IcPAr2O91gt7do3MXPjywf3av9uNfP+vAHI+mQJ1ZUj2gZz
	 wekElpX7T/7tPyKqZoZ22IeEDybiNKTUjLUEQN1Rgspyzt7zbvY+IFb9XyPPdkw4E9DKB
	 wCSR0apDWZ3eWO83Kvrp+6mPshzvrJKfOIlZvkDdk+53iaut/upsVgi+eId7sVYn50mPS
	 e3pcSwdlDt5MiX9vGzVyBbQR+lTLdPA3hduU10euUYKJ7IIffiqkEQxHXp+A8AJ9NGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=gMevfWyYDAq/uXFAXCjx80YlEeGrTQFvBJ/PfoThMJc=;
	b=e+twPdB30GkQCL7t/UrJDKTdnNYv3SGYrQwHEcUbJeON8ikkyHrmXGRJuYLvIZLlk8NX
	 p2B+42fWXw3TxCzwEhT5YMdGWvMiK9dPQ/Ps6cCf9mxEnRQaM9VEFolalp1LEn5LiXOKv
	 VzMfIVfQVFUbFN2lImvcnxLMkyqgJs8NRb9dt4trgkIhVmnkvwc7OidQyz18VJvdDF5ab
	 +A28K3GakOWhcs3EP/N0rBB/axEeBrJM1kPlcA0T8quBl27s6DU9v/s/NHBzy6MdwZZul
	 foif3dutKMWfXS6cUui7TFukhW/rGxq6noNB//zZxS2LOZgVoqXmPNN9LimlZkLhC3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VBNFXxFF;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FAB606A32F
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 12:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7FAB606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VBNFXxFF
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b179528d56so1164286a91.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 04:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795090957; x=1795695757; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMevfWyYDAq/uXFAXCjx80YlEeGrTQFvBJ/PfoThMJc=;
        b=VBNFXxFFE5uMq968D1yBaj0iA3Ed8zQvNa6FrRCJzhMUejggzVfpEJO+8LPgQ2INol
         RqkwA2luxSA47VgXU2P5rn1wGVvXxImIteXRJ0rhkY9BGQnkWySKvrH5Btz4AMYqrZmK
         ogPEUgc5zKp0//CU1Xb3ozjt4GAcM4BiLVP5ggy4p2RPG19ZU0guaHQAd1Z2ovnjQyq/
         evItvA52+n3EhYzQaK/DDe+5+0Jz1b7E4Juv7yEs+3llzHCooMSGJCBweRjBT3tw40Hl
         CGLUvQRr2txAIYyd7ca0eq/0q2o36h87UeqPq0BV1htBFeoZhhXZAX0/keyIpaJHMdLg
         ppoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090957; x=1795695757;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gMevfWyYDAq/uXFAXCjx80YlEeGrTQFvBJ/PfoThMJc=;
        b=I8KxvJ9fK4D6NN09mAP1Nb37GJ9fTASHrBnF5M0/9k0EVwmlg0G2Nz66UNWjWIqHqC
         5EmCE+OhFkWKf5TJBV42FF3YGxmezNQTiG2Rd2FZ6lqxRpSNjH1u8r4JsqKCV+y1+xzz
         u2f8+uF1ps1kWLGuhUrWz2VkNPEgf+h8x/YbILnzm2xof0XGyOvN+fUxbbmpuoI/zbEF
         00VUFnRB/4D+6ljmhcb48d0NPk/bxe2F2tL6PvFBQ5SYoeP0yRAiVLnJ/nXBo3NkUmAk
         k3wQyDvMFiL9HXEBZAzsWF3lyRSJFhiz8PsVUerQofmQIyTPPLHpLbgVTLs5mydeB4pB
         6cVw==
X-Forwarded-Encrypted: i=1; AL+hErGrcxtLxm/vjS1WwIQDnM0ClwX/Tb1t6ukFQEum9JByc4DZ4weDe/avYyscwP8vOK6UfF0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+rUOR3VzwVDv/HElR9b4qS6gaZryCTiVUy9QinN7PxwTWSOuNN
	a+sd1iQq3JMbLO1xYs4R7CCSGioVnESfEltz6VsgogxEIXyhKxq3Pv44
X-Gm-Gg: AZFdTZc1nWexEn3gw6xW3bbq9mXdNRG6LRz5wdC8FkYv5EWUv/D0Pu90l3cleFpCL1K
	n4kCJsPdzsB1nr86QZFZdHX1+OiVnpUlQeNV+ZD2QaiUrhv8Vc5u/Klh1/6i2wkKocX0SwXmOOc
	yp9FL+p7IhJvYFvvajpGuq5XmwpqmxLxFMbCABXqBnJLZAC72kChUGaI7ziMJvv2n9AAkJZBXzn
	Ml9er44eSoPjUoiziVwxpx30n6X+Pg+scRcyPDdBEB9vUf3j1OZgNmER5SluqUkLX6QPuLAzy82
	hUVzZSipfsYN1PCuq8PilrwjB/BEO01e6sMYWRl7RXNMcfT7IK++uaFbouQQ4xRWp2zbdKYQNsU
	0Mbm7leoFM2tQPcxP2fo+biAzT4fvi2BxXVnN4A9jkBqnbQI+TIR+cWLLEPCZu5gQ8w0CaDXouy
	8N2ZBV9AM41LVwM4EP6qmhgf/aS3Y2LFFWRlAiZufGqbzSJhnF0iuMcqSewH+W68N+whmsUKOo3
	5y/QjPD4JXYxDCEsy2omfISBuXc18IQFKljX3F4538qzQe7k/OYuGGngStlMDVnsAiF3MBcx3yw
	EaH5iQRGExDh1jx0CEe1AW2RWkHLqhdQ3qrpvCsX
X-Received: by 2002:a17:90b:57cf:b0:3b4:ac3:8af2 with SMTP id 98e67ed59e1d1-3b40ac38bbamr799997a91.27.1795090956882;
        Thu, 19 Nov 2026 04:22:36 -0800 (PST)
Received: from [192.168.0.11] ([106.51.27.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405776019sm2557963a91.4.2026.11.19.04.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 04:22:36 -0800 (PST)
Message-ID: <db459a4f-9454-4855-b1c5-c8ffc9b277ce@gmail.com>
Date: Thu, 19 Nov 2026 17:52:33 +0530
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
Subject: Re: [PATCH v2 02/20] t9300: make the series B tests self-contained
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com
References: <20261112-kn-fast-import-tests-1-v2-0-b8c3a0ab27e8@gmail.com>
 <20261112-kn-fast-import-tests-1-v2-2-b8c3a0ab27e8@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261112-kn-fast-import-tests-1-v2-2-b8c3a0ab27e8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/26 23:04, Karthik Nayak wrote:
> The 't/t9300-fast-import.sh' test file contains numerous tests and is
> currently just shy of 4000 lines. This is because the file contains
> tests over multiple series, each series testing particular functionality
> or sections of 'git-fast-import(1)'. In upcoming commits, we want to
> split out these tests into individual files for better discoverability.
> 
> First, we need to remove the dependency tests have on preceding tests.
> Modify the tests in 'series B' to each run in a new repository, which is
> removed when the test completes, so that they neither depend on nor
> leave behind any state.
> 
> The 'B: fail on invalid blob sha1' and 'B: accept branch name
> "TEMP_TAG"' tests import on top of 'main', which used to exist from
> earlier tests. Create it with 'test_commit', so that the first import
> can only fail because of the invalid blob ID.
> 
> The 'fsck' tests require the whole repository to be free of unreachable
> objects. They only passed because of the garbage collection in the
> cleanup of other tests. A new repository makes that unnecessary.
> 
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>   t/t9300-fast-import.sh | 472 ++++++++++++++++++++++++++++---------------------
>   1 file changed, 275 insertions(+), 197 deletions(-)
> 
> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 4cffe43a71..e2cf0b7a22 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -358,274 +358,352 @@ test_expect_success 'A: export marks with large values' '
>   ###
>   
>   test_expect_success 'B: fail on invalid blob sha1' '
> -	test_tick &&
> -	cat >input <<-INPUT_END &&
> -	commit refs/heads/branch
> -	mark :1
> -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> -	data <<COMMIT
> -	corrupt
> -	COMMIT
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit base &&

I suppose we need this test_commit after making wrapping this in a 
subshell since we can't lean on the commit created by the previous test. 
This is just the commit message mentions it. Makes sense.

>   
> -	from refs/heads/main
> -	M 755 $(echo $ZERO_OID | sed -e "s/0$/1/") zero1
> +		test_tick &&
> +		cat >input <<-INPUT_END &&
> +		commit refs/heads/branch
> +		mark :1
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> +		data <<COMMIT
> +		corrupt
> +		COMMIT
>   
> -	INPUT_END
> +		from refs/heads/main
> +		M 755 $(echo $ZERO_OID | sed -e "s/0$/1/") zero1
>   
> -	test_when_finished "rm -f .git/objects/pack_* .git/objects/index_*" &&

I suppose we're also losing this because the 'repo' itself would cease 
to exist after this change.

> -	test_must_fail git fast-import <input
> +		INPUT_END
> +
> +		test_must_fail git fast-import <input
> +	)
>   '
> 
 >   test_expect_success 'B: accept branch name "TEMP_TAG"' '> -	cat 
 >input <<-INPUT_END &&
> -	commit TEMP_TAG
> -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
> -	data <<COMMIT
> -	tag base
> -	COMMIT
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit new &&

I think this additional test_commit is deserved, too.

>   test_expect_success 'B: accept invalid timezone with raw-permissive' '
> -	cat >input <<-INPUT_END &&
> -	commit refs/heads/invalid-timezone
> -	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1234567890 +051800
> -	data <<COMMIT
> -	empty commit
> -	COMMIT
> -	INPUT_END
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
>   
> -	git init invalid-timezone &&
> -	git -C invalid-timezone fast-import --date-format=raw-permissive <input &&
> -	git -C invalid-timezone cat-file -p invalid-timezone >out &&
> -	test_grep "1234567890 [+]051800" out
> +		cat >input <<-INPUT_END &&
> +		commit refs/heads/invalid-timezone
> +		committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1234567890 +051800
> +		data <<COMMIT
> +		empty commit
> +		COMMIT
> +		INPUT_END
> +
> +		git fast-import --date-format=raw-permissive <input &&
> +		git cat-file -p invalid-timezone >out &&

We're losing the '-C invalid-timezone' here since we are already in a 
repo created specifically for this test. Looks good.

> +		test_grep "1234567890 [+]051800" out
> +	)
>   '
>  [ ... snip ... ]
>   
>   test_expect_success 'B: fail on invalid file path of .gitmodules' '
> -	cat >input <<-INPUT_END &&
> -	blob
> -	mark :1
> -	data <<EOF
> -	File contents
> -	EOF
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
>   
> -	commit refs/heads/badpath
> -	committer Name <email> $GIT_COMMITTER_DATE
> -	data <<COMMIT
> -	Commit Message
> -	COMMIT
> -	M 120000 :1 .gitmodules
> -	INPUT_END
> +		cat >input <<-INPUT_END &&
> +		blob
> +		mark :1
> +		data <<EOF
> +		File contents
> +		EOF
>   
> -	test_when_finished "git update-ref -d refs/heads/badpath" &&
> -	test_must_fail git fast-import <input
> +		commit refs/heads/badpath
> +		committer Name <email> $GIT_COMMITTER_DATE
> +		data <<COMMIT
> +		Commit Message
> +		COMMIT
> +		M 120000 :1 .gitmodules
> +		INPUT_END
> +
> +		test_must_fail git fast-import <input
> +	)
>   '
>   
>   ###
> 


An --ignore-all-space diff helped me grok that most of this change is 
just the existing test getting their own repository and the test code 
indented to put them within a subshell.

I just wonder how much additional time or work this has resulted in 16 
additional repos being created and torn down.

-- 
Sivaraam

