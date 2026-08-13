Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1806236196E
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622895; cv=pass; b=blSULFG2lT3E6EfOzrXTJoomZem5WAstsu1gvu2Q7RXN5B8S6rVyx9NmUfi2Xh2AraPWpntsalnIoA1CaNoxkOSEnTsTBkxyIeth4VMSr81v4VowN9Ld/K1nENkmW6qUNU0+ZMmPz+uygONcwj5zHlvHL1l4+K77cUuVAMV1n4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622895; c=relaxed/simple;
	bh=ByLJZT1T99pUHg1R1zjDhQ4Zipq0nhLyRbw8cVJD6YU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=Ky/BlAFF7bPyaY+SPmwv1+0Zkc7lAOv5dFFchTWmPYVFY026M4Acr1WeAoUN2/oEPETbebibaN3i8agYIfeApBaofim+QgQehz0zHTQesd7wdJlnf5G3NKyo+VNsv/5U67zvZF2htvOyAKUGEgIUCIvyklTFJV7h4CRVcHfhsj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3SyfGeo; arc=pass smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3SyfGeo"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-966e7380109so1449630241.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 05:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786622893; cv=none;
        d=google.com; s=arc-20260327;
        b=k4EvSZjpRHe9bxxqEd+uTscPZNpcals39HnuK5XKb74BwTiADE9iHjOy1ZuOp6MMn/
         rij7edp44TV+APhRkazfcFbe0LGS3PFks95yBuRMMerpJfu3MA9PVN+VoF1N06/Kjt7q
         ytZpG7/xVNSTSBt17A9wxpJmZlBQ/OSUbUjEOg5398FsNrmOH2YFBOM2NEg0TvHOBzpH
         vujaZBw50azIe8JH+a0+XEx+1iL28kSxCjBWQOQwDi3Pzp68T7hES5YlEkwhynPKlV/6
         gaHuMgLymmTLvF1Ymh20D888Q08gksfxJD/dozIbQxgkXfDIyfMZn/mHOuVDd4reEeYu
         nNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=YDtRIyotdc3MwTOwsPfGno867TJxuNELOA0nlEE7b6E=;
        fh=GeSn4VSJTj6EACUlm7/KYQY3t2gvAdfFkaGxLTTXRIQ=;
        b=Ra5WH76uhP14FVrfokDTcMxXEWoKrkWAUdrjVveZkm99THZOl8rDWGNk0q45HpVWQx
         kh+tWQdjv+EXwmmuxMeX7YVu/1MejAVJ1raTRucVr2exwJowSGZB1c0uzPEYKdBV0D0w
         pk/AY+G+Qe0mFF7nlYsAyUUkHdKOByCjs0cf3GyL1hQBxR2/EaevTDufOiJ5rJBAWMvl
         ca1jYTJhpkn8JJ+PCramb2rhw7dL1OQiAiSATep3h1kML/S7iyIo7jN73sbf5DLpER+r
         MEI8GbLH3JEpxD4VSp78jyz2TtF6TAhVC6M26pCNBFV9GeyKaMQ+xyUF7Fo/O5ZqukH1
         sPDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786622893; x=1787227693; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YDtRIyotdc3MwTOwsPfGno867TJxuNELOA0nlEE7b6E=;
        b=Z3SyfGeorjjv68CDvhmcsYUkfxlVhDiDQnE+Uj8eecxW+DJ3EBcQkluU7+EHShADm9
         15zTIpRK9d4gMzsu1oD1TEn3srtH+qtpBNMplZgWzQYtgoT59lM/OnmfjLEcjUSqov0c
         Z9d95ZvZ3d9DEiCKNzTE0C6CdcyG/SMb9EjTHI7WnDrVmPMg/zSXVkX9ab/i3a/HKDho
         OEc1VtvoszRzUEfMusc5Qje8L7BIh2ppM4VNFQiEcUwUTMmk+OpvD5v+CfX/CX7LR+zH
         gEqmvl5B+WP4B0L9ghvzlctqLtmSK7KQLKHJXJKR4ozWKLsysz8hc3iFGaB0JmyDv0xH
         tyVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786622893; x=1787227693;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDtRIyotdc3MwTOwsPfGno867TJxuNELOA0nlEE7b6E=;
        b=CDmW2WsNW2+AT6RxTCkQcDmHkKfqmUOsEquwwa84V4r+zNI0uk9Nx71lgs830Ggc4s
         H0rNFoRCbHDV+RUmmfjbJayaPNWe17zoIg9RKkpDE5gESjRkdYlRVYHgd38GpKkG8Vnh
         cMmceIgmt0Qb/jRNZdwC81kPh3FfhIsftyXbQTVu4bcErrCJjVY5+Yod9kOATtSS+fR5
         bt+sPKYbj1ZZs8DRbVM1x6wqXWxTc1034Shb3LQeFrHYa5cZjgZg3xHpU7oVJHa8oL57
         us1Soz+xi5+OTznl5QkH4ogyrzMZ2NydE7uYe3+TzINOC9oIC4GPqRV2ocNo8zOhGW+A
         p+gg==
