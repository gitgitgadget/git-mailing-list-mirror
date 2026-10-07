Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FA33C1D62
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791354722; cv=none; b=uYsmmSPiR6t8HAuX8UIurFVAfBr4CxxWvcOHsvnFQGb5G6BgZ3isLwZHipDo66MYOnqBpuwqKCw5kcKZPpZKybOHjlElhmvvkdLZ3AHszI4O34zCXhIA5a3gR9p/CiWTlgAQCm3fAZJVEqN2kYhkRu+2oyrW0dH0veH4e0JauTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791354722; c=relaxed/simple;
	bh=InWkRYbaQmPu17aPdaix+dYJ8Jk0uvDApzq/ogHtOG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqubiL2aIeUKj/lQRXUGHGpoMylRZXhym40L2xTvpeKVq9/yPjCka/rc1Ql9iSLnzseCv1ECNF0QMIKgUhmV5fz3tyYFwObl9IYtVtx4rMLg2wvoa8L0EyGtKAAtT1f0Kx+WwJ9AvGd6HfkzqMiMS9s/ctNFvGMO2Vr0bCan3XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMfxkgax; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMfxkgax"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a16c399641so14545145e9.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791354719; x=1791959519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hu9Mkbh0v5YNMNtnIlMwjKo4DvSI0epksm1cZizQo48=;
        b=GMfxkgaxGamMAjFMezzzU4V4Cxsq+MbbmbV6AFxz+k5LPf1ARmy9eVQcTQvTD8GYWA
         JbiNRwOr9Qo6CcAwQFIr0UwvUrgqffP+iq0qRg3JCLqniXyhKp8pChyrok0m+P9abIYR
         jO42Q5AJtbVAqxLdMrTbn6UnXLwNIDxK+BW1KERFtdQW+GqC1jI+2R+ZhvQp+mhjcsg3
         U+H1xKTlSfuoxvVe3f81wtlYNSqOfma+9q9JmltgJluaieNWk4ShW7ks0Gh4w7+IOo6Y
         mxIjEcd/ArD08ERC3wEQlzArwVRXtHHyQ8GD0/2W8XvEoj22/j4m66h5iCFN3ZnMFQSa
         tEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791354719; x=1791959519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hu9Mkbh0v5YNMNtnIlMwjKo4DvSI0epksm1cZizQo48=;
        b=uHB/+CfzOcJK4aEqe9lcNQHBdl6nO+mYRAOXG+nZxo3nKEbLYLlFGHEnJ6qWY8t5c1
         cfsHEJY8vym0RoPhe7HS1xEmQmkosat/4QTgiMwXSMnU24sCVrBvpeED6rngMoJSE2rN
         dl3dRuutoRScDfO5nurmDa+oAFeWeBjA96aq4ycU0OiCi8nKoAJVKolkbgjLG4ICSf9H
         raC/8p29yjvvOVxKoz2jMLhxsGFxKeL2KCWdX7o6UlSldj0iULnSnTIWES+ygHiuGQ9B
         nBwVZaFvUbIBBqn0alwNih7n4qupxp3uOLQ0CSfDwtM3HQpGYV9NTpOmd1zX0yelZbVI
         cBdA==
X-Forwarded-Encrypted: i=1; AKwUvBzgsC4I0rEHe86DLMOMwHsT5fz20KQ8DqI5OlNkS9McM+47vlJS9hM1j3ssL/6f7bE9umQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lA+mQgrW26R0zpxJuouul0UTXqSYaappZyDauWDKj0p53CuZPU
	bdODAYUMys27Kweq+CiOGhTVBH2//esZhDmZHklDhlHBtEMzVCp9p00K/OOO96OIoNs=
