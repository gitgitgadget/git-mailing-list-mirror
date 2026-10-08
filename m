Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EA23CBE79
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 06:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791442597; cv=pass; b=p9uL8qiMe54/vUH4chjKEpUc5Prqqy85Gfgw+UNw377p1HWzZhfO/aDyk54lv9OKe/FjKiIkUZqd61Plry3xhsTzvRTWNEfSoRBoMMcL5fDYs80ueLELF43yfqd/QDJAcdLGVLl/S9Tm3g0i5uUnmaTl9oLUVa9CRwRMOr5oGfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791442597; c=relaxed/simple;
	bh=QzbM7LlrDpwrCk2J8OCdiilIDv43KI9T55X+m7qmkW8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=iv5CE+VfyQ2HJIT6lf02sl1blQYehih4P6QBZaCMKbga348aSzXj5zxaf8N6U9yg66LfN2XTdlCyNFCcimjtILd1zBxifeY4GzJfK8yxqCo1E5uvyC6YXGEMj+UlN+nXBC520KetGVvy8k98MDl9R65pMf1dHNRcTsU4ciYHkIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nortesoftware.dev; spf=pass smtp.mailfrom=nortesoftware.dev; dkim=pass (2048-bit key) header.d=nortesoftware.dev header.i=@nortesoftware.dev header.b=I6nWNgjR; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nortesoftware.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nortesoftware.dev header.i=@nortesoftware.dev header.b="I6nWNgjR"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5352a876d5aso30945771cf.1
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 23:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791442594; cv=none;
        d=google.com; s=arc-20260327;
        b=BCCtdJizUQuWN0gU2+W4a+fUvosHddyNIf6EP+YoZGbPzLlOPa6KLBLBsMds8bd1Ea
         Dwi5xLhJyYSYsj5qN1qmQEq/QZPAy3gyjAZQcnEaa6kpEtUddSfF1XgiywhV5cMB3rMm
         mtck+GaGhK/dRk3UfegCW1JqTu2W8mm/dtBj06Q+OmNjtRrCLXuU+3ZBGB9+VOOIstXR
         kargpK+EkU9lA4u5KxqBEeZRutrSgXFuaSwT3lzv/XynZfqDwxY/xN0bV8vyvv/pq6+A
         JR6udDGIMEZwfNsBFPFJWehprVBlCq9lMxeDpPFalJTktx4j1GnDZwZeHEZZ6jeH01r3
         xtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=x1Al5R19kJCxHAvKKnW6p32D1sVcQARr8h72ZAzOC24=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=gX44SxeW66VLe2Lsa0fLPNL/OoRASNciyMITwgmHxT3q7d8G+wZyq11VeWNSkKW/q6
         h02sNXog6UoDd5yfiOkNTqIm0p3pBv8E5kQbVb+7sj9wMvyBTyYvtsPgHBIrCHro/N8f
         kOwKIQNF2KUVI9azV/j4sBiwAzDzYdCb1AuIpulcmGPRdhGh0CswroBhkXysoFbYPCGA
         TfBC6w8cVPrRy8khVXPAwPJvM3m4/AXmWEvwcgv4Soci8gKO9pN+jKc6GO7B3YJkcE3/
         ApIeU1Qn3jD4D8Nyw3gbgTWnP4FtBUwTR3z/nNuQpAA70SgRx1+gd7PMeTJUO6qNFTPG
         e9HA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nortesoftware.dev; s=google; t=1791442594; x=1792047394; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=x1Al5R19kJCxHAvKKnW6p32D1sVcQARr8h72ZAzOC24=;
        b=I6nWNgjRFMdir5sAImdpQbC8R5718KA3WuYKmQku2p/8OiI7WuBsMzyi6jijg/dKFd
         NqlPIoK1FsDod0qI11kWUZrj3lfhSgGOpGTnzMo0EuLeyfxhiU+ceFqXGM2IpPolXxit
         TPF2YUQ8aHnccGXKQVzC2zghvZ6uYqkXd1lRwvkd8LJs0ck9XfKIeDibUdXh+ZvK3p/I
         6gcIzSyG1UoDBxf7XFBW0kplnMFkOF8O900i9ykCE2XYUsmT2YKNSZS2LWJnmFIXraEe
         vjoW+ZFRV27YhDeJo94tqAmnWVmPxWI/opjFZIJzxDbqvvj0B6vtwvRRyDV+etlZi+NV
         PVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791442594; x=1792047394;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1Al5R19kJCxHAvKKnW6p32D1sVcQARr8h72ZAzOC24=;
        b=xch4ttO9yeW1wP9qBNTADoGRkYC5WdIRv93sV1baCsGB2ucwaFT5Ro4y54JmqSKNUd
         ARY6Y55LoQSzhN/QUFPnxwcbo6yT7RS/QYjVBMGrmU098kEcFs4zZTyROramlEeDIiLM
         4bozR8J8e+QTz8X6NHGtbW0mWlNE/g4vGRu4l4xVaXtfHgc4/jh01oTGV9Ol9IKkiFVO
         HIGh3lZXpZW5rr7P2HYlWHCxcjKyQTSDeL3lqQOdUZfwwtiljMs8+6wq4EhZ3KJztc7E
         qsuTdzORIT75D+grhKo+gn1q9fhZBy6ysOKwFNnfiOw4eFpCU+a8IDg909lJAlHNjljh
         m3/g==
X-Gm-Message-State: AFuF++kTo4nDDOVD4LA6tu/kT+Ygk6GQKtzFGW3p6Jm/5fh0E4/Vgvjp
	4j2O5FzXrvAWaZCrbGZ6HOqS2PyB3qfaepPR2JemKK7Gz90jzp8B8GQIjmfq4tm0OtfCj0OgtN4
	FmnZWZmYJ98OVo7opn8LqUQpJTg7f4sLD3fYz+k4+HdAOKmeGtsz8EwE+
