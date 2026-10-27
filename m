Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134806;
	b=fObqAEO1TXXHvshOlvKL+/HXVmU/E1ol8TRNHpouW3P4PF2XL21nb5Wu5ES6IBZmmmjh
	 qBI7Ukx6fN/zTamBVXkwF0wE/3ytKwT9e8gbBXJrnIJWhWkllKVFnAfHjTqte9qUl7Bi4
	 m43GqUV3aHTlFwm4d8fooAvrnwDmM6KwCqslU6SUzJRpEowuf5UlEesfZnySpoQYj7CDC
	 qQZVGDpeGvmf/uO4LiZAvsIN20SnqV7Yt6O+7N1B/cEO1WatiKhyQY3We72FBj9hMLrD1
	 kxeG0anFS0Jca0hgNNuYzfZ+r2EySfgtX2WOGr7FEg+CcpLjS83NS+P5KwUwYu2YZJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134806;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:
	 From:To:X-Mailer:References:In-Reply-To;
	bh=ABh6/zfgsGd9pABZ6nCZg8heyBHiBQRIdpTyD/2eIV4=;
	b=guwS9sxnfqRb3OyoiiLGE1IRhiM38+3ZLHPNURt3nMXcobmw46s9xr2odGz1Nup6k0bd
	 9WlkFZpkz8AQ2D1EhKCmbMyzH0WEn6nhEQT+BI0h8wKq96N335P0PSnWp4wGqnWDbt9W3
	 WWu2UXWvqbg4fl8fxIPAuWfJj5NbRIz/DQRZpZV5x5Uvm0DP8IPRixKpDvXfXfxgMnXua
	 8/dfC0735ItZbQ/BFdKxitUdHngadukw360gb0IrEW+0QtEU/S64jpomvejTpuoHOrQUT
	 J7fND5NgFhw+/7NBoqimesuQHq07ihXZZigselCsuJmrVllZdh0lWF2RQqH1NPUuiPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J0PLg1jv;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7270606A31F
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 21:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7270606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J0PLg1jv
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e46e449e8so175491f8f.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793134804; x=1793739604; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ABh6/zfgsGd9pABZ6nCZg8heyBHiBQRIdpTyD/2eIV4=;
        b=J0PLg1jvxpEI3uqT+hBOYMDxgEdm7lAL0GDPwstMXF0axE1wp7RTwEavyj5Jw9d2iQ
         HDErE00MBIQJij9yQFt9iVsdmMxDlI7B63SRgEu3Bny2bQXh/tRRiokxNO8f376kuKdQ
         A3SB+glgulZ3nEmYlwtcXjf1iZlZO1+bZ4B1M1XQel9e9Q0YtJj83VvLxVVpQV1W22vd
         /afmXCi6Sb5Rx2z1ZIfSQToxIjxqTQJKdfWtagFi8DUPR7+qYuTxaZvUWShzljm4YoZ5
         bYoCjx7QTj5tzQvkXIW8Y/KUWRKnxdR/iC4CWizzx32cCABp6sor+S3UryWlcZ90qRS3
         /Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793134804; x=1793739604;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ABh6/zfgsGd9pABZ6nCZg8heyBHiBQRIdpTyD/2eIV4=;
        b=DdYwZ3HPYzIAJGSlI/swEtcnhCJr79/qTWhz8312ZLarGr5aFGAeJyCU62BPsHxR3h
         zO2P1YRYzHiWfJogpKVINYDAp/05/7JIwVQFhbqKef2wjlcUXDvETjZW46wI19zfRIii
         Xix72siLo8i5CF3Yr8nQsywCuSt3+nsJatrOF3Xz8OgTkkN8JIrzbZwQcoHo045ZI8XB
         smsNgRi9YUUZ3r42+0tRpZFV/ryvYwbw6pkjMU815ecIYmxvJ0Pt/WGseWNDDj22jlIs
         GrJoKdhlSm27d2LePrX5JsDpbYrfevMOjJyazf391jfryEXiOhNuhuS8AHr6n7fKRqce
         auGw==
X-Gm-Message-State: AFq9FYItd/ZTV7iwptvXAIT4rCXIGe9mlpIgr+8u8M7aclYIVnBbyXdd
	vwBc+3lI7re13e4RT5mDmdO/D65t7f7Nx0vODA4AxaO6nin476l9qcKz
