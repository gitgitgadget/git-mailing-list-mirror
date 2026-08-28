Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45B288D0
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787907955; cv=none; b=oAqRrQfLAPwkOnH77mahd6YFw3USgHKURtpzh9oySimxym7YdSUiwQCZ5gS35dJVjW9OsNdDX2fHGL0MCVQN1Hwu/OQN+gBgOyVWPj2Wrerb9z11oVEVGyW4vzMmx/2KXsej8JeI2AXhHxndwKCnR/VZcY2ej7YK3kxpFaypD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787907955; c=relaxed/simple;
	bh=H7VyI5/pGnbv0+vWT7ePLEe2J4a6LRkShOjeu5mN098=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=ZmsKsqV6ehS0oImYyeeI1BXItf9DfzSs7pNl2Zu36+VvhUwqP/CHS640ba/urD7GZAHaO2aQEXTzo+QRhEtqemz8+uRbBwzDq/QFPlItfwvQg+MVkJOo+zf+x9i7K7l4WTEtF5w+XYAvoT+zdvLwDoI8hzrfqJrTxB9yNkJmYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WykNfHsO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WykNfHsO"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-39686abd426so721802a91.1
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 02:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787907953; x=1788512753; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H7VyI5/pGnbv0+vWT7ePLEe2J4a6LRkShOjeu5mN098=;
        b=WykNfHsOQa4SV8iFce0aiazgHszNzgLDYEjvijkk92BEVZ6smJTtVTxBfUzm1mfYwK
         7VQMLFW8uXtRnXQufZ2dagOG24yk3wpFq5uxJYSl8mfNmosDCW5rjKap12dTb30vzsSK
         83Rq7t9mUb3WMhILrZqV6js7uCm4nzSBHG/fLyH4aNyr8cbKK8HMwoKoeFWuqyYw6P6b
         qldtA2faHyT66pFNT4TTUvzmeZ3gs70ooG/YvxBtHWS2KdeYH6PnRviV+/QTYhkehtQY
         RSwkXKCow36R9dFPy99gFR+UYl8EEcQGsiIvEZjr/lbDnlJ6tic2F7QwgKUlz7zHlJtk
         nPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787907953; x=1788512753;
        h=in-reply-to:references:subject:to:from:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H7VyI5/pGnbv0+vWT7ePLEe2J4a6LRkShOjeu5mN098=;
        b=Mjp9e8SedI8S1O1I4g2APBXuWEIOfsfyRqJAkZ7BGVwesvvAVaYSKw6RMaa3g7f/KR
         BpfAXZXXJnUCFesLNzEKI5AlWN6isQX46jpS57HtxGdVGhh5OkswiBuz2oqbrkg2EAbM
         F0VTYFyRUwufVPuXyVn3nZaorRqk4r1iyxawYSKB0XObhsPa85zNuUrzDZ1bKuK82Wci
         94XX90blzlSANFUos0KN1YrSPqe3Phhk+mtFn+0FFt4vRtBZ5FVFbbnCNQxyQvbDKpM2
         gS/tAMeLowKKfyt6RK7mx5x+ugS7MpqfzjnALWK1wtutuKWBZkOL5ZZmHeU/dV8UqTlw
         MpnQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7BMfrPs+CEr1Kqbitxt6u44SsUwBAalP+Y++0pZBQqSSHF7NxD02Hfj0A59FTeijXJXs=@vger.kernel.org
X-Gm-Message-State: AFuF++knU7ktjtoOwar3oy0MEB3j7CaLC6Vw07/ckpp2wZTAX2I2YBYt
	Z9DQh9o9EziKws0FCLYbSoSsmIzCa5T/WwcYnwpUPQFnVPtY+2/coWLgA/kIuQ==
X-Gm-Gg: AR+sD10hlSo7TaWWP31p2M04tiwVt566ihOjlOFXSKlVCjq9VzhZDVQajipQO/DsiHV
	r1nX4OPmoBrlf6+0LRBQ12/Y78Kmn7V6Tut1vbCV2yo4Ff4EW9fs0K2SH9smtNJCSWXHRuaNAci
	mmKpvcCpcHWPPMARw7rqz2ezqG65BT3ANcOLutqrywtMKwO2jNdBk4xey5/QruWMAlLE9HZyTKw
	y2kK6LZsf6lSWzikAlunBtqOOknOsIbl9NN1CLtqAom6WSShUvebsetLUJYN4m+Irzz/KT/D7zt
	a3Aocn5awqnSI+dSreOb1TsFvtR2R6Lvf7D4i2oCY6Lt8oPfE0dXlTkoLvzpjp8pBzB6abtA7dL
	CXA35h8z/YJZfl09thig1ZzoAKqYs8o6rVwbOusQHJz5id5LYkTU8ikFa9ZyOtCwBuq2GaXzLJb
	g5AH6t28S07k6G520jb9weX9jX3IievBNCq3HX6zLjPzcpE9YZyN7mMhswcENX
X-Received: by 2002:a17:90b:384e:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-396d104d0bfmr10213524a91.15.1787907953260;
        Fri, 28 Aug 2026 02:05:53 -0700 (PDT)
Received: from localhost ([2402:3a80:1fd1:f8d2:5f8e:d60f:4dc:42b7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f99585csm3472292eec.21.2026.08.28.02.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 02:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Aug 2026 14:35:47 +0530
Message-Id: <DL0GH05O36T1.1J4TSL2PU73TO@gmail.com>
From: "Hardik Kumar" <hardikxk@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
Subject: Re: [PATCH] do not pass "repo" to builtin commmand implementations
X-Mailer: aerc 0.22.0
References: <20260827-env-is_bare_repo-v1-1-aa99600dc213@gmail.com>
 <xmqqo6en8jof.fsf@gitster.g> <xmqqh5kf8hqc.fsf@gitster.g>
 <DKZZYSTLY6TX.2TDQEBBOG5IAV@gmail.com> <xmqq7blb8g04.fsf@gitster.g>
 <xmqqmru76ybk.fsf_-_@gitster.g>
In-Reply-To: <xmqqmru76ybk.fsf_-_@gitster.g>

This would certainly help make it more obvious as not use the pointer
parameter. But would you not consider to eventually move towards
something more efiicient in the future?