X-Gm-Gg: AYBFou06+OHv3ruVHqUwKt0kWC+PS3EVo3zk19E1vb/BWvEKZtAfyuOHqz1qS86cSbS
	P88pdDYZaFeIpRLlVqp6xqH+YOrr3fRgmatBA+iFBslcTcRbCW8EzWbxEnz8ISB/MTEgsWeTcK0
	Yq2bPZTuWZIcfTKvNRpPT4nQFzAZfolxJBQeKAZxhaq8NAQuwTYt/nw1f5hi+y6xSBYcwNvoxE0
	Ah/cx9rEYNnQkwrV/7UavgdBmdTEDpeiVvssUDDSO4GDu2X72ummNVrwGnGJBRSshQAMshmTzpT
	G0PLnGcEEeyKWGUHuRT5G5r1KLIZZAgxbZn9lT9w5+3FMibw0JdgYon4nzGSUzzy2MVDcfsUYi9
	hlGsjX1gfCkVHk83Hzq2Uc37yWLIAdffX9b8tVw==
X-Received: by 2002:a05:622a:4d9b:b0:532:c82e:7481 with SMTP id
 d75a77b69052e-535756328damr75851451cf.51.1791442594495; Wed, 07 Oct 2026
 23:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Christian_No=C3=A9_Ramos_L=C3=B3pez?= <chris@nortesoftware.dev>
Date: Thu, 8 Oct 2026 00:56:22 -0600
X-Gm-Features: AclHuK90XBM9xRdCRo8Cjtqo3cLnd5gU-Zh0ye7BFdUzD2WsbKJMYh6z3R0As2k
Message-ID: <CAHGSfbZ_Q8Ujt3om0POapkjWZed1pZVUrB-mV-e+UjmPgCNvWQ@mail.gmail.com>
Subject: ssh signing: valid-before is checked at the signer's own date, and a
 missing revocationFile fails open
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Two things that, together, mean an SSH signing key cannot be reliably
stopped from being trusted. git 2.47.3, OpenSSH 10.0p2, Debian 13;
source read at v2.47.3 and at master (c46c1e37724f).

1. valid-before is checked at a date the signer writes.

SSH signatures carry no time of their own, so git passes -Overify-time
from the committer or tagger line (gpg-interface.c,
parse_payload_metadata). alice's key is in the allowed signers file
with valid-before="20260101":

    ssh-old        %G?=G 2025-06-01 12:00:00 +0000 verify-commit=0 merge=0
    ssh-backdated  %G?=G 2025-06-01 12:00:00 +0000 verify-commit=0 merge=0
    ssh-honest     %G?=U 2026-10-08 02:15:15 -0400 verify-commit=1 merge=128

ssh-backdated was signed today, with only the committer and author
dates set to 2025-06-01. Nothing distinguishes it from ssh-old except
when it was made, which only its author knows. ssh-honest, signed and
dated today, is refused: "key has expired: verify time ... >
valid-before 2026-01-01T00:00:00".

The GPG backend refuses both:

    gpg-old        %G?=Y verify-commit=1 merge=128
    gpg-backdated  %G?=Y verify-commit=1 merge=128

The documentation for gpg.ssh.allowedSignersFile says "Git will mark
signatures as valid if the signing key was valid at the time of the
signature's creation", which is the intent, but does not say the time
comes from the commit. So valid-before rotates a key; it does not
retire one.

2. A configured revocation file that does not exist fails open.

gpg-interface.c:568-574 at v2.47.3 (579-586 at master): if the
revocation file exists, pass -r; otherwise warn and verify without it.
The same file, present and listing alice's key, refuses:

    S2-revoked       %G?=B verify-commit=1 merged=no
    S3-revfile-gone  %G?=G verify-commit=0 merged=yes
                     warning: ssh signing revocation file configured
but not found

S3 merged under `git merge --ff-only --verify-signatures`. An
unreadable file and a directory both fail closed:

    S4-revfile-0000  %G?=B verify-commit=1 merged=no
    S6-revfile-dir   %G?=B verify-commit=1 merged=no

ssh-keygen, given the same missing path, refuses: exit 255, "Could not
verify signature". git avoids that by not passing -r. OpenSSH's
RevokedKeys says, in sshd_config(5), "Note that if this file is not
readable, then public key authentication will be refused for all
users."

No test in git exercises gpg.ssh.revocationFile; it appears only in
Documentation/config/gpg.adoc and gpg-interface.c.

Controls for both runs, fixed beforehand: a good signature gives G and
merges; an unsigned commit gives N and is refused; the revocation file
present and listing the key gives B and is refused; a commit with its
message changed and the signature kept gives B and is refused.

Together: the two ways to stop trusting an SSH signing key are
valid-before, which the signer can date around, and revocationFile,
which does nothing if its path is wrong. Either would be enough on its
own if it held.

What I would ask for: refuse when the revocation file is configured and
missing, as ssh-keygen and sshd do, or say in the documentation that it
is ignored; and say, under valid-before, where the time compared
against it comes from.

On prior art: the ssh signing series (Fabian Stelzer, 2021) carried the
warning from before v4, and the review raised the config name's case,
not what a missing file should do. The key-lifetime series (RFC
2021-10-15 to v6 2021-12-09) passes the commit date to the check, and
the replies are about style. The N for an unconfigured allowed signers
file is already on the list (Grayson Tinker, 2026-06-25) and is not
part of this.

Christian Ramos
Norte Software
chris@nortesoftware.dev
