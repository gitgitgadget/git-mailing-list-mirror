Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793699284;
	b=lqKPISRtCsP1cdq7eshv5ZqUB7xUNwWsWtT5XG+D5b1HclcGI9TWsm/pMiKSiicFrrMr
	 FySqiYJgJkel44TrsdpJflcX+5cDPgwhNWpi+f4lE5l6yJq9uZgZIKRI6TM92obq71EFy
	 s2YoBAJCZYWAZ53UDIzUPi6agIdQ1/yWHzWeJpi0/nnHSh0WQbGVQTZ+bQXZQULFvTTND
	 6skaCO7LAGkZ06Juc769S/QTKWCgqo85PURgb2YssDZf1iCOoikQfu6sKJSpLd0EpLFkD
	 BzY6Gsy1fTNDY360G5Ty32lWf10uQIwSHqqOH6OWT58jrh6Ea52zHc0xdeZ8jSi+hZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/FnOj7byRxiH3eT2nfwnnsumiSMo4zM9/UtpK8HuJcI=;
	b=P7MmKtBtvgTKR3uPGqBmea1cq8ahtP3FVx1jlWzh3166QEqFPYf5w3eKQiZxd2MQMUpF
	 Q6f0ZifmultTJDYPWWIz1yGFYe6M8fWzomE3RfgYjBD5Yck3DlWTXuz6j8uiezg54uden
	 7hiSISm1ZcGNhRKRGYHCk6XETE9HYlYLYqDK25owTykT4CGAqSi4bQ0vYxbT/ZA2LK1Zg
	 yOPSLxpq0UoaGIz0pTCw8x1M4mRyAoCL/HthDN92XXZaAmVASoblAmmo3xiCsaBEhghxm
	 f+z+6llxMCd19CbtLEdyYIPAfdhlmjwzceceRxImjMi/tSHB3NfKewEv+lcyMfqb+bQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=evXAcGai;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E68606A32E
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 09:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E68606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=evXAcGai
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso896445137.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 01:48:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793699283; cv=none;
        d=google.com; s=arc-20260327;
        b=Wv1RNmAlMFbVv5pnyXk6OuH5EAc89Kh9aKXU0M+nsXU6pEdJtVQsEo1yi5aQtXD7bH
         YsqXwqy9QjrhY6doI5V5ifiCtWB8X6hV4qonczW8N0ebgleH2ByHgxZwfFeQkELXkixi
         u5FJbob4UgiMm0MNeijAI8asiHZsLcmUmNPmqhvrN4EKw78Vkgz3cSmkybLX3y/eaKqH
         xzvBEhbw9XfMT52pN+NLc9UVqGyziYHeL8BOP02/0z9trrsksm/G4pHjgoZH/jucOuvM
         VS1qXbMcAxcfW7s53Jp4S6os+YUM43PL8X8OuWjmC4RKoFXuy3b3xoycMiq+Mavn3Jpq
         SIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=/FnOj7byRxiH3eT2nfwnnsumiSMo4zM9/UtpK8HuJcI=;
        fh=DhfBfEoPGZz1G4mQhLGiPT79PHX2ZfM6D/O9vhkN0Pw=;
        b=LIWnbZKe/j2QGC50DC+z6nvpNs8JJ8lpetU0PcO9g0ZBBncBL7ze854kytiy9INO9Y
         Z5Wzsn6McYv+TB5V0DwVETI7fQp/UKNPLKbOeH+kn8zYT4KbO60NMdcatflRUDlmtbdI
         49g0EFagHoFtD+/2SMBpu8vuzzgyZIn+t/Fa4Mi4usWE5/sFBRMP4roT2h8cyPiiwDvD
         hOuwJzsOBIiEFA/NTpB69CrJZycWY/8QgWskTqk/volTLnzvZeoxTKLpXHLMbHVjOyEa
         Iq8W+6OpegQP53bjjrdF1XnIsEDupFlRMKb7FJjBbpQ0/L6IcBX6XDNzqZxI8VWaUMZd
         RVEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793699283; x=1794304083; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/FnOj7byRxiH3eT2nfwnnsumiSMo4zM9/UtpK8HuJcI=;
        b=evXAcGai3ubt5u/hjjEojKrpQgFjpi96S+GiC6SW92CMEjw64KBlbVLO0fUhYiaoiH
         XbZG2FQXJTqFU8rHtqEyIkMmSG+XPTSdsmd1MU8t7xN+Nxvy5+FhRBIkFUMpY4Xq4T5a
         zdoCuqiudiA3cv4hy7bk/lWhVG2bkKMT8UHwCd4xZqPXBS1XuzlHOIj5reM/Q04kZl9K
         M4zDgb318f0rKgUUAIoaTMCawcrgN9EKfvuZD+sSafZLc+rP173N4swDH/bUMxarF/9X
         9GZwZCcAoGADXn5b55RHb31L+lW+ET2otQ6ETPt3B3kniCjAqVEAak87wKjmQ/sUBfGE
         sDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699283; x=1794304083;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/FnOj7byRxiH3eT2nfwnnsumiSMo4zM9/UtpK8HuJcI=;
        b=QWA2f5asNmqXuk5kbER/XkfV2OcurpJupkjMmL4beFsOz1loPgjs9tvMgkAHgV05kI
         USwJjsxD/udA6aiXp3DxSeDoHlJoFgjYgiYS/lB3Y8zxiYgdHCZlqnQe1NB9wKeYlhvz
         cUtK5gbQ1R/5GjeF7sdlFyVEJ/L9V7MJAkKT3YCWMQFVFS+BbMspZKOJPTMGpH+j658M
         LdT2mtTEuRSohn1ew0/15vQXem5ybEnHBhSbs1aVDDFaOhAv5fs4p0umzZy/3KG7zJCH
         rikAc/DXDFG301Piwrq5NrsioF2d4dKAv/d2UHBtsPZ8dSL1JSt5Xfi/ij2ENItZ26mn
         e5aw==
