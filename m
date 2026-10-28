Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793189270;
	b=l08YYjGTCVKRuP03POrRngFzWlZdhlIGa+ypDeEsT7fhea8qJOGEsReBWVKoHB8Tnhd0
	 oSrmkYDB+8RK+0v3lVvrXGL1nE6ZEgtdPIJ5JAAgu1OqLneHSDTLT+1nGaRap8uhxsYqK
	 Oeii029+0oxLDX0psKVM+1LufcbmysyTM3rKqs03BjVeTFGwvEQld4KWrgMoKWQ7L6ZKX
	 ZxsuGnVWOhYKuP9DhqoN6N/BR9KZR0P+7YDODF51usrG2tViTj0vSc3DbqD1LyOvXP+Mr
	 pqHrMrehfR5Zv/3lUn5nvqZVZCVKBsAO1ABVKzTTV2oyb8PxdGyI/4hU0gYqN1XjRjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793189270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=hjdsRdcyqReQmZjxrYmZOSdGGalELyiuqpF4pWyDnMg=;
	b=Il2HZiGeiuD8iMzxyqVJjNGN3hDrwUn4Htrf3KJm2WEHsEv4iNOTRJkl0XBJynR+5kwv
	 kJDxmycnejop0AJsjJqlq2/AbGuoJjnwJVtt2qnyn7H+7WldWFzutBYconc70SyPP4Sou
	 jF/ZXQsyLr6A0ILER4YAKM5Dm56QTjg+A+2nyC8HKHhKu4zRBzUm6AhWBek/Ow1Y0LwDB
	 fq7fXdfH1n9lLNMsdxquxrob3j41xmf2C/Z2SpKNpnKDPXtR8kUEivPBSrqLIr+82eX+m
	 NnYRxf+VwnUKe/lmzQ6vnpPUVSSN27kjthPag8Hsx3w7QGtGtBw8RbdaqDf8hRMMyHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s5DUCOhU;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F48606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9F48606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s5DUCOhU
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so7623875e9.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793189268; x=1793794068; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hjdsRdcyqReQmZjxrYmZOSdGGalELyiuqpF4pWyDnMg=;
        b=s5DUCOhU2FyqMnnuMtDfRM90NGC12mfUj+m2U+peJInyF+7KzrYH23AqpALoNNj3E9
         U0rrVV7N/TnvnWbxI+NddOME+ZmBIn8HAvmOlkzC/nPuLBb639JAaz5akB0oxeEdzEfZ
         RAwti1ZeWNA6Cibl04txxMCW6R/c+HxYUoo6IZ3F3iJxUkaoykGLY9kGQT7YC7pqNmB0
         7uXEm98PrOLII4gOBkHPwyPuGf9KjNcqr/bq69SJnFir3lRMCbKmVmrDFw+SMSq/LReB
         CAPv/S3AKsFQfAJFaAc4DQoqVqxKDrDzbhyMMVtK640ftYE49fHb5x6cWOKOd4vnLnpG
         265A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793189268; x=1793794068;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hjdsRdcyqReQmZjxrYmZOSdGGalELyiuqpF4pWyDnMg=;
        b=ZtGmVlH5Fu1tsJkITHXsvn/gxAiOCuN0HRPPwiwzZdDXxbSfAxEtpwGZFt3DE1Xj+g
         wMsuCWRXSVlbWLcSjXOz/lKKKMV1L+PvpYt+F1IEcN1wVxwaRy+Q/EgjB1fCf10IEdYL
         VTd/O4OWaNdiyibE3qoNPlSOYfdXt/dOOppnd46/wEN2i/hsRxXgiCI4arSoEneB+jed
         0zWVHVaLHwD1Cyo0VH3igW6Ac6CbwMRDnEtzEZ69R3zR7x9QiJFBe5O1JHkpKG++jq/v
         zW86EVyFaIxBBxm8QkX2beNIFvGgY/xHBTzNI4gfDPj+oswl6NuUrBvfOru5kdL0U0cY
         tVHg==
X-Gm-Message-State: AFq9FYJcBTZmNE7lUmkCTJS1yfgovDwMs+btGs2vC390YAbXGqQDwIqw
	L/7pCM+a4liFR6Ulv7oLkOdpO7cMqOPTrtcKATrsxs1gjYHZLvRcJ060ZjwdOhBz
