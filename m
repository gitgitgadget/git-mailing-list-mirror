Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B892773E5
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783834049; cv=pass; b=a2Z1jxBm544Ffn32lVwtAyeycSQuU4QxQp7TghrqVP9DeBE/N3KEIxACsRrssJ7qic/h9nJC1T5+NxcolVnL1xX5Db7LmgBiBsU+k6nLF0vpjZ5go2DKBdxRb+JQgIoaf+gJVnA7w/WdnWp9W7bRSDaEzyhMPXnghDm1g/C+uwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783834049; c=relaxed/simple;
	bh=VhDc51OwhAijsDXOcr2cZC1TBROS17OZCMj2C+ShJDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LldgYSnxUj06o4QD9a9HyEVUXc0+ZZOEvh63PIdPfcu4o0TFf17rXq0P/6w6/rMbm4rgJE+3UGl711mhXRM1/Vr8N1rAtkla7EsHbBX3weAKwJSuC5DEM2tHmNiW0ChP2PF6AskO89YdBfxotPLXcd50gOP/SFgHCE+dkf+bun4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj4Vn8/X; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj4Vn8/X"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6976b0c5adbso4418695a12.2
        for <git@vger.kernel.org>; Sat, 11 Jul 2026 22:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783834047; cv=none;
        d=google.com; s=arc-20260327;
        b=rHsjjh0Nul6AT3/hs/BupW2UV0VfXQNAmU3RLFLkBcRF/WyfPnhTUdwUF6zTiyxSuE
         Gagb6MhUGoL7vRWJvkt6DZPYVE8V/V6D0IFbu5uc0dTnaWWLKPiY2/GCNMRucRGjmxr7
         SA3EHb97KXEDwygTcr+PMcq/XnxWrY3JestalYi9HLtho4ndrnH7fG3Iv6VmVhrhOLKU
         e2S0lfn+IPPiRQMoF44IAgR28f1I6Fr52T7xlFBN1vXmLAFbkyC1N5MqumD4xtlMEsNO
         8qD6ccXtHJjbsbPi3jAaxJDIfuOOAMMKG8TNJ31XD4cpFi8I4TMRlmDidPfOwiiGxG8o
         EPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8BCdmcsuWqzefny5M8OIii/NdhGx+seDdLTHKR54rgw=;
        fh=ISsVGTm4QTHCbZR9EK3a4pCu4r1LnmV8QgBu6/dlz7Y=;
        b=jhes5saNvzkAtrpgFfnpYp7bi1IGpYwqJaHZTiMzQCpTypOsTpvjT/KhlWpJKuNKk1
         S3IhopPX1X2ddfw45RqvMz217b/vkpUoxuj8sQ7wFu2zeJCZ7pJvrI6lOwrmwny8trS7
         3fDD1+X4GWFpviLk2XZO3scPXWQGapW9lhsYlDjeI8RnAF2/daA2Bq7VJPqJyiuplNzr
         w05clwRdiiMRPpHTSCddmqcxtb6TJgjIIOB7Ee8r/lyF8sFKWIAwB0p1G527bQF5X3Gu
         3pFKf8EJWuRqgU4PmypJHggDFuP4p/PskKfBiYdYOWnwnFiY7MBfJhWyjR8DMPnMeBIK
         RdGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783834047; x=1784438847; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8BCdmcsuWqzefny5M8OIii/NdhGx+seDdLTHKR54rgw=;
        b=nj4Vn8/X3HVHEYCfpl67zj29wQmz30LicbK/a3/2l4Cm+797I4jIGHfKygqVYYQgUY
         j9bZ6p/g0nBwCpsLP0yyo7xknoyykpr4D+05Lkk0Q8bpodmuDzBGYkc0nVZuAydnyyEo
         QZPVDYNEzvIyREAYgV+nGZ+WCfZZWmAZG01Ow1/90t4TkK9T/SAHKof8s3PbeITMZRXZ
         z2e6XyqNVatnq08UYFbSJJ8aeocQvRVnOXkOLSfZPoFTQ0qj67CGHcT32d7UCjaP0yV2
         ViBicZZQWqbQTFK0O3yPI+Hb7QB1OrcXdF7iqqyeVBQdmC6+GwyAZpKhF6/LIZbAkMED
         RCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783834047; x=1784438847;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8BCdmcsuWqzefny5M8OIii/NdhGx+seDdLTHKR54rgw=;
        b=fJV/2egvt5t/AA7bQKfYt0ekWtjhVxfUCCHPT5q3Aq/R2p/c+sdd8PIROrizzaeK6R
         j2BfrZqh2+6ECKiKGl2etfJY7BQS6nXn97ff+gHKgLDcXQ83F1R2bRXSNuuRb5DfiKrj
         5QxkWbEIgxSq7d5lHj3xcIF8WmblLBaPDziCZ+IKIvCOLda45VOb4lx0l3HPeElyIm8Y
         ZkU3pxsjFBqxcXMgmHYfYk4MX3gZp7cpj2/kEe2Mn2ng6CT1+12bpw6M+P9Uk2ZUHsUj
         nnhyhjiTI5du7jUERLo+vyaC9zvpn1aYX8WudH58eTZZ+4IhGpIaAnXNuhZD0QJVc+19
         iqrg==
