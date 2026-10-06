Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EEA339364
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791317515; cv=pass; b=hMXJmHf4Anpm9t8ujHjUh2q1fIpxv4elwHoI8c7SELlsD/PDfaDsLjbQ/H71ntgsAf72Fg0CPgzMJwRw3jDv8TkZWu0vb/07N114vFsUhfOf0mk3V5TbQJwwbRmSxbOxhDnwkwEp1WytTDK3ka5xj06kBixqupP4aenrcxrfFvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791317515; c=relaxed/simple;
	bh=69TOlVqlfKWB8lm8daLywcJZS8ds4d2sdATGg+jZP5Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A3ja4gCTTVttPAopRmJfVDOB6V6odZhgJy2p3Mr7lWjyw6CZKlV6SbqLZlxF7MqVipx15axX61Sddp1x0a3OqZE33YD7PAK2Yp+qeBi5q1fxlLWVy30PfvIFr6bVwJX0vujxqxKANMhKEbk75Tby1NhQAFO2WYCWm7kEiIPTemg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsVBKzqp; arc=pass smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsVBKzqp"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5e23be41cf8so423959e0c.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2026 13:11:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791317513; cv=none;
        d=google.com; s=arc-20260327;
        b=jeE0LSdVc3Ft37eJ7wt5rzwH9p4vCt3+KoR3IEAikdhfgbneOwrX4rNyWN+5dxdqjI
         NgRQ2PpDVuQRKzECizkg1izfBICFyEj3uZnCv4IRIpjvJASpOR4Fg7YX/dlIwog6dxro
         Kk1fJ9wJk8LRpVQyfckPyp2uir5wmeFKe3c5vi7aFsg9HVFMetYHmB1zHDwtnuQfRzDs
         BVLcxbQ+fQVb16BCh5cp0Bb9pBAoZT4TNphgU3Q6fGejnytQTvcc0vtQpeLuw6eEK2r3
         b7Bhcp0gMzgJoKnUWSYzV/yGFAKHs2ImCmKteExY1JAefsSgwf5HVQHdQJ7Q+whkgTF9
         TY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=8oZj9qu26wrDtVz4uiZjhHyE+6Qa7LkZGUWC9W9aWi4=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=qMm2JX1ky7NMI7tRuYMXet0/X9Pyt5SBGvAXIUJU/IUMuascMKlkBoa06ET6KOjYMC
         BAzTFoZ7xN0dkGwC+gp2takjSMZ9jX2qLNIT+JLyW7v7Z1wu8UBbxtMAycA/4fGnPAMv
         LG1q7O0E84xyKI7vOSGYbeAg2Q89V9ov40AtFGoa7uGV5aW+JgAeFz3zwf2R65H+vKQ0
         28KZXMKGaHM/UMLU5SJpLLS91450P4P1+oNkvJ+HsMpYhPL6W8GIqiIiYN2WtsCqsqRm
         Y6zZ/qW3b1d3WXooc3CxKG6jLeX2JMzmxxkoqoUPus7jfTHZb5ZprYC1+0xiyy3EXlC9
         fJBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791317513; x=1791922313; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8oZj9qu26wrDtVz4uiZjhHyE+6Qa7LkZGUWC9W9aWi4=;
        b=RsVBKzqpgp8VdjRKJ2Kh/CmlsPIFvWoGtNDbbqxB2qrGGXArEcSho7SHK3CywyFvH8
         47PR7l3Qb5jNZ03cB+ZhkBEpOnzGCs+SnOtEDLP5oDQMEPpA9frzBMozTKrcTvQGscWk
         sIRfXEf01ck5FIdXe61XCqSWpnYnuEq0V/cEaYOIpwgV3z2vXn0fkBEpF0p50UgqNpFu
         +bX9PQxEMbqPdATVhlK4Jm95B81sN+MHOvc4PC0+A3D9JklawHtp866IsetF9p64EZGs
         in3jZY63CasWR0enJ4+/3lnP5zOZJ7Q3J+3mCBhzK/NTKmtZDUDcm1DoDQbYn62UPZCN
         IZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791317513; x=1791922313;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8oZj9qu26wrDtVz4uiZjhHyE+6Qa7LkZGUWC9W9aWi4=;
        b=gRHoJQ2tpJlQaHpLfqtKRX8SDVqM2pJ5eg3aOwirJ9JCTyKL+OWLW5m2Bp3FBo53Lt
         igiJcJJVWot7SdI2to7BGYxdy1NuNxz6X+aRd0B3o1nkCbwOY0Y3dyejrgbMitvFL0WG
         3Q/v+TSUCDVmAoOr4NkPCcGf6UAFroEUzVyFU615Z5qHVEOZFSShxV5ODYcU9YqTJhbF
         0zAN5+vKms/Wlcxx9m/OiNeXf2vJcHzW/SxsAaNYAfHFXili9vHqMvdnxtj6XoQlG1fD
         ftW8jJEo1FcXOU3Vvm/AaWL7NZL9PhKXCSQvOVQ+Uv8EFzQyvV1y6ZNRpZ8AhXXTcwrt
         f8OA==
X-Gm-Message-State: AFq9FYL60fphJZ0VeBF3MzZ9+HGoEF82rY8V+jBlDWDneMeiQtt9ADxk
	6Ogrv/R4+ANRrtSiv7j4+bKroFKdZqVuFdo/tOq5ZbKVxPJclubU7eWikQ0xw3zXIhX6lnZzUTk
	76fGZC7YaGB2T0lcHp0s4NQLE48LvaZkvAw==
