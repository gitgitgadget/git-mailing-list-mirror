Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC4732C942
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770931796; cv=pass; b=ZEAUf/zW41UKkg+w6Tbgi0sA9tQczwPvvc8GzDmHlOIFqCzKUC5Sazw1vtMcOFFDpwV/mXnK8BBl+6evrIo1ThriqUm4jW1mJVT4tnJsNNyVO9czjdoGxqgadhGpz0MgWkjzp7kNIsczsMl16YxKwu7dP7BQLojcdwhRWtMzvHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770931796; c=relaxed/simple;
	bh=wBkn9mFmgxWZ3OP1ZJ3s1LDzbViDHOz6+AHedsl3k/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjGTavMT23lxm9yF39tejDDlHG8b6ksey0vIrssP/iEe0u1uXM/ynbsgNrRmDSXnVw5uBEjSy7kV2IRJYlh/JEKARTPW5PVHRJrg9DINXVLrqMjLo9PUaVFT+jzpkWWbe8tAJNhjn5xGOE5ySnZwQXtfJXHBfZ2avQC0b5uzmCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3WAiSQZ; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3WAiSQZ"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64ad8435f46so288325d50.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2026 13:29:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770931795; cv=none;
        d=google.com; s=arc-20240605;
        b=Fw4V1l6PPA4Ao6mwny+vI9xV0ep435tAy2WfmRaaaI0DN70h2DtH09YoAc0EbQjHQw
         Q5kxM1zR0Cfgytj9u/XmzGVKf1981lQb8pruQUDhmynkVH17Da8MOhPyciygzu/XzlfC
         FsBCOY/HO9ZfGi2js8K/sjMSVe80IQ38fp1xXeXM4XITRDNsOxqf/VY8hDiVHTXFiVfG
         nQlZD/BVMtf2uuaxpzhOvJaqMUAG1q0Trz8R5JpezVJ46gODo/lYIK9XTxmBkYG19eND
         zQ3YUhdomCQTr9spG3kr/xde5x3u4xUn3AiraV9PYDmLoYL4Lh1jNWCTiGmQpmBtXbwc
         1fJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mOhrzESJEsgtDGZql5VwJlI1OSvj17pBAXAxTTwJhnY=;
        fh=RJRPxWyrU64VNsuotaC6zvtv6r3085k5B0lFV7F/MWM=;
        b=IlPuXZLqdSaHtlMCYasJFGyt3YBFqxnBO+iMy4pIJlIkFMF8zQPh0y515UrGtTRjPI
         icmBXel3YAERbjmz/cAJU+wHU+sRPcMTK9j6PxebN0SkL/r4kkvjSVv6W9wJ7c0X8PcS
         zd9D+kuQY7gcfAIhj1AB7S34LvK0CQ/fPCMgBxQa19INWyWk7cLgIZavAsKKgFdLwbes
         KxxIX7Hu7h8w0fsb/nhLtJ8NgycJJAGSuwPy+q1mqVGynYRq2g/rhfu0MiIt8DXRDKc/
         tV8isJcJ3nPcqlwVVUNcSaa1TfDYnCUuDOqZk4KpjgDaoJyp7GAysjKMx7HQaVmcPwt+
         sL/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770931794; x=1771536594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mOhrzESJEsgtDGZql5VwJlI1OSvj17pBAXAxTTwJhnY=;
        b=J3WAiSQZzkFPI8rNJLlrzN4tZrtZXTCzBDwnfvlBIzlgZ18tm4bCjbMaRqNxTZ59wv
         /DiNWiSmtN4Pwwqj6ZblEoXJe1sBDD29y6bh2b6X7TcF1fdRCTeJNy6ngbkIgPlZDFXZ
         +gedaRdhAwCNG50DPjXmtTWve/qubqO1FGTSgJ6dRkE/oTD1RoerG+FV1KCeRA20opM5
         5V9R1wTp6svlYtlFiqIKwowEnT2PnrjVKhUoD4FB2Cr1I/pQtrBvzJLQR0jB/SMrJk/d
         INyBbK16dCC4ozaFh0o7p9bkjkiMT0BJc+ANvJzh36wiHyli6nQ3xkFZQeClB1PN0RcC
         lN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770931795; x=1771536595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOhrzESJEsgtDGZql5VwJlI1OSvj17pBAXAxTTwJhnY=;
        b=ApP+znhDplJqHCgW3IE+KrdhjmYr1XIGe9dsano8dRXH48IzGpgOjdcsYbY7fO1i0Z
         bzPUwIY0hsxjVC8tZ5mQAxOJNLCecsH0al2xpKx14az7piVYKchcfRCB6pUfX8G360kx
         NFqyFBJgydGpUe1FvjZ1j5xinl3CoFCWbezsN2as4ISfFFD7RqFRaZCaD+Mqqrb34l0y
         ZNdNpRnFhGEaMKzKIjgHkhfSstkpO3FPwlYPSbxbwhRYXtqsCfAzbSIC14MrfhOuv8sw
         QLcAG8GkvoH0ehEmIw7p5NcvBu/3P25MU0Cu4jbcEKH7JZEIizx01Bsyib5hOyIcHV40
         es1A==
