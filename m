Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769272EB856
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 07:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402046; cv=none; b=berA+34OFfXGHKOvZTUJAIyXpz7TPhVpdYbct3rx1cLJ9Ul+gjvL9TyoeGWy7wHtGeSHokUo98shoKLoi+ZU3fyhNR5mjQGCb6aCfO3RlKzTqgdhkB5Xx00DH8nM6b5rJ2qH2Au4ZM8oaS1FWpXrETqPv7YyglbtHaCBT/UR4q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402046; c=relaxed/simple;
	bh=ZIvmDdVAm8OurlvOxHF20Tk+2UtR1h8oC7+qJRZM6X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u54Cxp+0NHDgS1pw75Vc7kjmzGcUdkCwU1ZoUqZzWWidYeSsQwhOTbztnbOo+eqEp5Yffw3psfIx69A8oKkUgDxS/HndMa8//icGNz8kVau5OZ/xfN1lll7RCXdRyWWsuzAt1V9NUqykY3S7NOiadYnjf5o9YqWwncLtbXiPxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpvE1cX1; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpvE1cX1"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-4135366c20fso91605ab.0
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 00:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757402044; x=1758006844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60CbB8OtqpAS5bE/OHCSr/5/hKDABgG++VGYtM0PTUg=;
        b=PpvE1cX12nN9fppMEqBWYS2WKLOrOD/wxRfGcPFUk8SqHPIYJZSp+7tY0vZ1AjR+4h
         NjniOsRhGAvMB6rZlV+ooEC8GXBKBpD+QMk9h/AzJLHt4X93AeJaxbAAevxNtnEIP1K2
         T8D/sod965S+ZyqC3GwTN5lQlXnRd68TSBI+wk72vF38L5GZ6PdY2yU5g5n4bJFY4aZO
         5PH0sKtuKvfQZy3FQiArGWnxhR5QFLdBefk7epU6sguy1MihA45AUcYkbp80ZBWP2aGJ
         GCaDsPH1c0K8n0oR10I3oGL2P0WkEbo/pzDE6DYG6Zv1eH75LRFxD3nF198lV0p8kMZy
         RzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757402044; x=1758006844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60CbB8OtqpAS5bE/OHCSr/5/hKDABgG++VGYtM0PTUg=;
        b=mcxDDkbETzlxLC2KQHw30MhM3pEjpkGXZWOxDzZQhExkGtbobJWCt99QNxHEzAbtbi
         qhdfLVtQm6wwvmbsr05oRIUk37dMh6vqcJrFHRuSKtnVkXKpqdd3/7Wn+j1OWCcl9MYF
         eXJ2Bsj+cIxFHVd43RLizkqPGOOYtwjeOsAf4HZcxE7ll07l4pnRWu695SdglM2atMfe
         E0F9oYYswNruEsFJ4RWrTbIJ3i4Bs17hAlQ1vXu8IQKl0EfjIO53rS89Urh9euTqhFUp
         Kgzq2PD5U/6XrRLZaTcjQGO87Bzo2NWJCkSPgdxPNwTVd9+8dYSmi2kYrxbk46SQSjVv
         FA1A==
X-Gm-Message-State: AOJu0Yy6cVbz36BJK7sQZOiaepKksWFnpnZS4AxgTKruyUe/1fku/Usw
	EaICngVUdVMhEbwkbK40qMEVilonHclz7hxM0dufiTySituntkKHJyc274eILFYM10pV9LZCWdK
	z1c/7SG8/qEA/SWt8FVa3UtNHpNzRPPo=
X-Gm-Gg: ASbGncvm9fH98yTQEk9XVEeda2t+rHKX+tOLR/t0dlDmvoiXG6cN9362isgqsdXNFMK
	WQrwQOBfc7Vm5uOrg/N7cw/qgryB5v6kCFpfhugvB5VVOryrla7OX6Gp0s1ekgq9EffdX2yfqJh
	Lt2Q0tx6htrr4x5w/yawNhBdXatLaLoFNxn+UdNhfSon1Ee3LOu5n78blu4nQ7082fL8UUwLdwA
	yaCwmi3/rfld9u73pGBWQwc7/YR5dg1Fri1TDU=
X-Google-Smtp-Source: AGHT+IGeVdmcB3qWBsH1fBkgU3pw0NEn71erXLyVzjGetf5GRcsuZPc9ecQ2DeLNFPIzYExcpc34ptKZMpiYTzYqyGM=
X-Received: by 2002:a92:cdab:0:b0:3e5:4631:54a5 with SMTP id
 e9e14a558f8ab-3fd85316f02mr155140205ab.18.1757402044358; Tue, 09 Sep 2025
 00:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
In-Reply-To: <20250908043620.57848-1-siddharthasthana31@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 9 Sep 2025 00:13:53 -0700
X-Gm-Features: Ac12FXyv_CDTBXlnhWjwqxW9YtBklHm_huxMJDkipCDv2fdsJnjOwforOCb-45g
Message-ID: <CABPp-BG6A_mwxQheE5ED5HQj7STVtf1_9NhSmjmzRPB7QkdWyg@mail.gmail.com>
Subject: Re: [PATCH 0/2] replay: add --update-refs option
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Christian Couder <christian.couder@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Patrick Steinhardt <ps@pks.im>, Toon Claes <toon@iotcl.com>, 
	John Cai <johncai86@gmail.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 9:36=E2=80=AFPM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:
>
> This patch series adds a --update-refs option to git replay. Right now,
> when you use git replay, you need to pipe its output to git update-ref
> like this:
>
>     git replay --onto main topic1..topic2 | git update-ref --stdin
>
> This works fine, but it means running two commands and doesn't give you
> atomic transactions by default. The new --update-refs option lets you do
> the ref updates directly:
>
>     git replay --update-refs --onto main topic1..topic2
>
> I discussed this feature with Christian Couder earlier, and we agreed tha=
t
> it would be useful for server-side operations where you want atomic updat=
es.

Seems fair...but why not make --update-refs the default and add an
option for those that just want the update commands?

> The way it works:
> - By default, it uses atomic transactions (all refs get updated or none d=
o)
> - There's a --batch option if you want some updates to succeed even if
>   others fail
> - It works with bare repositories, which is important for server operatio=
ns
>   like Gitaly
> - When it succeeds, it doesn't print anything (just like git update-ref
>   --stdin)

Seems fair.

> This should help with git replay's goal of being good for server-side
> operations.

I'm slightly confused by this statement; there's multiple ways to
interpret it -- various antecedents of "This", questions about whether
you are saying git replay has one goal or you are just helping with
one of its goals, and leaves to the reader to guess which part is
helpful (is it the ergonomics -- why does that matter server-side?  Is
it the atomicity?  Then why did you also add --batch and --update?  Is
it something else?)  Perhaps this sentence can be dropped or
completely rewritten?

> It also makes the command simpler to use since you don't need
> the pipeline anymore, and the atomic behavior is better for reliability.

Yeah, makes sense...but why not just make it the default behavior
instead of requiring an extra flag?  (The command is marked as
experimental...)
