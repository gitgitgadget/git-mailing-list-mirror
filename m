Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9822D0C60
	for <git@vger.kernel.org>; Sun, 16 Nov 2025 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763294730; cv=none; b=ayCC7BpgOSF2gxm6jZOM7PPjr7rEMKCdBL16O9c+SRyztcJq51aZLg7HtQT6Rb6V94VhV7j/id6adGygBn7eaY/SV+5DW0SooucGvSQBWUNLjFzwBn35IfCg9gaBnTs9AUJ5Epga8jnpyuUQANpkFAyVWPZc6MFJUrwsSOaCDiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763294730; c=relaxed/simple;
	bh=2Z67qm7dUxZLKidaze2UinHSBys1r+GDd6x4M8nCV+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CMagntV0fIhV3bAye0uwcKN1o2/TVwKyUXNQsNAnOSKs4XPsGwubycgYEKv+FdY8CgTwmrhBhLYm1NwjEEgtTB4GTK1EXgWT7FolND3O7Gu1pVqfyIzOcl3fkpuRTSUyrtu8YX3tc+mylZXgglc+7scoMMSmGlglFIQdm9UXNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsLuC9Ov; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsLuC9Ov"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64165cd689eso7093572a12.0
        for <git@vger.kernel.org>; Sun, 16 Nov 2025 04:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763294727; x=1763899527; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e8reO/U56qOthb8P1HwxvOu+8EgMiGt4sOrLV7tCP1E=;
        b=dsLuC9Ov/4695SX+9NBhvWkiWgKY/wmcfxaNDAtkHqiHSOUDW1vlwAgXhSJXVnCVAw
         s2xR7R7cfJW1JoBViQqxtM4/X43gOzfLe7jra0kNS8/xEh0v1awCvkFg/9tlVxa7/JfK
         4o+ijDG1eYC4osouNDLg0sYwdEDljsvWmK/02b11P9B/xjWh0hGLplcG7gSj+LQs3BSa
         5kC3q6LCXiCisDgwFDT6NjnndTwLVxYkcZiXiRE4GYMleRxl1lcZMcrDh2osvkykIXsL
         TaPgC7rviwUyXDXdTqed+2kLSMVj9mY2rEJ9U9+tdNWVgfm/IUPlhyYse/xjcG0QgGMc
         WhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763294727; x=1763899527;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8reO/U56qOthb8P1HwxvOu+8EgMiGt4sOrLV7tCP1E=;
        b=Ez5+C8rhu9w7DcdA5Okj+1MIN/zyTTHDq1wrYU6Zxny1p5kAHKhaVaYFggVibGrDhO
         ELVXT0aeZD/iSRcRHQCL6g9QOMO6JlbwTe6cztWlhYKdDK04KO8iQzigjSMmJJ4ZRS76
         A1IX32P9sPGfcTwE14m8Ckca/iZDRHgd+tusVp40ehVSgWZAPSH6XGWs3zgdwhjXdGa2
         zXixanqqdcZzjqNAqtu3MIrX7CAS9Be2BabaRInrHicGId9X6evKKhHpvg6Jbf7J8txG
         Egq4ulQnC0jZa3jzOQoFzJF4qVhHweZ7ePpUqCcVeZFWscd4OANf7EbH7wmme404rleh
         qwXA==
X-Gm-Message-State: AOJu0YxV5W2JSSIL3qAgT7RoUAVDrBoSiBc/1x46ocQQyxOFOLxMmcFK
	8Dx3WhdfwrnnKtU3+hWeK1XLgbRHcsocHibeNHCJy0zFWzQa9YIXV/En6LwTc5Zx68lASZMh022
	p05pVxUSdxB3u4WSitx1dY79+Feax2oE=
X-Gm-Gg: ASbGncvdB+6aXm8/Ct6VsfUw2tqREwh5hEBmX/pAW31vWdVdBGTppBjSffU4OZXke6J
	Yl7oji25XLRLLvAvNmdivhORVJgwuVbMbKlOFMZUdibjRUAFEcUWOO2RAOB2UuSUwd19d0LhOVx
	07feXK+AdGKElnMcUUlX461DoF47HHMVSSNnuxNObINf191b8K9nHw+J88lyqXXEdsRgff06MnM
	PGeW5a1+A7OWoscFojOjwa530F9O/XQP2uHjX9sp0wqhBwdqiqPI65GGrx0mZ1TKAFlDGTo+AiD
	EmNfKSU7/TDcf5QFOTKjmSM=
X-Google-Smtp-Source: AGHT+IGmUeHC4ZwkVm/GEJGh7veRp8N8So3QjYehQbt6sArrk6u8DpjOHZVLp8PSTHg9BSzJ3No2GNK0hQytoqohVx0=
X-Received: by 2002:a17:907:eccc:b0:b73:2e54:a002 with SMTP id
 a640c23a62f3a-b73485707camr338146966b.15.1763294727405; Sun, 16 Nov 2025
 04:05:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2101.git.git.1763232863.gitgitgadget@gmail.com> <xmqqjyzrdpqu.fsf@gitster.g>
In-Reply-To: <xmqqjyzrdpqu.fsf@gitster.g>
From: Kiril Ivanov <ivanovkirilg@gmail.com>
Date: Sun, 16 Nov 2025 14:05:17 +0200
X-Gm-Features: AWmQ_blwrU6zDjWP3MK1NcxCtZl9RI8Pyea1_Ygfmwp0LKXENatLtWQyKx7WoF4
Message-ID: <CANHi5upZdwi33upTFL01NymMqK7dCWEbj8XAOEydCDMf4bSFzw@mail.gmail.com>
Subject: Re: [PATCH 0/3] git-prompt: add quiet upstream indicator option
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, 
	Kiril Ivanov via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> wrote:

> ... (this is a reaction to seeing
> some bash-isms in these patches.  No complaints here, as the test
> script is all about the command line prompt feature to be used with
> bash and nothing else).

Actually, this got me reconsidering.  The prompt feature claims at least
to support zsh in addition to bash, and it has had modifications to make
it more compliant:

<pull.1750.git.git.1721762306.gitgitgadget@gmail.com>

> After this patchset, the following shells work: bash, zsh, dash (since at
> least 0.5.8), free/net bsd sh, busybox-ash, mksh, openbsd sh, pdksh(!),
> Schily extended Bourne sh (bosh), yash.

And the test seems to run successfully under 'sh' in master with:
-. ./lib-bash.sh
+. ./test-lib.sh
(Passes normally, and fails when the 'expected' strings are clobbered.)


... Which is all to say that the bash-isms may be undesirable even here.

Unfortunately, I have been struggling (for an embarrassing couple of hours)
to replace them with something standard that still keeps the matrix-like
form of the test parameters.  If anyone more experienced in scripting has
an itch to help, it's welcome.

Since I originally intended this to be a two-line change, I'd rather wait
to see if it is even a welcome addition before I spend more time on it.

Thanks Junio for the feedback!
