Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA0736CDE1
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780974; cv=none; b=EwUGmnjIMMO/LWXL84kTHwkIgjBrb3C4qOsQpB/u5rwwjHKK9polNnpb48tJr7SqVPIBCTPhMPMlHF6Drt2JwvTD+XVJ3tb4ujIYqwIC4VYMkwjfah3dT/zfJCfimUp8+O8mDj/lJMn5me1qUFwoSYMaYkNrqJD+uQduq5uBJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780974; c=relaxed/simple;
	bh=pFpNri+Z1VuqfK+EjwoA4cwz0ywDOJFb/Cvnq+rO1Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHgRYpwGaRXGRM53f7RU105LNbVkvPSMPMFTVKJY60sCEJcHz41cm1oIlp/Z2qepZLqPx7mt7chmMqM0/K8YgdJH0qxXJfYWM0bu/aOWp9kqAXgteOUR5hswM3l1XVnji/qsiVqUY7xIBDd6QmNZm5Q5Gksp0AvQAVB9Ruo0Rcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xcrj7LRw; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xcrj7LRw"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-70a9f556d65so8402466d6.2
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755780971; x=1756385771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BVXhEMztE4dmJJBzNij6nl9rjGowPAyoZqPglwJBZlE=;
        b=Xcrj7LRwlomH0Zdp5OyYKKlBKrO+KGpquRSIuGLdc8eVn0yeEvxzfw55RSKV91E+Se
         07+6ihTMlwWPOxE3fECShenVkGz5FRoYO5fPJw4WNfuvLsD3W8YbDikOc3FkPVGEtn69
         6tAF1xR/wmFbMRs5S8nkVELtNfBDdBVMcBEsufOxAt4ZK3O6fp8eqWCBJZt/Vjt+wpC3
         cawReRyaY1swl6n1dwWNGOYOfuuDiYI8DBN8P+9OhGUhLJf9D/RxDV3NeBiAXq6eBKcO
         u8S0gG80va/9raIrIej5ApzZ6hJRAr2iuKPd7438+Eg9WKDER2gQPfk1gNv9qrKFhyRR
         Yl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755780971; x=1756385771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVXhEMztE4dmJJBzNij6nl9rjGowPAyoZqPglwJBZlE=;
        b=Mmbj15KRJs8oQny5nQZIU9410DhpxE3yBnw6+JC2GcqBSqNLDgbr72mpYJsUNLMlq3
         M4GJ7zPPq0AaJ+EIGeDp+MuLyB3RoMGWhRukABSMFRv0777GZwnMwi37REob2XojVwya
         x0cN+7uCvSTTAJwfYVBrYXpa9ncUTixpSoKbHrBEzm4497wVH/qUzLQwYBJs67a1ON8E
         DB7RtSJ36x7kQbh8yIiXZkc1bs6Xn6aVrUKu9ynQk8UY9MUEYuBUJo1WUuHJVIcb2bIt
         GV0di32rnDy4qwozu3TqZV8ES+KQxj0adEmEN5PDcOFXxwsxJB+9QjaSlbdX3X/eOj+0
         Zqrw==
X-Forwarded-Encrypted: i=1; AJvYcCXx1101ZCJIGTwNYcs6ZreFAX2Elkxsd6jTBrGpk4qYEnewcYtOptK6m+bMq3hqFmR1/xU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywymr/VK5mo+Y4tWcaVVJuA+YV8F3WWdJaEjUwczzPH+xW96+CV
	T/Rn+vCqRgU9Y0XuOEoe+4GZg9Vwi2l+EiUWoZhIGbWgnH/XI2V3Z9kK
X-Gm-Gg: ASbGncs/xlwuFBdEcSPTNoQDwVq5RvX+1n6yuvtXuHPFo7PYKh0/UFs370InWBOqU0t
	lYHgjX2twnhh43izt6/LGVigp9wKSpkDGVybRkMn+ni7Fk2DgV8bp4whyQMovsaX4pf0prv/5Ei
	0keULh20jWgYyTVB1pWeMs0XyeFXKjO406/CS3UTCmMasFQbDyvzRzC8eXdbZInazDMgocZGUTK
	IjNEGiEe4C2auJ5L+d4Pl1G2R5iv759Fgm68dMBJZN8KLHqLqLvWXcWs83HTnccX9cMTs4vmdVA
	G/KfsGtg97F0thSKnFkFJE7efDad+ABcVqDmuQKSh+zecJkP+MPpenUSKyh/tu+RB3Ta9/kmFzd
	EjfmXdfA1lazVo1+Cp6R6R6rAOlSExGhVhxk=
