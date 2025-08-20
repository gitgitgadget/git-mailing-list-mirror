Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F931CCEE0
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718956; cv=none; b=RJgNQYhs+Zhn06kV6J/aK0A9Ni5U6X54ciuwEvjWl/YJC8MJavmH/JkwOMdWbYsWTGHdSHONCwTYEJK0a4LPHTGRr0QlfM67lRJ+J2YQ+CBZ/SIeDNaUT2R3EPZI2lrTBcglGp6MjJqpyDmbVpbWZ9YUtpEJqSj05MyXnqXxVn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718956; c=relaxed/simple;
	bh=2Eyp7rBIsn95tG0LfeGHSnLsHqarp+QevB14BDJ6FuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJXyru7Rlm1N8zcWT+/IjxVTK/tR0uISM7niUarW8eOysCNamGbvEQfvLxMdK+DspaN4IlPaRkFacJ9TrUZHYSheFCMrQe9K+dEybujV2MBHyqJG8U9Q9mU7LoFsUYKjDYM2/1relTtIx0/PxabUEufVrDlIhEii7nCk24R+rGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0jc/VOp; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0jc/VOp"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b1098f9e9eso4538531cf.0
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755718954; x=1756323754; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsZfDQfAJX0fqoy6+pTGZ4LATQVjI8xjYGpruAEt69k=;
        b=h0jc/VOpqZOND0px6VVVkzhO6lmQoaO4qQby43WaSnf2CZfSu0tA3DH6QiG46Q9RtZ
         o1bI2Uv9LZD2SPsjT1EbVDjbmWDfkan08rj4O2SNNYfjc1YRLLi425MzhDf1Out+Q2D/
         J18GGKL0P3zkNq5/iXgPCmFOLghLCZcpRHhlXilxKMemJgK2TKI9QnSvQUhPdOQVCI9l
         xdAxbDKzqnhy/0fAqX4I8HkcplhfeiekAyPe1e3EjGsP4BLN+NHtZTFFbo/iChjxNaM2
         Iw0VWtCQBe3N3yZOQdRLaESq1XEpMlFA/AQVRkHxMog/84aWcgk9i2yNfknbGErYLDRc
         y/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755718954; x=1756323754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsZfDQfAJX0fqoy6+pTGZ4LATQVjI8xjYGpruAEt69k=;
        b=SqgfQvss66dfVYYdDdTmZ2L5Q4NqZxRyaZDGsOmJSj61E00z/M7bAT+gpMZKGEzkn0
         x6LAoSSjzRbYLRxprDyvPwsILd/bfEwIrvniy8S1SFPv/mbq8wFw6fb6dBnOPerNRMT3
         Q2KEmrmjuP4OWa0ggyp5wE6kjArsF7iddm81Vfv4VIk6/45nPQ0ebhT4p+wFMbVsuOPm
         rdDVkY51SmyHaLPBXxAT1TO/lva5hexlk9PNtlYnuPB50sZMXBe+yXhHMnFK42TPmPGI
         Ggxoz6Fv1j7vF2WP+ynBsCN0+oad9WbN74M5NHymYNHDkUab17eZqYVoRqfcqOoyOzXo
         86Bg==
X-Gm-Message-State: AOJu0YwAQMruzrFiIzD4WCK6BRTprMaRXr0JfMKB1umecdEuafaXveor
	zw3x4Bj5g4CvwN8bhJMDX8VLySkmSZIkr986fLtJL5b+tJlYvB04neU5
X-Gm-Gg: ASbGnctlPFVdxbDomPD8V/YQqPsVuz/LZSzZpw0XnqKPK5V4o6MbgToNfRNCptcoosG
	Mr/ZjYTrPGoeFa1ZKt4e+fLXSPVLpOBTVPCBjmAmKHMn5w82jmhuL/qDqq/iR2AeLsvYYTLXEbg
	nydCJxcgGgFyogebtFLHNgpHYDKNOccXQeKKKwGeHx7Uw7cPSJZEgHIW1G8Yhf8W/iCZ9nf/nvP
	0JLoUOMgRwGkrQN+dg8hKNo55dbzSpJ4nAb4Cg7hSjej66k/QaV3n7gr/Tzy+l3DdKYUuQxHqCk
	7KQPE+neaq+j7ruTZosMHZRZ+cejjTT4YnWBhprXiiwNSlfikUxYAo0HTMMUrahW/MGPPcGkDI6
	aRUGC+dszBm/o79vc9U13eBjrwO7acJenaSc=
X-Google-Smtp-Source: AGHT+IEBQtAmT5FD0J82OB3SRIMbj4bvBwl7nhruXTHMapNJ2ouHX3LA7YEtIEWScPiK4gErut8ObA==
X-Received: by 2002:a05:622a:5c0d:b0:4b2:8ac5:27bc with SMTP id d75a77b69052e-4b291bf69a9mr50954051cf.71.1755718953735;
        Wed, 20 Aug 2025 12:42:33 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1926b3sm980699285a.53.2025.08.20.12.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 12:42:33 -0700 (PDT)
Message-ID: <c6ab0985-2a74-406b-9685-cc65f8748515@gmail.com>
Date: Wed, 20 Aug 2025 15:42:11 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] path-walk: fix setup of pending objects
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, me@ttaylorr.com,
 newren@gmail.com, peff@peff.net, ps@pks.im
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
 <0dc4a6323e66598070b403d286ee1918e6a9b791.1755715196.git.gitgitgadget@gmail.com>
 <xmqqh5y1ak9o.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqh5y1ak9o.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/2025 3:02 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> The core problem here is that the "maybe_interesting" member of 'struct
>> type_and_oid_list' is not initialized to '1'. This member was added in
>> 6333e7ae0b (path-walk: mark trees and blobs as UNINTERESTING,
>> 2024-12-20) in a way to help when creating packfiles for a small commit
>> range using the sparse path algorithm (enabled by pack.useSparse=true).
> 
> OK, in other words, the bug is fairly contained within the path-walk
> traversal.  We treat things as reachable not just from ref tips and
> reflogs (where path-walk code can use the tree object to compute on
> what pathname each blob comes from) and the main index array (that
> has paths, even though it needs separate way to compute than those
> for trees), but also from places like REUC and TREE extensions that
> make associations between pathnames and objects.  Are they also OK?

The key integration point is the "pending" list operating a bit
different from walking directly from tags or commits. I was trying
to reproduce the issue from all of those other sources before unlocking
the "singleton" nature of the problem, and failed to do so.

The resolve-undo cache (REUC) is something that I had not tested
previously. Adding "git rm --cached x/y" to the test in the previous
case leads to the 'git fsck' call giving a "dangling blob" warning,
so that could be an interesting way to strengthen the test. Thanks,
-Stolee

