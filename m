Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2A6DF58
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752798122; cv=none; b=jj4zGHrghXejbfrB1Pmh2xrkuGTFQO+ldFp0FtDyr1+cRrFCItf5EGHaqpCTg2CbVim5cAAq2s2kqBzkRS3tRS4mJEFMd8oFES0H3gTS86s5w2s+xZYu5WLa3h+Wl8k7tn4qaH6CVI4cBihLU583ZzlAr/KAvrQpy4jheoLtvDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752798122; c=relaxed/simple;
	bh=b2xtodCdXBJ8b4Dt1sHs76rQFozPSVGwcuKHShdUkvc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h19uWvUQnoWMmUZ0HLIyXtg/oZ9FCoT3ec8jql9ZPvJUZFve69ybOTKJkeUU5gS3K9iaX8Q49oKc43+Bbd7PmFI7j+zZkNcwz7YCTnexs80bWQHaGj+X1N3Z61NiIfyJgG9vfBYy3XuNuS0lGeMzeZ4dsPMmTllu+iB030JTcPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=QTG2kBX3; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="QTG2kBX3"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8bb69cdb90so1589378276.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 17:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752798119; x=1753402919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Y76qHc1dsExdNChf3Cnq7Spc1CWUFmMsdcKBQa3fng=;
        b=QTG2kBX3yQWmktMcN3KYkLD7nMSvWzRdxP3TnbL+I0KQaKEQx5tQf88MAIH6FThBGN
         udnnhkzXYGCfJ7Myz5UEDIlkPX0UjJF8wDcf1WE6gDa2Uow2AognAtgaK83eMgouqeSZ
         WcXiIZ9oqtDsDyNDRvAfEz1Nmc1KcQNRZc3pME8HiZYBf1ZwKY63sDmet8GLF6ADPaef
         nZrHkueCTM19KVmscfC/ljq4U0x2lcSrWv4/D21797UCM/FvD1A63YItzLIAALWaf5LJ
         bORrjh6gqKnJ2GL1UhkoSBoORnViCBp3jR3hh4Fr2soXDtBJIhImTMKl87Rf/uA9OQng
         Qj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752798119; x=1753402919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Y76qHc1dsExdNChf3Cnq7Spc1CWUFmMsdcKBQa3fng=;
        b=okTJXpGD1YSYq2oZlCNo3cj9I55hfZP/YEKOsEkETAVlO8vxuXbVmLUEXmAxNC/Gdq
         ElwHz6mhOpO9x/tZ1tAsviBlb/f4PhJKHGAJIGsPd5ijyE6w/UUApD0g9/t9oAS3HN/a
         HVjE4zf58qnEL1HLxEvmraBLVvYtGg2m/9BXUDEC+MYpntNJ+exbY8yWMTDxqlIyh8De
         wR8pQQIAi17nv+WdhtmLyuJ5KBF4/BYobdRpJW9o60vuz+ydkMk/AUEwY28ycaIDHjke
         jtlpxgKCzKQFCy6L5OOmoZmRWL3fo9C7Bu0fOSqv+/ATK5cBIvGbZfgnO3HZInsFGCPv
         16gg==
X-Forwarded-Encrypted: i=1; AJvYcCWyJHTkg/fZWbrjsDe/kND3NjVleL4eQ32dVARsmxzHD2XKy53SS2M5y2ID0xiRxTGMoWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5IkJWxCoDxlBJdo70ERcv+rn3tM2mF/qI/BPs6pmxikGpWvZV
	qy1hjYlL9MXb3OA1JKtzB/moRh7PxaBhL5kiHaBGZDxi5O7sdVsBWlbmlXtcELR2SIc=
