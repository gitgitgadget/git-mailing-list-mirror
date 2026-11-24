Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795534093;
	b=M0GcNGl9TjtVplS/JU13V42Zq8WvFsmfR1jN4Vn5ShcudXMgdp1AXQthT5x4X8a7iO3u
	 wSsq6NMkOxzbbWPDaKg7x0I6q/V1L/7Jj5RufAm8p4oTl3s/OVCqD07kqwkWYHCbX6bDK
	 JnuR6Mm2TC2vqoZ+aUgDffxVq+mZ8xH8lzErnU+15j9W+T3UIApD0dKMPwf9/L7FGWy+i
	 5f4dw6h/ZsGhUR+vSIVqyPSvmhR2IlAt0rCmh1ZeQu3aAu/VXGea+O55NtHRDzhnAZcxj
	 Jrkc0j2gfDUhYiP0y+ZJyvrZfnwTnD2/LyCbER2StDoeYtU8AOTJDH9bHuTAIO3zrhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kL/vXU8imPMrYQ8HyvVqZA9nHaULB+QxwtmW7IiunUQ=;
	b=Xr+BSU584NZ1cnfcZXGvo27LZ2ukVLgRQ2ASqmnBTquBGE45dBBoatmyMw7F+r2WMizc
	 q1PYolTCTmuQisz2SRSX7cR/d/Knpi/9LraffxXG3r7Epocy1pqGamrj6282qgi2keo9Z
	 xn71kh6wdgTAL+ccIDoxfauwLxeCBpX4RrVDqK6x9XhucifoWfooUonmat0p/M6ejNREF
	 aZjua4ZG4QUZZlp6nq9EwSppvHoqgy5x2jrfqMrjg11jMazhrOuenoMnEe086aMc9ggak
	 MjradJ8sAsGR6EYgTA9mhOf+ZSMuFCo7bbJZV3royExZtTgrzLHhYzd2FUdO0MJcdnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bS0JtgyG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61030606A335
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 15:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61030606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bS0JtgyG
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a3c08d6928so6674744c88.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 07:28:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795534092; cv=none;
        d=google.com; s=arc-20260327;
        b=iH0blDFE+QKByZKOUffAxOuwd58TYazzaPkFSlLg7IaVewQRvasle3d8ahbFnwRrff
         kTsMI/YVDya1DivcX4QdiJ7eUXlvBQHVv9YIKlcS2IJ9Qco3v4eVWZOWkUyaeVobjJ0u
         YYL9SwONjWbQmEDhtQ2f0STLypQNRC2V5WbpvkbNv3IU5yFKvoRqeTz/pIA8VJGNnKSy
         Fr7ZsLx2Uxl0Ew7jbYwrNoPo3ppdd5/QnoQBbjzxsAELNVmXn6H7oSqxktm+0m6ZSi34
         U3twAREPkaa9BGxv/IEyWCezeFQ/vrwgyxAbcTHjEy1zKcOjFbJPB8j1ZnHrW447vMVb
         vvug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kL/vXU8imPMrYQ8HyvVqZA9nHaULB+QxwtmW7IiunUQ=;
        fh=hBHoqjeL6C3fVBOBMAWd6TM4REcZHuh9L8s4jOIJ5Ng=;
        b=V3myPs315PnaP+5mjvHT6fRlelwEwcOZ1pppqC01msR0W3G+73Xm3niSUttYz8TDXa
         TP3+OnWfZo2pELSRxlJJUDEkAHsvJeo6BtA2D9pJqrR+IWnYFaCWIvDefECsCst0poUb
         RD7tZh3tasKCYb9j5W+QC/+QjHBtmQYaODUVGNcCxmFRkX/5jI/BW/xlHWRPd4qikpkU
         z6ZQamI0RyLlekKh2IZIW8JtKUBxPS0YTWVv1za9xGt/riUqldIK7Rj99NStcxCBqkEc
         CD4n5h9Zn5v43Ptv3JTj8PI6ooF9qUzXQjfNznnlWn/Kf+sv81L/34HRU8xVx2LNk8hc
         b/WA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795534092; x=1796138892; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kL/vXU8imPMrYQ8HyvVqZA9nHaULB+QxwtmW7IiunUQ=;
        b=bS0JtgyGolYE5DOYN2lAKQn7erHMAdfProT8iIfo+sa4nTVQQkmMB14op/BCiTTaSP
         ms7UX29l3ezD0XP7hqOW8bBbIg9fLePGrvWGfXrbtxZ1T/7drh0bwMjwDKwTbSHjgnWq
         QK+bV7F5YYN4fCzSY8uy/ouNSBFrqire3JtB5OvErVLkZmqR+O58gqKfK8DIbxgMMDCZ
         SQOKZ9cxoOiLGFed4uwEZ+yOlhwPU8AuCmWnPtlUGQY3eF+gJWtBxgllIHdQ/GnuRbdu
         wNpMbpQpq7DXfTlpuATxDLI/cTfbhQqq8MksDBOtWBD0Kcg9ILG3+mj7OtSbMwUKP0/Q
         MbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795534092; x=1796138892;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kL/vXU8imPMrYQ8HyvVqZA9nHaULB+QxwtmW7IiunUQ=;
        b=PL0mgJESsqOYy4Reuc7MhGZ3uphNqAfwdNgu1LtjVIOelZjvFaAt+dTXBV+Ub3obUs
         WfQ3FjqtfCY1/jNmHr/PAAGdHPsBQQGVpHOHF4Ahbx3F83CL8qy/UlZ2h1CEhNuIN+C3
         qhXcvfIXDpu1WRlFP3J+mWqWNAKx5x1ycVjZ3m3PzjdVwVXsFmp3jroHguedmLtuOzAH
         pQUTxUmFRUS4+lMKkGeO1Jc43bF2XUHMGXEUN9AbhJya/084eQw+LzTVhb6rIXAHhxaR
         WQSVbHlEZDvHV/GjQOUTgUgwcdw9MFK7+/6q7kawX3jgB10ahs6XhXjX+oK/ZblNzain
         G3gw==