X-Gm-Gg: AYBFou0LvR+yXrbAItkYl3mzjKtLWYhi1Lq3BCSuVnaCcdJ2+qYBuItq5Afk0vRwXTb
	3P7VY1CU8TGPdRR58GK96demrwlGHaF53eoEGSBJGp+RN8HJ5+OPHZCdPgUgzJrmCggI0keABQL
	lbO0ejqxh2nA9oKO4UYAnohxZRUblUEx7ETD3cNaOYoezuoAGOdP44R/Ztq2rIGnTBFaHsUDWyl
	aYaAsHg8LEWPbDn7YxbJGmSaGoL5WCx4nw65kqFe8nDGQVPHqUXRy2vx650IEffzfgTYvrauf1V
	krdvEgRADU5l/QzH3dd2fyodKlQjhviuv0Naj1BtREUQLsyzrItKZ7nCIAIu5yweuxvw9URn/Fm
	g8iZ/0OQjZgoION3dP9U9qI3xehmQ4/x0p5n6gk0tqGUAtQ==
X-Received: by 2002:a67:e701:0:b0:7ba:3572:2789 with SMTP id
 ada2fe7eead31-7c877fe763amr577785137.3.1791317512617; Tue, 06 Oct 2026
 13:11:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 13:11:50 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Oct 2026 13:11:50 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <asTnDMrTjUWHVSwR@pks.im>
References: <20261002-pks-odb-move-alternates-v1-0-8a63507b88c4@pks.im>
 <20261002-pks-odb-move-alternates-v1-2-8a63507b88c4@pks.im>
 <CAOLa=ZSNHWFw5Vj_5qg16ipp1QA0pDcV8h=hOA=ma4hy6F_LcQ@mail.gmail.com> <asTnDMrTjUWHVSwR@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 6 Oct 2026 13:11:50 -0700
X-Gm-Features: AclHuK_tsk_tXENEG3RQFqMTABzHKa2ibLodl-Hk4s3iA77fm9zWUq4CYaorqzU
Message-ID: <CAOLa=ZSbgtBStEWz_gnqDTUVp_GdFfu0qghq_rzzfqUPqb3Stg@mail.gmail.com>
Subject: Re: [PATCH 02/13] commit-graph: stop depending on `struct odb_source`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000057262065d319c32"

--000000000000057262065d319c32
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Oct 05, 2026 at 03:43:44PM -0400, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> [snip]
>
> Thanks for trimming! One more ask though: it's helpful to retain the
> diff header itself so that one knows which file this is that you are
> commenting on :)
>

Sure! Next time!

>> > @@ -28,7 +29,7 @@
>> >  #include "tree.h"
>> >  #include "chunk-format.h"
>> >
>> > -void git_test_write_commit_graph_or_die(struct odb_source *source)
>> > +void git_test_write_commit_graph_or_die(struct repository *repo)
>> >  {
>> >  	int flags = 0;
>> >  	if (!git_env_bool(GIT_TEST_COMMIT_GRAPH, 0))
>> > @@ -37,7 +38,7 @@ void git_test_write_commit_graph_or_die(struct odb_source *source)
>> >  	if (git_env_bool(GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS, 0))
>> >  		flags = COMMIT_GRAPH_WRITE_BLOOM_FILTERS;
>> >
>> > -	if (write_commit_graph_reachable(source, flags, NULL))
>> > +	if (write_commit_graph_reachable(repo, repo->objects->sources->path, flags, NULL))
>> >  		die("failed to write commit-graph under GIT_TEST_COMMIT_GRAPH");
>> >  }
>> >
>>
>> Shouldn't the caller of `git_test_write_commit_graph_or_die()` send in
>> (repo, path) and we forward that path, instead of using the path from
>> `repo->objects->sources->path`?
>
> I'd agree if this were a properly designed function. But it's basically
> just a hack for our test suite, so I was aiming for the easiest fix
> possible to make this work.
>
> Patrick

All good!

--000000000000057262065d319c32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 72ae839f6874d2a6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1yRlZnUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMXRxREFDTEozTnZRN2NPaEtYby9wK0w1c3lrSDRqMQpyM011ZEJZcnVV
TUlvK04zK2dydzhCMVhwbzdEcktTL05RSllEbGowYVBsME52eFNqK3g0bEJQMlhDTkw1UjJUCis5
YWJ3RHZHTEhjRW1mZnpoa082NHJKSHgzS0hMREcvT3BoaTVnWU1BdVg0SnRBa0h3U2dtNEJ1b2tI
ZXZXZnMKRkhIRTFrSmpDWE94dzdXMGtNU21yeElPK295d2VBczZZKzJpYjl5Z1QxZkd2WUtBL0pP
SHhPQmZ6RGF2WUtKVwp4SFNrcDlBZWVmdnpXdGs1L2FXSUpSTFJaQklLOTlSMm9VS2lHMEFvYXk3
ZHdZNVFmYTMwc0J0WHRta3E3U1FhCjM1dGNqdVl0UmlFM1BMUzIyVFZGRmZ1R3V2TlpjY2tmK0x5
NXNEdW9jN1IvV3lMV1J0MzFjaEE3ZElEcEhjZVcKRVh0aENwOStOU1JpMlZJSytyV24vU08rNFIr
QjY1YkdLZzV4bGhkYXd4MHEyMFMvNkpYYkZDcXdUTjNpdlUxNQp4YndCNkRMK0ZqdWtoM1NaMkR2
ZkVFYVI5OXIxTmp0Zjd0WTV4d2JneWcvSm9XcWU2dzhLbFNHU0ZBOWZlSDVmCkUwa3dUU2ltaGph
RnY0enRSSTM0T1hiMkg1Z0xXcjUwRjZMR2lWMD0KPTdIL3kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000057262065d319c32--
