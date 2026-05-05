Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BF3D8129
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778010300; cv=none; b=VBsoEt/Dlqn6yB+uQ0ZkvJFQ2X4iJ50Nhku8Shbs0Wx6MvkAAqOqSMWbYbMqhUFyc6YJjZtf/C4dhGDJTkUpzQw1NNRuv4FLaAqUVaUc8Ts6hl6B43Mof/UCyiogVILGNhXXoShRT6q7G20Utfl9XOHVRbEu4Znnd/uq/Xn/eEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778010300; c=relaxed/simple;
	bh=58qchqHy47FULDLYZhm33hPFCcSKzJvO5OilFlDQvuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAbSGF2lxyWcB9XvLhtpG449u9Ql1WUqvvEHU6P/mQR1ehotuL6LY1B2SVXJBE7l4WLw7wWLDN+b8wy8kjXd8sW1WklDq+8ViHx4WL9HxxwPRXsHQ/q5AhjP/TrKcIbntTWJsoGpkHtbfIE69ifuShg1VNWnUzYLoD9vCQuVdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M35CdG0o; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M35CdG0o"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8b5232009a6so45802706d6.1
        for <git@vger.kernel.org>; Tue, 05 May 2026 12:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778010298; x=1778615098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DW5qHIycJDeAx2j3x6CrU5z9+kQ7uA6u7PxEuQBgsw=;
        b=M35CdG0o00I+6YJ+M8o7Q2ScI4jc+O2eVcWE2+E9TKUwqoDt7j9s/pnb7GyoGf9U5p
         jraaN2Ya0boVL6NHKJLrrFeILIY5LpFEq8+tUYCye61Bk4hBgY8XFlIGJcoAdSWbXkee
         ZuRdAJ8VmkBy57bCXVlGqgc2gO9DziqG3j0Fo5G8V0DQSAIQ7mX0jm/zcVlZgw4ma4XM
         eS0KAhhFngugRRFC7Odp8y3Fbls2Jj6J7ras/YAdYnO62GnU1Gn8yiUgctnIDYyTPNDQ
         EgAK98irtfrb+YRvTFKi/n570JqlWH23eCSzeSB0yhHvtNLSHJTbw6mCNtiqJFFFqeeE
         sKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778010298; x=1778615098;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DW5qHIycJDeAx2j3x6CrU5z9+kQ7uA6u7PxEuQBgsw=;
        b=eDQZW+iijrfJ3Zm1byjzlLEnGcDi/F13Af+q2ALCj0voubl9a9kq8VPCG11soLIRai
         Ww0/pY+4hSvS+AeIUUgiE44TWYxRBMAwF/CwAzgqTH7Gah9lP7SzWhMv7psTJxZW6zU+
         F9hZPd4O8OXEZ1qCJvRGihnqgyCM9QKs6AaMo3wGCCMid1WDcacDSW6QnKIPMjiythA5
         58AQr6kD/+CnPCvz8R3WlwH6xs+ULTPPG+xdvym9Phe3QG8b2NQy4ZEIX0g+XCYpSQQL
         7dqyFU+9a15/9Hihe/6O7pQOiBzs9JgxQpTT9aHJUmL4yK06tvowpK3qIri729/493h7
         p30g==
X-Forwarded-Encrypted: i=1; AFNElJ8p155Bgn/lZdcTC/WSLpfKwpab3LlGuL9fMG783BBZ0Vjmdq4FuhA+eszAun9QLgOt0m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrzSfTt5L7Qb7+aF7SKMSM06iPAQfFPB24BLmFtcfWk6usH2xi
	T2vDkOpgr3vv45jU+gDQwKPdShR6/7xFh72nMqPOx6TRsahTH/qOmOzBr5tsiw==
X-Gm-Gg: AeBDiesG4JFqziSVgRH9kAyuvXiR2kXH7+W5ovBcWZCQZcEYxcwQNXrmMgBWJUyZiOV
	zU+nfRnIfC0isIdc8FmbXQoMFoaCn7a3r47QxhkUtMuOWQGa2nLXk8IclVf6YeFt6jRsnGUxjQ3
	8LibgL2QaBGnP+j8Es6+6QyMJ/kyklPBEj3+46mKIeLIYr8NKcDPO418pVq7jmZlUc16gZlFY5d
	P14qcGOvul0N50pNSU3UnUjKybErJ94PYyH7vSG0wqWZGWUOdkKUfuDBJ+v+HcUbHN4yWdxupfE
	GoFGKrQQw61CsDjmXyJ4cdSfp0SG8zMfPZoRfsPi6b3RtzluYK/rm1Yz0kNrfzxkWhfXxJV+qGi
	kxpCnTWTOAm6qURGy0ssj405L6QpuMGCaRsdyZMbBhSdECuDi9YCKu6IkOEGemyywIqX/0ev4Jj
	Y6vtetxlQTWuwxxQvWH9XWgwTjf3Y5JwWzYE3b4jZwRHbMbNWs4QwhS8v5Uj6B3WSexR0H/UGe8
	yx4n/kr
