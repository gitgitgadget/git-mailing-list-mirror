Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85386313293
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758290407; cv=none; b=cqw3iFFChZKM+kNxvtH7zsP8Nqi2OpF5AnswjHMXXuHePEFWaMcbs9DBv0rFFo2nRUzU87YkUrbFqCvkgdLNCDp1dAGASXiVDs0k6Li3Fb8FVL4tjGEFP0ejXbb+4H6euK5Ob3JydWcRTi/1p9gUbDADtC8BFCKwcjBE3d5ZceA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758290407; c=relaxed/simple;
	bh=uyLDQO8O7P9yA0LBrXB+19ETHUW+6G4nur5ge8TvHM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5vKPSXBAZvtIIAtcVU5evS8AIztCQ81mpVuzYvWP2iBwizxyVeZWo/ptIM6J4HPIcMJKYzLFeLzP5eRgp22guqKSx0zkcVHt4xm7qDfVcFHlutH2srPv6y3ceZxu4Yjxmcjaa6tz+FMsThF5ilMEjdsbT+NiGI9Ah5ZTCEuaTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjSFHPkQ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjSFHPkQ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ebc706eb7bso1109394f8f.3
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 07:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758290404; x=1758895204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5SXJXLadkpHSVRR2Wi1VK7HdHta7PJjNVfCZYlZRnP4=;
        b=OjSFHPkQiF7UxAbMwefIFtlxG/X3lJUfkwuOc16ih7vZQnJJudCtYRBMlPoMkAD2A3
         OnjMgMm6QQGVojIEG4jw97LMj4vU762izcRN2fShcyWdPnlRkQsgHxCUbWWkT3l34x3C
         4OqDhk9C2b/Qcx/wA58l5+xMU+V0XnIcB7Zxaj6WvXMr1XWK9fmVQ443ixvgsFZI8PdZ
         kWT0qc6MsRxZc2jRZySyYBrn0UufD6yBjucLQNzAWyTMQJ0hCEcgfpETjTcT0AIXdeXu
         6sNEmAgw9/mym/AcHW13HsuJf0e2IsUn3qWc0mZgTJPNnH1kGvEBbRuCNEA+U8z4A+rn
         aEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758290404; x=1758895204;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5SXJXLadkpHSVRR2Wi1VK7HdHta7PJjNVfCZYlZRnP4=;
        b=L7MFCShjdXVJ+yQJ2uP1udg0jAebKwd7VN6+P7N8hgfWzs2mdUv2rY+/44jmSn0XZu
         nc9wrymIPnCcW+t2uWkNaSaWST31wIOpye0nrgNuA2NtZogIFE+xHWl7H26x6zBP+nZS
         x6CRCqS+0vbUhp+8VGTBwCFcTh48jaFUUNtrIvFHvsoeQ5Sl7054lDrEZe6T8bAuUQ7V
         haEYUYCEXYs4PDQDUKnJBra+q73YC3vWPuvZQp7seqt5pfYTIcL7VYO31LzthxXswJLA
         0E4wPi3j0FqzeYEOOHJUWOufYmCdSicq6wBw/LlECEqWWWg8563eHkIQPtlcVtD33Kj5
         ZBxw==
X-Forwarded-Encrypted: i=1; AJvYcCU6y7BERq7EKStRpiWoT6jpdIQhAmYhz6TFyUGKf5f/leQWhglWOfOBXNy6WmGCBb6e1nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwslqfaW7Di7JzZn8pQEyQplsEJop/0eKslXXGblGdI7euu2srt
	WablHoG8J7gvpl/aj+1YdJ5Dch9Dp5dQhxC0qvvb7NjdRh52nf1+FXjq
