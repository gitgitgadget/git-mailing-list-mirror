Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1A51A2846
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 22:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250995; cv=none; b=Efx5Y2YnPfH3MuBqlWH2ef+TGwArqFrl3tGASrx3q4UNusEWTobmADEmq6JPZi+oSAMlkxoB7BvIrEYbuTMDMKVBF2ugUY5xYwBbrEcLD2T2i86P3XbXHzjJlY4hmIiZdjsAlg0NESK+dtR3Fm6W6lkGoYxUY+n4IM/wrWL8WbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250995; c=relaxed/simple;
	bh=19kmTqJwxrRxxZyUxYdUgT6AzxnAD/4CsZn5rUaEgCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HY1owiUkOpl8DrCCC9j2vTkkeFpKRc+d1HKrzD7cceH3nlz/qjmTTX5TcUoVzBCWjs8ZbfTmx6SV5dyB3WA/hi6DCcfux2z9tlmL8pLvo7JMFmTZubFLzW6nUgzBiDD1Boav6FQQ6tOEhUZKPgFR/RA5ZbLma/xOvArdsbzQPe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SIFGGgcR; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SIFGGgcR"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c3bf231660so589744285a.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 15:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742250993; x=1742855793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ihg92YmKNyUuyINn8ezi+RefcZ7jq9YBhtmq4nhKLUY=;
        b=SIFGGgcRF+GVQDaa4k0qlDU0FdtLwEEybFF9dlfsq+9rzA7bYT7PJjRafGIQg0gA3v
         5D9UOYAt0LN3ZvPVc//QtKWyxneDkmms/p2a1fuajBmoiW6lD+m+paAq75Nv275xXpyU
         brJRHqUHspvhO0sSfXLxiGXPzQEeSIohmnxFxgLblrWwjeoGYEHfBvBNnNs70iz35CaS
         YXURBtxfgAkt3LkUERnT21tt4Mrqp8ROf8EUTdnNcON9tWdJMCWAmE9MAoCred/JT5ZZ
         7dKxE6AZOuQ9yiUaGFskVQxu39yAAe2DFHoU9KzvqtpPwLJFdV2U5B88WInEMB618hs0
         jTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742250993; x=1742855793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ihg92YmKNyUuyINn8ezi+RefcZ7jq9YBhtmq4nhKLUY=;
        b=NUIcG1FjqdQHAAepLrOr0h0LNOfAk+6vRI6D82agq39dMtAJy8oaAWXYdrrJS2NLIF
         v5tTe9rjIXmfHsCxuKM+Sf89WT4RiajeARSlw7T9TXp6J6A9ZpS1zBbWdQmxWpO7k+xD
         B6pNB2WFA0C8hpffr4EDocL8G82MRiRERiBm9K59bvDbuoJmkhGHo9LfUDQ7pkYNEbxI
         D8HGV7Zm7jO8MozbchmS/o9vkGtI+8f0IkTBNOS+qWZQO12UHXpXiFXhSEgZrgymrIPx
         GiCq5F0RJwLzN3h4AtcHQNeahVqUd1WWhJMn6YZKQge/UMxxMlMUdKCuSvercZTK9y7k
         YyFA==
X-Forwarded-Encrypted: i=1; AJvYcCWgD+9cW9GFL81tK2XPNxDr1PjQEPa3/7SCC2SYSZrtukRCgeHPcN+7F3mXSNSb5qs53cg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNIG6QE3Q/2Wm8REOXWgh3xIRyYk7CIr/Lfb29gJamH7gEd3Mg
	q4nny9r0pl5Li1psV+FxUwWScScRZiu71/H2tIwTsMGplaP5Jq8t3QdOUnE2ciA=
X-Gm-Gg: ASbGncv/2J/WbWG43jVGMW7N660QU2Psa1ZqDC11Pt1jpbqi0Lw1t3qUQ4PfEDaGSl7
	5/iaX+9TYR+EsTfqp5Kbnpwibed41f5nxpdnekkxj3z1aNHD7Eqalh2aJcdk+5NG9S36gLxrQFS
	276v8ikq7a8/sIG6F7hJfAvgNUGComNObfE60pRjhVmB6RrsFDMzAkxeASyDHCzy9RvTHDC37px
	CjuPTb5Jip+5kAqWD3Ywfy2x3WnqlU9O9rijGx7r62Wq/iqoHvKLApTC9J7r0shRknrC9HMKptM
	S9gQXRwOkqY0QSTKlS5yFGOM31olERPwNOIxQrI4VSHNoF5yKyDhma0g1szabxIn38fTgXJPJm+
	WZxgPjgYldxP8AbCRP+hBTsoVVbk=
X-Google-Smtp-Source: AGHT+IHp1+eLMdrMgP+0Ha+/0voVvuslUY/nux+gfovu/qpKNILcEGjWFnRDXzir4RFWEKu3L+4Baw==
X-Received: by 2002:a05:620a:1921:b0:7c5:5e9f:eb30 with SMTP id af79cd13be357-7c57c79c59cmr1750839785a.15.1742250993225;
        Mon, 17 Mar 2025 15:36:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c55e95sm640558085a.17.2025.03.17.15.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:36:32 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:36:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/3] git-compat-util: introduce BUG_IF_NOT() macro
Message-ID: <Z9ij72MASlTLT6+8@nand.local>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
 <pull.1881.v2.git.1742107322.gitgitgadget@gmail.com>
 <109060ccb8665c73aa0c4f73e3cbbddcd135bde4.1742107322.git.gitgitgadget@gmail.com>
 <xmqqjz8n70dt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjz8n70dt.fsf@gitster.g>

On Mon, Mar 17, 2025 at 03:33:50PM -0700, Junio C Hamano wrote:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Create a BUG_IF_NOT() macro which is similar to assert(), but will not be
> > compiled out when NDEBUG is defined, and is thus safe to use even if its
> > argument has side-effects.
>
> If this is meant to be "similar to" assert, let's not call it
> BUG_IF_NOT().  The point of BUG() is that the developer can mark the
> problem with something more than just a conditional, and it feels
> funny to call a facility that lacks that central feature with a name
> with BUG in it.
>
> ASSERT(), safer_assert(), safe_assert(), sane_assert()?
>
> The last one is in line with safe_istest() that is used on
> sane_ctype[] and sane_qsort(), with the intention to allow
> developers to write right code more easily than using the plain
> vanilla C.

For my $.02, I prefer ASSERT() to the other options. It's clear, but
indicates that it's a macro and thus not the same as assert(3). But I
don't have a strong opinion here.

Thanks,
Taylor
