Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD715444E
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502590; cv=none; b=pNEGoct7StlDS19vMLMfGzDRBW8FL7NKGp3uRnm8t3YyLKf8aE/Xwvyq8fHuYArMXGM4iB7pzX2oDibb/zLJn3j1qX01hlEH90PsqupMkR4lrm67yxX+p5rEI/lUhbcUIFQOhsHSFNyO4YgfMFRhVqfSBgzeekXnkt0DbiVH/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502590; c=relaxed/simple;
	bh=ROrNTSUWsB2v48QFZujKXmZPraqew93hrmok5AUtcLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGW5SgugfHmcQh5pNKnKvkg/qw5e11tNLdmD5Z8AYaTnIhUFHnAnWuVX8ogCFtM0eUnVQPAPnU4T4nyD7cJF6FN7ex8H0o5VJSkMsYAyfy1RA4rhuS+0zYrlSPjaDRXH47r+33XJtRR/YzyMJBkJx6UkOZvNCPn0gG6ciuBpcok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=h9iGuu9w; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="h9iGuu9w"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a09af86744so6215985ab.1
        for <git@vger.kernel.org>; Mon, 16 Sep 2024 09:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1726502588; x=1727107388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROrNTSUWsB2v48QFZujKXmZPraqew93hrmok5AUtcLI=;
        b=h9iGuu9woEe3fMLWrd8YqQtUAGKUlb1nOJrn+lBJo57tmMPMJ2/Vayr6D0ne1sjQk5
         xDZE2YqRsMNWTlAg1OilbQgMzPxswgXjhr/QU8wmpCTCTmu3Mc0ouNsSe8xcgyv1u4BF
         DyovCv/mP2VBbHjh/aSQx925pEzDrhr0DSxO0vIThI73sCOe3r9GUl3Cr0C38YXfsWdI
         jKRhf1/AsrZh9s/e4RLg2OUZ/I6poGJvcdTJtH6No6YcT0wdSHfB/m3J/ACQL3JiABAf
         4wwRBXOI6WAxUgVBs++4FlL25qqGztIbWoB35u1bOdxv63/kP0X+2iqPX95yYAaoiHnD
         mEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726502588; x=1727107388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROrNTSUWsB2v48QFZujKXmZPraqew93hrmok5AUtcLI=;
        b=XAhKjFSLUlKEuLdQUYupZg8ltLSN4TXoDLRH+eHp874pIyjmRvTncmp5YcifRpQB2o
         SQ/Wf6sb+6UUTrqp39CXrvL8FBAxdoNHp0XZ68vmWqPEbMz6jegM6TciqqnG3He+uTRC
         ZwVlNkPDjVroosj2RDmZvRMQ3ypAQ9bXGJL7S98+Ykpn8NvCMpC00TM3W6HyyBCI2vJc
         vbiJox1s+xFMQWfFRucpXZbzEDi9GHjNE1uPJ0/WTJLKA2nMmq1m5lUNQCHOmapbfvq4
         lwl58MMdlJ38lBCEvHGKcww29b+FCUjXhNUtE8KcU0kGHbLbwbFeOijO974PLUCVEOE+
         BC+g==
X-Gm-Message-State: AOJu0Yxh1EZdovpeuAOSgJCndvMCqJqjh6GMjesdggLqXrOpDh5XSJia
	Qvbi4N6myoPI0yKL3f0cjWDBnpqYifDK6BweUR9SQeec3+VYwXE10eDeEsrtaL0=
X-Google-Smtp-Source: AGHT+IFI/89c3rctMPM2SK6IFtjSGi9nf6I8Fb7+N1tMvMnTFTSa1Cz3t5Z5BhtphaGIWYmjL46PeQ==
X-Received: by 2002:a05:6e02:1d11:b0:3a0:9c2d:f441 with SMTP id e9e14a558f8ab-3a09c2dfb33mr45110485ab.24.1726502588031;
        Mon, 16 Sep 2024 09:03:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d37ed190c3sm1562720173.120.2024.09.16.09.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 09:03:07 -0700 (PDT)
Date: Mon, 16 Sep 2024 12:03:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/9] finalize_object_file(): implement collision check
Message-ID: <ZuhWueGSwouKddgm@nand.local>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
 <0feee5d1d4fc1e0aa1ca5d98f2f404ecdbb2f6b6.1725651952.git.me@ttaylorr.com>
 <ZugMUv1xbnjYH-el@pks.im>
 <ZuhUprZXvcRvgpp5@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuhUprZXvcRvgpp5@nand.local>

On Mon, Sep 16, 2024 at 11:54:14AM -0400, Taylor Blau wrote:
> On Mon, Sep 16, 2024 at 12:45:38PM +0200, Patrick Steinhardt wrote:
> > This function compares the exact contents, but isn't that wrong? The
> > contents may differ even though the object is the same because the
> > object hash is derived from the uncompressed data, whereas we store
> > compressed data on disk.
> >
> > So this might trigger when you have different zlib versions, but also if
> > you configure core.compression differently.
>
> Oh, shoot -- you're right for when we call finalize_object_file() on
> loose objects.
>
> For packfiles and other spots where we use the hashfile API, the
> name of the file depends on the checksum'd contents, so we're safe
> there. But for loose objects the, the name of the file is based on the
> object hash, which is the hash of the uncompressed contents.
>
> So I think we would need something like this on top:

Thinking about this a little more, I think that most cases should
actually be OK. Of course, this only affects repositories that are
changing their zlib version, and/or changing their core.compression
setting regularly, so this is all pretty niche, but still...

We often guard calls to write_loose_object() with either calling
freshen_loose_object(), or freshen_packed_object(), which will update
the mtime of the containing pack or loose object path for a given hash.

So if we already have a loose object with hash X in the object store,
and we try to write that same object again with a different zlib
version and/or core.compression setting, we'll simply call
freshen_loose_object() and optimize out the actual object write.

Of course, that's not always the case. We might e.g., force an object
loose via loosen_packed_objects() which could encounter a TOCTOU race
with an incoming object write using a different compression setting. But
that seems exceedingly rare to me.

I think that we should still take that change in the mail I'm replying
to, but I would definitely appreciate others' thoughts here.

Thanks,
Taylor
