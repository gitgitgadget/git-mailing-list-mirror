Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D295142047
	for <git@vger.kernel.org>; Sat, 27 Apr 2024 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714222315; cv=none; b=nNquO/+RIT2+D1eHkNSRAZ6fPpKnCR9laVC04Uc4fn4Aojh7v+7ucIpXJwcDmhgCy4jwvpENphtRV46lup66AljeBAzoQLvx3nlowka10xIQfU9/iqT4H5u96tSHQXVtsKctzw+D1VuqAurKGVxsChJU84AhWKGKTvuuzdnYy14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714222315; c=relaxed/simple;
	bh=U4thcNDrZV7Tw1bQVbjkuUv3TPLNkQPffi7H2MGlv7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apU0guscAfUTRweEEbLxo4bznCWStGWEh8eneaXTLFCjuYsA8aYnIExTZCGzgcmJ2otwO+xSbhkpcCgj5W/uKT4MEttE4uUR5zgUAHqbIT7BWxeB/6lX8h2FNuG50/rDMkeD4PBeZdOD6O7MYClkvN+QLV2kSVNiQ4ForBgVR68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDQ4PKS1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDQ4PKS1"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso418360566b.2
        for <git@vger.kernel.org>; Sat, 27 Apr 2024 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714222312; x=1714827112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aYRuANL37zQ5mjElsa9a38DlotM3a2Cbn+GVpHvsi0U=;
        b=nDQ4PKS1ucx8XXn9xBN7WBPb8OpQBHAlC1hnUOW8YSfRiqLbfyFC996AchZ3sHqITI
         b1RBDsPPFsuox5S5hGhAw7kARg1Mz7CaqzpHF3uncjDQqBkBNKMTVqxJhlzDYvn407Ym
         6clq4j048TFTRnAp3mzkFUuCrPPJ4qE2Y02OYdHWjpoXXQSJOOmN95dcqs5zumJExeCI
         5A8BBGQdkD8AiIWM5bSaLx1wdlrLW5l6Sk5Ygw7rI77pwIqH7/ECPfYX9eKbxf02Psz+
         19ZHTRHMKWVSWSnhLlhOx3EcgWD+0TdcgknrG5cMiUbNh20UHJ+wI07Fn3oA0Bblv5j4
         0Hhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714222312; x=1714827112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aYRuANL37zQ5mjElsa9a38DlotM3a2Cbn+GVpHvsi0U=;
        b=I6kKFB3sFGUHogXUL2/+HaK6ktroMSA02S2OdQN36MRM3O3ti3J4TVaRLg7t9q+mvL
         KUmEtQzyU5Tsb8zH2RXIGEwwL6jcYdAee5+1idC8OQBoATqbVpkeKM8373EZZRmp2KN6
         lATm6zsrDR+3DxpbRRXQrke7Sg+Zqo9yZuPWTVjEkVaN6VLcQfKyOnSHCeWfweSv38Z5
         VRG6FUvK3zOlcFFYqHkVpBGvvKNzM4gJbz5YV7YwIiOdrIObTWII3th5CIko1eSkyZzY
         JMYkxoJp9dB3O1YAHC7A67EOwl8/HB2KXczbFnL6Avtku1AXRcS99Q1934Qhb67VAESn
         +nrQ==
X-Gm-Message-State: AOJu0YznpXBwYqLUYq8iuKMWgY1W5Ytoe8HvzGH0blWdQPpQmtlzsXZM
	oQ7T98fl9Rxxyrf0fcYokGHjZTghjmq19G4j5+GHjPc/XblPTx7SFOpbm/UWXDrErKZ0SfJol0H
	OH0rWwbwZWOTyZythFewrt518M8s=
X-Google-Smtp-Source: AGHT+IEuaM+edzWuYagHTJzwKMXH7XambTYzqU3d1Zztm8lS0mCpQjJE3pBv5rqAFscpaxnyDioTWkpr8z2+CCVLshs=
X-Received: by 2002:a17:906:25d3:b0:a52:ec:a87d with SMTP id
 n19-20020a17090625d300b00a5200eca87dmr3720054ejb.74.1714222311813; Sat, 27
 Apr 2024 05:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com> <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
In-Reply-To: <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 27 Apr 2024 14:51:39 +0200
Message-ID: <CAP8UFD3Vzs2KvsE2qmx_54UX9ktAngr2FkpKfWVjRMD=t1B7Wg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Make trailer_info struct private (plus sequencer cleanup)
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Linus Arver <linus@ucla.edu>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(I had sent this email only to Linus too, sorry.)

On Fri, Apr 26, 2024 at 2:26=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:

> Linus Arver (10):
>   Makefile: sort UNIT_TEST_PROGRAMS
>   trailer: add unit tests for trailer iterator
>   trailer: teach iterator about non-trailer lines
>   sequencer: use the trailer iterator
>   interpret-trailers: access trailer_info with new helpers
>   trailer: make parse_trailers() return trailer_info pointer
>   trailer: make trailer_info struct private
>   trailer: retire trailer_info_get() from API
>   trailer: document parse_trailers() usage
>   trailer unit tests: inspect iterator contents

I took a look at the whole series and had only a few minor comments on
some patches.

Thanks!
