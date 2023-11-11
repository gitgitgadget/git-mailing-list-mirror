Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463D615484
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ne7Ld9Vs"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E2BC4
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 06:26:55 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40859dee28cso23524805e9.0
        for <git@vger.kernel.org>; Sat, 11 Nov 2023 06:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699712814; x=1700317614; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0glItwY4dPdA3MF1b7tgtwULaeSW1SRdUfectNMtibM=;
        b=ne7Ld9Vspk8ZJdHSWPpsKVxavCYbhAyrgXa9pZvw0Vf9ucg3KJ60hsF6F5QAvPgCpU
         pANn6SvOU2VCPoDlbCfII0ZTsLwbIfCsimEXGSXnHuwG3pk6qKgxMcf/iB0WFpmYBFAh
         v573HyRBSE8gLCYNrJvbJeC6+i5bjsaixSZl8wCKGRaQdUim+raU7dmyXkfEUIrP0VOt
         /M6pOTpGzw2xKTGFDA8PxM0e0Gs+KxTemcri3aoI6qmXTEzv/yCLFe8A1zoC7cr6XP4m
         sIZ3NJ0S2yQ1k4O9kcKVpbuNjXW2KsjfVRhwmdqjQGzzOjxifRRB58Eb2d7TgN7tbQ1I
         V0Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699712814; x=1700317614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0glItwY4dPdA3MF1b7tgtwULaeSW1SRdUfectNMtibM=;
        b=vdUA0sp+c45rTWg+vQvSkCxrClRKK24VJ3e6Le5u+5xPIy0mx6VF8VYzg9jNRlVgdL
         OmVgzJq0VQPWDttNJMveTNhFKeanStrjrzs5+lEp5DPP47TBkvsnjmRHI5LWnaBXvJ2b
         maqBNTl937xR/8KYQW9aO6vaHhwjFB33ZayOV4cWh+H2H/6gHvCG6t+sQ7pSxDgHSJZN
         2odILFzElM3usC8sykxGatiPQ0/LQDYFP3Hk/avY8BpCBtV3jDAEE8Zm6WcjYJniwE2V
         ITOb+IwCjXoA10D5KQbHQcU+ZFZI8p0PZ8m49Lwaw8OU+Wz4yOlp8AxmhB6LH2dZDUdR
         Yq1A==
X-Gm-Message-State: AOJu0Yyn0o5LJwElSDKGx1zMPCqpKVkxbBH343fzSbXtAqhexh+LVkBA
	F8UxuPepRYG1aCcOvPsbuRs=
X-Google-Smtp-Source: AGHT+IHP/2YNhB+KCVK9fDjzkDmQGWDgCOj9ZkC3skTX/AFHyT4sd7nuFhPhGD0sI2sqIf80pqN1dw==
X-Received: by 2002:a5d:59a6:0:b0:32d:b2e0:ed76 with SMTP id p6-20020a5d59a6000000b0032db2e0ed76mr1779253wrr.49.1699712814032;
        Sat, 11 Nov 2023 06:26:54 -0800 (PST)
Received: from [192.168.0.17] (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id c10-20020a5d63ca000000b0032d81837433sm1571371wrw.30.2023.11.11.06.26.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Nov 2023 06:26:53 -0800 (PST)
Message-ID: <307994aa-6a3d-41b8-86cb-c891abc13e52@gmail.com>
Date: Sat, 11 Nov 2023 14:26:52 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] rebase: support non-interactive autosquash
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, newren@gmail.com
References: <20231103212958.18472-1-andy.koppe@gmail.com>
 <20231104220330.14577-1-andy.koppe@gmail.com> <xmqqcywng0wu.fsf@gitster.g>
From: Andy Koppe <andy.koppe@gmail.com>
In-Reply-To: <xmqqcywng0wu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2023 00:50, Junio C Hamano wrote:
> Andy Koppe <andy.koppe@gmail.com> writes:
> Our log
> message convention is to first describe what happens in the system
> in the present tense to illustrate why it is suboptimal, to prepare
> readers' minds to anticipate the solution, which is described next.
> 
> When asking reviews on a new iteration [PATCH v(N+1)], please
> summarize the differences relative to [PATCH vN].  For explaining
> such incremental changes for individual patches, here between the
> three-dash line and the diffstat is the place to do so.  When you
> have a cover letter [PATCH 0/X], it can be done in that messaage.
> Either way is OK.  Doing both is also helpful as long as the
> explanation done in two places do not contradict with each other.

> If you tried to format the documentation before sending this patch,
> you'd have seen the second paragraph formatted as if it were a code
> snippet.  Dedent the second paragraph (and later ones if you had
> more than one extra paragraphs), and turn the blank line between the
> paragraphs into a line with "+" (and nothing else) on it.  See the
> description of `--autosquash` option in Documentation/git-rebase.txt
> for an example.

Sad thing is that I knew most of that from reading the contribution 
guidelines and previous experience, but obviously I don't always 
remember. So thanks for you patience in re-explaining that.

> OK, by clearing opts->config_autosquash in this function, you keep
> the rebase.autosquash to be "the last one wins" as a whole.  If a
> configuration file with lower precedence (e.g., /etc/gitconfig) says
> "[rebase] autosquash" to set it to "interactive,no-interactive", a
> separate setting in your ~/.gitconfig "[rebase] autosquash = false"
> would override both bits.
> 
> A more involved design may let the users override these bits
> independently by allowing something like "!no-i" (take whatever the
> lower precedence configuration file says for the interactive case,
> but disable autosquash when running a non-interactive rebase) as the
> value, but I think the approach taken by this patch to allow replacing
> as a whole is OK.  It is simpler to explain.
> 
> Giving short-hands for often used command line options is one thing,
> but I do not think a short-hand is warranted here, especially when
> the other one needs to be a less-than-half legible "no-i" that does
> not allow "no-int" and friends, for configuration variable values.
> I'd strongly suggest dropping them.

Dropped in v4, along with the attempt to expand rebase.autoSquash, 
following Phillip's review.

Regards,
Andy
