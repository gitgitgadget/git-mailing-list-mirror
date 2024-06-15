Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B6417727
	for <git@vger.kernel.org>; Sat, 15 Jun 2024 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718482453; cv=none; b=NnRuI1anr3q0OtgolJ6DA9J+xjLZ6by2Lc5GXHqxc+4z6zhHBjncnNIwdjfY8YaA0dJ54R5ba5K1jmqbzuY9soLX5omBKFFQse8RZfo3Qo3DnmYZpa1MTBTKaHZpQHhNZAxjlZCxRkbHiGn7HpTTYUhssEDIDSzixLmDiphBocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718482453; c=relaxed/simple;
	bh=BbmRyp2u/D1I8mZg7QGSrVzKMD+GNvouxVqXrU6+ybo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5jE6wPw4NLjXUqgIg2B1OcADAg8Obj/iEsNYK+Y5zlMg3/qKtOKSsoDIZEeGGqZUtMwUiGLA/SPHSGKqAZpkUYVXssMn3/Z8l2Rom9Dj+HVEyjhOFOdBMBitWbUSxWUvl+50fuLF1zfs+fmQLe6xOvm74DGOdqXQqs0yqynqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADVnmi+G; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADVnmi+G"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f4603237e0so2345043b3a.0
        for <git@vger.kernel.org>; Sat, 15 Jun 2024 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718482451; x=1719087251; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YjHJASSo3EIOY5kAGfrbnxZn6e04+FkLxoie44yTOk4=;
        b=ADVnmi+Gu8MUDT02EKUSf50Jo7ZYghhwMqg/1PArK/ChxvNO3xsJrLq2hGx/S7tGtq
         NnQtsAp1FcLL6GV9TDhsgqXmhaDbkljdwzcNW007jgAl/jZ9GxDyaxgQbF6kolwS9Wji
         Z1Qu7W0NjZw13x7OkheiHFmQcoIZWhGx1VH0iXjXCKAalLT7LheVOjoVvxgVvTF9Cuzm
         JUSKrHxgsdsj+fw7cw7CYSuV0c/EDh9s5f+5qVYT3iCFK5PruPTzxEq0X/6hd36D9R06
         LMOXS0/GNSf2kBXXU8jCu65ualLiQ2BImF0tbNo5Tj9vT7Lraf193033PF/ahDu18gez
         4rKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718482451; x=1719087251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjHJASSo3EIOY5kAGfrbnxZn6e04+FkLxoie44yTOk4=;
        b=rztHFn6QB4ZgyR8R29EayCQLA3EaFnsaeEqOeO7dNQjY083PN7OLMdS2JJzZKJ14TT
         wMW+CT+klFQ5V/5fgb28EXuWPyDaEijZT+lTsfUHXMl8XLwLLHe7L1MF1SQM7xl97Xvp
         ACzRiqR+pguO3eGUxrrTh9cTs2L8MN91IqEUTMogH/e82wLrMRL7nmay0UeMHQ+Si9R8
         WsxaU/VbCCToW0qkeqk+fF/wn4VgZiyXiuIG6RPnBgeiwF540mQOgnsxk6c9N9EvJuB9
         aaI0/eYsF9g3Yvk4mWq/WvdKtTKdDvGut0Y3FFQ56cT6kfqzIweClm52ATgXLf/IHrDG
         /NIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMZNrnCZlanJAbkYLioLbXiKADa+M5qKkY9pvkY8amYngHm5YzONsP8jTzZK08hW2CLqgWZYpHHwZyXYfzNbWLaQAw
X-Gm-Message-State: AOJu0YwisVD++lN34H2QHbulYRZe7t/Z8y2iE2EcWLqnVwhZEUzNPspi
	8Y+W8Dg+rje1Y90OBQBj59S9TKytE3hn9O8yN2bj2wzdd+WrA1pR
X-Google-Smtp-Source: AGHT+IHJ6UhOSD5tlRxId6BznJ7vvDWMHLYXhGd4oNyCO1M1oSVcKqXIQyexuRUZ4RwxG8DOsLCHIA==
X-Received: by 2002:a05:6a00:22c9:b0:704:263f:5559 with SMTP id d2e1a72fcca58-705d69fc94dmr10854988b3a.4.1718482450885;
        Sat, 15 Jun 2024 13:14:10 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3bf40sm5036415b3a.111.2024.06.15.13.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 13:14:10 -0700 (PDT)
Date: Sun, 16 Jun 2024 01:44:07 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, ach.lumap@gmail.com, chriscool@tuxfamily.org, 
	git@vger.kernel.org, kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 2/3] t/: port helper/test-sha1.c to unit-tests/t-hash.c
Message-ID: <6fhpz4aqq7jr6ca2durig7e5a37g6ndzjjc2v46kjjkldohtja@tu7cdo4tu2r6>
References: <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240523235945.26833-1-shyamthakkar001@gmail.com>
 <20240523235945.26833-3-shyamthakkar001@gmail.com>
 <ZlCWcpcUkgUMWJYz@tanuki>
 <CAP8UFD1=yjZEZWvMYKq1RyY8fMSHze4XcLbCZMSFhCLBheaM+w@mail.gmail.com>
 <xmqqo78vnrba.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo78vnrba.fsf@gitster.g>

On Fri, 24 May 2024, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
> >> Can we refactor this test to stop doing that? E.g., would it work if we
> >> used git-hash-object(1) to check that SHA1DC does its thing? Then we
> >> could get rid of the helper altogether, as far as I understand.
> >
> > It could perhaps work if we used git-hash-object(1) instead of
> > `test-tool sha1` in t0013-sha1dc to check that SHA1DC does its thing,
> > but we could do that in a separate patch or patch series.
> 
> Yeah, I think such a plan to make preliminary refactoring as a
> separate series, and then have another series to get rid of
> "test-tool sha1" (and "test-tool sha256" as well?) on top of it
> would work well.

It seems that git-hash-object does not die (or give an error) when
providing t0013/shattered-1.pdf, and gives a different hash than the
one explicitly mentioned t0013-sha1dc.sh. I suppose it is silently
replacing the hash when it detects the collision. Is this an expected
behaviour?

Thanks.