X-Forwarded-Encrypted: i=1; AHgh+RoYBmAODW7r96CX+Poc+TO+6lKwM1tTQijZiZJVFWB5NRhg4GKrJ7bYgILPUdeBzDWSw7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd+7dSR+ujXSaOWq5KdFO5SFjBh0f8JNsVh3fqxTwl/av8xluZ
	ALnFNE1g1LNnuAtgVt6+D9xTFfByLeFXoqAm83fAJOlRNQ2yzcaiweDb5I9UbvqyRXf5TLZao+W
	rya0Qe561UHI4pw82nyAWvjk7thNQ0xE=
X-Gm-Gg: AR+sD11KVTsKG7ax+abt1++wDx7zdZrrGDVrLDgQyp34hpDtDGuWP4wkXE+3TMQTFNO
	NAz/1XH5Wla6hnK3yYU8XickllHKwDriASkR3xAoQyn2FJReGgsWIJnjruGLc/p0wKpQK49RFue
	SztFCgIUUTBiEvaCRrz1m/M49dYfWi2ERsjlQLcIL+t5beGVDoSUHOmHQkHE+lVKa6indLAM/W2
	XNi9/L3aoXa2qjMeIig9CQM8Hj6+DGjXG3unVo9+OSHSARC8quc1770+QGFq/Ir7qi/wSveeHON
	5OA1WhKoO3hBUTtsTlJ5PRfVDCTuH5bbYq8I9bzHkDr7zj2f3pkez5wNvMd97h6kFvv1BofBIF4
	rrCRpUG34A9v8VaqDqtWSlkb5NWcPK4z7K54=
X-Received: by 2002:a05:6102:2929:b0:737:783d:1912 with SMTP id
 ada2fe7eead31-76db8871be8mr1555063137.12.1786622892846; Thu, 13 Aug 2026
 05:08:12 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 05:08:12 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 13 Aug 2026 05:08:12 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260812-pks-t7900-fix-flaky-test-v2-0-9ea0e1ac0edd@pks.im>
References: <20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im> <20260812-pks-t7900-fix-flaky-test-v2-0-9ea0e1ac0edd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Aug 2026 05:08:12 -0700
X-Gm-Features: AUfX_myYloeTRdN-9owiADSynEpc927I6FEa0UF8pM_8efJGf8zIPXiX7YkFQOk
Message-ID: <CAOLa=ZQmZ0spmdPOzCZe36i24nQh+o7d4fSz5dcJS7+O3p2skg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] t7900: fix flaky "maintenance.strategy" test
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e044e90658ec8e21"