X-Forwarded-Encrypted: i=1; AKwUvBz4dtr8f1HXziHjMHcETv01Cr3MXDRSNj0fGh7Xzn8O46GxYZ3jXjgU80SBDTWfxXS8UzU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Te55GCs3HPlyL4T4AXDBPCbIdXqoWdryIJd0nGOumLXlwAPWo
	seAhCQOzyznYW0I8tGUmZMVY/67O4IowJsWpCOayPypMQam8cLvlEmcupB9ptQp0q/ApyuwojwU
	pZSgOj03QRYLFDEQ9/6VwHmOwNi3xC2s=
X-Gm-Gg: AYBFou0aCNHtmPzuzzOchQR3F37d0Rdq3zlQJjgv2Xj9P6gp8YlnuxyIdxqwknBVEtp
	2dm9C8wOOg/AssjBWLayd6ZrLoFxS3adiCg7r4+7Sb5MaOoRtJ2oaZ/0jhygleB/956KXJmd6Ki
	6ohFTf5laA/z63BuAYii6vKk/m7kyX3H6jDAWJgdiJb2SLdM4vgCJ62+IapGsqYgaKIvrmq27eC
	M2pCfU9fL/Nbn+2RLpyNc6dG/080S93sR8PvyFir5gql69w0Epz0XAbnyfqdEQfXP9I0sb+1+Gc
	8i0OR7jpknGSDE/sou5PpG3akXOXpcsiDv216dWR4ELExyauFTe0wgdv0g3RW/tXiOS4YkJsdus
	iyy2LJImnW5i3sbk+vE3PJFsApcpwhpFxwRoO4g8QWh3rceYUvx3EHYtlX+aDW9U1+hRSZRIFZr
	cV7+bPeNrFXVBb/m0KPW4t4vI2rjs5
X-Received: by 2002:a05:6102:4457:b0:7cc:32da:56e with SMTP id
 ada2fe7eead31-7d0725b9fb5mr3290887137.19.1793699283026; Tue, 03 Nov 2026
 01:48:03 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 03:48:01 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 03:48:01 -0600
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20261103084930.15532-1-okhuomonajayi54@gmail.com>
References: <20261031104526.46711-1-okhuomonajayi54@gmail.com> <20261103084930.15532-1-okhuomonajayi54@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 3 Nov 2026 03:48:01 -0600
X-Gm-Features: AclHuK-p-LuWflreX3EmZsu_xgvoEZlzy1BV0-TFMywguHsayfzY4EBrdpZUgDs
Message-ID: <CAOLa=ZTAEVcKj-Y5QCGsAFAMUSh665E1fmQrEnuuufTLLbn3Wg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 0/2] notes-utils: stop using the_repository
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com, ps@pks.im
Content-Type: multipart/mixed; boundary="000000000000996fb3065f5c28a7"

--000000000000996fb3065f5c28a7
Content-Type: text/plain; charset="UTF-8"

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> This series removes the_repository from notes-utils.c.
>
> Changes since v1:
> - Add patch 2, which passes a repository to
>   init_copy_notes_for_rewrite() and drops USE_THE_REPOSITORY_VARIABLE
>   from notes-utils.c, as Patrick suggested. v1 stopped one step short
>   of that.
>
> The callers in builtin/am.c and builtin/notes.c pass the_repository,
> as those files still use it everywhere. copy() in builtin/notes.c
> does receive a repo that could be passed down instead, if that is
> preferred.
>
> Thanks, Patrick, for the review.
>

Overall the patches look good to me.

[snip]

--000000000000996fb3065f5c28a7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d82833f9c75ed47_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ycHJkQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMlpkQy85VkhMOSt3aExYT3c0bXBWdmM5OVo0bnlZWgo5aHJqOGtUTTMy
K3hJYWVWYWo3VndnYUNTbEpWZEFMTi8zQTlaSWpxS2hETVdhVERBY1g1RDdYcGZ4Wm9LN3lUClRT
SG83MWdicnprbUpRU1RyWVV0cXE1aGVrR2Q0RUUwSjNlcDR5YWNyS3FMWnhJWmJWU2ljTkFPMDRX
MHlWQi8KNi9SZUxmSnhXT1hIUjZ4VkphQjhTakFCOWVHM0hqeTBTN1FzZ1JtWmo0Q29obVdGeWVZ
Kzh6VHl0ZUpobzJkRApybGhiMktHNG5NT2xNUk9PUDJISktaMGJxci9LbjVwS1N4OWdSYzJmcUx2
dlRDcGZSYW5qKzkzV2k3TXVnMXQ2CmlsY1VvbDRmQmtONXBaOXNpNkdNendpWVo0VjR1RzdyRnMy
TnBCa2JBR2dVZEw2MU1xTVZEai9WWVNHQlE0bU0KTlZvdHJUNW8vd1d4S0kwRUdYLzJyNVM4bUt3
dWNjSlhEQlpiRU42UHd6N1VmYU5Bb0lqbExtYW5acEpiYkNEcgpNZmhxb2lob0F5RW8vTnQ2NnBp
b3gwc0pvSEJ5azUzbWcraGNMdDA3WUxQTllGYkFqYWhnekhPa2hCbEw3Slo1CndpWTA4WTYwUXh0
QkgwQ2FqSnpVQk1aak85STEzZVdFSVZDSzVTST0KPStVc1QKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000996fb3065f5c28a7--
