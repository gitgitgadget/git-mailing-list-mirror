Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBA37D13
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GINlrw9I"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ba2e03e21cso3223460b6e.0
        for <git@vger.kernel.org>; Tue, 19 Dec 2023 09:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703005657; x=1703610457; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gHUqrJZeNif+kRhIusaIPMbUONmBVOVmQaWEq7f2fvw=;
        b=GINlrw9IfUeY89q7oq/QaC7I9hpz2WctUDMSEdFZVqoBsj6atGTX7pY+JCBwvBzC45
         91+lHmZUWvCnmR8eeJ07WrJvvlfL8jZDUmf3ow/8TPKLK+dRmMEjQMQ7ZJdgJgbwivUi
         c2RbijtJPRIQo+mfG/1gtZhpopNHmLrzSbOpsUBDe+3Jr4JJpzTRlv1YxEPiYeNaqx35
         osMd3uiHLmwMVC5HAE4T4uwsb66OUsW3KInk2ixyy4HH8nIO8p9w3aA4ykHAe7kkioK7
         p2crhn0y0e1/EORAuHBpsJqzXg4xMmsvbdcpiYtXUeizTyuH/JdYgqBQoI5xb2WH7jP7
         cXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703005657; x=1703610457;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHUqrJZeNif+kRhIusaIPMbUONmBVOVmQaWEq7f2fvw=;
        b=lCA4txtv5t+hSj7VzaaKIJBm25y3g6tYN4Sg82xaXfSkneUhrBLUpoH2c7KaBr5Xyk
         ZPgW0kx/WLkUiWtkiH9nUQEfdfw5fVequABYjRO4lyy8Ucx4hscPPT8aqolBFQ0WDsVy
         dn2EnpXrelu1n9W6keQKsH0ovO9c7vqlPkCH+Y60La4H3e9iwx0vUkqZ1XgXC4+ns2kb
         kht1CkLZY3w8oGhDJO1fNyDS0dNtzgTWeR9FOS1o7eyoUPO47w/ervviGZXru6s96huP
         ff6SFVIsPaGeX/GVC04/eFHNpy+lH+io3cEMr5iUXLk02KbGddOu9ImsZ6wmY+HCsoB+
         AB9Q==
X-Gm-Message-State: AOJu0Yys3YHExx6ELk5NYt6Cd+dlbn/Fatpc0L5+XxoxaRP+PLfculst
	Coj0kJYcaPHrymT7e/Bjw6Ahqm0YvkqZ04ccbySE8TjtS+M=
X-Google-Smtp-Source: AGHT+IEFUPQW0WVtsEQZjajo3bEwhfOsggzloFxBTMuMrF7t67zClIi0vi9BIueiN2boQVrPhE25zKcPcTLaEzvswss=
X-Received: by 2002:a05:6808:398c:b0:3b8:b063:6672 with SMTP id
 gq12-20020a056808398c00b003b8b0636672mr17711940oib.105.1703005657516; Tue, 19
 Dec 2023 09:07:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1620.git.1702908568890.gitgitgadget@gmail.com>
 <xmqqle9rfkvd.fsf@gitster.g> <xmqqbkanfkjy.fsf@gitster.g>
In-Reply-To: <xmqqbkanfkjy.fsf@gitster.g>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 19 Dec 2023 22:37:26 +0530
Message-ID: <CA+J6zkQVcSqpi8yRirEJn6Vbe9WkvhtWE5_YRZVzq7bNrFoFPA@mail.gmail.com>
Subject: Re: [PATCH] Teach git apply to respect core.fileMode settings
To: Junio C Hamano <gitster@pobox.com>
Cc: Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the review, Junio. I have considered your feedback and
will adjust the patch as such. The mail formatting issues seem to
have arisen from my invigilant use of GitGitGadget.

> Junio C Hamano <gitster@pobox.com> writes:
>
> IOW, I am wondering if the above should look more like
>
>        if (!state->cached && !previous) {
>                if (!trust_executable_bit) {
>                        if (*ce)
>                                st_mode = (*ce)->ce_mode;
>                        else
>                                st_mode = patch->old_mode;
>                } else {
>                       st_mode = ce_mode_from_stat(*ce, st->st_mode);
>                }
>      }

You're right, we should prioritise the file mode info from the
existing cache entry (if one exists) instead of blindly assigning
the one from the incoming patch. It's more robust that way.

> Perhaps we would want to check with "git ls-files -s script.sh" what
> its mode bits are (hopefully it would be executable).
>
> Similarly, check with "git ls-tree -r HEAD script.sh" what its mode>
> bits are?
>
> Check that the patch expects script.sh to have its executable bit
> here, too?

I assume we're doing all this filemode checking to ensure that the
executable bit doesn't get lost due to any other git command?

> The code change in this patch is primarily about making the code
> work better for folks without trustworthy filemode support.
> Emulating what happens by setting core.fileMode to false on a
> platform with capable filesystems may be a way to test the code, but
> we should have a test specific to folks without FILEMODE
> prerequisites and make sure it works well, no?
>
> IOW, shouldn't we drom FILEMODE prerequisite from this test?

I will keep that in mind.