--000000000000e044e90658ec8e21
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> I've recently noticed that t7900 is flaky, see for example [1].
> The root cause of the flake is the auto-detaching logic of
> git-maintenance(1), which sometimes causes us to skip maintenance
> altogether when the foreground process is racing with background
> maintenance.
>
> Changes in v2:
>   - Perform some word smithing on commit messages.
>   - Link to v1: https://patch.msgid.link/20260807-pks-t7900-fix-flaky-test-v1-0-08d0ea0fbbc5@pks.im
>
> Thanks!
>
> Patrick
>
> [1]: https://gitlab.com/gitlab-org/git/-/jobs/15762975482
>
> ---
> Patrick Steinhardt (2):
>       t7900: adapt some tests to use a throwaway repository
>       t7900: fix flaky "maintenance.strategy" test
>
>  t/t7900-maintenance.sh | 76 ++++++++++++++++++++++++++++++--------------------
>  1 file changed, 46 insertions(+), 30 deletions(-)
>
> Range-diff versus v1:
>
> 1:  10521f07ad ! 1:  1f3f8aa538 t7900: adapt some tests to use a throwaway repository
>     @@ Commit message
>          tests more neatly self-contained and allows us to trivially modify the
>          environment in the next commit.
>
>     +    Note that we adapt calls to `test_config ()` to use git-config(1)
>     +    instead. This is because on the one hand we don't need the auto-revert
>     +    logic of `test_config ()` as we're using a throwaway repository anyway.
>     +    On the other hand it's not possible to use `test_config ()` as it uses
>     +    `test_when_finished ()`, which errors out when we run it in a subshell.
>     +
>          Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
>       ## t/t7900-maintenance.sh ##
> 2:  71cb84a4a7 ! 2:  ba1fbb27f9 t7900: fix flaky "maintenance.strategy" test
>     @@ Commit message
>
>          But there's a second condition that may cause us to not execute tasks,
>          namely when the "maintenance.lock" file exists due to a concurrently
>     -    running tasks. We usually disable auto-maintenance from detaching in our
>     -    test suite to avoid exactly these kinds of race conditions, but in t7900
>     +    running git-maintenance(1) process. We usually disable auto-maintenance
>     +    from detaching in our test suite to avoid exactly these kinds of race
>     +    conditions by exporting `GIT_TEST_MAINT_AUTO_DETACH=false`. But in t7900
>          we unset "GIT_TEST_MAINT_AUTO_DETACH" and thus enable the auto-detach
>          logic. The intent of this is to exercise git-maintenance(1) closer to
>          how it would run in a real-world scenario, but it does cause us to race
>
> ---
> base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
> change-id: 20260807-pks-t7900-fix-flaky-test-160abfcef65a

The range diff and this version looks good. Thanks!

--000000000000e044e90658ec8e21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 8bbc054d7e24b17c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1wOXM2b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUJoREFDWFR4RTB2WGVsTDZKQTE4Rno1Zi80eUo3LwplMkpFcStodjRX
bmNURWNBYUViczIwaHhBaW5WN2RRQUFDRlQzcWpHSGtsN3hmYWw4OHRTSi91T2psUVFtaW9tCnI1
ZVVyMTdMYUJsdFNzeFNIT3RpL05aQ2FTaEdsWlRNa1RqRHJZejhMZ2gzVStybjFYbG0yZzUrQ1pH
eHdrbngKRWlmT0dpY1R6Umc5WlBWSnVnV2lJWVdiVDVRTGFoSzUrc1prdjM2UFJxbk1ldkR5NGdF
dHB1QW9oalo1Y0w1VwpjekhIdS92Ym1yendlaXF1aTNuZWRLaWlKaXlqbWxVbWY3a0MxanYyR2x2
ZkN0Z25tSnFjYzNWUExtLzVrV0owCndZU3NOS280cW00VXVCdmY4L0FZdHRIYVdGbTdtQm4zdG9M
ZlFUNTArMTZZQUZKQnFXazFKajV6U2xka3dxVlgKVFdqV0E1ckNFN3dXNDJ0QXk5bnk0d25uUkZG
aitzRUMwalpuamRSaE5OVUova1FzeXJlMnZFREYxTXk1WmxQZQpVeXlXZ0k1TTc3c0k2V3VyQVNt
SElYejRlUzFMMUtkWnFvQ294YVBNdUxrZ2Zsc0NkZWtIVmJhdVh1ZGdTVTBnClVPK3FaQUNKUHVj
Nms0eXJtYUo5MnpQcGI0SUtmTWwraWNiTmRIRT0KPWNzSE0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e044e90658ec8e21--
