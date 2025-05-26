Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4720FAA4
	for <git@vger.kernel.org>; Mon, 26 May 2025 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269214; cv=none; b=ZrOecxNhBeF7qNoOV+WoBlEUwlzgMB9yOzKKPAiBfFA6H4O+Jnj5cNuaTs3Tr9/Z1TJMX5dYC4xnIELgRAe7aeX6xJBVYcE84RjXAZtGarRoE5JZnCVmCJVtxjnuaVZ9M9s4dyWBQDalqYhzpRonFyeiJ7iqURu8p6/qWzXwopQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269214; c=relaxed/simple;
	bh=sbq5xRu0k5+YBtIM/X6u41P7agZM0ZFHG8NpCxoRUjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJQpYBt9lmGxzY4OAqz8+TxEYl3phcZPvPdBt1e6TW7CePvZXDX3Ic6maXwP5feD2dkVtkX5m0R6OZQhpx8vQifTYDLDZJ1ZKMrAXRtthxTMaKgRsXvYCLUZ0UuRKxRIE67SRTIrTxgb1H3vqNsn+TrPrZbiX+IwyU3ZOJNW+Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m281HgLO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m281HgLO"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso1654785b3a.0
        for <git@vger.kernel.org>; Mon, 26 May 2025 07:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748269212; x=1748874012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zHFW3pSWLEbERSPYalWTOL3W1PlQ2IP0LlG0+dIV2tE=;
        b=m281HgLOtwfvLFiUjgXUsbzusnc8V+Dwwi45Q4e6AQlZ/pl2wEcMkM1wQvu7q9spwK
         BVOk5jKbzk4Le6dmOnUxyZsth/scJpf4LZyou4xJSW0EIs3rNDUv/JQ54RGuX/brP9zQ
         gavF8eA5Y35V+KQXECfNvxtN8Y7JETY4YP1GYBHFxRv717w2Qw30h1u/v9TOUUZexpsp
         +2E0gU8LVBj2qnVWOjZ+qopu/7Cr4A0RvXpdd84oM3k7mhDDUv/jMEmhkYMPGSA3K4e2
         VuM6Sg6iqWwkbBqbw846JTZCxqtxWhxWouEEEX+V8HYTJGdz0Kcq0NkvwpcPB5K+vWeP
         gv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748269212; x=1748874012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHFW3pSWLEbERSPYalWTOL3W1PlQ2IP0LlG0+dIV2tE=;
        b=WVypKlLrNeBGSLBkXyOxb/0qmHya7ljuaKcXg7MJzd/1Jw5YhSzyTWe2uzaRzTa6yo
         27vi2tt9utOuPFby8xdHdWLO7/LfJqYX8kYNWmf/xahidOMf3PxCXGHcDtkcvbZLaJYH
         b3r3dKIVa2Qzw1jTGvD2A/20EkRPurXSY5GPPwXzA6bjGY5lkOr3uG4Qex4qdvw4DbsR
         Ozlg8I6ertYuTvph2nCMXBf9S/Qqa5tkMSQEfXHXZkvIRA7e5VOFRJzjRsaCG4T4gYg/
         5rseRcbzug+O9L0M4mQ1aFxKzs48TiFZRaKSek/wpgAeinkpydXV/BQ4MkJOKeClfLpQ
         3kNA==
X-Gm-Message-State: AOJu0Yzh5o27qKw4cE3pDi0huZdsxfNZ4K09ZrKlBFYSBb70hEsS8Xq8
	v58rwYFXvuFcD3QuIIVgJ2joXD97vO/x3FHvWZvg2AxcDeUX+8XME2Qg
X-Gm-Gg: ASbGncsZnmO7EnSBCHJqz1cPvYWbcYvP2Q4FJ4jXgBwGJe6409wThlaOU4zwf96Ikoy
	03zCuneNQyfdb8dw6F6vwyR8KFlZ3jk1k5PeX/CaNNXWCmW8es1ZD7Zaq2+VL0dI7ZmIlfd3OqD
	eyFDCI2xai815FzI9jVhWSx2ZtrPiQq1vd+qmgaQ2QOIJrBUla7G9oUJ3Eo0/+sMqJFIXUSuFgS
	GtdwZTqY58IzOdoQNi4Oq2PbCTizT/SbvezX7DGyZK9SyDv8EUhFDHwkPVpzia+vA0EL728Z6Eh
	9PtoRjKbBgCPus3k7nVjVqQlNVG8Tn7x8IobR/CWX1m/cRs=
X-Google-Smtp-Source: AGHT+IFxUWH+S8h1lWRMEGGzxGzRXBanFFpWW3QcICXooXjvG9gQE81utcTTxbaHVaGP8yKVfD5pMw==
X-Received: by 2002:a05:6a20:3d1e:b0:1f5:535c:82d6 with SMTP id adf61e73a8af0-2188c3b493emr15023374637.35.1748269212237;
        Mon, 26 May 2025 07:20:12 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-742a970954asm17055155b3a.46.2025.05.26.07.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 07:20:11 -0700 (PDT)
Date: Mon, 26 May 2025 22:20:16 +0800
From: shejialuo <shejialuo@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 3/8] string-list: return index directly when inserting
 an existing element
Message-ID: <aDR4oBlmuiQQolTJ@ArchLinux>
References: <aCoDB9P5XV1lHMil@ArchLinux>
 <aCoDW8CcWeq8T9hp@ArchLinux>
 <20250519075813.GF102701@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519075813.GF102701@coredump.intra.peff.net>

On Mon, May 19, 2025 at 03:58:13AM -0400, Jeff King wrote:
> On Sun, May 18, 2025 at 11:57:15PM +0800, shejialuo wrote:
> 
> > When inserting an existing element, "add_entry" would convert "index"
> > value to "-1-index" to indicate the caller that this element is in the
> > list already.
> > 
> > However, in "string_list_insert", we would simply convert this to the
> > original positive index without any further action. Let's directly
> > return the index as we don't care about whether the element is in the
> > list by using "add_entry".
> > 
> > In the future, if we want to let "add_entry" tell the caller, we may add
> > "int *exact_match" parameter to "add_entry" instead of converting the
> > index to negative to indicate.
> 
> I assumed this was in the same boat as the previous change: something we
> used to use and now don't. But I don't think we ever did. The "-1-index"
> pattern goes all the way back to the beginning of the code.
> 
> It does match how other functions like string_list_find_insert_index()
> behave. But I think that pattern doesn't make much sense for
> add_entry(). After the function returns we know we've either found
> something or added it, so the positive index will always point to a
> matching entry.
> 
> So I think your patches are correct, but I was curious how we got to
> this state.

It seems that we create this in a long time ago. In 8fd2cb4069 (Extract
helper bits from c-merge-recursive work, 2006-07-25), we introduce the
"path-list.c", at that time, we have the code already.

> 
> -Peff

Thanks,
Jialuo
