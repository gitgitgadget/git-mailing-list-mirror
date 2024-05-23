Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28963129A78
	for <git@vger.kernel.org>; Thu, 23 May 2024 04:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716438452; cv=none; b=d0pHhyo6e3b9mMUDoFMjaPZcAx4Woj4gb6R9ROA6xEiIRAqJiqS/xwoFE+xWqYPP+kMxx8xDTAAa5eLUvgwp3xTOVx22P4tUHOse5hUNwsyOP5g1wVbwy1JrBrIpog+NhRiylSNW0SknDJDkn5STDAiXWA/aGZf0eZD9Ie35qqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716438452; c=relaxed/simple;
	bh=V7n9tVQaQA0cLNyDvy5Qozfe6J2TnNWxGon9Vtf0lWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjLFdUZXvE3qJccsm4Qt+MwMz0Gv8W7KfjYrr+Io1vjx7MPdNQUjb4K98DcMyODsk3ATUN5zVWxbpisntjMGjfCfla/jKkHfXWP7rS7zK0Am17pZe72IjJZH3bHPZQ0+PKE1IvI8oxr96sEGrodqfuHL2iLQrYJRsK0uOHYwd3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6a8691d736cso11247436d6.0
        for <git@vger.kernel.org>; Wed, 22 May 2024 21:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716438449; x=1717043249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpEysTSCBr+1OcJJjxqpJxNG15mMS02W3vUzNIlZ8+g=;
        b=oUYXxkSQhCSjgrMJeVAe2hBK9owjYzFyvCMbcYRze6BgA25nkNvPpX+tZeYDcdvrJp
         ILdrGbWM5U1mFa6KlK/maX25YV8mpLqlfOE989rHJnArvnzjsq66zxG2jKkaMHo67sxI
         3QtNzV2BkCzni45zblbBW4ua7j6uCXKnmEgvyWDsWDd6Uiv0ese2usiFRxQOHC+0Zzkn
         jqMbmot3iCC8A3bsZrLR5V0Un2ZJunKKpPplIriBrGIs12ykjxrn0gxwbq1zkH+PIzJh
         aMderdsnYMqv3QNq3AQVY+wBgK11EBHLEDkNXq3uwi1Wyc/BiHgAgTNFzh7am1YQ/wOH
         MeYg==
X-Gm-Message-State: AOJu0YzLJsQS5ojQYsJHZpROgOjKERhdR5adoxHsn7GXd63aXFI7Vk7m
	iTMg4ZUhladGdcu7tsfjV8TZin0SRceC5a1G4ZInHIzK5Fi1JrqnLFq6BkysACRYwmvJyxnonfQ
	EuZon8saOoS5JbIPXLfJnsp9hV9k=
X-Google-Smtp-Source: AGHT+IG9CXgqPIgJjIgg2B2MDMDlZKL7TGnsL0wHCqiyCKjmhWlMad1fx0FAZqWE6eXiQDKE7iFpEalUEOC3Og8sTt4=
X-Received: by 2002:a05:6214:4a01:b0:6ab:7980:7247 with SMTP id
 6a1803df08f44-6ab8f60df38mr26169886d6.24.1716438449012; Wed, 22 May 2024
 21:27:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522024133.1108005-1-iwienand@redhat.com> <20240523042143.1220862-1-iwienand@redhat.com>
In-Reply-To: <20240523042143.1220862-1-iwienand@redhat.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 23 May 2024 00:27:17 -0400
Message-ID: <CAPig+cTPmiF_f-fsdNPF4A5NoSWrmp6sMPSNY1JFoxipyr7qgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Documentation: alias: rework notes into points
To: Ian Wienand <iwienand@redhat.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:22=E2=80=AFAM Ian Wienand <iwienand@redhat.com> =
wrote:
> There are a number of caveats when using aliases.  Rather than
> stuffing them all together in a paragraph, let's separate them out
> into individual points to make it clearer what's going on.
> ---

Missing sign-off.
