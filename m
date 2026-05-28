Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994812E6CB8
	for <git@vger.kernel.org>; Thu, 28 May 2026 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937479; cv=none; b=nRjD1FmwUiizP6DwD0A945cX7EOqhSqnEQV/vAEq0txh5qANiGECbPVaRL+dvOnebeYHepyiGDY+00wGEfq9/r4UcUXy8HtyEEhlI9a7xnfv8ij659sFqIoRniKo4/JmpvcIPvKZ1CKR+EofTbWQk257okxI0MOW6GsPSfn5IDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937479; c=relaxed/simple;
	bh=CjRjHp6h6dP3bI5v1xT4xXMEJPT6xuxrz+hrFPFJfmI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uTTNbZJhJtTAkc85Cfr+m+DuCdOaE6ea3ZJOZvZpaDrs07wnmZHr8RtozNV1mqNmuEJSw6+O1ARKc0sLXx0mIes24gogl8OzyTQo/ArWbKHQDJsx5eN8aypFltJA+3wv1DlKV9jL434dskYsaDMWN2ZYm8pxRloXpDOU+eKVbwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jy+rbUn5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oaBmvvHY; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jy+rbUn5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oaBmvvHY"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 987121D000BE;
	Wed, 27 May 2026 23:04:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 27 May 2026 23:04:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779937476; x=1780023876; bh=rdSsdtozw/
	fVKoVSEroq4sijt3cDsW9GfMXMVNJOaes=; b=jy+rbUn58BjjM3N6QjP+xj+CTq
	SF+zPhqR9kMQC9lPorcpEvK5Cn3wv6wJ5K49wVxtpo+GvRt2mYBpk0+OnIVe7LV9
	3wKbLtdyL6j6p1FX0wZB2Cmm2drR2v4Hj4fT6+AHlXhUITQB8Tit7KCCpUmLqt0V
	ncMVpRcaoaOicaHEL1bUPfvyPbWbDwVhjJK8RQE/EUM3jDTPfUO0b01YkbKm1M2f
	UIGNnPb6vOjiqWG/+SZMFvX6T3au2Jyy8TJoUJFImIosMZ9riUcceWwc+A+9lAxC
	fxNcokMXaqS1XVsfWVH7wiDzpe9O8PDoqlKAmc2mSHRZSyeACeXzwMLMkUgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779937476; x=1780023876; bh=rdSsdtozw/fVKoVSEroq4sijt3cDsW9GfMX
	MVNJOaes=; b=oaBmvvHYrAmI2zX2rEyDTVOuB6QDUxA3uRd+i1YkNBqS0IM2QfQ
	1oHM16/Qhg9gPrPxAKe5/5Wz4Y/btuFAC/1NnvGGTZMg0ZfGIxf34l+iOiOaFimF
	jkh9m18ZLRCZ80NVFn4wR8zC12F6ns6IDYXVTeSBLEvjbC1E2TcUbzKx9NVKUqH8
	ma2CLAu22eG76ovPIPmdfOLIf8t77mo9oUKWJkG5vsCxfT/Uo1TQdqnA7tI4HnM7
	mvGbMp2E+WsLjbdDGyrNVsO8kQjm+6otVXswR7KnJOvLtvwac6lJoaRjOnJZbX7b
	pWIekZjpEPzfrmpgUkQbGSOcO1XG+YnmRiQ==
X-ME-Sender: <xms:xLAXamLursATex6_as4v4ZVfIwMcXRIwgbruUzgoXORB8zwa8xXRRA>
    <xme:xLAXalJMLlbwEL-GP0F6Hm_aRQ7iGhvD6tNGfcCDCwgajc6H1N1qq2ooa_Au6EbcJ
    X1j8XK0uUjS-5rwxDNS_6EzBX15TWP_3RCgJE7O5WQf5LQ8dI46Dms>
