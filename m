Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524FB194151
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662609; cv=none; b=R4ySJzKVq7oEcct2ic5hleVb8b4h+dyclCyIHVRlI3jcnzzLjSpa6TluOciTaXbjDSFIWCXAQYGnUBvrae7J+1buaCPdeyU6dC66qvDb5d/8hbpkd0yaRSvs1rOwjdc74on8IDFGBntpruvv4dDbwY8dekKPaacFnpJDUbRDhDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662609; c=relaxed/simple;
	bh=FmqmjIYCO8kbu0NPGA6FXundMRJ4sXooq50pD1FSJgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PTCFelKYwIODryLU3BwCRalmetfO+JCFa57AmuknCrtHcA1gUnWCd8q8sLL8Pka4V1h9lJTvx0C7ZtQUyY4wEBcF8fHH45jMyMXTzXyuESkqL7yeqC5Mgp2zDwb6mdVImTzjIeiXU3JzWfkdGynoLDeBvC35pU0xDr7kAGVnsn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cbe509817fso2852056d6.0
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 09:03:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728662606; x=1729267406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dtMeCVIcwAyC+rUKebLJv8IhesW8KkUID9DMHpWeywY=;
        b=gyLUlGamLYWuUnZxau1ljX47HxeNxKtqambkt/VMoflYh+A59w8tfOQy/7rIdRu48Y
         32gTp5YSpgursTFX7BaVDuwdOv2wRdjoJfXwP3Pp2zEjhTW8MaWRgeVBx2so90YSKfTw
         XG42esK5dZGE787jl1eAspV52TKZVB8mcTXmiF0U/gCNtZ6XS9Hb5jM/qLDFe8SbKFrd
         e2oLEH4tQgunQzjNXsyxo5v+waEased6NMsbnwuOLeiKEgp1MlaNcE+vyy04XHsk8eJG
         rtJBk/J1rezt6FClDQcmX7XzA36gqBnRtreXwHJU3L872uPpI9Wi32nFQnhtDpjLkzs1
         CfwQ==
X-Gm-Message-State: AOJu0YxFiLxXJjSFvSwQFDhKpjBsPEaK+jF3+RbcZM0dL8mAYe3vafh2
	BTxCpnakqarQ1ObkTcvSj+CSct2fEqOf7f1tjo9iC1OWr6vvDHlZRYy6eU9UjQWX1eDMOOOixbX
	NZ/dqlI7KdZQh7v6eTUjCF+ZBs0M=
X-Google-Smtp-Source: AGHT+IFJqIFj5lhZezVS23pZG1vqw608fQnxHUvcadpBEUkYJcOiaD6R3kcVW3PBVgLmZKQ0S0Ee5bEsNDzmCMZZunQ=
X-Received: by 2002:a05:6214:76f:b0:6cb:4fad:5215 with SMTP id
 6a1803df08f44-6cbeff37f40mr20257646d6.2.1728662605884; Fri, 11 Oct 2024
 09:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010063906.51767-1-chizobajames21@gmail.com> <20241011154555.584917-1-chizobajames21@gmail.com>
In-Reply-To: <20241011154555.584917-1-chizobajames21@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 11 Oct 2024 12:03:14 -0400
Message-ID: <CAPig+cRLdzAEA-G=L81yR9dmm8Y-5VEU7ybyohKmbq9=0bDUaQ@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v3] t6050: avoid pipes with downstream Git commands
To: chizobajames21@gmail.com
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 11:46=E2=80=AFAM <chizobajames21@gmail.com> wrote:
> In pipes, the exit code of a chain of commands is determined by
> the final command. In order not to miss the exit code of a failed
> Git command, avoid pipes instead write output of Git commands
> into a file.
> For better debugging experience, instances of "grep" were changed
> to "test_grep". "test_grep" provides more context in case of a
> failed "grep".
>
> Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
> ---
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> @@ -344,7 +374,8 @@ test_expect_success 'test --format medium' '
> -       git replace -l --format medium | sort >actual &&
> +       git replace -l --format medium >actual &&
> +       sort actual &&
>         test_cmp expected actual

Isn't this conversion broken? The `sort` command emits the sorted
content to its standard output stream; it does not sort the file in
place. So this is doing the sort but then simply throwing the output
away, not capturing it to a file for comparison via `test_cmp`.
