Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795121939;
	b=L99TLyLMaYvctavKUPhQwEMLl8Vm0DsxIlBx2WUobjqwctS9wFj1UNI62Ux1QKpoBKVs
	 hGnAjuSDphZj5b6jIIm+XJTNLxnQKeAUqratTwNKn7utpYLz+Qw9swZhLfPLuHvPP6kIC
	 li0It2L7+kEKIl+NIzSuY2mCEqk0KsHNqukgI4PsviBOz5Ygsf71ThZaUSlfq7/duiQWf
	 kAl/kmyl2HbFV785I4wTY2meRqg7aQ3f9evhR7sN7f8VZTOvW89uy0+Sy3hjHc9z4vAlh
	 bozEHHaqTllegPsFYorI4C6/f5Z0dRAtfCRNfPMm9TxR6FdLdmtHX9zjfXmBZ56Heww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=lGasD3JqHn7sHvzzaQgIVA4rjKdZhgkvUsARzRA2skM=;
	b=NLTpeVXWSoU6FdRv2aj60p25De+0D2Tm8Ro3O4oP+1tinZm/61KTpISXTcQrBu8l0dp5
	 peI/ULhL0DTDP9reuhrUr/i5l0n7zY2q5tjymXRGv11stx7PXXg3/5E1Xo3USfRx1VIf/
	 DfO7wt0PY6MCT94DQFAahoiBZweFjeTPWigsrk/JlLz/VEhrfQJTQM9T+OdLTXGX8dGSF
	 GNAIsINjEKCUn3/eo0QmS08UaDEgWxc2077EQ3NdZgMiSdzEedZO05o8mXm+g2CKj9MLc
	 oNBu5WQIW77mD3i1ke+x1fdPJRziH7OcJ/Enj3lGGS6iDJt0+/QBP3YJhRHyzghp2Sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FhpUMKeV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.47
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99A606A903
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 20:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A99A606A903
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FhpUMKeV
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-71ad2c6491fso810824eaf.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 12:58:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795121938; cv=none;
        d=google.com; s=arc-20260327;
        b=cEaeRj6c6ru9IUHUSBEd+OyN56lOjCzDWPEO+lFBnZlhRMUxGhIfbWDb29naxl47Np
         cDsxtVmRpq3VtdufQirGa0usdKujPTZ6SJsb+QohFispAjNW/LRJE+GnodX6/4hJh/LS
         MXKJUmYE32v+LMC6rzM7NpNXr/pC886J7X/PPTQ+x18+9dzHhXwQ6QWjX36UhAyr7GgC
         EATd5R+8wV26jsBU3hz5+pKmx+DCrSbVG4gJyQxJBDtMHi0lF7pz4cAtYplxUel85JdX
         6UsrlY13MWHw4u2LQX5hUOFnpRkdfduqVNzHyTK4B6/ijksR8Sr7VnKW26/QE5faH8C0
         lQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lGasD3JqHn7sHvzzaQgIVA4rjKdZhgkvUsARzRA2skM=;
        fh=azt8TgWTl01NptQZMw9NPhZWceF2SXJbJqFTBR6uZLs=;
        b=ZsI26ZPxDB8H2wBGX71bBqonS0QX30fxNI8+FaqZqc2RSKCFsOyFdL3V1LdI0AJcQD
         C4C5MRanJJ24iB66oyCKRnFagXx/D0thoh71jzNeVdV4ik0MgoMx0PgMaZKMvKZrvjPy
         7DupMObGiBfxcaQTgjdw1DDMxlSiKgF5kWSm+BFZ3g/muDrXUUe61Qvd/gtgRNasWtTF
         r22fH+BSeoSmKvqiGKqi3tTeCvOAw4I/QMuKeBjk6N7W8twtr3DdQpPjGc4nmvxZ7Pe0
         sLDQju1CMZbwhJp9ebA8bY07M2xbXLxqw1dR4lcR9MIBTSxCZg+H0IrWWcqc1W4JbnCd
         JA5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795121938; x=1795726738; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGasD3JqHn7sHvzzaQgIVA4rjKdZhgkvUsARzRA2skM=;
        b=FhpUMKeVTRI0zFUegDOjQd8ZIx7S/8wx9eiyA49IXnDr52nEDZ09tT+1j5d67USD2Y
         SruXvcQw8X4pzObVnNyjW3JjVaIkDv4RaBUtpnDAEWflaYmTW476VI2sDxPTGUIOiSRB
         MRObAo91kf7426soCJQAWtQIxqkoM0e4lSi+puSk3rVxrXOF/FUFafxn4c6xDdb0YVcu
         L/JZcY/ERgiZXYDUwi1hg2OofqD3DNwZ4q0FnnyVPxDuiZfDPnjN0WyCILrGKsksu302
         Vx9YciPE92nff2ekz2r+rRPIWO08hZCF9mRh5RpkiWr5w4bQWoGoN+IlvVBoXc0MzgHl
         6xcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795121938; x=1795726738;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lGasD3JqHn7sHvzzaQgIVA4rjKdZhgkvUsARzRA2skM=;
        b=nURmFMIIocGacBp11BqnllRW14zZ5vYLVT9Kb/fYPj3oI26VelrQFyCb3DSwByJNNa
         4t3sh3IGIFybuuGZXRhZd+TyTacx44IiAA7qe6SYyX0ZNW1CBFIFoBsVF4U0TLGzpC2d
         r7uKOcQ5eNUhjl6DqmIKHo6NZ6hgk+hMZ9JbKE7kCEWhWb/+lDaCh4xP727YkvHGbjKV
         P4Bs9t+EzHxidmjO4yaKNoyDt8j1B6IPWbDJvGVbDtccBVo4sPeI8DPv/1rqWFHP2s2z
         5ThDSgC2QYh3tjMi993s3l5fHj6EFjoPZn3cH06e4BMhCfvjBN++/88byFqJnI7psFkB
         Fl+g==
