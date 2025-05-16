Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99907D07D
	for <git@vger.kernel.org>; Fri, 16 May 2025 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747409567; cv=none; b=OVn6UgBvH0E2iA07/G7bHVPudJGRNn7CasbZQidfakg0ny9yovz85TSBtnVHnjkr7Chacb7I4VWCzKnxPVI+K0XtVpq+FJaxP1H7wF9BCUReww6njFEWQsyYlw0fMYwnHSb7bbBDsJv9fPnhLwFOah51EGk4j6niC6yGCGbIWxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747409567; c=relaxed/simple;
	bh=L6hTHUru7z/JnocxD7Dj0c+R05oLgMuhvDXynLwCptw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cElhmBYm6uy3UIqs6zGg2HpXr6tFggR8Ase/EC6e3J+5tvvI/CBfTuJ39vp3SQ7tIkcUiluJxhT4Fr1JluLN3S7nY+zgzSQxzy8XUmEHats3GUqtwUcjHTGT1XJN0DDec17T27/SnRLmLBr5A2/vrW66H67e5nJ2J506jVsEQnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dA6enPVv; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA6enPVv"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c922169051so131078085a.0
        for <git@vger.kernel.org>; Fri, 16 May 2025 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747409565; x=1748014365; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBUoQGKyh3L6nP+q0d6x/JpMfFzCSXxgFSgRWZGOuBo=;
        b=dA6enPVvJQy1z89iYHsSnDmDU9yNN79im3209JMMmuTY/beEOEU9NgHQGd+AoQqRij
         0a/6F5fpBQV1d8CMagELrbb6jLsEnIkszHGY10leKYrv7Oz8JLbRuMwxH1z3e7PujeYr
         +Nxx8/MmND9RJCe3iLkl5He8xsCCCAhMOJoqPn98NflmMydtOBj0XfuTSvkJLsv3QSeH
         slvkHLZcf5BRZnnosKgYQoeR5XlroE8QyZjSmwuqjaHn2wm88oUl6BB+HYlZ7f7U5t1V
         yk3G4L+EpQIFu6itMpnG0k9wST8PxQfro5h9NW+qOAT7KQQFMfDdqtb2/cfpv4dUSZc4
         Nm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747409565; x=1748014365;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBUoQGKyh3L6nP+q0d6x/JpMfFzCSXxgFSgRWZGOuBo=;
        b=XMwrE5P8lQjXVEmy9jkNIk8tpEh/s7PHNDbo1DkEazVNinJ6AZiMAN7lCjw8s7m19G
         SusBGPLjBb39m3cu8gaMwSYmx5rwtQNRxuXe6p5IlTWH03vqf/p7fnplsrcyZncyskh2
         FlaThBwyfUCWlhqiBSgriK/zWpcxqMOuPGnPIobgQuDpY26GbSpmafbOMq3Ol8CGLLAV
         d1EeNPxcoA8+MYwLKCY+H6X0OZAYpA/WHD/qzQQWnUXa492qPxGi8mD6MRMb4qMb2fiX
         +xKWmUumkj28WvyYhPR/sEJ1k9Ui+uuNGdwP7DyycD7ZBdcQ50mwabPhehqR136Jxd8q
         yFZw==
X-Gm-Message-State: AOJu0YxPMrgTrIC9g71i5sAXV9XwxPsaveBGVBMLCvv2MPoMFtAWTPNs
	1jchLTEevOIKy1bJ5uIdETxZ6GiRlyWeKQt689QFOH2Nmyh6J0nnMvG5
X-Gm-Gg: ASbGnctCwg34OhyCtXJrzCZzpRnNGuLXwOYBWmE4cOIGmzIOJZKe+mzYKcQcouzztC0
	5LhlduKenFxugn3ePFe5xVr3we7gvdr0FeZ7heMMQruRzwtf8q0b/+AUcy2ut3cuXOb7Dw2qVf6
	e/Zo5T1yEXwcmLZ71qXGAV1GLeetVQRgYZ0zlId0vLCbHhSDHDrsCT1Q6BF5+ZjjLPjbega5VDo
	UlLzf5zBuPb77p6ytYfxGGNbfzU09iun3p2oa6DW/nEPZAUGZwuXnJ9XtAk6xQgGzjSVOHf7zIl
	hhZ8g0wjZMDBQ0Sz8ANGb0XZh8jiG4x53vRrJlJHU9hNRIZ9ty8mnFYxcfNqupEM+QQIVaobRpN
	wTa5Dh4BmQqu13Wb0MndAwNxeP4Myxi5fv0vqXoo=
