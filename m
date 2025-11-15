Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079F62AE99
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 03:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763176161; cv=none; b=St7WSvTcJ868iWxV0pjNDBmip6pibkbNgVETIWN7lU6vvgj48gnW6ZRtRPXzuEOUeNH+NKvIIc0G1PzzULIiSqQZZ5WOwAqpPQ9Zo5aG6+Eh6CswXFYBr4tKPTcYSmGhc+OJ8nTy/MdYGmANORVTAB0i1nx58llppfF2Lha6ZgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763176161; c=relaxed/simple;
	bh=uvwkvQV2qPVKln8G2SVTtrkXQx4TwO8VJ1Gy16EvHxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdfl4ZYuTzcqo72Am1sdPSH5Q6ktr7OcWF5hF40dcbyC6F1LWfz6dyReHNHHSgMF4bxpWUoB5TpnAmXRGDUimBER79wOyZzC89jQsFsB05WyqFqZK8Zn2+BPSYSUrsom5UDPSCOPmwW6I9IqmJi/Nm7W0oU8XtjdxLsDEaofodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=EJmZmGZw; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="EJmZmGZw"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id K6c2vLhgP9u4DK6c3vm7o6; Sat, 15 Nov 2025 03:06:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1763175968; bh=DKrt1H77h8ogv8wHR72gzGnK/zqsCCMh/WmBk2ds468=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EJmZmGZwxR5DrKI1B6lvCzTMFSUwNMZlqwmSgcqO3oICS5rWVr92GepRwSs84RLHg
	 6qnQrDjcQMB/GnllgngXG9/dk1u/KKA/48DzLvSYTCGuOFIbaEa5HYTt7sTzjCThl1
	 h1d49QG05ZQYcbituvxwAwM7xAvgi7kS8K+ih0OcUhsBY1FpXV4pMjRWa8QsaIvAvm
	 6fltwIDrm8Fx/1xzySGt9jly4TINN2H+QJwvdGWI7Eki9zBTedPPtMKbBm2WvDxF8F
	 Ez7SYQoJ4sffJW2TVSpnvgup5oLWqXHUO3mZIrY+II6OD6nqnEj1qfFU0dNn4sZijC
	 b0tgOzKUmMSeQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UKJ+Hzfy c=1 sm=1 tr=0 ts=6917ee20
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=C8lZhQBcK_BE1lu2MUEA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <23b7fd8a-2b50-4da3-bc8a-3727ee99654f@ramsayjones.plus.com>
Date: Sat, 15 Nov 2025 03:06:06 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] doc: define unambiguous type mappings across C
 and Rust
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>,
 Chris Torek <chris.torek@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
 <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
 <af732beb6904d8b9b7801ecc2487dabdea05a571.1763159816.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <af732beb6904d8b9b7801ecc2487dabdea05a571.1763159816.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMveyl/cQZ0f0qVDry5r/WA8aIxFWdNC/ATchi21rPqkkqNfvzov2iqoL9XdK7OWsqSnYvdk1Yd+QxuIBiipTyJUW/buH9Hf/w8DlQaO+H0jpJoXdqQt
 VejUr8hHom+jMqlFu/3JSoIq0SztA+KhJm5mipljpukSDnJgJRgN1ZjZac15HjH9xyKEUPVpeAKunSnGLLyO/ERsxF+w8fKUwp8=



On 14/11/2025 10:36 pm, Ezekiel Newren via GitGitGadget wrote:
> From: Ezekiel Newren <ezekielnewren@gmail.com>
> 
> Document other nuances when crossing the FFI boundary. Other language
> mappings may be added in the future.
> 
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
>  Documentation/Makefile                        |   1 +
>  Documentation/technical/meson.build           |   1 +
>  .../technical/unambiguous-types.adoc          | 224 ++++++++++++++++++
>  3 files changed, 226 insertions(+)
>  create mode 100644 Documentation/technical/unambiguous-types.adoc
> 
[snip]

> +== Character types
> +
> +This is where C and Rust don't have a clean one-to-one mapping.
> +
> +A C `char` and a Rust `u8` share the same bit width, so any C struct containing
> +a `char` will have the same size as the corresponding Rust struct using `u8`.
> +In that sense, such structs are safe to pass over the FFI boundary, because
> +their fields will be laid out identically. However, beyond bit width, C `char`
> +has additional semantics and platform-dependent behavior that can cause
> +problems, as discussed below.
> +
> +C comparison problem: While the sign of `char` is implementation defined, it's
> +also signless (neither signed nor unsigned). When building with

Hmm, this sets my teeth on edge. The C char type is not 'signless' (whatever that is
supposed to mean), it's 'sign-ness' is implementation-defined behaviour. This means
that it is 'unspecified behavior where each implementation documents how the choice
is made'. In particular, it has to document:

  "Which of signed char or unsigned char has the same range, representation, and
   behavior as "plain" char (6.2.5, 6.3.1.1)."

(it is still a distinct type, however). Note that some compilers even allow you to
specify which you want for a given compilation! (see gcc options -f[un]signed-char
and their inverse 'no' options!)


ATB,
Ramsay Jones


