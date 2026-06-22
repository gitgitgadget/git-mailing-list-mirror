Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E103A7186
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782131200; cv=none; b=aZy7IsyDswNGOuVsl7VW7Ozz8FzRjGDSWg9Wq/ts7+tFjQEyYbcB5ijIEQmpPeYriDCupaRXeenoJa6BZ6ea2xJMU28AcKQfU8niZsl821yH8EybHHZADjDOgs6e2uXG9yYWU6p3q/0ESgpMy8tXoaX+G8k/U8rwUMD0c0bG1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782131200; c=relaxed/simple;
	bh=hRURq8t3hTPukQGGLJbJlgt2rHkxuUDCUSp+S3UWj2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gs6qu8HbU5AMVKiCvH1gsidDBb8WzVw65a876qv2tXt0cMUgtVzxU8WEr5f4wYiubKZijCjSREiBqa95/mSKM2SS4oCGQVxDmpKLB73FeCSjhFr0fLHH5IvIBS4XNBSfxkZWn/MsM+p+AlVDwZqxr3GmBkNI7DvAP5mTXKYLXGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NtKUxhZM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+U6i/rg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NtKUxhZM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+U6i/rg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 67E5114001CA;
	Mon, 22 Jun 2026 08:26:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 22 Jun 2026 08:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782131198; x=1782217598; bh=tNM1me5T9b
	AS05gZgES4x3P+gQ0SMOLoRZI7s9KSOVY=; b=NtKUxhZM4me3WzlVB0hwKs3UEZ
	xtAe2Dc+PnfIM1hrme9fUmjcmI8JarrbmbC3Ovje9g766egB4qXJ9+UVUj8aiRYA
	GC4PnG0fW46NaE7kv6a6aOQTnkmQPpyic704zqTtbauNq09BaNCd2WDDt0FUHtO7
	9g8G8YBe9LIu393FKY0HJ2eVLjTYwqLsvrsf6V2uBtaLFsfjgD0V4vLO+k/9/D03
	QN+lhfMH/Br2THZCvlcTeijwuwpnS73BazeVT7cDhpeXq21g5PAVzYw4bOxQWEzE
	+Lg7IZvcbLiThV17RlGOF0EK0flipWJGS993uHIhh9PPN3HNgyQLbhqD0Eog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782131198; x=1782217598; bh=tNM1me5T9bAS05gZgES4x3P+gQ0SMOLoRZI
	7s9KSOVY=; b=a+U6i/rgwMZH/g9zfwZYgR1vT9+0EIY8qGU1UAUD5axmvnUCppw
	TCpQWo4myfI2N/9O82atSDqopc+gD56AAXI56ntHCZqYMj3fosEaE/+qeF41exC1
	v0V7CtRuL5SA63oIQELTDhpRU3MPEIsFmBkigE0VdQqfz12xGqD0G5OXLygWdcka
	JHhRvhxl23qPe8Nx9i7i13jg0Jx7wn0Gkc8DplUUrCVTiwtVeHKSVrKnL5tz24F8
	yIfdCTNfUyJNLH/7RSD4W4v/LHcqkRBt14EWs5PdAcc1tZxBzE/+3ZcKHc1+M4gW
	oLadUOI+pHzTSykPKKpqRNQtMhWvnVdoUQg==
X-ME-Sender: <xms:_ik5ahbsLxhGa8WL58fQctb9uvfLGdOcgxXvZGqbXsYb7bENMq39GQ>
    <xme:_ik5aqpNmRFoMGT-dr2FhskuE9Y4MNIlD6q1A0KOXw36x1rMTJ-LD2_qzBgKv1NQ9
    VJozG1VlV0BGdftcU7r9l8ze9I4WnEg3vR6eQVX-OfC1z8IHqUjUg>
