Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55519355F5F
	for <git@vger.kernel.org>; Wed, 13 May 2026 18:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778696954; cv=none; b=WkIPWDUAs8iwc8owcO5/IB4WqRLA/6Nw+7whlWgGQTSITem7x9NATHbgpkAlHwTs90n0CAQ88qxG8jr7IHYTUYlEgeq8KA1WBHS9uBvwtAgj9dmJFFYDbn3IWMdNxdNpTq4JZQhA/eN+BZyLYSlrJ7XfOKUAU4snpNX7InPXp88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778696954; c=relaxed/simple;
	bh=/JQ1h7o7q6M3eXTryKDaJroGCJ/GfGXzGcShflciMew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tqa4qgRGftfPFKKX0KTMFBjSEx/FuvLNyhCrctfsy3mya3umk+88i6yqTtXoxkuLH1pIunhI8qXieUZdB1PEhKKNL4jEGHS1meO9UWoCwrGvflEgu6/J4mC3sggRD4Od5velZjK+IcxEAXRGw5J0iuSUIdRr1hqeNKrIgEd2oCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSa2cdjL; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSa2cdjL"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-90d13fa59e8so240921585a.2
        for <git@vger.kernel.org>; Wed, 13 May 2026 11:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778696952; x=1779301752; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3MPeyOvlGSGEgMrcPC/3PykkgZs7UKYngvtbENff9o=;
        b=MSa2cdjLkUdfyiBM1cWMKD4jrC0sUZrA2DIwnnLWJzaB6eOf4jhT+N9wq2a0QGj0+r
         LvdcEGBwtQnN5TZAql8s8mOwvD6kgr1cL5Dq0hIropDQneN3fAZFfSTuqo4C8CLEYhZa
         k6xzcNjREtrw/3/8/1t8VcA0pbrY5zTNWsgRGXemqJK1OrkyR+Bv1wCtiBePPxZntBRv
         XyH9s+myQcULykkISwZ0N3BtlH/ONVETMg76xgoVKe+IH9aNyDMpaegT/NlL0ldNYUtm
         E6kCB4L9MAhhs8flb0FKXJCL2vcsvvN8T6qBdxn3r7f+JL6MoQaQgXxud4gyDWXBK8Pk
         QcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778696952; x=1779301752;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D3MPeyOvlGSGEgMrcPC/3PykkgZs7UKYngvtbENff9o=;
        b=GG6LRNWfhnu9vf5VBUlNSHIlzRqnHNNh90HMjkiX+TwtjnJMHiVpY+uOGnoNrIui1X
         HFMgX/lKIRSWKm/lp3A+kffeLun2j0PpBIZvzcE172bCI9GL69A1VHrVbFQuNFtjwcvT
         QcFfZ2buTlu4wtmFy4jP6BxkZuVcqYYOzHLgBd59Zfqbs+FsAh3d+EenpcKjMQrtKRYj
         bdEcTFw3dPT7WqpMqIZcOux0YmKw5JthJ+RHSAkLVx/AfOLpUwEBpu2xHv1g4kY9Nvvm
         b4EWeAUbCwCU+61PDd73jCBZJqcucR60yburJ/PPqOzMzfGmGzPMqm0lqFrt6aIWdPy6
         E31Q==
X-Gm-Message-State: AOJu0Yy7KYPt0myZOIFsL67IGn5+3SYvMs+izdUdf9dBTjgaO5x3pS6D
	HVcb3GoIsFk2YHqhuiomvsqrNYnarrr+fO6k7jhbPeABS3PcmL7vj3pr
