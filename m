Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BA6DE
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 09:22:01 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-425860bf009so2814051cf.2
        for <git@vger.kernel.org>; Wed, 06 Dec 2023 09:22:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701883320; x=1702488120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jWDgUfRaeq8TsnA2PLc6lvNIfHT5gBcDpth6UHOBvc=;
        b=Ol5UD4EMC+cXTOVc0CvcYHGbWgCjh858NbFNFIMI8wVGOj0TEIWq9RWgG92RJhXFun
         FEVnjYQEkLobK0rWShvboOjU0FK2U/qyg51Wl7dtioBroI+5AiQ5lWRSXdbTQPVPe3Mm
         AaGNPrE+0tI8LTL8/e5rN5E8N5Urv0MeZr8g8j3nPYcgiZpTMK2niE/Dc0VAuDuR3vj9
         7vTo8TeXvFBcAwcq/bVMPD8cc+qnO8utkFmRVdrtdGyt2rnaxTO1DSZcGGrHbxQYC72m
         FOwp2kbwX/zBMBwbG4spCuQpVmvVhvhBOa6HpsaYk8voddYH491FsGEmfeNe6oc759Wq
         KvRQ==
X-Gm-Message-State: AOJu0YzCgTgKkh9fgrCx4wlwxNf2NlSFH9txHySpOgaeOwu3/Wlv5gFc
	qtn43BcYejgAvGD1lfBGdx7T8xqf77Hsl0bxisU7WNfDfMEuhQ==
X-Google-Smtp-Source: AGHT+IFCeR8jNRD9h5eWhA1h9zt6DiGcvnvdKYVrzOI+TmeYjsixkCykCRo0oNZejSbuCq7JWTjQmwMnCPNQ5kpNFCA=
X-Received: by 2002:ad4:58f4:0:b0:67a:a721:caed with SMTP id
 di20-20020ad458f4000000b0067aa721caedmr1119737qvb.78.1701883320628; Wed, 06
 Dec 2023 09:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231206115215.94467-1-l.s.r@web.de> <20231206115215.94467-4-l.s.r@web.de>
In-Reply-To: <20231206115215.94467-4-l.s.r@web.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 6 Dec 2023 12:21:48 -0500
Message-ID: <CAPig+cQBKk4PpCjT1RN+puS5vSo8_jZ3wONAgGhRvduw3jZT8A@mail.gmail.com>
Subject: Re: [PATCH 3/7] revision: use die_for_incompatible_opt3() for --graph/--reverse/--walk-reflogs
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 6, 2023 at 6:53=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
> The revision options --reverse is incompatibel with --walk-reflogs and

s/incompatibel/incompatible/

> --graph is incompatible with both --reverse and --walk-reflogs.  So they
> are all incompatible with each other.
>
> Use the function for checking three mutually incompatible options,
> die_for_incompatible_opt3(), to perform this check in one place and
> without repetition.  This is shorter and clearer.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