X-ME-Received: <xmr:_ik5amOpCCqOOSoi4CLZDTZi58GTr7PBKXJUpEmU-QvNAMSKyVINh8nob9zCO97Kcm68Ym0l2gPYmAraAtCRihAJslPD7eTngcNga1g>
X-ME-Proxy-Cause: dmFkZTGXRDzck9VWs0Sl+UiNo4ZerN09Ufh3D/hpGaXBFYZEAyX+d1fDMYwtwT0yMb0gY5
    gcZR2bWv3bDTMig25KTVb1bQLmwiYbZ6yes/QmjOyenFhhbWqa9cdmOKxl6D4xhK3+xZWD
    WDE6FI7336DNuHbRTc7L9S65QaWbZrL+vc5gXDs8bMDazhi2AOCziRooIkHiRmJPxkVcHn
    BhE94iSBPMXnmUEeurGi0vq/HmT4wNL4y9zHQzyNqitlY3R8pcMkNB8V6hmc3s6B8aiJkb
    LlH8P3aPcr2qSSGEr9VMiKWcYAtCt6Xq0WicqqDZhuFQYjH86UAt38v8ay7Iv3GyPXwqi+
    hwPVPZwaDj9jHM/8eHCrlVxLXsKDQWfGkLKsk/xlEX1+plZ4XATz/16FgpJF7KdklvWJPE
    4n5hvIgXaumqk5Iy9Y87RgjB2ifDqDsyAIkJD+ikJ2Cy2T+VtsOCTl160YikX3+gfwSkKu
    mqkIP8geRyTWhsU/Ck4ApWmFMi4HG/+XZujN8Wn+6JmLEHjwCxN8omjsPPZtZH/i+LX3xn
    3/zuBjcL4IO3OMBZCPOptdta/P0aQw0nTVOfTnD2OULnBE5xJVvOp7lczCZ0rMDU9+LTwj
    Z+QnB0+wtAuJlzT99l7Ify4sB4JTqvchKDTWqvMi+pp0RYD5VAqOajycuTdA
X-ME-Proxy: <xmx:_ik5alp_0j1rnRyuZ8up0CCqmZa5W4sFhbA3XGvnaZD_HWPfVqiyyw>
    <xmx:_ik5arfptys2-kbRs4-JmXllqga9Qs8oiHIZ-CRTotBbDrmnrFoxRg>
    <xmx:_ik5arRMSlII1X8KGjxPk88VcLjLJMD3u8AA5g4qWQq0V5L_xBBjxw>
    <xmx:_ik5aka8VgzzMVgFdes_HvKwlJZM9Iog6IpM4MSCfK94DvQZVlRW3A>
    <xmx:_ik5atWMPHmkXknnUFUaXbS3TrE-NcGF1DWha5n6jWfWPAJhwvW7zAxo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 08:26:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
In-Reply-To: <55a8cc56-f015-4a1b-b830-79cf24870286@gmail.com> (Phillip Wood's
	message of "Mon, 22 Jun 2026 10:07:57 +0100")
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
	<pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
	<9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
	<78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
	<CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
	<37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com>
	<xmqqcxxnsufl.fsf@gitster.g>
	<42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com>
	<xmqqh5mymt8i.fsf@gitster.g> <xmqq33yimsdp.fsf@gitster.g>
	<55a8cc56-f015-4a1b-b830-79cf24870286@gmail.com>
Date: Mon, 22 Jun 2026 05:26:36 -0700
Message-ID: <xmqqbjd24v7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 19/06/2026 17:01, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>   - Notice that a branch that is deleted (because it itself is
>>     merged) is still depended upon by being @{upstream} of somebody
>>     else, and when it happens, fail the operation (i.e., do not
>>     delete the branch).
>
> Not deleting is definitely the safest option. As Harald has pointed out 
> we then need to think about what to do with the upstream branch of the 
> branch we're keeping because it is an upstream of another branch that's 
> not being deleted. Keeping the whole chain is probably safest.

You're right.

> I think handling branches that are the upstream for another branch the 
> same way for "git branch -d" and "git branch --prune-merged" is a good idea.

Yeah.  The latter should be a short-hand for

    for each branch
    do
	if branch is merged to its upstream
	then
	    remember to remove it
	fi
    done
    now remove those we scheduled to remove with "git branch -d".

so it would be clean if we can explain that philosophically the
safety lies within "gir branch -d".

Thanks.

