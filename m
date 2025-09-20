Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FCE223DD0
	for <git@vger.kernel.org>; Sat, 20 Sep 2025 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758393618; cv=none; b=ugATh38uIwO1vmMb873h5d68vNJg+T4n21IkkZCoT5jQWW1muFY1tE8TqY1/jKaJJPplzjRvAG3+Oa2ubMUgqjci/NA1nKtBHolMMtq3IMJQQIxWDZsXhM7kv30fjo8ZRt9wVToCSEw34yd5H0Fc/5ODleeMl5P7EbbOEz5NTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758393618; c=relaxed/simple;
	bh=grxzvNBv7Ag2g2lJVSc3AJDY52yJj5dtIkHTVaoZkzs=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=kOtWl3Dyj9GF94V99dyqEDeXFm5Ui/9gwFb5TNCSSSeWl5wDXKmZ1yi31iG1AkQgQ4q+yFEEXVa8kFW5yuX1LqKsHMJzGP3mDI4GZB7hn19oncw+BLFeKWebE5nAroIItnmzKWTPL2hb4VZgQfJaDsgl8fOM3FDBUdr85evyVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58KIdXuH1550901
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Sep 2025 18:39:34 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>,
        <ezekielnewren@gmail.com>
Cc: <20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im>,
        <Johannes.Schindelin@gmx.de>, <ben.knoble@gmail.com>, <cb@256bit.org>,
        <collin.funk1@gmail.com>, <contact@hacktivis.me>,
        <eschwartz@gentoo.org>, <git@vger.kernel.org>, <gitster@pobox.com>,
        <me@ttaylorr.com>, <newren@gmail.com>, <phillip.wood123@gmail.com>,
        <pierre-emmanuel.patry@embecosm.com>, <ps@pks.im>, <sam@gentoo.org>,
        <sandals@crustytoothpaste.net>
References: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org>
In-Reply-To: <8799E6DB-FC85-4F71-A6C1-363D1AC8ED06@macos-powerpc.org>
Subject: RE: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
Date: Sat, 20 Sep 2025 14:39:28 -0400
Organization: Nexbridge Inc.
Message-ID: <000001dc2a5d$ea10ffe0$be32ffa0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLgmUmHR/cGrsIL/oCQ2NDpPqhQsLKTiAvg
Content-Language: en-ca
X-Antivirus: Norton (VPS 250920-4, 9/20/2025), Outbound message
X-Antivirus-Status: Clean

On September 20, 2025 4:30 Am, Sergey Fedorov wrote:
>> but I'd like to hear what OSes and Architectures you use personally and
>professionally and why adding Rust would be a bad idea.
>
>I am the maintainer of ports for Darwin on PowerPC systems (few past years
in
>MacPorts and now in https://github.com/macos-powerpc/powerpc-ports fork)
>and contributor to GCC (gfortran). I have added the whole of current R
ecosystem
>into MacPorts and a decent support for modern Fortran via FPM.
>
>Those systems are still actively used, and thanks to GCC upstream support
of
>powerpc-apple-darwin I have been able to keep our ports pretty much on par
>(occasionally ahead of) what modern macOS has at the moment. A lot of work
has
>been done in past two-three years, including fixing/restoring support for
ppc for
>several major langs/compilers (gfortran, MLton, SBCL, Ruby, OCaml, Idris2
etc.),
>build systems etc.
>
>Git is essential for the version control, but also for the build systems of
MacPorts
>and CMake. Since my powerpc ports rely on MacPorts infrastructure (there
are
>40k+ ports), I need a working Git for my workflow.
>
>To be clear, I do not object to adding Rust optionally (as I would not
against adding
>optional modules for any language), but making it mandatory, while Rust is
still
>broken on a few, admittedly edge case, systems, hurts the open-source.
>
>I agree with John Paul Adrian that once gccrs becomes properly usable, or
otherwise
>gcc codegen in Rust acquires support for currently unsupported platforms,
things
>will change.
>
>P. S. I have contributed to mrustc, so it is not ideological. Though I do
think that
>ability to bootstrap from source is strictly required for a compiler to be
safe, and at
>the moment bootstrapping of Rust may not yet work for all supported
platforms (at
>least it is not well-tested).
>
>References:
>https://github.com/rust-lang/rfcs/issues/1312
>https://github.com/thepowersgang/mrustc/issues/300

To clarify, gcc is not available on all platforms. The overlap where gcc is
supported
and Rust is support is likely high, but more, where gcc is not supported
then it is
highly unlikely that Rust is supported. mrustc is a difficult more that
requires gcc
even if that is not clearly stated - it does not build with c17, for
example. This
double requirement is making the probability of being able to continue to
support
git even less for me on NonStop. My team is working hard to push Rust
availability
and we realize that gccrs is an easier path, but those two are currently
outside
of our control because of complexities in the loader on NonStop.

