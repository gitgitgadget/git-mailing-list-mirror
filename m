Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7437FF48
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781880055; cv=none; b=InI90h8pLHKPGFJLBHXDRiJgRk4eATu4Unnzb3KpW+fKp3WIEKRQOySbk0RKlhVWqJj1a8jsmo3Zz6w6Aed7htf54+dakV1VEhGypPtsZ95326EX/jZsr9nORaasV2C1HWtHKpJmHW+LlR4BgMz4aJ64h/GJbze4H1FQ71q0FlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781880055; c=relaxed/simple;
	bh=JfCeLLtFcFJ1xsDqSuLm/XaWrG5EsdTeMp6i3SzZg5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAB9fzVMcPAxZsKTgEwlH6lNGr/u5ejJgrkRMa83KaTHltSQC2vBY+stsozzM6IILliOWN+Qyv+YL5lTRyDc4O86wO6xz83bhUjbQuZAy8qfoBJGUhC5RSyeRptc3IK3caJrvk6DG1AnirjEbXFX2UPeTC1hMgzj5jXh5lrAZG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQK9bSKV; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQK9bSKV"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-6efdb57db0cso683127137.2
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 07:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781880053; x=1782484853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/yxMyWYEE1BimgOmLVUWfpVbcuQU4bpGOzdUzpo7zlU=;
        b=qQK9bSKV+NpoS6dhFaiOKbWlj4MBu8GL6QPZHaRwvHQYI3+x7LdB5E9nR1EW/E4e7J
         AARM8RcBuLDOtUtEA3F9I7+kkWBPPgKyu3h5rbFJSqmNRW80BBkOhTkaa5gOIaUQi9BR
         64V6IZ/kPDXi78jHqFKGO0/dHalrMEFlXyOG1leXVbGAJYv+07lQxoddgDc2Xs2GB51e
         8kws3dcFWeH96H/LAHdrReP2kXR1Hh8qMdUG/tbLbLUl45J4zbcJhqygeoJg8b5+QGCt
         +ltGXWKxZAyXItrlkU9ru1rmcLBnvUuFoDffO//0mY31kKPpApZksbA3h9oLICHKwP6/
         627Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781880053; x=1782484853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/yxMyWYEE1BimgOmLVUWfpVbcuQU4bpGOzdUzpo7zlU=;
        b=o+dJxgMwunopc0gerJq0UoTagNowdVxqlfmQk3UIfk7OJDEsaypPCDqOkg3Yz5svor
         J8n+GqkcMDbsCanHzJb4Eh/wwxXPkJ5lo/P4arVl59c6qls6pD1rFwo6awNg0JWSesnf
         9ukDZcadMHUDxycu6YdEnN6abQyhPYgDri2THzKlr8MKKuqKNRHVoJCv3GNul7bf5eyG
         U8hE5IkMzj+vneObMxTiGWaodHMM33EoVPkhnXo/CVZLQackSd3+kH3gkzkmGzB11rFD
         w4i81tW/NHXe2NQN/943M0NCXicd5ZhURmrIXGtskhMlfeh6q8/oQooRZlmyAyWMVQLJ
         /QPg==
X-Gm-Message-State: AOJu0Yw7sDpvT0K37AOyykgKhi0ZTJrOjsD/CAgHvdzIs90iiR6vfS5H
	eDWRn79CXmk/xsDqKvPPVzy5y2JIcYQOQip8MBVmeh6lUxJ6dWo2nCQo
X-Gm-Gg: AfdE7cmezzacyAEgKOyvBR/CtbZb66azATCiVnW6BD/eeF3lzIssgJaDW7I8sPsadPC
	BLRuleOccKQgVZB88W6AWTuYfm1l5+i1VD+b8pTi1LdQ5/bwxz9VuSMHcLuqwfGHuXsSS43OcYS
	/GUfTYu27oRba6HRwmAAxbkqyElbbguIPaJ08tedJBEMoL5V5Ca82qeIjfNm4V63ccfwnEcVDc0
	QuB66YQcnHquaSx+eWSazzW/XOsfsZvmNnojAN8AqjHV3hGB+S3cV+wS40hZvo5cXem8eINw4cX
	ecZ2MsM/G9oY8cxbf44Pcs3WWbwZOqVmuTDsoEO8KbZrXIHhKCQwZlBJU9qsjb3hCRNHS12hUnL
	3nBEU92u2hGUn3HODt2f967N9bylmsa94zzyHtGcBomNqTFC2WavPTmR9DT+JMQ5qveImmgIC/j
	/p0QlSjke2npnEYJiNSXXHryma7j+R3eHTDMuLMVsujfG4qhBM04lZTlrpgQ==
X-Received: by 2002:a05:6102:b10:b0:6c5:d55d:c090 with SMTP id ada2fe7eead31-72a75fa1ad4mr1603370137.3.1781880053166;
        Fri, 19 Jun 2026 07:40:53 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81cdf302sm108046d6.30.2026.06.19.07.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 07:40:52 -0700 (PDT)
