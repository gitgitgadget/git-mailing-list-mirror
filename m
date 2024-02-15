Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78A23CE
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707975205; cv=none; b=d6rN/zAYjHJikZd7UvtnygCG6tL0xfd9spnVWc8u9navSp3BmSshRdlrD+3AJraXQ0FzhRwtN1ata7KlQzT1b2NF3D7t+8yphrE2R0pnkXTChHtRf69K2Y473cW6ldAZyzwX2/sypdhinluh5j31UJi3GlhzUZfq007OnqvVU5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707975205; c=relaxed/simple;
	bh=llyVShHXtCp3JjI1wejJF/ha1t3G13dHyCfCcU1A9R0=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=EvAXzKI2f3Q6VMS5unnRYRFGff29NGUjb4EsqUEedqciXC6sDnhBQGcN9s4V11g7tyEdyV3c4YjbIchlanJ2BDoOhdS1F9CMjwuao+96UV8pn54uPn/QBtOmLmwxM433Xjhj4y+nbx+8rsd6fGox6nbAzcn2KeBZfOD3uy7Npbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkTUqLLv; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkTUqLLv"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c47f06863bso17248239f.3
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 21:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707975202; x=1708580002; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dqVK/4dq6noNvARnXzm38LdiXMeVU0lMf/GD5O/R5cs=;
        b=YkTUqLLvrKxspea6ZEz+iec1OK+6Equ3FKwf0pcL3/ZZwfN+VIsKvyfcHN98zpyqI9
         ECzgZSyN56vF3Lw9SU/fI1pm4ec3vz4J4IWNWqwAKGUKjTECSWKydtPeDVKOkk4o2w8Q
         4+dbL/LTwDsuVPXUKz6CsbxBaeIE6yjO2yPYOhLvwEWpO0YV5Ey0/IIzRHVxrE0PIiv0
         e7cf2zm28CEa6R5imd4gE9WDm8gpnA2E7oicww0ugzBUkXAuXkT0Kt6OsLHmzdQMU0Mg
         vpDiWa8CC2AuZZnWpQKUd3ZRcSQ19jGsEntB+ZomDbCjb4Q+3NOMnzNpMlqhMv3hHVsl
         q9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707975202; x=1708580002;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqVK/4dq6noNvARnXzm38LdiXMeVU0lMf/GD5O/R5cs=;
        b=kxtVAwpEf8SXVoz8cZDP2NhfsoBJIcRsQfUGMqc5+j4Ljmt41Dj6+1b8f1MZ3Df114
         AYDcDZUxoegvT9s0JKgwfaafDlAfBIt/Cz6stb5Zev4IjqsbL5RDh8gNHKueUCwUJKAr
         bVktnA2e8FgK9cADsMglebrc/LZ8AEQpDO1hEIh25L8gIDsgYosenv1EKtKa3u1sjjba
         oJDeVpeN2iet1ktsrV6bC65DXchiDwG2WsfyHf4k32VrmP8/t+H3nEsME13rGJ3iKqa9
         lG9AU2IBhbm7STLL4wNTbcFwooB1LO++NQoisWabyLCPL0fQ7DMizLIbwHeJGV+Oo2mP
         H3zA==
X-Forwarded-Encrypted: i=1; AJvYcCVhx5dZhtqeHiAge1Vh539aHybHJg1BSJC68io68PUO/su1WRrTgrxpdcTHD8qvvACkVmHdPMMWK9BP5Xm/h57q4RAZ
X-Gm-Message-State: AOJu0Yy1ljHg/esQtRSVVyLfp2nugbwuUL1ytounkQTCgw28jShzHSl8
	eYB+0r7086icbtw+Sc5maT/CpJrrR///Zx25aV4fTvMNNpz1RE1I
X-Google-Smtp-Source: AGHT+IG8Af4oFSuNpYX5zZwMw0lhvYSjowe5o95tSiI9uoFbgjluLNPduFgKrvQQnEmzrsN9kaKOtw==
X-Received: by 2002:a5e:8a49:0:b0:7c4:309d:786f with SMTP id o9-20020a5e8a49000000b007c4309d786fmr906511iom.21.1707975202596;
        Wed, 14 Feb 2024 21:33:22 -0800 (PST)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id j2-20020a05663822c200b00472cdb0590bsm180656jat.64.2024.02.14.21.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 21:33:21 -0800 (PST)
From: "Eric W. Biederman" <ebiederm@gmail.com>
To: Linus Arver <linusa@google.com>
Cc: Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Eric Sunshine
 <sunshine@sunshineco.com>,  "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2 05/30] loose: add a mapping between SHA-1 and SHA-256
 for loose objects
References: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
	<20231002024034.2611-5-ebiederm@gmail.com>
	<owlybk8ja4w2.fsf@fine.c.googlers.com>
Date: Wed, 14 Feb 2024 23:33:19 -0600
In-Reply-To: <owlybk8ja4w2.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Tue, 13 Feb 2024 23:20:29 -0800")
Message-ID: <8734tupa00.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Linus Arver <linusa@google.com> writes:

> I'll pause my review of this series here to give Eric B some time to
> respond. Thanks.

I will respond shortly.  The re-awakening of the review process came
just as I am in the middle of something else that is taking a lot of
cycles.

Eric

