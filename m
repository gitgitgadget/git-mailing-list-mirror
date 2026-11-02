Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629228;
	b=UAHJv/PJFq6C+F0X95ozrvDbB/g1ICwLby0h8wyRAlSTgFqJGyABHB+9BmygfsWpYAS4
	 1aSNjGrUkaRG+1SfnEVz7pZnA0nKHWVdcydgj6OdSUAfnbuHdOWg41n8HQ2iGkbYcwg7l
	 tVbsBTL3WxnSUgBG++kiGlgwn3VDeJgmpIZ5d4u5SPry9C5dUxmj1prxUXWtt5QFrgLRI
	 7rrZQdtuwDpL2SSXkj9CPWryz5iKPQNP2+TeDIukeGdS50x1bTWCjA+5sxQ2Z2wdBaV+C
	 ISPc4wqgLLoxN6NmpKdglvKEB0uUgAqR7DS44OOydktE+Ch6B5yw6n26iLc5LGJrfdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=E7s5lv5FyIYEw9CtrVU5aiR+g1B0HReZ+iQS9DjCsdA=;
	b=c9PCMFBVkah+4UMN7lNJlz8wZchXDvjh4m2FWzZXvGI/cIschNzkwOmlOXW4B4Pm4sly
	 xtGDossdgWbf6ITly0mZewdYubv6AEnSbqjqPFmG4ZvJRDvvoEB+7CBygp9Qn+DKHnDMn
	 uv8HUL/XXQvqQ52bBBc97pMb4mWK8VCsfWkmQpXj17x+Apr2Ltdn+leseS2DIo69o1Zw+
	 0p9rs8jGQVFIKJQyjxsBn3Wj6hk9TjaNqozzvIC8PVzm/eZBtUtt0Ob8pymPvV2CeqFId
	 1uUCqNeilNHRjIqJfo0jmJr2LDy2VmnlmYqZUwHXH71ad1BVDUuanYbhE6LAyH3Y0Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4GDwutx;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A6B606A32D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 14:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89A6B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B4GDwutx
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c8fef5ce2so40180456d6.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 06:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793629227; x=1794234027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E7s5lv5FyIYEw9CtrVU5aiR+g1B0HReZ+iQS9DjCsdA=;
        b=B4GDwutxSbcEWXvJVvmDvFlf9jn2g2OTgLEr5fJ5iWZ0cB91VG83Wf+5wM5P91pzv8
         JndEDcIZd/SQQewz5C2lqE+Ld246ZH3PTnuy+O5rrFkmNh1izPeqncAr3l90sAvsW53G
         Eh3aZXOcD/e0pfoGO72zcTp9LjpFv2T9/FfBNuE3a4TctrK5PtN5pKPnTSfuHTy59CCc
         Mvbpyn9Vp2f25BOd56dC+C/cTdCRSNlRaCKXWhlv8W3L9NReNqvVBomDMHkNEKrTuRy9
         PCD9GNmfv6dcSl9kc4d+nw8N9dDh28RbES6CYBjO+CFodZ2VM+0EyEVF0D7JUjrtGLCN
         e3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793629227; x=1794234027;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E7s5lv5FyIYEw9CtrVU5aiR+g1B0HReZ+iQS9DjCsdA=;
        b=zcctlOinQEoovH0Dlx01fhMzn0nqFTjSS715CxU9ilbkAWg9Xc6NKGziUqZnmLkNlu
         dvSupYSiGDaBPj1IdqNj5+QHoQS5UzrmbFzRYO85NJ9tfB/c2SZZlVGygeQEfHcIKxur
         1HlXf+frCm4uqQie+RKtQaHcuirwHyNMS6ycg/f1RnilK9hhGpjonDTW+vrHA2/ehwMf
         P9Zr+lm1YmkWrbsXiDoTiT3a5vewf3XCCQzWeSJjLPJd7AExN/rtbg02GPjx42LLl6nZ
         JgnVKAiVfFbc3kzMQbryouEf0WU4D/Wwl32/hCCpEBtQUx0Bx3zwpaQtvQ8ceWkBy4eC
         mPGA==
X-Gm-Message-State: AFq9FYKROnQbs2mFCxfak3iCuddp/6r1667A3+RA4ecEGo0QHRfnwe30
	aswTEMEvZ8gtNYlyfARY2w63xxABUSySCHUXlusfwFf3mVe4d19PBzNNHEdwwA==
