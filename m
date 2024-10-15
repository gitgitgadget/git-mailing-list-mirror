Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B76F1CBA0E
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005438; cv=none; b=W36p9yeuNaErMHOGyeebUE/eQYraO1rZd/SkqMvLrcAJiUgnUhPp5Wev8jkqkCHsq6FKCLUQ84jry6q4PEPmMi+uGD4H27eAM5t0FaZnazVgKbC0Y7zg3EcgxKJ85IOI+MZ1GJdGe8vtOAGQ8/YqZhrbpHu6DFVjnUvV+/7ames=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005438; c=relaxed/simple;
	bh=lyzhFHnQRLgZv5h9LLJrebPiKCr3IeX9Zykf7vpZt2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLtXRIBbV6MazhnTM/4IfIZze5tVca6QPWLgTGpDtuhzqKx5hWE3zMw0FeeiZGYKl17e5ki5Yvj5F+2MkOYSMVZVF2lAVvkKWd3s2myeaI1yGdBJX3GYJ4TNRfHKl9KfjkQNm4yn0bD+e8/duL8CRm6fz1D8Zct8VTLhsMZa09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcowZdS4; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcowZdS4"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5e98bfea0ceso2661301eaf.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729005436; x=1729610236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWwF45Z+8SzgpySphQot0AXTlYq4SN9Jq0/+oj9RsZk=;
        b=fcowZdS4YLc/OZtuqxMbtpv2fvYZtqYn68wiMi0ej3YQZKPUoplYC1tO0mb+k9p2vj
         9FPrKso9hVMQqBLwxF9G1LQ6ejrz0fFMv0qyVeG+FHt4/RrbdJraxgPZ66xm+xevmyCd
         1r4pqbX5djqLo2EhF0Kw9+lgjsr0+Ye3NQ+j3DkQJOF42LF2AcHLt7iJTqPzUmGpaJOb
         D0VyJhU06oVOnu4W9/5sHs+ig8i8+ZcigJniP6pQw25guBIkulCGxeCMgwZh8dlEbWu4
         KDLZcEftO+3K1flTPkyoZcnDsHZFAPRlus5VSjKxOMMJJbmt4nGpWkJ2HbhrKVvk0r1s
         Q2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729005436; x=1729610236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWwF45Z+8SzgpySphQot0AXTlYq4SN9Jq0/+oj9RsZk=;
        b=tNKLQQ0N2HkjjZFq3EdpENz9ofEHwvf5xumyjn/0z/2IcdhGcQzNJEEiij4iDtGxlz
         dgCBhul/c7HB8DzcGWSVFGticRTabkK9QQSpWCKxZ0lF3tG5kX8j5VUBKMwVtNnpMZ3A
         X6gASCiBuwIwjJRPGTpZN1472HBdabkB7nP4AY2URhF3m2LMwRp46bQPKFEdW3OTJ9G+
         1+3NlbUq6+sC8a/ij/oMSyluYSZF4wm3hQ/L1gnY92ohrSTKhKQglAQAXcWqejzUU3IB
         ZqeVBqO1QkkIbjdMRtsVMV6+/PoWrhkBfD+vUp99B+11wRVlkdB9N6esYn1ayksalXn+
         rjaA==
X-Forwarded-Encrypted: i=1; AJvYcCXrcxncVUtIlaPyZUtpKrpbS52iGf+U4BEAqmGGMzc05u5w83up8NnfiALRgrtXNIFh5s0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/5Ucuuqtk4x5i9c5CupKuaqa8hA0IsA9K+E6FhU++5nRh15aj
	aViC/TQSP12AjlbIZnv2Q5AYFlgMbGSqU2I+nZqyw8JrDroflLfXWPAKEtaYeIrcslT93G+Xg4s
	mqTfRMnzpQ3aOkTA2/UVLCFgLMrU=