X-Gm-Gg: AYBFou3GknpL9Wri/ZtfnRu6l0bz1zRgCayVN0SMr/Z1DiFexoCQpu6Bieei4s05Kjr
	Okg3qVvpMVCKu/6haOJBh8Cs68V6CPeu6lVv3mQQS+jxqgdDbhU6zUW9mu9lxHrWvvNmcETp8ZX
	0YwTJOFratyIgWM5Wk13mipjYQ0m+yd4vEQqcDlA38HjgIHHPmswa6Y6OGBvG2AXne1w0W/C+jk
	v7zKutAz0i07NIgVNeA09cfRkhQuhAe+v55zLpKpXfuJmEBwKEYckJNfI6xu2wNi3RLjesZn1Qo
	rdeow0bW1BX/8B+mnfMT8Gxoqu1T7Pg7G/Ei1cl3XCUWBVAf+7HHMYZWnPCT5MJAHuru0iYordE
	nJWRlUDJvMGe7lIJ/nUMwUc7gQWY8cIxUj4TcK7pombFbSxjMIWw4xovzg0GXy2XL+hoJkH3VzH
	vjhbPurauTPf1Ofgz3E+Fkk15hc6Am2uAY8qf/RJOWxYgB8rVxbPJZgbBVY4suAA2Gc6iACbmro
	T1VE+llEPoIREuTr9PzMgry/TPSGwBS3cVcC2whdaH2S/JjH79AUJDD/ydqm5g6BfjrgoINWjkB
	mc/LRvq2sFSxFdm2zJGFmqybk4y8Q+g/Tf/ax4ODuiYeaT+yrMCglzbW5C3DO3dHmY+FYDswUih
	dvxoyXxpHYDZydYexgvBT6/BNXoUuhWb0K+UfYsnIN7PgjEyKPAs1H0TtGJ+Sfc8kFL9B8RR/ef
	6Cs98Sz7SDOzx1O9+D0WZiwmQ3LaTV+gR5TS6iEbU9pStKIPXZXftnJSY=
X-Received: by 2002:a05:600c:348f:b0:4a7:a5db:a93e with SMTP id 5b1f17b1804b1-4a9643d380dmr44264595e9.4.1793189267827;
        Wed, 28 Oct 2026 05:07:47 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:b017:4479:7c99:e3fb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97c42ca77sm39573455e9.8.2026.10.28.05.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 05:07:45 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Oct 2026 12:07:42 +0000
Message-Id: <DMGGJIMVUXEG.WJSWR3E4POW1@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] cat-file: extract the transport ownership from
 get_remote_info()
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
 <20261027-remote-object-info-batch-v1-1-ea7a1f0b1df1@gmail.com>
 <xmqqpkwvj7bj.fsf@gitster.g> <DMFX8JPX16W8.9VBEJMQVF998@gmail.com>
 <xmqqbj8ee3g1.fsf@gitster.g>
In-Reply-To: <xmqqbj8ee3g1.fsf@gitster.g>

On Wed Oct 28, 2026 at 6:37 AM WET, Junio C Hamano wrote:
> "Pablo Sabater" <pabloosabaterr@gmail.com> writes:
>
>>>> +	if (!transport->smart_options)
>>>> +		die(_("smart options required"));
>>>
>>> Is this an end-user facing error message?  I am not sure a user who
>>> saw this message can figure out what went wrong or how to correct
>>> it.
>>
>> I thought it would be better to say why it fails instead of a generic
>> error. If we drop the check it will die() later with "remote does not
>> support object-info".
>>
>> Since the smart options check only die()s when the remote is a bundle,
>> I could keep it and change the message to "object-info is not supported
>> on bundles".
>
> I am somewhat torn on this.  It is certainly much better than the
> "smart options required" message, which the end user would not know
> how to act upon.  However, that improvement only holds until we gain
> another transport other than bundle that also lacks support for
> "smart options".  Saying something like "object-info is not
> supported by this remote." would avoid blindly mentioning "bundle"
> when the remote that lacks object-info support is actually not a
> bundle, but it loses the clarity your rewritten message provides
> when the problematic remote indeed is a bundle.
>
> Do we have the remote information at this point in the code (i.e., the
> URL of the remote that was given to the remote-object-info command)
> that the user would immediately recognize as the remote they asked
> the command to access?  If so, "object-info is not supported by %s"
> filled with the remote information would probably work better.

We have what the user wrote for the remote in argv[0], so we could have
"object-info is not supported by <remote>", and it would be the same
for anything that sets smart_options to NULL.

But with that in mind, what if in the future there's a transport without
smart_options that does support object-info? The smart_options check is
there because of "this transport can't do object-info", and nothing
on the object-info path reads smart_options from what I checked.

So I'm going to drop that die(). Later in the code there's already a=20
check on transport_fetch_object_info(), which looks for=20
fetch_object_info in the transport's vtable. It's a bit later, but it=20
checks the real capability and it will give less trouble in the future.=20

Currently, it has a generic error but it can print a more detailed=20
version such as: "object-info is not supported by <remote>"

I'll send v2 later this week as I have to study for some of my midterms.

Regards,
Pablo

>
> Thanks.

