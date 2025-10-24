Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D289645
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 00:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761264078; cv=none; b=PaHTMFVx6rc+ot+KXirTvIq0rKx/CDGwqltPNWYFpOUuaDAAIxOdG79AfIF/Bn9XZNRDU1o0XfTdZb1lpIpI2mVTezfmz4SZvT9UcQ97f54W/xWg97tJCwBKFhQDFSvL7G9e41ImMvbUNA98m8dfMDrT6rhGfjBy7Ey0ZqSgaVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761264078; c=relaxed/simple;
	bh=uchsosZLw3Bvd92bJDdlkUtPOXtp+PSknW7FQRzKeDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sY9xapZx2Pq32eV5jWazQsEqhE2jpiC6kQeS5IIXyeC+idi0KC/F45bjBmbkeG/8c/nijXb9HhELA4IPmgznHB8fO0SMFbf3Nu06h5SoRBRWSYv/mplHyyw0pDl/+pKhSoY13OdObVWf+Z8TDrSqVjZAfaRXAT0Oa1s64QBeGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nzD+VOfe; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nzD+VOfe"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-431d2ca8323so7594495ab.3
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 17:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761264075; x=1761868875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jb3hPRPo2VwJs1Av5a66MxQn86vdpxP2Jn00QhKHSMM=;
        b=nzD+VOfe72FefILUs78KoO+AtV3QxcevjA4up/2yDcgSFYx9MiVEiyS5LAb0sKTEIf
         A5gSJzuaDSM95eNFwSEwsK1bDG/I25XcR2MKwPQsoXpuWYRfDtIra3JTcUUGf2t2Kd2z
         07x8dolbP+nKtwFn/GYns5plKSYSgmqCk6BHNAJTH08InH1/TP5T/tP3YmUS4Zjaew2g
         y3QMc8A4Bqae+KkmsA98wTxaJBCHMafV/899BpPFU+LALzuIkrEsKu3KmJhJUjqMXsuQ
         eqnLXVMGyFif+PE/h1K8PH8PRyvssLXOhX3+xaVa8L6yNJGUy7CzW8YsO6DO3AQxLbxU
         qtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761264075; x=1761868875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jb3hPRPo2VwJs1Av5a66MxQn86vdpxP2Jn00QhKHSMM=;
        b=hY4pmk4ZD7bCxIBYO102IZWZu7PWvXLwQiN0xN/+ff0h6b1aqzg/W8lIs1o9tgAxAR
         1CCqgfucaJJ+tjzrpWfQfjqrWHpjXRpyY+okeHhTltAc3Kkj2ZErkLmSaMTCfd3bvWAL
         n2B5TJwkkGWsRL/4Pg0/2/IUZ5wrVWEMpJczXxhgYZTkHRVAqhGmEWp2e31DU82qG7Vs
         Ek6yLZxzEUL8gepTm6WgLwnz+QWOAFyh5IS5Mwzc9gDngYykfS1yf5F9quTHiNO8CCbo
         xIZQkSPrH5FUSwNrU4MhVwU6VYYMurI3r+YGxwHm8Fiy/iKnH0WOxAxq+A6DzB7H8Shy
         2v0w==
X-Forwarded-Encrypted: i=1; AJvYcCWzLBN+QlYjM355UrKG+dJ7DhksKo3Prh0d0+Hg21mQc0qGfdk9znEdq7B8DOvbptKkPeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9BoMvd8nwXLgjK5AqveIkvjQEUY+740KON5q2Zbxkm9cFBWWE
	9pxXt6IlzzD5+WCBksRQC/PGarL3yk6GkVQN8gVMnlE698cmOQEcALlM0uR74WMrIVw=
X-Gm-Gg: ASbGnctH4trOe6uIsIoMXJRLLYLGvGwVkBzq14hNKiCzK0QhWj69FsnHHaMtu0Uw42U
	MpPTW2SiwU5E/fO8J9cR4qV1DT2YWAcORFtbf38H0Lra+M+l3fMZ+PCAoJ7M4ZTzLf71x83HOO5
	gPU9hzMSm/EzQqTgY2ey3rNJZzcKMo7LMw5JKatXIM/UkUik0UjE5N25E+gz/nOh8o6KGp6euYE
	1bMs72OxfSBG0oNRNxgTtAnqPNT1fV//UqBfGsYcA73zeVGPlOdl3tcbl2o4yECn3spEfFFn8oq
	/Iad6RzoiKMYgR7P+Z8dG/k0WwgH3bRl81soh/ONAVQ90Ct2YlloInlJ6f+bS1q2warIJL1ZrWi
	YnjqeV/NkSx2wQibBlLaNhB1eczNqzBfubpl5bgaGuav6SNdfjrj18NZdKaAlw4MhRghmHtFg5R
	UR1xAfNZjYZy4tBj5tazSPLjroI6iLdK38QGhCoeZx3PfbMIQwUncVVn79cd7E3GwoJYr/yffJm
	1V+J78hDHcn4U4EFw==
X-Google-Smtp-Source: AGHT+IGvR5cbmzFCYew8w+kak8kKtGlZpwmNsxh10Zex0UOtWINM0SpjTV6PpjXNJlszMwrXso4/VA==
X-Received: by 2002:a05:6e02:156c:b0:430:aec5:9bd9 with SMTP id e9e14a558f8ab-430c5209291mr355902295ab.5.1761264075293;
        Thu, 23 Oct 2025 17:01:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-431dbc21f25sm15138685ab.7.2025.10.23.17.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 17:01:14 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:01:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] last-modified: implement faster algorithm
Message-ID: <aPrByfpOkQ7biyEI@nand.local>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
 <xmqqy0p4uoqc.fsf@gitster.g>
 <aPgkwnq87UeusC6v@nand.local>
 <xmqqecqv1trk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqecqv1trk.fsf@gitster.g>

On Tue, Oct 21, 2025 at 08:48:31PM -0700, Junio C Hamano wrote:
> > Practically speaking that's probably OK, since we are unlikely to have
> > so many active paths anyway (or if we did, we'd likely have other
> > problems to deal with ;-)), but it is gross nonetheless.
>
> The case path_idx() returns -1 is an error case, not "there are too
> many paths we are following" case.  I do not see what relevance the
> number of active paths has here.

I just meant that we are unlikely to ever have so many active paths at
once that (size_t)-1 would actually have a valid entry, or IOW that
active_paths_nr is smaller than 2^32-1.

Thanks,
Taylor
