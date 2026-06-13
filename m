Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C736A358
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781315809; cv=none; b=OJhOAYL7gky+ooPyrdJ5aA1FGWG3SjOfNVUEZMlc/dompF0aQy0htisvhxcYww4SiOee+Zho4OpzrrFWgGDqAzRfwF/wnqWAMQdK+imXhmaeQ7ytY1C4eh4HcUoddYpzrJXNZvBD79LA2Xd+yQ46yCv1MRJPgXxq090pY2cJlYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781315809; c=relaxed/simple;
	bh=vv0BVygwQcpNYmHXLZuXwnzsY+oU2P7fytY5F55ry/0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=TcOhq9vU7sSS1uTrWFqKrN3qXnACRPqUaGjmUlFTxoS3JQVqsxYal/usXEGvAs+0bFHOT330uiaPQuIlR5IFa0T7io52g4rn2/gOrlfEJpTyy6CawyyOqCWNFqH4BGuRiKgaQRj/7Sj2Smu7eutSmB+5Igmh/6xv3i3MCprgFVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 65D1uh3H2769973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 01:56:43 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <xmqqik7pqeiq.fsf@gitster.g>	<065e01dcfa75$ade00690$09a013b0$@nexbridge.com> <xmqqzf0zhjuq.fsf@gitster.g>
In-Reply-To: <xmqqzf0zhjuq.fsf@gitster.g>
Subject: RE: [ANNOUNCE] Git v2.55.0-rc0
Date: Fri, 12 Jun 2026 21:56:37 -0400
Organization: Nexbridge Inc.
Message-ID: <06b101dcfad7$e2600b10$a7202130$@nexbridge.com>
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
Content-Language: en-ca
Thread-Index: AQE2QUXve+Cc3EDmUgFIrOAj5bt+RAHkDBkvAs/a+0G3Y43F4A==
X-Antivirus: Norton (VPS 260612-4, 6/12/2026), Outbound message
X-Antivirus-Status: Clean

On June 12, 2026 11:14 AM, Junio C Hamano wrote:
> <rsbecker@nexbridge.com> writes:
> 
> > On June 11, 2026 11:32 AM, Junio wrote:
> >> An early preview release Git v2.55.0-rc0 is now available for testing
> >> at the usual places.  It is comprised of 397 non-merge commits since
> >> v2.54.0, contributed by
> >> 70 people, 22 of which are new faces [*].
> >
> > Cargo is not available everywhere. Build is not possible on NonStop.
> >
> > cargo build  --release
> > /usr/coreutils/bin/bash: cargo: command not found
> > Makefile:3021: recipe for target 'target/release/libgitcore.a' failed
> > make: *** [target/release/libgitcore.a] Error 127
> >
> > Is there a way around this?
> 
> I see this in the Makefile that you may or may not have read.  Does it
work?
> 
> # Define NO_RUST if you want to disable features and subsystems written in
Rust #
> from being compiled into Git. For now, Rust is still an optional feature
of # the build
> process. With Git 3.0 though, Rust will always be enabled.

Thanks. Adding NO_RUST=yes to the command line for make worked properly.

