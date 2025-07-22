Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340E27E076
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753220306; cv=none; b=POH4uV8cySkNW3jYNSHHgFrn9sF2Aqhozof/L4urXU7dkewu48sLlHBgxhYkgmY8PkIdsE6YIHCjSHhjAAvRk7dg10TCxJYdayJImKTfx9qRHX3dRK3CVeUt66YqVL7ZielLa5+41Aew+dreUE8KADeraW5eqbS4n4zC9puZtKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753220306; c=relaxed/simple;
	bh=Sqne1PPgApyNiAR655o2eCLyjUm/2ivjdjiy5kk2Ks0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A26CEK/QkvKA29jjEmfvd/TWbYFqnPAKjhe4Kj6IXzGB2XFyJDrdHPY7pQlNVcdch5ADDDm1XPwuGeUfF3T/Ue+cE2CtZvHoUnj7KE+emvOcI6Tupve5lifb2ws204JKdhqvpRKjaySdH6bjm+ZmYE4iIFYt/Q6bMX6TMzoxqXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vv38RB0v; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv38RB0v"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-615ed9a4f38so851860eaf.0
        for <git@vger.kernel.org>; Tue, 22 Jul 2025 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753220304; x=1753825104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=icc6mUxHTjbOx+c4zMa8BihVgg1hDIlzqnnDEjBwfCk=;
        b=Vv38RB0vHtqGyqhi6HSDgk5xDFPAqOre2bCBzYuKA8bZQI1FumUeiwb6rNUHER6B41
         WqFB4TRtTUX5llCh0pBNktr/3QPJEsMUx57tpZt14YaQM9y91zo5D5Tq9OcEkj+9y8J6
         E2O098wpSIa4GqchllYXly+MJGzDI0/XCEmGEYMb1Ya4vaghfDRRQGIE7j4Vhrr+k0ru
         9CTQWMmzzBW1JZToGJsJbfO17RdnmIk7onofiCPNTfjtrpMpAtpiAamr8/i9nUwsBq9F
         KbG62QkIJJ6oIWI47cYMGgXjOdye/B4oJx1kH94S31WLdMrcd9aY1S2UqPMyq+lvglcg
         kd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753220304; x=1753825104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icc6mUxHTjbOx+c4zMa8BihVgg1hDIlzqnnDEjBwfCk=;
        b=I5ec9yX2o8ZdJhDz0tOSBJk+3biNND3K2JQbIJ+CgPkQBCWcw2UbKJ8ILOy3Jn5MNR
         QbDmBFWwWFAfbEbTMGhidahJ406eFHIxrB8My788Dy3XUTTdMdyojZ4ZZ6M5HKEUv7c5
         uYhlD8f2VVnKn+6/J+SlNyh3Iikzs16koXFJ12w1IJjkNZ9xLKf8ErJGwPv81mARaKBE
         I1WvVsY+TjEykfXhfCNycTVrs/pJUriivAZeRoj74Hs6/1AsEi8uZzySfkwk7WxBbmOu
         30nm1qxn3064+3FXTy9Si7iS1QlDs+dgysqfow1dnxWKY3e9SmAVNsMl0TyJ/3ZkPnjq
         FZnw==
X-Gm-Message-State: AOJu0YzfGPedXXT07Wh/V2vgzki89G7lrZcQWfAcEC7OlYlYwNB6jZu5
	MU16Y0ZPF/hZNC2KLEwvgIxZh2+Xs8SOI0vEHCu1BImaOKmIKoQLY0Y+ATdjMA==
X-Gm-Gg: ASbGncuZmOiJrYR1esvG89o9wyAHh79tIU5CjsCAoUQJbxTcyhYQmS3xFRa4MEkNaNI
	UpJcnM4gE4NGXip/D2TXewnsj1vmHD0PZAjtA91L4zwlE5vX37mVYqbdFyco3OcYRfORrDqJgVL
	phgoaq3Mp//YEEERWfN+5OQmKeduB9TGayGpxhRUKneoFykxJrAqGgaf62k3Emdgyl3TYBlbB4J
	3pfsvdc7X4tOFXASC9Wbn2d+A9yUZKyLqBwFJ8CNJBUYFbg2lZf9rZd724EX9nt8JUHRfl9Knw1
	1To2v3CzziL2IcBVqcqa+libEtawXQz8KRsFiUMNSfrUQkV4H5XBo+cRK7r+ieqO5dvQqmkewrF
	sdYOknk+sqflxdJw=
X-Google-Smtp-Source: AGHT+IGBU3P6vMwf7rJjo4vMzoIxZ8sNRXkCaT7dKfJQFuXJhbft7OHBbSg0PlGIN97ImzM8CAK5fg==
X-Received: by 2002:a05:6820:211:b0:615:7f6b:2ccc with SMTP id 006d021491bc7-6186e90d039mr426575eaf.3.1753220303771;
        Tue, 22 Jul 2025 14:38:23 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-615bcdbbcdfsm2246656eaf.31.2025.07.22.14.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:38:23 -0700 (PDT)
Date: Tue, 22 Jul 2025 16:32:34 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 0/2] builtin: unmark git-switch and git-restore as
 experimental
Message-ID: <g23v5k2m4pcqeyralbxnuop5s4qlrg3j6bjecwxaatuigneaej@mqsijwz6qp7d>
References: <20250722180818.1043014-1-jltobler@gmail.com>
 <xmqqldogrn64.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldogrn64.fsf@gitster.g>

On 25/07/22 01:22PM, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > Greetings,
> >
> > In 4e43b7ff (Declare both git-switch and git-restore experimental,
> > 2019-04-25), the newly introduced git-switch(1) and git-restore(1)
> > commands were marked as experimental. This was done to provide time to
> > make breaking changes to the interface. It has now been over six years
> > since these commands were implemented and, over this time, there has not
> > been much change that would warrant these commands being labeled as
> > experimental.
> 
> Do you mean "as not experimental anymore", don't you?

Apoligies, the wording on my part is a bit poor. Your understanding is
correct.

> We were
> hoping that we would come up with vast UI improvements, that are so
> much better that warrant departure from the past, allowing us room
> to even break the backward compatibility.  Unfortunately, we do not
> have much to show after 5 years.  But ...
> 
> > At this point, it seems rather difficult to justify changing
> > `-c/--create` to something different as it has been that way for a long
> > time and is used frequently.
> 
> ... yeah, people grew to rely on that experimental UI that we added,
> with intention to revamp and replace with much better alternative,
> and now it is too late to change it.
> 
> > By removing the experimental marker, we help clarify the stability and
> > maturity of these commands.
> 
> So, even though I may agree with the conclusion that we no longer
> would allow ourselves to break backward compatibility for these two
> commands, I doubt that it is stability and maturity to celebrate
> about.  It (not the "have two speparate commands" part, but "leave
> ourselves room to improve these two commands" part) was a clearly
> failed experiment.

That's fair. The wording should probably be toned down here. My intent
is really just to indicate that users will likely be more inclined to
use these commands if they are not marked as experimental.

Thanks for the review. I'll give it some time to collect for feedback
and then submit a follow up version. 

-Justin
