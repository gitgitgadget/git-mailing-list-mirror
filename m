Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792632176;
	b=q0JqY2aouDTjDriq2uk0xQ+az3EDP2t1zwnqrqH8gngelytmK0Jm5QgcZtfYIhemgmg5
	 FIfGQejThqy6Ebb7WYplqxhtgL/6wixhZRZAt8QjV9oewz7P0ynEkP54Nqs+yMjzSrxZm
	 H2mS0ZVo9RyUzQIgdYzSqgptKx/bRPkTO1TVRovIVagwb6ewmTU2mJ+E+8ODpag/2zpBb
	 Uc/yurW7yOsiZO2/3YnWQdPxzOihN20ipi1SAaorD4sfseIrhwkUI3msLAeIUGx40mPiE
	 4Zw+8IW2Z6kTApp7umdqzffhQmNygtIi64ts37kmtkoUxyyPknqpcFVnUPR0c3CUpgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792632176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=G66UoZUqMc0GqdoRhq+8fuqVLsk9mPLrrGuwj1TVpA8=;
	b=AnlIq7lxAF0a//JfZ3kaoMbykBIfunG+Kodf2m3r72MRTpADDXRa9NExntW5UFse1eO+
	 fNcWC+VD7Oxi8PiAVTlLeAQgcJDCR1GizraHPZ8sQWnkEXFcFgWsVjpv9Cwg6mc43PF1F
	 mmgXD8Y369N7qk7UVLZYwWS3gOcwZ+U8hboe9aN1iMvv8tF3GPRMDu/6yNW/gwg6U+a+l
	 6Dn7MG4XP+HCmwzB68AfGIOx1C6D05Ba4dJv2W3uabiVpcOGtwKd9x5Dqpv/3maawvC6y
	 lNsODCWKioCD7LyV84ntXVrn2mB2PofSefpFBSTg6zhhgcw4UKliVyr5Rc2w1W6sA3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G5RelDCz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766E5606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 01:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 766E5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=G5RelDCz
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b4213059d4so118388a12.2
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 18:22:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792632175; cv=none;
        d=google.com; s=arc-20260327;
        b=J980BVMqZJbJPlBdTHZwc7iycbEbe+cg0OLltHPluHOSbNpNsM8YQ5CdoqLZVWKt0Z
         pybFMPZRxQsKHvIiKdbMdvmThjxpcR+CdrUbFwp/No8etIVaxQFVC9j+Cz5kxA2J6AXS
         7lYkEHdqFYGzhWuAvZaoRPBAxY5X3g4n2gr5hcPKVy73T1/lewzz/Amp+7/TdvqX1UEG
         jE/oIuozolL0aq9c/AxFpPtT8ppMKPVQphev0GLvQAh6U0kzNCE3/99bxo4SrwzWY3G3
         l2vsQbHhFZLqAPmAH+K619pWLx26MXcJr0t7MgUX4VT/QocKoHw1/1RLfsyab38zGBg6
         n3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G66UoZUqMc0GqdoRhq+8fuqVLsk9mPLrrGuwj1TVpA8=;
        fh=hIzMqH9vtF6hTCMPH1CwC4iasS4kLBtDt9YK+UGWA84=;
        b=qf2qB13TIVy1jMSuXqGZrOtIArv5y6TsjPcpRzUk7SVibXfH6qWHStbEgMBnxb4PFC
         YKEKjte1eveNHJ0zH2UrWsUlVC6Ln0iGlWNdyJNa/+Q+bsPBwKGLydi/d5C6iZqhvONV
         EeD2y0iLsw38sYR8sZx4tjAQfZbR28mHWzzJgYjdrwH1FmcSVxbiMnb4HtkUV3rWZvOS
         C/Nnjl61VK5hRMxvwCz6EumxwgZEBYBdusR0oykwUBcbDi4PhjZ2VTag4knMQNv9b4cR
         3YOTh8HepdhHIR/oO8iYEoLUVbI4NEv1ftEW3xusIFCQ6c7/IMtmDNR1u2GUgrRoH6qU
         CHLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792632175; x=1793236975; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G66UoZUqMc0GqdoRhq+8fuqVLsk9mPLrrGuwj1TVpA8=;
        b=G5RelDCz25ZnaCZwZdMHAD01NkqJSyB1auKfv+Bvk+I3D6wTlDsbXW/539OHcs7wZy
         sRxharc276l0yHkcJra6uyyk6DmGfetLFqQMxkfhOyPvUMlUIpUPT04rQcnuebyfrzfK
         YhxowrM9unx18Cd/PSlMvlCQXd1g6BBHPDNWY3Jq5MGUscycibcIv2eSEkN34GYqDD5E
         C/HiNeagVXQU9FUPGNjR8/9jJX1maSyDJ8gF/FAZPt3G0/ZCAtmM7xmQ2b8cSYiw0exu
         QvYJH5l5V8+bsxPoV456gTiJxqBd9BJcNwLJYH/Nf76YzIp+lTwzduY941kwwjdax9fg
         FXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792632175; x=1793236975;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G66UoZUqMc0GqdoRhq+8fuqVLsk9mPLrrGuwj1TVpA8=;
        b=zp6ra6J/TYR1YgiwmarZ6W1ZmKb92mnSa7bsD7Q1sO1pmsFcoXIhSKIBR6aAiKcWJw
         TAsmgZszBQHO28SCB5ufhB/supfFoZVAo8Uy1VbcRNgW3DyXMn917n45qIAHbThEgU1f
         /qY78w/HzzHzL1ZsCHSZN9cluX5dfgFoPknhIxjmiE28ox/ccR7R04Rl7TrTCGJxL8Ez
         Xl3+mEzGkPXcmaUuhbxG5AeWwwCO8kVGlBPBh9rXcZUopanYepBWAkSU+zlrTQF+UFK3
         wLx61FqLgzWQz0I2ZWWZ3Eo+jJjWQIBPggiwTFRt1QbR4R5YKhpVAT8CK2jTosK1HM5o
         2L2w==
