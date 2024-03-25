Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76DC50246
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399170; cv=none; b=kldMeqjrMVips0wTD0GdOkwVArml6UddYHqnb7OEdtuw1l00Sn74TLbID5ufewnRLUDJ+4T9o/Les5Dnmd6eckoY/qDNl76XR57r5xC8Lu0A4gHuAbnfA56nK0XjdZS2swp6/W1zcMPRd03yxBLfxS7Pj0QveB+A5eXFpN7kr9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399170; c=relaxed/simple;
	bh=VJF2ynWBZuWGOdGGxGK3qFGO96dL7dFZ1dVslQYjEvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGFk2ELB0//JLTxPQO6JJA/xjv+Eh5Y1/UsnOCuLr4xMlLjdEc9V9RGkkKWZkEjQUS9Drc/1eZiI1BRk//Ibt1KnlD+EqVw+ntlcsl/8AxsZS4GUV1gSguL/eVxOMfIjo2s5/WeEcub+OzLb9WoCi6dFvjURRXaRCTDkxycQnT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-696719f8dfcso20855086d6.0
        for <git@vger.kernel.org>; Mon, 25 Mar 2024 13:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711399168; x=1712003968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJF2ynWBZuWGOdGGxGK3qFGO96dL7dFZ1dVslQYjEvc=;
        b=qRk7Xks2ilRDEZa3BEl5V0lRPZq28E4jcE20GKIveHxNOSDbleE4olVS7MxHJ8sxnt
         rE+4nhrJV8Ygu/TEAea78pbfFxulUJ4uWWGANbhNoQYDcv1yga6hgEv0TdwuUwXz7xn9
         CLJg7ACCBl6ObJaLj488G/cddMT2hiYpAet7m730re3sUWCQrA4LWiuw+GfG23Ndb47B
         6TG7DT10cLK4odsZqdr4yDEMTuSoFFrVsRWgE+/4Nq9J/w0L0QFQYa1p83iM4NXenDR0
         QdnpX91sujx4wp/iAckGkvjcCYUqCgIoG7e6bHF0uxMvub5Dfb8mx2f1MOAFdxg3I038
         yL2g==
X-Gm-Message-State: AOJu0YziU30zDfIC+wdEPsYB5pldgRDKkWVTqwwQaEhY6zKAe1ZZkJqU
	27G7FUQy7ue9iqOTWRWY89jJb/Z6ThSZMdUAYjuhsc+v+/xpBuFntZy/XmIV3eQYaaexEPboPRj
	r8neaRD2rOVyFECkho7dY1OO/goJRmv49
X-Google-Smtp-Source: AGHT+IF4foav6n3qoKMa50TTHXNuK7ywhkYeFjCEpEoxde96Y78BAIpCnXj/Ss2n5fTlggDVCKPb+H8XSUT74fZ9k/M=
X-Received: by 2002:a05:6214:2127:b0:696:7fbb:db69 with SMTP id
 r7-20020a056214212700b006967fbbdb69mr8780667qvc.42.1711399167691; Mon, 25 Mar
 2024 13:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711398665.git.dsimic@manjaro.org>
In-Reply-To: <cover.1711398665.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 25 Mar 2024 16:39:16 -0400
Message-ID: <CAPig+cTia_gXkpNw6jo8VHg=ODqX71Nvff4Qfq0oMWqShv5TWg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Assorted improvements salvaged from an earlier series
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, jn.avila@free.fr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 4:34=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
> This series contains patches salvaged from my earlier series, [1] for
> which it has been concluded to be not acceptable for merging, because of
> possible issues with various git scripts. [2]
>
> Changes introduced to the patches are described separately in each patch.

Prose description of the changes between versions is very much welcome
by reviewers, but please also include a range-diff[1] or interdiff[2]
when preparing a reroll.

[1]: git format-patch --range-diff=3D<prev> ...
[2]: git format-patch --interdiff=3D<prev> ...
