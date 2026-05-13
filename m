Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848252D5436
	for <git@vger.kernel.org>; Wed, 13 May 2026 19:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778701581; cv=none; b=Q64WXK2NLQ0tPTbb7eU0Lpu8DyGbaRrJiHu4SDP+HN2TJRstEIOk2GCXjMlRAxvru8e1Dk1bR8EgPmB+TJkMzFAfTOdC+7wLIUwlWkx4WBorLQ3bA4Na3PHNvzgdQDm9xCgxEHZPI3HrXzLE7ir4USPZsOD/DtMazfkn2P9bPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778701581; c=relaxed/simple;
	bh=Z0QVVYf8aWQZG2K//jZdkGNxEx3KiHC9UdsMO83JFFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EjG/ogf82nPBfkt01uHr31WQy0jnDEG1qPbKKijO7yYDG0jzxEiRsBDjavjemPWfQNTFUT5/SqaxnbXc4lyLb+93cg+3vY3ZVRq0aX97EYMtk9AlaQj+fLpaVYsk9m+nyk3wSrdCTBQeez46mJm3qUFPFU+hzidWK6cTTgxkjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nPfC4oxJ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nPfC4oxJ"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d736211595so492988985a.0
        for <git@vger.kernel.org>; Wed, 13 May 2026 12:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778701578; x=1779306378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5CadwLaXNO00Aer8uf2zRobTeW40xrlv8LTlE4idYw=;
        b=nPfC4oxJ9/+FCuW1pYtRv3/n/ahJxAz4HWZ5BKjTyVQYWjBy7BI0jmZYvObnt930E2
         uEHjQffFV6lqnKHBx+t0r/fFaqydlDbcmXrM0t/AkFeJPw9bcLLhs6wdy49hDbvB1k8S
         tdqphOM+TTWRxjJwlv7KF6VVnSDqNT51JqWNROmIYgx9GCwBJuJQ/i/4prWDmq5RAg/e
         1EFcgCbt/YNeYLrN2AV4iNThvHDC1lhPKESa79BOr2+KZwe8KoJKexnkDNZtCWky2ohC
         xEfbZWFOOkf7We+BWfvlV+drovxNV/OVHnB1lreDnNZWO6ON5BpR60+c/u498Yr7lR6H
         R6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778701578; x=1779306378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5CadwLaXNO00Aer8uf2zRobTeW40xrlv8LTlE4idYw=;
        b=RTJ1ZZ3bqoCoo/2qBxpk/dK6novuoX9HdcXwdn1DQW5FkA7QiW09YGuIACAAVYWjdL
         VMQlUhCiyFZORFfgbtkGs0ZTVOhHJdqBUYzzr16pbGTBB29y5BOdzR0rG9w6E9HBfkRP
         Y9ktqDoTG6RtgV91QQrJ4BYdPOBn/hjJgwYmx08ypk6204Rqy6YDnP/yU0cu4VTOVsr8
         P3JvlEaCZTpxqpyxRRHzkPXvFlGQ2/Qk6wQMdPlpmvsxwIyLuVtdRuO8VJLBWpX2fzLZ
         FMWfZ0oB3i6NdFJJQGu3Oa2hOtBF/fb/j1UPyK2MB9jIAorWpqaknoNfg+96hjwOCYti
         NrYw==
X-Gm-Message-State: AOJu0Yye+kESvkcgyXzbxsKy8mcc8KXLOYuT4BOaFZ1VC9i2g3DYg34D
	Hg6DUZgBV3I32hxpnRbg4McjjCA/jPSBDXWnUZDES7+xXLJYK+Eqdhgt
X-Gm-Gg: Acq92OGtMyNP6+CODrUv5F+8CVTgg+yCd+fPyBwyGL3/nILVClVT9Ko01yZzhTjNm5Q
	SBHjp2E5rGswFp2J1k9mpgKZWOuKGSegPbBBi/f3fBT+oLiBjTKtbWezEumP7Snml/zbea27+HM
	4oVbRmeP+dyAnnY7SxokeEPC5OkCjQxi7DkdBrBI3iV+e83XHXTiCchLO2MZDnbQQ2qv5nyANWP
	YbWUiDiN0FoyEGa75k0WeHCEXAbSO+Q+7plSjyk2nBq/CilREvEdaF9jYx1CTJZuiRPzffvCHx6
	ozUC5HTTUK72avBAqZ+XQor0EWNTfaD8Z0rh1Cue+CH5h7OFax06+sv4EI4XgAlSc9oG12NmwEx
	RUd9GGLkT3W1LjjgZrMCU8qi7UN3m9YkHSo+4xTr64b1v8ozLLLaE1OCeDQd+ZWLuoHiK4u4ZrJ
	pigCPudL3OJXD7K5cSqupJqqVxIyUdpz6E/uMdYNrg7jTENxCJ1eN5vuU41JiTBVd9FdChx9Vnw
	A3sx+YS
X-Received: by 2002:a05:620a:17a3:b0:909:fc70:c2ab with SMTP id af79cd13be357-90fad385785mr645669785a.37.1778701578146;
        Wed, 13 May 2026 12:46:18 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd62e233sm45031985a.45.2026.05.13.12.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 12:46:17 -0700 (PDT)
Message-ID: <bf1e14e2-626f-432c-a77c-706eea0fcf29@gmail.com>
Date: Wed, 13 May 2026 15:46:16 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/12] path-walk: support `tree:0` filter
To: Taylor Blau <me@ttaylorr.com>,
 Taylor Blau via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <c9efff0ea8d72d2d084957e1b099801b8d8727f3.1778523189.git.gitgitgadget@gmail.com>
 <agKFRV4TjInVOCaO@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <agKFRV4TjInVOCaO@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/2026 9:41 PM, Taylor Blau wrote:
> On Mon, May 11, 2026 at 06:13:07PM +0000, Taylor Blau via GitGitGadget wrote:
>> @@ -534,6 +545,18 @@ static int setup_pending_objects(struct path_walk_info *info,
>>  			free(tagged_blobs);
>>  		}
>>  	}
>> +	if (tagged_trees) {
>> +		if (tagged_trees->oids.nr) {
>> +			const char *tagged_tree_path = "/tagged-trees";
>> +			tagged_trees->type = OBJ_TREE;
>> +			tagged_trees->maybe_interesting = 1;
>> +			strmap_put(&ctx->paths_to_lists, tagged_tree_path, tagged_trees);
>> +			push_to_stack(ctx, tagged_tree_path);
>> +		} else {
>> +			oid_array_clear(&tagged_trees->oids);
>> +			free(tagged_trees);
>> +		}
>> +	}
>>  	if (tags) {
>>  		if (tags->oids.nr) {
>>  			const char *tag_path = "/tags";
> 
> It looks like there is some prior art here for enumerating a sentinel
> path for "/tags", but I am curious why we did the same for
> directly-listed trees in the presence of --filter=tree:0.

It turns out that this confusion is actually due to some major
flaws in how the path-walk API was treating tagged trees. The
test setup didn't catch this because the tagged trees were also
root trees from commits, so this wasn't caught before.

This means that in the next version, there will be a setup
patch that updates the test setup (and demonstrates the error
that those changes don't impact the rest of the tests) but
the new version of this patch will be substantial.

Thanks,
-Stolee

