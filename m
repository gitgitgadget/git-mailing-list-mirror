Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9E17A311
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742333423; cv=none; b=n9pUcP9OIdbonZrKNra9X0CO7DClwbT0EQPj/PlhIcUE0jXGGh4AvRKD6tzvfT8TeXUiJetq+e+iTiXX/HLag21odW/jnlIyVflxhv/RPbKA3QOP4cYFvr/5jHgIfCEjuP123dfMhHu8xJ5DlW3BKBxeWNfiot7LDaA1USsTe0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742333423; c=relaxed/simple;
	bh=FYEKrTXogeOV27B4gXdik4OHwgCgvfdpwMMT1l7T+VM=;
	h=Date:Message-ID:To:CC:Subject:From:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lj09AXiSw7bjL3oSVKvPoIxx7rd5aXOMgm1Fc7DAMzRTPiws2JXHez+Eg31TGgm93s2hGeo5D/6VheVEqTGmpz0CFAjGM2jKDyhdXOAsNSw3zdHozn1BCCRgUbjgOTWmj9DboJUN6BLUcy+YrJZDUW++TBdTwJarCEYp1J+bEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=D53iuVOG; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="D53iuVOG"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 52ILUESm005367-52ILUESo005367
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 18 Mar 2025 23:30:14 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <taahol@utu.fi>)
	id 1tueVp-000Ox3-Pz; Tue, 18 Mar 2025 23:30:13 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.39; Tue, 18 Mar
 2025 23:30:13 +0200
Received: from localhost (localhost [::1])
	by localhost (OpenSMTPD) with ESMTP id 12049055;
	Tue, 18 Mar 2025 21:30:12 +0000 (UTC)
Date: Tue, 18 Mar 2025 23:30:12 +0200
Message-ID: <20250318.233012.1423505396684882738.taahol@utu.fi>
To: <gitster@pobox.com>
CC: <git@vger.kernel.org>
Subject: Re: [PATCH] format-patch: use raw format for notes
From: Tuomas Ahola <taahol@utu.fi>
In-Reply-To: <xmqqy0x2yr6b.fsf@gitster.g>
References: <20250318180251.3712-1-taahol@utu.fi>
	<xmqqy0x2yr6b.fsf@gitster.g>
X-Mailer: Mew version 6.8 on Emacs 27.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ex19-07.utu.fi (130.232.247.47) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWUhZXkguLT4lWFxYWFhYWFBeUVxfSFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhaSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:message-id:to:cc:subject:from:references:mime-version:content-type;
 bh=rdgkc7X08RxT3Z5c9c76NhmyyJjw0xpKUYlKmNFpCdw=;
 b=D53iuVOG/zh8RzjRBV1aKIX9PheyqDwaNXmtZROPs63b2cuRkfcLZpnNOxJ4kfjeg1elChgyYkaB
	upTLqYNHRAB5yi1rYB0qjtqGdnkfcCiztSHgqkxfB1lalo6p+l31PgP/TdlJcxlqd/+BQUeX+WyV
	tmWDqx1nhjDmZ6202XraWzy5SKCWB7qJK5GHfx/rYPVAchNiRU79PcvAvtRpdVhWv9wnkh52l6Cn
	Ko8R4kyhcrT97WY2nA3K30cOR39K9RX/WNjT3AJ64OuW6fuAQataN81nmctE8mtdH/O0B5R3m9sX
	NCm950ZBH5qDvCpLNSp4pW39WUXhRiKtCOc83w==

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: use raw format for notes
Date: Tue, 18 Mar 2025 14:17:32 -0700

> [--] more importantly, the contents of the note loses its crucial
> leading spaces that makes sure that any random lines in the note
> that happen to begin with "diff", "---", etc. are not mistaken as
> the beginning of the first patch.

Thanks for quick response. That was indeed a compelling point.

> So, no, this change is not a good thing to do, at least in its
> current form.  Besides, unconditional change like this will break
> existing users.

I see that similar patch was proposed in 2017. I should have searched
more thoroughly, I guess.

--Tuomas A.
