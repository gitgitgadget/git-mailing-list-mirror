Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934CC1DF736
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 11:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300345; cv=pass; b=KWM+e4v0g3dMcBIGgr1YaIn8z1JXCKBEJucOtZ9BcTuGbKmqrfkRU7nFiEG6z7A3vJg7HJbjeauzAnUshK0Yx29Q5Q6IaASYGrOmrWsFblqdLRPDwmZj6UiG8EgY0YQh7E32RzNcdmT+VwcqVt2y7sStwf1BsitmkKHdsAS1QAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300345; c=relaxed/simple;
	bh=KNgTGCkadaRePASDszVva+e06dXwWz+zq575wL3l6CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6Vx86zGmLyxs92B9uztS2hehV8Moy2UtA3Wx+XoOjXiASx+y40Qn1tWhWzws31ykoJUFgJ87MfZC79y0uo9wFOoAESF/IbLkGmtJNEUBuBflfyhqCDKJwS3f4iH1wV4E0cRmQyEd6S0IQXS4nwFxP+mZjqhL2C/ZoV+cD2/zoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=BAZKH7Yf; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="BAZKH7Yf"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7fd3801ca22so7415887b3.1
        for <git@vger.kernel.org>; Wed, 24 Jun 2026 04:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782300342; cv=none;
        d=google.com; s=arc-20240605;
        b=OGIIgdGYZH3GXirCZFAljOglg/BHxr5sJ56TtfX27pS9giBnYIknjcQuKNyFLrX4Ll
         vIOHhkYlQo3NKIGBU2R5HFfne4AIrZp7qRoHlOFWUA2cloSFa8OovNTgmftAISMvf6Cr
         eLlceT8phYbgXH6TiN4OAPn/+2+zIxdIiFcfcIQhf0DrlS0c1rAlYVa1m7BeBDa4nON/
         PzW4Zc9gT9G/r+Jnt/AWWotacbvH5nBdKv8UiZz8x9R/nRPlNClq6ltOqk7NHAu74SoU
         koyAGxTsXuTlYqCCPuFwrDUOqUMUAkFuLyPugUsiaSyLEHSkjSUC92UmGvp4eh7ARBk/
         H4KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KNgTGCkadaRePASDszVva+e06dXwWz+zq575wL3l6CA=;
        fh=T2Wv3F3Wcvrl7a6+JlVRgraW4uZT3XAyrsdqM3TCXCU=;
        b=RJYxN+E7m35anIEEXOvVzig/RzJnfhPDl/Dc1TECEEZFGw+9AU3tXjntc8P/jIOE7w
         SXhl2N8n6cq95vQaFsnn0MUHuq5JQl+JVo/eTnCFEynBW0C1kyz1zMxCIY8uKKLFu3Bn
         kSEGMhArv6Ol5HS1vJff+UP8YzaCk9faW0E5kDpZ0EkeuDpM3Vk74FRWo3WplgG0J4GL
         G0V/lc7/YrPgJXNNkMGwe2OIFgGugA8tiAFYPI5GynSAQVT3uDJdnVo+eLjhxZyHfT4g
         kqJrxjiI10wb7A0Nex42TnwfqKutMutogJupNo2XkNtgP2XcIieLhp1XNQVelqANP+Re
         ZKVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782300342; x=1782905142; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNgTGCkadaRePASDszVva+e06dXwWz+zq575wL3l6CA=;
        b=BAZKH7YfovPOOtPZ9ojNNZgNmn9e+cikBOOM7yGfaDhDDkhq/g1VDhazHh0UU8xwL/
         iZwgKMT1Xy1eRsbozHYXRcJj4PrCT7WKDSpTgW2ANypTeqVcOoLV2yV6vOdI2NpQfi3W
         bLKYjLunECOx+s7vQVxpCdCPSxtPVPA+hn4CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782300342; x=1782905142;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNgTGCkadaRePASDszVva+e06dXwWz+zq575wL3l6CA=;
        b=hvA/h+EKu6zTyFb6nnH5fpWPS0UdsbQ4BlRIhBNwbMaez+Y2CHBVZ6sDX1hK0eLGYr
         41H5TtkSIfFhSWegkZE8JPESLQQISdG5J0Kbq6A+sarCh024HMP1ylIMEIoHO++G9/+8
         ZUSajvHv3jctRpqbyl4+Me3VL0fjpZDYg3Hvc2OT/gaEED3ui+nsVQ+Du75+4eI3M86L
         XbD6Gc+15NlpyDN9s626WA3yQpFj5zqdGtqVc+Kdn2y1EWoKxh/WyMu2ncGP4gDJ3zzg
         OlhYIWhGFGjMShncLgZw5bsGNbt5v/cYqKUgeB5cb/lNsVfTV+dpgOwuMY8/6117GpKe
         ypiA==
