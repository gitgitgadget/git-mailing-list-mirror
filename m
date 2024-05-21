Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71D61E48B
	for <git@vger.kernel.org>; Tue, 21 May 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296352; cv=none; b=Vp/35+iUT7eFbupHVF2qOBWVbvsro0ulD8T9xGGHWl51yw6Gtg4UM8ubDNW/xH63R5BT2FQ/d3UI9F4ElLsOZBsRpCeJMNhTW1tB+GFVkdlR1sWcLw0iknQwEuEjGbQSDkE4WkLplSdNiF3EffJ4eKFXBAc7GnY3myATe3cQtSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296352; c=relaxed/simple;
	bh=WgQlHwii+mNddwzGUsvSR1xYOwQBYXBIzO+EDWBQcPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPCJw+qGrZMXDqOb273PFbn+CcyNErkOIXUvqowA3no/uI6/IuKpJsI4ZPULFhuwpitnXybML80ClPJidWz+HCsRuZQZdKN56PxlEo9LbaESBfmK0igAjEtssGvNLBtwX0/ral286ch0Ao/4PCx5u7JcAb9DprOEU1yh+gviW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/PehO6n; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/PehO6n"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4200ee78f33so32089535e9.3
        for <git@vger.kernel.org>; Tue, 21 May 2024 05:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716296349; x=1716901149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9O6aUXmeLqe6D1hm7Is5uVWrB3ErHcSSQpSz4Fo1J4=;
        b=T/PehO6nXuL6HXgFBOMLWLadyuS2EQ7/qfEIFicH20OiESDSRtdfhjiDuDcvPnmsic
         UosxIULV6yEJG4t2OpKqKPDmj7R0pP7GIjfpn1a4pfFlldKGWizJUxAs/ZPIkO4+LEif
         EARFE7xNnN8k60+1W/VBO2a60MY78HXjF60MZYzt05Q6xKtC3YOmggLs8jf6c3yIhLkD
         SxLjTsmmWek7ubFk5wIVvt+Dr73v9W7OutCZRojViIZ7v/oLk7BV9e3GeooFT5YceMoy
         k0nBOWPFi2bhjcz+/NEXth676UZgxvc0U1+idMbyTcVk05H0gtPD2l0NxZav7wsmieSK
         mJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716296349; x=1716901149;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9O6aUXmeLqe6D1hm7Is5uVWrB3ErHcSSQpSz4Fo1J4=;
        b=FJwsCeV7Gpz920ZTsDQDrJbepGciKdM+/UDwIbsj6EpoW480En3ziI0FwuZ1D+D2+p
         w9P8L/706vpSRpXwd6II4v7CPiN5hvONWJaONfuc9SOFRasSjw1WL70dyYmzKVQdd4OH
         OX0sS4NpejpeJ8B5UzEesFTxGLQN9FGorhzYZHPkmcS/CLKMBT/TjcKgGbAkmQVQsoE9
         YUtn+9rrOH0Jnig5QR6J22MzCCu8HXnAbBd6lzTtT9MXWczBt2fKw5XiJD4QUwsdMRLx
         ir8zJ0rLv3U98axkQqaTf271dX+5POoTcX+NfDjCdSWB+3T1mMUEx1jVp0t53SzYFYO9
         Pz1Q==
X-Gm-Message-State: AOJu0Yymd4z1xiJyf94ii/gGXU+6H6WmLtc3UjDJRiSURWZrnyRqr24p
	vm2zvW99wQLbUSUn8S8dWNnaSZwPfyd9n1u1jWZoTQ7EkoHY4RTpdIFPQQ==
X-Google-Smtp-Source: AGHT+IF1AWMrzpJfUiOqQWNHfyYYCgKOKf0hD1P7DxWc2S/x4MaGZ7KsjZRejvlnL+EP29/SUYNuNg==
X-Received: by 2002:a05:600c:4ecc:b0:420:2b2e:f6e7 with SMTP id 5b1f17b1804b1-4202b2ef814mr132960785e9.17.1716296348849;
        Tue, 21 May 2024 05:59:08 -0700 (PDT)
Received: from gmail.com (96.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92bcsm463023395e9.36.2024.05.21.05.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 05:59:08 -0700 (PDT)
Message-ID: <b7f9de4d-bd5b-40e3-8ee8-977f507b616d@gmail.com>
Date: Tue, 21 May 2024 14:59:07 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add-patch: response to unknown command
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>
References: <1dbe4c61-d75f-45d9-95d2-ac8acae22c56@gmail.com>
 <ZkxHLE_8OpYvmViY@tanuki>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <ZkxHLE_8OpYvmViY@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, May 21, 2024 at 09:03:08AM +0200, Patrick Steinhardt wrote:
> On Tue, May 21, 2024 at 02:37:54AM +0200, Rubén Justo wrote:
> > In 26998ed2a2 (add-patch: response to unknown command, 2024-04-29) we
> > introduced an error message that displays the invalid command entered by
> > the user.
> > 
> > We process a line received from the user, but we only accept
> > single-character commands.
> > 
> > To avoid confusion, include in the error message only the first
> > character received.
> 
> I'm a bit on the edge here. Is it really less confusing if we confront
> the user with a command that they have never even provided in the first
> place?

I think so, by giving the user what we find wrong and implicitly telling
them what it is.

> Shouldn't we rather fix that and make the accepted
> answers more strict, such that if the response is longer than a single
> character we point that out?

That's reasonable, but maybe we're going to break someone's workflow?

At any rate, my main goal is to avoid the '%s' in the message.

> 
> Patrick
