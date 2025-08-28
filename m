Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B922538F
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 21:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756416875; cv=none; b=Ow8Ft1x1A0bLCkBbETDeSu2AeDMV9aPdjy/Gd37lthCmAyb/soFgoSPm+N36rLSdDAwPfTSQ7r6T3AXGUM1J3gyd4tIvNQz0/vw3C91LwVXYPwkS6oQp0SRaB6UL/WAhjXfJIkQdy/NrQeSWY6yKPCeeF9oQeSARdU9/HzYuifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756416875; c=relaxed/simple;
	bh=87ZmeCcGzMu2w4Li7vChZ1SV9deSJE+1RT4yvTmoQMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYVcgQ/1ZpBE5x/gALNQzPLJFCy5JyGBLFBYrFcVFS4c8xIn5D0n5pa02d/FTdREo8amdKmR/VTieIzDAFml/Vwc9iEWLJf171xRTC+dnLV6wOt5dVPopBs0cRKGFObQCaFc5WOOnXb0YxR6Vv3XJ55aXun6m+CEyhlcyzyO4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vtg0Iofp; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vtg0Iofp"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3ef2efc0341so14335595ab.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 14:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756416873; x=1757021673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRNgWlhlbB2/xPhm+NfJtCwXlpTTTmSJKXTkSUwUY9c=;
        b=Vtg0IofpO5iP9FJp81PH7vDuqe2stPfvFGo9J/Rany4htKWG2CXZVF6qy/nOmrnPxQ
         druSsI48CcA9+au+jh/KqBIelHuc4dGmeNBjQjew7qwC+LWp8NdsoGHd9edOdfyvUcnu
         /qIyITDN2BCWtcPp3hw//X0iK2LV66geD672/yr7tVCs+jj+4K0C4Br6ZfDNj0y+vkVL
         uKLjwQaSmROhHVoY71ESo5nsRBXAhHrQBhwV+u3VuActZB7o4j/C5ZanBXfkbnxBV/ij
         lzGj0Nhd79OVB3N5tkyp1wzPFCO8Ok1YbD72Kjj/cmeJikrMnKo3KaswY6SCAkgj3rQn
         OrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756416873; x=1757021673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRNgWlhlbB2/xPhm+NfJtCwXlpTTTmSJKXTkSUwUY9c=;
        b=l0T6z/p7z3h/f3GwKXpbMVBXDrZ5d/FCTvQxxqdgiYU63LLy8lCerf3meIWR7/5XbG
         mXaSg8qFbWXIGI3umMJg7XTPlAk4+TX6LmZIq5DzA5xr5eJRp2K51WoFaHbySbK5NYdT
         LZ5uJaU5EBesnLIllL+adtebbrcN+wYQGNW8Or76hB8iECV2o0qKpo1AOrFcBh1bPIqr
         T7PW3PM+iHB3ukOyY+OwG4VUG9uH0mIDtYFetQoAieiUzwdeDANLULSLLMuDeiPVvMhH
         94cCorPBeVcCUXGgsw67UL1ZzDnoOGU2L/slsU2ShZ11WJT4Oy9bUQVzjtyhDHrGU/u5
         +yQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJePVmp8lvgapk9tYOrLKe8dr5un0koUDBql649d5/ijz58w/FIM6mQP4jdQMmzUIdLEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNQm+pn4+p5cSUhzHqtGeegjuFkVzVDg2aPox61Nb9Lh5E4k8/
	EL33+7tBM4wm0w4mk8yo7yd9HkjJyjEmFkCn5HnyIFFf73xV8O2GT2BPCcRRwU5J3lBwU7ZXTLH
	sWPTA619o7VI+bqKxiSApJh8ZA2jr1+w=
X-Gm-Gg: ASbGncss277jF7WbgPUKqMIETHHVCPjXlSwpaTuvA++iLvEZZ/CN7E6CxHYgXd0aghH
	3SJk+KjJi1RWDH1hbrEAKu2HDHOo7MnzYZ6Jsa7TrkxpiU9iCNQjuZ8wAmeXAeowe9s1/ogN4A0
	Gf5pLI+m7VF/18i7SG+ahF4KU3nn4OOtrn0r5jvn+6OOXWoTIqUSYyUGnhiaMdkkY7QOHswM5Br
	n5LMXlcdY8+23epChkxb8aoJY004Xg04niF0A7RBiPNtrVF6B4=
X-Google-Smtp-Source: AGHT+IHavV5/fw+U7pa58I6jKCQIldSNTc2cWduwlWai6yu3DUMqqAOUnmmFnOazTsrTWGH1B4aESqd6QXhcLM5e3/s=
X-Received: by 2002:a05:6e02:2192:b0:3eb:9bfa:b6b1 with SMTP id
 e9e14a558f8ab-3eb9bfab7bemr192642225ab.3.1756416872966; Thu, 28 Aug 2025
 14:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1958.git.1756228693233.gitgitgadget@gmail.com>
 <pull.1958.v2.git.1756370289.gitgitgadget@gmail.com> <c81f920fee0ed8672783728fae70b6435e800f82.1756370289.git.gitgitgadget@gmail.com>
 <CABPp-BEDje5dYZHEyYMN6j_LdR5CqRN1cxc0riRK06qK-OxiTA@mail.gmail.com> <xmqqiki7ta3e.fsf@gitster.g>
In-Reply-To: <xmqqiki7ta3e.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 28 Aug 2025 14:34:21 -0700
X-Gm-Features: Ac12FXzF4dK9UmU5u-1gteTOA2mswf0fjR3LUKrfEivQFnhx6x3yQ9ayISMVjkw
Message-ID: <CABPp-BF1z7iS6m4FzM6555j8UQeqfTZuCbwwK=Zh0zQ1+qfMZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] range-diff: add configurable memory limit for cost matrix
To: Junio C Hamano <gitster@pobox.com>
Cc: pcasaretto via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Paulo Casaretto <pcasaretto@gmail.com>, pcasaretto <paulo.casaretto@shopify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 2:22=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> I am not a huge fan of configuration variables that do not have a
> command line option.  Assuming that it is not like you'd be doing
> overly huge range-diff that would not fit your memory every day,
> shouldn't we start this with a command line option without a
> configuration variable to gauge how useful it would be for users
> with such a need, and then after it proves useful and we identify a
> workflow where a user would be passing this option all the time, add
> a configuration to allow it always be in effect (with command line
> override still available)?

Isn't that what Paulo's patch does?  Maybe I'm just blind, but I've
looked over the patch a couple times and don't see where he's reading
from a configuration variable; am I just missing it?
