Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B518215770
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 23:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513657; cv=none; b=AmRuXeka3+YIsOgBbtjbMJM12oUkyAKEMUTlPaEkhUgZog8YslNnCsvAuJQ5ONUq2PO4cCUkSaAev/RkDTRI0H1EhpQufYIgQhnvuLi5j54qz/8D2fwGpEqCqjsmXFuQG2uzSyO9oEKyfucp3/y6LFotqc9jU2IeHQy4pblyJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513657; c=relaxed/simple;
	bh=JBeVLjDyYqdor9lg5oA+Jvblnidt/qcYC17VJLfnixA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGksrAFtpRiH3q7gqWSzsCLdLoOR/qi67Ahg6AuR2PKzhG5vsk/K/KnsZEgkEk3+WUOtyUfQ3log5mIuHv8r9MV2VumGd3CI/o4Jt22m6IF7dmyUi6vXhNVB/YKMsbB56sI2R24ZTD3zqoF3B0QLmxbsnA/Nvr6gN2B/oaWSrvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwxO5eES; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwxO5eES"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2c6f27599abso353283fac.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 16:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513655; x=1743118455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xpefBbqPFFGHNPgFor7WAYi64RPGZnQqFpknvL9t60M=;
        b=fwxO5eESqz3biexQYrRa8VMqrrVrKF0h1No8e5awQ2dY8nZOP/aL8NWcqX6112oolj
         fmYsyIXvujtm46MhAHxyR+pbybxA/PzDiQ/sr5bIZwQNTOqad9VM3PokYoh/YMViYmAX
         WhoyJ3hxmdV1pXJNua1Q7NnY9cf7fm0sq5VuZK0GdK0E5wBBPjw6u9cGSDZkO8ii+AEW
         PQP9DVFX6lM14uFG35buPKoZemYHh5lwHLq0cxVJRN+0RYme6qQRmpP7PLEw4PiKweRQ
         DinYvPEU78ZeDDZbQzGx95rR7Wld747oClKXsoTSKuEEUqh6mAafouS627kQqC6ORFUA
         2QXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513655; x=1743118455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpefBbqPFFGHNPgFor7WAYi64RPGZnQqFpknvL9t60M=;
        b=eV2LPGiv730QVKeYBfU4tJZhVMjXbzf21X30e46t9CLrnfv1lJwKkDjXHfk9H5Zqyq
         pg3d/v17unxFp/nClHMDANLo3bGXuzE6uks6z35RAGn8QP0oYvlDWlTkluFNG65qPDkI
         eDy/lR/InGRKl8QbLoZ3VRwwsmrirthRf4fQLLZyhK/aSQYp3oR0Fw5ljq70wtMefD+H
         mHbIBm9AGld6SiKJtqC/HREscR0ok59t9gxrZFGRA2z+ckpQRt6hwrdeIIonzahl8X3h
         zEWcS3UopSC/3mSosEXCHGE/ulmtZfO/iYXOiz8bIkN7pwEHLGfbMLdhyS0YDEHiEysw
         XPmA==
X-Gm-Message-State: AOJu0YxNlk6cnr2vm6VID5UPe1CRQpgoygC+rpEniHN1+yoh5I8L7XOj
	j+tT1eKGPWWBshOt9tcs8TIlU9LKMy06D4CRUIn9wtnC/RyDB4DYiS+9NA==
X-Gm-Gg: ASbGncvxzWyJ/PHFQvWhJ0nh1MdfWV15HhWfWnl1OsHTr2UYjNDzxpnBvVCBklxkUpc
	hdkrXViueheBjH8QZda6Yi2R8GteIvbETtAMT9iQRcVRwv5eHibcZpmf3+UFkEnQyNVJKvnWs94
	tiDz8d8ayLBBA7fqJzI3aYCPVKhnuS2hjpEmY2agZsp4WKOSZjM/Uj0a4oSL+XgGqap4iO3zSbv
	ZN6tzl8f8faO6KJdOlB5bwSkvlDZCchaIGwyjvMd2n5HaQkfzPYMseWO57PSUjcDinhnwB7T9m7
	JdAAfzNNo8wpgD0IFVEmRKYtyRGDDRTp6iJ7ljvTJIh6tpAx
X-Google-Smtp-Source: AGHT+IEBHJxxLMVmCOnXuEWBadYO2jnzpkzXadNHsRqMe1KliBEvw35L5Y8YmiDETLrilMRF3vwHKg==
X-Received: by 2002:a05:6870:2150:b0:29e:671b:6003 with SMTP id 586e51a60fabf-2c78055e5b0mr970513fac.32.1742513654947;
        Thu, 20 Mar 2025 16:34:14 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c77f0f3fbcsm191551fac.49.2025.03.20.16.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:34:14 -0700 (PDT)
Date: Thu, 20 Mar 2025 18:30:39 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] remote: allow `guess_remote_head()` to suppress
 advice
Message-ID: <rbuwquadvjmqbyhbikmupwd53xt6dpu6rpv6oyso2pscihddzw@eoovi3vqkzud>
References: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
 <20250320014646.2899791-1-jltobler@gmail.com>
 <20250320014646.2899791-2-jltobler@gmail.com>
 <Z9ukDuvsLXhYTQAP@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9ukDuvsLXhYTQAP@pks.im>

On 25/03/20 06:13AM, Patrick Steinhardt wrote:
> On Wed, Mar 19, 2025 at 08:46:45PM -0500, Justin Tobler wrote:
> > diff --git a/remote.h b/remote.h
> > index 6be5031f64..49c7b644bb 100644
> > --- a/remote.h
> > +++ b/remote.h
> > @@ -395,7 +395,7 @@ struct ref *get_local_heads(void);
> >   */
> >  struct ref *guess_remote_head(const struct ref *head,
> >  			      const struct ref *refs,
> > -			      int all);
> > +			      int all, int quiet);
> 
> I think instead of introducing another boolean parameter it would be
> preferable to have a preparatory commit that turns `all` into `flags`.

That makes sense. I'll adapt the next version accordingly.

Thanks,
-Justin
