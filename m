Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4823B7BB
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dl5tFIVb"
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B6CA9
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 13:46:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso4195a12.0
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697143585; x=1697748385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLYuX+CID4UyHzjwHh34GB13OQDZ5eKzjp3x9r7PTSY=;
        b=dl5tFIVbv7tP2pQjN6+Nkd23u/eQoivos+r/D8dwRNZkLHSOwfYb61vxt6qK1Y2wtB
         uSZfM/bdJemXDYCf+ZAzO2dN7ve0fZ4PdEnPzitjEAro/w+GbHqZNEx9MQBQwLicohLR
         YTkFEn0diQesyqBPjntNWN1sBeXiRpzPYPjbVnsxKqEgFBqaDKeHuginYkycvTxArIFy
         xBKmE2/WavgMZDjQcMpKgGEutg7eRH5UB8OvseL/ZGlPqinkomRq9zZ7KjZplzc0szIV
         b515FzSCs1fL/go8Be/t29CNYJABYOBxiw04BtyvNpY+mxwS0iKCll81eYbpWCQXZEvo
         cVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697143585; x=1697748385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zLYuX+CID4UyHzjwHh34GB13OQDZ5eKzjp3x9r7PTSY=;
        b=PLVbCG64YdepftTMsuw7Z5DxjUUFJwAsjhY1BiEdNt/A87a+ZaUXSwD16ZMQWL8Lsl
         HX/bjEsqJ4MGJO9+9IkYRX216bMkrJ9+l4pxRdP3gucsKoFJdchNBEL1wwqLW0rp4n5L
         tzDWah1dMLfBe/awOlWOi7s4SF9YWEcN3b9dOiJaTrksmmG4zUaG8Dc7xGJaaDX6yp6c
         DOJ3kOh39hyt7VvGWiHLzz+B7xgAIIL5ooNxNK73z47um/MxdpS7+X4My2TXjdX7aGeN
         HQS0/gpmxow1HrxbD84HSGnf6GM6vp6fYahjawtCrdb9vUu0iTXRho558AOJweQw7F4K
         EQYQ==
X-Gm-Message-State: AOJu0YyOfMgOo9fdypiMC2U7meZK5nTcNVHOcROChLce3/2UF5iW6H7R
	TKMymYh3P42dKH5KOASBSpjh0FF/J5eVRLJs/vRuzwzzo6ErJHntpm/bYw==
X-Google-Smtp-Source: AGHT+IEN+eoYK5t9MgMoVtyaGhPUydNV8XRDyeJNob32E4yP/ja2R2s8nId73qmyeysHdemoVoRAZH5Kcbqco4j2hG4=
X-Received: by 2002:a50:d602:0:b0:525:573c:643b with SMTP id
 x2-20020a50d602000000b00525573c643bmr1288edi.7.1697143584935; Thu, 12 Oct
 2023 13:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012185308.GB6241@kitsune.suse.cz>
In-Reply-To: <20231012185308.GB6241@kitsune.suse.cz>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 12 Oct 2023 13:46:09 -0700
Message-ID: <CAJoAoZ=MrjjfH6Noganejey0bAaB=d+jH_rXAqbscPG8E0m3Pw@mail.gmail.com>
Subject: Re: -q option for git to suppress informational messages?
To: =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 11:53=E2=80=AFAM Michal Such=C3=A1nek <msuchanek@su=
se.de> wrote:
>
> Hello,
>
> when using git in scripts I find that many git commands insist on
> printing informational messages, and the only way to avoid this is to
> sent the output to /dev/null.

Michal, you might want to investigate further whether there is a
plumbing-specific command that meets the needs you're concerned about
instead. Those commands will not have additional human-facing output,
and have a stronger guarantee around backwards-compatibility than the
human-facing commands do.

Commands which count as "plumbing" can be located in `git help git` in
the full list of subcommands; if you're not sure what alternative to
use, I think you can feel free to describe what you're trying to do
here and get advice on which plumbing commands to use instead of
porcelain ones.

>
> While some select commands support the -q option to suppres
> informational messages many don't.
>
> Since there was recenly some discussion of problems that newcomers could
> work on I suppose this could be added to the list if not there already.
>
> Thanks
>
> Michal
