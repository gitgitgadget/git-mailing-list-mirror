Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4008BF9
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 05:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC72A2
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 22:19:38 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-66d36b2a247so19368456d6.1
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 22:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697519978; x=1698124778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTVjQvZ0L1PnPC4rDSRX0QGkJdfAiMN8IAX985nnjB8=;
        b=mlscBYGqj0u7RYZiNGRgKT39BRQk6vLJEWp9tVAVOOAWZGV9WO1ZEppNh0F6Y9k2Xc
         8/jnC51kP79Ufrdt7cST/E7uZyw8fnrsXb4Ir8lxlO6dIuUl1R1Kv3gzQFekldvcHmHG
         jFLReEVhEQT5T9mV7+hVTo5tUqfDeTexBFb147ZvPIMYK5wNl4PeBs5d6v0+yATL8cq8
         4W2zUPxZW4nVaUUqUPEyBAjVu2PBLqQXyOgNPdWgN1FE2Ig45G5UD6ngYB4lY2tsPD1A
         4OO3EGOixteM9zcQQwZSby5pvxsvRaflCuzoMuqTSCZ7D6t7BL7R274Kf7A5CHoB4u0L
         Ne7Q==
X-Gm-Message-State: AOJu0YzcLJUW78Zvax4jjvW5VoquXaNdf1tkNdibzS6e80BeJUUYqHbb
	Oo8/wWpDMeoTedYe/cINpe/C0CXpGcYXnPWF0v8=
X-Google-Smtp-Source: AGHT+IHD9CaCLavuw4hh6AGpweUc5JNvYCsZyhdmEjgl1XgFf+4V06+HUwRU6yHnMhTiOuw2XQmqWqk2Ia+huom2bPQ=
X-Received: by 2002:a05:6214:21e3:b0:658:7f94:3978 with SMTP id
 p3-20020a05621421e300b006587f943978mr1601000qvj.13.1697519977880; Mon, 16 Oct
 2023 22:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACaPSotRhyFZ-eBZ9KNKRUjLFHKo09P-Un+sitDXEktzmwuaxA@mail.gmail.com>
In-Reply-To: <CACaPSotRhyFZ-eBZ9KNKRUjLFHKo09P-Un+sitDXEktzmwuaxA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 17 Oct 2023 01:19:26 -0400
Message-ID: <CAPig+cR8-s3bGCw6qF12Bcxuy4vB8Gh9H5jTb_r3pUu1LK35-g@mail.gmail.com>
Subject: Re: Proxy Flag for git-clone, push, pull
To: Jaydeep Das <jaydeepjd.8914@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 1:15=E2=80=AFAM Jaydeep Das <jaydeepjd.8914@gmail.c=
om> wrote:
> To make git work through proxy, we need to set the `http.proxy` config
> or need to set `http_proxy` environment variable.
>
> However wouldn't it be better if there was a flag in the command
> itself (like npm) which
> overrides whatever proxy is set. Something like
>
> git clone --proxy "http://..." <url>

The -c option allows you to specify configuration on the command-line, so:

    git -c http.proxy=3D"http://..." clone <url>

should do what you want.
