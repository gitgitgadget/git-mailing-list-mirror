Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5AD3EC2D1
	for <git@vger.kernel.org>; Wed, 12 Aug 2026 08:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786524378; cv=pass; b=nk/1+uQVfAwxWsXKAXyJMm2e0uiptTxfWMMwKHrjMYg+Bkqiyh+5ROIdJ4+X/fZ12T9XZZZ78W+bl2Sr05iBx6JhvoQnrPQcZfj000EVCJ/LuIJQ8i5xwT3WmH9Ud+0PRDTlCWPf7VTx1doirisHOquXyzCxrgoCwowePhqkia4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786524378; c=relaxed/simple;
	bh=O4H5Q70xdXHrCQ0eC9NpsZeVXjYnDwt/QTLlOpN2nbo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=hAB+gtMPg6UXBxvK3HkWYDcgiZntmZ0GhT4JgRq6BsCZMkZ23JKBdaIVKJOO9zcG1r5Z+fVjOOU5R6kR9lcd+aQsVcVbv7Td7bGvCx+zpP3my/93FZbIjXOdCtLQNcBpDO/ZyJRzzNosVFIuC17xCfIM2iOmk+BVaHkWJUwqcTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzIH51el; arc=pass smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzIH51el"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7466771f1caso204735137.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2026 01:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786524375; cv=none;
        d=google.com; s=arc-20260327;
        b=F3T2f9WV60olGCSksrY2kROB94W5E/azEMfm9Xx6Az0tpWCBkSLocmd5sBGxjLDflX
         3b+CzwO4lt+8FA8IeHPZNY8rX4VdulvvOOAapD/ftIHrLfTC616G/W4g/9RaWKA4X4t1
         OTGljg2+Yubujl8GP80w1/FVa/UKoX8HVymU1+6X/fWIUbOjOFc9vpYFFbxUxxzc6l2K
         kU7WVhAQjz2JIpxQ5PAhWdjIzdtwnVZiVLBxUhJmHWso0LBvBAYVbjtFwK3zEm1o9PfI
         nlJP2talqLymLcOqwa6iIEmsmUbnR4+oHeUjU9jtUCxiigK0xkWPBTT63j7QmLyiSq8p
         BncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=FtL3CqIDb+shpL52H75cy93iLEFPzMjlYADL+o1MaUc=;
        fh=tp6zkf4qVrQwAoy1knVTTSGRNDemWT6r83zQEIP8H9Q=;
        b=jYnzPm7FKPn7WRQt2kzUGhUmljcfxDQKUR7hXUjFbtSblQzytDrYXYza0B7rwCHaHP
         l9zXzEQ3vHxoF5+gjJLoMZLjj29VFqEzkg8l78Ub2d8uU6qtXYEMLqoBZ8TArPH1FARA
         cqQ/eF1jkumEcE/DwApUoQiTGOrTU2OjpWbVY7zsNVZFjtkiCA7WHStnYdAB7gJnhMGo
         1FEOLV4TPTgiemufbPm5KxPcub89SMe0N5wDlmKDXpWKzTTfn0MM7UDmMGkz+Wpk9Lz3
         FkVLwzZZQt/hjodsJcG7p27bUyCEpdIveLi4UlAnj0XJcjlDC2NyKOC0I58D0AUhPOYs
         fvwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786524375; x=1787129175; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FtL3CqIDb+shpL52H75cy93iLEFPzMjlYADL+o1MaUc=;
        b=lzIH51elM6dFRfwsol0x38WXg1oFg3wVVfo9jtxKoaHKTwGcoFEu8KW3qj2TJrU9iw
         yVgaPlNAp1CbDvLX+3GsBd6YTpepz3OHwZRnh9nzmFdos1H3RdLvWDs1PO0PSBfyj3l7
         EJpFAop1xbdZFwi2obpbGPpXEQUp2PEhiKj18xq0hlvFCbdHBszdV3TNGMEcpMq/3d8M
         Ixf35Ib+CAKOJ1x/MkSyBVI40Mrd1LU6NJ815/V1NY+LJEsCZOQSwRjEN9z/yymMvnhf
         uHe1Wl2uz230qRikiv8QcLiAKcf4G90BVX1SeufllGRTOtXwAqG2dVk5w8iIzboCFh8/
         9jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786524375; x=1787129175;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FtL3CqIDb+shpL52H75cy93iLEFPzMjlYADL+o1MaUc=;
        b=FuVWADVbV+jr3AxXrCLjMJNAfPiSsSTNWe0zK1H+ovjdqAYup9qHK0O5v3exDASzic
         f5Q0vS4pVziqo9RGmt1U6ysOKe+/rDog01UyMMutT8o8geRDMYRdKp1kHdngDEgc/Wpl
         UFh3APyb2fCDBoH3puxn8T4QkSeHW+2gk1xF2CXN9dzImllkQAmkkTWAkXLYfOcLqA4+
         nHB1JdIttveMWQAjfWC0GG/Av3v5aQxWLtIpoIn/K9al6/erhPHwyE8cssnsi9vzsw2A
         7K74q2DVhwtOJSV6uUUIDnhegBGxF7jP6wVJRxptEoXe62zoNLOxkTe1V8l7xvAt+yNA
         c/BA==