X-Google-Smtp-Source: AGHT+IE17YInlGnOPANi5aUtBXVtR2Z6QdTY+trH2HuoI6xOnihoD4y/eo6AYwbJXsK09Z2Fdu18hQ==
X-Received: by 2002:a05:6214:5887:b0:70d:924c:324f with SMTP id 6a1803df08f44-70d924c3d50mr9120206d6.32.1755780970942;
        Thu, 21 Aug 2025 05:56:10 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba9300effsm102376596d6.37.2025.08.21.05.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 05:56:10 -0700 (PDT)
Message-ID: <9263e8f7-8772-4b8a-a3f2-6ca2a70d645d@gmail.com>
Date: Thu, 21 Aug 2025 08:55:48 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] path-walk: fix setup of pending objects
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, christian.couder@gmail.com, johannes.schindelin@gmx.de,
 johncai86@gmail.com, jonathantanmy@google.com, karthik.188@gmail.com,
 kristofferhaugsbakk@fastmail.com, me@ttaylorr.com, newren@gmail.com,
 peff@peff.net
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
 <0dc4a6323e66598070b403d286ee1918e6a9b791.1755715196.git.gitgitgadget@gmail.com>
 <xmqqh5y1ak9o.fsf@gitster.g> <c6ab0985-2a74-406b-9685-cc65f8748515@gmail.com>
 <aKbSTN-rfGzadPsm@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aKbSTN-rfGzadPsm@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/2025 4:01 AM, Patrick Steinhardt wrote:
> On Wed, Aug 20, 2025 at 03:42:11PM -0400, Derrick Stolee wrote:
>> On 8/20/2025 3:02 PM, Junio C Hamano wrote:
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> The key integration point is the "pending" list operating a bit
>> different from walking directly from tags or commits. I was trying
>> to reproduce the issue from all of those other sources before unlocking
>> the "singleton" nature of the problem, and failed to do so.
>>
>> The resolve-undo cache (REUC) is something that I had not tested
>> previously. Adding "git rm --cached x/y" to the test in the previous
>> case leads to the 'git fsck' call giving a "dangling blob" warning,
>> so that could be an interesting way to strengthen the test. Thanks,
> 
> I also wonder a bit about the future -- if we ever add a new source for
> pending objects, would the author have to amend "path-walk.c" to take
> this new pending source into account?

I don't think the risk comes from new ways to add pending objects,
but that the path-walk algorithm added an "optimization" without
appropriately modifying how it handled the pending objects. New
sources of pending objects shouldn't cause any issues, unless the
revision API itself changed substantially.

For example, in my draft for v2 I add changes to my test to account
for the REUC in the repack. The new logic for the path-walk feature
worked just fine. It does point out that 'git fsck' doesn't follow
links in the REUC and so reports the blob as dangling.

If we have a new source for pending objects in the context of
pack-objects or repack, one would hope that tests would be added to
demonstrate the behavior and then that could be double-checked with
GIT_TEST_PACK_PATH_WALK=1. One problem in this situation is that
the tests were not substantial enough for these sources. We are
correcting for that now. 
> I guess the answer is "yes", which does make me feel a bit uneasy as
> it is very easy to now corrupt the repository.

Perhaps this has always been very easy to make a bug that leads to
losing objects, but we're purposefully wary to touch the logic around
the repacking processes.

One feature that could provide increased confidence is some step that
double-checks the object list before and after a step like this to
make sure that no objects are dropped (or only the set we expect is
dropped). Something like comparing the object lists in the pack-indexes
before and after a repack. This might be too problematic to enable in
all cases, but could be enabled in the test suite and certain critical
places. Azure DevOps has something similar in its backend to prevent
any change to the Git object database that can't be undone, but these
steps happen asynchronously to "production data" so it may not be
appropriate for all server architectures.

Thanks,
-Stolee

