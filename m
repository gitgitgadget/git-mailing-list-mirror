Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362F241695
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 04:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774326491; cv=pass; b=iXyXyktrtz8Tq1fq7/582EXg5rY5NYwap+mCxaXOB8Ijjxt5gO9bbFUs1ATK4z0B9g9b67weO3Vd9gSit1gtnkfM+sJOozfcY32R/Ii2EKpVNnXciGHNUjXN9sDgZG6br7/Oh9Mr5pspE7mpgNGm8Ym4L3M0Sf9V9K7idIU5hjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774326491; c=relaxed/simple;
	bh=TL3EBtDh0XSlq5wNL2esBV9q9n7bHK/ux3npemPct94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rO4INtJyD8SZrUl/plzbJNyf2Gl4q7Pvk+V3VYA/9w3prEiVBSEsKK8MHItdNme9JzVKQwvUoHhiWf36WuKSizv74+Opc4kV7fVMoovk1/CqEfXogE3uVtt7DmuZj++LTjBC/bwYrrcXUy9Kwy5FZgsFy29d4c98L4jQO4T6NWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-124a7216c9cso303216c88.0
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 21:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774326489; cv=none;
        d=google.com; s=arc-20240605;
        b=GuoN72fe42Ne7p460Blv5RjkommLWmBmkTtICBNd3z38cRTTLyw3PjoqHGlRTgeLmK
         7XVw95/Vezz1LwE3aqW00wc2+wDcmm4p87PFzHgewD6ZYLI4Oe61NUcOE36xvkhWNyaR
         YaH2C2LNPdBiNZfVv1ErrWYZ55IwDCDiEI2esW03nhx2+vqqz8wlf4L9/epeA87qhYR+
         GusP6Qa/vbkdEEA1Us2brlUaozjeOJgfYBODInNWbuN52RKWNo73xujRDqgkH93aaej2
         yWUXBF7B3NWaYSdefi2l3Wr4OBBukfbCn9gs2Jew3f+GBSTigNUad6UYTEXid1sc42hW
         rDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=LSYIXwA/r7Kz9DDct6QAfTqRQJ8ALyjW0x1cgTJQLQ4=;
        fh=R9x9/2HsTdRKtZSEL4NTQaPda4anL/aroNKhYv+pkRc=;
        b=j0h87juiNnQZFrZWjEznn+oc0yh8Fg4RKFYcjcCgs5uyMhtkrZToYnmFLZTiqicl6l
         TizGjy2NMYynNVhimpm6d2eA/pBwtrfu2Cfmk6dCZuMs65boMSnOAFXZkac3l81uMpkb
         EXDSpgQcC0k0OoUN6dIPac8GXNdyHDHc9ycGFV7bUTOsjv1K6lwp60orj1G6rwMwuXHw
         7ZynyCPlQMmjy7we8cjWayKC+WYOHjRiozD/K5gTMS/EgEir/Uq+2Q/aQIWDbbABjBF4
         cRbj6ryIJ0FzChLQFOc/NtPFRZaZ0HJ0WPwrYvV2IoQejkACsPPL6LpD5EX9C3eXcY+v
         z5yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774326489; x=1774931289;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LSYIXwA/r7Kz9DDct6QAfTqRQJ8ALyjW0x1cgTJQLQ4=;
        b=Mm87RtQXLGEETb/Orrhjpjfp8air3qclcpqBXDJGuPZzL/TXiY8BBUjzdvhbpZOExd
         jUKDQ10rK0Fauvhh+Au0UHy9JBk5OPD6Ijj4mE4do1AFWJ3Ux8vDNzcvTj3OaQieKu2z
         2UpViWYLxG0MnY0E4yZpwIfmb4OPwJhHS+rtLVLmOvzenZ13oAYmT3ogLfpptEaG3cHX
         GlaSqzaXimMD+MPIxALRtsl/kneW2CN18IyHg5oRhvMYU+EtXHQdkhDvL/Z721UmeR1g
         YriJFwfKyQh44PR6wkyQELA6SGQzASbCZNU8SQNCPkoNNn4jjxa6xt40xZcswwYx3CSF
         d5nQ==
X-Gm-Message-State: AOJu0YyT6gH4PoSTjFqWoSlP2q7NyeFLTl6NPwWwK96+1SSVkhxe7aF+
	6kU2aoy0zc1Y6pOBck5XZkZLhqPlDGJnZIVYtYQXkS6AgV5AYq5I7BTsKPIiGmcH/VlWAXzgSv0
	FMhrzXkPB7P0Ybfu68tHyErGLHXxn13k=
X-Gm-Gg: ATEYQzwNy71Kw1ClL2XPcjK8Y7KK+46bM6g7my0g7Qo3yFEMXK8d99RVrYMgq7LchK+
	5FCfaIef5PmpQRQNlNdf0O+A+KS5meVqJN+3CAiWFCIJD7mhDv06zV3jEG8TXM37X6/M+jY7a7D
	5Z7WLSLVDzfiaZXURk+ZZE7zV12N5LXV2tkgiRH4rpGeRcRHj2Gp3koKxkBa0fxCkvHpZnkjYSE
	TSooxk57GDrnG30/tqjlRopuM+xs0fiPnO2C9rM3GAXcmGmWIi6aXTrnQzVNauVs7F45FkavGoU
	SZ22jIYXmK2lrdD8igljOat83wkf1QqADQeUbFQ/ow==
X-Received: by 2002:a05:7300:aca5:b0:2bd:fe5a:b87b with SMTP id
 5a478bee46e88-2c1093dbc83mr3281938eec.0.1774326489391; Mon, 23 Mar 2026
 21:28:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a26599ba-01b0-4587-ba0c-bd28a822c615@gmail.com> <20260324041903.43155-1-jayeshdaga99@gmail.com>
In-Reply-To: <20260324041903.43155-1-jayeshdaga99@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 24 Mar 2026 00:27:57 -0400
X-Gm-Features: AQROBzBt4nHgy7_EdO5DbdOjNTjqnrvKj2Wz-64obsMdlzTbggoieoI6jNhFSSY
Message-ID: <CAPig+cRo6N-idg5ZEzsUyCZUzLoGNV5RR8PUxBb_RghoPXdXNQ@mail.gmail.com>
Subject: Re: [PATCH v2] t/pack-refs-tests: drop '-f' from test_path_is_missing
To: jayesh0104 <jayeshdaga99@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, a3205153416@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 12:22=E2=80=AFAM jayesh0104 <jayeshdaga99@gmail.com=
> wrote:
> test_path_is_missing expects exactly one argument: the path to
> check for absence. Passing '-f' is incorrect and results in
> "bug in the test script: 1 param" during test execution.
>
> The '-f' flag appears to have been carried over from the
> equivalent 'test -f' usage, but test_path_is_missing does not
> accept such flags.
>
> Remove the extraneous '-f' to use the helper correctly and
> restore proper test behavior.

This commit message which talks about changing `test_path_is_missing
-f <path>` into `test_path_is_missing <path>`...

> Signed-off-by: Jayesh Daga <jayeshdaga99@gmail.com>
> ---
> diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
> @@ -61,7 +61,7 @@ test_expect_success 'see if a branch still exists after=
 git ${pack_refs} --prune
>  test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
>         git branch f &&
>         git ${pack_refs} --all --prune &&
> -       ! test -f .git/refs/heads/f
> +       test_path_is_missing .git/refs/heads/f
>  '

...does not reflect the code change at all.
