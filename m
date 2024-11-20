Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695BC1A704B
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 12:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107516; cv=none; b=up3RHyp/hJrgaeKJ3pWDFwE5thwJKxBN3i7iuk4tuMb8yWaHaXnFJtCcancFwpTFweB6VVJVT89KQYAcs05i91y83bDSAZmvJ5qCJyvU96arnUcFUyjuQVSAyKvOzb/sQpqsU5XsT9n0ymHmSeLc54We1HplFEYsJMwNwzSZOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107516; c=relaxed/simple;
	bh=UN1Ptbyi8MWpxV8CVp0+48V07eK8OD3JMhTM3cCP14A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmLAyfGOwPKnjoZRqyEcOHTrO+PyWw+oP8taZxcOrmO9480G5o6kQR15pXoUV+NvlHlRZT8WKWFIFzFPEPSWAj9nFf0F+gKRUaQfaIK/T/bZWP3zxRIrmr7webncczh2oTUtl8gp//roSaZYvsfQSVhUqXRIGApYhi6a/LD7D78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAHQZtGO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAHQZtGO"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-212348d391cso30536785ad.2
        for <git@vger.kernel.org>; Wed, 20 Nov 2024 04:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732107515; x=1732712315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aG0yHURdM2mompgHXso+6B4wAaWU18yHA6AjBwbwU8=;
        b=UAHQZtGOh++uCtrZ/b0KuFOR4trp09cu00Dqpg4fQxDBjO/JkOgr8wjtPn9fVwdOLH
         qSgBUsa7Rvj52lDM4yFtZLpNbktT1R2v99ahL7V7e6u0YT2lBZveLQPGrJn4S+qyXosU
         K8Ctg9PHE//dZYI+H/Xf+wpq7lIVXHVaXDwjVzLenjDnma9uVwMnSxv4/cy4123+ejo5
         0UfXte/JjZZyKXO5sCenm8JtuJiZHOOzfRgbQ/9DxtjXDFsZk6iyGASxaSKEkQzJ3ze9
         Aw0cn1XfkA/G0eLz2Ym/CxGnhUxAwfwKpDJgPNutQY0lUA6NBwA3498jNstvM2lN6HzA
         VR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732107515; x=1732712315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aG0yHURdM2mompgHXso+6B4wAaWU18yHA6AjBwbwU8=;
        b=LcYEZTjqtf2FXgw23JKn2vCNg6shNBAxW8wLrdDag1+UMsgcXGrbivB1Q4Wj9mKHqa
         udV7tYQjLqnHpg+WC7QV3P/XDlxyyBq2NJLwY9UcWnDCI4u5FbpJV828ks0tPWnKv+qf
         lDgAu3YVxjlqnH0Tx8NYGHx+hHQ+E6D3R9JXkx3LFP6qCPGJO5lB9wXZdju88LolC9UE
         kGbH/ZbH7CaWF+gD5gcFd3bVDUv4BtDBWm1oba3Uxj/6lX/Pr4N1CRtgkRNbotAQGPB1
         J3bUSzdv9MCDJ82S10Ru41ZDDo1zgYMYoxg7OannEVhAD+dUz43ic//0Y0CTpfS95aQy
         SIrA==
X-Gm-Message-State: AOJu0YwQrg8D5lzMNz1sSm+GJJFudXJHyk8dngpRwRD4/Ik+cbii14+e
	d9T2+IHQUCHTaSteuoeh8WBZibJKFC89/SUaWC3FJDHIj3MwOfYy
X-Google-Smtp-Source: AGHT+IGO/OWUqx/jp+AHNA7ojOPWRlvt2C4MLhhBObmtnE5ymF8CqTAjuC1GGpCXxlXntMb7+tpbJg==
X-Received: by 2002:a17:902:d2ca:b0:212:29d7:e435 with SMTP id d9443c01a7336-2126b013a2amr31003655ad.39.1732107514667;
        Wed, 20 Nov 2024 04:58:34 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e9d0c389sm77857625ad.161.2024.11.20.04.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 04:58:34 -0800 (PST)
Date: Wed, 20 Nov 2024 20:58:41 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v2 03/10] midx-write: use `revs->repo` inside
 `read_refs_snapshot`
Message-ID: <Zz3dAZGAG3BupQqE@ArchLinux>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
 <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-3-e2f607174efc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-3-e2f607174efc@gmail.com>

On Tue, Nov 19, 2024 at 04:36:42PM +0100, Karthik Nayak wrote:
> The `read_refs_snapshot` uses the `parse_oid_hex` function which
> internally uses global variables. Let's instead use

Nit: s/variables/variable

> `parse_oid_hex_algop` and provide the hash algo via `revs->repo`.
> 
> Also, while here, fix a missing newline after the functions definition.
> 

Nit: s/functions/function

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
