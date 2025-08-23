Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0919115530C
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755972356; cv=none; b=hx/ma2rouZoo0i4eutdOZzo2Qsy2G7sKO8WFlMPb48EMI2ZNC4WUU7IFcZ57g7TwOMY5sIZfbLs60fpFCHfdoQ4gWnHyuFUOhqQoyv6mT9rCoRe7BeUTKdnGkT0hUwjZr9Qcjmeb52efaV26zbb+qeMsmQqdvGSlsipPf9hnmf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755972356; c=relaxed/simple;
	bh=IDwuLINxNnQkKM8HY3+faI6KMswhH5IJZhLBc6iR5+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TKsK6IXuJ6kHUcA0nRoIJdLsLq0xHoI7VzYZGRbwkAlot6/UPZ0+F3QF+DoGrcKODrshzVGLh3slTj0T/aEEwA0GbBVZ5NI0rXklxcQf7k1b7zJ3QRg+/q6+i6T///K5KgoUq28Cqacz8/+1yG5E0GGlqve+Kom9GWNqvsYoQwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G7262BDZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jCzZaG5p; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G7262BDZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jCzZaG5p"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 43B451D00035;
	Sat, 23 Aug 2025 14:05:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 23 Aug 2025 14:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755972352; x=1756058752; bh=aUuHOjdPaP
	Og92ZM/dQUhh4pRHcxND7442zyzw32Uso=; b=G7262BDZtTwV8gRZ3jGBBSh25O
	kV7cdrY2xjn60ekmpwyaERBFBuk5Y7tz9ICPclguVgnnM8Nu9GjKC2WiHhQaylte
	qOXrlqEtWWLeLTkJ52fDcDXpbV1tEkJAGKS+fMypMEGglTFfeopNkiQ1DxBD8FdN
	ZS8qvIs7oxbFP169AuvhyvaMLi2HpWsWqEtrtsI//1JYtTwfTME19CA9lWhiJfTc
	FNne9BuRBHpouHOP7X4smBATrhcHPBy58JmpKhLx57KBCMghhBY8eUOsFNPehAXa
	iq3C5j9wKnCHAgtRFjgLTK8oHg66ysuQxbsUAQPvYJV6EQyCUvI/08CqfKsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755972352; x=1756058752; bh=aUuHOjdPaPOg92ZM/dQUhh4pRHcxND7442z
	yzw32Uso=; b=jCzZaG5pkxFMOQojw8URhzFfaHfaQOL8eLMzIK8zOoqyImh1M6b
	WRwaAfdF79Q7W8RA11wK40Hm4BWXfnsd0Am4hjZFlcH38EuuYUll55eErr9Tu89V
	Uhd9Gy1ZIFp/EiwwN7/vPhg4PRAWso5mWwVUdgeazVrWvNjWJikXAqZij5lE6o/C
	3ke5RYup+PJ2hqPlHPfkvpMGXIlwG1F2KLQErVIvpusJeP+GZqex2PHZ5bXibnKm
	DNx40cs3VpYKmslWwarXym0K+EFyz1xDJitP95fHPPCD4N/uHyoRUsJI0PdmX7H/
	B1KXA4Ysy+NR/77r+9KObW07roJikXg2+OA==
X-ME-Sender: <xms:_gKqaL25zkbWo61gxyZSyyHfjKiVzheFDKQ4-9cBebH0BF4Prau7PQ>
    <xme:_gKqaPPXfxuVPLKVIenYIIY9vxz4sWbWY8BmQwPjTj0lg_fzXWJCz27L996sAcadT
    JLoVsXbutBmJDu93w>
X-ME-Received: <xmr:_gKqaO0bSdwqfB6iwDSM1qksYiUcPzPV2TGiCQo2EnpKXoXc82rFvBhfFSfzkoVSq1Moyq7G7DQLGVcsQfJQP3sx0-Dd94zOfxLfjc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieejfeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffgffkfggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteeijefgieduheffhfetgeeggedtvdefieeiuddvudetkeetgeefteejjefg
    hfejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestg
    hruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhgvsehtthgrhihl
    ohhrrhdrtghomhdprhgtphhtthhopegtsgesvdehiegsihhtrdhorhhgpdhrtghpthhtoh
    epphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegv
    shgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegtohhnthgrtghtse
    hhrggtkhhtihhvihhsrdhmvg
X-ME-Proxy: <xmx:_gKqaG0aAPLBD1soQBkXrcm4QNlZAsC0c9yvoi8lRt6NDtpGJbtDBg>
    <xmx:_gKqaE99SOCd7zVPZxggbl5uewfCghchd1onoNB5BJBXMaCQfKMFnw>
    <xmx:_gKqaKY7Wq-zfVENMbXeteDpCHtgm2MppTd3ONmT25rPdCl7mxOf7Q>
    <xmx:_gKqaLxzff-GN1hnRHW3OjzZ4Gg0RjTiIOnECd_aUyCvjlYxu8DMow>
    <xmx:AAOqaD8j-Y02AFswpaO62bUoZukFCY87qvICOS2GpuB3PBBXD239zk5y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Aug 2025 14:05:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Taylor Blau <me@ttaylorr.com>,
  Christian Brabandt <cb@256bit.org>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eli Schwartz <eschwartz@gentoo.org>,
  "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Matthias =?utf-8?Q?A=C3=9Fhauer?=
 <mha1993@live.de>,
  Patrick Steinhardt <ps@pks.im>,  Sam James <sam@gentoo.org>,  Collin Funk
 <collin.funk1@gmail.com>,  Mike Hommey <mh@glandium.org>,  Pierre-Emmanuel
 Patry <pierre-emmanuel.patry@embecosm.com>,  Ben Knoble
 <ben.knoble@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is
 interoperable between C and Rust
