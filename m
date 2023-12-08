Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nIy3pvpY"
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED22AC
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 14:50:17 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3b9e1a3e3f0so1342256b6e.1
        for <git@vger.kernel.org>; Fri, 08 Dec 2023 14:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1702075817; x=1702680617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IedD90TL4dAiVnjZXChY5K/dL77qr5ky8tSlqXzQUSQ=;
        b=nIy3pvpYDDLN9eW6JSee3wpWhjA6E5ddmMbveTH42r8Jje2X45wgd1xD5yTLk3PJ1m
         uK4xdf4TdVT8qQvTTsJn9afpqd20POuqH9gWFIcLfUzN12vzta0gF2gbRQ0+jNLli5Oi
         Z0+8NXwnS2QGxKMqjN1aLerKIIr52K4x6/6AZ57tiWXjK9FaEQwitrNSgjHG96h8UMFU
         Iis9vi1u5CkZZPQHFMHFYmIDENyenu0fi7Lx1BYBSUyS8wp+vaDjjLGNY4DH1mCaLt9d
         HGQCZwQqTXWfefhwQL6Tc7cvRhaPYD9Bz4qBKIii5VwwjkJ+KkwkEyVlvHsBMzH7UgqL
         UexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702075817; x=1702680617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IedD90TL4dAiVnjZXChY5K/dL77qr5ky8tSlqXzQUSQ=;
        b=rqxIGRprKxhATxGSMuJ3jW+aPVYx3FUvpy+CbRaxuQnesdDz2DJKr1F9bDG564NgVT
         0QgpuiyxHeU2IPevvTAJL3mGWqkbup+AQczT5al6PMTiroqL8WzEvIplV6L78RxKoCoC
         iJBO9730Ga8mgjO+Amr8QqkOico6GTA1hRPSDNXoBjamyjnYcJk6vUIOELNccz7gr6qM
         TN4uG67HySxWRAW49pq5sj8ItpLqSdrhv1ZNLSvunAyWb6uznpBKCYZcGGut/s7Pu6Kc
         4/jFz6JavU5TS9sYaFGbjvenj8LyG/6xd3sWb3cQ+4ZHuXqZwRoMqXhpPoe0sM99FCVd
         wXIw==
X-Gm-Message-State: AOJu0YwNh0zOxpYvU5sQq8PwxWaaKyzLT7bdsWG3M+N4jVy639lL3hmq
	Q9JVlbAtCeVH+0I+GV2xYMH2y3gH1OZvIRaiabA=
X-Google-Smtp-Source: AGHT+IHTFesdDnnrhyiDzrfms/I61DTtlhiK3aJhivA4dMsD7gaID0mnS1xK3Nro6NDYaxHaixGhxg==
X-Received: by 2002:a05:6808:1817:b0:3b9:f016:fb89 with SMTP id bh23-20020a056808181700b003b9f016fb89mr942240oib.53.1702075816937;
        Fri, 08 Dec 2023 14:50:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o1-20020a05620a228100b00775bb02893esm1008235qkh.96.2023.12.08.14.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 14:50:16 -0800 (PST)
Date: Fri, 8 Dec 2023 17:50:15 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/9] config: reject bogus values for core.checkstat
Message-ID: <ZXOdp+uHCe+Daz4O@nand.local>
References: <20231207072338.GA1277727@coredump.intra.peff.net>
 <20231207072404.GA1277973@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231207072404.GA1277973@coredump.intra.peff.net>

On Thu, Dec 07, 2023 at 02:24:04AM -0500, Jeff King wrote:
> If you feed nonsense config like:
>
>   git -c core.checkstat=foobar status
>
> we'll silently ignore the unknown value, rather than reporting an error.
> This goes all the way back to c08e4d5b5c (Enable minimal stat checking,
> 2013-01-22).
>
> Detecting and complaining now is technically a backwards-incompatible
> change, but I don't think anybody has any reason to use an invalid value
> here. There are no historical values we'd want to allow for backwards
> compatibility or anything like that. We are better off loudly telling
> the user that their config may not be doing what they expect.

I think this is a good instance of "yes, this is a backwards
incompatible change, but the behavior we're breaking is so obviously
broken already that it's not worth maintaining compatibility."

Well reasoned, I am definitely in favor here.

Thanks,
Taylor
