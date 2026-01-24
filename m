Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03C246BC6
	for <git@vger.kernel.org>; Sat, 24 Jan 2026 10:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769252064; cv=none; b=aaee/CPs4nBrXHifMqwUCL5tE6l//ofBUgwZCTA8E7X2Mg88C1hn9nzk3Z4Dx4Ay+v3mJp9R/vEeLzxexDkKoe5nxQF8L3vwnOiC2dwA4UknvQV8E8TlJu8oEJGs+mErTAZXoL7d7f9fNDnR1NEZX8k/tsYvpsudkzQmi3vsWtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769252064; c=relaxed/simple;
	bh=Km70estWm3DkVkYkCI7BVooBWlbIPLncRrQyKhzLslQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pa6XOJRudHSYskNDxwBDZFjvlCRRfYANHzu+he6jUXebKfcj3FGXcCqgzkdoxapRnO50MfCWaj9XWyoH8js83y7JelZZY6uaQuwS51ogWlV2YAf47VEOBFvi00PSA9rSmDIDoRSVnSLKC2BO/TSeK0mZhRBv1sEb0A+3A9AxBvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Us1hUsYd; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Us1hUsYd"
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42fbc305552so2614326f8f.0
        for <git@vger.kernel.org>; Sat, 24 Jan 2026 02:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769252061; x=1769856861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zkaWJn5Jzps6T5Gnm6y+hKik3V1lhl43/3vlEqkK944=;
        b=Us1hUsYdimqKruvlEdVmja1IEKmAhL5VnriWhWWIJuldxM0ZCzbULwtDsZdJn6rAN1
         yX1zgXKbIFq3JnIUBfh6VDxYZr9SYtCqeta3+k0ElVmZddt/P0Ys81qnFjC9NMvOrozg
         5MaG0ZMJrvhxx0leU5Xalbe2x8VtG2UQjwCFZmKuC+tunz9CLiNbooyDc2HQnkMVBHKa
         or2EfvoJXZ/sZ7qJtwtHsSSKgQ7evRg8wV6eTe7TaLJgiyC3HyMqt4jxCNLuM82lK5bX
         Td10aO7GgcmrAOVT56XI7jbsZgJdMfdk+tY2kWhsfpdWcSIaGmWrnhkFyg2J62pEzxr4
         lQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769252061; x=1769856861;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkaWJn5Jzps6T5Gnm6y+hKik3V1lhl43/3vlEqkK944=;
        b=LDdgl07Qa+sKSddOKoFxKbZbON49iMdbEW9Rc8f0QBBVPZ7TVuwm3P8e8zsx/sVGnE
         LHnHgPhSSRlT3rfUHG/D/xGI4NX0yE43gM2Vny32JCm4w0zfwxDGXitQ+zw29FKJl3Bl
         OejxVcgYntSq6jQT0QPGZrCP9gPKkBx2Ds+mJa2sJpk/dyW7ILI6vRr/ohC6ompNmPXJ
         IGmqdQdnisTs7gfcRnAhDVdkG0vrAQPoOJXISsljA3Pm/ixHakZgy+8UXI31cjlgtqv7
         hU4GHHbEMPJ85beBRtcvjA7FsXs2uXZcKnV+nXu0icI9Cx9R0KpGkBMT71JnjSUKVM/g
         5uEQ==
X-Gm-Message-State: AOJu0YwRYIB206NB3uhGsZ7FRvoVCYZLlFEc1Ze19MjuumL1X57ajB7M
	9lSgJKG9mdtCOlz2lSWww2pB99UOB/GQhkBUQUNmuynZzNqq0/hm16R6
X-Gm-Gg: AZuq6aIqsuSkeddhYHEuaevBhpSo9XTA/Pew3oLFyvz3ErUQO22i8J4f6Ku3kxb2ASi
	jQ29qd7XTQNSjMO9jqgVExLGuS2Upm4MC86IifavNGDPQWiHU1KmD5+uSv1bDKF1KKjl1OHqcAY
	fZ2QfaOc9mMMcEzvCeL3fz6dybDi7ho3U6o6ukZYOvzT21px2S46gzUgJMjBqtoCFjCegSr6Fww
	QGHZERIThki2Gcr3HUZt/aWPoPorfN0A67JwPJ+kHHMaKfK5YP5YoNzo1gwWtEwMO2xVE2LJtHo
	VIXVgEffOjd+iPbUyRirw+IZGQM2MGGxOSwoo51n1BuPvTfaHMgl1/qs+rAhj71qeCCKbinCfH6
	8vnGoKQMHAivuim+wmbs6ybvjrVZVgfSZrHu0DAYDw60a2O/3V7mcYLR78YecROxN5oE2WzFq4v
	pck6BIQJwGiCoHWEBQw+zRzTfYTWsejr7Bmfl1a1d59rBxuBXZLGp5CE3eptQbjeGH5w==
