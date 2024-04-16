Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6271386D2
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713295883; cv=none; b=e/T3You3DiHD6ThljvvgMrGKOOeWMuOOq1x6IKm0LL+Y6easKVXaY4fN2gl9ZxoFWP4sFr2nqIdkH8sZkgs/sInE2WnjZIPb0F1iJTajTqV4QBuL9pLUV0uwWU7cPhRkpMNSvfP+aQjKTq1Z533PrgrnVVnhvMjigxiqAjWevkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713295883; c=relaxed/simple;
	bh=5Qz85U8fdSx9tLuu0oCboXzNBahTlZhYpQdzS/mYAp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbZWaoYYZJQ+gcIQRb1XkOM/whgBQ46NOjm1mtsM7TM8J4BIY28AHv7V43gKeg8T/CmdLcG88N7XCEWbo6ZPUe42bJujXfLoJ4adecSNAVESBU3+Z16nAextVThXYRRsqqsOGxvHraZoQ4EAt16Y7CtG6zF0k/urJxJaNJFC19E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTi4G4uv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTi4G4uv"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4189a6a71dcso5680635e9.2
        for <git@vger.kernel.org>; Tue, 16 Apr 2024 12:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713295880; x=1713900680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h+BS5HAJ/W1FsxjLy+ADjklRGi1unwtx9QHjMJ4AXWk=;
        b=YTi4G4uvBJ8XYcVw0paZ33ejzKmGqDDs9gZq6CDMxS1RwhVvo3V/TENjN5J/eZ9sfw
         5FjBOsQaPrZ8rBPHn+X+xkY/+l3xpOYOu32rivLvCWWJayqXdDrGc79rl/ZHFtYyvRag
         quNND7Sondh3cDsPmwa0TFwhQ4wcmkaOa4X3vzIsC7KFWcMxMMEUB4vAsl403w4mUOF/
         Jx4kFuv9i0Qe9Wg5ZYo/wgPPjSsZPLTnW4WitoE206IY7LQhLluSXqlyHSGuvkwvXuOw
         GZedU3hEp/5qs7tOYED6fXz/LVm7x3Pv9MYujSdsxqSKvU65QrncVLdmiqBSxe1f3ORm
         Ks/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713295880; x=1713900680;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h+BS5HAJ/W1FsxjLy+ADjklRGi1unwtx9QHjMJ4AXWk=;
        b=C5e9UtznAzD6L1cr+6POTMTF8rPJvjC99KO6EWGsZCOPGpcvwarDe21+8Zghnn4oMR
         K5jSZNJLJMkpYEofFatuCw/pVEFbLCYkHXj9ITS+X5lk2V2k2P6HrIyKnh0BcDAR9fee
         GKJ+m1ByV1PkoirQx+LjLgWcWKcYmU7Lo1EDqUAgS6sNB6Mj2ej/4oRtqloJt6u4T2Ax
         f9dfC8q5soURtQobFbN35NBFQOtkAaa1XrGkYYUSQjE39NrfU8COPlHma849g50fJmp7
         Ny21aZNmDz0XxuO8Y3qMp3sZz6vo5/3HjMbTd2sMfuFLKnp7qb/tVNg6mJJZdrleqixX
         JCJw==
X-Gm-Message-State: AOJu0Yxk6D+bppVIkG6KOAqV+qYMhoTk7fhOe8BxHkieDhPYWXMSuJ99
	J+3iLAhYNDRSKIfyLnNTN5Rpr6lyJSbRd9bE1dopCoAQ8pr9g81X
X-Google-Smtp-Source: AGHT+IGOwGdyNEcMEdHwNHzmfgNi27RT3ZVOPH6zC6w3ZdEmqKtujt0Z1yOu/sCTv4tmfDOK931iyA==
X-Received: by 2002:a05:600c:35d5:b0:415:6121:5171 with SMTP id r21-20020a05600c35d500b0041561215171mr8723087wmq.32.1713295879955;
        Tue, 16 Apr 2024 12:31:19 -0700 (PDT)
Received: from gmail.com (91.red-88-14-45.dynamicip.rima-tde.net. [88.14.45.91])
        by smtp.gmail.com with ESMTPSA id w5-20020a5d4045000000b00346ceb9e060sm14839538wrp.103.2024.04.16.12.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 12:31:19 -0700 (PDT)
Message-ID: <18640bf4-aefb-4057-a680-3e47f10d88e2@gmail.com>
Date: Tue, 16 Apr 2024 21:31:18 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] add-patch: response to invalid option
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Patrick Steinhardt <ps@pks.im>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <xmqq5xwhhacm.fsf@gitster.g>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq5xwhhacm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Apr 16, 2024 at 03:26:33AM -0700, Junio C Hamano wrote:

> > When the user introduces an invalid option, we respond with the whole
> > help text.
> 
> The verb "introduces" in the first sentence looked weird to me.

OK.  I'll reword it.

> > Instead of displaying the long help description, display a short error
> > message indicating the incorrectly introduced option with a note on how
> > to get the help text.

> Is it worth changing it at this point?  Does it improve the end-user
> experience in any noticeable way?  I do not think I can answer these
> two questions with confident "yes".

Indeed, this has been with us for a long time.  We're not fixing or
changing any normal usage here.

I know you know, but let me put it this way;  We are introducing two
changes here:

   - a new error message to inform the user that an invalid option has
     been entered.  And,

   - not displaying the help if not requested.

Both are improvements to the user experience, but especially the former,
I think.

This:

	$ echo W | git add -p 
	diff --git a/add-interactive.c b/add-interactive.c
	[...]
	(1/1) Stage this hunk [y,n,q,a,d,e,?]? y - stage this hunk
	n - do not stage this hunk
	q - quit; do not stage this hunk or any of the remaining ones
	a - stage this hunk and all later hunks in the file
	[...]

Becomes:

	$ echo W | ./git add -p
	diff --git a/add-interactive.c b/add-interactive.c
	[...]
	(1/1) Stage this hunk [y,n,q,a,d,e,p,?]? Unknown option 'W' (use '?' for help)

Thanks.