X-Gm-Message-State: AOJu0YzCN3i3t6UYKrIksobwI1o3oY3ggROCyu66v8JtuECkpZ8olQ6P
	qc3kmAi2JCWo0VlVwrOUrImS26WkphHu+byoYdYYIhICvJfhYhcoQgQlKDQJBFk51YrtRYD9lnU
	nB8jx45tIJH1AnI9PFrjIy9ovjx4lSok=
X-Gm-Gg: AZuq6aKTusSH9VgIbBly5JwAJeqQGP/vAX2P0SnkMR4HBOBBV4k1b53FLMxcK1nzSG8
	Ehw0qoVQPUe2k76Gps8gGqvyxk652xFQ7cI6s2RV86PbZP6KC9IN5x25+DhotiH7PcCpScGDB0q
	x5/CuqlpXJdM7diNoNKbMNqvzJHjG8xhDNwtHcV0rxyh0J0Ui2M6n3wBFm4iXg/Re80oDp67BEB
	QskNh5RuKja8l3z99NkiV2AfH9fPkRIdRlkVxDT81XjgWjrIx1goSrcQbDiaspF4Ya+a5ylIPlm
	VKWsIhClQnsqX+lj56xIo/l8elr45yxuu8ZAW+RD
X-Received: by 2002:a53:c703:0:b0:64a:db34:8509 with SMTP id
 956f58d0204a3-64c14d71e0bmr349249d50.66.1770931794584; Thu, 12 Feb 2026
 13:29:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212041017.91370-1-amishhhaaaa@gmail.com> <20260212041017.91370-3-amishhhaaaa@gmail.com>
 <xmqqh5rlohsm.fsf@gitster.g>
In-Reply-To: <xmqqh5rlohsm.fsf@gitster.g>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Fri, 13 Feb 2026 02:59:43 +0530
X-Gm-Features: AZwV_QhOZlPGizDtHsDU2ohCXKm_lOX8EpMu2ZUUGz8CKaXK9WWGpoULoyADvY4
Message-ID: <CAPvEtrenMBMFaMxcCR4VwoyMFU-_Z+bqq5nJaWv5eyn3HRutEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] help: ensure &keys_uniq follows sort -u
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Feb 2026 at 01:28, Junio C Hamano <gitster@pobox.com> wrote:
>
> Amisha Chhajed <amishhhaaaa@gmail.com> writes:
>
> > From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
> >
> > uniqueness operation of &keys_uniq depends on the sort operation executed
> > for &keys this might introduce regressions in future when the logic of
> > forming &keys_uniq from &keys is changed.
> >
> > add string_list_sort_u operation for &keys_uniq after the processing of
> > &keys so it follows the expected sort -u behaviour.
>
> I am not sure the above reasoning is sound.  With the original code,
> we
>
>  - prepare empty keys_uniq
>  - collect keys
>  - sort keys
>  - iterate over keys
>    - add either the whole "section[.subsection].key" or "section" to keys_uniq
>
> before we call remove_duplicates.  keys_uniq would have duplicates,
> but because keys is sorted upfront, wouldn't the contents of
> keys_uniq be collected in sorted order anyway?

No, there is a case where it would not be sorted(keys_uniq won't be sorted
even though keys is), more details on the case[0] and steps to reproduce[1].
[0] https://lore.kernel.org/git/CAPvEtrfEZXHxcDf=z60ODfUA8cS81rhF1y7KEZApEBby7aCa1A@mail.gmail.com/
[1] https://lore.kernel.org/git/20260212041017.91370-1-amishhhaaaa@gmail.com/T/#m64880c5cd0d36e35bc78692757cf206b13496aea
only reason it is not causing a problem now is because we do not have
this edge case appearing git documentation(from where the keys are built)
but if someday a case like this appears there then it would cause problems.

> This is not a performance critical part of the system, so it is OK
> as a future-proof measure to sort keys_uniq immediately before we
> start doing something that we _care_ about its sortedness (e.g.,
> presenting the final output to the user), even if keys_uniq is known
> to be already sorted with the current code.  Using sort_u here would
> allow us not to worry about how keys_uniq is constructed in that
> ugly loop.

Agreed, we do not need to sort it twice if we decouple CONFIG_HUMAN
from the rest of the switch case, that is a great way to go about it,
thank you!.
I will work on it.
