Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C33B248165
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933093; cv=none; b=EcBrE+pQsmutwV4HBvm90lgxVRNcD+R3nzn19SUR8axISa2G4WwXdkosEQNcUsEN45oG+PqfQWSmaHWfeXs9IL3E8ITKqwZEEy5qrn1VK/9dY0oWPyXG65KqyQi2Z6eOeyN4eiJLp+UJSmwP5OQH8949s4S3qGNXyj9TQ0h4Cw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933093; c=relaxed/simple;
	bh=u0DmaFVGdCXpxQ7HrMo40Hyvk7uFMF/U3BhcJblVpmg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=joRG2lHbajKt3Kev5Vkm0or+nwa5kzWCMpAfx0rn0DuiUlNfg3Zh8SYgdGpE6CsJC2ZlkC10HZHniYggG7iHl/sfjxxiV/6VufVVv1ezHDjYOA1jlCZcxO4OzV1FOVtuEEe6F6mEtvCvA45xHF5EsC6Mrian9xLx9KZCfl8Cbs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hylIZHtx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hylIZHtx"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54020b0dcd2so701396e87.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 01:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736933089; x=1737537889; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIZ3xij21YihxGdYS+5XMxg8B6+qS81BwAHa2oYiZMg=;
        b=hylIZHtxrjE/IfjIpCwGOA0V70yMKik5iGiwyTnJm3JB2hvtMfNfIQQ2AVTpwmZbwu
         dZ9ElqZw+KU6BnF5lh4cgrWYEQGGmnQifYgTPg5XYe2wWqc+Ftf64glYfHYcdcYNXHJs
         80YHkqDlptlgN0iHcBtdHV6JJhqkG+mamcX0RjpF7cqkt4dcmmVAcWX3fGN4k6/WSpCy
         NHL1AnR/arzIns2AmSMF1pZfqwsXd+nuHzcZeB5TemhLmUooLvElOwcyseG3NdD+e1nT
         58PzH82iZVoIQbOzAJyAnufr3D/vBF7CbNQYg3n+ouzO3VTOxflHwA/o/bsiXymr3gfm
         mq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736933089; x=1737537889;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rIZ3xij21YihxGdYS+5XMxg8B6+qS81BwAHa2oYiZMg=;
        b=MxaDgymcyQOSgQzqKR5fPickuZSvP8p0EdOppSQKr5RmFrt7wMpBnxx5R18lLtIJXp
         NEQH/7bF/Rq1ZzAr5M0bF1DADp/x1/424o7mj1lQZDn8a7nIrQLVgyDrzZAIyiYGIUf3
         GT6FrR+opMTYnGiUmh0dl2fMNWhT6UmZLhtKfW5U//joDykufFphnv3ike4i+X7S9dlM
         MEg2gwxVBsfwlVfzOAyAIwHjkXzu2GyCvKiFOWB7fz0d3RvOJOIrZjXpfoG2iA6hhAD2
         9CJRuID/7w20MehwGQ6XabxdtGp4zAZcRu4La7CxQLkr1E8oO6rQe1WrByk98e5+U5Tt
         lg3A==
X-Forwarded-Encrypted: i=1; AJvYcCUPJU+LqoSqMJ4f+FMZ/VhpsYM36vktMsJSSNQzTQ/VPj1YJvN6OzdHieblRRa7GlMynrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyddh/YwCZBbIjIEsf6VLWBAHGvnqbZV2AFrrHW0dOkNZUnKiFW
	scGHUGcm4kxOoM66IYcilzwbyMHxrMDRuQ7+nbY5LxdfV8K2chnepuIb2LW7
X-Gm-Gg: ASbGncseLs3IK0kbl9zO6vi/lSNwlgMkobhYOSeH+fdBwc/K+DM3oiDmrLxw6Y+IOmZ
	3Mu15iU6k+ph9EgQDC+nBV9vv3tloVfBtwC0gXNlCyjjhO1l8zEFVBd+bxM/EfUgvmuyqoYawcr
	iJ+Npo6st4FxCjOOAlJqaBKG8hUmHasPzAKZo8ZfRZ0oar5uppsamPGH3OowiKohX5uRPn9qwfS
	+ORUjNTea6kswkywFPP6wquCjpjAk+izJp8yaXtyKfgsBqC3vLI0swmSly5i7HWYU9+5yzB/i6J
	MLL0OLUSsgLRfO3DvhZ/EHrpvreBLnn0sjsOGHd9HAzrz0SHgyqUfxIq8zIrRy5Aq5qKnnTxdMY
	6XHpBCsOGQ98ZyJ8S1Jovl2nh
X-Google-Smtp-Source: AGHT+IEwEtA+c443w3M9cX23NiwSKIdiAICAB9Jvepf6K8mClTnl6KbavQPa6bVyQzZofOIdkCSytg==
X-Received: by 2002:a05:6512:3987:b0:542:7fa0:6701 with SMTP id 2adb3069b0e04-542abfb650emr728682e87.11.1736933088829;
        Wed, 15 Jan 2025 01:24:48 -0800 (PST)
Received: from 0369-666c-ac0e-85ca-4400-843f-07d0-2001.dyn.estpak.ee (0369-666c-ac0e-85ca-4400-843f-07d0-2001.dyn.estpak.ee. [2001:7d0:843f:4400:85ca:ac0e:666c:369])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428c704547sm1980472e87.6.2025.01.15.01.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:24:47 -0800 (PST)
Message-ID: <6deb9ea67b2dafb12d02146a29a35ddd970f7c06.camel@gmail.com>
Subject: Re: [PATCH] instaweb: fix ip binding for the python http.server
From: Arti Zirk <arti.zirk@gmail.com>
To: Alecs King <alecsk@gmail.com>, git@vger.kernel.org
Date: Wed, 15 Jan 2025 11:24:46 +0200
In-Reply-To: <20250110101346.30416-1-alecsk@gmail.com>
References: <20250110101346.30416-1-alecsk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On R, 2025-01-10 at 18:13 +0800, Alecs King wrote:
> `git instaweb -d python` should bind the server to 0.0.0.0
> `git instaweb -d python -l` should bind the server to 127.0.0.1

Thanks for noticing that bug and sending a patch!


>  GitWebRequestHandler(CGIHTTPRequestHandler):

NB: Looks like CGI support will be removed some time in the future and
the Python backend for instaweb will stop working afterwards.

https://docs.python.org/3.13/library/http.server.html#http.server.CGIHTTPRe=
questHandler

When I get the time I should look into cleaning up the instaweb script.
