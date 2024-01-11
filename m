Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71E58112
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="OPm1RGaE"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbed5d1ffb0so5398047276.1
        for <git@vger.kernel.org>; Thu, 11 Jan 2024 15:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1705015404; x=1705620204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ3HdfYdeO8VPrVpl/wvG+yqArkAyKtgaY4JbIbhPE4=;
        b=OPm1RGaEL6Ny3n7f38vfzBBdTZkouVo4e3+Hu0L4yPHo04LU+7G7shzXdU9DYjpbI7
         SUGUegwSFcBybR5chnMQ9eMSKg0bTCZVVkBy9Qpu3+0n06djq3EC1zHLLZDyXNTGVUXk
         IDf62aDUwiC87IlxQSgXNTrqREMgfhJvL9WB0pHMfAB586L4j1Ir6js9V4k07zLLo6gr
         oQq8N35B6eGzJYT5ey2OQCvUnFSJs3Iht6Ubhp76J7iuZ1lG3HLN5T5/SXQ+miL+muwQ
         mYIr69AzoiV2jX7gqmbXQQ+Bm6LGIinp+ddUAjhLsh2PoDLPn1rWBFSqRgYO5/TZdBZy
         fNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705015404; x=1705620204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ3HdfYdeO8VPrVpl/wvG+yqArkAyKtgaY4JbIbhPE4=;
        b=oJjffv1PLD+ar4l0mT8xIs8rjsvih8uH8JYfEICbs211XJjdQt0xWfARIaVcczdTEZ
         IU5BJEIbMApvgHbUX7liUDPOwDjos2SVdaeYDc1186CY64quKQkVQPvv2EH45e6WWLq6
         rnhkwLShrc7qqahFdxLAEkEdv4/8nsFZVHiBMoqpsEm+Rd6CMDfGQWJ5kg33vP9o9MqB
         YjMdWwsoVufoUjcEpHt1HydO10kZRSGq4CCIlwTDmvjwbz84+Q9iMlQgUCoeDTP7wJpV
         dAtYK5TW7e1xAlz6FHYjsjHhKYTXCPBirkzt/9LHrQa1jA07LdRYkDBPRg1pUN+dgoV2
         WrRQ==
X-Gm-Message-State: AOJu0YzcDptgyx8kIFlCRAeBPRBZy0Ttd+Fw9jJDaEMOS3RZY0xmA/Qi
	JjMpIO25QLcvMZawziWfhPAge/mIsspQJB1pCoXzgIdo2d74/OU8qDUltUeH5CYwAQ==
X-Google-Smtp-Source: AGHT+IFAn1rnB1D75fGIrgbjObOehmI/598CkdIRdogWNB4m9hsPJhPzwuJ5K2qtwKbtruEsFJTxPBvLGyd5nOPlyOE=
X-Received: by 2002:a25:d246:0:b0:db7:dad0:60e9 with SMTP id
 j67-20020a25d246000000b00db7dad060e9mr5155ybg.118.1705015404424; Thu, 11 Jan
 2024 15:23:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZZ77NQkSuiRxRDwt@nand.local> <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
 <xmqqjzog96uh.fsf@gitster.g> <006b01da4412$96c6c500$c4544f00$@nexbridge.com>
 <ZZ8ZlX6bf+hjmhN+@nand.local> <007c01da4420$10a7b700$31f72500$@nexbridge.com>
 <ZZ9YrYvW_L9A02aI@tapette.crustytoothpaste.net> <00a801da443d$b1539670$13fac350$@nexbridge.com>
 <CALNs47vfBH9u9B5B3tWRoEkJJiqne5067A4CFnZ3OaMVvz_gSg@mail.gmail.com> <01c101da44d5$175f1100$461d3300$@nexbridge.com>
In-Reply-To: <01c101da44d5$175f1100$461d3300$@nexbridge.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 11 Jan 2024 18:23:11 -0500
Message-ID: <CALNs47vSMV4XcFqNPBorAGftU0h87nhP7HJbJx2oWfvKxqtO3g@mail.gmail.com>
Subject: Re: [DISCUSS] Introducing Rust into the Git project
To: rsbecker@nexbridge.com
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 4:28=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
>
> The usable compilers and interpreters on NonStop are c89, c99 (what we us=
e for git), c11, perl, and python3 (for the x86 only). The perl and python =
do not have sufficient modules to do what would be needed by git. The compi=
lers are invoked using a CLI and are not callable using a library. gcc is, =
for all intents and purposes, not possible - so anything requiring gcc (for=
 example, Rust), cannot be built.  There is no back-end pluggable component=
 for any of the compilers.
>

Ah, no pluggable backend is unfortunate. Rust only uses GCC to build
the LLVM backend, it isn't actually needed for the language. It does
link libgcc_s for unwinding and I believe some math symbols, but
unwinding can be disabled and other symbols can come from anywhere.

If you can build mrustc (C++ program) [1] then you can use it to
transpile Rust to C. This is how rustc is bootstrapped, and would be
how you bring it up with a different backend on a new platform.

Still, this probably wouldn't be a solution for git.

[1]: https://github.com/thepowersgang/mrustc
