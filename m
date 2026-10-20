Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511474;
	b=wDtd3kPd+f6tMH8jyMsSKuLVhCc8uoidiq3Y6izaSNWsDNEtdd80bMtzOS7AnlimUf+u
	 uR0JsAuwwg/hKAwHSl29dpP6HJwcxABeNBOOiJet9jenzRjbUFxT2nel8Mp48NH9Bu9B3
	 1TS8WY/uj3azC3GcA2ECFlgMq61m5eNAtw+O8yvbdP5cX5BaKk5XmrSF65E6gqozsjs+D
	 lo7+HfumqLX4EwB+Q+NjbYWTHuMbFcfX1OxhuPMi/D41Ozd06gLCX3TQZtTD52HQWg/eP
	 W1K4yFR0t48zGTubInFilxmXmmMwRp9rD/fJw+2cKUgjNEbHh27uvHFQczphGv/bghg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511474;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=PJFEVEIBPzIpJCe1bqFJnqLJYa1OToE0N7RMYFpvkbI=;
	b=TiOp+uYTSupx9vU7Uz3b8Bz3urHk3fP9tb+8K8IfskDpkvWMV8BNpR6pfDGAKooG1Rhu
	 c6LwLYc+0/ODmwlSzQd1czMyHxuEh+sgPG4NMAyvxDkAbWvjR+vprJ4cmFqkZcd/Am+8I
	 YBU/3nkV9FaeSOixmiLnYAL1oBsEVicrxd1NJbTt7Xe2bBf8raqXOL8Egy746//VY2vKw
	 cIaI50NW1yZCUfDSyF1NbihHpVfctRsmshWp9eyVZNKhVxsHjjZ9cUs7iIfwrJvCfoSU+
	 UMG/WLoTc6DjvblITjxh7hDF30nN20mtbnaVJJM4l0YlN5QqFVSkTjBDM4H31Q9fqAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kwnvdk2y;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BBE606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52BBE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kwnvdk2y
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6f5a0893610so2242377eaf.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792511473; x=1793116273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PJFEVEIBPzIpJCe1bqFJnqLJYa1OToE0N7RMYFpvkbI=;
        b=kwnvdk2ygLPG4fRWBa1zvYrDkA3W2j06L2GOohUkwHaEDY5tbUYqNQM2iMiWYsXDW1
         xO36lESon6fatyXLCMT2WF3QJKjJNvzNzjQUvL+7MxpmbUV+RQEBK85yBHPNEj2oAH8K
         yNAlV/6ayNewMHmLKt1jRWM/CezGcpyXCkMwX9pAQSBfkqsGvxaDDsjRrC+jl2S77AT5
         dx5dWZTvCiNa0dOGQ0Q8HRI9hR5oq/KV/1nzoSEuubvdcMOWcNMKPZtq6HXG7LM9KIKp
         yAQ0TX3U/s9ItOZl14XG8igxpQYtmPq+31RGYkgFecyF5f2PxGMc9aEgEoRJYLuZiaeW
         SsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511473; x=1793116273;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJFEVEIBPzIpJCe1bqFJnqLJYa1OToE0N7RMYFpvkbI=;
        b=DdcDeW/DfkPSTgfhA+04NaWbRISiBTIOd9U94+Yw9sN8n0GJEiZ6UUrnJa5CVPHqJv
         u+X98Y2H8owIiDes7J4VO1oHVtm23ZUv7F+eH6q3fNG5+FTKfuzafBf8QHCMEw0J5kHd
         wppJ/7Tk49W+jGLS3Itr58Zf1vBA5d++q0iLeCshJqdkUMz7WSGis/4fd83u85wzG2js
         azI3nZbV5t8JlFa/vdGGUly74Cm0z0umA+5zsODucEtIik2esSZ9IWWOobqiKoe8gR3R
         mhOuez4zPiIDPLIVtQBT809XEbzbrapBsR5NJa65C+5XqitQ4QlZXJ6cLn2Jg0n0EjAx
         lqjQ==
X-Gm-Message-State: AFq9FYLG31id/K8ARd5BHZkqge1Q6zfMRZmBkCNO+/L2P0wi4S90Cals
	LmDxEVrKoz5ubO6qhmrpUJaZVwg6m3ocKXvWELF+GjGHjNRuRDwjLlsNePa2Uw==
X-Gm-Gg: AYBFou3KBg8FI7gcF0w9vabehVC9wqVKhyeMDWzgaHTFR+AchtqN6qhabXiWGeWRKGp
	ByecRZiMnmRUyaiplx4fWqoq+BaB4295lMVVKNuDXOdsBiqTNZZ88dzgC2LcqoHiGn4BJ/mYBOS
	I+rOrSVovAxPJaZsziRM32CWHTY9QaqBb7J82maVrbKkDwb/PxpPIX8V2ddk19cGGayOFJqrNgH
	3oMOVYtdXqkH+uE2ugYDlXUbYnp823kLcyFjJ3h6oPLb3q1K00etcIbk/dE3P5GwJOLKFpo04sE
	zxrX1pEUnR35NgZpVhraGhV2P5unfUxWg+VbwXEqQ+uti3H3OShkbnbsuLAxDPozDAI1Uc2qyOc
	veHjKtVWsFYnmsaN3rucdmWXifFMcLlOkmh/llrnkwWsQdTfmXvizLcyeSrUqloDEkw7jWO2tqu
	5ZrmupfPEPCLeRoDrS2pgyXwmg+QigqYvUR1yjrMv643o6VNWpFND5P/kTKSbnba0YpnZPs63Hv
	FmSXICHIETTan1ORmUtxoA=
X-Received: by 2002:a05:6820:820:b0:6f5:eeee:b22 with SMTP id 006d021491bc7-70356a9c160mr7763932eaf.49.1792511473175;
        Tue, 20 Oct 2026 08:51:13 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8462659e3f0sm8994219a34.17.2026.10.20.08.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:51:12 -0700 (PDT)
Date: Tue, 20 Oct 2026 10:51:11 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] object-file: explicitly write ".keep" lockfile
Message-ID: <ateNY8W17UAVPZ9b@denethor>
References: <20261016213716.593278-1-jltobler@gmail.com>
 <20261020132900.1208343-1-jltobler@gmail.com>
 <20261020132900.1208343-4-jltobler@gmail.com>
 <atd6IjqH8F_O44gP@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atd6IjqH8F_O44gP@pks.im>

On 26/10/20 04:26PM, Patrick Steinhardt wrote:
> On Tue, Oct 20, 2026 at 08:28:59AM -0500, Justin Tobler wrote:
> > +static int write_pack_lockfile(struct odb_source *source, const char *pack_name,
> > +			       const char *keep_msg)
> > +{
> > +	struct strbuf lock_path = STRBUF_INIT;
> > +	struct strbuf contents = STRBUF_INIT;
> > +	int ret = 0;
> > +	int fd;
> 
> Hum, not quite what I meant :P I'd leave the variable explicitly
> uninitialized and then set it on all exit paths. Like that, the compiler
> (or at least most common compilers) would warn for all code paths where
> we don't set the error code.

Apologies, I should have read your suggestion more closely. I don't mind
sending another version correcting this though.

-Justin
