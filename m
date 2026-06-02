Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582EA395AC5
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425337; cv=none; b=J+F3kzJpyeF3pRjWAjNu4pJube/5yM43/5zf8WB7wVxL0sMixBlgOqotNc8srapacCgWypMu1sjEW67Yuh6NLnHooAawEDdU8i5iun6qFY5jmYpr8IX3I7udkqqSnc/bH6hWmIBkQxAEAoHSY1wBfxyH6eHFIR+IgOwnb91z+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425337; c=relaxed/simple;
	bh=don3y1xYOpcJWU5+om9KKIwc4p5WaVBfAxdRikqZbhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlN1D9bAvpSnBAmNgaqv/LR/D1eFUMwlRnQxeTtmCIjM3n3leg84eVOfz0U6DSWwP/9KNsq8ZT14hQK1oJyyOxoO0rW4mS6e3+m6nTuWyE17tcArHqPMJ1V7xV1DuNxBGTDeKY7BU1119dLeUjojR82T2jtpy5kzIq/rSEc1vlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfBhh98T; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfBhh98T"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-45ef0ccccfcso472122f8f.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 11:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780425335; x=1781030135; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=don3y1xYOpcJWU5+om9KKIwc4p5WaVBfAxdRikqZbhs=;
        b=IfBhh98TV8uK1ESMfYK7k8bpxRAd2UfnwAux6vrtKN5/iEvy3ugG0bn9ywTalDfJ0O
         a0Iw51zzyoKZYnb2Z37FIOaVVgUJmTK762Gg7tzuEfZ0CGn0GVI1t27D281umH7TGoSM
         4a9WrPodd5Bt6OQy64cL3uDCyXtvrpDyAgruWpz+6FweMELTwz0RgLnc/WRQeQcVqUGD
         cc3KBjvzBBB7BnkcrDYPdlhQc7JWUrd8djSrHb9WRBOjhGmrNLI9q7hGS9YUY5CK9uoc
         gQRFcfNa4kItaCVW6LKnTHtjq2b9LMAqIfxjoggpHozk5DVVQRuc6bna63PpGWx3NRJX
         CfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780425335; x=1781030135;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=don3y1xYOpcJWU5+om9KKIwc4p5WaVBfAxdRikqZbhs=;
        b=nHMNiLCqDVXdzJcQS4C8TNQlyWGrOPeCEJvLelxk5eGBfUh3sR9x2Rqx4oXHp7M1SO
         G4y+Kp+7V/7xZLjAFYgS4UQSApp+r/VDukVw3npmHzL2+g5kP4WEEHUFDlfIoPXoAA+G
         aKM6Mg5bv9uOYDkxUyzSyTzl0oEdY5pWF8s9UB1avtM4Ft2lAtDMPB9AAvMkYniNKDav
         z8CASmOFeOKw2GP396orhQAMxVXOzrubfDcEdIzzdNLiTRiNElAvBjRdam1g3zzuzBpe
         btTdJF7PVe/KEryUhfaWH2F9t0b5ghuJ5Znl1sqMLpIuKe8NpRNMS+IJkaZ//TIi2Yhf
         Ed2A==
X-Gm-Message-State: AOJu0YzywIS6faabFQgwmuqD3h8SW77Z4A1BKFaMydfghHBi4FNntg9q
	vdM3B0pgoJ1SyGO6scFALbxWQ+iAvO2OGFfbhuXwLsMBOMiFDSIeRDP/0+ZhsgEWe4w=
X-Gm-Gg: Acq92OGXKfvdfhx91Bydk45oxUUYzErM7zYtwkysD9vrDiSsejXyb7pUZ27IfQPr/Lw
	ZRw5Uji8puQQfWr9ejnCAIRxsr3BPhh4/yx/Oios+LdRWco4N7oIWfpVpnoAqv5gW8vSacBXpuD
	etRGKX4MYvVsBV1nKHbiQ7hKs1jD/NnzK3bML68vDSD7jbadiiPGY/uYZljXE7evOXehk77am+8
	eySObmGjYTxBYlh1hZ/KjlE4y3dMKRn9vcy7hb/qLkLSQSf3SV8mDE1hJqu2WJ6Nur60dj6XuzG
	KDkU5oYt6y3GnkNuN5grF2+PZUc36VpULXozbPX3nqOWRDfXQMqXQvwKKXQYL5EX1PvfJ1pbh4Z
	9lUeadweZiqXmGz1DaDYZvJ90jDRZjNrspyj4ukX4YdYo4e/Ij6sEBuUVJFydcyYo/qcJFY7j45
	1OHY9isQPpAPhs58Ov1wnTOU8sML36GSfFvKwPhx8=
X-Received: by 2002:a05:600c:5394:b0:48a:5758:7999 with SMTP id 5b1f17b1804b1-490b50b32fdmr5971455e9.4.1780425334618;
        Tue, 02 Jun 2026 11:35:34 -0700 (PDT)
Received: from desktop ([194.127.199.113])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e19a06sm90119055e9.5.2026.06.02.11.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:35:33 -0700 (PDT)
Date: Tue, 2 Jun 2026 19:35:32 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Ben Knoble <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Suggetsions for collaboration workflows in large repos
Message-ID: <ah8W5BL714h9r3_c@desktop>
References: <20260529163117.z2auhbg4sdxxgmis@archP14s>
 <82F556A1-A5C6-414E-8EFB-13F83FA30E44@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82F556A1-A5C6-414E-8EFB-13F83FA30E44@gmail.com>

On Fri, May 29, 2026 at 01:56:02PM -0400, Ben Knoble wrote:
> My current advice is to enable git-maintenance on such a repo, where
> prefetches and commit graphs and so on will give you a nice perf boost. Then
> I keep the default fetch all heads config and don’t mind the noise too much.

Thanks, I do have maintenance activated (I believe `scalar` handled that for
me) and that does noticeable speed up some operations, and I have find the
performance in general for almost all operations to be much better than I
expected (having not worked in such a large repo before). My only real issue is
in fetching, since I really don't want to waste the time pulling down all the
other branches in the repo that I almost certainly will never need locally.