X-Received: by 2002:a05:6000:22c1:b0:42f:b707:56f0 with SMTP id ffacd0b85a97d-435b1605719mr10728150f8f.37.1769252060766;
        Sat, 24 Jan 2026 02:54:20 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24f15sm13891551f8f.18.2026.01.24.02.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jan 2026 02:54:20 -0800 (PST)
Message-ID: <4fa413ae-f2a4-4de2-a2fb-0b1db379750b@gmail.com>
Date: Sat, 24 Jan 2026 10:54:14 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] xdiff: re-diff shifted change groups when using histogram
 algorithm
To: Junio C Hamano <gitster@pobox.com>,
 Yee Cheng Chin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Yee Cheng Chin <ychin.git@gmail.com>
References: <pull.2120.git.git.1765054287938.gitgitgadget@gmail.com>
 <xmqqikcusn8p.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqikcusn8p.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/01/2026 20:51, Junio C Hamano wrote:
> "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> @@ -915,6 +919,45 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>   			}
>>   		}
>>   
>> +		/*
>> +		 * If this has a matching group from the other file, it could
>> +		 * either be the original match from the diff algorithm, or
>> +		 * arrived at by shifting and joining groups. When it's the
>> +		 * latter, it's possible for the two newly joined sides to have
>> +		 * matching lines. Re-diff the group to mark these matching
>> +		 * lines as unchanged and remove from the diff output.
>> +		 *
>> +		 * Only do this for histogram diff as its LCS algorithm makes
>> +		 * this scenario possible. In contrast, patience diff finds LCS
>> +		 * of unique lines that groups cannot be shifted across.
>> +		 * Myer's diff (standalone or used as fall-back in patience
>> +		 * diff) already finds minimal edits so it is not possible for
>> +		 * shifted groups to result in a smaller diff. (Without
>> +		 * XDF_NEED_MINIMAL, Myer's isn't technically guaranteed to be
>> +		 * minimal, but it should be so most of the time)
>> +		 */
>> +		if (end_matching_other != -1 &&
>> +				XDF_DIFF_ALG(flags) == XDF_HISTOGRAM_DIFF &&
>> +				(g.start != g_orig.start ||
>> +				 g.end != g_orig.end ||
>> +				 go.start != go_orig.start ||
>> +				 go.end != go_orig.end)) {
> 
> So the idea is to remember the original values in g and go (the
> location of the group in the file and the other file) and if
> shifting up and down changed any one of the four ends from the
> original locations, we always take the fall-back route (if we are
> doing histogram)?

I'm a bit confused why we need to check both groups. I think they're 
supposed to move together (if we move "g" by n context lines we also 
move "go" by n context lines) so I can't see how we can have

	g.start == g_orig.start && g.end == g_orig.end

when

	go.start != go.orig.start || go.end != go_orig.end

> By the way, this appears after the if/else if/ cascade that has:
> 
> 	if (g.end == earliest_end) {
> 		... do nothing case (case #1)
> 	} else if (end_matching_other != -1) {
> 		... do the slide-up thing (case #2)
> 	} else if (flags & XDF_INDENT_HEIRISTIC) {
> 		... do the indent heuristic thing (case #3)
> 	}
> 
> Am I reading the code correctly that, even though this new block
> appears as if it is a post-clean-up phase that is independent from
> which one of the three choices are taken in the previous if/elseif
> cascade, it only is relevant to the second case?  I am wondering if
> it would make it easier to follow if the new code were made into a
> small helper function that is called from the (case #2) arm of the
> existing if/else if cascade.

That's a good point

>> +			xpparam_t xpp;
>> +			xdfenv_t xe;
>> +
>> +			memset(&xpp, 0, sizeof(xpp));
>> +			xpp.flags = flags & ~XDF_DIFF_ALGORITHM_MASK;
>> +
>> +			memcpy(&xe.xdf1, xdf, sizeof(xdfile_t));
>> +			memcpy(&xe.xdf2, xdfo, sizeof(xdfile_t));

These would be safer as "xe.xdf1 = *xdf" so we don't have to worry about 
getting the size correct (sizeof(*xdf) would also be safer but there is 
no need for memcpy() here).

I also wondered if we need to do a diff or if we can just mark the 
common prefix and suffix as unchanged but I suspect that wont will work 
for more complicated examples.

Thanks

Phillip

>> +
>> +			if (xdl_fall_back_diff(&xe, &xpp,
>> +					       g.start + 1, g.end - g.start,
>> +					       go.start + 1, go.end - go.start)) {
>> +				return -1;
>> +			}
>> +		}
>> +
>>   	next:
>>   		/* Move past the just-processed group: */
>>   		if (group_next(xdf, &g))
>>
>> base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
> 

