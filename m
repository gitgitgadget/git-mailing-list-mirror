Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CC31DDE7
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjuupXOK"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BED387C
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 09:51:24 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc3216b2a1so9829105ad.2
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 09:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699552283; x=1700157083; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kEvL5j8L3tvLCixDBo0o2hxqn+hJfQjZd1YQqRC9jVQ=;
        b=vjuupXOKujU6UjiD4TewVzkPONz8yyoU4Cw7dwlKBJqXq7ivTo1014vuvetQ+Bo5UA
         T7jSeIQpxrFMqnVt9Qu9egDy8iDJgO9E9Kjg5/S6GE1j5TFjBQHEVyPuJK4WaIBxvbW9
         GZcg34HCkAFpiX/b9+eKLVdTURlBMknPPf2m5DAsLkI91HxhoL3PtxZ1o+DGrZTvfywH
         mVuwbNVoGPQHcamCgdOAgvCVCgbomflagxuffYHJtT/7mCBA9ZOS57yN7go9fFn0wSmV
         sURTA5+7wIjPurHnN0B/x3tXZjM10hEUUbF6IStSHcDo6XxD+sVTdBIsZbQY4AkmgvP/
         YBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699552283; x=1700157083;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEvL5j8L3tvLCixDBo0o2hxqn+hJfQjZd1YQqRC9jVQ=;
        b=rR0X5J7OpBSpRp+7X4ojQfx66gWERJ+mJ/qMYLiA+7AmA1V0yLl8LpS/zjXwuhuOAY
         rp3uNcw4InPbFzJz+Oalo/P5B29fiShyoQEYFbjdIGASVRXpjpBy5GNPsaMfOoBURFUt
         3vj4p4acj0vGpf9ZcVwm8T1TLDcK9BarqAC/XhgdVSTZJ10psf7ykFayMfChW4LImTUi
         Jd7nyv9ImZG2x+hRRDD9NhzY+kRIp7mEXa3XeoclH3jIpm39BiJyhc5lK+4k1q+oB8u/
         oRfe3sq9+soK0V1iFdmz6NbIBe5dv1MA5zZWsjsmX3PHu8ZWLlEaXC+L0nw+X+76qIct
         5GIQ==
X-Gm-Message-State: AOJu0Yw5fIt0YNNYB4YXfW5DaUXw2VCSyD8/LjL12VPqNI9tJXEFJSKA
	I/1YWM14w+tynduFTT8aE4DYsA==
X-Google-Smtp-Source: AGHT+IHun2/UdoE9nJbUBjLnthuJbo++Xv9snt611zbvWZivXTaF6cHOxgKBiZL9fHQChEaLEsAuQw==
X-Received: by 2002:a17:902:ea07:b0:1cc:50ed:4931 with SMTP id s7-20020a170902ea0700b001cc50ed4931mr6703819plg.16.1699552283351;
        Thu, 09 Nov 2023 09:51:23 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:5c8e:97b9:4fad:1ea4])
        by smtp.gmail.com with ESMTPSA id b7-20020a170903228700b001bc18e579aesm3805263plh.101.2023.11.09.09.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:51:22 -0800 (PST)
Date: Thu, 9 Nov 2023 09:51:16 -0800
From: Josh Steadmon <steadmon@google.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v9 2/3] unit tests: add TAP unit test framework
Message-ID: <ZU0cFK1lrBdXpHug@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1698881249.git.steadmon@google.com>
 <8b831f4937a167519b77c724fcbc36884bbfe43d.1698881249.git.steadmon@google.com>
 <CAP8UFD3SVnu+HFQhFpsF4PA6pK5B5L+aP-jxRX=Ro3EYekS0kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD3SVnu+HFQhFpsF4PA6pK5B5L+aP-jxRX=Ro3EYekS0kg@mail.gmail.com>

On 2023.11.03 22:54, Christian Couder wrote:
> On Thu, Nov 2, 2023 at 12:31 AM Josh Steadmon <steadmon@google.com> wrote:
> >
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> > +int test_assert(const char *location, const char *check, int ok)
> > +{
> > +       assert(ctx.running);
> > +
> > +       if (ctx.result == RESULT_SKIP) {
> > +               test_msg("skipping check '%s' at %s", check, location);
> > +               return 1;
> > +       } else if (!ctx.todo) {
> 
> I suggested removing the "else" and moving the "if (!ctx.todo) {" to
> its own line in the previous round and thought you agreed with that,
> but maybe it fell through the cracks somehow.
> 
> Anyway I think this is a minor nit, and the series looks good to me.

Ahh, sorry about that, I must have accidentally dropped a fixup patch at
some point. I'll correct that and send v10 soon.
