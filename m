Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC84D517
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 03:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714446161; cv=none; b=tV9XzsY7gd3sgkVneVJHu48fTcXBYiSE1M/gM6FIJ63gzJ/9sJ1Qrbb+IVYg3GSVYB2i8pQxePNylJugQ7Cb8kJ9z2XttqBj55fFeTwc3qx/mJuTqry+YLV6XIBdndah0YwXfQfKbJWoVehjcdLiYLCGVSmDywMN73fCsuwwe78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714446161; c=relaxed/simple;
	bh=v2vwXMOCWm2TI/KNmFeADP6WlsQbHn5YR4qEXeL1wog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag2CyQZFvlbp7Km1DU6WVARUj4MJY0ygtc12RCa2mapVL5/ojBFV0e1EzvyBHLRAzX+7chl3dSZ4r4gCfqMoTb0KytIaXZieT1eNqb1YBaFCpFt1DPNsBVDIvZVZemrKl6jXekKpQRuD5DoYtfE5pd0rDW6XoCdVpeECLvyE/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cRUOKx1A; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRUOKx1A"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6ebc69b1e54so2356052a34.1
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714446159; x=1715050959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7YUO1ywaC4hgja7bD35cQlQ2grVsmrWzodMIjuoGhY=;
        b=cRUOKx1A91VpIvrcwXgV4LWObtehPQltWWt8zL09P5cP8f0ug1V+HXqWGyBTRrceHH
         MbiNm/6HTs9szkmRCHRSrixSbNIhiG65EoT3PLUUo3+fkJzQCgidZTP5jmTBh7HIcsWe
         9X3Tk17CbK4nntGCiVv0l6EC34cemfBwivkaS/BEWWqXt7cS0nxSSbRH44dA2sSzfaMj
         rMMtU6Z8bBv4gCep/sy5wDEY6s0mUD5eOWurVwV2supFuJRH/BPIIikX8C/fQ+BY4/zl
         fhSjDXaaTGk0EyoCXPdzyyRAKKSmu4ZhwqQBxA3gMqH/RpcU6s0XBtCxvelct7brKNVq
         WbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714446159; x=1715050959;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7YUO1ywaC4hgja7bD35cQlQ2grVsmrWzodMIjuoGhY=;
        b=eIZqTMk19Nnfg9pLAaffz2eQWwfgNhqzyeF4CX5KGydFr49UrZEdY6hnknLXbF+nH4
         ANECP3mL5og0i8Rv99AVUTCDBdTOGYKbEDhoItDZ/01Gr+cl8zgy1XamHo+DUKqZEP0t
         MMgvoEeF37usGDP6JislURk6JNYeopgsD6ZozuVp8dyFpGgnMI93xaCQMG0bhqo7O0Zy
         fWdOPT0eExsjrkloXfdNABEZyDvDCDGSqh/sRBHJAve2oJt6rCD4oeigMkubJuc+7xoL
         MBYommMUZ8FYyOcTNzzFqZk0t4mIatAIkPIvg/RI1EoSA2luNlSPyDI31o+TuYDLibT1
         QaSg==
X-Gm-Message-State: AOJu0YwfQ4zn5LEbRJcxrS97WdghZbiwdUqL+U0gwB+Y/AsbI5xAo+8J
	ofzvqkaA5DTqX0BOvTsGIjST2UWzqJARzwdHyl/ravje79yZFk89TbMhIyDg
X-Google-Smtp-Source: AGHT+IEHnXquCuKzInGxCs4b7t0CztV2A8u8yy0piM6XBsnzuzLz5R14RQh4xLbXPmnyBsD4i4JM2Q==
X-Received: by 2002:a05:6870:64a0:b0:235:44b3:8e57 with SMTP id cz32-20020a05687064a000b0023544b38e57mr692584oab.23.1714446158915;
        Mon, 29 Apr 2024 20:02:38 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id qt7-20020a0568706e0700b002376b807200sm5265269oab.5.2024.04.29.20.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 20:02:30 -0700 (PDT)
Date: Mon, 29 Apr 2024 22:01:15 -0500
From: Justin Tobler <jltobler@gmail.com>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/2] gitlab-ci: add whitespace error check
Message-ID: <5p5ot4juki7v2lycups4jhadxcw5yzpqtjkwgxzwrlrpu6mlmt@gis6xmwjjh6o>
Mail-Followup-To: James Liu <james@jamesliu.io>, git@vger.kernel.org
References: <20240430003323.6210-1-jltobler@gmail.com>
 <20240430003323.6210-3-jltobler@gmail.com>
 <D0X33QRECNTC.33V5ZK9NYIE1F@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0X33QRECNTC.33V5ZK9NYIE1F@jamesliu.io>

On 24/04/30 11:59AM, James Liu wrote:
> Thanks for putting this together, Justin!
> 
> > +check-whitespace:
> > +  image: ubuntu:latest
> 
> I wonder if we should pin to `ubuntu:22.04` and only update this for
> each LTS release. It seems like we've done this for the
> `static-analysis` job above.

I'm not sure if it particually matters. I know Patrick recently
submitted the following also using `ubuntu:latest`:
https://lore.kernel.org/git/01fb94999f8e2014ba4d09ce7451a4f5d315ee72.1714371146.git.ps@pks.im/#r

I can change it though if there is strong opinion one way or the other.

> 
> > +  before_script:
> > +    - ./ci/install-docker-dependencies.sh
> > +  script:
> > +    - ./ci/check-whitespace.sh $CI_MERGE_REQUEST_TARGET_BRANCH_SHA
> > +  rules:
> > +    - if: $CI_PIPELINE_SOURCE == 'merge_request_event'
> > diff --git a/ci/check-whitespace.sh b/ci/check-whitespace.sh
> > new file mode 100755
> > index 0000000000..1cad2d7374
> > --- /dev/null
> > +++ b/ci/check-whitespace.sh
> > @@ -0,0 +1,16 @@
> > +#! /bin/sh
> 
> nit: there seems to be extra whitespace after the shebang :D
> 
Whoops... I'll address this in a subsequent version.

-Justin
