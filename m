Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F891798F
	for <git@vger.kernel.org>; Sat, 24 May 2025 06:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748069706; cv=none; b=nV4OZGDhiqT4idor8U0OwHCT0dIi+yMa0KM8iy1ZFkkwxXu2aoc/r9EHl8cjNukrkzeaPhPtMwY0Xi5SA0EvxcQ8dmhRRujFHrZvMXifnIcqH8NsHWeGOaiXzCOVNPUWC/FddMzwbmAvBkYKpYiv2h+2uUencqDV2Au5u2DKgDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748069706; c=relaxed/simple;
	bh=7fe8uvn+arfBVUuMM4JELnJza2Wgb5SjYYW/rCmFA1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iPIyKvmN1E7L5HJ0qyvCY4oi68S1Jh4o8j1WIpVwIQiWsmGXpUGksWgAFk6cldEyzA/Y85JngXG5mq04WXUt+Y4i2pUQaD8WT5IA6+XKYrQAp+623krEw43QDjB0amjhxK5bD1y7EiXGRDNW+wuKgU+du+nvrH86I/IEFEZkC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjLaJHAA; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjLaJHAA"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c55500d08cso52531785a.0
        for <git@vger.kernel.org>; Fri, 23 May 2025 23:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748069704; x=1748674504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7fe8uvn+arfBVUuMM4JELnJza2Wgb5SjYYW/rCmFA1M=;
        b=FjLaJHAAkliLfhKsm9nWYow14n581o9WwVWZk9QljweosudqVpdH+cM3FOEOjxyWbg
         5BZDwGw8x5jAY6jmb5iVFpwd8teSO+ifzgengAYiDXQboy5N0GxkwGDeD99m6qIqPcDa
         HXFUTs54j0eD7xgF87M8NZVEkY+xRk1L8PdTH5YMF974paBNtqBH9PbnbVu9EqKPYtxi
         Ip/L5NQbScqF/f5cbvi373jMY6BMMhd51J+KngFWrbogx6EOsrLbUF1yH9sLaBs2sDoS
         83MCkuIrj5GGpGI7OcFDmJm9nlHdlrJWAZT322pEDIbpsh+WwykvhC7MbJGSYePnwFIt
         jyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748069704; x=1748674504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fe8uvn+arfBVUuMM4JELnJza2Wgb5SjYYW/rCmFA1M=;
        b=A51aokDfB2jVzV/HB12sglT1DDeU058IyJX/LSB5c1CqkxY+gsHmgN5seQFXIQvPpy
         ZcbdIXRrrR1NkhmVYWv7xHqLQXZ/Q5SumLCzq90VysRG/GrWSA1GT9jHfO9jHvKmv+4z
         sVvpDNKKVAqW+k4dwDSGLkwzTjW2plhkqSHBmM0GcFRXaMH9RPIDtEuJ49DI4Ru3CYey
         Q6PGJTCaEKiJVIM0q29qACo8YaOydeqMi/E2VqjdMo4OwEKL9ITQj7zwEodCWN2SlVvB
         yCKv/y7l9e6iGzeUcbdjMSwqzdFoRWgfcJcYJwqAOIP+VATHhoOVptQ6GK6aHs7NiN2b
         FVrg==
X-Gm-Message-State: AOJu0YxrcPq275JjGFbpafGhTfy0RlJnAL8koDylphSHI08EH/ySHi9N
	A1Sobsmfbuy/ANreEKHqnkC/NWUCvsvk0DlGlxInyQvPCJOVrqz3oTOIZkSUvQBdTIc/V3lz3L2
	AyXvg84NL1E5dXAu7n6baWvsAydnzJLU=
X-Gm-Gg: ASbGncsHcHzUEjoqSPefTLb6WQ+gDuLpeJbMDrS2UpSlLBFEkfTnTIW4CXUW8D+9AS5
	okn/sY6bABEX1Zdnmj/etiklzSNV2WAJG8+9DaYfT//SbZpi2OVpYP07Fuc1fixg4f2O6EXU1Qu
	7XTEMvWXZr3YpUBmqylxd1Ju48yPCGhRnFvsqMsMF44m7pbOKFvaPZ7OJrRituPDpO
X-Google-Smtp-Source: AGHT+IG0FDlMxgUJPnM9eT3QseZRCqElSwfCyDiKlILa4ntpTYArj67QMhoYc8VyrdMlo2mTlltX1Kf/y/TuRvoeHWg=
X-Received: by 2002:a05:620a:f15:b0:7cd:1f0f:f61d with SMTP id
 af79cd13be357-7ceecc44736mr329804185a.54.1748069704280; Fri, 23 May 2025
 23:55:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqsekzjo7g.fsf@gitster.g> <20250524064847.51900-1-jayatheerthkulkarni2005@gmail.com>
 <20250524064847.51900-3-jayatheerthkulkarni2005@gmail.com>
In-Reply-To: <20250524064847.51900-3-jayatheerthkulkarni2005@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 24 May 2025 12:24:53 +0530
X-Gm-Features: AX0GCFvhK0iKJduI8fTtGQOhh--L_SXIBjqDBAKJIn0iu8991UzaSmONOnFSCV8
Message-ID: <CA+rGoLdbZvD_aMfB=J_cJay-4Ptgf+=R3es9vmdrsHkGhCtPmw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] submodule: skip redundant active entries when
 pattern covers path
To: gitster@pobox.com
Cc: git@vger.kernel.org, mlell08@gmail.com
Content-Type: text/plain; charset="UTF-8"

Since I added the helper back
I wrote the tests for the active part of the problem too and separated
the patches for clarity.

I also ran the tests and it passed the test 9 in t7413 and added test 10.

Thank you,

-Jayatheerth