X-Forwarded-Encrypted: i=1; AHgh+Rqfjc+MLlCj9fQAowISpxLwEhACQHWu358uE1jyHk/Y86rx+38Qg3/Wtlp+5xJ+2jPvQnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6WsrXP3DZehqpI5ctRfz9v7Cj4WDQYuCFkWHY2v5zN4mNVR1N
	4gUkwhZCexmQxNuXHGFaskNqcDeyAyzhcwVIJ6oDNT15z2ad+aG6aZSrMk310GeyjJNYooFBklh
	yVeWPFcVfPWehdgDA+6+/0nwqAyhUpCFifXKL
X-Gm-Gg: AR+sD13VE3qDzvxbYfNgbf4xs5mxSaKMm5Ha3oMrdHFeF5+zFIC+S7f0ssqzV9Mcv7x
	cyALTkjJgIgVUXNZ/R9QjabYRcTUc8M8C5utxyeMY31oT4azdnUufzz9WEFtyisaBqTnvUz3pxR
	b6Bp9uVrL5kOImiw3yjYM0eM1EU7yh7FkXrPVhxPUKCT97rNckinFiA30I+j5Q2oD3AcmPoj5VL
	v8eAgjYJrvpPdz788WvMqjNGG5u/XudRxvf9Cg2Wy6CmNkcPlqGXABY14hjIbEH1R3UdJJrImNs
	2mHNxsCn+TTGVLYNPVXiS3iK9Gs/bgnlp9nmiunCQ6ji7gHgFGxZIZxNbsAfOJP9M6VWbUEPCaw
	9oC8OF5tYl26PM+dfvV3n7bGINJycGoaM3jk=
X-Received: by 2002:a05:6102:2b85:b0:738:9c30:2baf with SMTP id
 ada2fe7eead31-76c8c5e610bmr594468137.2.1786524375379; Wed, 12 Aug 2026
 01:46:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 01:46:14 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 01:46:14 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260807-pks-t7900-fix-flaky-test-v1-2-08d0ea0fbbc5@pks.im>
References: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im> <20260807-pks-t7900-fix-flaky-test-v1-2-08d0ea0fbbc5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 12 Aug 2026 01:46:14 -0700
X-Gm-Features: AUfX_mxlhpfLPQTP-ZLgbh-weeAI2-_ZNhAiHr5bAWhnQPnsSmCE2ybqjhUylQ4
Message-ID: <CAOLa=ZSW+Ta5ktauamTUvp+fmjC4HHDpKOQ0sri+pBfLGq6mOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] t7900: fix flaky "maintenance.strategy" test
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c712540658d59eef"

--000000000000c712540658d59eef
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> One of our tests for whether "maintenance.strategy" is being respected
> in t7900 is flaky in our CI systems:
>
>     + GIT_TRACE2_EVENT=/tmp/test-output/trash directory.t7900-maintenance/repo/trace2.txt git -c maintenance.strategy=incremental maintenance run --quiet
>     + test_maintenance_tasks trace2.txt
>     + cat
>     + sed -ne s/.*"region_enter".*"category":"maintenance\([^"]*\)".*"label":"\([^"][^"]*\)".*/\2\1/p trace2.txt
>     + test_cmp expect actual
>     + test 2 -ne 2
>     + eval /usr/bin/diff -u "$@"
>     + /usr/bin/diff -u expect actual
>     --- expect	2026-08-07 06:20:51.388322602 +0000
>     +++ actual	2026-08-07 06:20:51.388322602 +0000
>     @@ -1,2 +0,0 @@
>     -gc foreground
>     -gc
>
> When running with the "incremental" strategy, we expect two git-gc(1)
> tasks to have been executed, but sometimes the test simply doesn't
> execute any of those tasks.
>
> A first hunch may be that maybe the disk-state is sometimes different
> and thus we decide not to run maintenance. But git-maintenance(1)
> doesn't run with the "--auto" switch, so we should execute those tasks
> regardless of the on-disk state.
>
> But there's a second condition that may cause us to not execute tasks,
> namely when the "maintenance.lock" file exists due to a concurrently