In-Reply-To: <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
	(Ezekiel Newren via GitGitGadget's message of "Sat, 23 Aug 2025
	03:55:47 +0000")
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
	<pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com>
	<db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sat, 23 Aug 2025 11:05:48 -0700
Message-ID: <xmqq8qj9vrpf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> Trying to use Rust's Vec in C, or git's ALLOC_GROW() macros (via
> wrapper functions) in Rust is painful because:
>
>   * C doing vector things the Rust way would require wrapper functions,
>     and Rust doing vector things the C way would require wrapper
>     ...
>   * Currently, Rust defines its own 'Vec' type that is generic, but its
>     memory allocator and struct layout weren't designed for
>     interoperability with C (or any language for that matter), meaning
>     ...
>   * Similarly, git defines ALLOC_GROW() and related macros in
>     git-compat-util.h. While we could add functions allowing Rust to
>     ...

All the good reasons any C (or any non-Rust language for that
matter) projects would want to have an interoperability Shim
for their dynamically allocated and grown array-like things.

> To address these issue, introduce a new type, ivec -- short for
> interoperable vector. (We refer to it as 'ivec' generally, though on
> the Rust side the struct is called IVec to match Rust style.) 

I however was hoping by now Rust getting used more widely, somebody
has already created a generic "this is how you make C-array and Rust
vectors interoperate" wrapper that latecomer projects like us can
use without inventing our own.

> +INTEROP_OBJS += interop/ivec.o
> +.PHONY: interop-objs
> +interop-objs: $(INTEROP_OBJS)

What is this phony target used for?  No other targets seem to depend
on this one (I am wondering if we need the latter two lines).

> diff --git a/interop/ivec.c b/interop/ivec.c
> new file mode 100644
> index 000000000000..9bc2258c04ad
> --- /dev/null
> +++ b/interop/ivec.c

I am wondering if this needs a new hierarchy "interop"; shouldn't
the existing "compat" be a good fit enough?  I dunno.

Even though this is a shim to somebody else's code, it still is a
part of our codebase, so our CodingGuidelines for C programs should
apply.  

> @@ -0,0 +1,151 @@
> +#include "ivec.h"
> +
> +static void ivec_set_capacity(void* self, usize new_capacity) {
> +	struct rawivec *this = self;

 - Asterisk sticks to the variable, not type.

 - The opening and closing {braces} for the function body are
   written at the leftmost column on its own line.

 - There should be a blank line between the declarations and the
   first statement.

> +	if (new_capacity == 0)
> +		FREE_AND_NULL(this->ptr);
> +	else
> +		this->ptr = xrealloc(this->ptr, new_capacity * this->element_size);
> +	this->capacity = new_capacity;
> +}
> +
> +void ivec_init(void* self, usize element_size) {
> +	struct rawivec *this = self;
> +	this->ptr = NULL;
> +	this->length = 0;
> +	this->capacity = 0;
> +	this->element_size = element_size;
> +}

I notice that this reintroduces a variable named "this", which was
eradicated in 585c0e2e (diff: rename 'this' variables, 2018-02-14).

I do not think those who want to use C++ compilers on our C code
would not mind "self", so how about doing something like...


	void ivec_init(void *self_, usize element_size)
	{
		struct rawivec *self = self;

		self->ptr = NULL;
		self->len = 0;
		self->capacity = 0;
		self->element_size = element_size;
	}

... perhaps?

> diff --git a/interop/ivec.h b/interop/ivec.h
> new file mode 100644
> index 000000000000..98be4bbeb54a
> --- /dev/null
> +++ b/interop/ivec.h
> @@ -0,0 +1,52 @@
> +#ifndef IVEC_H
> +#define IVEC_H
> +
> +#include "../git-compat-util.h"

As we use -I. on the command line, there is no need to add "../"
here; just writing

	#include <git-compat-util.h>

should be enough.  Also, if this file does not depend on the
services compat-util header provides (and I do not think it does
from a brief look at its contents), it is better not to include it.

Instead, the sources (like ivec.c next door we just saw) should
begin themselves with #include of git-compat-util.h header before
including ivec.h.

> diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
> index e69de29bb2d1..8b137891791f 100644
> --- a/rust/xdiff/src/lib.rs
> +++ b/rust/xdiff/src/lib.rs
> @@ -0,0 +1 @@
> +

If this empty line in an otherwise empty file is absolutely
necessary to make Rust work, then please arrange .gitattributes to
tell git that this file is excempt from the usual blank-at-eof
whitespace rule we use.  If not, remove that unnecessary empty line.

Or perhaps remove the file altogether if nobody looks at it???

In any case, given that our top-level .gitattributes file starts
with

    * whitespace=!indent,trail,space
    *.[ch] whitespace=indent,trail,space diff=cpp
    *.sh whitespace=indent,trail,space text eol=lf
    ...
    *.bat text eol=crlf
    CODE_OF_CONDUCT.md -whitespace
    ...

I think a new rule to cover "*.rs" and perhaps *.toml files right
before rules for each specific file begin would be in order.

Thanks.

