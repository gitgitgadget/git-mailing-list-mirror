Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6841023A4
	for <git@vger.kernel.org>; Fri, 29 Dec 2023 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D7M++a5r"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-28bbe965867so3378058a91.1
        for <git@vger.kernel.org>; Thu, 28 Dec 2023 22:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703832127; x=1704436927; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Br3lhmYfS5mWj4dNLpj69zYuOXUF5x/gFZDYxxHnuZo=;
        b=D7M++a5rs77Wg2TzTySdCLPlFAYdVGBkUz69CuTwRz8ZlLtRbhgioZBU75xFlw6sPs
         PYxOKJbGh4IvV6Co3L5HpM3Go2S18LY4M2BsqBI9N6iMBRowHBlhAboavxqDfIiUMoN/
         vxdM+p1Xby0D5WtzGiOC9W1kjW/4QZJNCciehHDjynRRM/jdr6APQ39ySriT66XW6I4P
         A/EjOzXPJES0l7jg+dyUdt/pMPhVBJVfn42kNvpre8NL7s217KmXOhOt4EkW8d+ubWLf
         qFH39//MzWkUm7eQ1b1nsx15GJCQ6NqjPn7ZHxdCwfKjHshoCVGRxld3UmpZWcacuLk8
         FNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703832127; x=1704436927;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Br3lhmYfS5mWj4dNLpj69zYuOXUF5x/gFZDYxxHnuZo=;
        b=ZmoZovqNMSoobpfhohVGEPlEwpjnzWTbAg/LEe4jfdrIxMEZrumLR4wf5KgRIAOChY
         q2CTQ4xECogOVtrayLjEQMFsOWuIt36RZxEfRX3chgSWWSQHREDkWBNkUsE2hJrURJV7
         cRZ9YOsBpF3jJljdxjJ7joQ6o/0mO6/qwoxhHsP3v9GRGgXfcQL3faCBjZszMAJR4+bF
         VOOxrB817Mn93n3GR9pRZdKVmZ0Qnje4eYPrMqYV25VR428LfVti0nsU+96hl/+QGUiU
         7PosDMwoqeNPmN48/qRdBORG400zNlssVqTACy+5vjCr1YQs3tGv93qeM+FcIBHv+CtW
         0yBA==
X-Gm-Message-State: AOJu0YyyihKKhrsiTzxjswY/Xsr0EjLPmbexAIjl5jxnNf4ONLZCiwPg
	AUcEvXK+ll2t80kB4KgfbcTIuFXH6lp/NpKbAA==
X-Google-Smtp-Source: AGHT+IEHpe9czXH+LzjFM3kOtO9MQZAKeOCkddXL9cguGCtpjdcfC3wxrGom/AiuXP4KHrp/HqOGFl2n1PI=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a17:902:e541:b0:1d0:68ad:d894 with SMTP id
 n1-20020a170902e54100b001d068add894mr470686plf.11.1703832127694; Thu, 28 Dec
 2023 22:42:07 -0800 (PST)
Date: Thu, 28 Dec 2023 22:42:05 -0800
In-Reply-To: <xmqqr0lpoue3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.1563.v4.git.1695709372.gitgitgadget@gmail.com>
 <pull.1563.v5.git.1697828495.gitgitgadget@gmail.com> <ce25420db29c9953095db652584dbed4e35d67ad.1697828495.git.gitgitgadget@gmail.com>
 <xmqqr0lpoue3.fsf@gitster.g>
Message-ID: <owlyv88hqzlu.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 2/3] trailer: find the end of the log message
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, 
	Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Glen Choo <glencbz@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>, Phillip Wood <phillip.wood123@gmail.com>, 
	Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"


TL;DR: I'm working on a new approach.

Junio C Hamano <gitster@pobox.com> writes:
> Other than that, I didn't find anything quesionable in any of the
> patches in this round.  Looking good.

So actually, I'm now taking a much more aggressive approach to libifying
the trailer subsystem. Instead of incrementally simplifying/improving
things as in this series, I think I need to get to the root problem,
which is that the trailer.h API isn't rich enough to make it pleasant
for clients to use, including our own builtin/interpret-trailers.c
client. That is, the problem we have today is that the trailer subsystem
is not very ergonomic for internal use, much less external use (outside
of Git itself).

As an example, the current API exposes process_trailers() which does a
whole bunch of things that only builtin/interpret-trailers.c cares
about. Multiple other clients of trailer.h exist in our codebase (e.g.,
sequencer.c, pretty.c, ref-filter.c) but none of them use
process_trailers().

One really useful data structure is the trailer_iterator that was
introduced in f0939a0eb1 (trailer: add interface for iterating over
commit trailers, 2020-09-27). The only problem is that it is not generic
enough such that interpret-trailers.c can use it.

My new goal is to introduce a new API in trailer.h so that
interpret-trailers.c and everyone else can start using these new data
structures and associated functions (while preserving the
trailer_iterator interface). So the order of operations should be:

(1) enrich the trailer API (make trailer.h have simpler data structures
    and practical functions that clients can readily use), and
(2) make builtin/interpret-trailers.c, and other clients in the Git
    codebase use this new API.

This way when the unit test framework selection process is finalized we
can

(3) write unit tests for the functions in the (enriched) trailer API,

which is one of the major goals for my efforts around this area.

The work I've started locally for (1) does not depend on this series,
and I think it'll be cleaner (less churn) that way. So, feel free to
drop this series in favor of the forthcoming work described in this
message.

Thanks.
