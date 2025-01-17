Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60491F75A6
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 06:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094640; cv=none; b=SHbALwK/nNO3vwrMgBygTXQSlWCcUv/E/kEZcJBXTMX/SxshRjTUZk9MfWRNpIB0QA34SGipxVI9VGQLjMkKGUE8dps3pcMq4zKJA3ArtJ4ruozBp2JQEZA8QEjW8+02RvsWVj4qTci8yFnF4zsljfKlQqmWnD7LeAepRWGl4so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094640; c=relaxed/simple;
	bh=Zv20BCF9BaZuoKoIsxZfqH6o5kPfOAnly5Td02MfV/g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FS1Z1qFkRtST6cS8RXjx8jo/DTavaWFExMAb4KaKm4AQbzdS1R/EnxEPx1kVQvuPl+6kuhOKLUNTx+7hbhYAlcnQAg0i/Sy7O6HU5WUCL89kKC7ayjloEjing4U3DDZTQ9hj6J8foHNW/HI9/CNQUpuqk87e4Np75o/Ieqc/YnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4nEXMIb; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4nEXMIb"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4b11a11a4f0so462788137.3
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 22:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737094637; x=1737699437; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JzYcvo0D/N2XxsmwKQQy6BHqqK4W/ZwmJiAof0ICtVU=;
        b=R4nEXMIb1l+sjfo9x55H+MnXY9IUF1V0LflyHw7WtvxhAQ5jt05YXJnDo8FBF4Ji1u
         cUz0POgTJ0J2b4D5UkIa9iY+ljQ5teM0ndtUBuS9vq+ZgYJrU0J7B6auzF/oE1BhTWP6
         B9DlJkAkWrK99Z0a91TVaqzS6t9Z7C49cI5N6odOhHkc6vgrxHMyrFlWGuCR1cuaojeS
         2/O3Rsjvhi8G8kVJwSM69yE18fMvvcL/0eAkXGwmgyS8VOqvpDUq4b4rfZc5+ufDGEzx
         FI5pIMIv9v2sZwGVhT7e5obKvOjaIVLJkEf6VFBsf/Ek5pXy/dk1VgksukILnB49HfRj
         i+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737094638; x=1737699438;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzYcvo0D/N2XxsmwKQQy6BHqqK4W/ZwmJiAof0ICtVU=;
        b=fA9VFjtMaY+FQsruozzQ4NA0E88lbQWXUAUTR/J4qQx/ebOjV5roU3Kk81p11ETVil
         VqyR6S2SI5WWLRUOGOYNRmH8OulgzH+t5dyDW2J4xnVLmuSIEViWlzkGoaFhwP5xIPvH
         QBf7lzOiltdrb1utx38enxPnZ6ykirp62RpiDbxuybbUtiYCaZfvuB2PpyQVOdiTeMXT
         0HX8BLL9tS1DnKfxnMrMG5aXsj4yJWBcIAT9/yCIoEuVS6z7jrMOs2dv1VOWnFqDW4WA
         uO+RgRNvSN1L6aY5zqBdQNFGIozkeEg5jCB4pyu0c7HybfFtt7Tix+7dGE7mA/O60cSH
         JUXA==
X-Gm-Message-State: AOJu0Yx73g9ZPOv5TuHLcts79EBhNqplxKmeR/49nkbBlEFjecGxJT4X
	x7EBmPZrqzRANDvjbAbK+d2CkkyF/dV5J5b4FMBojS3Dwg8vvlVHYow7djc+ffyn9DzaSmEdMbp
	MOw7zj8+c5ps0wAE4w2lPxCj0Zr4ZtWIt
X-Gm-Gg: ASbGncsV4b1KTCRG2y56TGgtpLmps4GBf5k8P3lKXUfvVLfXIIYWKFaGM3fMDS8Daf2
	UbmDB7eHWvB699EBWWSj+3e6KumaEI4wAExikyTE=
