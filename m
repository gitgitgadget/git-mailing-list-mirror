Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3660F126C1E
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759832319; cv=pass; b=u9EQCzA1l5lrTRS5D5+5UAdPQ0/41vuI/MQp/6RlCuj0dh297mnZ4LSqM5ysHVy+S/N2Hm3366ng7Jrfo3oQQEh7QAu1W0ecUOXd8ACpvszglb4+SadRGGyGjR4cH5Q5HiGmZrDP068P8Wg2H5uV3oeqSu8X0nQ/6BflQyQi+hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759832319; c=relaxed/simple;
	bh=hkyTEq2Zc0+z1yZG+DTP1JZJSL64K6D6OVZex/ALkvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KcV2wBShmwIn4Qny6erAh4g1LinEoSq74lnsYxjh0oGaklrXmTEkjsX1Ae1D+6BM0Ykg6IClaQgn4pC/DZKWTIpW077KfDKEvpb4z322pEIjwbwhDc8sCxnVR0RbBL1blYF+WumA6mwfBO1iz4ODGQ+QQ9i+3z+xhL0KTl6Sof8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=AiDCHLA8; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="AiDCHLA8"
ARC-Seal: i=1; a=rsa-sha256; t=1759832292; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U1U7GYhlnmgyDMV92Ga5p7jdTrlyy18r5W5TVT8fWVDtiNXthvWt3p6/74tXMKaTzU1Txw6Yi/B/CJ2l7rrTaOxrOwWRirzRXsvrvwMhvJmffwo9561CWBYfHufQdEeAX4TXH67Q+pww3x5Zw7aa0QuUaxAzD2LloYsqGtyrd5w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759832292; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4Klcz7iTeKKKWC6DIVlfPsiHj1ukcuTEaurJEMTB9IQ=; 
	b=LB33EQxcdxLCaoruV6FXZXF0tlBl61o6CbbLcyjjeGC4qV1gnNUlmM4RgfaIMAR7E7fP58DQarM28/PhquDmuf1M8qGFLkWM/zca2VhZSewT8cUXUGDHo5Dg4otMoq22I4vX3tP6XNXvYcglPdNm5ENxmaDMMvp6EhzJKt4xAHg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759832292;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=4Klcz7iTeKKKWC6DIVlfPsiHj1ukcuTEaurJEMTB9IQ=;
	b=AiDCHLA83JrgbSYIqv2Wg/fLpM55v4zJx6Cbpf+tD3+CSWrXVpCt/32s+mWBYvwP
	unBnX0OT5lseUyJf2Jpe0EpJxOaLaJ2c7lgTt1nzDdU/wIur7Yt4BvIB7VH+NsT3Hkj
	8JTcRsnAR/e4Wx9lbb4joZjXREe81VuuOUHnsMCo=
Received: by mx.zohomail.com with SMTPS id 1759832289228623.9026514165633;
	Tue, 7 Oct 2025 03:18:09 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Aaron Schrab <aaron@schrab.com>,
 Jonathan Nieder <jrnieder@gmail.com>, Patrick Steinhardt <ps@pks.im>, Josh
 Steadmon <steadmon@google.com>, Ben Knoble <ben.knoble@gmail.com>, Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 5/5] submodule: error out if gitdir name is too long
In-Reply-To: <xmqqy0poot7g.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-6-adrian.ratiu@collabora.com>
 <xmqqy0poot7g.fsf@gitster.g>
Date: Tue, 07 Oct 2025 13:17:58 +0300
Message-ID: <87jz173tih.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Mon, 06 Oct 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> Encoding submodule names increases their name size, so there is 
>> an increased risk to hit the max filename length in the gitdir 
>> path.  (the likelihood is still rather small, so it's an 
>> acceptable risk) 
> 
> If it is acceptable, can we ignore it? 

Yes, we can.

Peff actually asked if it's worth pursuing this path. We can 
certainly ignore and let the OS fail like it does now, without the 
compat wrapper.

The only usefulness of this commit as-is is to to print a nicer 
error msg and allow us to eventually address the patch TODO 
(sharding/trimming).

Please let me know if you wish to drop this commit in v4. I am 
perfectly fine with removing it. :)

> 
> Just stepping back a bit, how are we keeping track of the 
> mapping between submodule names vs locations in .git/modules/? 
> Don't we always go through that mapping and would a half-clever 
> code that says "heh, that is url encoded and I know how to 
> decode it" and bypass the mapping a bug?

The short answer is no. :) The slightly longer answer is:

Before v3, we used to have a clear filesystem separation:
.git/modules were unencoded
.git/submodules were encoded

After v3, when the extension is enabled, we encode all submodule 
names with one exception: if they already exist, at which point 
they are treated as unencoded.
 
> 
> If we keep track of the mapping ourselves, then the names under 
> .git/modules/ do not have to be "decodable" by themselves.  They 
> can even be sequence numbers and that would not hit any maximum 
> filename length before you fill your disk.

IIRC the consensus was to avoid keeping such a mapping due to 
complexity, risk of desynchronizing with the filesystem layout and 
so on, so simple rules like the above, or even a simple hash_name 
might be better (see below).
 
> 
> No, no I am not suggesting to use sequence numbers; something 
> remotely readable by humans is better.  But my point is that 
> just like you have to make sure that the encoded name you give 
> to a new thing does not collide with existing names (you know 
> with "ls .git/modules/" what names are taken), you can notice 
> your mkdir() would not error with name-too-long, truncate and 
> twiddle with suffix to make it unique and retry, without giving 
> a failure to the end user. 

Everything is on the table and I have no strong opinions. :)

Someone suggested we use something like .git/modules/<hash>_<name> 
when the extension is enabled, so we have a simple, unique and 
recognizable pattern.

What do you think of that?
