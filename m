Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734F43D9DD4
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 14:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775743284; cv=none; b=pM5iTPj/fVAOptgPM6VJLeR2H+EkK4ns+N6UhgKq05R7A0Nv4ebUhyvpITwuRlNRFxa7Onvzhk0NqhSDBj5G2Uq48AjtdCYvqRsrKVrNfVVJ9oNyojmb+IABPFcug2VPkcYvII14FGUU5kKagRWnnNI9ErYDnC2HfqYnM6KpCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775743284; c=relaxed/simple;
	bh=wSManvbtHvN4axrkc6EJcoxiZGCVMRYfB6v5ItsAQng=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XclAtQPFvmnATpK+bYd0LD2duFREAFG6ghyKeiKGniLLW5xT8zzEuE600BL0MSZ+LiOukCS63b9UGvyZt480TGvz+L6uzi2pC0jKU10s/ZRntnvLism7b2BkBEZ42ayOcZff10LK/09qrOsjaEsZzoox0DJcvQoJOqklnO1164w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncbsgq7R; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncbsgq7R"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b97f9587e6eso134012866b.3
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 07:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775743269; x=1776348069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v2+Sqjw61temeZIpZdCCNmPDv1LOyY8blhlRig+W0/M=;
        b=ncbsgq7RGtgQtCMz3w3uWJu6DshCKxrdurkzoYrrwk02f/gDu1UOOsqEo9TQg8fB6J
         oUIfm38auUiBDuk4mNBNHmRu3OSrSmYCX0RDpGXe4ewctb+CGfdMIwwsXh6MVX2kBfBN
         i7vYVFLANLBlqj5ruvd3tnAfrUqpYXLa1eJsg+ai3SEbNQDQvIfxdml/XMBfmISdKTAq
         yJ6TbHO/AzhI+t82DSNGeE8hHS0zbv7UxL8F+R5D1c+EInZFD9STaqeY9WgwVblkW+3l
         /epxtRLj0eVva/eRhsnpZhXknZhxcpIF+sfivrtT88UtKar9LH4QVOXhF+KP2deZq/+4
         T1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775743269; x=1776348069;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v2+Sqjw61temeZIpZdCCNmPDv1LOyY8blhlRig+W0/M=;
        b=OxvZbHLEEb+xqhiigf0SMnGY44VHI54XmKlXtp0gcVh7wnfM+w2OJH9tgR6KhJgsWI
         AS/A0LPLc3EPs9FC6ezPH4lVkfXOO08xBnn/3Mh0XVc9TbYfHd4JKxN8c8WzAfT9MGpR
         Gu6NHKbI3ttJv9L0WhGKKaueKZMcO67ia8jIcgSJsdJO4BZMBtbZMHb9qm1Ln7XdYaxR
         /S/HR0wK7Q4ayMk5aj2GvCV6B3CU2V3Y5CimDwfXb3aE+bTKwikYRZuHnSi81QcmIVRZ
         EuMC8v6NoxrLzhxMgpXw6IqvYo7l8zOANXvTKq4wO1yILBdImq2CH5ZcWHjAD2tgHvwy
         xYUg==
X-Gm-Message-State: AOJu0Yw0f1YTuyISd6rWV0eJp9OVhPBfwFaahX+576r1SMRSjtnuhL9S
	q7toxiKA8DCa64f8fK9VkfKEGd9br8EcbJNr9KNP88syu/D1xvafQa/o
X-Gm-Gg: AeBDietbqXft3c1wW3JWKNAfACh+TRhddXTQupef5XzV3mhaDzG9SMGxDcFQVjn3w8p
	MyS03/xwmtjkIKAPxjBwdPVOt/QEce+mD8pnpJOn1fVhHJ72KDS3Kx0fGoRvN0Y867e3e3714sF
	DD38LF8Wb0jyuf8qQrDbhw7s/B4bfgL4wCZipsK7jOO+AJ6Y5WY0+v2t+YRGx2hbBK0rxKiDdPT
	yip1aO8/C8AtbUc7rtCjc8PlPcL/DdX6PbeEm8m5yxWuwbNLu+UPctOknDn5OmkYPChaaEr6OEG
	5Glf1K16OJqsLqBbF21ZEBiUlh8qdobz1iz4DQts8DwngRuxzmMLiUTDBdnqfKIoiREDimnJqGz
	tuxM2eFWdle3GMV0wwJC8UvrZzlPvcnY3uupYaFCmx0op0bfEVodA3fsiFXOOPW0Uya/fX01US3
	rIxb9jFIkgQ9PMfne+qVimJ+ftK5Yk3A0YuOrCULjd8CFR3gb7gca8GTXLalKRJ9/cCBpzUysh6
	CU=
X-Received: by 2002:a17:907:c009:b0:b96:ef71:49f9 with SMTP id a640c23a62f3a-b9c6742fc89mr1406271566b.9.1775743267894;
        Thu, 09 Apr 2026 07:01:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3ca9a145sm742704366b.25.2026.04.09.07.01.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 07:01:07 -0700 (PDT)
Message-ID: <1ef8dc54-871d-4a3e-80c1-a689fcb883a8@gmail.com>
Date: Thu, 9 Apr 2026 15:01:05 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/6] Xdiff cleanup part 3
To: Junio C Hamano <gitster@pobox.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Yee Cheng Chin <ychin.git@gmail.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, Jeff King <peff@peff.net>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?=
 <szeder.dev@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
 <pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
 <xmqqh5plxhta.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqh5plxhta.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/04/2026 22:28, Junio C Hamano wrote:
> 
> Thanks, will replace.
> 
> Phillip's pw/xdiff-shrink-memory-consumption topic was built on the
> previous iteration of this topic, so I took the liberty of rebasing
> it on top.
> 
> Phillip, can you double check for mistakes when I push the result
> out later today?  These two topics should appear near the tip of
> 'seen' next to each other.  Thanks.

Thanks for rebasing that topic. To check I rebased my branch locally and 
it matches what you have in seen.

Thanks

Phillip