X-Gm-Message-State: APuU4Z8MlVghYHMD2CzkzroLAP3+/F7GaJ3XL+RyH7jBaLcgBP7Q6FqF
	qtOB+daL6cdXFydcKuJH988v6GsSYZo7kgYbM0InMOQOgR5UDkWxn7RC+lYil3BoG4P3bNFzMJ3
	P3EqZz08Y5BM85aYXmTukQS74ssxf3m7op5XD
X-Gm-Gg: AYBFou1tnGYLgL/s7jHcN3zVn1RauccBkT8f5igHiiFgVgINmjCZrVNyQh7ZyfB6bmv
	21D9CH6YBb5eGy9yiUU8aD7yvJGTapB8LMAiz8+NRcPM69KNSSI3BhEP88uoxgYBktcra1PUdT5
	OuYCfmCTZqtURcZ+iqXVePXVqpsgAU+Fk52c1hi8PnhnpoJtGpUK5qjxlncXGVrfsaM2po1CF9F
	qqh0CSplL6DK5pyCZypCAYKyLuc+D44u2Y6MxPwb6UvcdmcxDbkgayYg+09F3W8WuSJ8/HwNHi8
	D89+xUHdYi4zv6KAn8dyxItya8sfnsjeF6SAuvp7PuqioTynAUcJaRZSguNtMOBySwUqJleZlYJ
	did1fpgy5xDxLBBr0HCNhs0WRI4gEYTvJQF4=
X-Received: by 2002:a05:6820:1606:b0:716:f261:d8c0 with SMTP id
 006d021491bc7-71b39294984mr739227eaf.2.1795121937727; Thu, 19 Nov 2026
 12:58:57 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
 <20261118-master-v2-1-3f2aaec15d31@gouders.net> <CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com>
 <ghse0x9sgm.fsf@gouders.net>
In-Reply-To: <ghse0x9sgm.fsf@gouders.net>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Thu, 19 Nov 2026 20:58:45 +0000
X-Gm-Features: Aa3M54oIcfToQN0YNJpbAVoQ5FvWlfy9d_WVnS8kD9ZfgjjFxnh16ix-0GT9cg8
Message-ID: <CAHWeT-ZNoDWqTMfCdQg3PZ2bbLD9PTVqeFMms_1dFj8dbReSCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Dirk Gouders wrote:
>
> On Thu, Nov 19 2026, Andy Koppe wrote:
>
> > Dirk Gouders wrote:
> >> +/* Same as above, but for a NUL-terminated string "s". */
> >> +size_t display_mode_esc_sequence_len(const char *s)
> >> +{
> >> +       return display_mode_esc_sequence_len_counted(s, strlen(s));
> >> +}
> >
> > This is a performance regression compared to the original function.
> > Calls that previously returned immediately because *s != '\033', or
> > after a few bytes of scanning, now scan the entire string with strlen.
> > It turns scanning a whole string for SGRs with repeated calls to the
> > function from linear to quadratic.
> >
> > Therefore I think that if the original implementation isn't going to be
> > kept, it would be better not to provide the wrapper, and thereby make
> > callers think about what they want to pass as the length.
> >
> > Uses on strbufs can of course compute it with `sb.buf + sb.len - s`,
> > but they don't actually need this safety net, because strbufs are
> > guaranteed to be NUL-terminated and the function stops at NULs.
> > And the length calculation itself adds a source of errors.
>
> There is only one user in pretty.c that uses the wrapper.
> I can change it to use the _counted version and we could then drop the
> wrapper.  Junio's v1 already included such a change and I could steal it
> from there.
>
> Would that be OK?

No objection from me. I would change the make_line_colors_self_contained()
function I'm proposing in [1] to the _counted variant anyway if the original
display_mode_esc_sequence_len() is going away, to avoid the performance issue
with the wrapper.

[1] https://lore.kernel.org/git/e9f88b533dfbd10528c9151e2e87207419d0253d.1794905511.git.andy.koppe@gmail.com