X-Gm-Gg: Acq92OFYm8mXLYP2X5Rl8sxc3TTmWQ0rMLsFzS8P+pgZ5VWt8dqBfLHoSMsi6tsbzjn
	KrkBMptO3Q+wPixb2bKk/Z5frAdfeXHUhu0StGphrEPhBC99UJyjPoQWdzbFTwZ7dfAM5Hi192o
	u9arH1PfB4g3p0/6Upm+bxuOUW3L2w+fKZ4+ksEJfCW3OMjSzwr75Ud7+dcjkdXf+gE+CRN73vH
	s415tBJN4PZ8JVBpuJxj0APJuck0T06Iw9xSTq9X9zdLsmft7ymvqp88g/MqQktnvSfHY/8jEWN
	Kn1Kgb6kxbb+bUeZ2SPezfSAe9jFyPYd13n60rZhXRl6kLpTo+ymQGIhtHmHQSiigf6xPFR3syh
	7mTZJ4sqqT7vuihIzhNS9eu6J2MLoXM2kcFceMCZ1SsAuLK1Q5p/uxuI6p35sjQtFiRBMpRLfc3
	3IZvYb98o/Aky9BdezjeTg4dA5lZcXzMzM3KwX5h8cdQFfgVn36HqHu1yzoK3BIZ7w9V/m+w==
X-Received: by 2002:a05:620a:4403:b0:8ee:18e7:941f with SMTP id af79cd13be357-90f8a16312amr660959585a.40.1778696952244;
        Wed, 13 May 2026 11:29:12 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90b2dc41fsm2824496d6.25.2026.05.13.11.29.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 11:29:11 -0700 (PDT)
Message-ID: <b7465fa5-48c9-4c94-b886-0055f0696371@gmail.com>
Date: Wed, 13 May 2026 14:29:11 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] path-walk: always emit directly-requested
 objects
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
 <50933cccf508f71f47d955d5aceacad0db612fc5.1778523189.git.gitgitgadget@gmail.com>
 <agKBJJvBP/PndPMP@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <agKBJJvBP/PndPMP@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/11/2026 9:23 PM, Taylor Blau wrote:
> On Mon, May 11, 2026 at 06:13:01PM +0000, Derrick Stolee via GitGitGadget wrote:
>> We can tell that a path is part of the directly-referenced objects if its
>> path name starts with '/' (other paths, including root trees never have this
>> starting character). Create a path_is_for_direct_objects() to make this
>> meaning clear, especially as we add more references in the future as we
>> integrate the path-walk API with partial clone filter options.
> 
> I don't know that I have anything in the way of a better suggestion, but
> I can't help but feel like the `path_is_for_direct_objects()` check is
> somewhat brittle as-is.
> 
> I am not familiar enough with the path-walk.c internals to come up with
> a good suggestion off the top of my head, but I figured I'd raise it
> here in case you had thoughts on alternatives.

The brittle-ness is due to how trees and blobs without known paths are
added to sets that are emitted using distinct paths. The starting '/'
character does prevent the "/tagged-blobs" and "/tagged-trees" sets
from ever colliding with valid paths that were discovered starting from
root trees (with path "").

I could imagine a world where we store a more robust struct that has a
flag member to indicate that these objects were not discovered via
normal tree walking. Changing that could lead to this method not doing
what we expect it to do. But we are not in that future.

>> diff --git a/path-walk.c b/path-walk.c
>> index 6e426af433..59a7670c5b 100644
>> --- a/path-walk.c
>> +++ b/path-walk.c
>> @@ -248,6 +248,16 @@ static int add_tree_entries(struct path_walk_context *ctx,
>>  	return 0;
>>  }
>>
>> +/*
>> + * Paths starting with '/' (e.g., "/tags", "/tagged-blobs") hold objects that
>> + * were directly requested by 'pending' objects rather than discovered during
>> + * tree traversal.
>> + */
>> +static int path_is_for_direct_objects(const char *path)
>> +{
>> +	return path[0] == '/';
> 
> If we do end up keeping this approach, should we have a NULL check on
> path itself here? I think that could even be an ASSERT(), since
> something has gone wrong if we have a NULL at this point, but I'd rather
> die by an assertion rather than a segfault here if so.
The ASSERT() is a good idea to prevent incorrect use.

Thanks,
-Stolee
