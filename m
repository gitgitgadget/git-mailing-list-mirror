Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FCEF510
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727367749; cv=none; b=n1e9vKtBlkbI5IzjulKfLqNlU3U262+7lm/jEsDq5IWt9yL3A3fW6R0WXZRJhecyH00WJiH6Am6jB6ltVNYRorWy6pwaesNEIosLWjJPWLYzn6YrfbIqZ2e9QT/4ThB0mf466zYxFq8VAs344/H6X1TfAbEeO88BjKFZFUxG8Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727367749; c=relaxed/simple;
	bh=ASM3mfqPLhej0dCEudcpw2CHlBO5KxmFh+u91y0ORjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W0zj0q12ULERaeAd2hScDBRDfbQzgvunK1dyupuCENGJ9QA2J4yiAlkCGmYAaJToJ1VufRSZOzOlY+H6X/mWhvkdsX0UCN8wbjB1/Yy+JL4vt0NWm5yGeBTg5J1rTp+pG5WRiHuOQQbZbtPc58YHmH6BzJOPrfGojQgP2z/YeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuBJvX+t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuBJvX+t"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2068acc8a4fso10580635ad.1
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727367747; x=1727972547; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ASM3mfqPLhej0dCEudcpw2CHlBO5KxmFh+u91y0ORjI=;
        b=KuBJvX+t1MibF7hFbSV1KgijZRwHINsm544VYLn+x2uYfWWQcBSCR8lHwvgePZx3se
         vABfveErg58t8q82H6qn1nYhoXi29BURKRfyq41ECRJ+SM2VaHHwI7Nm4p2EqN4yF9uy
         7wQPd5SsFrPdsgVusMLySGA0F/CgHe4v3bhkgOLNRB9ZaXeN+7aF6VQlyTiGE08Q9f8L
         KbRWfkJrruhs7f9uYBeFAFeR3ORX7EM14oSiJYzcl1OxOU3bK59DFyvssLhBEBe6NFAk
         BisjRdDMgYqxKo0N/M25HbBukTi2bBPOPv3gNZPaHaHTCbPhUtfr1V1Ql6OvoNsPcTkM
         VEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727367747; x=1727972547;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ASM3mfqPLhej0dCEudcpw2CHlBO5KxmFh+u91y0ORjI=;
        b=d6p+4JfJJAPL4/2M53o6vnLhSbi4CCKHhQLLiovp5PA7zRJe/UjqOCG6qElOZSVcg8
         zbTur0SVLA3Q4YBJA/c4/lRN5ELcmshfyHFHclfwFXyLy+j0J0LhAuxCjFcrZ4+Um0OV
         6N6rPKTEH4/mKJ5wHkKS7h16XZC4sd0d6yMhliX05JX1QXfz7F0d3jUoZ3B30x8TNBV5
         pYCs8V61r/mmFlZC6n9+cGbWLMMnyC3emHq4UYJvD0o6aKBuml2GCFbeIIJgNL5JFMwk
         +nxUWjXoCCxASrJjFtitJvOjDCrLwCQqwRzcPNzTb+WqNpIaD5R3D0KcRKoniBTzUllq
         IQKw==
X-Forwarded-Encrypted: i=1; AJvYcCUwSnj8rSFovz4RQIi9oiMJaQ8NfPkDrqu+4N0nj2aZXairLdwmSSpFj4kczv1/zPcVYgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeW8eXJRVwSeRJeDMCUariPCV+wpi74knZZj3NWnsVJ7JgPj83
	neaRZNvo16kwE0zP1g4Ifl5RKErMIadt2/TdszaJN3h0cq6PT+bC
X-Google-Smtp-Source: AGHT+IFoA2aRGU8vOX2wKMkDhYO2QFxrU2juF5tUsRcwEstrTkns68UD8QvU5jN0mRTxtW669tysxQ==
X-Received: by 2002:a17:902:f693:b0:20b:c8c:6639 with SMTP id d9443c01a7336-20b367d01d8mr3761025ad.4.1727367747523;
        Thu, 26 Sep 2024 09:22:27 -0700 (PDT)
Received: from localhost (217.108.125.34.bc.googleusercontent.com. [34.125.108.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d9147fsm461215ad.80.2024.09.26.09.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:22:27 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Eli Schwartz <eschwartz@gentoo.org>,
  Henrik Holst <henrik.holst@outlook.com>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ./configure fails to link test program due to missing dependencies
In-Reply-To: <3a303c6e-35b0-4428-9d23-799b33194330@gmail.com> (Phillip Wood's
	message of "Thu, 26 Sep 2024 14:55:52 +0100")
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
	<xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
	<29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
	<xmqqy13oa8oe.fsf@gitster.g> <ZvKsH1Ct-YwBPA_f@pks.im>
	<b6b131cb-683c-4140-9769-290b622721e1@gentoo.org>
	<ZvOTL0cG8qRY8OXe@pks.im>
	<1f002f86-9212-4639-8804-898bc62726e5@gentoo.org>
	<ZvOn_wChzEgXtpMd@pks.im>
	<3a303c6e-35b0-4428-9d23-799b33194330@gmail.com>
Date: Thu, 26 Sep 2024 09:22:26 -0700
Message-ID: <xmqqv7yil70d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Patrick
>
> On 25/09/2024 07:04, Patrick Steinhardt wrote:
>> On Wed, Sep 25, 2024 at 02:02:34AM -0400, Eli Schwartz wrote:
>>
>>> I'm probably biased, but some of these failure modes are *weird*. And
>>> they basically never require the CMakeLists.txt to do something
>>> considered non-idiomatic in order to trigger the issue.
>> All of this is very valuable data to make my case for Meson instead
>> of
>> CMake. Appreciated, thanks!
>
> One thing to bear in mind is why our CMakeLists.txt was introduced in
> the first place [1]. Visual Studio's CMake integration means that so
> long as git-for-windows is installed building git is simply a case of
> clicking on a button, there is no need to install extra software or
> plugins. I'm not sure the same is true for meson and I don't think we
> want to end up supporting both.

Is CMake the _only_ thing that is integrated into Visual Studio?
Are there other possible candidates that could also be used to build
for non-Windows and is usable by this project?



> Best Wishes
>
> Phillip
>
> [1]
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2004251354390.18039@tvgsbejvaqbjf.bet/