X-Gm-Gg: AYBFou32HrgNf4qoAX3RFoy9jOEpbUPEtgoWvIMhpm9tvH5cCwotzV4t+50yEq7Cup8
	as9xjWX4siNGNFIOXsPEuJEg4NPf/P0vIUI/2ZVA3gpIIloAg4XmvDGdIQR6ethi3nkMpOCXLR+
	68r5UfwcsgWqiLILiLUm+8Fo1dXPGcCHF4Cgc+6mFccht82L027peSJe99tdBCVR3d9ilkCUGkV
	SrrtlO/7TyDP5gRchQIeHWt/phIcuxeTwGOdC9RwZ213xgVSdLUUuCNsx6UaTCpSyFWLGfXjhLZ
	d35IPRb0//pWbdvhFQNkbqR4bMr32MwLKJWSQZj6yxBg/YyGqC5hcLKcnTm+Bv59CXOyLBCoKWa
	iEew5J3FvogO9mkFZZ0+ui7zjyA1HJUFaPdolOKv9fe3XNnnaPGU3co4GPjlDQklZrz6Ku3j/XN
	zu2OimN3zFWelLwYMxJrJf7RqBJcTXYknowX9G/I+MH9qXt+Aduc1PIexAuy1QNzEx6SbqXipkD
	TPb94XGHxpHaeGO2sTXRn/CqaOyLpPJVN3kgcU5pcz7d4mzle+dEjnFSYej5dI6vuKwcuQ2MxNj
	1zPIFeW7ApejeZBm1Hsvv93hQJWHWlzeGQNk8BX1ZVkG5sKtF6ZMcsf9b3g9l/1GBcB7TOCFZzU
	ejKWOf0eSjI+7WsNNrGDpCM/SVQ3wLPeH9Z+UQemeqr7fKH3WZkJmb9Vpy3/e2smm4UiBKvULHX
	g7LnA=
X-Received: by 2002:a5d:5f52:0:b0:48c:4658:602b with SMTP id ffacd0b85a97d-48e5d2e7375mr1542295f8f.10.1793134803805;
        Tue, 27 Oct 2026 14:00:03 -0700 (PDT)
Received: from localhost ([2001:818:c665:a700:d08f:88e:8091:3e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm26156864f8f.18.2026.10.27.14.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 14:00:03 -0700 (PDT)
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
Date: Tue, 27 Oct 2026 21:00:01 +0000
Message-Id: <DMFX8JPX16W8.9VBEJMQVF998@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH RFC 1/3] cat-file: extract the transport ownership from
 get_remote_info()
From: "Pablo Sabater" <pabloosabaterr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Pablo Sabater"
 <pabloosabaterr@gmail.com>
X-Mailer: aerc 0.21.0
References: <20261027-remote-object-info-batch-v1-0-ea7a1f0b1df1@gmail.com>
 <20261027-remote-object-info-batch-v1-1-ea7a1f0b1df1@gmail.com>
 <xmqqpkwvj7bj.fsf@gitster.g>
In-Reply-To: <xmqqpkwvj7bj.fsf@gitster.g>

On Tue Oct 27, 2026 at 7:02 PM WET, Junio C Hamano wrote:
> Pablo Sabater <pabloosabaterr@gmail.com> writes:
>
>> get_remote_info() receives the name of the remote and from there it
>> builds the transport and at the end closes it.
>>
>> To be able to reuse the connection for multiple batches in a subsequent
>> commit, it is needed to extract that responsibility from
>> get_remote_info() and instead have it in its caller,
>> parse_cmd_remote_object_info(), which will handle the batches.
>
> Makes sense.
>
>> While at it, rename the transport variable 'gtransport' to 'transport',
>> as it looks like a global when it's not.
>
> Good move.  We started (not particularly this program but the
> transport layer in general) with a global instance of transport
> object called gtransport, but the ones that we create on demand and
> release after we are done are of course local and it is misleading
> to use such a prefix.
>
>> +	if (!transport->smart_options)
>> +		die(_("smart options required"));
>
> Is this an end-user facing error message?  I am not sure a user who
> saw this message can figure out what went wrong or how to correct
> it.

I thought it would be better to say why it fails instead of a generic
error. If we drop the check it will die() later with "remote does not
support object-info".

Since the smart options check only die()s when the remote is a bundle,
I could keep it and change the message to "object-info is not supported
on bundles".

Regards,
Pablo
