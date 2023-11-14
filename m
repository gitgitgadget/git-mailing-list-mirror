Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DFA2FC21
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lnbamg9I"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8F0C1
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 13:10:32 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2C6D228C9E;
	Tue, 14 Nov 2023 16:10:32 -0500 (EST)
	(envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:message-id:references:mime-version:content-type
	:in-reply-to; s=sasl; bh=NkkbM7Tx+FYqW9fsBut9mJu2bXaR76Cky6sBngi
	xpQ0=; b=lnbamg9IeKv2bTLzHKrEkUqyh8EGdjoIoaF3KVb59fy15Yh7b5/Mmo9
	KlOcHdDqJn7omCos0hL1qRzzJWiQcNsnWic8soMqONyZ6AJeKUMF7j4/PjR6dO3K
	mY8pSVr2A0OxEPvC0tIUNZqD/SARIHsrX9LRpVs4BToxqzLKkEqI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 23A7528C9D;
	Tue, 14 Nov 2023 16:10:32 -0500 (EST)
	(envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 75C4B28C8F;
	Tue, 14 Nov 2023 16:10:27 -0500 (EST)
	(envelope-from tmz@pobox.com)
Date: Tue, 14 Nov 2023 16:10:24 -0500
From: Todd Zullinger <tmz@pobox.com>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [Potential Bug] Test t0301.34 hangs - Git v2.43.0-rc2
Message-ID: <ZVPiQKhem7ew8o_8@pobox.com>
References: <xmqqo7fwxn4s.fsf@gitster.g>
 <053501da173c$ac5b4470$0511cd50$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053501da173c$ac5b4470$0511cd50$@nexbridge.com>
X-Pobox-Relay-ID:
 3C3B4FCA-8332-11EE-9A96-F515D2CDFF5E-09356542!pb-smtp20.pobox.com

rsbecker@nexbridge.com wrote:
> When running the full suite, I found that t0301.34 hangs
> on NonStop x86 (Big Endian). No details at this point -
> will rerun this, but this is a regression from rc1.

FWIW, this test ran fine on Fedora's s390x architecture.
That's little solace, I know, but may help rule out some
potential causes.

    t0301-credential-cache.sh ..........................
    ...
    ok 34 - helper (cache) can forget user
    ...
    # passed all 44 test(s)

The build log is available here (for a few weeks or so -- it
was only a test build):

https://kojipkgs.fedoraproject.org//work/tasks/4976/109024976/build.log

-- 
Todd