X-Forwarded-Encrypted: i=1; AHgh+Rqhpz7V0hvPCpRM23ImGYmU1/9ULY3JDViLiyfn7KkhNfKKvHyQ7K1pbCVUdN+62Ov9cFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwIeADshrZOl24kkXoBCR8esK+zPO8p0nRH61vNA6OZcG3byfH
	DF7DH0Ly29RKiG3+Un/bE6hiuYSu/3Am6CuDPofKGaXo08Ckru/I65Av7lO4t9zimcIsvUoUcAj
	wHcdXxZdpukSRnpYN/prsNCjv3ClhR8QbLPW5U0xXMw==
X-Gm-Gg: AfdE7clj/KZ+idRoloSXK5LnS03f/kt6Wb1H6KWJIJX/26wJu6Ai7GudgzS1RRelfkd
	906Z8CE+lT+k50OFdlCuAhQltBm0nP6LpGkTqiSPdmfsAUm9QNEBSODBpcVScF0GZ4bM5FfqUWy
	2UOuy8MWHouUYBZpaBHeXcH1T3is/UkpkUhg0UJfzgqh0XrpjCpPYdmGEY0yEco2apfojrzurBx
	3bmv2Z78XXuMQPwqTspJ2kBU3T0HZ0lQQa1ltDMhRXkQMU4akvz3ZN5crkQwH4GHZYeFEP4KA==
X-Received: by 2002:a05:690e:4147:b0:662:e27b:5f9a with SMTP id
 956f58d0204a3-66312d6dd74mr18159540d50.8.1782300342583; Wed, 24 Jun 2026
 04:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <316e4dfe261043730c77142639f86f5c3cabe370.1781951820.git.gitgitgadget@gmail.com>
 <f0c9eb6e-60b1-4eb6-86be-3af4d87afe85@gmail.com> <CAL71e4Pcw-UUbHBw_j6PFx2bXmxZ93VLMWG+3Qap=RmCJa_ZgA@mail.gmail.com>
 <8d07f5a9-82fa-4aed-b407-363e659f6851@gmail.com> <CAL71e4NFHz_zVCWPvmTO8UPNyaKkDFqNQdd3CJykoiGmEhfUTA@mail.gmail.com>
 <509fa950-fb9b-468d-b917-6c0eb7823d64@gmail.com> <CAL71e4PzjdNCaVRtXg7wh9s6DxBeA4ock1aTzq8VPxKCmE-obA@mail.gmail.com>
 <ec241a02-546c-4b5f-8ef7-06b4355d8fec@gmail.com>
In-Reply-To: <ec241a02-546c-4b5f-8ef7-06b4355d8fec@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 24 Jun 2026 13:25:30 +0200
X-Gm-Features: AVVi8CeEnd0P0edsiPnsG-AaldVZIOwfAoPwuczcA2Iijn12RFbLZnUa9gY2s8w
Message-ID: <CAL71e4Mx8=JFt+UcqiLN+Wb_UvGvF=SP81Nb3z_VZaEVahBfBg@mail.gmail.com>
Subject: Re: [PATCH/RFC 2/6] commit-reach: introduce struct paint_queue with
 per-side counters
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jun 2026 at 16:17, Derrick Stolee <stolee@gmail.com> wrote:
>
> I think this would be an appropriate way to handle this. If we
> pop and return NULL then it's ok that we removed data from the
> queue because it shouldn't be reused.

I have prepared v2 on GGG which I believe addresses all of the
feedback. The halt conditions now live inside paint_queue_get()
as you suggested.

I am not 100% happy with the halt-condition placement yet --
the existing loop in master already has several exit paths
(while condition, min_generation break, FIND_ALL break) and I
think there is an opportunity to consolidate them. But that is
a separate discussion and I do not want to derail this series.
I can propose some alternatives in a follow-up after this
lands.

Thanks,
Kristofer
