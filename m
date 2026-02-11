Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9E017B505
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811522; cv=pass; b=Gv8a0uCO+s65QV9LYhoPGtPmWz889ZsVsjOzvf7yGx3peIwvS9iOKJV9Vm3syW2ANmdfQ1O6hXuxQelHHgDK6RfhxGIf3KCRlUhnNpgXE1S4zx0MXYRQEDgDZlBvYKe9rBWwCbkKqeHy9vlv8Wci5Xz7BEAV1X+I3zzJaJHkoFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811522; c=relaxed/simple;
	bh=k1QPA9IurVwTa4lNr78Yi2twut+rm90NscoTslxrF/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tx/FEoX47fZB37/NQzvzfyEww76wKP/YuFvgIzPf4GKq6TkuBNH2DQb7ee0M3SaTGJ+uXQcG4EISLAKQTq3NO0csfEtlMjurzgP2IEYSBPBozYfkwf7QCcoteomeEq/u9gwxpgMjdoEwm/lNaB6+msMgvUQi19dP5n6hm2KURkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYaDxQ0D; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYaDxQ0D"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-126ea4e9694so1859137c88.1
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 04:05:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770811520; cv=none;
        d=google.com; s=arc-20240605;
        b=ABvZ8nFxs+UFop+Rwrn5ssoHvswvVkueHJNIVU/b+ctEr7FXkaOTW8jxhQlvd3pDcy
         z99bksHrj1p9QUvLqwGZO1dYTI2dpvwJhjEOIxNwzmjhzbiBwfkp9SU9tYmVTVPqIBVy
         z9B2ni8iDJcumn9OSQ1EeTHlTDpzxRtyEdRS87jiGFn1XD2X/PvITBTSgu9amfyZ2WHv
         t0WZeso7cXiBAa+DpM8/olONQVN4nfw1rC38qm5VhKJGYCKJLHKxxIHRO5eiqLoexAUb
         al7D8IgzWPWBg1iCVL5UhwiPuN9fCQjpv98us+po1cwgO0mEmIsyhmYiYsn7l7wmqpW3
         b56g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hnNC8eWrNYk7+G0IoxWoChhKJ9fxKWOeQZE4/O+rBqI=;
        fh=0F7rZ5biRIsIZUxT/HtoudgO+XAjDec7F3Ug+t/k2xI=;
        b=isB6W3b4JpYu5jhBITDOhplHMlxhntq95oOTSYBB/IFs0nzBr98YktJI9IpOd4Y+mc
         OIfP3fZZdryDPBgi/MgnXDJeU+kg0KOKL9bt0Dkocbww4UFE3psnudFKaPoYWTqeaevs
         bceu8Xk2W0tYbZhIpCskjRX605lqPbuPz/WqFNE04b9kJcSV1CfVczPFBzXGEd5kUYiJ
         5Xjc16AOr5HzMqDLS2oDBnHBPX85xc/AI5h52zWQHgAT03qEfXj1HQ3Rjz/A5BG53A6C
         RY1s6FpazkKova32hDHaFlFnXD+Q/rVVf3OJJzFV0w17vv4fEepJNgEB55ZiZuLemBJ9
         hv5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770811520; x=1771416320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hnNC8eWrNYk7+G0IoxWoChhKJ9fxKWOeQZE4/O+rBqI=;
        b=FYaDxQ0Dk1Y790uL/ozgIYx+a44dIuPpvDFgbhRTagowBKI9k9cRY+eLYan9wXKxIR
         X0j26flwfbmkJargggHIEfoazAZ7COFpSEq/LZNZs97jfjKF0w0dgKXs7FImybmP/IA1
         qGQRpUxWWwMbP+ifx/4G6SwY6kvvFojlttJSZbQn3xE/yArdgs92H9Yo6qMA+4yx1gSM
         MCxkVjZAxdCHhviBK+jQ3tEJc/2FKlPnsDxCLJjhOLOF/O3EOoOGuAIh6O5qol+xL2l9
         ozv1S/ThYtlLR6QCaZ54/X44vsGYgq1XIkvUhv65Lup1Vfj7O9Y7qRFXudpAr1FFXyZb
         b7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770811520; x=1771416320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hnNC8eWrNYk7+G0IoxWoChhKJ9fxKWOeQZE4/O+rBqI=;
        b=nUudqUSMB/C6LWF6lgOpDU/HjJZhdr9JWJdkVFmNQIEBC26wQ+vSU0n8tz5s2OP25I
         2R7iS5jdC4P0+nKVRNNArY4occ3aG7hN5LDxcCxd4Jatje5v1D5nW5u1wun+z9xOE/ob
         wBu0GQEfQwyWFO3dIXzoZmocWoWC9XGHkLgXM4un2YemU5ho/JA8XEZb77WnJYlcxUel
         UsIUhRfPHUv2TF7od4Z6rH5nCSHJhuasMqzCXFMo7l7fkHzg3aGCEPGvXAGAInxmmXuj
         L/k/S1lZZkjKUAhuRueDj2/Z2jwzldAciBDT3S2JMoMC7TU8bMD8gMkLAyIv5m+HelnI
         2p4A==
