Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9EA50
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSdFdHXu"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADC49E
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 22:15:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40572aeb673so51189715e9.0
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 22:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697519729; x=1698124529; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=j05eYTFv/5gCsb3/NBdlDOh6ZC/+XBwfAQi4g8LwJ4Y=;
        b=VSdFdHXuvpWM4+fT4cnNqRpbbdq5XNOpeqPK3dY6CQjPPepkQOMFFZWysFLetx2oMA
         UetyS2MMEO5zpRUPkK7AnBsVvouIByBlvhEaNm4dCaANL/ieFkUSouD3FEVkFvvsV9zU
         quhxnDcjpLPsw1ATBWSc5gGpG7QHABQMV2+TIg/UZ8f6cLXZzX5eFzuPaQWcaPw83RfL
         biXvxJV0pJzqNk4lLGc6OykNS7UfpNIziGRUUX9EBReB1/TuvwuXqEqO1ggmAYlmkVED
         znKhqwzG/XSSGfFEq1lffhnh6+aFcCI/PDK/oUrx6Rr68xq8SV5QIgSWzKHnjq62H+PV
         B1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697519729; x=1698124529;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j05eYTFv/5gCsb3/NBdlDOh6ZC/+XBwfAQi4g8LwJ4Y=;
        b=vhwVTAJYMN+YHi4VmvYUyC6jH156TJ6lUagm6cRyOAtalI35K2DMSDqQkO9csGvohP
         w6gkouODrJr82wRVPJVCKH0xlp8a4zb50aO85ZwYRs2MoFh/vCsNdv1xrl2yEHg4Bm5z
         addIykeuFnEaK2RNPiFHuQZqrqMk9WgU60aSP2Lqi0k7RXR+nTIk0FOh+5LdJbccZhoR
         LWpGzEyXP8nhC0L4roLwm7seUC3b3viptXLGCV6uDY2dVuDstf0vz1kYhUKmjCT8rp18
         qkhEnlmRvayoFJgQL+9Vteubg7fFmnnJLuEqfmEAZk8tEZS94gPImfvF/aUtHv1GWnvM
         5fAA==
X-Gm-Message-State: AOJu0YxNwJ2ecpinZanvDEaF7IvdAUPZ1sq0v/+XzzXrKiWQLatGRHAH
	2mZ7jVhG8lAvbmHvk/qci+9zEsXbx5pZJXVcz2Hvt5Zdvhc=
X-Google-Smtp-Source: AGHT+IET7DRMEFu/TAchNfLf98mOg2sU0rqly/ewazlWgTYVYglIMLnvBX6sXlqnvjYePh94qpTvhhYcBCd5ka/KxnQ=
X-Received: by 2002:a5d:4842:0:b0:32d:a211:798a with SMTP id
 n2-20020a5d4842000000b0032da211798amr1031182wrs.6.1697519729321; Mon, 16 Oct
 2023 22:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jaydeep Das <jaydeepjd.8914@gmail.com>
Date: Tue, 17 Oct 2023 10:45:17 +0530
Message-ID: <CACaPSotRhyFZ-eBZ9KNKRUjLFHKo09P-Un+sitDXEktzmwuaxA@mail.gmail.com>
Subject: Proxy Flag for git-clone, push, pull
To: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

To make git work through proxy, we need to set the `http.proxy` config
or need to set `http_proxy` environment variable.

However wouldn't it be better if there was a flag in the command
itself (like npm) which
overrides whatever proxy is set. Something like

git clone --proxy "http://..." <url>