X-Forwarded-Encrypted: i=1; AL+hErH2DE2DkowP1VOsmg7xU2cbN5E/5gm5xw5V5W6bfmQ+jZumPlA1XKj7NGMDxUaneiwxIGo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Rzp+iiRsP6b00rOFJtmUdskKyKmTFfm1K46S07WkxDaYLgZ8E
	MgZihwrrq6GPCw5Ac75JyJW1DnTvknxZHNGFkj9Y/7EKVSY1Rl6HrDcUaQwy/4OZNYmd2DWkO0O
	SY1UGhFSlR7pXSthBEzC7fG/wydQB0Ps=
X-Gm-Gg: AZFdTZdKw+BumORX6nwzkdj2Z9GcdxdYGnp2D9yR1hOZDYMJLZLFNJpur29zqDwf3yZ
	GS1z72SBo0SkVv/NVWQPuxnPsJC6HxqiEOFm2dsZfBFtyr2wkhs8X5s43qV7P6kCvxNjDooCEfL
	gpwWCiPSFCzI/kITu7EaHw0qmG2a+doUcT2MLmAxSHEXEo3gyRC/gYhmzxuM+KukAHXQBUFxBtp
	vdDFPtXHc8iOFg9exzyEcPxZCF5pUdEcZYwsTqpoqFGAMjYpoG6CtYWBRZce5wuTSIMdTpeJ4Uq
	RYDDzbMSg5X5BGaIRvSYTI/Ta/WyicK09negRUc1ZMrUam7dJ+Bvi6Z+5HKzOBFM3oSyQB2njpq
	DgnOXpcENRHq9iwmHpgHdHafgBd38hRuib86Nmw4pUh8zGQClfrPedsezHML7Cxk3VVaL/pJQ+P
	i5eYSkemirEKQ2Lif2Fc19eEosSq5WimBfkIfPFd4qoqZ3FxPwZaV+J+P17Lx8gpZzmL0xdIIBU
	9bLaXhb/SppRIH2XC0gq2jpnnLQFrQ=
X-Received: by 2002:a05:7023:a5b:20b0:191:a5b2:ef4a with SMTP id
 a92af1059eb24-1b5568b9f5dmr13948194c88.28.1795534092278; Tue, 24 Nov 2026
 07:28:12 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqq1p8zw49g.fsf@gitster.g> <20261105203344.48513-1-okhuomonajayi54@gmail.com>
 <20261105203344.48513-6-okhuomonajayi54@gmail.com> <avGP6txIm0tK377H@pks.im> <CAFpMFfBA-O+BqXzCo3sG28hh63G-N4HpSr0zv7tfUhBAN_57+w@mail.gmail.com>
In-Reply-To: <CAFpMFfBA-O+BqXzCo3sG28hh63G-N4HpSr0zv7tfUhBAN_57+w@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 24 Nov 2026 16:28:00 +0100
X-Gm-Features: Aa3M54rN8GEZ7LFaVKAjm0i4QYUvKf5gtvgg3NxuGEpLQRU8GVOQ6O9TTHiyz1k
Message-ID: <CAP8UFD0b612_d6SEVerqs0GzSTOQzx9RaSvVDxAYORMKRWbQrw@mail.gmail.com>
Subject: Re: [Outreachy PATCH 5/6] notes: pass the repository to the
 combine_notes callbacks
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, usmanakinyemi202@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com, gitster@pobox.com, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:12=E2=80=AFAM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> Patrick Steinhardt <ps@pks.im> writes:
>
> > Hmm. I was hoping that at the end of this series we'd also get rid of
> > `USE_THE_REPOSITORY_VARIABLE` in "notes.c". Any reason why you decided
> > to not go all the way?
>
> I limited the series to code that already has a notes tree. The
> rest needs more than that, the display notes code keeps its state
> in globals, and log, format-patch, diff-tree and format-rev are
> given a repository but do not pass it on. format_note() falls
> back to the global default_notes_tree, where I wasn't sure which
> direction to take, and expand_loose_notes_ref() only takes a
> strbuf. The hash-size helpers are simpler, I just left them on
> the global.

I understand that this series was started after discussing a previous
patch focused on "notes-utils.[c,h]", but it's a bit strange that the
changes it makes in "notes.c" are limited in some ways, while
USE_THE_REPOSITORY_VARIABLE is removed from "notes-utils.[c,h]" in
patch 6/6.

For example, the hash-size helpers you left on the global are reached
from code in "notes-utils.c", like create_notes_commit() through
write_notes_tree().

I think it might be more coherent and easier to move forward if this
series was limited to its first 5 patches and if the cover letter said
right away that it's only a preparatory series. It does a big part of
the work in "notes.[c,h]" and its callers (and does it quite well),
but it doesn't go all the way in the notes subsystem. The cover letter
could also list what is left to do in "notes.c", "notes-utils.[c,h]"
and "notes-merge.[c,h]" and why, and then say that it can be addressed
by future series.

So I would encourage you to send a v2 taking into account the changes
suggested by the reviewers but limited to the first 5 patches.

Thanks.
