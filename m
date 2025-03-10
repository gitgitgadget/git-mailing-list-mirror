Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DB2221F20
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741650823; cv=none; b=iPG+SV4O2qVJiRE2T34GCFSvCzqvd17HBDUunreKbmoCiNGUtVsGbJdhAyJp6lEfshN3WLhefvOTyq8QiSRlva+ZKiytcs1jpg5HieQ0Mq0HDt5KuG6hGnj9XNk2T9+KwHFrp0G9hl6IVEnPobVtdg/CPk4ZT0/hNjaVsfbxmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741650823; c=relaxed/simple;
	bh=pfTyfACMK68dYRAOXMOahQG2KweMw4jPfhJWu5KP+6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nqZ3X56nGw1nsA+lov58lsofLQ8DBXRhBrgGI3VjNAq+tVimoYUCSlZA7mRwKZJ5KL6dChU8x90qQm/8DgA3DazuvHiqXUXV/jHSp7+1d5JOgAjeR/Z2ZehnaZNUKgQVhyH+/6F42XXWqpEmZpnw+2LPoF56GkZOm8+oxXbozmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c3bea983e9so49250685a.0
        for <git@vger.kernel.org>; Mon, 10 Mar 2025 16:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741650820; x=1742255620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TGEaNcqSUgdgL1xJA7rcPN/n9dt3n28YuptZNToAMaI=;
        b=IDAxHQrJtAfu77Ka1femGbfwJHUKCBMMMv9u5q/xk3FP1MsAn7a2xdL1XyGqmMQuw2
         w6SZRM78gWQlCk52KPcHNzz/jUwNJkehuEnm6OXe0XfXi4JV+r4NSkHKWSFCL/iMs+nx
         L2Ksqs6BAG6A4m2KXeamysaYCAv7XjZCeCkG4qggcOfEdNlarEPPP54cCJTGjoK2SL0k
         OQqRf3dSCW4/9W7HHtqKpn7GCFhKB/sTDsIq+yKAc4BFtI1r8PoL5oOWE+Dv+qKiiUrL
         KUOGJEDxUWZn6RjPwo/miLOQzdrB62d1o3UYvdTUTpgM7yRlvbZjg2DngjJqmFElF063
         Y1AQ==
X-Gm-Message-State: AOJu0YzW/RQV64GYIQTid+aTHLxmJZfsEKMi0tVi+3q5zYVSWOCmZShn
	EJzYxrMNO8uFuHvN83IXPX5ua3UUAwCJs+bBOp6ZxvJB2n3ea43LunCVqt5gKqy5k8RlobPg074
	XaAXAY4tjsckUCAqbi/jFOn1XS89Yn7+s
X-Gm-Gg: ASbGnctLvdzfg93KlijQTOjUDqsQ8YUUwx4Al1hSWEiMmVU06vFJyOXz9xUbxnyq0MQ
	TrL6ltZnPlrPZZI0MUVgZucTf+La+v15q7sqJHtf/Q1Sqq75hUTnb0LG4Xk1vc52y6SX1i+9038
	03O2NdR5Z3a/3j4BE1Q+Sq4D1O
X-Google-Smtp-Source: AGHT+IHA5skuLR1Py70QflumNgwUdT1BPNIiDQ9O8xUM4Cf7+p03yBWHYQvM967OmWQm/Q+qqBqmdBN9hrlZj7B9rFY=
X-Received: by 2002:a05:620a:31a1:b0:7c3:d798:e8ae with SMTP id
 af79cd13be357-7c53dfeb3camr564727185a.2.1741650819899; Mon, 10 Mar 2025
 16:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310231652.3742490-1-gitster@pobox.com> <20250310231652.3742490-2-gitster@pobox.com>
In-Reply-To: <20250310231652.3742490-2-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 10 Mar 2025 19:53:28 -0400
X-Gm-Features: AQ5f1JrKCHPD4TkM-lQL9Wab0LlyXdxwGOLvMeMnfcmtKpnZN547i8rQmu8tlbA
Message-ID: <CAPig+cTRNts9JO-17rfkmmwyTJojJSv-mS1kvxCJV+L2F2WgzA@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] t: introduce WITH_BREAKING_CHANGES prerequisite
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 7:17=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Earlier c5bc9a7f (Makefile: wire up build option for deprecated
> features, 2025-01-22) made an unfortunate decision to introduce the
> WITHOUT_BREAKING_CHANGES prerequisite to perform tests that ensure
> the historical behaviour that may be different from what we will
> have in the future.  It would inevitably invite doulbe negation when
> we need to add tests to ensure the behaviour we want to have in the
> future.

s/doulbe/double/

> Introduce WITH_BREAKING_CHANGES prerequisite and replace the
> existing uses of WITHOUT_BREAKING_CHANGES prerequisite.  Some
> in-flight topics that add more uses of WITHOUT_BREAKING_CHANGES
> would still need the old prerequisite, so let's keep its definition
> for now while we'll eradicate its use.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
