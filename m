Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CEF1C7B70
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 21:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723669850; cv=none; b=cP9gbOIERKjwEBdEj1hLEiEM95hEpKYcoFediLXId7X5C4Y77fHfpI3J0qfJpUaCp16DrWOXyPrNhbwo6fMAcKbcgE9zfAvj6ILC2EwBq45wxnKSpNCWNKh6bB51K/FgbO6DmZqmELU3tdASo5ao6Jc2pSX9oic+83+cpJ8hwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723669850; c=relaxed/simple;
	bh=LBgYp9INheiR/xG6JTbxR70jn5VJcr51Pgz7QTDdBOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ly517K41rFLxG29U9PaZYiBGTz39zN3eMaMO5+PufmpOpPtDealgtllh9SJH6DJbsGgViqxND4bdhdPn3dK0TFBf5NYq1il+4mmm108dWngWcIDRUhgRLzRyEqmYK1Pz5SA+becMc8q9itGTQHl8LBB+eNEcLKjQCHR4muNTQtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b7af49e815so1602326d6.0
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 14:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723669845; x=1724274645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsIu0tCNXR9C4WsxFbwx+NnX4bDcbDO3QgnxiESwI2A=;
        b=DTOG6HIl9XTFfz1BOGgDfK3GXmrTotoogjLTx4tYFaUR37gUQ5wrnt0wgKRBEhd94E
         YqCC90YyDQCGC3Nuf91GMKG6qLy6/F119SHPAykp910wwaW3qvgM7yTDvAbIStPBK4Py
         jHEhy/sS069P/edxdpEYbp+l1egxaHPabhyFqcdW1gmA/THWu1ZfwlDc2B7YAPGyvx3m
         KnxT7X/erj0kwZzDaQECqClF7UL2fAo9WnTD6f87vc3FKIOd03HQ0GFP8dLd+FmLhx23
         dG8UZ8WbhzCCb0Jh7LPsoySMXzZWzxv8hzeH57TCtSjqCE+a5qMZDGNngET3ZHHj/ti5
         smbw==
X-Gm-Message-State: AOJu0YyV2MC9VwJQMgJ5szLktVHGfkBCgZCB1Loqb583oMrEa64mU0cZ
	jORfwjen+jI91xR4VOmf5HYTsFFr2HBdiu+j/MZEMkg09ixpmY0VwcWGNbOx19UtV5WjyqhJma+
	Agf/k97fKuJO40tgkzjpIm4XtkS05Pw==
X-Google-Smtp-Source: AGHT+IH/BRRCWe0xKaHnXi/5Ywi1oDsIdYhwW7GXp5hckfyDFcE0uICfRB7uO5+weGxFUF7JW6CcL/yjZn7BwWNXv+U=
X-Received: by 2002:a05:6214:53c6:b0:6bf:5b94:bae7 with SMTP id
 6a1803df08f44-6bf5d1c8392mr51954616d6.24.1723669845363; Wed, 14 Aug 2024
 14:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814200709.53450-1-geofft@ldpreload.com>
In-Reply-To: <20240814200709.53450-1-geofft@ldpreload.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 14 Aug 2024 17:10:34 -0400
Message-ID: <CAPig+cRTbVPaF2C=u1+mVqYwK5UiPQ7jXB6sw_i4_H6qgYibLA@mail.gmail.com>
Subject: Re: [PATCH 1/1] git jump: support show
To: Geoffrey Thomas <geofft@ldpreload.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 4:07=E2=80=AFPM Geoffrey Thomas <geofft@ldpreload.c=
om> wrote:
> This makes it easy to go to the changes in the latest commit, or a
> previous named commit, to fix a bug and commit a fixup, to respond to
> code review feedback, etc.
>
> Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
> ---
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> @@ -41,8 +41,10 @@ open_editor() {
> -mode_diff() {
> -       git diff --no-prefix --relative "$@" |
> +do_diff() {
> +       cmd=3D$1
> +       shift
> +       git "$cmd" --no-prefix --relative "$@" |
>         perl -ne '
>         if (m{^\+\+\+ (.*)}) { $file =3D $1; next }
>         defined($file) or next;
> @@ -56,6 +58,14 @@ mode_diff() {
> +mode_diff() {
> +       do_diff diff "$@"
> +}
> +
> +mode_show() {
> +       do_diff show "$@"
> +}
> +

I'm not a git-jump user (indeed, I've never even looked at it), but
should this change be accompanied by corresponding updates to the
documentation in the README and usage statement emitted by the usage()
function in git-jump script?
