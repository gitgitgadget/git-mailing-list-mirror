Received: from mail2.viabit.com (mail2.viabit.com [65.246.80.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D55280CD5
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 16:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.246.80.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557144; cv=none; b=PKSV9AQVK6q81RXr6ZHeFcKPhBZC4qpYceYnDrHlPLlcMkibVY71XxKqhJrev+UMR7c49ACm+COReJGShUDJhshi/ZP0qxJYmfjICY0wfdhDYbsI0s4PZ/QU6ibRMZM4OSW6lYjYVnYCGqnSHjWag1/mYLihLyJVCC/SfcI0Viw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557144; c=relaxed/simple;
	bh=1Ge2KLZTKCFSfcf2eypbhUdDNKj1Sx0SGUx6c742ktY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xm78h9MvZaYGVPSfXC9v2I9DGQ9Is5OTM7ofO9FirZ7/1RbJRYilGt2HLyifagnH3GOVnrr35dSME6ua7eLGrzVygdW+4OcL+CjcIWtj3QR0ULjU5M+ZiqHVlxrNtZFGDSK84AjhntJ8B3l/jVkKXtfpO6YmsVKxCx7mOU7lzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orlitzky.com; spf=pass smtp.mailfrom=orlitzky.com; dkim=pass (1024-bit key) header.d=orlitzky.com header.i=@orlitzky.com header.b=PgoJm7zv; arc=none smtp.client-ip=65.246.80.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orlitzky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orlitzky.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=orlitzky.com header.i=@orlitzky.com header.b="PgoJm7zv"
Received: from mertle.michael.orlitzky.com (vpn1.metro-data.com [65.213.236.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.viabit.com (Postfix) with ESMTPSA id 4cVnqz50lrz43KL;
	Mon, 22 Sep 2025 11:59:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=orlitzky.com; s=mail2;
	t=1758556801; bh=1Ge2KLZTKCFSfcf2eypbhUdDNKj1Sx0SGUx6c742ktY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PgoJm7zvg9A65h8NOGkhKxOag+GJbe3joQaI+XYa7lwr2OQGUFpMM8waqUP9hpJWZ
	 Fs7FdsXFHPbgbRpifo+LfD/qsLXctGFNVohg9XRTGiIgHczvG2ObVNktz/MbeFP6oF
	 0G7tr8PiyL8KqcSh7N4zlS0rqtPEe27J/I/XYahU=
From: Michael Orlitzky <michael@orlitzky.com>
To: ezekielnewren@gmail.com
Cc: 20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im,
	Johannes.Schindelin@gmx.de,
	ben.knoble@gmail.com,
	cb@256bit.org,
	collin.funk1@gmail.com,
	contact@hacktivis.me,
	eschwartz@gentoo.org,
	git@vger.kernel.org,
	gitster@pobox.com,
	me@ttaylorr.com,
	newren@gmail.com,
	phillip.wood123@gmail.com,
	pierre-emmanuel.patry@embecosm.com,
	ps@pks.im,
	sam@gentoo.org,
	sandals@crustytoothpaste.net
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become mandatorty
Date: Mon, 22 Sep 2025 11:59:49 -0400
Message-ID: <20250922155949.27019-1-michael@orlitzky.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>
References: <CAH=ZcbCUL-rWw5E6p26T0039gs9q-P8iK5fp73-RzTzKiZ0zMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> We know for sure that NonStop currently does not support Rust at
> all, and that there are problems with porting Rust to Gentoo, but
> I'd like to hear what OSes and Architectures you use personally and
> professionally and why adding Rust would be a bad idea. Is it
> corporate policy? Is it that the Rust toolchain doesn't exist for
> your os/arch? Is it that Rust is a new language and isn't as battle
> tested as C? Something else?

There is no problem with supporting rust on Gentoo. Gentoo users build
from source, and rust is a problem for anyone who builds from
source. I'm writing this on a riscv/musl system. If there are no
binaries for your CPU/libc, let me tell you, it's not fun. And this is
like, my job. A normal person would be completely helpless.

Nevertheless, the arch support issues are secondary. I'm sure it's a
lot of fun for the people who are writing rust code to do cargo
updates in the two or three directories they work in all day. But I'm
not writing rust code, don't care what language git is written in, and
have hundreds of other packages to keep up-to-date on multiple
machines. I want to be able to use my package manager to do that
efficiently. You know, the main tangible benefit of using a linux
distribution.

But every distribution is "packaging" rust the same way. They're
bundling random old versions of crates in violation of their own
policies because the ecosystem is unstable and the tooling encourages
tight coupling. By requiring rust, you are require me to go back to
managing dependencies like I'm on Windows XP again. Git is the most
important program I use, but it's not more important than package
management itself.
