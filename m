Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EF62F7445
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256000; cv=pass; b=UzYvYaTBV8RLvbWZGgZjSSyq9Q+cnh3nB75NQ0Z4OzgbFwWLhFA18tt1JuVAafwv1WFbTmCoZpJdbHW3QKovdgrRmnk8kLlpAuCWSNBC1cU9QbKBt2uApdGo4/nwZlQgNyaD5Hg8uiELOYdYTYibbyIlmfR62ihTOUnfYyNrq2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256000; c=relaxed/simple;
	bh=c0JYJdXtD5MAjXJKNl4OHG6DlJHAGMj6NkU5yes7Y3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsHLFwfAoPHbQLDafkRF+7RdQHK8sv3AkAh9pCjLlMRwjCY4/KM5sPkY065wmIBjbzpMu5Y36tPIu/UvfREVLEZaEP4+OZOBoR7UbqcSHS6gqvAr+F31HA7Zz7IiWsbKpW+lA2pvk1jcXvDR+xvie7zZ670qIacWRFN7oAGpmWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TthDtmIY; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TthDtmIY"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64ca09f2056so183008d50.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 12:06:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773255998; cv=none;
        d=google.com; s=arc-20240605;
        b=S5ybOAHZxgqydx8EsShUTpYF6JPu7XNJOlfqYp+uspLkRtgec6wlynBPHOZ+GsUz4H
         w69/jpVGoMF6/+GyCsanyyqgSgQvn6zrm+Hxj3oh+nxmm5vpx7JxZcFgF0amzjoptonD
         sv623cj7qas5qhl/ZIfOOBLe6aKz8PKDXsMq83/4AsgVW052qfHuLtfEp8fqPzPWeoJj
         HBqlX6cTLNldFjL7wigx8/HIN9fhnIqOICQzyeK84JZPqXFvzN6H9o/MnKB50LeRX5mk
         iim3OB0mzXGin3O6bAR7Gpl5Fh4KWX46Fo07N93Gq2mTEcUJdZbdpOGDAqhBbfSiknc2
         ptBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HYwkT8mumTd5mMlP0514fuIEcoqF4r8V5dRPH34zpUA=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=Nld8hkedojJ2h6lPEf+NaY0SEs6L2WXFY8OCp0szK7FfzkrWTCNDad3zuOfai1QKOt
         G5zVH5w7cfZcIJin/TPWY3QJ9GFJgHRqXFuMOEQRvsXrDmp3Km5oX2FR+21Jwm4nkl9j
         l50AQoB5ozkzsHk/RNm25RefJF1NTtV2ttHIptdsKynd08zJcK9xp9ToG3P1eZ412Gfd
         GtUKlEaNax96J9TX0qOLIRHsUDoj5T7DtZ5Fw73iaaMhX887AkISf93ct71LFZDtRCJU
         ewmt5/54esGMAsZVauMieotR7ezOXBfO0k4uoexCAhWJiZId1OhBLXrKm2HyEgwZczWE
         Kkqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773255998; x=1773860798; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYwkT8mumTd5mMlP0514fuIEcoqF4r8V5dRPH34zpUA=;
        b=TthDtmIY7Rt0q9AQmyNw8CMpAx9m+Tp+dS7xDpUCMNHnf6/7q727siyXBRQ5D4K6Ge
         WeVZ2g57ReRz0iGlmS3wsXatsf2SLDLjmhq0IUrzVCmQzoCWYblV5MfGEtDzu0BOVr5Y
         40IoKaMqOd5X916ZuIMFwUbgz4Wsdo/5QaCkuTHUzNOg4u1ORLMaNlD18d5iIx+diy1o
         AYnFXPYdC/BHuoeoQSfwugAnQR/yvpE860hCcbA3Inu01ENAmMYSbKB0Pwo5PejwKDHu
         QxoDyDfg0m6CbZh/baIGoM3eZRJxKnxH5rGgM8EpBoJuHlO1yKxjwNce/JV5QMX7blHL
         Rjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773255998; x=1773860798;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYwkT8mumTd5mMlP0514fuIEcoqF4r8V5dRPH34zpUA=;
        b=RAgKJ6JGqOorKnWJtHkfy/0hozeBCBHHFuTVBSQM+MPELC73ucwbtn5yKxKeopLejA
         jANatzwFinhHKtxXBsvmdfsXILEiheFiQG+HGPfikhgfQTNYy94C4WDwMoMbnFDvm98o
         o9+2l3QcayE2COtrkgr3qcPAjlfBeTJndLozGdxZcwezjaMkuZS/Oh01wJMzxNrLJbbg
         CrRQUb6Dkdi9CyWPGWJ6OejeOg8LXI82v6wlZYB3FLvaXxeW38zOElD0WK3IO0haB8fX
         E3h+WZAyup+aH3YmFYek0LLNTyGDtL5ShN0S/BaiQ0tCGdEsWbnRaDMIrmLn1Ctja3sP
         LDBg==
