Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC53446A5
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773094488; cv=pass; b=GrODrbFu8ynmhu0Ur1OWQFL2raGlSn5lp3UwZBp0oUmcaH9QbBCYlrxdGDUJ1FlmlEQiv2A1kLE4iPk3s1UQA8erAr8ZlwSIxnDCRAvVDe12tQSmkKZS7GP8mk94KEofabbb/GgMjZMYL4ZQSGXsiaPmqa9glxRMcAuaT/uhJps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773094488; c=relaxed/simple;
	bh=WEp6Qia8T7xfSLUSL1USGxCHP7Nj/LehuihwcWjeBIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nbWc9mqvChr1GdSw+OdMls7t/KxMj3LpVdhklcrrgL5QZKUmGpMFGtJ2mZ7NBOZfEl01XYXN63hf+ZOCF8MEo+CJPY7renp4tDjghsZ2wo2OyM0AZAbX+ihkSRVa2BgH+/b+YfNTAcG3tjrdPurMECYrFPQuXZaqY9XAsp8usug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHQnAikf; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHQnAikf"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3598e065d8dso4119177a91.2
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 15:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773094487; cv=none;
        d=google.com; s=arc-20240605;
        b=axr9rbmrtHfd1s7YnoKsWRTvqXMewqt9UqE1cFCrJgqMoHn+C+FiKABVHNXjy/pPRq
         dn5yEI4zEzmBC1wjKnFAXSteJNgk78DYoYoc4HnCLf9YQjK2hAmL2hcttTc+ST5W6PyD
         jGfENwJYFiudiq1nvTdmnDDW0OdwZcO9bnMIqRrvGEOz1dez7o0Z02LDfh+Q5++UwiAS
         HNrEfdRY1EyjNApUnVzzxIi8Emtb7tulIUwpQmT8EQAitkTT3IbmFzLHmoCwDOZAmuwM
         hGsGa4YL3DNNQ1+84ws656TU8RWQN/nEbPi48aWiCW0IoFD0sGf0CXp3YkbcbR+bq0Jz
         Qm/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WEp6Qia8T7xfSLUSL1USGxCHP7Nj/LehuihwcWjeBIM=;
        fh=rg6xByg/zLyX4Alt3KuoGv8Yy8uxn7jh/BxXzYI5/Gw=;
        b=faxtE1An5/ffHlD1Bll30kweAy706Paia48WlgAMUc7VOkdsOI84k29qwF7p2QXXl1
         GXK2C5kKZ6GcG8zuk4pWaEXJXBjT5D6eZGUy5IIDk2d+dqQHhJ6XRABCFUi6VRayBYFS
         0FxIW9NNV9nOndYwQA+qbtSDLXVor0qFUPknlMEnE25Uk7YUeokOlOnnTBG0fJrc7afO
         U7NEvvIFmKExyzfTZWY65yL4oHIvM6XjUliPbjBKJ5U2D8Hh/1jNFXfyO2C/lUdSFQi+
         NrBBgz/sIFKO2LtwENLkMC7WaDnpNILecJSnNdnSe2JNSy9eZVP1ZD3TO/8w3OFBcr14
         TSyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773094487; x=1773699287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEp6Qia8T7xfSLUSL1USGxCHP7Nj/LehuihwcWjeBIM=;
        b=eHQnAikf8DuSyMeMLok9sFGe9FAkqsPGENdPQ77E7BhWTrK74vp5RwrwSMAypYGfBK
         jkpUV+P0iVsao1zbZy3stJ7G4ntF8hEi05gPGvFNlzAV67U7Zt0IBT8G3NnNQN+vee3c
         qfz9UZrO8K382DqlLsyBMAqjFSoBNwDxEh1wcO8yfuyqYvV+m5PiTwyqw6mk8QkG4gfT
         SbM5jT6wLGdKqxu3Q8cLxWvigFi122e3cH411kovQB/IjOVGukvsuqOPkRuJBsXBs4ER
         /jmzNxc8Yy0LYpmLBkbB4m4xP1/mQ7qbNmKSr5Sne5syWQsRRnw5d4RD0Htp6qgKZxIN
         CnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773094487; x=1773699287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WEp6Qia8T7xfSLUSL1USGxCHP7Nj/LehuihwcWjeBIM=;
        b=tQSagvqg37jF9Ety7yKfiaofFR2cHLjWMSeVAW3qlbmzxwzSlT+6dPLdXRqC/MCWmF
         c874iscrI3Mp0HKxEjWXgkzjbmT1FcGllmE6N8e57C00mkAK14MAgY8QjdmF242xCESM
         P603mnBmqc5UuIUjUsR9MQRrcw2YPf4hVJWwxsUNYoTGRtix5JF9d9iOG1tYK5MrSfTD
         1h4gh1PA6scQ84k1Vsyoz8qDZATKW0kcWat6rmkdnl1vq2wEsRYh4lFuM5VOMtL8EgZp
         lBrN2jciaba7Hj91Ut8qARhnm1oe6AstDVYqwlolo2v1JnGIBq6cNL4WPMR57MRPMh0b
         Y/vA==
