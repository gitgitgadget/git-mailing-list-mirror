Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E022E542C
	for <git@vger.kernel.org>; Thu, 14 May 2026 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780521; cv=pass; b=qjPb0lRkXdjCdSnP7i8BW3TS+IzOS1CBMlg4gNzaaba5X3PDY4Mje+yyADw0mK5xSkjngIKgS4RNFTGjsei2ar41ZWOzcVqXCCy65yQ5s7c+8ergNqL8l4eqWrwMQA1iyvVJlI20RHHx4Yt72qUNceyjM8C2q75OHkR5Fwaq/Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780521; c=relaxed/simple;
	bh=1CopsHpQl4o6mmWGQ/xC+0/ysaN11Efe/J7RKBoPx1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lFygJO89uI6WJjk8Zln+AEOT1CLRvrkgxXzvvovNQitAHecrosOI0b938Q+3x/o5GthF/UomMCO3PzZIjgbt9OmC70iPFmZwcyLX6l2DcqcjoP5sh1QrPsqtnRQmK5hahK4VA1DhkzVKZUNKDcPt7scKXa5r+j+x38k+m6ARFe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXJGoY7s; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXJGoY7s"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c7492a2ceso8973633d50.3
        for <git@vger.kernel.org>; Thu, 14 May 2026 10:42:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778780519; cv=none;
        d=google.com; s=arc-20240605;
        b=Sp8VEV2H/32qe4jMSfuohmt8FeFlzr6P55bT25yp3wUgCD/EM0ag+qyagSqGaKyVWg
         rd7W/A84zjIDoTHN5Hl6kMEbcEWcTASt+n6nYNOrNIjbAY46a0ziGvMJSU25WZgTm6kG
         EHCVk1yVdr7wOLiT1mFld40ZLqpFOr/3ebVYZ1v8cIDY7UDNo8vmaNHd/8MGD2cJSmA5
         hQX23bbbGNoAMxizu76/02+3dJoUKlmO38aVN18tWr+twsgINMqUb6YubGjENdOATRmj
         Ay2hljkfSOXJZ+lAojshrtroleDnpiy3YNCQukGpDWqLYh1VulKL8maHxxNWnfYBV1L5
         2b9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1CopsHpQl4o6mmWGQ/xC+0/ysaN11Efe/J7RKBoPx1E=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=ENqUIU5UWYYWXTx9Nu1oG3/gq7NsCugfs6gfdts0lovhe86tki1A+VrvaVxWhL7yb8
         nNmAIKrrJXbVpl17cze/Xpkv8hSIrPKm5Wj2plAcFWCdUXx8eSvsYnZ5lV6RUbrbwke4
         MbxGjYgHbdi3inYJJDTzY725RCNrIRJPe+mmIN99cayNL1m3TKlrntg4/ZCVzIa+kr6d
         mUU6YoFKeh9pVO/YGOQ8A2h5GZ+6kD4XvtQapZhPY1B3+XHu/PCSrBBEILZ9/Ra+e9de
         rFwGVi2D8NHFy79Ms+Ssoq3iQzbqBEZakzmF3Oi5l0cXaXiISVtKdqNEZHhydh2TaFZL
         aTRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778780519; x=1779385319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1CopsHpQl4o6mmWGQ/xC+0/ysaN11Efe/J7RKBoPx1E=;
        b=NXJGoY7skafG4O4/BgGkGKPdxPLORzufHt4HafWT/ITFvNxNyJWWwJE0ZYF812w/UM
         EV7WaSnfUsSEFxiLs3kxx9RgNiQlz0Of0Va8ravWA9E4zbIjI3FZlyPrqC8cO2GXJh7z
         yq7c9OGcHT9lYYdSg5tgqTe8ZZV2WiVaMEwWNuajBSo8lJxiJjlKy/+i3Sps66HBQAtu
         pJRVUsPW75ovIK7A9Q9UIoEXMgCMNuw6DKbJYmnDRZkHeEzz+yfGz7dqyCwAoEy2JMbR
         iZbgFmrBL3kdSpHdIEeO64NEL5bDzq81eLbT7CQvW/gy/xPbmVTyIonjhyatGfXHucXM
         rTwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780519; x=1779385319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CopsHpQl4o6mmWGQ/xC+0/ysaN11Efe/J7RKBoPx1E=;
        b=Ygm/VIbg0XmugVVHChUUJXFD1yx2u9h3jMDAAynvhGfthpI4EBg1D/75lDMg+ZbvnP
         9+ksJvVosoPq9E/wlHB05GSYswcPWrpfaUhnyjOZ5vmDx0kMqnX68D3pNT84zraQFUhj
         siNYhjntFK/GO9lNDDh6JWlVn4CwkVqUTlpfUjpfhABLu2y7l4GMonm0Kp464c9uvjB5
         fqEewJt8TjOljKMGS0ZGd8F/MeXRVGySsLswUOfNNcgudD0fxgFITaUW2gfkt+IUa8wG
         kqkbSjI+o8pYuCaBPQkR6lthEFqO0YyMUq84kAAZ/Ok+vGoY0MQdXGSKEONJ2WKpD1aQ
         SeuQ==
X-Gm-Message-State: AOJu0YwgBnshHAmam1uj7DmJ5OdZYmJbSl37/KK61WhIbV/El/zF3lsX
	MRr1Z1AZCJmf9kFQMNIoXahR971wXHWCV6UyRwbFjS7jCYB83van+JoNvVwJslWnUQ1+4+04+Ex
	i13mKjz+t45rdFLOnieSER/R84wQXIvw=
X-Gm-Gg: Acq92OFW4T9O2o4Y5xeJuI4m4gYZisdwQZv4KARz3QHPcymo/rR4cUN2OWDWb6kazyV
	RvEr1L+cp5b0trZ70CrRKYQh11epmv8l3tYocRqam6tK+dBLNJknGY2BFavW3+SQPFDOzCDPoEH
	5gf8aKPHh4ykfu721u87Ta8MTvWJMjv5fvo2o6U9r3Rmhs2Zl/Z1fnATaw6hxKPbNFycnZJdpIV
	glpnXOxbRJRoywbtUq0uROhTY9ngbuT2u4kdY9DWeVWORyw/Hs2ok5BoinXmDOvY1KQZdPvaqFO
	N7S4rPc=
X-Received: by 2002:a05:690c:f03:b0:7a1:3088:e528 with SMTP id
 00721157ae682-7c959f87470mr3682967b3.18.1778780519193; Thu, 14 May 2026
 10:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqik8tm16n.fsf@gitster.g> <CALE2CrT9=5mOauUdzxJAEjeeD77RWGyXjLGGTObsk9R1eOrP0g@mail.gmail.com>
 <xmqqmry3i9a4.fsf@gitster.g>
In-Reply-To: <xmqqmry3i9a4.fsf@gitster.g>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Thu, 14 May 2026 23:11:46 +0530
X-Gm-Features: AVHnY4KKVGkPS67qdfHSjBOYoIZYJMl5UA1dgqtO1SQrvSUWET0mTqDW2ITu5IM
Message-ID: <CALE2CrTea19qHKbhQK8V+uQJgh5GdT+8ia1q2jwr+hf546fnaQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2026, #03)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Junio,

My thinking was mainly that git stash show normally omits untracked
changes, while --include-untracked consults the additional untracked
parent of the stash commit.

I did not see existing coverage specifically checking that behavior, so
I thought a small test for it could be useful. But I understand your
point that not every observable behavior necessarily needs explicit
coverage, and I'll keep that in mind for future patches.

Thanks,
Pushkar