X-Gm-Gg: AYBFou0H6dDd0jub3iIzzSNMtvJDMgprjzvwSjQLt6aWL1h7BxPVPXDBXuWsa7W2QB+
	oR3KYrjSWtTo701LfDmrrW5jzAAWkXSSuM4b2DqGERPVpg5OokqqJk+1CoAEsyhplR/35Xt5V1q
	OaNTNAvJi8G7py9Fde+82GaoSY2dEoJrSDa/syKZl/89cZWG45G8NJ6d9Nhueq8z9hpPjwxHb1S
	Uc5PPfpYfW6GyNAYgNYm/VtFUb+4uZacim2p/m8xOyPPbffNNUKi5GWJlXF1ZhV0HQnHH1ZxAsR
	+QouqEovXTyShPuzSkkstwXNas1tHuY3xzjfba9hHeNxzelJpewqydQ6eMACaV9bAe4kjZ1Nwi0
	SsXkWQX4cowUqsCSPAldDAvDHfm7+rkIukhwcPVwB1UJrxfUeYsAKnc17WUS0XRoWjaCNQ9+DaI
	nVuhgcgdu5yy4jiWk33EdMWcYJ3ZpMefSbpSCXxZyf4WR5UUWFXFIqLacrqvpr6XV2CuDV0H5+i
	JX3P3UGKxwfyPHY9GxjYLKCGjzA
X-Received: by 2002:a05:600c:6099:b0:4a0:1fb9:2f51 with SMTP id 5b1f17b1804b1-4a18043be70mr14054775e9.14.1791354719209;
        Tue, 06 Oct 2026 23:31:59 -0700 (PDT)
Received: from SSI-H-ARSHAD-LP.ssilhr.com.pk ([182.188.28.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f558028sm48089855e9.10.2026.10.06.23.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 23:31:58 -0700 (PDT)
From: Hanan Arshad <hananarshad619@gmail.com>
To: gitster@pobox.com
Cc: j6t@kdbg.org,
	git@vger.kernel.org,
	sandals@crustytoothpaste.net
Subject: Re: [RFC] git stash: add porcelain for sharing stashes through remotes
Date: Wed,  7 Oct 2026 11:31:55 +0500
Message-ID: <20261007063155.4573-1-hananarshad619@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqzewsmaod.fsf@gitster.g>
References: <arw5XxJPNlUxU8TS@fruit.crustytoothpaste.net> <20261005055337.7579-1-hananarshad619@gmail.com> <e1635b9c-bc03-4835-805f-5fa52f09364d@kdbg.org> <CAKPibBx6364BcB2nqyQ7jhTaQMaUuR2TNKzZ-9H8VopcRjXbZw@mail.gmail.com> <7012706b-516b-4cd9-abf3-0144093e0779@kdbg.org> <CAKPibBwjRSb5cXd2iWo8bbYby1odcXNazEg-D9hcqbehrR6g3w@mail.gmail.com> <xmqqzewsmaod.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> All of the three you listed (discovery, transfer, clean-up) become
> easier to work with if you used branches, branches have always had
> good support for these three (and other) operations, and I do not
> see a good reason to add a parallel support to do something similar.

I understand the concern. I think I did not explain the workflow that
originally motivated the RFC clearly enough.

The idea came from a workflow I used with Perforce shelves. One concrete
case is build configuration. The repository contains configuration
templates, while I may have several local configuration variants that
should not become part of the normal project history.

A tester may need to apply the same configuration while testing
different branches or revisions, for example:

    branch A       + configuration X
    branch B       + configuration X
    release branch + configuration X

Using a branch for configuration X makes it another line of history
based on some revision. When the code being tested changes, that
configuration then has to be merged, rebased, cherry-picked, or
otherwise combined with the revision being tested.

What I want instead is an overlay: the tester chooses the code revision
and the temporary configuration independently, applies the
configuration for the test, and then discards it.

Perforce shelves give this kind of temporary handoff a straightforward
user-facing workflow. Git already has the underlying functionality as
well; that became clearer to me during this discussion. A stash can
already be pushed as a ref, so I agree that adding a separate
"publish" command would not be justified.

My motivation for the RFC is therefore not to add another transport or
storage mechanism. It is to see whether the existing stash/ref
functionality could have a more coherent UX for this kind of temporary
handoff, instead of requiring users to compose the generic ref,
push/fetch, and stash operations themselves.

This configuration-overlay workflow is one concrete use case that
motivated the idea. There may be other temporary handoff use cases, but
I do not want to rely on hypothetical cases to justify it.

Thanks,
Hanan