X-Google-Smtp-Source: AGHT+IHURY0CUSV/pz++7DjeKt0sem+wjz2VMKH20WksP3eCltsfAN6EA+S/+wM8HBHpGTNyxPii0LihT/Olri4TKk8=
X-Received: by 2002:a05:6102:f10:b0:4b1:130f:9fd5 with SMTP id
 ada2fe7eead31-4b690cddfb5mr865161137.19.1737094637652; Thu, 16 Jan 2025
 22:17:17 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 16 Jan 2025 22:17:16 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqmsfqnw4s.fsf@gitster.g>
References: <Z4UbkcmJAU1MT-Rs@tapette.crustytoothpaste.net>
 <CAOLa=ZTL9n_DPhNr49XAd6bT838kc09oVx_AH7Pb4o8VK_xQ9w@mail.gmail.com>
 <Z4mUizLNUdq_1BgY@tapette.crustytoothpaste.net> <xmqqmsfqnw4s.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 16 Jan 2025 22:17:16 -0800
X-Gm-Features: AbW1kvZwZH3GWhU9RHZzXk1oD6QkIfweu95IphTWklFlbbf2fcQZ1yc-nnNsp4s
Message-ID: <CAOLa=ZTqv4owoj5qFjn9XqKahsmBhY-CynQJstWcP=OBChRn5g@mail.gmail.com>
Subject: Re: Bug in 2.48 with `git refs migrate`
To: Junio C Hamano <gitster@pobox.com>, "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Content-Type: multipart/mixed; boundary="000000000000d1b01f062be0dca7"

--000000000000d1b01f062be0dca7
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On 2025-01-15 at 11:54:51, Karthik Nayak wrote:
>>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>>> I'm attaching a patch below which should fixes the issue for me and also
>>> adding a test to test against the same. I'd be grateful if you could
>>> also test the patch against the repositoryies you mention.
>>
>> I can confirm that the patch did indeed fix the problem.  I was able to
>> convert both repositories successfully (and very quickly, no less), and
>> they both work fine (I did normal development activity with them) with
>> an unmodified Git 2.48 after the migration process.
>>
>> Thanks again for the quick fix.
>
> Thanks, both.  Let's merge it down to 'next' and then to 'master',
> then.

I was going to send some additional commits around the patch as a v2,
but I think they can come in as follow ups. This would ensure that the
fix is already in place and we can discuss over the other commits
slowly.

Thanks

--000000000000d1b01f062be0dca7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f2f4e5a1a2c96a1f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1lSjllQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWNrREFDZ3ZOSnVkZTUzcDMvMnBKSHJ5L3doclBLdAp3cDJ6NUFjbmxO
elI4VFpHYVZWaVJoanZvR2RPanYxb2x0cmJHWU01WWtWNGc1L3BheUNaVjVBeGVmRzI3c0QzClF6
a0FPbUwyRkk2MGxnZm10Q0hTSDQwa3M5RWRlV2ZxWkM1cmFXbVI0NGplYjVKMkg2bG1JRTU0SWFN
NkVkdFkKVjdZcjhrUFhSVDRCcW1TZHAycHVvenlYTzRhMVdDa2VQMVUzc3JrV1paMXpJcWwrNkYr
L3dueS9pQ0JwRUJJUwo0NDd6K3BWUkZwZ0JDWU5mTlVDTmlSY1BOTGt4ZzV6MU5DakdnZi9ldHdm
TEYxS0N4N2J3S3QvV2l2SndSc293CmJEbEliMzRRMmpIa3dJN2hXYTJlV3NkNTBXWmRYeWovRkph
bkJkQ29xWmZsbjlaYWt6N0VUeFlVbmNUVVNvdTIKcGo4UldncVBhejZjb2RJSTQ5b28yUVFNM0th
YzVqaCs2NFk5cHdsZG9UOUNMK01SKzRXWS8vZFk5ckQ0YkhGMAphd1ZCRUtSTk5SRDhCS3BRN0xL
TzJqaVhLQnZCY3J3czcvWkVaMDFveXNUakFBY3EweS9sTTdBWXdDYVR3RGxFCkFEaDFzUmpYMm9r
Q0YrbkEwMy93d0wrVU5MeUxaaHlkdEMwZWxXUT0KPTNzOFQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d1b01f062be0dca7--
