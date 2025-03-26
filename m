Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8974086A
	for <git@vger.kernel.org>; Wed, 26 Mar 2025 01:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742954187; cv=none; b=RV9yMJt37vXoqybt6VO+Vl2E+uIQ4jJGpxl5SifNXWfjtS6I3PelAz02u3sXqy3VdfnrgVVK3KLs2WS5NSWJfLgyb+/BWrf0HX21VBBy1g+xNIoAJGxVJGegRAeSZ+HhKD7LaKNNU2HS7z/+nqIQGJSL3kz+GwUTIU5VWhXr1EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742954187; c=relaxed/simple;
	bh=HZHbs5LfaGBT1gpr+/tsVKplCE5cdvucBzZw7J0svO4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BoTp1rtjUWIGOOBhpDMKmVhGc3xqZISqP0T3+C2uO+0NEJ8o6QTOQX9gN2HjHX54JXpgRgugMYKphRDglvqVTgmXkQ/gRdGFr6zb1vk43L4M4OFi2DQC7yf3JttfhyaxLq6QV+mjQyzFnoJSGmZkScNDErvoT0J1GiYq+Cv1bAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETisLS2D; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETisLS2D"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-47688ae873fso64138341cf.0
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 18:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742954185; x=1743558985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13rtF0rIyEAEJSqPh+vv1Y3rRGGpIyEu9lRABci7Lbs=;
        b=ETisLS2DLQnXmja6UjlLYZlkEfTLEM7hcP5gLyfDeF+Jf03dlofb/SytEwoIV9AMcC
         air3mna0mkE2fzKyXCbGBumNxVuhCod5AM2uD7geVClWYlGovMzn0nM84qwvJ+KyTbnP
         MuV+wUjuleYaH64WsmWD9u9OCBYIZ5z/uHfz0VLpVn/Qty5zHCcrIiHIJRig/qKYWycE
         Lvq282GjU52cJVvLmSKJ21F0+4tI2nUiAFx8KNj4tRwbZ6q8crNfSEflfbnRAxeV2HFr
         f4H/scQkl9J2phjPkqqsrYAaO0vKYBUXudjkxx+KaPFDQrH66zmGbwcgqIj38Ix33nFE
         w2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742954185; x=1743558985;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=13rtF0rIyEAEJSqPh+vv1Y3rRGGpIyEu9lRABci7Lbs=;
        b=XdgiGZGQkKRMdCEnaMTNKdnDhCdWhcLaBzconKG4WqJ2n3QrBsXJDXHI/JnrcaNQsh
         M+plFZS8hnznT+IZehcfsOzLLUOZxrST3Ai2i8DsOnvmG90vwJuLAifTxBgR4XPaIulq
         yQsztDKmEDDTn8PDb8Wm2GFbCNr6EVMRbwU+GrHvOFRg2It3339MHqv9rWq/VE5bKLkE
         kCTgQvgQpM6SP3+5GhKKyJOXbPNgdzf/vkEtYHpvPAQvFtmOSDNxy9+y1mHFWeP6QTIo
         OVJRGD3iZOXFfU+XQnjsd/MEHcdL7mRDjBjvkedONHxJNJVDZlpsBRlTs5puLAKmzLMU
         TIiw==
X-Forwarded-Encrypted: i=1; AJvYcCV8HRDHcbAoSPFrQ58MB1K4Q5WRtmPwz9fjQComZdsdyMaIBAgSpBaD/fApT7a3lSnwH1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoLKkR+wYAh7aIqajWTbpVJ1nGlytumPV+91oHXuFcO31Rb8OV
	RgdIAfKaLoTgy1ELaoQTjby2J5YlzCHkGgLQ9gD1mMST0eKcglcTKOCvqdik