X-Gm-Message-State: AOJu0YwusWQI6uBnuSLmb7Cw87GheNjw/C/km9lcWG0NjQsQSRN9Qwtx
	pFSaicVvlXL4kSR1iPRkcaq9pl1xq+uNagIpaUzFkbPXAHTVwHVM+tDUQo7KicolZC/+PeNpRKz
	RplLtY/DFzqPosLEKUQdIJHovy2ekqIA=
X-Gm-Gg: ATEYQzwOC0vwHgmxGHse+tEVx5NgMLUjQx/lSsiVhlvMhEaYTsQiJqTfzLFOvGlloQB
	WVlun51zdHFZN+ZdIyebuBz1YCWa8iJ3bfpuFluOIGTHwqM4NIXQt78mJL/2sgBecMddv/rH6a5
	er/B8YTv4FsIloyGXCTvOPvuD88UtrAtd5TChjLoF8xJ6KjN7XBtDyopHUpGbvlp++42/koEl4d
	PcU0aQOUEsiVL0TCfXkZLwvmoQgdPa50utYkAOCsTGj2DpFtRuI2vM8DkONK9ZO5YZJAFrorr/Y
	4RlH1k2nUSvOA8Rsq3aUV5t+QK0JP2DFnSna402gHbgsfQE9riDZUt251e2+4i1d9qKbuv0DZYR
	++XjSsfI6eLlumWLl9FCp790N9Fo=
X-Received: by 2002:a17:90b:1fcf:b0:359:1130:1042 with SMTP id
 98e67ed59e1d1-359be34e415mr10293879a91.23.1773094486817; Mon, 09 Mar 2026
 15:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <032a7767-2350-4312-a7b1-75080519c72a@nutanix.com>
In-Reply-To: <032a7767-2350-4312-a7b1-75080519c72a@nutanix.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 9 Mar 2026 18:14:33 -0400
X-Gm-Features: AaiRm50u0QhSN5MJl0DsGPEtWY2Aw4vmPYVI94VL6fmAL10b3u2AUoZbfTZE5nk
Message-ID: <CALnO6CCR1BioeC_eYCBt9BCrFS63L6f_5p2nTk=Z9eOAj3hW1A@mail.gmail.com>
Subject: Re: Option for "git submodule foreach" to also run on the parent git?
To: Florian Schmidt <flosch@nutanix.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	"brian m . carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 9, 2026 at 8:56=E2=80=AFAM Florian Schmidt <flosch@nutanix.com>=
 wrote:
>
> Hey everyone,
>
> would there be an appetite for a new option to "git submodule foreach"
> to run the foreach command on the parent git repo as well?
>
> I occasionally use "git submodule foreach", for example, to make dev
> branches on all the submodules if I expect to touch them all during a
> dev cycle. Even if I don't need them on all submodule, once I'm done
> with everything, I might run something like "git submodule foreach 'git
> branch -d <foo> || :'" for easy cleanup.
>
> In either case, I likely also want to run the same command on the parent
> git. That's easily achieved by just running it manually one more time,
> and I'm sure it's not hard to make a git alias for that either. But I
> wonder whether the workflow is common enough that there's interest in
> adding a command-line option for that? I'd be happy to have a look in
> that case.
>
> Also, tangentially related, "|| :" works, but what about a command line
> option to continue on non-zero return values and not abort?
>
> Cheers,
> Florian

This is not particularly general-purpose, but don't we have
submodule.recurse (-> switch, checkout) and
submodule.propagateBranches to make this kind of branching workflow
easier?

--=20
D. Ben Knoble
