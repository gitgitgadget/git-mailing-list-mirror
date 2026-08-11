Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8404C3AE19D
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442548; cv=pass; b=UchKfraRttcXbfR8i3RPJYzG66AoH97bXpd7Y32ldSZ2tFFW52JXTnO8IVZWVv2Fu4XiU2J4yk+eZ2nZIDlJdZpbSB/8hysMzWpuuJr5WQ88tgoi9F1ShV/1MO5HZVZSTLPFYHjrUBtYqJmHdaWy2okui157eUzJBy3W8CkzgQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442548; c=relaxed/simple;
	bh=5oUUGKqOnVTmX5buUFFsItlbgUmDd5lqkB06X5i2JfA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FbCaK2OP/UH/rWABTbLim3zmoJpuRyDLKA/6t2duWPkLw69BcPQorJsLKeoFr7QERDrA5bScecSZ5+7WNdbfxwTGO7ucx62tzVJFiio2gVzbw9YeRpo5ZQjxWkPe8sUCeyWh518AVUOGlqVBT+wM99rysCk0lnx6t90LMNZmXs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1tsomio; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1tsomio"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-969524c1a63so1855157241.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 03:02:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786442546; cv=none;
        d=google.com; s=arc-20260327;
        b=lTqSeazHlY8Gr0lqbv65FcksaB2WaaYnW3KX5jeqD6KiYjmK0MPQzhiFonlQIFqD0g
         rRJ9y7Vk58MriVjaz327s7IdusxkPRbOd6lGFnVIbRpcL+cuQSv24MnvqLkv8/SBzZI4
         HnT5aM1fu95ZRA1MTbgl4Nos2hit0D6tRFJn+ulqVahbQqdTaxgqvqwNoqyRcOqN2cvs
         /RtmVab9JSDDA4wqABfaI8jKjZHGTA397wgAUGvNPYY1NwMh6pazhpnDQI9B27EvSnBg
         kEcrVBpk/4+FdisoewJITrzx6i5DTobNnZiHgatjdDxO3dFQeqTKD2sjEe/OEVr0+jsV
         ZM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/4EwKfQz3PYkXRYW/ueLR+/pJKB+Xtu4dVmOyGKrV5o=;
        fh=9e2ouCm7KVburnhuEB7ZF3yIgOGzJT+SxVIhwsJkHJo=;
        b=ZJRmTYsHs7gXnAEXw2wr7vTZfdup3mgAiFuO6LgUpPR7Yha3mby19Kwokn9Kc2I56V
         54bEweI9vKY1ENPzs+cLjs1waRaevWn1sfiEtDMbn9WbFSNJf1pU30dneix7pREscjjj
         KPiQNeKEyepwBuWabHBGyNB3lenET1Gs+K2UZOHX4rb+dqIffDkubbDcwML8ey9L1tgs
         rZroUkuXr9X7VFTkbcDQ5DxlzyRyDicSZyqS2QAV42R/zE5J7fc+qa7xpqJFv4CUCIuD
         C7W5YN3sDpqJeqwd6ygU7YP3RBpPTvrRsttUD3jDpTkd3u27nP0RBIyHc8N60+34Xxwz
         h9Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786442546; x=1787047346; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4EwKfQz3PYkXRYW/ueLR+/pJKB+Xtu4dVmOyGKrV5o=;
        b=f1tsomioRe9VlLC34+yr8tKD5bWy/GNdklrv0eEWAotvQk+PMYE7rBaBO4p0rMLr/t
         MRbZpmnrXDPwZwJOXxAh61Z3jp2rOwPY5MKG0K6mAEns0BgqFKDLpaWRbsuxFt1lyLbB
         4340zUN9NY+4wVZGevFWRNL2rIh3+wk+r9O759p5SV1lqzxAkqkNrAGhdNRPExLYCZ97
         f+qbElpb1gs4sZ93fe8NIx5L9QwHQx1j8eXv+V3CAVYvse/L7uFW8yTWc1cRn02bi9tC
         2/rd3R+mgqbtD+5i08vYrSlIA3W49VJQy4a6K+/fOCplVU6oAflxgfwwvMX5mhY47E9S
         C2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786442546; x=1787047346;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/4EwKfQz3PYkXRYW/ueLR+/pJKB+Xtu4dVmOyGKrV5o=;
        b=GNKD9cbjg/g6n0RlfCb+YLMim68+eyE/IT7y18+ysLBLmCnOO8gMJCbnS+I8oQEDXb
         1BMWNwOTIgfbIzF98kRkhxdmbOv95c4FZdIWzKpxwDrv+HFBIYCtnu9kkeifh2TN7GC+
         7UcC0qhKz+bKZo0gyNvuuuCDWWtdOrVI8GksnCwFfGNPrQuKi1BYmBbsGbBrKxnfcO2P
         SvCyJzVTb6mX8odruYPoo2YSVS6KW33s5+l5/sNBW3czKuIk121fiZeE31torDpSpcV2
         EMIVXIk2jEoSIDoiXL/YCR8jNQjwtHhIw7ssxm6nJBC6VyNVHzDxlom+6qHmZGCTKPIt
         fG+w==
X-Forwarded-Encrypted: i=1; AHgh+RrM+i1rlmNqwxghJjwsYjQ5tniJM4DS7nO3EA5hi5lOUotfNQxKk8dG8C9W+AA7oVLbQn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQDqUH0qIV1XLZq4PSZlpvhF3vS8D/Q8lEVKE0mU79QiL/KTrW
	u0QZ2s/in+5a/4/SqlJeendGYr36kpughxFnKk5WTeUn9JecB9b1bOK5NRQ/je5nIIJkFZoavHb
	r7Vr0TWgeJQZksiBq0maJ2MzoHwerpsQ=
