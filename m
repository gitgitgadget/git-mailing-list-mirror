Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9F97460
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 05:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712469176; cv=none; b=AiKhPNhgbKAfHD1Jmg7+mhNhCJCTdkFapjqerwgifPuEdvvrQ33WxrNF7cWKeQWV7f4AccTFkzl4RN2jfctgclT9JgZl0/Ze0WOqm5P5VUBQLruCsvlclsis8NM73xxPlaCZt0+dTx8lksMRJKk9DgIDC2W94gQB6l+nV/S51BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712469176; c=relaxed/simple;
	bh=eyExn1GRv6gj9xEgBvadb3qAClu4t+6hyvwJarTkKyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWpLFzN1z0SyAzQix6tdOKWVorblHHwYxzUywy5sCW/kJyAWA9pFd7iOlqr7vuhjc2xkl167MeiaE9EjS8We42EwUQ2fwZYUhHjKXvGGaTQT8i+FQNjKdPLTfBEU32z+4gyX/mA9Ps5UInGUi/k2y+K6AeJ0HyOAol8VoQy1ySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6994c36365fso8460366d6.2
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 22:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712469173; x=1713073973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hK1/9lJyEKs7QSqCdJMFgZwGYw3GHvdoDsUIZQfP5yI=;
        b=Y/nonUqwK8kYaLhMouo23ZLWFCIqri9P4iYOLoC/JahRVf484C2rxnIlU9Z7k2XPBA
         NYLoCK+E5BrWahftacOiJpWipALJVZj57QkMsZRKDbR99FGU7dLCD3D54PnYsW8pYTN3
         hr3Xz3k3ysFvOn9XPdZxX033GQxWEekJqhzMfYSdlUmsn17YdcVlrOOtm8k8W7buNHQO
         cDX3EB2wB2O/Gm/8s8QjReaHybqGWauJmJKhoZ+Lu+iC02wLnzMJUQXaOY0gYsJAI4aK
         Cw7/WVp8gmNjG15fYaKSVeWR9ft+2M8YkMsqadh4U3MdSSZOo3AEnRa49VMoqtFZYqU/
         KxEg==
X-Gm-Message-State: AOJu0Yy0BP8DMaFkkweXiIP68ytHrby1nuH8Wt7d6wXrJz/UHKOsWuKg
	rc98Ea19VF1fdFdWS1uLxyK2LvXfsf1yfi/MyV1X0AwuHOwMQxWiL/woAVuDEAhNMI/yK2Gr3MU
	rjNwekVTv5DPMXdkbJt4etwFtcQh/XUpqvOk=
X-Google-Smtp-Source: AGHT+IFi5HaFsHyxbpCL+9eGc3BlREl0l2voga2CGMxoAG4MHhlFs2Wmw/J67Og5y0B/APQvn22clRvzrx/B2oxPSq4=
X-Received: by 2002:a05:6214:2422:b0:699:2d85:6437 with SMTP id
 gy2-20020a056214242200b006992d856437mr6337739qvb.42.1712469173588; Sat, 06
 Apr 2024 22:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407051031.6018-1-leduyquang753@gmail.com>
 <20240407051031.6018-2-leduyquang753@gmail.com> <CAPig+cROH8Ebu9CgR87-48+Rk0H3maN+dwB+Y-N2FTvy5shE1Q@mail.gmail.com>
In-Reply-To: <CAPig+cROH8Ebu9CgR87-48+Rk0H3maN+dwB+Y-N2FTvy5shE1Q@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 7 Apr 2024 01:52:42 -0400
Message-ID: <CAPig+cSfpWaanknSqMGEza7rPhXwgQ0k3V9svfuBsZ_C2EaCmw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Add separator lines into `git log --graph`.
To: =?UTF-8?Q?L=C3=AA_Duy_Quang?= <leduyquang753@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 1:47=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
> I'm not particularly a user of --graph, so I don't necessarily have an
> opinion about the utility of this change or its mechanics, but I can
> make a few observations to help you improve the patch to improve the
> chances of it being accepted.

I forgot to mention that application of your patch results in some warnings=
:

    % git am add-sep-lines.patch
    Applying: Add separator lines into `git log --graph`.
    .git/rebase-apply/patch:61: trailing whitespace.
    .git/rebase-apply/patch:147: trailing whitespace.
    .git/rebase-apply/patch:151: trailing whitespace.
    .git/rebase-apply/patch:160: trailing whitespace.
    warning: 4 lines add whitespace errors.
