Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4141BF3A
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794675; cv=none; b=XzsJ/8F8+WAZTRMx4szR2jfH7667bl3NoihSzwiEeZyPu7v9jNfORB/wA2xqvISvtdXyBFIDeSJhJXWICyW8HSn2t4Jb00l+eZIgIamJcc1+fK937sk2PMUkavAgl4yRraJ6Gf+KcN/E06CDIjSAfsLxvAibWf+RWNmAuIZnc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794675; c=relaxed/simple;
	bh=7CoUUsDXxX7QpU+Uq2PmUIQ3W2GFGPbU+aXER/2WLno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HQgR7IXYd1duFX5O9UnSnEW1nV2t+Ss9TkBRbI/kqzqxphS4c3Vn43KQxdojeGnx9plcDw8g5FGNZyefsNcZo/Dvs2/1DHfSbIbjbZfDLmJ4mbUVVMHSFAa+hhoJ/HtB5ymtbn58R3Y9n3EQ+514ToJaO19HpY10KWM1aUb+V0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42f14b8a3e1so3205721cf.1
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 22:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709794672; x=1710399472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0cJJUVHUVezo1MaSuMog967q8BbwFwByjcSiot/ykc=;
        b=loJ5r4bKqPaMYOi0OnEvsroQiUV7k871MamARwC5XCTJh897kwff/4//WqcsrhLXRl
         dDKf6yPbGzWqu+CyxsMeiE3+M90Zd91J9fEp+COE/UzdFYgUlmNo4Hh8BcJjPxlnni0s
         B5ltDlp8ciZVlmhn7SeayFccOWR/SJN/biAjmtxJVFLgT1BFfD3kZXryk41T8XVEZLRW
         tZJmUJuBAcPqUbySyJKVcuuc8qn/XT+LCtfUOcbrMCMl7QfkuVh7/DuK1FV5zBSs8R3n
         JtJntKn6wP0M7ckGV9hmwhq5yoWNQSIz4Rst64p4QSTZfKnew+6G4mnZjZ9c2J8bt7Uh
         3nZw==
X-Gm-Message-State: AOJu0YxMtuGJrASul8Sv/b+Ts1NvPTBpaVC6c37AlgcJjBWeKzwcbsV3
	JScCNaoNdNidqmyf41CCO0h7w1hZoWeSFkI6Qw83wErbE7LVQ3kso8pdt3u2MmnZoxgaP/PlZH3
	99xKJng/cNhj48caTAq6J1VTbyHAvUb/cWZM=
X-Google-Smtp-Source: AGHT+IG+qyCvbzxkzheVzbgohYGVpdGaMYWKsstyKaCtyTuZRe6KJrsFjDMvgeGatP2WrQ9PUC/32O4TKk+A3skpSVY=
X-Received: by 2002:a0c:ef0c:0:b0:690:9d57:27bd with SMTP id
 t12-20020a0cef0c000000b006909d5727bdmr2291692qvr.52.1709794672280; Wed, 06
 Mar 2024 22:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709724089.git.ps@pks.im> <5ff2bf4a2286431a3b3048e0ea04d6551006d0d7.1709724089.git.ps@pks.im>
In-Reply-To: <5ff2bf4a2286431a3b3048e0ea04d6551006d0d7.1709724089.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 7 Mar 2024 01:57:41 -0500
Message-ID: <CAPig+cQevQKb8YA1Yf-t=AHg11P7i848gELx2kPc39g5cOWbqw@mail.gmail.com>
Subject: Re: [PATCH 8/8] Documentation/git-config: update to new-style syntax
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 6:32=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> Update our documentation of git-config(1) to stop mentioning the old
> syntax while starting to mention the new syntax. Remove the help
> mismatch in t0450 so that we start to ensure that the manpage and
> builtin synopsis match.
> [...]
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

I'd like to push back on the part of this patch which completely
eradicates mention of the old syntax. Doing so makes it difficult for
people to figure out the meaning of git-config commands which they run
across in blogs and existing tooling. For instance, the following
recommendation is commonly encountered in the wild:

    git config --global user.name "Your Name"
    git config --global user.email "youremail@yourdomain.com"

Typically, we instead retain the old syntax (or options or whatever)
in the documentation so that people who want to learn can learn, but
we rewrite it to make it clear that it is deprecated, and explicitly
point the reader at the modern replacement command or option (or
whatever).

So, perhaps you can have a SYNOPSIS section for the deprecated usage,
as well as a "DEPRECATED OPTIONS" section (or such), so that we don't
leave readers entirely in the dark.