X-Google-Smtp-Source: AGHT+IFwmvSWFX9gud6OhBB7D3gIA1a6rNQtF2DdnVjzsXi3EDu5iOhrN9rWIqibkt7iC9KIcAYXzM5sODdiv6swJUg=
X-Received: by 2002:a05:6358:311c:b0:1c3:77fc:3bb6 with SMTP id
 e5c5f4694b2df-1c377fc410dmr123729755d.21.1729005436108; Tue, 15 Oct 2024
 08:17:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <c93bc2d81ffb33a2a61dda2878fa3b9987545e0b.1728774574.git.gitgitgadget@gmail.com>
 <CAPSxiM-V1qOB9QXUY3aDh+_nGdDHBWXJZ54U9p_XxKfHoODu7A@mail.gmail.com>
 <Zwz4B4osJnYJw6pd@pks.im> <2a937b6f-a3fb-4f2a-997b-5508f0e20e65@gmail.com>
 <Zw0kGLZ-mcYjb6Je@pks.im> <2160f8ea-5f00-49d9-8e02-d71d4d827d39@gmail.com>
 <CAPSxiM9ncwaZ3HF72wsRwmen7joWk3mjipsu78WxKEzLX607sw@mail.gmail.com>
 <CAPSxiM-aptyjesMX1H-P5QJjA-6CUonA01Bo84cq2_t==TqFgw@mail.gmail.com> <84dbe9f1-976d-45f8-a49a-d0f942906686@gmail.com>
In-Reply-To: <84dbe9f1-976d-45f8-a49a-d0f942906686@gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 15 Oct 2024 15:17:05 +0000
Message-ID: <CAPSxiM8-C6DAE3nYqMUCs+UgHN1R41grwVE+S-cSi6gZGvCpYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] parse: replace atoi() with strtoul_ui() and strtol_i()
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:36=E2=80=AFPM <phillip.wood123@gmail.com> wrote:
>
> On 14/10/2024 17:26, Usman Akinyemi wrote:
> > On Mon, Oct 14, 2024 at 4:13=E2=80=AFPM Usman Akinyemi
> >> On Mon, Oct 14, 2024 at 2:55=E2=80=AFPM Phillip Wood <phillip.wood123@=
gmail.com> wrote:
> >> I got this from a leftoverbit which the main issue was reported as
> >> bug. https://public-inbox.org/git/CAC4O8c-nuOTS=3Da0sVp1603KaM2bZjs+yN=
ZzdAaa5CGTNGFE7hQ@mail.gmail.com/
> >> For the test, I should have the test as another patch right ?
>
> In general you should add tests in the same commit as the code changes
> that they test. In this instance I think you want to split this patch
> into three, one patch for git-daemon, one for imap-send and one for the
> merge marker config changes. Each patch should have a commit message
> explaining the changes and whether they change the behavior of the code
> (for example rejecting non-numbers) and add some tests. Note that I
> don't think it is possible to test the imap-send changes but the other
> two should be easy enough. The tests should be added to one of the
> existing test files that are testing the code being changed.
>
Hello, thanks for this, I was working on this and I need help. For the
merge-ll.c,
I noticed that the check->items[0].value were already checked to
ensure they do not contain letters in them.
        if (check->items[1].value) {
                marker_size =3D atoi(check->items[1].value);
                if (strtol_i(check->items[1].value, 10, &marker_size))
                        die("invalid marker-size expecting an integer");
                if (marker_size <=3D 0)
                        marker_size =3D DEFAULT_CONFLICT_MARKER_SIZE

error: option `marker-size' expects a numerical value
not ok 38 - merge without conflict wrong marker-size
#
# cp new1.txt test.txt &&
# test_must_fail git merge-file -p --marker-size=3D1a test.txt orig.txt
new2.txt 2>error &&
# cat error &&
#     grep "invalid" error
#
I grepped the error message and I noticed that the message is gotten
from parse-options.c and it ensures that the arg is negative. How to
proceed in such a case ?

Also, for the daemon.c I am finding
it hard to get the exact test file to add the new test.

Thank you.
Usman Akinyemi


> >> Thanks.
> > Also, do I need to add the reference which mentions the leftoverbit in
> > the commit message?
>
> I'm not sure that's necessary so long as you explain the reason for the
> changes in the commit message.
>
>
> Best Wishes
>
> Phillip
>
>
