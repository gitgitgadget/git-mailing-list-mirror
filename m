Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E477192B6D
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 16:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744043198; cv=none; b=EHKWsHmessxd9mnyhj9Kq/8DzCD2CgY2qmI81TWfePY9UoqMfr1zdpxgAVHAZB7BWFwnYX/GzJg32mNr4/wB2HFS8xPxViKnGu/FKgfAoHRnVWMpICitXyId/YnfvXr0IqCsKK7Xwb6DCnC1Ll3DNViNb/gk8gDj3P9Ogb8cOmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744043198; c=relaxed/simple;
	bh=7XB7l5V5u09CHW+bQ5tfZy/kZIk4STDogwS/dPHB+Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U8LPFB6lf9lqLZ7cKU00XYEK2rbVtPoBDqg6zCJWcBR/cjJ+HbFpWfYXzLNw0dFQ2fiq+LRTGLqLCBuFz9M0xrDSa5OxvP30G7fwO8ZRzDDfIa2PQRq0qEauX6BD02otS2Azm2mh1W+eZYExDOduFDlllJWLptbOHvxwiicvO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c55d853b54so38737085a.0
        for <git@vger.kernel.org>; Mon, 07 Apr 2025 09:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744043195; x=1744647995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Cyp5jpPBfh1S1Ff7Lfeto9U9kclRNV/Vy4xkHERBUs=;
        b=GX3P09UoggqJ+/3iyZWH+7i1n2z2o1fZw1o7X8QEoJAdztllJ9iMuvEZlASqmuWLK/
         T1I/SZp4N+Y1htTpm9uSsWLY1j04G0vOLzC1oq9BXgPjysl3kuW21EWgUt68adYUs8CE
         K3mZkT4yLTTP9MKLWL4SjM1S9IPFzkt49JFWqt2rABlhoM7FO0VWhDYE7WPT9zNNHnnN
         gqLYXRah07z9SkX/XwyOpKVN0hKSVx7/KTt2s0+j0F94a7RIS5K/bc5gA31qF5D3hKth
         m6x4BShlSMyuMq686AN9+NcFqHEalGxEe6ngVblnbFVPY1U7qdEzu1NPAXy6k5I1Pqsd
         +BJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhKg4+ETADa4M5mSxQuXA2BoiJ4hTKGq3j/PeoUgcc58uH0z/pucOZZCm3Ir4UuMBK1+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywba/6iDuDQTZB5+5Sw7Cs3qyLt3r1hHKfqGi76ZjFH38tJyR2L
	e/t0ZlUjKBc1xXOSzqfA/b6A/Y2+AP4urHX22YdjT3GeLv5xtpbhkcyRVRXXa+UZURwnOONyBzt
	OJLzG+b1VG4qYA1rUHhh/z/qs2gnSIg==
X-Gm-Gg: ASbGncvOZVsUf/nf4O/4/1XFGED1q2soC0KoU5Eqwnpl3gTnpM4a2dU34PF6y4op8z0
	gvL4SeB/0gZNH7E38k6PADdVOHurqxpIUh6MSinxWNSjmPM5oxpoPr97H/znLLiWLxWPMy5fSUW
	Jt6WgumZV3uyint7WxupTZZ2/72GhkOA598FKS8bRpgDaWWPIDvABvzzc2s7g=
X-Google-Smtp-Source: AGHT+IG6iaX7Sq+odUETpKOllpnVmMaz72B4TFp/bmHpzKiB4y6jeNSuZHxC/RyoCtheCo3OGg4kVpHalw/VQRmle8Y=
X-Received: by 2002:a05:620a:454e:b0:7c0:c2ec:e560 with SMTP id
 af79cd13be357-7c774defd8amr686347485a.15.1744043195281; Mon, 07 Apr 2025
 09:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z_OEAxJENE_mGkVa@pks.im> <20250407111824.46518-1-anthonywang03@icloud.com>
 <20250407111824.46518-3-anthonywang03@icloud.com>
In-Reply-To: <20250407111824.46518-3-anthonywang03@icloud.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 7 Apr 2025 12:26:23 -0400
X-Gm-Features: ATxdqUHR5sdtTScwa-jp387L86zEsCEtjKJ-QZ6yqBqOBDWRKNbzt2BdaXqGiZ4
Message-ID: <CAPig+cQbMUQAHsx92QNLAvfkUKRFoVoWznhPQok0PN6HW3wxzQ@mail.gmail.com>
Subject: Re: [GSoC] [PATCH v2 2/3] t9811: Remove the -q quiet mode from some
 instances of grep
To: Anthony Wang <anthonywang513@gmail.com>
Cc: ps@pks.im, git@vger.kernel.org, karthik.188@gmail.com, shejialuo@gmail.com, 
	christian.couder@gmail.com, shyamthakkar001@gmail.com, 
	Anthony Wang <anthonywang03@icloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:18=E2=80=AFAM Anthony Wang <anthonywang513@gmail.c=
om> wrote:
> Remove the `-q` quiet mode from some instances of `grep`,
> as the lack of `-q` on the `grep` on line 99 implies that its output is
> required, when that is not the case. This change ensures consistency and
> avoids confusion about whether the output of `grep` is used.
> ---

Missing sign-off.

Rather than mentioning line 99 explicitly, it probably would be more
helpful to readers to say instead:

    ... the lack of `-q` on the "TAG_F1" `grep` implies...

> diff --git a/t/t9811-git-p4-label-import.sh b/t/t9811-git-p4-label-import=
.sh
> @@ -97,8 +97,8 @@ test_expect_success 'two labels on the same changelist'=
 '
>                 git tag >output &&
>                 grep TAG_F1 output &&
> -               grep -q TAG_F1_1 output &&
> -               grep -q TAG_F1_2 output &&
> +               grep TAG_F1_1 output &&
> +               grep TAG_F1_2 output &&

For such a simple change, it probably would be more common on this
project to combine patches [2/3] (which drops `-q`) and [3/3] (which
replaces `grep` with `test_grep`), and to simply explain as a
side-note in the commit message of the combined patch why `-q` is
being dropped. However, it's also fairly subjective, and others may
feel differently, so keeping the changes as separate patches is also
valid.