X-Gm-Gg: ASbGnctS4WfZQw8gvXd8jL1/DjYe1Tnt5QE7g9tOVTVKlJfwsrJPz627sWfI+OhZEcs
	J0FDfWGUK6SmA+uopn/X6Y2ckpQxFL2zDv6cWRaq6Krp7Jm2z1SKTtoQmw6bCdE4oWfIe0pGXiU
	lCc+PG9dW2B5gCSXp0b+vMmjUEE2EgDtkCn+zQqVe9vZz63RVjkLUUFXyaE4rnLacvNJLeHJ/g6
	uDqiholuPQllKVARHc8Aibl6iVMNZMK46yC99bRd2JY2TfMt9fObRx1imxhb8Rv813SNl+TDlrH
	DYrcqvmlHFh9nu+bL6iWuAdsi+zlKXJ+3haEOEb+N7XSk4pWNvEvBLyRXeD8YbHH6EXedYZP8my
	1AbOhcRLPtU8mHTKWXwxsuey8eGb7dBe3x7XtcUsx5y424k3eUydeUM9KTW+eOP09zEgYrA==
X-Google-Smtp-Source: AGHT+IGfZY06gwKelE/k5oW6auWsos0XotijU7urBgdqlkVe+VVFMpL3s/ZubQjrBNzkicZoCkCzhg==
X-Received: by 2002:a05:6902:2686:b0:e8b:7719:fe3b with SMTP id 3f1490d57ef6-e8bc25fc82dmr9719028276.23.1752798119457;
        Thu, 17 Jul 2025 17:21:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e8d7cc0b159sm65206276.9.2025.07.17.17.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 17:21:59 -0700 (PDT)
Date: Thu, 17 Jul 2025 20:21:58 -0400
From: Taylor Blau <me@ttaylorr.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
Message-ID: <aHmTpqVDkE4PqG3h@nand.local>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
 <aHl9YLc823uWwgIp@nand.local>
 <aHmDiqsBsDJJ6m8C@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aHmDiqsBsDJJ6m8C@fruit.crustytoothpaste.net>

On Thu, Jul 17, 2025 at 11:13:14PM +0000, brian m. carlson wrote:
> On 2025-07-17 at 22:46:56, Taylor Blau wrote:
> > On Thu, Jul 17, 2025 at 08:32:21PM +0000, Ezekiel Newren via GitGitGadget wrote:
> > > From: Ezekiel Newren <ezekielnewren@gmail.com>
> > >
> > > A few commits ago, we added definitions for Rust primitive types,
> > > to facilitate interoperability between C and Rust. Switch a
> > > few variables to use these types. Which, for now, will
> > > require adding some casts.
> >
> > Hmm, interesting. I am not super familiar with how people typically
> > handle interoperability between C and Rust, but having to change types
> > on the C side to make it work with Rust is a bit surprising to me.
> >
> > I would have expected that the Rust side would have declared its types
> > using libc::c_int, libc::size_t, and so on. I think I have a vague
> > preference towards putting the burden of casting on the Rust side, but,
> > again, I am not super familiar with how transitions like these are
> > typically approached.
>
> Rust normally handles byte strings as slices or vectors of u8 (that is,
> C's uint8_t).  C handles them as char, which may or may not be unsigned,
> as we all know, which leads to some "entertaining" problems from time to
> time.

;-)

> Also, in general, Rust doesn't offer generic system-specific types, such
> as `long`, except for C FFI.  This is actually a strong benefit, since
> it means we're not inclined to write `unsigned long` and then wonder why
> things are broken on Windows: instead, we write either `usize` (the
> equivalent of `size_t`) or `u64` (for things like file sizes).  This is
> much more ingrained than it is in Go, which has a tendency to use `int`
> (Rust's `isize`) a lot and much less often specific types.
>
> If we're going to move this code entirely into Rust, then it makes sense
> to cast temporarily, and I'm fine doing that in C, since it's C that has
> the weird system-dependent behaviour (arbitrary decisions on the
> signedness of char).  That actually allows us to have more confidence in
> the safety and maintainability of the Rust code since it is less system
> dependent and leave the suspect pieces in C.  It may also, interestingly
> enough, also allow us to easily get rid of the weird 2 GB limit on diffs
> due to the unpleasant dependency on `int` in the xdiff code, which I
> would absolutely love to see.

Ahhh. Thanks for the patient explanation. That makes a lot of sense, and
casting on the Rust side seems like the right approach for this spot.

Thanks,
Taylor
