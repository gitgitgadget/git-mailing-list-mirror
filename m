Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F3F19BBC
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737592696; cv=none; b=tR1TPMWarndrDZzXXpJytr0WEBCowM/FgtuN11f1woEACEPK66bTT2dzGYLt8bPzjycFCKPihr+gQxxOk/ALx7pf3YVqj4Bhi0I0nEexjMnS1kAjKsVJhTQ2zRgz0TorM5ErHe7H9T3ZPdoP5ieYggl30Ys+RseKR+kWXHW3lUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737592696; c=relaxed/simple;
	bh=XojWN/nKBthCwEJBJHGo3csk8d393Lno/2BwNchOE7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMkRM/CeAZ5AVeQYyrwrH2TbjUYbkRhNJomYSTDAo6/70XwA1W4VfoWRg1O9k5Gns4yS/w5DbKcnPpIci+2O9ljGRcabvfuGSXtrXMsosnPdVJDvHiFSpO8mQKOgp7GnBvo4Ic0GNc+q571jMXw7RzQMmre9EEmotV30ZDTROGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6df8f7f9442so631126d6.0
        for <git@vger.kernel.org>; Wed, 22 Jan 2025 16:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737592693; x=1738197493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZIJo57ZjNPAoUUPiwuF1AdVysbqoS5me3b8/zcfK9s=;
        b=XYlsnXf1VkorIi7fiWrJ+toFAmuVHPMeqPdABKsbt3y7v9aSb7rCE5gTY+E1d84kRh
         SQlXbDGxESvR1q8sOuLSR1daEWasPbQHIEs2CqXb8+hEpMi2LEV5z+SyHcOSO4LN8KFE
         MpSPdBmJoNSyFIklBEZN9vAQ0WArdbqxQS2ZcJ9YwALNuO4baQf8TlCVX0/HmG+XgulF
         r2/EX8gtUhR1nEV8kaNfQ9YgW0vekIB3tYNOSlgSUit3bju1jYmwAxn+4LsxAjRawNu1
         meIMngtpNBf11P7SNBCu7sXPE2/55ryCD18W6w0c3e84Xb2mBnod8hGcitYnTzHSZv3t
         VM0g==
X-Gm-Message-State: AOJu0Yz0Mm7V0lpTcocuNF2w1YVGQ/abF+4FfDo8Qk9kXXFztseIiTfn
	twEOlSlDf33GAsSkKMg0b5aUT6mJ9JdYTAojQ9p1E4c0JSZRiqbxxzMtzl46cbG0+QR7kXFUrfD
	5LtS72bi8PvioB4We7TLBHUKVF1E=
X-Gm-Gg: ASbGnct/Ilo+PQh/Hiyh8VxMgcJVSIzwN3VfZ8Pij0tt2RO0WGb6G/CP4sUWqZxixtU
	hiOYCuNGCwJ3+ozHgo+FNJvZLEqRBb1No2vn92FCcNYNNt/eWiw==
X-Google-Smtp-Source: AGHT+IEv/7BHa+pcrkJ+nad57BOjSMKQZQM+83DdSm2lLgfOnIxKfnFubnLNwM+kFeiYNUBF0Bo1GfFySPtzdBNFeYM=
X-Received: by 2002:a05:6214:27e5:b0:6d8:967a:1a60 with SMTP id
 6a1803df08f44-6e1b2155c60mr138080906d6.2.1737592693605; Wed, 22 Jan 2025
 16:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqbjvyv510.fsf@gitster.g>
In-Reply-To: <xmqqbjvyv510.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 22 Jan 2025 19:38:02 -0500
X-Gm-Features: AWEUYZnJW8_S1i8ROG-qxy0fX60DofgsO1ChZTzpQuEuPhRxyyUjkf6CuOEgHTU
Message-ID: <CAPig+cTBgHn8vjKDjy5JujFf-S4kQxPQ0iFMdh0HA37f76eqLA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 22, 2025 at 5:49=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> * ps/reftable-sign-compare (2025-01-21) 10 commits
>   (merged to 'next' on 2025-01-22 at a5ae1ce801)
>  + reftable: address trivial -Wsign-compare warnings
>  + reftable/blocksource: adjust `read_block()` to return `ssize_t`
>  + reftable/blocksource: adjust type of the block length
>  + reftable/block: adjust type of the restart length
>  + reftable/block: adapt header and footer size to return a `size_t`
>  + reftable/basics: adjust `hash_size()` to return `uint32_t`
>  + reftable/basics: adjust `common_prefix_size()` to return `size_t`
>  + reftable/record: handle overflows when decoding varints
>  + reftable/record: drop unused `print` function pointer
>  + meson: stop disabling -Wsign-compare
>
>  THe reftable/ library code has been made -Wsign-compare clean.

s/THe/The/

>  Will merge to 'master'.
>  source: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
