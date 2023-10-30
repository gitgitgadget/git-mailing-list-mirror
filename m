Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F141945B
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0+G1vgk"
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7793399
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:15:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c595f5dc84so64923281fa.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698686123; x=1699290923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zdA/rRVOChuD/1DPyUV1QE/9k1Od9xKpLP/zlKP+4s=;
        b=X0+G1vgkkOvI1jEP+6CWiudpeyXJaDaryzCGqgpRTf9zySAHA9/p8oEDUwr+9NqVOO
         gCi47u97DZUkuIQy0ZK1rXarQiABDGUIVh9nxBLYN/9c9UIdfqcLSBKvXZ/7QSZhQGqX
         WXIRMUXJ+FSYUognqE0TUtVYo5Ek3+bXG9udIJ4+ilneLD15sS5pqRkLYkSvpvbMU0fO
         KRcJxlOEQQ68KfreTAWS69PjNPxvKl18kgRlqSXsRbM3nKKJATbHZXSqclfFTV3OubE2
         M5vSCkVQpIoOO7I18JHsCQ0SeHq1e0gV1cWftSCEthsWmk9PXCoFdSnaOe/r1wDqNJ7c
         tbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698686123; x=1699290923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zdA/rRVOChuD/1DPyUV1QE/9k1Od9xKpLP/zlKP+4s=;
        b=GPL6ytuvDyBaQF3H627Sy35aGGqXIgkII2vgnXo4QaOC6C7UsEjoU3DBH60cHiYmDJ
         cdKDusBeukU3Gv/6zPkZ27JJP3soS6ZMLm/yTI1h3YjGNjndtPVEiEo+RK+uK5d1BWfa
         NzbgTDonc3Fffg9UBZEU+CkE8wX8chw/H9o6E64dtk6B1WlZToANOTNGgtHDVukxlju4
         ldqwnbFkOfatwxFB5g0ocR+t//p5m1dc3dpvlHeOkINPv4mIwC0FnzCr0BF0DVwnSFrp
         OrI1v0vMt2/aFz+SSNCgxrzwFuYXpAQFPyELzWy1jKOzS/ZTHe1kXO1kLMx+Pb2blJfV
         LwdA==
X-Gm-Message-State: AOJu0YwQMnNSqAuTi8wtBWWrXZxrsYt96Jf7FSC+7mJAoDG3yfmAqWi2
	sYYoPGq3oX0V4MEDPxr5zQST9pq0mD7ZUWGVuKQ=
X-Google-Smtp-Source: AGHT+IGIPWXwxwBYW4xMdphfgTWIEZixeEoulT48NPtEcGYYrX4Z8k5HMFkkTE491Ijjitgprrv3q9afqm3mQ+44n6o=
X-Received: by 2002:a19:6d1d:0:b0:507:9b69:6028 with SMTP id
 i29-20020a196d1d000000b005079b696028mr79064lfc.24.1698686122494; Mon, 30 Oct
 2023 10:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net> <20231030162658.567523-1-sandals@crustytoothpaste.net>
In-Reply-To: <20231030162658.567523-1-sandals@crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 30 Oct 2023 10:15:10 -0700
Message-ID: <CABPp-BF6vxU5x5VLGbRhtcTBqDu3x31=vMOd2bimZNg2mkkvuA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Object ID support for git merge-file
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 9:27=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> This series introduces an --object-id option to git merge-file such
> that, instead of reading and writing from files on the system, it reads
> from and writes to the object store using blobs.
>
> Changes from v1:
> * Improve error handling
> * Re-add `-p` argument for documentation
>
> brian m. carlson (1):
>   merge-file: add an option to process object IDs
>
>  Documentation/git-merge-file.txt | 20 +++++++++++
>  builtin/merge-file.c             | 62 +++++++++++++++++++++++---------
>  t/t6403-merge-file.sh            | 58 ++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+), 16 deletions(-)

Thanks, this version looks good to me.
