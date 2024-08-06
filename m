Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38C73C485
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722968809; cv=none; b=T3IT2LLLVLiXTPhfrHAw5LHQ3jKCz+Qsnr8FGCW6SlQAzBgfXilmej1V1neKDfwEv3QQKh8tDChb8GWpiN6K7rGZNRdrOZY6LVw9tLz3naslS6Jn1Z5znu7ZS1sgKVXNrGiWjhiispSeopEoDiRMtWkAUGfEYh/nF5LXvPoAPu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722968809; c=relaxed/simple;
	bh=xwRPZYQwA1mjqlUN7C0B6pQaDbW6iIdVg6PF21ZEhi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhQ0R2VkLzR3ZUX04+IM2YdfocV4ttUYP+5vOQ/pWpyypNbCRoro56alA1kBI+IlZQeJF2wPqH3WxXfTQ92Fjdjm7TllwPgLyaidrxzGKg8Kz7hdG7f46g+76IZ97Kksrqa2Sr/znzNAaVT2AZUxmXusvMTzi9VGVdX6I6xhVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7091558067eso554179a34.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 11:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722968807; x=1723573607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwRPZYQwA1mjqlUN7C0B6pQaDbW6iIdVg6PF21ZEhi0=;
        b=Ip0XngtXBqUx8il4Iw2IAVj/5Fm/lLViywPnVBNbDlbovdABfgerrfGBhLETTgrXzX
         XsNefmASQuhPDcm9iHgLqCcmmU6e/e/AyBcegtRUgg9GW0hTzzST5W+vH7zhaA5qrn6T
         PGnY+GdYnFkSuiwyou3Li6wb0EbnaJYp3+srDZ/qySj3RILoUP4XxDc6lI3iutHYdoL2
         iDeBpljyflFROQo4fqvcweUKvtOjIZhR87Vtkbgxx12LaKhmk5rePpTNR/JbJ3eJPltv
         UgM8m0NENSexreiMnB8KM83cOEWv/MLJ2pnftYuDS/6xGVFviQF14bNzo4VUSD2P2dWf
         GYFw==
X-Gm-Message-State: AOJu0YwVCsVrfHeKA8VtCi2cMyhXNDksksIJhJPfNFuh+LMjmLwjCwBF
	szQlsHjpeFH63cQzHBgZr7a4K8CeXXKvBk4U8MIl6/U7FJ77YFigWPDRK+cx2Ve/fGYKq64Xw5g
	KWSzG3LhxXEMOeUp9kELnZnmpVhs=
X-Google-Smtp-Source: AGHT+IFXMJG1b7Dza0iMwrypHk+j7L7yx34pIMh5AzKSzCE1gEdNZMfzWSTBaH7Z/3g0wBfdWEzvmLYXOIBQAOnR+/g=
X-Received: by 2002:a05:6359:4c1e:b0:1a5:cb16:bc40 with SMTP id
 e5c5f4694b2df-1af3ba5aa7bmr1842777955d.7.1722968806788; Tue, 06 Aug 2024
 11:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <CA+osTZX4FBT5za3Nw2Hc=DCNNbFg=xL4b3AhNmN8S2XKb5BXUA@mail.gmail.com>
In-Reply-To: <CA+osTZX4FBT5za3Nw2Hc=DCNNbFg=xL4b3AhNmN8S2XKb5BXUA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 6 Aug 2024 14:26:35 -0400
Message-ID: <CAPig+cQ05ocHKELovvEhvptAn09DLuitQkdJyFQ=N5qvje-GhQ@mail.gmail.com>
Subject: Re: 2.46 submodule breakage
To: =?UTF-8?B?SmVwcGUgw5hsYW5k?= <joland@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:21=E2=80=AFAM Jeppe =C3=98land <joland@gmail.com> =
wrote:
> I did a bunch of testing to narrow down the cause:
>
> It is not related to the Windows port - all the testing was done in WSL.
> It only happens when the clone containing submodules is done with
> --ref-format=3Dreftable.
> The commit breaking it is: 129cb1b99d hash: drop (mostly) unused
> `is_empty_{blob,tree}_sha1()` functions

Cc:'ing Patrick, the author of that change.
