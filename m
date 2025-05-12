Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A218634EC
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071674; cv=none; b=Bn4Mf5hsWww0NdAbr9ZWjIBB3ezfXtEwnNEOnmqHjt42SIAkK53YLMKs5hHyqB3IOlz4kVilKftpxAwmAILCRaWd/uSniMBM0TYL4PO94Y2V8osWq/PJ5vzu2BiKTf0oXILp9kXGjpngI/HnROW2pLL3D6LpqUF91EbBiVscKWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071674; c=relaxed/simple;
	bh=9eSqVViLpl47+8s6oObkf8qhtWBTXA6/Bu1zrOPkF1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GXPTJGrIif99x6RYMsFxgWbuqd/uW43eU3IfG6QK5/WksG8vGe63u0qD+iZRKq2j5jpTMHwwCaD6uRrkLVh+Uuqq4wWugjDJIOdXlgTgZ9gf9wUwZp5P/5a2Oy6w3rLA4Zp4+MGilIGIFxyORcyuYNg41a+/sr9JJOkxnHMKfmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTCWyZzJ; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTCWyZzJ"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3da6fb115a6so42935615ab.1
        for <git@vger.kernel.org>; Mon, 12 May 2025 10:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747071672; x=1747676472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCR/CAeJ4TvYle39ZXaqAkqdSodgIibkgFJMUxbzAMU=;
        b=KTCWyZzJWkNhfha+rriOkX9hHLAcpqwlfAvAiMoqrr7tlmgSiOj7uVr3vDQUq4PVek
         yHC5HQX3XS0L3ZOTCE08pmuLHQDbUqfDCfodmIuZUWdljdYyBINavNSn+0mpmXFDn/EE
         rw3Ley22d22wcV5Yry3o0hJwbeJr6jH4qoKcViGtgvXeQ4PAqdsUUc4YQEwqgQ/rTEwR
         UxNtP/Dpx86CbLHCgpHG/V4yuTeNn35ABgGPZmIgD0S+0VX2h6+n6SQAwkX+lGemV9Q0
         7UfSEVh7xjPRG2Vp/3hh8RnGkgy/FVuyPGZBQN8+dYEAmkX/Gn4XtJZCkScZ1iasneix
         Gg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747071672; x=1747676472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCR/CAeJ4TvYle39ZXaqAkqdSodgIibkgFJMUxbzAMU=;
        b=IVMQTINcVZyto5dwcBwWAwTYAhxYBp6dhyM4u9+y75wJWGYLXS9WR9nAqMjZmush1k
         cQbHIK2YIs+2Vs8ON/oLKUGmxHfVgPobuB59D2mMwNR38aDJw4peKzwmELGScBUJiMvC
         5n7OjOZufd4nJ1xOxGeOY1upMTuyQuRaIqRphycACk1LG5N6mKu5WaGXTY8WkmxHw8gj
         R9dG2WXY896F9qcTAWXsIILLHmgx2mX6d4F7NFP+jhYv7wtDVFnl+TzZCAnju1TT3tBq
         ljRcAjLCpf2VRhm4L81y8EZG0dOmW0rmeYzBD+baXybrDe3gj0meMO2XVv4DjGRdFHA4
         7zdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXErCDLw+cvrCAtA1aTRmLzQ67U8aZQU8+1Pxr8xZem3kt0MW6JvtR3aF1RqDGCDLgIC5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YymlEjRGglX7qwX5n0WavxiYaksV/Np7iYBP/73B0Rsg3cG8m87
	73BB1MzFv1Kz0Dzzk9J4FdEBH9HqfIoq+8hnJKXgYsPbcemhEtVOdattblq/PQaX0B9+FoVgB1E
	Ww3WbpMRqh2yZDQSYzdbJouxUUTo=
X-Gm-Gg: ASbGncuZg5596RfvAi97tazVNAuye1Z5irDso58Ein2IbMmmoJnzvIRVxG9iuY5Qtv4
	sBbvM0U+x6IM3fLFMCXNGdjNCjUAFh6oa2hmAx8viNTv5tCyeNbwr3QF7RDvbeLzLMnWoxebhQ6
	n/pdJZqQy2zXJBiRdTAWMlc8m39GHdtz32+virCsFmcj1Wh7M2yaKC1fB/WChu2dziwg==
X-Google-Smtp-Source: AGHT+IGZFjiohwTzoC4WYKQkpMFFNusCJGot6UGJrDLNcU+BRDtdUinJZ/wCh9eIXUnls4LVMR7PPY/nQRytOCTXjbs=
X-Received: by 2002:a05:6e02:1a8d:b0:3d8:1a87:89e5 with SMTP id
 e9e14a558f8ab-3da7e1e2730mr159448935ab.5.1747071672230; Mon, 12 May 2025
 10:41:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1920.git.1746914561.gitgitgadget@gmail.com> <xmqqplgdu5ex.fsf@gitster.g>
In-Reply-To: <xmqqplgdu5ex.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 May 2025 10:41:01 -0700
X-Gm-Features: AX0GCFubGCUxbuZ8Tp0RkIVy94EnrQiFVU9dIvTbPqBegxfH8AqtYyt_cSiQ4GI
Message-ID: <CABPp-BEJrkq4A715pV6WY-t-M205oheNABdGHy6HLmrxhNrk+g@mail.gmail.com>
Subject: Re: [PATCH 0/2] merge-tree: add new --mergeability-only option
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 10:04=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > This adds a new flag, --mergeability-only, to git merge-tree, which
> > suppresses all output and leaves only the exit status (reflecting succe=
ssful
> > merge or conflict). This is useful for Git Forges in cases where they a=
re
> > only interested in whether two branches can be merged, without needing =
the
> > actual merge result or conflict details.
>
> Sounds useful, but wouldn't that usually called --dry-run?

I thought about that, but I was worried that folks would expect
"--dry-run" to not make any changes.  This mode does not prevent
writing objects to the object store, it merely avoids it in the "outer
layer" of the merge.  More precisely, objects will still be written to
the object store for the merging of merge bases, and also be written
to the object store in the case of rename/rename conflicts if the
contents of the files involved in the conflicting renames were also
modified by both sides.