X-Received: by 2002:ad4:5ccf:0:b0:899:f0b1:7332 with SMTP id 6a1803df08f44-8bc443d6389mr2166386d6.32.1778010298007;
        Tue, 05 May 2026 12:44:58 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53cd84d65sm159440026d6.39.2026.05.05.12.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 12:44:57 -0700 (PDT)
Message-ID: <07b36bd8-376b-4a98-a735-0c0f75452c24@gmail.com>
Date: Tue, 5 May 2026 15:44:56 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] pack-objects: integrate --path-walk and some
 --filter options
To: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
 <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <f5d8d4aa-2453-45ef-bc96-2b94bdf55c7e@gmail.com>
 <afo+mEITFBSLevqV@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <afo+mEITFBSLevqV@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/5/2026 3:01 PM, Taylor Blau wrote:
> On Tue, May 05, 2026 at 12:18:28PM -0400, Derrick Stolee wrote:
>> One thing I discovered when testing Taylor's series is that this series
>> introduces new test failures when run with GIT_TEST_PACK_PATH_WALK=1.
>> It's probably due to new cases that are fragile to the difference
>> between delta compression algorithms, but are now exposed after the
>> filters are no longer disabling --path-walk even with that test var.
>>
>> I'll make sure these are fixed in the next version.
> 
> Thanks for looking into it.
> 
> It looks like this bisects (at least in t5310) to "path-walk: support
> blobless filter", which is 03/10 in this series. I suspect that there
> are other failures that are indeed due to delta selection sensitivity as
> you note, but in this case it looks like we are actually not sending the
> right set of objects:
> 
>     + git clone --no-local --bare --filter=blob:none . partial-clone.git
>     Cloning into bare repository 'partial-clone.git'...
>     [...]
>     fatal: bad object 782f60206c837dcd3d441e106549ad6f58de55b5
>     fatal: remote did not send all necessary objects
>     error: last command exited with $?=128
>     not ok 26 - partial clone from bitmapped repository
> 
> I think this is a consequence of us not sending directly-referenced
> blobs with `--filter=blob:none` when running the filters through
> `--path-walk`. Something like:
> 
> --- 8< ---
> diff --git a/path-walk.c b/path-walk.c
> index a4dd197c37e..dbad01287e2 100644
> --- a/path-walk.c
> +++ b/path-walk.c
> @@ -159,8 +159,8 @@ static int add_tree_entries(struct path_walk_context *ctx,
>  		if (S_ISGITLINK(entry.mode))
>  			continue;
> 
> -		/* If the caller doesn't want blobs, then don't bother. */
> -		if (!ctx->info->blobs && type == OBJ_BLOB)
> +		if ((!ctx->info->blobs || ctx->info->prune_tree_blobs) &&
> +		    type == OBJ_BLOB)
>  			continue;
> 
>  		if (type == OBJ_TREE) {
> @@ -495,7 +495,7 @@ static int prepare_filters(struct path_walk_info *info,
> 
>  	case LOFC_BLOB_NONE:
>  		if (info) {
> -			info->blobs = 0;
> +			info->prune_tree_blobs = 1;
>  			list_objects_filter_release(options);
>  		}
>  		return 1;
> --- >8 ---

Thanks for this suggestion. I got pulled away from my investigation, so
wasn't to this point yet.
> fixes t5310 for me. I haven't looked into any of the other failures yet
> since you mentioned that you're looking into them, but let me know if
> you want to tag-team any of these.
> 
> (As a related side-note, I noticed that GIT_TEST_PACK_PATH_WALK=1 is not
> currently in the TEST-vars CI build.  I'm not sure if there are
> historical reasons for leaving it out, but if not I think it would be
> worthwhile to add it.)
I think the initial idea was that the feature was too niche to add it to
the CI builds right away. Your series is going to make it a lot more
important, so adding this to CI builds may be valuable.

Thanks,
-Stolee

