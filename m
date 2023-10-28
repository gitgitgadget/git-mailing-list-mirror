Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E047F9D6
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 18:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="BaXH196w"
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28E4CE
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 11:05:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so2747721b3a.1
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698516348; x=1699121148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tMLa/nQN+T7sh8oK691X7FQk+Q7X0Wagopx3C5zTzEg=;
        b=BaXH196wOM35u2+9ACrHSUoKk29fKo4CU98EU8A5ZB6XlV2KcBmH263w+L3usD7DQs
         oQig58FTXHpLOG7V0XZ81+BznLFxgdeR0Yea0g0Eu3AtYSRUYFJhnY7WsQbbpgi5M49B
         KlsNIElAuQV4FwlmST1ThkFtYI/n4xKV5YX6yx3XFiCXgkk3Ho1iY42eXTKwX2R4/u03
         4P1QIQXOA0H/yklduXx48QCMTqQGT7Vt2G4+fXJOfSEe7AXAVFDB4dL8dbaHXpyLhBRB
         0MT3ctinVinRNulb+flttFkFKuLRG3qSaX4nSXzRd7vAYzwHIa/CowmA1WQhFpfPYREn
         sqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698516348; x=1699121148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMLa/nQN+T7sh8oK691X7FQk+Q7X0Wagopx3C5zTzEg=;
        b=YfmUzMCQgk5XByYfu7+WBe+dHKFVHK1Pb2kIhbji+Ih7RkzaR3CSOVxjwK0wJhkZy7
         Q3o4ymc65eHQ8hVhDTV7+dQSUiLptfr3W3mPSUo5UphxYhBkcFZjOE023ZDlOkk6Zw1J
         g36CaNVCegPDVRchRVrBHzOXLg70GHsETGX/OqxsjrSt2oIyxxFmvpR+iHztee0ddhdT
         b2kCFt1uzsKHSQMaKXQZNvWM3BhxQkn2MygH8OHgsdicyxp8JSu1t1LKb6OagZ5YGF3k
         p/TWob8pFgGOwfIxNl+k327zJ9wFSBfUaRjLvOtlFLt/odPIOvuapAeiLNiHssHTacvy
         KLHQ==
X-Gm-Message-State: AOJu0Yy7jyrbcGeTnmyrjy440g0dFFuepNv8lbGO+C5xhSXItAdvle3Q
	cMyV5R7s1zNrUZs17uN9fnERRV+Nq8x98CZEMPs=
X-Google-Smtp-Source: AGHT+IEbGhe0+Zb28eDhTdeoOxIViaX/34erhgEeU4YEzFyAkEn+WLO8FrfYg/CBwM/dY5t3ihye6g==
X-Received: by 2002:a05:6a00:9a6:b0:6be:18a9:8f60 with SMTP id u38-20020a056a0009a600b006be18a98f60mr6846844pfg.16.1698516348190;
        Sat, 28 Oct 2023 11:05:48 -0700 (PDT)
Received: from initialcommit.io (ip68-7-58-180.sd.sd.cox.net. [68.7.58.180])
        by smtp.gmail.com with ESMTPSA id v1-20020aa78501000000b006c031c6c200sm3223936pfn.88.2023.10.28.11.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Oct 2023 11:05:47 -0700 (PDT)
Date: Sat, 28 Oct 2023 11:05:45 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [RFC PATCH v2 0/6] Noobify format for status, add, restore
Message-ID: <ZT1NeRSSUA9r0KdG.jacob@initialcommit.io>
References: <20231026224615.675172-1-jacob@initialcommit.io>
 <ca47d328c280e4b4c13bfa6dd9958a57@manjaro.org>
 <ZTvvz6/GFdwagVa+.jacob@initialcommit.io>
 <9b93115810ca269c87ec08f72fdc9c12@manjaro.org>
 <ZTx3fIGpdGl4JpaV.jacob@initialcommit.io>
 <2a0ba4c8e96cb7d2ea66dd1e78cdd39c@manjaro.org>
 <ZT0m68HWZS/tDGtH.jacob@initialcommit.io>
 <37e7bd8f6f4b75aa3b31dc98804b1334@manjaro.org>
 <ZT1GWw886XuXwqlw.jacob@initialcommit.io>
 <fd54ef08fa676ec12ad6835f0122c4c0@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd54ef08fa676ec12ad6835f0122c4c0@manjaro.org>

On Sat, Oct 28, 2023 at 07:41:47PM +0200, Dragan Simic wrote:
> That's something we can keep thinking about, until we find a good solution.
> Also, a detailed review of the current logic behind displaying the hints
> should be performed first, if you agree.

Yes of course.

> > Yes I agree, that sounds great! Maybe I'll just wait then until seeing
> > your implementation of that before I poke around on mine more. Then I'll
> > apply your patches locally to add my extended option.
> 
> Great, thanks.  I'll start working on the patches tomorrow or so, and I'll
> get back with any important conclusions or open questions arising from that,
> so we can discuss them further.

:)
