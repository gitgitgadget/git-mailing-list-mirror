Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45957396B66
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768585578; cv=none; b=c9rgSqVGYdYsIfAZFFiVGU6idEWlagFCTY50k3Ho08dcXwY8yGzejaLtuWaub1rX+OeHCBjbL2MkSsAdxDud5fFaQAVV5iAFFHqm/Xa3chlLMJYGKAlNGeLavkDPNEPnx1xvJlt2BIP93AYJN0RmwKsiVqRT3cBC+GShRGJHhyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768585578; c=relaxed/simple;
	bh=909YBJgPZqIumrU5FL2As73/0X2uXFeX48aq4qRtNZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usuq/JCgLKXaraaKbs9+wrGW1BuzoJyarGAdwRxfhV0qfRgSvV31HH9BfRlJn3M9bk5STGk3Xjmg/E6KQ2pnSOOoDrko7ywI87xZqumIOWs+jmZLIf6Yu0R93pOcwDh6KapHopL5JP27klxmlshnjhhw/YLVVhs2OO2EP4yfoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd9ImlBg; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd9ImlBg"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7cfcebf1725so1538696a34.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 09:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768585576; x=1769190376; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nGzZMXvr3uh0Hw/9WODwt5P1e4FuNDF3FN3J5SBGCRY=;
        b=Vd9ImlBgBIfrlQUweCIbgQ5dUBE6EzQMLYtV71LmbhLH3zX2AffSgISpBBRW7Z1x/h
         UEVPr9O1ty6YZvgdXbyWkQmb75R0s/hbKSRiOoEdkpmV+8f2mUhF6GkdD/YV55dL46+T
         +68yWYJSTs8StM9mmJVlyQb2lfdC2S7eRfg9qv0/8Z5rKM4syySsJUo+BDM6oCfOLEEW
         lrs+oXs9S7P85N/7723tEFsN3qMxFxUmAsl2BoAGBXucthErX1ohvc86XgELrbReoNaf
         akOQstpx5FV0ciqY150KahGLBGjnlzK6pdbBLbIb90Jbl5tzekHHQhL3bLQSNu/ay3LM
         p9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768585576; x=1769190376;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGzZMXvr3uh0Hw/9WODwt5P1e4FuNDF3FN3J5SBGCRY=;
        b=NWDfXw8EzxCVS3+aA6X7EgrzAsKc/ajhwnLpwJpMYUmeunVK/o5i1w19ejUOjpB+sA
         zFhG3NGEiJEyA3p/XqDP8vC+qwWwkMrezVQo485HDH77ZMxVWMWBt6vxRtiMhmqPd+ZK
         6iH9ryQQ7icu8ms+5xuL9TVpNC9V6C9Y9e4DZc6GQ9BPC9Qsm09Co/YPCInj1mX1jk+O
         v4pTeX/guQvP69pparUlp8uFbk/Y7/1hlcrGCIRzhjm8Xmd5bo04OP9A3EFwN9s+X2u0
         jQtYq4/k00Glh4UlGVUbDzv1vROmPUfZRGWSsboJnnAUwoUtiwXqOCRzL+oLS6QJXMWG
         BhWA==
X-Gm-Message-State: AOJu0YwB0mZu7tRONIr+oVC2ckou3dgNrkL6kCmMHfTzhLVy6aQJEN30
	zVKqKDEY3S2DPuacsbZlTYpVRBFxoQ3L3i2Bw24UyHMUSaVS48d82ogJmVj3Ig==
X-Gm-Gg: AY/fxX5y93ltbMiYowAxRDsA0ii1heGkZQ9gcoghc/EQD11IB8XFLnifYXfQY1lXCsu
	YNf1mtuhKWge85P3FRcVDzrZFED+JwYbmdOhYJjL9IftXGZO2EY2m6CL2KWdu1LlfHO0GYKjXrb
	iM+V34dUHE42Q1IDLqOBRLrEUEeBSkN9KX+vlICrc8+u3pFs0EfrDOiOqRbCIFKExkMeKKfPvTb
	wlKsoc+6B+mbNt6VTPpfn/JI1o4spkTFxHs4dxOFSAFL+J+A8hHc8fQ+Z+cU5scUFJ/jreJInyd
	dJHxBM073znCXCJYXuylWXi69YEhRrqkjt3iCljBlEM8oVmy46M0K0xGRjvOxtQmzmFmM/tbLMN
	WCitNYRhIY3PnYaYl0xind+mv2r/yqQPSHPZvTmNALU3yDMEVRQttu5Y9LLECpdxPlmHLOJW7CM
	dTANRr
X-Received: by 2002:a05:6830:6d10:b0:7cf:d784:5dd with SMTP id 46e09a7af769-7cfded74cd8mr2335334a34.11.1768585575690;
        Fri, 16 Jan 2026 09:46:15 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf28efefsm2017638a34.14.2026.01.16.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 09:46:15 -0800 (PST)
Date: Fri, 16 Jan 2026 11:46:12 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 07/14] odb: introduce `odb_for_each_object()`
Message-ID: <aWpz65mPZfy7Hfba@denethor>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260115-pks-odb-for-each-object-v1-7-5418a91d5d99@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115-pks-odb-for-each-object-v1-7-5418a91d5d99@pks.im>

On 26/01/15 12:04PM, Patrick Steinhardt wrote:
> diff --git a/odb.h b/odb.h
> index f97f249580..8f6d95aee5 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -475,6 +475,23 @@ typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
>  				      struct object_info *oi,
>  				      void *cb_data);
>  
> +/*
> + * Iterate through all objects contained in the object database. Note that
> + * objects may be iterated over multiple times in case they are either stored
> + * in different backends or in case they are stored in multiple sources.
> + *
> + * Returning a non-zero error code will cause iteration to abort. The error
> + * code will be propagated.
> + *
> + * Returns 0 on success, a negative error code in case a failure occurred, or
> + * an arbitrary non-zero error code returned by the callback itself.
> + */
> +int odb_for_each_object(struct object_database *odb,
> +			struct object_info *oi,

Something I probably don't fully understand yet is the role of `struct
object_info` being passed in here by `odb_for_each_object()` callers.
Outside of configuring the specific object info attributes that are
needed for a given callback, is there reason that callers would care
about the data that gets populated in it? I was under the impression
that this object info was really only needed for the internal
`odb_for_eachodbject_cb` that gets invoked.

> +			odb_for_each_object_cb cb,
> +			void *cb_data,
> +			unsigned flags);
