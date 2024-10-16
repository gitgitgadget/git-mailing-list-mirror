Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8724E6FC5
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038390; cv=none; b=okZkNf1QQNvjcmx8D3Tf2Q2WKEeQeH3OciENSZLaBy/GNLf99hy85chw/Y02YQjRprjsWr1O/d7IySrEW+hxOAVAKugbXakYdt7p8/JXfGT9FcfACEkGpzW7FT679U0Bm+4hSItg72pe8yQ5IVQXbWZ6/XDvLdRUlDoVEQDCkBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038390; c=relaxed/simple;
	bh=BGAREMhijbloYHIswehrd7ZqcR4bD59jc1UDhTfIOV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JArQe265CJ1S+xl8u1rkChRIUOzu3A+kJ9f38+mr7N9RmQBLEHmmbZhBElmb4uQzEZqf83GmDsZ4lo1WfdKhfARtAyyo40EJGzKzBJh/vEllRoo1xhUp0sIAoOpNTUABBS3hSvtX/lSX/ElA8nhD7gaOEcLwhLTimJqRbTPwzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=RUzOtNS0; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="RUzOtNS0"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e314136467so4299767b3.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 17:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729038386; x=1729643186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1H2fDzJQH4QW+TIhcraitIGVVqpz3DlP3Um+TX8iEhQ=;
        b=RUzOtNS07OjW2NCMdL93jWBZ+D7rATTFjjckcXw7Duz3AJ5YTd4Zuue0E/CCilGr7n
         mQBeecwYRBRwlwZw8tprfxf4l0r468E0QsHKX8pr5eM6p3PsBil9GJV0+B/+yONMWSz1
         IiD8oA4TrzFjUcBhXPrudNM5Lg2vy6HXW3v5taHfgDP+I+4ie0h6Skpi4oPb6hc3Vv1q
         sEUY9+MvyDAALAbWwd21Q2poJrnPc/XYWIb6fDF+p9PyCrk06L4GBPEhp2fkO5Uw5x58
         QH002hIZK8JyJTjkPwttid3xFcat7Wy7hVnKX5AmKwwsP79j22QquIxk/k6e6EH3aeeD
         WU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729038386; x=1729643186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1H2fDzJQH4QW+TIhcraitIGVVqpz3DlP3Um+TX8iEhQ=;
        b=ZZJUYfEbwwNG7THlc8A1tJxGWQBJSdaWgiIsJ3QvY25aW2Z83aFZxjrO8+AoW5CJdP
         4eP4OGVnq59bWmJ68skm3eE3KBKTo1nwGzIVde5CwWz7XCc/YJLpPKoOPLTMZdddCXbU
         IA2/Jq/2vATo9aacPajsyisItjzkHN07UDa4opky0bwx/6R1iz4biMJX++gAa/GvWlQq
         yf3q7gPtnakIA6ol+16BMEBls7bzcdhjdfBfjpB/DemO9bIdP/9w82kVDfRkXb++fbet
         PHvecKF350TEbXmkS6vILbqT8TuJc140gPi9E+yccdZOCi8GsvWc8d0Sy8pQQZRYpHF5
         pI9w==
X-Gm-Message-State: AOJu0Yyfw1v58pjeQtIsOLEpGRtGeAw7K4liLArbHKGnpflRgWBh6AvS
	328wfFuvoLyc+f/ur2YqhaCw1B2CNI7pVU/t4qXQz8BEINZfw4wcNFDQMxqtB68=
X-Google-Smtp-Source: AGHT+IEjpkYe8u3RtHAyZFSTIP3jryoRR3Hr7LQ87rqlQiXWr078xRX/9oq/0JUYDxvfaPVZdfIHYg==
X-Received: by 2002:a05:690c:82:b0:6e2:41fa:9d4 with SMTP id 00721157ae682-6e344ccac13mr129091017b3.15.1729038386528;
        Tue, 15 Oct 2024 17:26:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5ae1bb5sm5019777b3.25.2024.10.15.17.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 17:26:26 -0700 (PDT)
Date: Tue, 15 Oct 2024 20:26:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, karthik.188@gmail.com
Subject: Re: [PATCH v8 0/6] set-head/fetch remote/HEAD updates, small change
 from v7
Message-ID: <Zw8IKyPkG0Hr6/5t@nand.local>
References: <20241012230428.3259229-1-bence@ferdinandy.com>
 <20241014225431.1394565-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241014225431.1394565-1-bence@ferdinandy.com>

On Tue, Oct 15, 2024 at 12:53:09AM +0200, Bence Ferdinandy wrote:
> Bence Ferdinandy (6):
>   refs: atomically record overwritten ref in update_symref
>   remote set-head: add new variable for readability
>   remote set-head: better output for --auto
>   refs: add TRANSACTION_CREATE_EXISTS error
>   refs: add create_only option to refs_update_symref
>   fetch: set remote/HEAD if it does not exist

I integrated this new round into my copy of 'seen' today and noticed
some test breakage in t5505 here:

    https://github.com/ttaylorr/git/actions/runs/11356267070

I'm going to temporarily eject this topic out of 'seen' until we can get
an analysis of what's going on here.

Thanks,
Taylor
