Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ECD17993
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 04:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916265; cv=none; b=JlJ5n5E1omTSpg40JgrPLTOCoAtvVXDFG6RyXRX99qp8hWWw25qMUDOBPAA4QITtAvE1lKn6WH5cQBXdTmGCQvaxE/VwzVqXIZecSP6QmuAOM59GGmCQ9szuEzed8/YGhNOrv0iLZkB8pVI6xtr0BTOohJtZW6F4YBwvjX2SRvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916265; c=relaxed/simple;
	bh=pFYTOE0/BjnVCbHw6nOtSxCaiywWyqNOsurFGUidRkU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=oK4Vk8v7E2314pFtK9++mV6OwHg01/T0BPZV4PuOTS647S2jWSmHHNBQLOpmH8GagydzYPKD7HcvvW1Movxf/TYdYMrog0jyxXcDC3uE3ks4Qf7FOoqHoJ491az5Kq7NNivEjWPkpdGVleLRq5eR8G/Vz6Ceujr834WbBepAjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=GEBqTiud; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="GEBqTiud"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-81adacb0f81so1463805a34.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2026 21:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1790916263; x=1791521063; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tl88we1gvZsPBb7ZsLuoxZqpRttaZiPOx1fhvaNOmU8=;
        b=GEBqTiudbiLNTrxXdTHVuzuVQKiREXIKJQP08o6j3MK3JpPwonxxPw6XjI3g4SNLzf
         8+0zHNKSYb/3EUTdJ0Z/y1q2xj1qHtiYFP9bRkdG86Tcv7BCjmXm7vwFtyf2C6bYgz9p
         U/m+zv6Xj9atTdos0U0TvAzCNaHBev7hdfusIQ4yoVj9+2qXwsDe9QJUks2TIfzKWF7T
         aNJNl4lIyiPeFyYANdTe98D7U0ljO/xt0LO4/gUnVwiKrNrCHQ2RvC25HCa4+zkTGmoy
         nq3QnMpr/fKsOUns9FfsQfVr4VuuZIJAfpODlVSa0rg3dpBJ1jr8CKQJRAi17YJyNmS7
         wffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790916263; x=1791521063;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tl88we1gvZsPBb7ZsLuoxZqpRttaZiPOx1fhvaNOmU8=;
        b=jsMXg10c7sVi0GYD25vuq1bF9eupMpBMK0RoyPUOJkZJFBf79kWkQgt/NSXE4P3u05
         yRn4b2IE/s+jwY+uWgJvkknEeDZNNl9NTLmI9aPiQTDwfU0EczUmzDFqxR8nbGkn0PSK
         297DkQoNYnqYL/9+1PhXlXXcjLWtN8TIxropJTYnxMpB+EWRxgJLJ3zd2yHs8y+CZCcI
         AAkuS2z7lG3icrGYUejEYIiKxTuEkFXQ+DQrsArv4Ee7UxyOLZRcappajGuvOdZsLxCG
         Xh3c2lNyvAoubtR9Zn7cxxSU73kG77W6W6WmrlricD+taeQGjcUnbYkS7EBNZnUtFPS2
         W7hA==
X-Gm-Message-State: AFuF++n4pW3jBTDloyJW2V1OQZqGy3bR5TB135A7RG/9Iity6n0h1vS0
	NFrmEY2aWWzPDUHXNMkvB/pnUGqNObXBydwTa82C9DxdAYLt0aV3YMZ+5pcfzjYmGq0=
X-Gm-Gg: AYBFou0Prt9cgRdPJtU2G1lRAsJUU1+ME0U67mgjZaHVpiVdXMfTfoB+OKI1IuQHtb/
	ezZFcanPCRLpVJRPSLUYlpkugaPczQ/V0GQwZDdUrLpwBCWbIi2t0hAIONr+6UW8SmlqE/Y4GPg
	O4i69QMTSJPNOFr4sN7K0agh+gAgk6OGQgDVnSc/vH5a6yzMqmBwSDpbZ4YkZiCIC0ivYMcLJLI
	zVPfkowwfWh8YCOBpaCCjfmmU/eeHxsOi7+G6l2vSR1ur9kXw0c6yQ31U4mNdif0gbX+sFd1AXr
	OmgQ3jnbnRtVCD39DlNSX5rcYe3jne1y6S7rhm9q99Og2Vqb02d3Q8Hl3aQjQ7rMOmh4U0gjpcD
	BwLKsUjtlZ9sIgDc2ZjveOrA3Fg6j559sTqT1Nm0BwjlClTu88vb+CyDYKqEnwP9dFp2Nu4UtV0
	38n34KiQLJRZwTbii5HO1fvh6SygY9+W88ECqf1SO6uubu2qkEojZs5XMkVeBgn88NGfxleO+4J
	NcT5aFyPw9wGbJuOuAIBR5HmE3wAtx2W1T9EYKEsuienB6kKg==
X-Received: by 2002:a05:6830:6f82:b0:81b:a257:70fb with SMTP id 46e09a7af769-8228495edd7mr1514347a34.7.1790916263386;
        Thu, 01 Oct 2026 21:44:23 -0700 (PDT)
Received: from brighamcampbell.com ([73.3.69.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227a16aaadsm1999919a34.18.2026.10.01.21.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 22:44:14 -0600
Message-Id: <DLU2TTDQB6OQ.5FQZGHG1AGZP@brighamcampbell.com>
Cc: <git@vger.kernel.org>, "Patrick Steinhardt" <ps@pks.im>
Subject: Re: [PATCH v5 1/2] git-contacts: allow inputting patch via stdin
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Brigham Campbell"
 <me@brighamcampbell.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20260928-git-contacts-stdin-v5-0-e9becaebc47e@brighamcampbell.com> <20260928-git-contacts-stdin-v5-1-e9becaebc47e@brighamcampbell.com> <xmqqv77ng8kk.fsf@gitster.g>
In-Reply-To: <xmqqv77ng8kk.fsf@gitster.g>

On Tue Sep 29, 2026 at 1:29 PM MDT, Junio C Hamano wrote:
> Doesn't the Usage comment at the beginning also want to be updated?

I'm inclined to agree with you. I would have updated it had you not
commented the following on v2, referring to the Usage comment:

On Wed Sep 16, 2026 at 8:25 AM MDT, Junio C Hamano wrote:
>                                                       Then this line
> did not have to change

I took that to mean that v5 did not have to change the Usage comment. I
will update it in v6.

Thanks for your patience,
--=20
Brigham Campbell
https://brighamcampbell.com

