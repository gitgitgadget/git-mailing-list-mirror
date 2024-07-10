Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63D7D08D
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 09:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603174; cv=none; b=rHdN22oyJSF1i3pvgiB6zVTIxZ6Q8oXLJWDzej+Xg4Hylf3OPFyiW9Zf/125dKZGn3a0WqI775bZ+1+SBYGYOjX/T5ZM8by2165KXySIBJehrPN+rrsCg5SV75KvCtXazKmGWpMGGTm8A/R44lJx7FxZJ0HnsHCyQ8aAg7a2eLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603174; c=relaxed/simple;
	bh=hPtgLny7fdqWWpWfa8tK/TIov2sGKfI+JS43tO5ju/U=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mVIxHFuNxEvnAf+KQYvJPnm+GMp+AXA9C6vmYmWIHljQeyK5GNOndZydcUAUMh64TIIqWbL399A9qo/kDN5g1jmJii/J0a/Gx5M6PMrpRUcQmdHg5cKWe/DfrrTE4NeYJBoZXyHKH7T+emZp78PW0pxu9H4XOYWSX9jV210yzEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0CjEIQj; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0CjEIQj"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5c66ffadb7aso1767331eaf.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 02:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720603172; x=1721207972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PR/6eWjMdnB5iuhWWwYKHt8Ly6HZf3ieHmhAwN6lDDo=;
        b=V0CjEIQjtOf+od0WOV5Lkol/B0KHm8BsAqx6y2YtZWRek92B4JAXou74U+3hn5SRFo
         t5ukpyQnK6WUXlQfWaMdg7ZNuVB8RSPT7eo/eyvukQhEfYQHv+pZBOMV4OeMSV0esRFA
         0sr1TtrtuOh60odEICPPeFYBGz/yVuvWre+VLOaBcL07f1EkULpESe+obnqw8PtGNRKT
         QnGjmR3y31CJA/X4HueFGqgEAKQ4hiGhnwH1Vk1vJz/mpAM5rC3SKi7mVQqAm3NTkFoS
         TRVmTn/+1c21OIncAS/Fva+ERBmnoJ2tCk5/kklC8Z5jW658E0E0W6aF6vQMyeqPd9jY
         PV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720603172; x=1721207972;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PR/6eWjMdnB5iuhWWwYKHt8Ly6HZf3ieHmhAwN6lDDo=;
        b=QUjZVsBpsW69qHgz3/IHCd+VTRW7oy6wQvb2c4kkddTfDmh4Zlff6mMi10Y8wvq6gA
         L7o3ASiYzL3v+ZsQWFNg9sAOZq67Yun0voLf1B0LIF6JwWKRDbaD0rzAC64D0jY0+Qfb
         2Whfiuljx4clnef+OdJppSCj1q6PrlMcfFTMNoery4XMXixnHz4cDBBnN5iMJ8jw3J+8
         4e15/u9+vb0zZkADzS19ED+g5aN5ud+xShHSDvOhQ7VmtlSf1C6C6zkWHSsujHIgGlkJ
         RVoSdqjaEhTTrP2kjQD0pkKwikFn0vwP9xJIb5izpwhAUPwiIgT0tEbdvqSCTKyzUuFf
         iPkA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Nane942OQu484DvrjE45P/SuWLXV8MG9jUA/xsgYuNfsM2VYUkjKqiXWsou+axZ5Eid5b259y5O3IA53TLViWrDq
X-Gm-Message-State: AOJu0YyPybxXS9N1XR5XMIUak1f/Xb5dUDGUKUlxS1ID40wBmswVOReM
	Qh+hPxv74V7zER1CARRFs4ObqUwvDIGccL3HXZfoN6N0JnWwvJ6GWkP6uDLRZ4cfpjuVuFqPBqf
	YXz2CYRvQhgjufprM/gBvS/MFzQI=
X-Google-Smtp-Source: AGHT+IGGF9HAnrO6A3+DUnczihn7OTTPohwXezsY7XiDM1LM0eXN8PKULxzRY3AAwvYwUagSz9uRDKdenwMX4el21Uc=
X-Received: by 2002:a05:6870:658f:b0:254:b14c:35e5 with SMTP id
 586e51a60fabf-25eaec15f3amr4189623fac.36.1720603172074; Wed, 10 Jul 2024
 02:19:32 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 02:19:31 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240709053847.4453-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com> <20240709053847.4453-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 02:19:31 -0700
Message-ID: <CAOLa=ZR4jZhwzyQtJ=zC0wYJ9=u2CPKDgps57e-zCgQ279mYVQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2 0/7] t: port reftable/merged_test.c to the unit
 testing framework
To: Chandra Pratap <chandrapratap3519@gmail.com>, git@vger.kernel.org
Cc: chriscool@tuxfamily.org
Content-Type: multipart/mixed; boundary="000000000000df09e4061ce12485"

