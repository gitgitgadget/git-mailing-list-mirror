Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC449C4A5
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791299150; cv=none; b=ksdCeWSGEDo9vKEbHzTlTfp0q1bWD5bEAYOYJ7mxFjWK7oEWf0YEu5XPsUEu87WDLRMOxLxK0OQ5dVho2Wt3Gbxg4doJ5TN5ZRRKXof4oL/gWJGL5UyKdh+/l1X/diabdhZ29rlDNNA3HyPGa+i25iDqbmUyX+3q/9NAgMGC2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791299150; c=relaxed/simple;
	bh=LlIm2D1uRAX+fOOmi/cQS8+tNB6VnuwPCwejaNr2GVk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ObIwiSd47D/SAIInzoxb8DzJBegCn1m+4qe2456PhElKiEJyPb7vVr12TKNZ5oMLEDkc3NdKLOzZu+NwafNuH4JDawV1+LifSu/ntq9CiTLHLCMiXNYjrtuIh+Y1u1M7UtIxvUZhjRl5Q59Zo0XLpgt1Wiq/M168rXw2YOWcxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=narN0qyy; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="narN0qyy"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4207ac26so574209f8f.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 08:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791299147; x=1791903947; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W5g9uomVTln8UUa6RXZJKyme48m5LD38p+VKLhlqzYY=;
        b=narN0qyy7shSjrdoopQ3U/G4mgcWpbQEh08mjLzDG8pyDE1/WL9D8iNUu/bXeWyovk
         cPgmSoFRWLd1vCcDra0REwgTHcwI1qgvYvgAWGZ8/E0VuiuY/TUZ+JR0M5/RHEZ0Zul+
         GKCLVnaZk5lSKulc3AfLI5umY9vATJuaxfHTyq+fj+bm/FyxKTNeJEA8Y6AbGNmlz/Bw
         SwPe38/EXOipgj86J4PIl8pOsyFam2ZlMYUSH8P9ZZkMcJEFPnTDjitTLuncAns0xrEP
         9VpUGW/hvhOygTprYuyKlOKo9sasL48yv/din0RjOv0lnyhBhumoZ8tGzSmH0u6qKX0+
         fqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791299147; x=1791903947;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W5g9uomVTln8UUa6RXZJKyme48m5LD38p+VKLhlqzYY=;
        b=uRQmd+ObTBIHmLW2CatKM6oAYEM7TH4yv62vYidfC5PFCOkN4Wx2GX6D6CspLVgSiR
         cg1NPs1RdJnbwdCu6boXEJo5F87mLq7L5L91lxXlCB8rFVDJtJEvsIEUhZHSESoXMio0
         alFBYbUxTrmusj8pfbCzV+xQAPfvvkIoojysXsWm2h0CHSwuHVPc4oo3lzM/E97O67iN
         aIKAeo4r4nAi51qk2x79VqgPt5AsfmkwWu2K7tzzPjmrOB1CIja8VmDWOSGdBzO8FHgT
         CkPK2GUVECeVaz9/MQQ9f7kjbJycSrmA8Fds1h240L8RSRvQK/lfMhyL7/PbBTOxT5pn
         hT7g==
X-Gm-Message-State: AFq9FYLESFhR6eRjc2Ym8o6vzefAjXmdaUW6QaiECfSqm3egyMr41gqx
	kk5t8aSbxpeYf19+RmeTEFc/1QVVaszlefHoPn81lkQLHTcwqUZL+EP+
X-Gm-Gg: AYBFou3Qqz15JodZY1hDPi9GQvX4Hhy3OSSZd4tbfkGmDSqAKaToq+1jRIFq7NOmiJH
	UX7ocm7YbX9/fXOgFeOMslqWkFPkWQ5LA0pB1HLH+BvOYWo2zY4S/kaDA1gIM9D0r9bGmwzr0yl
	JRZsSlfbpXjACvDWE6LiAY8JjhbgToXnkXLt6RxFhI5CKsYVZh7fTVtEhVT9Vp0WQG0E+sTTDdQ
	gzRSvZlOm56LFtT0FcflKDlF1METaGCacpwCsf5vcRNnrLLFPKWy9Wnbo3DIqnrJ/0Wzsy6jLEl
	G92OcqQvg7Q28OEPnHm/W7PEKqvYCiC+emxbVqnHDdDXeCGvBbVGhZ9jYM2XEM1Qp/Srz+sXcP/
	sj0fTnmUNN++aX5kCz3cR31xUwWrf7DPyIXXBrg9q0YJlwEmOjej1F56wg8wCyCqoWhMCFn/Kex
	Awa2RuLIB/1zBxC7+ejLOZlDRzsSX7FQXIyjwD5gCo95rDfKEfucpDpOSHfBu1foSDWhl4zn/iB
	47R3c5TGjhbzvIeKo8sxb/+BE8MRXM88HB3sa/8cR+gg7RQkYTo
X-Received: by 2002:a05:6000:2304:b0:48c:6a50:cbb3 with SMTP id ffacd0b85a97d-48c6d208b09mr3211015f8f.55.1791299146828;
        Tue, 06 Oct 2026 08:05:46 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d113dasm113043f8f.19.2026.10.06.08.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 08:05:46 -0700 (PDT)
Message-ID: <9f3d7277-e038-47d6-8554-175178e911cf@gmail.com>
Date: Tue, 6 Oct 2026 16:05:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] merge: remember conflict labels
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Johannes Sixt <j6t@kdbg.org>
References: <cover.1790761727.git.phillip.wood@dunelm.org.uk>
 <cover.1791206658.git.phillip.wood@dunelm.org.uk>
 <18bdf7df49dde2c8e7f73f3b46c656abb6b26293.1791206658.git.phillip.wood@dunelm.org.uk>
 <xmqqbj98kt2d.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqbj98kt2d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/10/2026 17:31, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Note that merge_switch_to_result()
>> we assign "result->priv" to "opt->priv" and later clear "opt->priv" in
>> order to get a pointer to the private struct as result->priv is void*.
> 
> I missed this part.
> 
>>   		trace2_region_leave("merge", "write_auto_merge", opt->repo);
>> +
>> +		trace2_region_enter("merge", "write_merge_labels", opt->repo);
>> +		opt->priv = result->priv;
>> +		write_merge_labels(opt->repo, opt->priv->labels[0], opt->priv->labels[1],
>> +				   opt->priv->labels[2]);
>> +		opt->priv = NULL;
>> +		trace2_region_leave("merge", "write_merge_labels", opt->repo);
> 
> Would it be better to do it this way instead?
> 
> 	struct merge_options_internal *priv = result->priv;
> 	write_merge_labels(opt->repo,
> 			   priv->labels[0], priv->labels[1], priv->labels[2]);

Yes, maybe we should have a preparatory commit that adds that "priv" 
variable and updates the existing code that does the same dance. Another 
option would be to make result->priv a pointer to an opaque struct like 
opts->priv - I don't really see any advantage in keeping it as a void*.

> Also, with the way merge labels are prepared and passed around, I
> wonder if we should just tighten its function signature and take
> 
> 	write_merge_labels(struct repository *repo, const char *labels[3])
> 
> so that this calling site becomes[*]
> 
> 	struct merge_options_internal *priv = result->priv;
> 	write_merge_labels(opt->repo, priv->labels);

That's a nice idea

Thanks

Phillip

> 
> 
> [Footnote]
> 
>   * Here, I deviate from the usual naming convention to call an array
>     of things in singular (so the second label would become
>     label[2]), because from the point of view of the API consumer,
>     "labels" as a unit is what they pass around, and call it in
>     plural.

