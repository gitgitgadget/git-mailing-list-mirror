Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA0E3BE636
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338461; cv=none; b=MpfK/rMnJD5pZ4roQ3uC87G4sK6p2UIGbhGTf0fbRjPGLY7XifAUOrcZGl7Hyqd7JV5SNQAayOZnZoO1icibm6VZysFuXnObrWNRCC6CktnkdrrdFfttc1dKuPkm4I40hsNMQQzvsXsT0MaINY8E6TMv+i8mNufdiKQcruvUnLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338461; c=relaxed/simple;
	bh=yh51ADCpGWKDfPhreFryItERgbyIAJ0mc+7nlVZgdZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EumXVK5D9xf4LWoE7K1nQJcneiGIgYHxk1f+1cIKmJhdZjajK4Ajud1a7XzY7faMsYZpkkbIKxFIlyHDVCw0Lcy3AWckVYggMjF2d2DEc+uAXiwyi6gjZpAsHKc9WshGFpG9OKVu7F4l6WFy7Rh2AfQp6A0mci3Gt4Is9/vsPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad80poYv; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad80poYv"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c15cd3fd760so133265966b.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 08:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785338458; x=1785943258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vgihx7W/5hRxUpwq+QWLTEDKLhF8zG/QranM768v9hU=;
        b=Ad80poYvH9i8KLu8S04YUB9n1/S1NJrrIA/PO/8Vs3KrXIv5pxnsD9d08jSOFXlThW
         4SGNOCX4tJ1w6s3Rp2pmEYTS8IWDmqPL49u2JiDrmBf2Ss+iXrBcAW+360aVU+iMehWo
         3EB1DjV7t19+7s/vbz9oktCuPRP9XLWPeXL0V86jDYZTKmTRJWXLe/LbmEjKnRdNOguD
         5I5kCEQWLRJRiUD4mmV0NhSUhKSz5mwGQJA2jvq7UDJS5bmMFNR+ta+0AO5JfWa+DRnM
         0VN5w7Oos3ytGgEaW5h6CH45xwiUQFKuYRX/hL1uYY/0V0wxIYoaPSKue8aGBURueWLF
         ORBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785338458; x=1785943258;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vgihx7W/5hRxUpwq+QWLTEDKLhF8zG/QranM768v9hU=;
        b=dDdtht4lyozwRXqxYkdsmSXaQ0VKVh8EaiEuSGZXmknXpdUF6Mk8LNFxnilsH3aeu4
         UXhZ7L99eyPDS+856loIkQ9vojO8UMapOb2Qq0F/RwXshXC3DitniHtHqRRxVclyBiip
         LFnRrmHi+ump520QFrRwEeMQnLJm1xyKQeOUWtknofqanik6ZmUmVffgFnuCbBV7bdnm
         HGdpWNXHa4lmeylHxAhGG0sbUH6V/zsnrnI+3ceyWlnTygPtjAhxQ+pUfIgIqGPqxdHw
         r/chxKzO3bycMBILjBhw0lCe93Zu1EZvlPdP341EKvyr5oscOz2f1XCPg8aSVIvwjlcY
         vWbA==
X-Gm-Message-State: AOJu0YxIPRw1+iwKdPoa4S4L69foLeKqFjEwW2Ki8IYxH1FhmsmLwZES
	AvcXthAQ2kkYPLqkn2GYiXVkoUX9mRHrQ1B1+A7eziqH7nad1V3KpwUa
X-Gm-Gg: AR+sD130gZ1JwSakh050iD89zeg08xz1j7lEFKEFla2a6zDWwdHQdXVCyp6SkcbXtXn
	bIW3s+k9u2TGNhlLzGqgNuTr5uutC1XlHUVs1lqQ4AA/ck8Ekm+B7Ju4TLSOIUa+1ww4oG4KvbU
	esq4qhi9K1ODOGolyZfRa1/BCxk1EbWFz7b3Zq1W9TTbjenWKEZH9W/A7fZRsp6RzV9OoBgNI0R
	kR0rAx0uOQ4KKsHztNwO5GzHNf2Fl+ffh/gh1kkcdKhezpvccHJI+txioNOvwrhH02ZJJUysBS7
	qn6tHh5csgKNA+w/lPgWyGI8c027TNTfQZ6emLntCnQlrIdGVSFj9pAGkqGUJND6tIMFV3ID4xi
	KVw6/pakFqTOE5B52/NK+MlkOIoI/cvB3Iw8rYIXDD8tT0koFO1/SW+sHq3c4XzXRfVoN0lRw14
	iGOw6dJ+go0hY/VYSjYZkKYv8zTH14LzE9aTMNgG2y22CTCIwguMUTwgYhXL0kd6lkTh4WLtOxR
	4eql6doV9cWnqaLPknYhxdcuSBMgWJMYHkHRtHN560=
X-Received: by 2002:a17:907:8b87:b0:c16:73a0:c4ec with SMTP id a640c23a62f3a-c1f720d7c07mr433363466b.18.1785338457664;
        Wed, 29 Jul 2026 08:20:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83c688cbsm135508466b.12.2026.07.29.08.20.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 08:20:56 -0700 (PDT)
Message-ID: <414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com>
Date: Wed, 29 Jul 2026 16:20:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Jul 2026, #12)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
References: <xmqqfr15ruw7.fsf@gitster.g>
 <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com> <xmqq1pclc210.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq1pclc210.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2026 15:18, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>>    The experimental 'git history' command has been taught a new 'squash'
>>>    subcommand to fold a range of commits into a single commit, with any
>>>    descendants replayed on top.
>>>
>>>    Will merge to 'master'.
>>>    cf. <DK1KIF2OI8IF.11188A3YEQV1C@lfurio.us>
>>>    cf. <DK1KIH6CXW0X.1U2V3GU8L6HB7@lfurio.us>
>>>    source: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
>>
>> Oh, I'd missed this going into master. Has the implementation received
>> any serious review? I've seen messages from a couple of people trying it
>> out but I can't see anybody reading the code.
> 
> Thanks for stopping me.  I am happy to immediately revert the merge
> of this topic into 'next'.
> 
> Perhaps I should re-evaluate the "What's Cooking" report and eject
> other topics from 'next' as well.  There are indeed topics I did not
> personally read, relying instead on impressions from busy exchanges
> (including earlier iterations read by others X-<).
> 
> Are there other topics in 'next' that do not deserve to be there
> yet?

There aren't any others that I'm aware of, but I've not looked at most 
of them so that probably does not mean much.

> I cannot, of course, afford to be the sole serious reviewer and
> merge only those I have carefully read through, given that there are
> only 24 hours in a day and I have other obligations.  So either our
> quality criteria must suffer, like this episode showed us, or more
> topics must be ignored.

Yes, we could really do with more reviewers

>> Having a quick look
>> through it assumes the presence of an UNINTERESTING commit means we have
>> a BOTTOM commit. It then assumes that UNINTERESTING commit means we
>> cannot reach any root commits. Both of those assumptions are false I
>> think.
> 
> Very true.
> 
>> ... I'll try and go through the patches and produce some fixups,
>> though that may not be until next week.

Harald - I've got some half finished fixups that I didn't get round it 
finishing when I had a look at this last week that I'll clean up and 
send so I'd hold off re-rolling for now.

Thanks

Phillip