X-Gm-Gg: ASbGncsFthFqkiD97MFcAHQnQFFBlJ5Ad8Kbiyi4IO9xFEAIrNGV3bLS/t/SQXOZWkR
	ylIsZRmm3LGEK3uNGE75b745kdacOdlF6VaZeAw1vZlNugvto90x/rbfoCYotfgJ7W5ljwvcybs
	I02NlAy1WJfSCsei41J19bU7LWFuqBjydpfJ4dZc6JIIu6N8Qqs+d7chbjFsCUqWbVT+xClDNp7
	UgQ492ct7E1pPKL8m4UofgiTtuwHqaeqRxscbAoFQh9DSNMQoiuy3BdkCHUiM06X7D1hRWGFPyM
	iKgE9Xh129DvHfgp6OgyQmXrvfDe7oWsA0MdYO+J8GOW+RasObI/yFzTj2+nhUQGg2TPY9Mu/UE
	y5yQcdiP+HK6emhR4nDwMhRiH3g/fjlH8TCPpIFIVp2uSTriM2oG1uEQ2dcfQSXwOMlsbS0B3Vs
	k=
X-Google-Smtp-Source: AGHT+IF8rku/RHkyM+x0dOo9BcUxCarnlzPXOxntlxBh7ueHhL/ud8dzvELeXebUNdl+StbB5g3pvg==
X-Received: by 2002:adf:8b9b:0:b0:3f0:2ab8:710f with SMTP id ffacd0b85a97d-3f02ab8748bmr1207628f8f.8.1758290403439;
        Fri, 19 Sep 2025 07:00:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad1b0sm101606165e9.21.2025.09.19.07.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 07:00:02 -0700 (PDT)
Message-ID: <72d0a316-ee3d-45a0-8122-77c52911614b@gmail.com>
Date: Fri, 19 Sep 2025 14:59:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Ben Knoble <ben.knoble@gmail.com>, Christian Brabandt <cb@256bit.org>,
 Collin Funk <collin.funk1@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>,
 Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 15/09/2025 12:22, Patrick Steinhardt wrote:
> Over the last couple of years the appetite for bringing Rust into the
> codebase has grown significantly across the developer base. Introducing
> Rust is a major change though and has ramifications for the whole
> ecosystem:
> 
>    - Some platforms have a Rust toolchain available, but have not yet
>      integrated it into their build infrastructure.
> 
>    - Some platforms don't have any support for Rust at all.
> 
>    - Some platforms may have to figure out how to fit Rust into their
>      bootstrapping sequence.
> 
> Due to this, and given that Git is a critical piece of infrastructure
> for the whole industry, we cannot just introduce such a heavyweight
> dependency without doing our due diligence.

I'm not sure what you mean by "doing our due diligence" here. We already 
know that requiring a rust compiler will make it impossible to build git 
on some currently supported platforms. Isn't the purpose of this patch 
to give them notice so they have some time to come up with a plan for 
either (a) accelerating rust support on their platform, or (b) for how 
maintain the LTS branch after the we stop supporting it?

> +1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
> +   disabled in our Makefile so that the project can sort out the initial
> +   infrastructure.
> +2. In Git 2.53, both build systems will default-enable support for Rust.
> +   Consequently, builds will break by default if Rust is not available on the
> +   build host. The use of Rust can still be explicitly disabled via build
> +   flags.
> +3. In Git 3.0, the build options will be removed and support for Rust is
> +   mandatory.
> +--
> ++
> +You can explicitly ask both Meson and our Makefile-based system to enable Rust
> +by saying `meson configure -Drust=enabled` and `make WITH_RUST=YesPlease`,
> +respectively.

This is helpful but ideally before Git 2.53 we'd make the Makefile and 
meson print that information if they fail due to a missing rust compiler.

> ++
> +The Git project will declare the last version before Git 3.0 to be a long-term
> +support release. This long-term release will receive important bug fixes for at
> +least four release cycles and security fixes for six release cycles. The Git
> +project will hand over maintainership of the long-term release to distributors
> +in case they need to extend the life of that long-term release even further. In
> +that case, the backporting process will be handled by these distributors, but
> +the backported patches will be reviewed on the mailing list and pulled in by the
> +Git maintainer.

Didn't Junio have some qualms about the last part of this paragraph? I 
thought he suggested that once we hand over maintaining the LTS release 
the people responsible for it could use the security list to coordinate 
their work and would be responsible for pushing fixes the the LTS branch 
themselves.

Thanks for working on this, it will be good to have a formal plan in our 
Documentation that we can refer to.

Phillip

>   === Removals
>   
>   * Support for grafting commits has long been superseded by git-replace(1).
> 