X-Gm-Message-State: AFq9FYLc/nqmRzevXu/sRMVbRLd4oNm2Kl/oN+Yx2flCKs52XnNhbH/0
	m6ev30XVj/4zmYAnT5knoOo2bKMu9LcWCanyF7ze/wVd3IS0lZ5w2YTf3DZZyp7SwyTOJ0Rm/er
	uVQQVG8iLaYZuvpvznrjNDDDeQjnLfSw=
X-Gm-Gg: AYBFou0HYaVYDfcQ/SFlWW5l/D5INzKqN5GmTIcFovpPWWemjoqbVBp4qnPoEA+eToV
	T2BsLhK7gSSK2pFD04oY2OleUxEmkKHJaDc55g7YO+AMRnhS6/QoQ3gNl1jbIQvobmbzXglnlFm
	9K+Y0lv3hYIumKNDM5RMHP0WgeA3gEbvrY5Q2dzY2TiKmFWcnvfOHbeABLYKYLh2IO2d3AwLci4
	XncNI/87KTbWGZESowHqkfQWcVqYJ+tBnzZeDOEPtKlJDPk/r+JKooWZUO/or3nLKUeMMy5i9KL
	m3L8vsvpo2Ahs6SYryPKNlsa1+IkSNB5hOSqFaafOxaqKfKH8rN4LG6Ly36mr/1E53YX55orPf+
	8hy6yvqY2qgyBFpmEOP4koceA/pQaA/YVS4j+
X-Received: by 2002:a05:6402:450a:b0:6a9:a362:4646 with SMTP id
 4fb4d7f45d1cf-6b408ea5dd1mr3082546a12.14.1792632174744; Wed, 21 Oct 2026
 18:22:54 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021033723.5265-1-herroyalpriestess@gmail.com> <athxA6S50czDEUYj@pks.im>
In-Reply-To: <athxA6S50czDEUYj@pks.im>
From: Priestess <herroyalpriestess@gmail.com>
Date: Thu, 22 Oct 2026 02:22:43 +0100
X-Gm-Features: AclHuK8dMwqFdbzcMUNWPnONpVWqwqh-WPaXf34Kwp0VXoCsPaw9IEtIVmldkXk
Message-ID: <CAOcE0wLUZP+HG_X+C72U4vT4eYp=F9XK79aBdAiArYODxcYeAA@mail.gmail.com>
Subject: Re: [Outreachy PATCH] t2104: avoid suppressing git's exit code
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com, 
	kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Makes sense, and the patch looks obviously good to me, too. Thanks!

Thanks for the review, Patrick.
