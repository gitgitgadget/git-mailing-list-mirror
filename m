Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8EC140384
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478843; cv=none; b=smfUb3rLxEjIFnY61gGi2XUo86MkHtCQ0S3G+l0NVnGEihKVyj/LlOCm9j07vFqpanIDy5tuVf8HEkaOUVs5yOKCwWDI25+NlVAH1hduf1aGQiPAMXIdm/nneA5hNoC4KeuqD+Nqq+x3kWapjOAeEZ2Zom60y1Mb8w4w1wZFd/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478843; c=relaxed/simple;
	bh=L4QPNsuZ+Hrj2a8RvlBuxxSpIVu5RfF6Lcr9HSQx5XY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYnvyIC2P3pdFdn6x+NIyUI/O7/9wjfoek/3JFwzMmpxaUE56bRktzwp/crZ/O8EOhIyAnyvqCfRzoUNVKZUwtMCLZxfVJ3docIU1fvAzVA5I3OC+EMzv6Shj8ahAohRPx/Nmb+z19L31i2I9Ec96TUEOHCIt/6M4DJsxfATTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHENy/Rt; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHENy/Rt"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-233e41de0caso2853605fac.0
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714478841; x=1715083641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=LFXS8CbG16b+Gc9g+yX6auxtfloQigKg54kyPJJJ9rk=;
        b=EHENy/RtMkYX8LQ242OlHwPdnJMNUsAlmv5X16hzZbcuLhnBi0nq+kWIrQjYhvz1s9
         9TawUrZuMTcq9t4eY0AlbvCZBSCHH4GI6a8vgFEZNAumgsIIqwNqYQSyWgRf/33CJDjZ
         A1+Pi34OB89z3Zirrb1xlI0irMwFqVQs7P57bkYbgdj/PUBZBh/7qJzxTqvrS9XI0HjT
         43OTZEK83RGPo7j99NUPYcmxOqDF8yfl0ea+G31eZPQO5p1sZZaaIAjYKzJMWqXS5mwm
         k9E6rB77ny3ysAmpW0x+9enUkldShMBJFDT2Fhf5KUjhYAW1n0ZGo5Ylt2zIe1kQZ8tj
         wfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478841; x=1715083641;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFXS8CbG16b+Gc9g+yX6auxtfloQigKg54kyPJJJ9rk=;
        b=pA+kfpwcHUbRBnak9aO9lupx+CPqRd8UnamZuU1HFpcFbk09IxbDpp4HGs8s/RGGEj
         Xxf3PuEsnJnKuLjTL0cxRtYyfQaWeGDOyJRpWwXn9cWLJm91JbLNmJnGb7OO+iw2+8Bh
         6UHkkzATk2JrKEmbNWZEYeYu+KSfR8gRPYmUbxK4Wh0kdaUQsLRjxkP1p6G3tClMESPg
         GSnJzeoNe9ex5krF6KROUH9sH1VPL9FkdsqFZfsX0eZeMT1rl538qf6YpJiH3PQ6Qn3w
         5BJq5/twqC/uEMzTx6ugTcJ01GWjy0WPsXeEqtDlZrrSDHqzgV9lcbHuGXOgisxuH/2A
         StWg==
X-Forwarded-Encrypted: i=1; AJvYcCWnnwLQLhiLFDxHRr134QN9Z3KZ+S/nAsCUSK2W/lrImmJrQid9uNUJ5ZUKP7Sc6MQI3qhtPSOWxGk2zBVl1531UJGO
X-Gm-Message-State: AOJu0Yw4BGng00OgHOqu8ezwEUNUG0/l8JlHGOXSSv7/xEjPhg6gSejB
	gBdEaMnpKK2vGaYfS8q03laf/FocjSyy1IF1jPpSKhONVN+p+D0mdZdCNvsyaocQ9G0HLdX7hvc
	/FTCtz4gEuqVYbG25qkTmUbOHXsJFwQ==
X-Google-Smtp-Source: AGHT+IE77Tzkz34I50wuOvSnC3JiTKxZKs1HCmhE4Z/k1/j96lwATIsT5IWezEj4XTe6E2iTA7wes3BcgKo+e0W465I=
X-Received: by 2002:a05:6870:308:b0:233:f233:c3ee with SMTP id
 m8-20020a056870030800b00233f233c3eemr14856897oaf.50.1714478841133; Tue, 30
 Apr 2024 05:07:21 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 30 Apr 2024 05:07:19 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240430102310.GC1279403@coredump.intra.peff.net>
References: <cover.1714398019.git.ps@pks.im> <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
 <e57ed591-5006-453e-bc93-6c53fcab2aec@gmail.com> <ZjCd_drNT6kyjNa6@tanuki> <20240430102310.GC1279403@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Apr 2024 05:07:19 -0700
Message-ID: <CAOLa=ZSLx3BQa8zHyDZp5CDuQc4rgSk1LjSX=uQViWXsiv1LZQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
To: Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004d1a5006174f3676"

