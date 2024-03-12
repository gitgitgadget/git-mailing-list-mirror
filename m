Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6AA1869
	for <git@vger.kernel.org>; Tue, 12 Mar 2024 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710209066; cv=none; b=SEv+taWGL13BM4qiY5vPlyeBncjz7EAvf5smJU4NazaXqD2oMQVOFf4f+SfuQgOwEdmPydCkgIbfEf2rVsrn0pLW728A7bfSwG0GryBc7giMNcSjVkQFK3p6d1/gw27YzDaPJ0cUJga8szA/G0FdKBoGk9N8+oJb9fs4jdVxXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710209066; c=relaxed/simple;
	bh=ijRpHg76rHvSrFIuGUQsbEn0Fme7EHIXM1bIL2B9+OM=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=ZxqBp1hlNjydXCdxzlnlNwUBLla1IlrSSZ3ERcy8yIKW4rW/Xfde2S/sOJBMgm0SXDiFXwyT9DIbLfS5zAl/6VGonJskzXqTk0BIYDlZsDkelvg5RY/WPpIkytxsS3lJegC+5dGbKQj2vYHiQbqBDAOoM87AGHAWxR+QBWqDA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCYIK35k; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCYIK35k"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3c23245ddfbso1396016b6e.2
        for <git@vger.kernel.org>; Mon, 11 Mar 2024 19:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710209064; x=1710813864; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o36gZfPpzZLfKWrWa5KcJnRugsXSxLrS+Ozulg54GMM=;
        b=HCYIK35kGj97o5AMulroqmEP/cqJHqYFI7sxFvhOzGg951QJAILe8kWVfmOpFS3+Lx
         n95lXe0vZe26PrhPafIccuwaf+7FZwok6XiCvsa0cG8vQllm7RsJAxImLrPeEnGb8yIp
         bythF5XzYDu/aoSA+4t4+3ilEFmjdZ0EGqLoycnP96WLzhH/nb2Z1ikCqmDi9C1LpfYX
         QEkyshioZopH6CE9wMQmWEFKnyucbuTHYtXK+45BP4A5rQzazX0qay+EXnKoyl7iCRMr
         CcWzMv6PhJw1rXEZ8J2LR3lIpRFISAXLQGuAKyxWmS5ALj9DIiYUc8aWv8ZC9ovxdeWH
         AMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710209064; x=1710813864;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o36gZfPpzZLfKWrWa5KcJnRugsXSxLrS+Ozulg54GMM=;
        b=t+k2WQccgEsE2MX5St+bNzyxHAHAczc/MtDOxrrVZ88dU7G4dXokbcOfRA2u0TzNMp
         P74NMpgK3JsfIpluJ569nKR4eJLD5yO0tfSOdsW39dvhEwSs/aVVStDtaCq8/kzLeyQd
         qPMq0SyAzKXH8zHcmlJqp3RuIFCPnmenyknjDeWs8yzls4+aGZHx2PdbinUTnhxXdYvD
         bbeuCI1O7I9P+yoWG4jWBvMQIpTKD+odrIunGU0K9xSjwf2fRkwu98L0iTv5ZZ1hGWua
         C7JVMtZw+TRUCf3c5dXxdUZaWkUiQmTpFeVozWpbRazKx+I9bBAEZ5PylLyPhHXHSGRN
         hkoA==
X-Gm-Message-State: AOJu0Yy1rhrvoplQ/URKc45FzDN6CWIltMKEK3a4+6MIn8d4JlWCtnbg
	MS9baNYaKi+QKLbGQKmf9e2PwA3VAj3znbTpQrp6Uymcz8uNpyK+SgnAFHHY
X-Google-Smtp-Source: AGHT+IF0QLJ9N5eijLlvN8DxjOEXWUWZpKqqZNa0xaxdmEY3eqlZvgXjiA6DV1xWxr1kwmr7/QgOQw==
X-Received: by 2002:a54:4884:0:b0:3c1:db9c:543b with SMTP id r4-20020a544884000000b003c1db9c543bmr6978777oic.16.1710209063532;
        Mon, 11 Mar 2024 19:04:23 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id t23-20020a0568080b3700b003c23faf3800sm895302oij.53.2024.03.11.19.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 19:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
In-Reply-To: <xmqqh6hcu2tg.fsf@gitster.g>
Cc: <git@vger.kernel.org>, <newren@gmail.com>, 
	<me@ttaylorr.com>, <phillip.wood123@gmail.com>, 
	"Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/7] sequencer: treat error reading HEAD as unborn branch
Message-ID: <17bbe214bab8dc40.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Tue, 12 Mar 2024 02:04:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, Mar 11, 2024 at 11:54=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>=20
>> It is not a good code hygiene to assume that a failure to read HEAD
>> always means we are on an unborn branch, even if that is the most
>> likely cause of the failure.  We may instead want to positively
>> determine that we are on an unborn state, by seeing if the HEAD is a
>> symbolic ref that points at a ref in refs/heads/* hierarchy, and
>> that ref does not exist.
>=20
> I suspect that you are almost there.
>=20
> +	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
> +		/*
> +		 * Treat an error reading HEAD as an unborn branch.
> +		 */
>=20
> After we see this error, if we make a call to resolve_ref_unsafe()
> with RESOLVE_REF_NO_RECURSE, the call should return the branch that
> we are on but is not yet born, and &oid will get the null_oid.  I am
> not sure if there is a way to combine the two calls into one, but
> because the failure case (i.e. doing anything on an unborn branch)
> is a rare case that happens only once before actually giving birth
> to a new branch, it probably is not worth spending extra brain
> cycles on it and just use a simple and stupid "when resolving fails,
> see if we are in a rare salvageable case with extra code" approach.

If I'm understanding you correctly, it sounds like you're hinting at
something like this:

	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, &head_oid, NULL)) {
		/*
		 * Check to see if this is an unborn branch
		 */
		if (resolve_ref_unsafe("HEAD", RESOLVE_REF_NO_RECURSE, &head_oid, NULL)
			&& is_null_oid(&head_oid)) {
			head_tree_oid =3D the_hash_algo->empty_tree;
		} else {
			return error(_("could not resolve HEAD commit"));
		}
	} else {
		...
	}

This does in fact seem to have the same effect as the original patch in
this case. If this is in line with what you are looking for, I can
include this in v4. The commit message would be adjusted slightly to be:

	sequencer: handle unborn branch with `--allow-empty`

	When using git-cherry-pick(1) with `--allow-empty` while on an
	unborn branch, an error is thrown. This is inconsistent with the
	same cherry-pick when `--allow-empty` is not specified.

	Detect unborn branches in `is_index_unchanged`. When on an unborn
	branch, use the `empty_tree` as the tree to compare against.

	...

Do these changes look good?

--=20
Thank you,
Brian Lyles