X-Gm-Message-State: AOJu0Yy9M8XhdpxgVeRofLfqBeupo8dqPH6UE32NJqtbU1Fc7zybMFJg
	TzHQg6KA5vKkSL7lBwSplr/XeXJX3z7hNyHL7Ttjox7I4j2WS34UVAp+MtvhQzV0aXjtUdzpEdG
	2qu3E9bIeieiRxED0USlZMPu0G0/kOnmiXfPq4UI=
X-Gm-Gg: ATEYQzyVIkrWmf9BCmoyYqtMMuRFF1l73mimJiuEnuEaX+58F8kCH3f+KGvO6hFVbHK
	fh0VOSbRalKI3eK9lq4YTu53IfpWssabA1/oQWsMqTnOWqoiOVCA7/xgozSWIKkh8oWBYz52srd
	rlxjw6yFGL5/a981Rhs07ax4s8QxVAAIn36GOhO1dTBaJcOrqSGxjmCUk3IdGmRWtTKD4U8+bON
	Bl0Rt1aeeAXnWR+MZOmGH7AJgEGACnEdThoABK41dS7nTS1ObKUpK0RrA66WSrmaE1GgLYKGq33
	4WwgL7pBsb3tldCZ5fZsGNLxOFPFUjpclNurFgZHQdFkSyfeItd+bgo3+1dBkN0ePFCJxRUwjdD
	Pjeb/YcG0GhLEk5JQ34p9VZ8=
X-Received: by 2002:a53:d242:0:b0:649:e501:21af with SMTP id
 956f58d0204a3-64d6569d0fcmr2534205d50.14.1773255997908; Wed, 11 Mar 2026
 12:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309150935.578465-1-pabloosabaterr@gmail.com>
 <20260309230134.758107-1-pabloosabaterr@gmail.com> <xmqqwlzip82b.fsf@gitster.g>
In-Reply-To: <xmqqwlzip82b.fsf@gitster.g>
From: Pablo <pabloosabaterr@gmail.com>
Date: Wed, 11 Mar 2026 20:06:26 +0100
X-Gm-Features: AaiRm53pdNLNxqsxUTjAd1MhJINKs59kyrATM3De1EzrShvI_YfEz5Zu9mijUns
Message-ID: <CAN5EUNRZQP6ATE87AeZiJx-OTnNn_4NxhW4zyH6AspGUfnV7TA@mail.gmail.com>
Subject: Re: [GSoC PATCH v3] t9200: replace test -f/-d with modern path helpers
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Our test-path helpers should work even outside test_expect_*
> functions, so this is not wrong per-se, but it somehow looks a bit
> unusual.  A related clean-up would be to wrap the CVS initialization
> part inside another "do we even have a working CVS installation to
> make it worth our time testing 'git cvsexportcommit' command?"


Thanks for the feedback, I can send a separate patch to wrap the CVS
in a skip_all git move the git setup
