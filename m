Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A511BC46
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710618293; cv=none; b=cmR+wa+LkFiRJ35dpsxwR5gjtiHUJD8ph0/YUG5trXOr1MGbwbOzL7a7u/XpeHlaGLyMiJ/K48Q87frciRYFOtAU8IGt4iwj6FqKqMUhwXitRoxlunDioZwBVZHq+dKqvBgjf7s8VljDg1IuvF4zIg/GjMCrGlMetg//oR4Hr4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710618293; c=relaxed/simple;
	bh=pODQ1KXknIe0N0NJuUmXF8bjCLRnM96geWp+TrGNX6k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G67vvqrPpKzQNKrW4V9iZx/ygZKzN1GL3TvY4+P1hBVePXStjobR7dKSDL4mmIm9ugledIwB8VIrifgHzzNZ2ZDYCm20B5M2pEFaeAxYj7+tyPmJJL24vH7lO4wMzLXPM3ziO2jRJ4RLa+T7xhGXRDtPA7MrCqOHdg9VxDhRMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZqkC1kx; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZqkC1kx"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-430acd766beso10596081cf.1
        for <git@vger.kernel.org>; Sat, 16 Mar 2024 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710618291; x=1711223091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mESs+vmHw76A+nUygdp1DkStS72CPG44tdegunmIJ0=;
        b=ZZqkC1kxYSAKRA5RX3tL8Th7oYhSsqweeKNTHONA5cPPUu5KzOM+DA20Yk0x+JLpZm
         uvV6YKdp76Je7F3XurM3dzQIUpYVEq6gNu66bOSnORztHu517LiWgVMMY/RJzoXUwkK4
         onJw+rREM6lTusAvsihXAknhHXORHPe177QM68gY5/VQhFleLdmm9gOUjjxzXV2fus+p
         s3M9SYbB4WouVvkib2cSB06gERwsIW8GkwKa59ADsa9NS9gU637l9S1GuXNK7ou4p7xi
         RtcPlU4g9cxa1r4npf7sT8yVn7c8+XTxnl35vsvHHQXFn4Jk1bm/GwI1GEko3EVME/eE
         8DVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710618291; x=1711223091;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mESs+vmHw76A+nUygdp1DkStS72CPG44tdegunmIJ0=;
        b=YJ+gu1zgU5rlJqOK1yhME4D+DEC1WQCdVpbXEq01u/Qh3t48/t4jwKwaczoEDU1hOm
         5b1IoTZqNvS8320HvurnfjqV+P7583lWe79npMS7XLdr1SP0rOXyg7y2L8yCZ6H2CG/5
         4pAVkhC1xZKc+BqMwSlVt0Y6Sd/0rBcCfCocAaCbO5xtxAP/XoxbP5yM44TcSupiDvcJ
         1KlmwcpsqEO2hHzpm7oPSsGt11CfhtsxZZQUwDINu8+VdPhktYHi9DbWYINhn+AgVssp
         Hmbl2cCf1i/SABo9QZ6EH4AdqcIcfNNtBycgsHh93tb8+d06k447thmuf7twKqxVy7al
         kz6w==
X-Forwarded-Encrypted: i=1; AJvYcCXhLifovseXRFOT5OGe4dJSRYSIn1S0CdUJ+Vt6Fam3/DYu6SF6zRhQaEkPz+QyN3V+veqkFAUlnyCkE4bNi2C/j2Rz
X-Gm-Message-State: AOJu0YxBO6b7svTkW4D8QeWLTp1vAGO6GNF3otjSwnGzNHegzodqBc0O
	Qg1F0aS/79oUmfZ5UuWwYgJeG/ixVHuJpEZRjrBxkvW7oZt26+/a+qIhLFvzkww=
X-Google-Smtp-Source: AGHT+IFghrQv0uMDaRuwcNormysP92Xx6sHAzI86PLNs5jyP4bLeJXIpNv3Ndr+LtiZtY8w/h4GooQ==
X-Received: by 2002:a05:622a:191e:b0:42e:d581:f735 with SMTP id w30-20020a05622a191e00b0042ed581f735mr8764983qtc.17.1710618290941;
        Sat, 16 Mar 2024 12:44:50 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:103b:f04a:b551:cd51:32ac? ([2606:6d00:15:103b:f04a:b551:cd51:32ac])
        by smtp.gmail.com with ESMTPSA id h14-20020ac8568e000000b0042f192bced9sm3107949qta.64.2024.03.16.12.44.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 12:44:50 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] builtin/am: allow disabling conflict advice
To: Junio C Hamano <gitster@pobox.com>, phillip.wood123@gmail.com
Cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 ZheNing Hu <adlternative@gmail.com>
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
 <3235542cc6f77779cca1aeff65236e16b0a15d76.1710100261.git.gitgitgadget@gmail.com>
 <f06dcfad-e4b8-4cb7-8728-f5fb018f7be0@gmail.com> <xmqq5xxsu1z5.fsf@gitster.g>
 <xmqq1q8gsloz.fsf@gitster.g>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <1961b9dc-e372-b0f9-9185-a1c11d32f1b3@gmail.com>
Date: Sat, 16 Mar 2024 15:44:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <xmqq1q8gsloz.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit

Hi Phillip and Junio,

Le 2024-03-11 à 13:49, Junio C Hamano a écrit :
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>> I think you need to append "\n" to the message strings here (and
>>> below) to match the behavior of printf_ln().
>>
>> Good eyes.  You'll get the final "\n" but the line breaks inside the
>> paragraph you give to advise*() functions are your responsibility.
>> Even though advice.c:vadvise() handles multi-line message better
>> (unlike usage.c:vreportf() that is used for error() and die()) by
>> giving a line header for each line of the message, we do not wrap
>> lines at runtime.
> 
> Perhaps something like this.

Thanks Phillip for noticing, and Junio for the fix. I should have looked
at the output, apologies. I made sure that the test passed but since 
t/t4150-am.sh only checks for the "To record the empty patch as an empty commit"
string, it still passed despite the missing newlines.

Just a note if it helps anyone: I cherry-picked Junio's fixes using:

   b4 shazam -P _ '<xmqq1q8gsloz.fsf@gitster.g>'


Cheers,

Philippe.