Nit: s/a//

> running tasks. We usually disable auto-maintenance from detaching in our
> test suite to avoid exactly these kinds of race conditions, but in t7900
> we unset "GIT_TEST_MAINT_AUTO_DETACH" and thus enable the auto-detach
> logic. The intent of this is to exercise git-maintenance(1) closer to
> how it would run in a real-world scenario, but it does cause us to race
> when the detached maintenance job that was triggered by `test_commit()`
> lives long enough.

GIT_TEST_MAINT_AUTO_DETACH when set to true enables auto-detach, but
also the default value when unset is true. That's why unsetting it
enables auto-detach. That's a bit confusing.

>
> We could trivially fix this race by disabling auto-maintenance for this
> specific test. But that doesn't fix this class of races in this test
> suite: while I haven't seen any of the other tests fail in the same way,
> a bunch of them have this race, as well.
>
> Instead, let's retain "GIT_TEST_MAINT_AUTO_DETACH" and only unset it as
> required.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t7900-maintenance.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index 6735a9e082..5fbb16f0f0 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -7,9 +7,6 @@ test_description='git maintenance builtin'
>  GIT_TEST_COMMIT_GRAPH=0
>  GIT_TEST_MULTI_PACK_INDEX=0
>
> -# Ensure that auto-maintenance detaches as usual.
> -sane_unset GIT_TEST_MAINT_AUTO_DETACH
> -
>  test_lazy_prereq XMLLINT '
>  	xmllint --version
>  '
> @@ -71,6 +68,7 @@ test_expect_success 'maintenance.auto config option' '
>  	git init repo &&
>  	(
>  		cd repo &&
> +		sane_unset GIT_TEST_MAINT_AUTO_DETACH &&
>
>  		GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
>  		test_subcommand git maintenance run --auto --quiet --detach <default &&
> @@ -90,6 +88,7 @@ test_expect_success 'gc.auto config option' '
>  	git init repo &&
>  	(
>  		cd repo &&
> +		sane_unset GIT_TEST_MAINT_AUTO_DETACH &&
>
>  		GIT_TRACE2_EVENT="$(pwd)/default" git commit --quiet --allow-empty -m 1 &&
>  		test_subcommand git maintenance run --auto --quiet --detach <default &&
> @@ -107,6 +106,7 @@ test_expect_success 'maintenance.auto overrides gc.auto' '
>  	git init repo &&
>  	(
>  		cd repo &&
> +		sane_unset GIT_TEST_MAINT_AUTO_DETACH &&
>
>  		git config set maintenance.auto false &&
>  		git config set gc.auto 1 &&
>
> --
> 2.55.0.679.g6767b8d81c.dirty

So instead of unset everywhere we only do it selectively. Looks good.

--000000000000c712540658d59eef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 5c500fb827458705_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wOE10UVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUdRREFDa1I3cjRoMmpscWJ0K0RpZEpia21GeUxPSwpWaDF6QU42N1FE
LzJyNnNvcWhrWTFFVmtkN0NvVWQ4bmE2ajUyNWw3UTl2M001Z2tqMUJ4QXlzN3NqelhiWmdoCjVr
RmxYVVZ1SkZyMk9BQW1YL0E2VnZFT3dsY2FOTW85MkVML2dkUVpFbEwzMzAyMTR4Rys0NytDc2wx
OXJHaHcKbG5MWFdhOGJEbXZRV1RieHJjMFJETDJXRjM3RDdPMGFkMW40OEE2YUtSaWRtZmZBU0Rt
RW9uL0hTVjVZL05hdwpZZDA1T3JVbGNrZitFOGluRWR6TWN0cytRMkdObnhjSkx1eStDZ0lDbi9K
akFDQUY4MGhUejREZS9HTC9lTktoCkFaQ2Qvd2ZXdVFUUHhleWhXS2gyLzJ4enYyRkt4UkdjYUs0
anBBNmNDcXNXNkhySDJYV0tveFZkVGFrOGhheU8KbDYvTlA3ZDhYRzI0ZitNYmtQOWU5SlZpMkw2
M28xVjBZYW00T1VkVXFzWlpRUE00Y2tHUFR1cysxc2ljVTllRApVMFJCSXdyWVhTRFpNeUt1bGJP
Ny81RFc2dSsxVzdOc2FVcWF0a2U5OXkzeVo1b3FCNmRIZENWaHlRbWplb2hFCjlsRS85cGMxajRG
dzBLSklLblJNNEF2RWJENDBtWGo5cmlGaWNSZz0KPWRQblMKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c712540658d59eef--