X-Gm-Gg: AR+sD12GbsgmqB0v1fCfGnmef5aUw5izWwhP+PawTFZHJmBrrf3fCgLTbJqdeXr6tbj
	oNXVg7Stp2rRL/b+OYqFncn6K4aXwfTpdFT/Z1bVSrpiXz5h/QQjguFUZK8lnNiF0EBn09hxZ2O
	iHkzy/2oU8Q1yu3CkkrFv1RAIgKINY3eBhaZkSI3zQHEo+d4zqEvfV5yjFrpA5g0tV5aoMzAJdf
	TCWFRVQlYohOxEinSFU22JgqnNmHZqp3xhtYhNKCKBOaf4Y5LI5g8ZPeq/y80Nq1ItWZOkNxzti
	Mp6YTcJ8tVWdiDRrYnnX2LnE/mfoz6xHp0LAfQ9bScDwc+yo8Ik+V3yxdXtoGXnqOKkkEe+NLMo
	RQpccjmwtYG0qqcGfmMN1pwvrAN67gpGwNxM=
X-Received: by 2002:a05:6102:5687:b0:740:127:c81b with SMTP id
 ada2fe7eead31-76b560a4301mr575740137.7.1786442546324; Tue, 11 Aug 2026
 03:02:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Aug 2026 10:02:25 +0000
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Aug 2026 10:02:25 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260805-pks-odb-stream-unification-v2-2-b8c369564641@pks.im>
References: <20260805-pks-odb-stream-unification-v2-0-b8c369564641@pks.im> <20260805-pks-odb-stream-unification-v2-2-b8c369564641@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 11 Aug 2026 10:02:25 +0000
X-Gm-Features: AUfX_myxl7A3WIQUrLmBcWoDDmFGtRZP32XIfw9vY98pJ-mBsRJEZ4F33NTrNbo
Message-ID: <CAOLa=ZQtdUKeuhNbxLC3kBTT9JbxgM8wJUGCzPNKJmEEscA4TA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] odb/streaming: drop `is_finished` field
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="0000000000006302880658c291e4"

--0000000000006302880658c291e4
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index f3e0b504f4..b7c486ea94 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -368,20 +368,20 @@ static ssize_t feed_input_zstream(struct odb_write_stream *in_stream,
>  {
>  	struct input_zstream_data *data = in_stream->data;
>  	git_zstream *zstream = data->zstream;
> -	void *in = fill(1);
>
> -	if (in_stream->is_finished)
> +	if (data->status != Z_OK)
>  		return 0;
>
>  	zstream->next_out = buf;
>  	zstream->avail_out = buf_len;
> -	zstream->next_in = in;
> -	zstream->avail_in = len;
>
> -	data->status = git_inflate(zstream, 0);
> +	while (data->status == Z_OK && zstream->avail_out == buf_len) {
> +		zstream->next_in = fill(1);
> +		zstream->avail_in = len;
> +		data->status = git_inflate(zstream, 0);
> +		use(len - zstream->avail_in);
> +	}
>
> -	in_stream->is_finished = data->status != Z_OK;
> -	use(len - zstream->avail_in);
>  	return buf_len - zstream->avail_out;
>  }
>

So we have a bunch of global variables used for zstream parsing. The
loop ensures that we keep trying until we get some data. The use()
function manipulate `len` accordingly for the next iteration..

[snip]

--0000000000006302880658c291e4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 6dd9431c6aece628_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wNjh5OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMGJZQy80aWpsZEtuV3VNRjdwYm5MTnNMWHl5NDkrNAo5VUd6OVpYUXRB
OXFoeXpnVDV0OENpSkdrcVJSOFBYbjZTZzcrY2ZWN2ZEZFdOd3NXakZlVHVZVVFrOFJvY0s3ClhK
OEYwRUJpZnF2OWhRRmNsMzZhb1pCWU1aR3QzN01PTloxOUxSTEtha0tJL01zV0NxSTVWZU5MSnNv
SkN0THQKKzBhUE56VWFhLzdwYUxFUnJFcGszZHFHVXBlM0oxTmxaV1kwalBaeXIwRTRtVXgrWWJQ
dVVvcTdaYVJRdEl1SAowVlNMazg5OFJoTVh3TVpwYTJSSVRYaE96T0NGbVBvekx2blE4eWZnL2Rr
d3hKM2E3b3hWaGdnSUVqZkR6ZmI2Ckt6THpkOExRWEE3Zk1yTUFmMTlQUDU3MytKQVpXKzJlVlVD
aG1DTVBqdWpqa0Zlbm05cHMzTklsWWpWbUdJbk8KTFRxVXFRSCt1SjRLQlNYSjgxMzN3amNLQVJG
NXNmNStZMXhyRzVkZ0RiM1djMmZLV3NhazhSeWdxNVJsbzdHcApkQUh5aUNRQzg4UnBDZUR4Q25k
Qm5kZkN0U1F3MG4rR0xtRHhubm1pU3YvUlFvY0lvd1pGaTNYeWlvR0RhaGhkCmwzM09PbDZ6cDJ6
ajI3VlJCNGtwYzFGL2psck1xVitzdXhsOVh5ST0KPXVUQnIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006302880658c291e4--
