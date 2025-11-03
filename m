Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4071C5F13
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 17:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192411; cv=none; b=ibUx45goLTwSr1gcxOmFp7CJAaaET4TXruOfhFxdF5lZTd01x3nIbZupODAlKvpF88oDc8y7S7WpZ0CfS9mfiAkiC0y3VEGMvuMy1qZ5jRArD26+hgrHEOifsLvifM4JmW87Spregt2fYdNsCEzDcg2hLi7f3w8FPcYjH4/Px/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192411; c=relaxed/simple;
	bh=RKkYE524NF3TfktLrT713qXswMXPPBam/2GMBcTSDUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MjranjvC3LHI4hRyamIFIfL6P4TiV5U0Euu86BhtihrRiEk/qJMUNFJS7imXwJoYI/GmPd8ubIN453DWLUOifJL7Rs+ZNrH5uAMpe/FkYGWzzguTdVnVRSamc9PEsFRw/vfKzyKuJvIYemXt7smRi+Tk1OAyv5/G39DH3Gya7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-88025b72e99so915706d6.2
        for <git@vger.kernel.org>; Mon, 03 Nov 2025 09:53:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762192408; x=1762797208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0o/BM9XEfQ9jC2fXYqs4FjRQrybbgn4KKlfI6tP4pA=;
        b=ogMgJq8vE0ImICBVTyATH49PaSsnsKcLd8xTSjm5NXCWEcCkJNmfi3rKACVTtURiPz
         m8G0Qet17fudbQv6ctpkqRNfWrxHpWVSVn3/M3Pr/2JV2NnXSimp0X0hC0SX9YDFp3pi
         KRUSivuzk9jFJHpVw5st60FfzvLWzTJp+6piwoFMaB2P/o7mzRiXvWOYCrn35w4ksy4v
         BqpV1t+Msqp24coEAmhxtih03Qd/N+b8Poey9GZypRzO9sk4A4Tpx/GjQPzBdARU/uG+
         sqxPJUIVEi7RKgtNSRIZP/pLrXEcqYBAZsGfjrveN5y55M1+WygZlOg0LeMSW7t10dAc
         UKSQ==
X-Gm-Message-State: AOJu0YwrI2TdCiNCbQIHFMf9v/O5+K27zAYv+Re5mNIv2sMTeIFQxkbj
	vBnqoaiYj+ga7y9Bn0nZ4j6zfL1xOe0eYoYUtMz/fXV0KrsPR9rXl5ZX9DiQH7NNrPM0fmSyb88
	+Pik4Ui/z7JJyfnL6hfkxqunFv9L3GhQ=
X-Gm-Gg: ASbGncseCSvKTHkYnqO+bh03s7TxmLy0h6Ran+QOjeoxyovk5CZn0mWsWWMxw4kMy6L
	7fZtWG608ar/X4BmFkMu5dxKZLzPKMG0zd2JmLwlvu2qZ1/W2iuslWP1lPaPQhgqaiEFJVOeQoA
	U8HV1FQ6KLL4vMxk+YwZLCU/zkPFr/IJVFiABuyIcJRykqYlXX/hTBWcKNSPbUHKvuJma/05euF
	exCGtolEuC8fBXdI1wO8WRiG/78h6LExj1KNE0KTXEvOAjKfBWAGs8sbuaoVD8ra68n1fo=
X-Google-Smtp-Source: AGHT+IEklXSciQS80V7IEJ5cve/MnP1Qrj3lOH/eLkVQBvebujly5omKgflgylqyCzFpk4218yZ/f6kdUoHy0ug9+xQ=
X-Received: by 2002:ad4:5601:0:b0:880:4f69:e598 with SMTP id
 6a1803df08f44-8804f69e797mr51021066d6.4.1762192408266; Mon, 03 Nov 2025
 09:53:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
In-Reply-To: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 3 Nov 2025 12:53:16 -0500
X-Gm-Features: AWmQ_blVxaoVdn3SSFeL0cOdmerOHpUXu3BdMX4Vdn3H0bv8ChiT2QfqXkzwEC4
Message-ID: <CAPig+cRF1hb_RQQCuzZWrnu4AvmOUgVT1mVh=LhP17f7_hYVGQ@mail.gmail.com>
Subject: Re: [PATCH] fetch: fix non-conflicting tags not being committed
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, David Bohman <debohman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 8:49=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
> The commit 0e358de64a (fetch: use batched reference updates, 2025-05-19)
> updated the 'git-fetch(1)' command to use batched updates. This batches
> updates to gain performance improvements. When fetching references, each
> update is added to the transaction. Finally, when committing, individual
> updates are allowed to fail with reason, while the transaction itself
> succeeds.
> [...]
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> @@ -1577,6 +1578,46 @@ test_expect_success REFFILES 'D/F conflict on case=
 sensitive filesystem with loc
> +test_expect_success 'fetch --tags fetches existing tags' '
> +       test_when_finished rm -rf base repo &&
> +       (
> +               git init base &&
> +               git -C base commit --allow-empty -m "empty-commit" &&
> +
> +               git clone --bare base repo &&
> +
> +               git -C base tag tag-1 &&
> +               git -C repo for-each-ref >out &&
> +               test_grep ! "tag-1" out &&
> +               git -C repo fetch --tags &&
> +               git -C repo for-each-ref >out &&
> +               test_grep "tag-1" out
> +       )
> +'

What is the purpose of wrapping this code in a subshell?

Same question regarding the other test added by this patch.

> +test_expect_success 'fetch --tags fetches non-conflicting tags' '
> +       test_when_finished rm -rf base repo &&
> +       (
> +               git init base &&
> +               git -C base commit --allow-empty -m "empty-commit" &&
> +               git -C base tag tag-1 &&
> +
> +               git clone --bare base repo &&
> +
> +               git -C base tag tag-2 &&
> +               git -C repo for-each-ref >out &&
> +               test_grep ! "tag-2" out &&
> +
> +               git -C base commit --allow-empty -m "second empty-commit"=
 &&
> +               git -C base tag -f tag-1 &&
> +
> +               ! git -C repo fetch --tags 2>out &&

Should this be using `test_must_fail` rather than `!`?

> +               test_grep "tag-1  (would clobber existing tag)" out &&
> +               git -C repo for-each-ref >out &&
> +               test_grep "tag-2" out
> +       )
> +'