X-Gm-Message-State: AOJu0YwSiBupiYPqHHaxdpV/c5NSp9wMKZTj2Ed7dpe50LiuAYdFK3Os
	aMciHrpBs0fxnHd4zHpQMxitmSm7l1HJk4F0YzOSbbgAPPYFmOvwrWe/dOvQK9zFm2o8bJKBKIz
	aTPyA/gcAVyxLlwbAgnBWd8GzA1vw02w=
X-Gm-Gg: AfdE7cnu8iq/IPuM72Rv23hyaQyfu1hzun4Wle5KcBgScL7ELwwC4ScOBgjzoGSqN3+
	2sbO8vBpiOj9GuZmf0cApaDuQ5q/vP/Nxi0xxRsBr16OAFZ6jWRLeboOUNBZHVxxnHUTcRX7K5F
	53+l2fswgg/oNUSkWPW4JjoYlvEaxlgEKc17j40ab7KORIivoK89tcWUelfDsPNjtaOtDxKgr1i
	OiK/evygGE8vmSZy6un4JdZW37TLo26eHdYaHMG/GMmstIT1CH9dfLIYm5AJ4rRv6x1cVuHzy7k
	YzkoQ2pNAXPKQKUCUQSkmDm9aEPf+PmLKuye6I/Gw5/eXH6F76owsl4ptIQN19w1UvlTbc9Qqtf
	s+y652T7IjsSMCmi/azcN
X-Received: by 2002:a05:6402:a5ca:20b0:69c:7406:9492 with SMTP id
 4fb4d7f45d1cf-69c740695c8mr798377a12.39.1783834046284; Sat, 11 Jul 2026
 22:27:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-ps-eric-work-rebase-v15-0-c88a43b63917@gmail.com> <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
In-Reply-To: <20260710-ps-eric-work-rebase-v16-0-66e07b58a8fe@gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Sun, 12 Jul 2026 10:56:59 +0530
X-Gm-Features: AUfX_mxMhgIWJe1w-FRWMfQEeCNPnxb0fU-H8Aonp_f5ynld8AlseyuN7BvIGqg
Message-ID: <CA+J6zkSo3ZqLe7HLEXRAs+hOq2FuOVokMQWbABcW95wihNtCgA@mail.gmail.com>
Subject: Re: [PATCH GSoC v16 00/13] cat-file: add remote-object-info to batch-command
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, eric.peijian@gmail.com, 
	gitster@pobox.com, jltobler@gmail.com, karthik.188@gmail.com, peff@peff.net, 
	toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jul 2026 at 22:11, Pablo Sabater <pabloosabaterr@gmail.com> wrote:
>
> This patch series is a continuation of Eric Ju's
> (eric.peijian@gmail.com) and Calvin Wan's (calvinwan@google.com) patch
> series [1] and [2] respectively.
>
> Sometimes it is beneficial to retrieve information about an object
> without having to download it completely. The server logic for
> retrieving size has already been implemented and merged in a2ba162cda
> (object-info: support for retrieving object info, 2021-04-20) [3].
> This patch series implement the client option for it.
>
> Eric's series adds the remote-object-info command to cat-file
> --batch-command. This command allows the client to make an object-info
> command request to a server that supports protocol v2.
>
> If the server uses protocol v2 but does not support the object-info
> capability, cat-file --batch-command will die.
>
> If a user attempts to use remote-object-info with protocol v1, cat-file
> --batch-command will die.
>
> Currently, only the size (%(objectsize)) is supported end to end in this
> implementation. The type (%(objecttype)) is known by the client's
> allow-list and request path but is not supported on the server side
> nor the response parsing. A follow up series will add full end-to-end
> support for %(objecttype).
>
> The default format for remote-object-info is set to "%(objectname)
> %(objectsize)". Once %(objecttype) is supported, the default format will
> be unified accordingly.
>
> If the batch command format includes unsupported fields such as
> %(objecttype), %(objectsize:disk), or %(deltabase), the command will
> return empty strings for each unsupported field.
>
> This series completes Eric's work mainly with the refactor of the
> validation of the placeholder with an allow-list that filters what the
> client asks with what the server is capable of provide following Jeff
> King's idea [4].
>
> GitHub CI: https://github.com/pabloosabaterr/git/actions/runs/29091116939
>
> [1]: https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.com/
> [2]: https://lore.kernel.org/git/20220728230210.2952731-1-calvinwan@google.com/#t
> [3]: https://git.kernel.org/pub/scm/git/git.git/commit/?id=a2ba162cda2acc171c3e36acbbc854792b093cb7
> [4]: https://lore.kernel.org/git/20250313060250.GH94015@coredump.intra.peff.net/
>
> Changes since v15:
> - Completely dropped the static advertise_sid variable at fetch-pack.c
> - Split the hash_algo type change into its own commit.
> - Removed strtoumax_szt() from git-compat-util.h (and its commit) into a
>   static parse_object_size() helper.
> - Removed backquotes from commit message bodies and fixed typos.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
> Calvin Wan (3):
>       fetch-pack: move fetch initialization
>       serve: advertise object-info feature
>       transport: add client support for object-info
>
> Eric Ju (3):
>       cat-file: declare loop counter inside for()
>       t1006: split test utility functions into new 'lib-cat-file.sh'
>       cat-file: add remote-object-info to batch-command
>
> Pablo Sabater (7):
>       transport-helper: fix memory leak of helper on disconnect
>       fetch-pack: fix hash_algo variable type
>       fetch-pack: drop static advertise_sid variable
>       fetch-pack: move write_fetch_command_and_capabilities() to connect.c
>       connect: make write_fetch_command_and_capabilities() more generic
>       cat-file: validate remote atoms with an allow-list
>       cat-file: make remote-object-info allow-list dynamic
>
>  Documentation/git-cat-file.adoc        |  29 +-
>  Documentation/gitprotocol-v2.adoc      |  11 +-
>  Makefile                               |   1 +
>  builtin/cat-file.c                     | 221 ++++++++++-
>  connect.c                              |  34 ++
>  connect.h                              |   8 +
>  fetch-object-info.c                    | 129 ++++++
>  fetch-object-info.h                    |  22 ++
>  fetch-pack.c                           |  58 +--
>  fetch-pack.h                           |   1 +
>  meson.build                            |   1 +
>  object-file.c                          |  10 +
>  odb.h                                  |   3 +
>  serve.c                                |   5 +-
>  t/lib-cat-file.sh                      |  16 +
>  t/meson.build                          |   1 +
>  t/t1006-cat-file.sh                    |  13 +-
>  t/t1017-cat-file-remote-object-info.sh | 699 +++++++++++++++++++++++++++++++++
>  transport-helper.c                     |  15 +-
>  transport-internal.h                   |   8 +
>  transport.c                            |  46 +++
>  transport.h                            |  10 +
>  22 files changed, 1255 insertions(+), 86 deletions(-)
>
> base-commit: f60db8d575adb79761d363e026fb49bddf330c73

This version looks fine to me.

Thanks,
Chandra.