X-Gm-Gg: ASbGncurmK43o3hqrIE5grpHHdvT2pvQlCYx35weOFuVJ/G/7Q8/cNdyqGk8w5VpJ3S
	N3bDOGAyYv9zTKioZx/RiAuaMV+xqJ2/O7j0XmfHn3b0fHxEtw6WOSm2239W/XoTZXE0lUJ7HBc
	nOHsWC87/7+6bwyQ23dMOg1IcdlFLpEL0m1eGO7l5DU+a93Rw0FoBYFm+79RwBS7/IGHCPk9R5X
	Gj2YREXBulQNsf5c39rXuAyagGReF6DKSbE3DyjLRBdhqemApE4fj9QM1hLpluc/JeVJzB8wU0X
	iurY0jscTdh+KuqohtVg++sMmkEewT3tjzRVlUGc0SL52fiodFrOPJ9TjZq+Ji353yB+8qpXYkP
	6v/+2iDuB11qbMj2yDKGYdw==
X-Google-Smtp-Source: AGHT+IGIaRBjSoyqQ9luXqg2JdNxa1YXg37/iWTdH7ICv8z5s0T409Mt+OH16TfbtlHQAOmg+dVLUw==
X-Received: by 2002:a05:622a:5a94:b0:477:cbb:a23e with SMTP id d75a77b69052e-4771dd5480fmr356690861cf.1.1742954184553;
        Tue, 25 Mar 2025 18:56:24 -0700 (PDT)
Received: from [192.168.1.174] (c-73-143-206-114.hsd1.ma.comcast.net. [73.143.206.114])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d64d5f6sm66505231cf.81.2025.03.25.18.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 18:56:24 -0700 (PDT)
From: Nikolay Shustov <nikolay.shustov@gmail.com>
X-Google-Original-From: Nikolay Shustov <Nikolay.Shustov@gmail.com>
Message-ID: <77b5fa59-a8a1-4859-8f3d-41f94fa8120d@gmail.com>
Date: Tue, 25 Mar 2025 21:56:23 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Nikolay.Shustov@gmail.com
Subject: Re: [Question] Moving from Python2 to Python3
To: Todd Zullinger <tmz@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>, rsbecker@nexbridge.com,
 git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
References: <022b01db9d99$e68785c0$b3969140$@nexbridge.com>
 <Z-MgpuxFQ3xEgvsU@tapette.crustytoothpaste.net>
 <66e39a95-09a3-44dc-ac71-a6c02b5949c9@gmail.com> <xmqqtt7glmut.fsf@gitster.g>
 <6977f08e-3c49-4bcc-9ab7-e3cc61a78396@gmail.com>
 <Z-NSGtV06NPE_C9D@teonanacatl.net>
Content-Language: en-US
In-Reply-To: <Z-NSGtV06NPE_C9D@teonanacatl.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Doh! Of course I thought of PYTHONPATH not of PYTHON_PATH.
My apologies for the noise.

On 3/25/25 21:02, Todd Zullinger wrote:
> Nikolay Shustov wrote:
>> You are right, my answer was over-engineered.
>>
>> Instead of speculating about what else needs to be done if
>> one decides to set PYTHONPATH, I should have just advised
>> to use the OS specific method on setting up the "default"
>> Python as Python3 and be with it.
>>
>> Well, unless the dual Python is needed (git-p4 running
>> with the Python different from system "default").
> Perhaps you were conflating PYTHON_PATH, which brian
> suggested, with PYTHONPATH?
>
> PYTHON_PATH is used by the git build system to set the path
> to the python executable, e.g.: /usr/bin/python2,
> /usr/bin/python3, etc.
>
> PYTHONPATH is used by python itself to point to the
> location(s) of module files, similar to PATH, as you
> mentioned.
>
> The Fedora distribution packaging set PYTHON_PATH to python2
> or python3 while both were available and things worked well.
> Only python3 is supported now, and PYTHON_PATH is set
> accordingly.
>
> That ought to work just as well for NonStop.  If it doesn't,
> that would most likely be something to take up with the OS
> folks handling python3. :)
>
