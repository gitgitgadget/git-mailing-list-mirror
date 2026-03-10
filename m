Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5C372B21
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 18:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165851; cv=none; b=uhfcaPLOFuAbD7f+nzF56PXwdnGOUvksQ2o3DwbSSZ4vI7d2LoMfL7GPMVa/mAHg5BZQr0dis9A8Cu5S2JadiPBXcYv4Df7NUJwZowmLCBaqT3EdBa8JIOsYnT9AoS3NGRPnNHEOQRjTDFL7e1T79Oa75y0BeVk2H+CmOtrVwyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165851; c=relaxed/simple;
	bh=KdgRFEeqiOtV4Mh7/GViekmGSG/N+rFoU9gL4pzK0s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE584O7xJuRMzzgar8FieuwQrYwJ1iQL8Ko8lZqfzbqF5xb4t5FrSYVJjoi+wp9nBOjiJ9hfm2Z/clfEukh2+ZHcQNuhTZjshAr8I5RBu36Qa6F3Ws11/JC70UX8PfTwZFeiXfbGpVdhNOJm5CMXwleKH/cNEnDsKygKUoqu/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VPM60ohp; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPM60ohp"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4171ff4cb2cso1580552fac.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773165849; x=1773770649; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2fHzi/649GD92Fi2+GUmclK1dN1B2X2yPm7EFCYKdfA=;
        b=VPM60ohpbKdaACUIoNUIK1GM4cLC8s21cVhEit6k9drpiu69bamCDHpA++OVXijo4/
         aGhBr/nE0IO/hGHhsQC24uhg4bqWRcGSZtQRQAB3a7yZKAm/YPGFTLTNPiw5bHY9IGwN
         U+MLVswrrMTEwzNmqYFGZnqoxA8rGL/ELUUaZurx9H+ivNHZJu/Ji7bOvibMWLfbu05t
         HQptTJXPflV+37z5cEdNY753AsFhN7NUTAspA9W27CBF140ig41TpjgHIiXURSRwccg6
         La+Ra3q991rOf8A00HP9/5wtcVLIdCLLt2Ls4IznM2OyujyOLQ8PgIWHGojlr82GZRzN
         tf7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165849; x=1773770649;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fHzi/649GD92Fi2+GUmclK1dN1B2X2yPm7EFCYKdfA=;
        b=SIQflD8S82hKJY3vQQ2JgzI+kcuef+yfO/5zueBGmeJRF2YOYTG5UB33ZZ40CI9dRh
         A7z57fAu+vNISLEfY0NP6fJnXR8uYLtLM5zmc9XhA1XhK0JlkomSqjqqMjuFHWmEKIp+
         YebUHxPlTglfUI+FBz+2aevNZ1F48nKDN11qa6/7dPKLIqCvF1qTAn+No/3GN7W1DrUP
         xKpODMZKUDtNVtWlhZ5uTCUp1aTqPEkvdHfpPk/w0KTGOEcWJlQQ1LZIbn+UneSU3ItS
         A7p9ERYqUOYejqCoA/nXDSOTvfMP2KIqRisc46p5TgwYyiZQ9DxNTyNWtXi/BE/l1SoP
         2qEw==
X-Gm-Message-State: AOJu0YxoxhTWFwUSqjmxrOdh+O3NGSjJG686pTaoUCfhNrc3tnCp56vr
	Dh9NICvSnqSPm2lk9mMkjAKoyH/Onums/fu/tKEEHAM6OIKsrJqhPg/6
X-Gm-Gg: ATEYQzz3UVZy+YD9eqxUHm4ZH+9jQTdZV7y9adcZztX10IcSlCzUEFkbnDO5+dym9hj
	C0XaxRKmRa5OwpewgN4tyAdITy7Z/2rKXM00k6Bt+z0aVpewTK2Zl5q7EjkEBZmcWCBbiOyDXx4
	IZt8gQndQVbdmLgxw2qQUdjTH2bJ7NrRak3L5SyI1EjSitRuoYG2qcNGjo183h92RIJj82F2VW5
	kLAwQb4rEfqAmcVKHeOdbpX9wh4jjO+oObhKeA5japj2Pj8mFEcyqz18RkyljMBD6y+CNTkWryQ
	Tx45NQwNVm1Ols36Fs7WJvMZ5oNDc7XY/8hoa6EjK+g0ZzYcj0/AfbcKGuEY2IWjBNRbdmGSRxf
	krSa3bqXASYMkYJKjcVZQMM+35NIhiqRqcJ4U4ER7pHYTiHa4pTvNc/xTZvwiy0VpVCh4i5JhD+
	k3OB9qpqNvgBeqPLAH
X-Received: by 2002:a05:6870:4059:b0:417:22e:e2d1 with SMTP id 586e51a60fabf-417022ef47bmr5843016fac.2.1773165848607;
        Tue, 10 Mar 2026 11:04:08 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41756dba30esm2978931fac.15.2026.03.10.11.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:04:08 -0700 (PDT)
Date: Tue, 10 Mar 2026 13:04:07 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, ps@pks.im
Subject: Re: [PATCH v2 2/3] gpg-interface: introduce sign_buffer_with_key()
Message-ID: <abBciWOi8D1oRJZ8@denethor>
References: <20260223194146.3476768-1-jltobler@gmail.com>
 <20260306205359.1723254-1-jltobler@gmail.com>
 <20260306205359.1723254-3-jltobler@gmail.com>
 <CAP8UFD2F-81dwyOP8iMqQq2MjQ0GN-92ZyACSzbk6f7cOQAmTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2F-81dwyOP8iMqQq2MjQ0GN-92ZyACSzbk6f7cOQAmTw@mail.gmail.com>

On 26/03/10 10:01AM, Christian Couder wrote:
> On Fri, Mar 6, 2026 at 9:54 PM Justin Tobler <jltobler@gmail.com> wrote:
> >
> > The `sign_commit_to_strbuf()` helper in "commit.c" provides fallback
> > logic to get the default configured signing key when a key is not
> > provided and handles generating the commit signature accordingly. This
> > signing operation is not really specific to commits as any arbitrary
> > buffer can be signed. Also, in a subsequent commit, this same logic is
> > reused by git-fast-import(1) when resigning invalid commit signatures.
> 
> Nit: s/resigning/re-signing/

Will fix.

> > Introduce `sign_buffer_with_key()` to centralize signing key resolution
> > in gpg-interface to allow callers to reuse the same behavior without
> > duplicating logic.
> 
> Nit: I think it would be a bit clearer if the change was described as:
> 
> - moving the `sign_commit_to_strbuf()` helper from "commit.c" to
> "gpg-interface.c",
> - renaming it to `sign_buffer_with_key()`, and
> - exporting it (so it can later be used by both "commit.c" and
> "builtin/fast-import.c").
> 
> Or did I miss something?

That's correct. I'll update the commit message in the next version to
try to be a bit more clear here. Thanks.

-Justin
