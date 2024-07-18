Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A977E0E9
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343024; cv=none; b=VZdXwiat7ebXbWqCAyzCdqg9PAGAf3GWtsVNYLDEm8VVm1Gar4vUeUPtgqQF5cyHsn6D9YHFIDYC9gRiIhIPikiUZ9sB9F1Hf2FmNAsgZbz4JsHDHCbrA6ql9scI6VocR1jv2dv99NtInlwclpaTvdZETg8j9ofuBgDDrcc5pkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343024; c=relaxed/simple;
	bh=GEzFc3GPI74SH72OdzNnUnUWeqm9PuJW0hDmPJr+aZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HF0v/A2fdqWSgUPDw8tqfkgVArvNim96S91lGaVhyLVD3Y31vWnm4Lflkstk4Uk8PQg0cxuc4J7s6USLfmtOlfbMY5zmyhY/fXXtwyj0yhaPtlSn2YIH59teQdivq1It1dCxvlNeU+y3b9s3YqR7yAhIPM88Ed00szk6WDTTR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SoPrGw1Y; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SoPrGw1Y"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79f178e6225so52997485a.2
        for <git@vger.kernel.org>; Thu, 18 Jul 2024 15:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1721343021; x=1721947821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5GrdDvQ3nhXP9xoilCeNDuVaTmOyDGn5xhmA8nN+5o=;
        b=SoPrGw1Ye8QCPzoJkX4+A9aWtWJtpx6m7uIrK1Mhq6Gb5INDdfQwstwWmfskatfF3s
         /K+c8aA1sa9K5f70o3D6n+hpvUktmas6t+MecmSKqTzR+GLxYRzQfMWbIQgY7BAIOazt
         gKKN0vy5IHUFjzakiTbt2UVmUabeTQGuEvWIEhpLLtbflnaVQMzpB2tWslBVuqZZdxjr
         538bSOF6CKTqhY7Vx/mabGF9QDtiBxyTdvRNmDCVvRbiKhIvfNAaDKCn1Zg9faXD1ze/
         SR/RDYsYApOO6ULmyUueDFA5c+6vlid5H4m2L9NaDckw84PNWV3sr/xCCw6OOLOFER+Y
         onLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721343021; x=1721947821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5GrdDvQ3nhXP9xoilCeNDuVaTmOyDGn5xhmA8nN+5o=;
        b=AIR8ZDmBcB8IciS6AA7zJe1waWsL7/RtXfVJ61JclQjQ1Hr8UNvGqK6gPR/pKNFUP2
         J0RkOHrP5Mh1XJrNOZ8CAgco3+OqutyH7qnHgtNn5m/oIgE6zHKqdj3ilUPwkqNuirpM
         WGCLN3J/10TytTb2qiruCnnpT+1WTA1WPdX6jnIQ95ubqUNTnAI1oOp75mrJ65BNNPjB
         L/rCNwfdjvpXwLsqiYBs06tjvFbw8w5+pia+hZFXw/J1mOn3UY0z+yJkb3pTWvhXvySM
         gQxCIv56flSI4MQxTsc3Te6nQyUbNGUSkLU3aoMq+3ERZex1nFIkCRcmAoU3+fmJD8lE
         eapg==
X-Gm-Message-State: AOJu0Yz7oH6R9m7BWxY0gw2hG/inygZuPyoMyCF53em18rT3EB/dHlio
	iLwXmsm3qf/RM84w0UP5SJdDbv4ArRuBo002hCSs+2WinnJYtSDD7kEl6I4zmAY=
X-Google-Smtp-Source: AGHT+IGpmv3cwSRs00pvzGCgGW8Qbih8IwWhOG/l3dEbNZIodSncJt0y7P4pfwyn7VIuAXfAWCsebQ==
X-Received: by 2002:a05:620a:29c9:b0:79f:726:e2d4 with SMTP id af79cd13be357-7a1874414cfmr799569585a.15.1721343021077;
        Thu, 18 Jul 2024 15:50:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdcfdc3sm671741cf.96.2024.07.18.15.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 15:50:20 -0700 (PDT)
Date: Thu, 18 Jul 2024 18:50:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/2] Fix background maintenance regression in Git 2.45.0
Message-ID: <ZpmcK23coi5Qqm7E@nand.local>
References: <pull.1764.git.1721332546.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1764.git.1721332546.gitgitgadget@gmail.com>

On Thu, Jul 18, 2024 at 07:55:44PM +0000, Derrick Stolee via GitGitGadget wrote:
> The issue is that 'git multi-pack-index repack' was taught to call 'git
> pack-objects' with the new '--stdin-packs' option. However, this changes the
> object selection algorithm. Instead of using the objects referenced by the
> multi-pack-index, it compares pack-files using a list of "included" and
> "excluded" pack-files. This loses some granularity of how the
> multi-pack-index chooses among duplicate objects.

Thank you for looking at this so carefully! Let me double check my own
understanding.

Suppose we have a MIDX with some pack 'P' and say, some commit object
'C' which appears in that pack. Let's also suppose we have another pack
'Q' in the same MIDX which also contains 'C', but the MIDX selected its
copy from pack 'P'.

If we want to combine 'P' with some other packs (excluding 'Q'), then
the input to --stdin-packs will look something like:

    P.pack
    ^Q.pack
    ...

And the resulting pack would not contain 'C', since we would reject it
via: add_object_entry_from_pack() -> want_object_in_pack() ->
want_found_object() -> has_object_kept_pack(). The final function there
would find a copy of 'C' in 'Q', and since 'Q' is excluded, we would
reject 'C' as unwanted.

So the resulting pack would not contain 'C', and the MIDX would hold
onto its copy from pack 'P', resulting in 'P' being both (a) in the set
of packs to repack together, but also (b) non-expireable, since it has
at least one object selected from it in the MIDX.

> The end result is that some objects that would normally have been included
> in the new pack-file are no longer included. The copy that the
> multi-pack-index references is in the pack-file that was intended to be
> repacked, so that pack-file cannot be expired in the next 'git
> multi-pack-index expire' step and is included again in the batch of objects
> to repack.

I think this matches my own understanding, but let me know if I'm
missing something. Assuming I'm thinking about this the same way you
are, the fix (stop using --stdin-packss) makes sense to me.

Thanks,
Taylor