X-Gm-Gg: AYBFou3gNm+eNTb2rhdmBGh2uj5fmJLKVcAuEuhv39C0063pTJm9sN3zaR20Nzr/qRC
	UM1jPeWYLXDwB411klp9Z3AJYxT8/9sfOYerCCxT4L1A0+X0WCZoIQOn4UUP2gp8K7HcSlkcFer
	Qy/+kiuuA5opUyXVlFmZdUjesX8vwr3SReD2UyxZT2o9OBZr9TZ4TegBvKxGfdANx41xGkL2ddv
	wFRfNa55a9LCGeu+lJKRu6Svf4MMh+lkBPsWB+zWuMnKqw/8lajuf5rBkKzv5mnW9CEQs5aDTc9
	v/6sgAOVxcHOjYUJXDX0FLfI7p/hL7z+41cw5WwtyQzV3BRJzHdv8fsNTrUUGK39AaBnlrauRID
	lxgWvgFLEw6ooxgRFjj960Uu4sNS4j8XYCiZnT3iP8ykr2QP7TEdSas6rUlp4/rIsfWzerN6Llr
	g9zkWHkE2YqIaPrBbHlDCFW900aMg1vRkiANp8gzEEdsK56d5C0U4CTAt/TD2uD9jViAHalRVwQ
	Wqr1zObwElNpTBnLG1/ce9z/C6FvHbwKjaJq2MQv9paK9yl67EzL5M23xvF1r643EuSxzK7BtGO
	psQeOkGCDIO/J0FMmVS002rh8lujPisUsXvrt6MsfEL8W8PZtkkMdN7bHSvzrHwZwjjF4cJxN5E
	32xrRHswKZQaU+D8pejOTyehpw7pMDfgjssPaUBzucn4wIWZ1qJuMHls6hxrVLUFb5fSjXyHZfc
	BzNcaarUVk6y8PZDnvtLawUHOXUUFMRsSjvlVR25R8yf+3IinKuj4MSsQuGJLSu9qUsbiASYx/x
	5M=
X-Received: by 2002:a05:620a:8017:b0:93f:2aa8:c550 with SMTP id af79cd13be357-9442171b967mr1612397585a.26.1793629226597;
        Mon, 02 Nov 2026 06:20:26 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425a6d72esm851517185a.28.2026.11.02.06.20.25
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 06:20:25 -0800 (PST)
Message-ID: <8fa4010d-d39f-4e78-ab01-be3e9d20a148@gmail.com>
Date: Mon, 2 Nov 2026 09:20:25 -0500
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
Subject: Re: [PATCH] describe: count the distance correctly when commit dates
 are skewed
To: git@vger.kernel.org
References: <20261031065525.19883-2-torvalds@kernel.org>
 <auiGP4XhObUzC9vD@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <auiGP4XhObUzC9vD@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/2026 7:46 AM, Patrick Steinhardt wrote:
> On Fri, Oct 30, 2026 at 11:55:03PM -0700, Linus Torvalds wrote:
>> From: Linus Torvalds <torvalds@linux-foundation.org>

>> diff --git a/builtin/describe.c b/builtin/describe.c
>> index c0abc931a5..2cd597d919 100644
>> --- a/builtin/describe.c
>> +++ b/builtin/describe.c
>> @@ -328,7 +328,7 @@ static void append_suffix(int depth, const struct object_id *oid, struct strbuf
>>  static void describe_commit(struct commit *cmit, struct strbuf *dst)
>>  {
>>  	struct commit *c, *gave_up_on = NULL;
>> -	struct prio_queue queue = { compare_commits_by_commit_date };
>> +	struct prio_queue queue = { compare_commits_by_gen_then_commit_date };
>>  	struct commit_name *n;
>>  	struct possible_tag all_matches[MAX_TAGS];
>>  	unsigned int match_cnt = 0, annotated_cnt = 0, cur_match;
> 
> ... I wonder whether we should also call `ensure_generations_valid()`
> here. That function is very expensive in cases where we don't have a
> commit graph as it backfills generation numbers, and it may have to walk
> the complete commit graph to do so. But isn't that better compared to
> silently yielding a potentially-wrong result?
I came here to say exactly that. Even when a commit-graph exists, it can
be slightly behind the object database and so we need to fix up the
newest commits with generation number details.

The biggest downside is that it becomes very slow when a commit-graph
doesn't exist (it walks all reachable commits from the starting points)
but that's typically better than giving an incorrect answer.

Thanks,
-Stolee