Message-ID: <131d7ad3-7791-4d6f-bdf3-afa6b0831a71@gmail.com>
Date: Fri, 19 Jun 2026 10:40:51 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] pack-objects: support reachability bitmaps with
 `--path-walk`
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <cover.1779923907.git.me@ttaylorr.com>
 <cover.1780438896.git.me@ttaylorr.com>
 <ffad584a43ebf3cb2138e8dce7daef84ab72712f.1780438896.git.me@ttaylorr.com>
 <849c659f-efa8-430a-bfac-0c26a3ed1aaa@gmail.com>
 <ajVSHvL+On9AEV+g@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ajVSHvL+On9AEV+g@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/2026 10:28 AM, Taylor Blau wrote:
> On Fri, Jun 12, 2026 at 09:24:32AM -0400, Derrick Stolee wrote:
>> On 6/2/2026 6:21 PM, Taylor Blau wrote:
>>> When 'pack-objects' is invoked with '--path-walk', it prevents us from
>>> using reachability bitmaps.
>>
>> My earlier response focused on the _use_ of bitmaps when creating a
>> packfile, but your patch also enables _writing_ bitmaps with the
>> --path-walk option, which is significant and potentially more
>> interesting from my perspective: we have evidence that --path-walk
>> can produce significantly smaller packfiles than the standard
>> algorithm, and once those packfiles are created we can benefit from
>> that size in later packfile creation steps by reusing those deltas.
> 
> I am perhaps splitting hairs here, but I would frame the use of bitmaps
> when reading with "--path-walk" as "either/or" not "both/and". The main
> goal of this patch is to enable us to still generate bitmaps when
> *writing* a pack with "--path-walk".

Yes. I was confused but your response to the earlier thread made this
more clear. I'm no longer confused. 
>> Even more important here is that we have demonstrated examples of repos
>> that change their packfile size when using the --path-walk method. We
>> should demonstrate that the size continues to shrink with --path-walk
>> even when producing a matching .bitmap file with --write-bitmap-index.
> 
> That's fair. One way to do this would be to:
> 
> --- 8< ---
> diff --git a/t/perf/p5311-pack-bitmaps-fetch.sh b/t/perf/p5311-pack-bitmaps-fetch.sh
> index 1b115d921a1..c1aed3e2aef 100755
> --- a/t/perf/p5311-pack-bitmaps-fetch.sh
> +++ b/t/perf/p5311-pack-bitmaps-fetch.sh
> @@ -18,6 +18,10 @@ test_fetch_bitmaps () {
>  		git repack -ad $argv
>  	'
> 
> +	test_size "size of bitmapped pack ${argv:+($argv)}" '
> +		test_file_size .git/objects/pack/pack-*.pack
> +	'
> +
>  	# simulate a fetch from a repository that last fetched N days ago, for
>  	# various values of N. We do so by following the first-parent chain,
>  	# and assume the first entry in the chain that is N days older than the current
> --- >8 ---
> 
> , which gives us:
> 
>     Test                                            HEAD^             HEAD
>     ----------------------------------------------------------------------------------------
>     5311.3: size of bitmapped pack                           278.8M            278.8M -0.0%
>     5311.38: size of bitmapped pack (--path-walk)            278.7M            278.7M +0.0%
> 
> (eliding other tests). I considered whether there are other interesting
> tests, but I think "repack" is the right layer to run perf tests, since
> you're always writing a closed pack. We could try different subsets of
> the repository's objects (which would also have to be closed), but I
> don't think this is that interesting.

This sort of thing does help to show that we're getting different
behavior when repacking with and without --path-walk. And this test
is showing the slightest change for git.git, but is likely more
impactful for the other repos I've used to demonstrate the benefits.

So this is the kind of data I'm hoping to see, but also with data
from other repos whose data shapes benefit from --path-walk more
than git.git and repos where name-hash v1 is sufficient to give a
similar result.

I'd also like to see if the repack _time_ changes with this, but
these direct size comparisons are the biggest indicator I'd like to
see.

>> The other thing that I notice here is that the bitmaps will need to
>> compute their reachable object set independently from the path-walk
>> algorithm. But I suppose that already happens separately from the
>> revision-walk approach that normally produces the packfile contents.
> 
> Right. The only wrinkle here is how we handle the internal traversal's
> "--boundary" option, but see the last paragraph in the commit message
> for details on why the proposed approach is OK.
> 
>> >From my perspective, the point of integrating these two things are:
>>
>> 1. Reachability bitmaps make it much faster to discover the reachable
>>    set and reuse bits of existing packfiles. (Your performance table
>>    demonstrates this is true.)
>>
>> 2. The --path-walk option can shrink packfile sizes by grouping
>>    trees and blobs by path before those paths collide in the name-hash
>>    sort. (I haven't seen evidence that this is happening.)
>>
>> With evidence of (1) and not (2), it's not clear from the data that
>> these features are integrating completely. Without looking at the
>> code, those numbers would be the same if we had instead swapped the
>> preference of "the --path-walk option disables bitmaps" to "bitmaps
>> disable --path-walk".
> 
> Let me know if modifying the perf test as above (and including the
> relevant results in the commit message) would be sufficient in
> addressing your concern.
Yes, the perf test modification and data reporting is the only
missing thing at this point. You've helped me better understand the
"integration" between the features during fetches and clones.

Thanks,
-Stolee
