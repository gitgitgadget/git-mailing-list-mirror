Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737933D34A6
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027950; cv=none; b=KJvlqaqV+8a2LrZvy+nedhQbbHv+5+xiFgpF/XfYdi5GtTJwOMcoXMC+PpO2AbvXoOnCsJ2L+Zys8q9uo9IscFn2NhqfY8ukoOU/NPwshZYIINT1KwqWc0MMH3hRsVN8Se4E8YJCUyRoThoF8V9KzQXgdtcnpUg//wKfvokcbWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027950; c=relaxed/simple;
	bh=NbLOr9nfoYSkjC0+ik+p5jywNhSEl0KnRC2abLD0yOc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CHeUZwvsXj2flg/Uc4GTBh0jMqVKEtJxc0JrX1/RZR9717g3Cfi/CYC3Ve+51uGQXyqz+Op17IZf8NzPlE6OWGdqGMZH6mopq4yf9s5yySp+8Rqu5bCD921s1TFucIqyo9QmhOgzuoK3z+7JfDWTkP6qQuldWPm/I9Tuhg/qhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av7H+jor; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av7H+jor"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aecf52fa69so2455265ad.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2026 10:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774027949; x=1774632749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJ6J+9fFTsx2hzazlgitELTG9cbsRyBAWFgKujYgl+w=;
        b=Av7H+jorDoewBDu4oQMvdBNFKoweFpkdxGEDOfnSR5mWXHZOyoDVKkGCZMEldj6mdD
         SoYSZRFhi7aZTQ4HOkHBtO8N1CRrEyYaVDiio2QMAuCMJ3L1wC0a+HM/X/F0gREiVCmE
         DyKB/sufOMQZfQB+DY8+J53H/ydDi+hdN/cRF1sWpuuQkdHrNOV5rFPRlSCGc19Sobpz
         XVxEj1jsob6TdbrOj9eNK8gH3VMrd0Hw9HTSHnkC2qwaZUhsp+dvdvQQ46yThQx/3EPx
         C/4/ooOiyNwta60xR16pFvvsgn+u8AWvuWOcitrIqCI7WlrQppla+dsMaONnp01QEWa8
         A7aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774027949; x=1774632749;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJ6J+9fFTsx2hzazlgitELTG9cbsRyBAWFgKujYgl+w=;
        b=s2+/qPZKfht8LnVUQcNGEYW4vpxvfYjguQarQMrBMaw/oxXNAH/xSWOGAUmsWp8k7u
         C0+kRlmi80SatYEEHY/RC1WqSbaU2oXYueejmtYR8W1jf0zx42tuR2XOAuuy08Eq6Prc
         PTjH1067nL43L5SZw6Z56UVYmyzlQy6rvVaj7sviyDV8SKoI+czQDr3qjp/5k41YDWKo
         kOg/UC08NyITYNSZRCjFzYzRhYGpQMNmmNGOS4b0mKTjKM3yACyMyW7YlFZ7azN4v+vY
         AwKmVtyrbOWtfFv0aUjXQsZQ51KIt9ciuCIJMTwjR9ZcYVLXPjvGNBe3gv/qDipRvL5c
         GRxA==
X-Forwarded-Encrypted: i=1; AJvYcCWEkV1KYNh4etbtz5eR/yUerd4XaiZa2NWftSsNzQqRUnWK8/b0d/1j+domWmlTRiI1JnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEuLZaY31KDh6rmYomyKO0k3v2SaOo+HAz4DIkiP28rwJUsVPU
	WPmy9L+aWUHs5gkjIBi6rOdvKaJ2khjSW5Jd9epMFRhLoaQ2z2v43uat
X-Gm-Gg: ATEYQzwfTA1rD5e60gJHsBQSw0nNhv67Tj9lg81np0AwfpMZ0KRYNCEJ+7ouPs+b/mS
	tgThZk3Qt6QmVl+x5UW7jUblQWWKofu+ZDcLLRZhsrRVFjnJPSsXKe4A1LbLcnsWCgYMCjrBYF9
	RZf1UYbx83O6Vwa1xqcbBPyrKRYnEVLgp3Z7WIkbiORsLu+EoWdJZcoZIw5O3OHoxMZRht7HC1y
	T35ugssQJ+5zpt8X+p4ZI7kJRY7PVM9h8FaY5nERblWXET90EVYFNIRYEi8c8Zwj4H341kqCX4Q
	WxTyTGoRCzruuqBmRR+BOnslC1pmIztiELHBguCRn1TGyvEQCDbiB25wSxmByvCrCSOPi7l68la
	BUhx97i7rwwF8JKr837/2zSwOoEUTRwZZCrnb2yYv34w3KRSyBCihtHKEJ7l9HzOcan7s+IPmIs
	W/V8A99wPyKRVAzggT09LGE3wAEAgpjR2eyfU+/8gFFjdxXDIWYQ6CGxyIdaV3BKIPWBfYAl9hT
	wgc8sz6MpI=
X-Received: by 2002:a17:903:22d0:b0:2b0:5075:96fb with SMTP id d9443c01a7336-2b0826b8a74mr22426675ad.2.1774027948696;
        Fri, 20 Mar 2026 10:32:28 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083655b5dsm37498675ad.52.2026.03.20.10.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 10:32:28 -0700 (PDT)
Message-ID: <9d0746d8-2194-4a13-812b-9b46d04c189a@gmail.com>
Date: Sat, 21 Mar 2026 01:32:25 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] path-walk: fix NULL pointer dereference in error message
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
To: Yuvraj Singh Chauhan <ysinghcin@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, stolee@gmail.com
References: <20260320114556.3151040-1-ysinghcin@gmail.com>
 <eca1a469-2e15-4466-ae58-978ffc23c177@gmail.com>
In-Reply-To: <eca1a469-2e15-4466-ae58-978ffc23c177@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Although this isn’t covered in this patch, I’d still like to add a few 
more comments. Please allow me to elaborate a bit further:

This is the implementation of object_as_type() in object.c:

> void *object_as_type(struct object *obj, enum object_type type, int quiet)
> {
> 	if (obj->type == type)
> 		return obj;
> 	else if (obj->type == OBJ_NONE) {
> 		if (type == OBJ_COMMIT)
> 			init_commit_node((struct commit *) obj);
> 		else
> 			obj->type = type;
> 		return obj;
> 	}
> 	else {
> 		if (!quiet)
> 			error(_("object %s is a %s, not a %s"),
> 			      oid_to_hex(&obj->oid),
> 			      type_name(obj->type), type_name(type));
> 		return NULL;
> 	}
> }

There are at least two possible scenarios: the object doesn't exist, or 
the type doesn't match, right?

Then the message 'failed to find object' is misleading when user 
encounters the second scenario. Wouldn’t it be confusing if a user saw 
this message, checked the object using 'git cat-file -t', and discovered 
that the object actually exists?

Regards,

Yuchen