--0000000000004d1a5006174f3676
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Tue, Apr 30, 2024 at 09:30:05AM +0200, Patrick Steinhardt wrote:
>
>> So the reason why pseudorefs exist is that some refs behave like a ref
>> sometimes, but not always. And in my book that really only applies to
>> MERGE_HEAD and FETCH_HEAD, because those contain additional metadata
>> that makes them not-a-ref. And for those I very much see that they
>> should not ever be a symref.
>>
>> But everyhing else living in the root of the ref hierarchy is not
>> special in any way, at least not in my opinion. We have never enforced
>> that those cannot be symrefs, and it makes our terminology needlessly
>> confusing.
>>
>> I think I'm going to reroll this patch series and go down the nuclear
>> path that I've hinted at in the cover letter:
>>
>>   - Pseudo refs can only be either FETCH_HEAD or MERGE_HEAD.
>>
>>   - Refs starting with "refs/" are just plain normal refs.
>>
>>   - Refs living in the root of the ref hierarchy need to conform to a
>>     set of strict rules, as Peff is starting to enforce in a separate
>>     patch series. These are just normal refs, as well, even though we
>>     may call them "root ref" in our tooling as they live in the root of
>>     the ref hierarchy.
>>
>> I just don't think that the current state makes sense to anybody. It's
>> majorly confusing -- I've spent the last 8 months working in our refs
>> code almost exclusively and still forget what's what. How are our users
>> expected to understand this?
>
> Yes, I very much agree with your final paragraph. I have been working on
> Git for 18 years, and am learning new things about pseudo and special
> refs in this thread. ;) (Admittedly, I think that distinction is new in
> the past few months).
>
> I think the "everything is a ref, even at the root" is the simplest
> thing for users. And the only rules they need to know are the syntactic
> ones: names start with "refs/" or are all-caps and underscore. But I do
> not see the value in them caring that HEAD can be a symref or that
> MERGE_HEAD cannot (nor the value in the code making such a distinction).
>
> My series does not enforce the "_HEAD" suffix (plus special cases) as a
> syntactic rule, but we could do that easily on top. That would help
> protect case-insensitive filesystems from the same shenanigans that my
> series aims for (e.g., "CONFIG" on such a system will still look at the
> "config" file).
>
> It is unfortunate to me that we even need to call out FETCH_HEAD and
> MERGE_HEAD. I know they are special within Git, and probably ref
> backends need to be aware (because they have to be able to carry extra
> data). But from a user's perspective they resolve in the normal way
> (unless you are trying to look at them in their special non-ref way).
> I guess the user must care that they will always be in the filesystem in
> order to access them in that special way, though.
>
>> > Are there any practical implications of the changes in this patch for users
>> > running commands like "git log FETCH_HEAD" (I can't think of any off the top
>> > of my head but it would be good to have some reassurance on that point in
>> > the commit message)
>>
>> Not really, no. We have never been doing a good job at enforcing the
>> difference between pseudo refs or normal refs anyway. Pseudo refs can be
>> symrefs just fine, and our tooling won't complain. The only exception
>> where I want us to become stricter is in how we enforce the syntax rules
>> for root refs (which is handled by Peff in a separate patch series), and
>> that we start to not treat FETCH_HEAD and MERGE_HEAD as proper refs.
>> They should still resolve when you ask git-rev-parse(1), but when you
>> iterate through refs they should not be surfaced as they _aren't_ refs.
>
> I actually would not even mind if they are surfaced when iterating with
> --include-root-refs. But then I am a little skeptical of the purpose of
> that feature in the first place. After all, the reason code shoves stuff
> into .git/FOO_HEAD is precisely because we don't want other stuff
> iterating over them, using them for reachability, and so on. That is why
> "--all" does not include them, for example.
>
> But I did not follow the development of the feature, so maybe I am
> missing some cool use case.
>

The use case was to allow us to look at these refs when working with
the reftable backend. Currently there is no way to do that, with the
files backend, well you could just read the files. So mostly a debugging
usecase.

--0000000000004d1a5006174f3676
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 507a89913064d51_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZdzN2WVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMVl0Qy85S2VuZjgxWG80OG9ueEVzK2VXcjRYNkVnSQo2cjFPYXNhNXRt
R1hDU0pNcElialhtbVdWemNqUkt4bEpDYk0zSjNRR1lESHNQakNsUzlqSkVFOFdVNWNmaENWCmJF
bm1POW9PVmdZWWpibk5XaXd1ditIUis4SUwyUm9zTWJKendSRjRUemI0dlhISlhEdmpCeXRRUzJF
eWlteEcKa0FRM2dhSDJITyttbmZpNWV0SDVHcHB6R3U4N3dpUG5qUkxXdWFLVlZyOTFqeGVKQW5s
VFV5UXJZVm83WUU0RQpob3Q5TzZaWi9ZUkwyYzlKRTBMQkdHRlR4NVJSaHBmanZqQzdnaUdjbDVz
WEoraTJJTXYrYVVId0U0UTQza0N5CnlIdysrWlNNR2F3SnkwdTE5Y2h1bjdMY3ZxZzgzcjJkT05t
NG5kYVF6TXJha2pOTVp5N21JV3RsUnlwWWhtNTcKbW9wMWNXZDFhTDBMYmlKQUZldmJvVFFTTENz
MTArRHc0Y2pJRDAyUWplcG9GMUdMZ1FyUGkzMHZ2MnA4Z0hjbApCOE0vU1FZSEQxVzJSSmR2TnJZ
VmFWZkw1Wk1uRVh4bW1XbjNEK2pFc0hkaW5WZmltVFRuUEZsQ1pqWXo1K2E3CllSWVVqRm51WTR5
QWsyMTFLaVAxVVgrdGpYMWpBd1drcXA1cnhMcz0KPXNFMTgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004d1a5006174f3676--