X-ME-Received: <xmr:xLAXars4yi9GRBEsj2p43__OAWEfFVqLIcMPNCZEs4f8utRMHT8x-MtO-z8tEoL_98uJ1YiWZtLwHq-ZdqV30Da6pm2rBwfpaUrR>
X-ME-Proxy-Cause: dmFkZTGJZEtVg4/lsM9xYA43aXjo6raK4eqK+b5HRX4OuBvGE9zInZlYiBswRPqXvQh2Ol
    JD/lanxQTo37oXalWlybAj/DAYNgkTWh6oLhNpwTfQ09HaYqpi4TJAjUYgtYwl3SZuPjuc
    4HE6QzxvqG0eSwrtamAfEUPyIhR/fKJcwCductsu7t4abRddTSRcObS2uJ8uwHF2SsGxhB
    u0wCOgVfnmOLJB7QBzZJzhka/zM8iBSj+DyPsonarjjnHe/WisRPHNcVPzUkZ5wSFB+23U
    EnmLPJf4ajYSfUc3YxV1aP/equAFI5tCRj6BNnRr85S98cJJPP1TfJhQhK5Os2WcYa9KVg
    l9A8jIbVIvEZfRb08QLlOJdnbcUu/pNVJpbVrrW3C0zgoFEalhKkks73/LY1Pw92watPEe
    fFhZi5gz/+CEI2HOU1TdOBQFQACtSfD1+awhaOSBKint3GOmzHOVXKz9pbx1qvFIRuZfdR
    AW93Bc58RhlPGTaqLI53tXHpz0i6yIpDuRVb6ZGwLgJepbAs1AY9X2iiJQJAbkWtnaPOdh
    qKjorY9YPyRJdkux5yASMjl4oBb+y7ZQOmE68Dk5ttZc4RBEn/Ptk9hNrZwHtfUWc2Oq6N
    KTqhzfhrAWbDu5ENIhqvmrg9YGtQ/OFM1zR7AIM3sEimn2gQCDbjvRrc2Gog
X-ME-Proxy: <xmx:xLAXaqQ3lle9Wg5u-FtJe5HE3WHentAeB1ZcPZ0LI72pqRRcb8BFjw>
    <xmx:xLAXapM-ZHEz8heiSXvhuFkQmY1bRK3CTJg_G4A8fuFoH5UUNY5DSA>
    <xmx:xLAXanYEAdDbxCkM18dIJBkZPu1lx5kCpHt2wZZ3WoLMk-O8YjinCA>
    <xmx:xLAXarz9I3P6mZ8A5smSokMP0vSVtDWJfaonAWVD_B5z_tNYBLiVhg>
    <xmx:xLAXam7a1QhDdrGF1zSdPJXOlAo6q6IkhdtTu5tTBnzVRwocZSI0wCl7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 23:04:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] pkt-line: initialize packet_buffer to avoid macOS
 linker warning
In-Reply-To: <pull.2313.git.git.1779901919956.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Wed, 27 May 2026 17:11:59
	+0000")
References: <pull.2313.git.git.1779901919956.gitgitgadget@gmail.com>
Date: Thu, 28 May 2026 12:04:34 +0900
Message-ID: <xmqqse7cjku5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     pkt-line: initialize packet_buffer to avoid macOS linker warning
>     
>     Removes this warning:
>     
>     $ make -s -j8
>     GIT_VERSION=2.54.0.380.gc69baaf57b
>     ld: warning: reducing alignment of section __DATA,__common from 0x8000 to 0x4000 because it exceeds segment maximum alignment

This sounds nuts.

Not complaining at you, but we are talking about char[]; what
alignment constraints are they talking about?

> diff --git a/pkt-line.c b/pkt-line.c
> index 3fc3e9ea70..cfd2799677 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -8,7 +8,7 @@
>  #include "trace.h"
>  #include "write-or-die.h"
>  
> -char packet_buffer[LARGE_PACKET_MAX];
> +char packet_buffer[LARGE_PACKET_MAX] = {0};

I do not like this; it sounds more like a workaround for broken
linker (and compiler to certain degree).

This, compiled with a stupid compiler that is too faithful to the
source text, may make the resulting object file on disk larger by
64kB, since the original said "I need 64kB area in BSS with its
starting address recorded as 'packet_buffer'" (which costs almost
nothing) and the updated says "Here is a 64kB of literal data"
(which would record the literal data, even if its bytes happen to be
all NUL).  Luckily both versions of GCC and Clang I have notices
that the literal data is all NUL and still keeps the area in BSS
with no change in the object file size or output from "size
packet-line.o", so to me and others on similar systems as I use,
this probably is a benign no-op, but not everywhere.

Are there different versions of C compiler available on macOS for
you to try?  I am hoping that even though vendor compilers tend to
lag a bit behind from the public upstream, the problems may have
already been fixed in more fresher versions.

    ... goes and looks ...

According to Internet, Xcode 16.3 or newer introduced this insanity,
it seems.  How about adding -fno-common to your CFLAGS?  If it
solves the issue, then we can think about teaching config.mak.uname
to detect macOS with problematic versions of compilers and add the
flag as workaround.


>  static const char *packet_trace_prefix = "git";
>  static struct trace_key trace_packet = TRACE_KEY_INIT(PACKET);
>  static struct trace_key trace_pack = TRACE_KEY_INIT(PACKFILE);
>
> base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
