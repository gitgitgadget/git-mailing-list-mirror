Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5A4157E82
	for <git@vger.kernel.org>; Fri,  3 May 2024 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714759699; cv=none; b=tf6fvU3BMaPIpPQRvBXIBM/lEFTBiBZf85P1uOvdpQ2fh/6SLrSdVOQXKum/GlpH8EGuiF+6N7AxH4KQrxuvkzPmZuxElkQM0maBr9lMfUv5a6tPCVJgtATcYMMt7LpmfCy0bIZzzHvtJSBerH9DVlPYPAruYNgVa3zlZ6GTxZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714759699; c=relaxed/simple;
	bh=wUFTb2TRkezNCEzAwertJdaGRrvTcn1u5QHcsOMmJS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iVKLgQwVnq15B02JPVqUP0R8X6ED/i6eyIj7wM2zcwO+mbgV9hrphrcI6bkQZpBMQU6p3g75/e9lUPZcdp58J1jUHn23X2kekPxYornjVokmwiXk60rpQtuNS3X1KBJ2/Rt6NkTxi/uURymzVQqpihbnPBMRBgPF2iyXN3aURt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HVuSvjK0; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HVuSvjK0"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EC4062AC5E;
	Fri,  3 May 2024 14:08:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wUFTb2TRkezN
	CEzAwertJdaGRrvTcn1u5QHcsOMmJS4=; b=HVuSvjK0n49wRZjldei0swQ/6z0G
	y1Ak3HjmmvkCgAE7/PrtiDNVNjKS4H/fjrSamHf6euUlk1DCU0IY2+sCmSJPmIYx
	qPUXZYgyP/MvTSMUtSKGOWyi1uzoFPCScbv9alRwLT0HPtJKNh3xiA1Q8YGqklKM
	bWKE3vTQnSCqZ4g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E48472AC5D;
	Fri,  3 May 2024 14:08:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A1672AC5C;
	Fri,  3 May 2024 14:08:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  avarab@gmail.com,  christian.couder@gmail.com,
  me@ttaylorr.com,  Enrico Mrass <emrass@google.com>,  Emily Shaffer
 <nasamuffin@google.com>
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
In-Reply-To: <CANq=j3u5ZHYbJQjhwtnq05GocOE_AVrHodjPOqVCNN7OZHwVsQ@mail.gmail.com>
	(Josh Steadmon's message of "Fri, 3 May 2024 08:48:19 -0700")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	<20240417163244.651791-1-emrass@google.com>
	<xmqqr0f47wp9.fsf@gitster.g> <xmqqseyzar96.fsf@gitster.g>
	<CANq=j3u5ZHYbJQjhwtnq05GocOE_AVrHodjPOqVCNN7OZHwVsQ@mail.gmail.com>
Date: Fri, 03 May 2024 11:08:15 -0700
Message-ID: <xmqqfruy7oq8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1D3F8556-0978-11EF-B106-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Josh Steadmon <steadmon@google.com> writes:

> On Fri, May 3, 2024 at 7:45=E2=80=AFAM Junio C Hamano <gitster@pobox.co=
m> wrote:
>>
>> We didn't hear any more comments on this topic, but writing down how
>> the world works around here, with the goal to eventually have a set
>> of project governance rules, is valuable. Otherwise loud people may
>> act according to their own (unwritten) rules that annoy others and
>> harm the community.

[jc: do not top post].

> Yes, sorry for silence on this thread. I am working on a V2 but
> probably won't have it ready today.

Don't be sorry; the message was not addressed to you, but for wider
community participants---especially the ones with more "clout" (or
"long timers" or whatever word we would use to describe those whose
opinions are trusted by others and count more) need to buy in if we
were to first agree on that it is good to have a set of written
rules, and to then agree on what rules to adopt.

We might want to pick ideas from https://fossgovernance.org/ for
example.