X-Forwarded-Encrypted: i=1; AJvYcCWRf2QsK4IGHLa0bN6npZ/mMO41663RddOJvcUhGECn1duIwkZT07lJO9UTWk0G8CYxT/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyXyUhg7tM6oWX6B0d/kXNCjPMfo97QGmPsfW+nlOi6PJ18YVr
	cDZFwIzgwvuNspbp+nhS6l+C6wqpJXuB2jV7Nz+UXaxg9m6AiLXSoBM5As/6wHXec1coGwSjZ4E
	oDvXt+0ZVKhfsQkB0w1hZUNF7YZhhtOE=
X-Gm-Gg: AZuq6aJBr/NHTvjuZ+UBnGo381kz3zreY+p3+zn8ZQTfzuYmdX7N3FjJKk0jxmuakYU
	IeKBPRaiHQ3lkpUpKW2IwmZI2c1TRFTYGRINpjTFgKjKE+b2hZPte4cwkKseBvmfLLXD7KsoTFi
	MlGwjbBcihEMi62ieEJID4m0b+HVx6hG5RIyU+NIi0Y+UpgR6HDCB5XMa4rCrN5nMBjAsAESudM
	QBnmlkhu8+HAB7jeHwRjFAe1NkUyQOVA/s52+mqZPxvE6s2361PHHMHRoAGERCKB5PHAGORmHsx
	jXlh9ULYgA==
X-Received: by 2002:a05:7022:43aa:b0:124:8d7d:2d63 with SMTP id
 a92af1059eb24-1272437e9a3mr2653149c88.35.1770811520296; Wed, 11 Feb 2026
 04:05:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYsEpvFwCSHb5DYO@ubuntu> <37abfe28-ff89-460a-962d-4503ec3f7975@gmail.com>
In-Reply-To: <37abfe28-ff89-460a-962d-4503ec3f7975@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 11 Feb 2026 13:05:17 +0100
X-Gm-Features: AZwV_QjO0LjcQgQNwateuQtGBT_9oVJlsAGiyABQzYwjPgotZiFmXxFZPYbQlLc
Message-ID: <CAD=f0L8Mz2jLMnkyvAUbtDC65RwKSk6Q-ZgB3+pLFpJo_DN9qw@mail.gmail.com>
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, toon@iotcl.com, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Feb 2026 at 10:31, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Thanks for the backtrace which helped me spot the problem though I
> should have spotted this yesterday. The problem is in
> initialize_repository()
>
> >   void initialize_repository(struct repository *repo)
> >   {
> > +     if (repo->initialized)
> > +             BUG("repository initialized already");
> > +     repo->initialized = true;
> > +
> >       repo->remote_state = remote_state_new();
> >       repo->parsed_objects = parsed_object_pool_new(repo);
> >       ALLOC_ARRAY(repo->index, 1);
> >       index_state_init(repo->index, repo);
> >       repo->check_deprecated_config = true;
> > +     repo_config_values_init(repo_config_values(repo));
>
> Here you need to use repo->config_values_private_ instead of using the
> accessor as it is fine to initialize the config values to their defaults
> in any instance, it is only when we read them that we want to assert
> that we're reading from "the_repository".
>

Okay thank you very much.
I will send an updated version.
