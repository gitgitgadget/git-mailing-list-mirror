Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523695680
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="QPcCcNKo"
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E174FBD
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 14:23:32 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c9bca1d96cso24527875ad.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698096212; x=1698701012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stIajVnPkKOUY3+74a1hnvW4RASOyAIKqQ316/rPEYA=;
        b=QPcCcNKopjAC7nE+iZHYE1UVQKezi8cJSRDvoIUqEZsBF4gAMOZvl+sj6d0rFEZS09
         TcaAu1IC6j7kThdxByr0wVkKSePl2w2U8ro28QYR+JS5/8bmrwZmb4rI1aJVvZtca8ih
         92hRk1XIrp2tYM3WEWczc+91ZzMTo/dV5y5VMTpR811YOYWqEMq5VW6XUYHNjpI4kweO
         rGapH7CSRfJRzKERUdwcPHVmhFKGTahtaMawaCIsx8vAIeIQYNdVnhOwTUvM25FVns+Z
         RfBIysOpLpIvyLj07bST6JTs1G6qgnnqsD3DgLCqC3zJWDf9YaVS9KY0128x8UZdh3ZA
         fRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698096212; x=1698701012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stIajVnPkKOUY3+74a1hnvW4RASOyAIKqQ316/rPEYA=;
        b=fi0zTBgmgV3il3pv0Lr3LfVUgnK+LkL8+8axu8jqij55bBDO+ZHFn5uYt08CDvEhQp
         jn2ZQCCqb8LWhJDu+iWfHtBUipWyHfRMmx3+stnpxpWRLxb2EMH68DiJCbL6iqtpCRLl
         n5BkUdQBSyx+2SpmO5e9+uURPqhzpFLIL62N/rFGbeV1DfTgTB1kWBpi46Z4BO3cUAQQ
         HfPgF+eBhTGHrxJlxFph3Tq7pRq/YkwrK3ZWFbXt+5RprDB4jRbSgBP6MFNDoMmDI513
         R9pQO5nVXdChUU5FDicF+5KGd4LDYuymYZKqsXEq+LXdhm+/LbWPfIthvfbRxGNYb0KJ
         9zfw==
X-Gm-Message-State: AOJu0Yw+FIPAfPFNCj4KhQTKTyyOYYAf05fOSLc9aBQQVCrUm4Q1BBQS
	Mm7A08IDXXPXfnV+rUUMdELdwbRJOqU2BaUQw68=
X-Google-Smtp-Source: AGHT+IH0ITJ+7nvmvA0VRMseaqxA0/e554HshG/4NlAHt54Swr2gwPTLZW//Xrw3qnGFCA6QX4CSpw==
X-Received: by 2002:a17:902:f945:b0:1c9:d667:4e4a with SMTP id kx5-20020a170902f94500b001c9d6674e4amr8427844plb.69.1698096212335;
        Mon, 23 Oct 2023 14:23:32 -0700 (PDT)
Received: from initialcommit.io (mobile-166-170-44-139.mycingular.net. [166.170.44.139])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b001c76fcccee8sm6397657plj.156.2023.10.23.14.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 14:23:31 -0700 (PDT)
Date: Mon, 23 Oct 2023 14:23:29 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTbkUUbmp56fgc+a.jacob@initialcommit.io>
References: <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
 <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
 <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
 <xmqqfs21noxx.fsf@gitster.g>
 <18c7b1bea07d5f3878f4466b8e133da1@manjaro.org>
 <ZTbb7bHkFOOyBT6+@ugly>
 <c8e437eacdb883f612ae44e43c95602f@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e437eacdb883f612ae44e43c95602f@manjaro.org>

On Mon, Oct 23, 2023 at 10:59:08PM +0200, Dragan Simic wrote:
> > On Mon, Oct 23, 2023 at 09:04:49PM +0200, Dragan Simic wrote:
> > > That's exactly why I already wrote that the original author of
> > > the table patches, if those would become accepted, should commit
> > > in advance to maintaining that as the new git feature.
> > > 
> > that's seems just a wee bit unfair (the bar isn't put that high for
> > other features), and it's not realistically enforcable anyway.
> 
> Well, it's a bit disruptive new feature, which is also quite extensive and
> can rather easily become obsolete if not maintained in the long run.
> Perhaps we should hear Jacob's thoughts about that as well.

I would love to work on implementing this and maintaining it! I spend
too much time doing Git things for no reason anyway so why not? :D

But... I could die at the hands of an angry user and then you would have
to take over, Dragan...