X-Google-Smtp-Source: AGHT+IE7Chh8zNwBRHDL4xGpJd7dJynocQInAWarnKlPI5w5tNl0jEl4fSztMXlVhyiQBRXYYHxEDQ==
X-Received: by 2002:a05:620a:3601:b0:7cd:155:383 with SMTP id af79cd13be357-7cd46731a91mr511258585a.30.1747409564532;
        Fri, 16 May 2025 08:32:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:9ccc:beab:105c:f288? ([2600:1700:60ba:9810:9ccc:beab:105c:f288])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b097a782sm13237416d6.104.2025.05.16.08.32.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 08:32:44 -0700 (PDT)
Message-ID: <f0f1ebed-06af-4d73-9068-a08956f01e48@gmail.com>
Date: Fri, 16 May 2025 11:32:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/13] t5538: add tests to confirm deltas in shallow
 pushes
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <ddf804e606a5560639e4018709da33cd80c74012.1742829770.git.gitgitgadget@gmail.com>
 <aBVWfJUFNdfwS0PO@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aBVWfJUFNdfwS0PO@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 7:34 PM, Taylor Blau wrote:
> On Mon, Mar 24, 2025 at 03:22:42PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> It can be notoriously difficult to detect if delta bases are being
>> computed properly during 'git push'. Construct an example where it will
>> make a kilobyte worth of difference when a delta base is not found. We
>> can then use the progress indicators to distinguish between bytes and
>> KiB depending on whether the delta base is found and used.
>>
>> Signed-off-by: Derrick Stolee <stolee@gmail.com>
>> ---
>>   t/t5538-push-shallow.sh | 34 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/t/t5538-push-shallow.sh b/t/t5538-push-shallow.sh
>> index e91fcc173e8..11b85cca9e8 100755
>> --- a/t/t5538-push-shallow.sh
>> +++ b/t/t5538-push-shallow.sh
>> @@ -123,4 +123,38 @@ EOF
>>   	git cat-file blob $(echo 1|git hash-object --stdin) >/dev/null
>>   	)
>>   '
>> +
>> +test_expect_success 'push new commit from shallow clone has correct object count' '
>> +	git init origin &&
>> +	test_commit -C origin a &&
>> +	test_commit -C origin b &&
>> +
>> +	git clone --depth=1 "file://$(pwd)/origin" client &&
>> +	git -C client checkout -b topic &&
>> +	git -C client commit --allow-empty -m "empty" &&
>> +	GIT_PROGRESS_DELAY=0 git -C client push --progress origin topic 2>err &&
>> +	test_grep "Enumerating objects: 1, done." err
> 
> Why is a full 'git push' necessary here? Could you instead directly
> invoke pack-objects as git push / send-pack does? That test_grep to
> assert on the size of the pack seems very fragile to me.

Here, I think we _need_ to test at the 'git push' level, since that is the
user behavior we want to protect. Earlier testing using 'git pack-objects'
directly had not discovered this subtle issue in how it was used in the
shallow case.

It does make the test more fragile, but it's testing "the right thing"
instead of locking in an internal detail.

>> +
>> +test_expect_success 'push new commit from shallow clone has good deltas' '
>> +	git init base &&
>> +	test_seq 1 999 >base/a &&
>> +	test_commit -C base initial &&
>> +	git -C base add a &&
>> +	git -C base commit -m "big a" &&
> 
> I don't think it really matters, but you may want to write a test_tick
> here before committing.

I don't understand why. Is the point to get a different commit time?

>> +	test_grep "Enumerating objects: 5, done" err &&
>> +
>> +	# If the delta base is found, then this message uses "bytes".
>> +	# If the delta base is not found, then this message uses "KiB".
>> +	test_grep "Writing objects: .* bytes" err
> 
> If we had the raw pack that was generated, could you use verify-pack
> instead to check that the desired delta/base relationship was
> discovered?

True, we could do that with a lot of effort, but what we really care
about is "the push was small" not "this specific delta base was
picked" (though, the delta base is how we got a small packfile).

Thanks,
-Stolee

