Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuK3HDXt"
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A456010E3
	for <git@vger.kernel.org>; Thu, 30 Nov 2023 05:33:26 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a132acb67b5so133177466b.3
        for <git@vger.kernel.org>; Thu, 30 Nov 2023 05:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701351205; x=1701956005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wvbzf6V4nn6cXTL8KUn1LPml22xj/RXmy27Vs/HGf/Y=;
        b=TuK3HDXtc+yS6izIu59pAKFC5NRimLZFHTZ9xQxFPhbApbZIHNUUT2xjPB+sLf08A+
         oMp6XMNrp69fywjOS2TPE/KmSObghTSnQY1seD/7mnP0c2erqIETZh9e6nv00+jNK56u
         nmT8ZGNWwUdHVJqEAC7o9H1WOUJZHQWVhn47X2aArzPyeiFvOzhmjGLVZw7VlwXOdVGd
         qWEzTD/krEEKE6LnImRXMshZhnDyGMTDIGBypmFEYr4TOO71jdv+yiD+CFrP3pUgZRZp
         ITg1tBi6CAXdJWk3huGiBMjcU4qRNBBW6vBeIqkMZtdQUudulVQdiGoBBhi/o2WBSRH+
         q5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701351205; x=1701956005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvbzf6V4nn6cXTL8KUn1LPml22xj/RXmy27Vs/HGf/Y=;
        b=UC8y4mgJOuJBdOSIXfd70ZGJwHAWXnB3tqZax1FlCfGrgaGkNdN6ZzRwU6Ykk3OsIr
         vssW57hM3gheo9AIH2+vSmujZ1G/W8sqtO6f7tVS5u2KBmeXP5+uiF0ebTUzSc1SMy9x
         0JseabQgRg5B93bWMB/LyAZFn+1aTNUw2b8EqbjsO/BIun/hzvjWAuO6J/GdVj7WHz+w
         k0rs90byCfXWMmBTexvxbcFo3NIe2gnh5GmKXeIlvSFCDAe312Px5yZ+Kau/WZDiSEaF
         /5r6QeJ87wjU78XTyPKEBqCtF2g+HnP/9hh1DIRyUb86yvOOZC08LD3MEA5XgW8b3fvr
         glKw==
X-Gm-Message-State: AOJu0YxwyJJZVA/+bn0onY21XD8Z4rANQCF+1XT3URJ71NcAap5Dcg/1
	utlBmyr9Zcu7v8J89dnuuwWBoIXsIW30sXER8aaawq7VCBwr5g==
X-Google-Smtp-Source: AGHT+IGdbbtQyuqC1rE+m8h5YO/Yp0khWJoDKz/R+WADMzf7heUtUJ2D4gIKUAmMmMJ0WfPoJxpLUHQNQWYnp6RWUyg=
X-Received: by 2002:a17:906:68c8:b0:a10:b471:f707 with SMTP id
 y8-20020a17090668c800b00a10b471f707mr8728300ejr.68.1701351204898; Thu, 30 Nov
 2023 05:33:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH1-q0iV+E73RrUDA8jcoFgNEfQDNwRnX5P5Z7r3Qj3GESV_7g@mail.gmail.com>
 <ZQb9Thxa5X-Fo5mj@debian.me> <CAH1-q0jGQBPZVYja3Sg2Xv4YGAxcUsnb1rL4MALKxCoywi0B=A@mail.gmail.com>
 <PH0PR00MB1349BB447657A94A8EA90A78A183A@PH0PR00MB1349.namprd00.prod.outlook.com>
In-Reply-To: <PH0PR00MB1349BB447657A94A8EA90A78A183A@PH0PR00MB1349.namprd00.prod.outlook.com>
From: Javier Mora <cousteaulecommandant@gmail.com>
Date: Thu, 30 Nov 2023 13:33:13 +0000
Message-ID: <CAH1-q0jbN19gMF7_uwjYKVpH70q_5Qbt8TXvMZnB+fB_6bCvwg@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [BUG] `git push` sends unnecessary objects
To: Derrick Stolee <dstolee@microsoft.com>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Git Mailing List <git@vger.kernel.org>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

> I just want to push back on the word "regression" here as it is an expected result.

Yeah, I wouldn't quite call it a "regression" either; just an
inconvenient side effect of a new feature.

>> However, it is possible that extra objects are added to the pack-file if the included commits contain certain types of direct renames.
>
> [1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-packuseSparse
>
> It is unfortunate that this user hit this problem, but it is easy to work around it

I eventually found that note, but not until I figured out that that
option was the one causing the trouble.  So yes, it is easy to work
around this issue when you know about it.  Maybe this potential corner
case should be given more visibility in the documentation so that it
is easier to spot?  (Not just on the documentation for the option
itself, but maybe in the `git push` one.)

> and the benefits of the sparse algorithm should outweigh these kinds of infrequent issues (in my opinion).

Well, I don't use git THAT often and still got hit by this issue, so
it might not be that uncommon.  And when the files are large, the time
spent sending them through an internet connection will probably
outweigh the processing time saved by skipping some files in the local
processing.

I wonder if it would make sense to try to make the algorithm smarter
to avoid this corner case.  For example, ask the server if it already
has the objects before sending them, or modify the algorithm to look
into trees that have added OR deleted files (to detect that a file has
actually been moved, and thus the server must already have it), or
simply be extra careful when large files are involved.  But I don't
know the details of the algorithm so I'm not sure all those
suggestions are feasible or even make sense at all.