--000000000000df09e4061ce12485
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> In the recent codebase update (commit 8bf6fbd, 2023-12-09), a new unit
> testing framework written entirely in C was introduced to the Git project
> aimed at simplifying testing and reducing test run times.
> Currently, tests for the reftable refs-backend are performed by a custom
> testing framework defined by reftable/test_framework.{c, h}. Port
> reftable/merged_test.c to the unit testing framework and improve upon
> the ported test.
>
> The first patch in the series moves the test to the unit testing framework,
> and the rest of the patches improve upon the ported test.
>

This series looks good now, sans a typo and Justin's comment!
Thanks!

> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
> ---
> Changes in v2:
> - Rename test functions & description to be more explanatory
> - Remove a redundant comment in patch 1
> - Add the 3rd patch which makes improvements to a test
> - Add the 4th patch which makes apt function parameters 'const'
> - Remove a redundant check in patch 6
>
> CI/PR: https://github.com/gitgitgadget/git/pull/1755
>
> Chandra Pratap (7):
> [PATCH 1/7] t: move reftable/merged_test.c to the unit testing framework
> [PATCH 2/7] t: harmonize t-reftable-merged.c with coding guidelines
> [PATCH 3/7] t-reftable-merged: improve the test for t_merged_single_record()
> [PATCH 4/7] t-reftable-merged: improve the const-correctness of helper functions
> [PATCH 5/7] t-reftable-merged: add tests for reftable_merged_table_max_update_index
> [PATCH 6/7] t-reftable-merged: use reftable_ref_record_equal to compare ref records
> [PATCH 7/7] t-reftable-merged: add test for REFTABLE_FORMAT_ERROR
>
> Makefile                                                   |   2 +-
> t/helper/test-reftable.c                                   |   1 -
> reftable/merged_test.c => t/unit-tests/t-reftable-merged.c | 202 +++++++++++++++----------------
> 3 files changed, 103 insertions(+), 102 deletions(-)
>
> Range-diff against v2:
> 1:  f4d5da52f5 ! 1:  0d71deffad t: move reftable/merged_test.c to the unit testing framework
>     @@ t/unit-tests/t-reftable-merged.c: static void readers_destroy(struct reftable_re
>       }
>
>      -static void test_merged_between(void)
>     -+static void t_merged_between(void)
>     ++static void t_merged_single_record(void)
>       {
>       	struct reftable_ref_record r1[] = { {
>       		.refname = (char *) "b",
>     @@ t/unit-tests/t-reftable-merged.c: static void test_merged_between(void)
>       }
>
>      -static void test_merged(void)
>     -+static void t_merged(void)
>     ++static void t_merged_refs(void)
>       {
>       	struct reftable_ref_record r1[] = {
>       		{
>     @@ t/unit-tests/t-reftable-merged.c: static void test_default_write_opts(void)
>
>       	reftable_reader_free(rd);
>       	reftable_merged_table_free(merged);
>     -@@ t/unit-tests/t-reftable-merged.c: static void test_default_write_opts(void)
>     + 	strbuf_release(&buf);
>     + }
>
>     - /* XXX test refs_for(oid) */
>     +-/* XXX test refs_for(oid) */
>
>      -int merged_test_main(int argc, const char *argv[])
>      +int cmd_main(int argc, const char *argv[])
>     @@ t/unit-tests/t-reftable-merged.c: static void test_default_write_opts(void)
>      -	RUN_TEST(test_merged);
>      -	RUN_TEST(test_default_write_opts);
>      -	return 0;
>     -+	TEST(t_merged_logs(), "merged table with log records");
>     -+	TEST(t_merged_between(), "seek ref in a merged table");
>     -+	TEST(t_merged(), "merged table with multiple updates to same ref");
>      +	TEST(t_default_write_opts(), "merged table with default write opts");
>     ++	TEST(t_merged_logs(), "merged table with multiple log updates for same ref");
>     ++	TEST(t_merged_refs(), "merged table with multiple updates to same ref");
>     ++	TEST(t_merged_single_record(), "ref ocurring in only one record can be fetched");
>      +
>      +	return test_done();
>       }
> 2:  fb0f0946b4 ! 2:  a449e2edcf t: harmonize t-reftable-merged.c with coding guidelines
>     @@ t/unit-tests/t-reftable-merged.c: merged_table_from_records(struct reftable_ref_
>       		reftable_reader_free(readers[i]);
>       	reftable_free(readers);
>       }
>     -@@ t/unit-tests/t-reftable-merged.c: static void t_merged_between(void)
>     +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_single_record(void)
>       	struct reftable_reader **readers = NULL;
>       	struct reftable_merged_table *mt =
>       		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
>     @@ t/unit-tests/t-reftable-merged.c: static void t_merged_between(void)
>       	int err;
>
>       	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
>     -@@ t/unit-tests/t-reftable-merged.c: static void t_merged_between(void)
>     +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_single_record(void)
>       	reftable_iterator_destroy(&it);
>       	readers_destroy(readers, 2);
>       	reftable_merged_table_free(mt);
>     @@ t/unit-tests/t-reftable-merged.c: static void t_merged_between(void)
>       	reftable_free(bs);
>       }
>
>     -@@ t/unit-tests/t-reftable-merged.c: static void t_merged(void)
>     +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_refs(void)
>       	struct reftable_reader **readers = NULL;
>       	struct reftable_merged_table *mt =
>       		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
>     @@ t/unit-tests/t-reftable-merged.c: static void t_merged(void)
>
>       	merged_table_init_iter(mt, &it, BLOCK_TYPE_REF);
>       	err = reftable_iterator_seek_ref(&it, "a");
>     -@@ t/unit-tests/t-reftable-merged.c: static void t_merged(void)
>     +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_refs(void)
>       	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
>
>       	while (len < 100) { /* cap loops/recursion. */
>     @@ t/unit-tests/t-reftable-merged.c: static void t_merged(void)
>       		int err = reftable_iterator_next_ref(&it, &ref);
>       		if (err > 0)
>       			break;
>     -@@ t/unit-tests/t-reftable-merged.c: static void t_merged(void)
>     +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_refs(void)
>       	reftable_iterator_destroy(&it);
>
>       	check_int(ARRAY_SIZE(want), ==, len);
> -:  ---------- > 3:  bba993bb26 t-reftable-merged: improve the test t_merged_single_record()
> -:  ---------- > 4:  4d508eaa02 t-reftable-merged: improve the const-correctness of helper functions
> 3:  85731b6358 ! 5:  1c9ba26c22 t-reftable-merged: add tests for reftable_merged_table_max_update_index
>     @@ Commit message
>          Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>
>       ## t/unit-tests/t-reftable-merged.c ##
>     -@@ t/unit-tests/t-reftable-merged.c: static void t_merged(void)
>     +@@ t/unit-tests/t-reftable-merged.c: static void t_merged_refs(void)
>       	check(!err);
>       	check_int(reftable_merged_table_hash_id(mt), ==, GIT_SHA1_FORMAT_ID);
>       	check_int(reftable_merged_table_min_update_index(mt), ==, 1);
> 4:  5d6fd842ac < -:  ---------- t-reftable-merged: use reftable_ref_record_equal to compare ref records
> -:  ---------- > 6:  309c7f412e t-reftable-merged: use reftable_ref_record_equal to compare ref records
> 5:  d8cbb73533 = 7:  2cd7f5b0b4 t-reftable-merged: add test for REFTABLE_FORMAT_ERROR

--000000000000df09e4061ce12485
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: bf19a10224cdc7a7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hT1VpRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTdFQy80eWF5OFkvaE8vWWxjdnlvbXZQOGRPQVl6QwpPd2UwalY1V3FT
ZFJlaUdrRnh6ZW1xOEREcFBOWUpIZHEwczcvcnFaUHpBZGQrUzZVc25qK2F4S3RmbWx4QTN0ClVY
NXhkTmI2VjBINVVRNHpjWmJwSXR6SFdVMTc3ZmZNV0hwVzA0c1d1ZkJ4SG1zNkRNbjRCeng3eEdW
VlZtSDEKdWFvUzNpYVNTS0Z4eVpNV2V0K0ozUjE0c0NvVlpvOU1UQ1VXeTZGTDk3SVJ5L2NKUzBV
Tkc0emFsMHFqakl2VApOMHMvbzRaMjVHY3lKSHlQZTVrVHlJeFZabkhFVDI2YUlQcWhxOXZrWENN
SjExeUVqRUFncGx1cnUrZGlPWjduCjFlUDBoZ2EraUx1L3c5Y0JwUmY4elp0cmx2aUpZMDVjZjFz
Sm1RMll5TlZ4NXVCWUoreVlaL2ZMOWxkZUpjZG8KcWFvTGQ1dE5jRnNLZ2pVN2VjQTZ0ODQrU3F1
MzcwdHFtdGdBeFZJU0RudjNGZzhUTnpBL2kvWktFaThKaHZ5RApWaGZINjlGZXZDVzZzVGNwOFlh
Z3Ard0tiV0NoeWlPcEVCbU9wRjJOQ1ZvUHF0YzZmUEUxWmFJbDVycFJZOTVoCk9Bc2d3Uk0zSEhq
c0N4NVI3T0pkZzZDaE1JcnVrYWlBMXRVZHlGMD0KPTZabXQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000df09e4061ce12485--
