Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15E4A3847
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282506; cv=pass; b=o9YgZpPqobn22uq28lkgl9K5WEeVLHaBh+XlGX2Dgrd7pUR6uN2znyhkC+4boyoRfSMP6hf9Ztr9DuD3g5s/KbifDy0uNhIsrEuo45YOh5H+7MWfLhPLMssfjd0f9K1+Vf4uKKFXGhLSWAgt+nzn49nC5iPeXt2fe+zEqMmtHa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282506; c=relaxed/simple;
	bh=nGQiELChfBjrxRbhlG3Clmc03SK1Bzc3hxk8caQB/yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BNzdFwBQ+GfkGpQANbe8fNFNtnhnJeYh0mB/thn7mpjQl4f9uI9hoYCnn1GfbxA1pW0byk0qDRK4j6f15QbS+O0cB2qSgpoW4ru5X1yZp0BbGpX2pv+VObqarbhSZzVNFqddDkkyliKx5UGlkJBcEQvWq0bT/1upv/QDdGWJOA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpaTHAhe; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpaTHAhe"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d5eso1220191fa.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 13:41:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790282503; cv=none;
        d=google.com; s=arc-20260327;
        b=VAUlYMsbNEwttly3EbJJEeXrigrYV01kT6VqLGqbydMQZuE8ycJBbuEmNHBYcwxYau
         p5viMGBKoKm0ufMCN+QIalpAH+/KOkZ2BRRNvn0fe2hpwGpvFGz/LjvwPhz70HuFWO9U
         wiU6rKZac2ddrTXYtPu5DzuL4/s6ZDt80w/dSnGmCrXwoxLa/YtSE0LhtpQblgCFtxQB
         +b+nTpZb8+A6hI5SeDZTMaaeg0KB/uw/cODhdCJ+MPsC2yaugb5rb1OO4cmYZdVwXqDI
         4s0caKvJKlcaHJmXk9vxLSd8zwFs+tY/nPSZ1dX59NmCKcz6VAxD1kPryw/jVpTt5HA3
         9pHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XSsb4UKluBoCwaXiKfh2vD1lBL1hEi0b1Ecf9NmzjNU=;
        fh=4ryOG4wBbIqKixWzeKd5dc717SQGdNJth+KYU2DAukY=;
        b=Cj2WrFt370hi+hl8uRcn1YcIX22b79Yl9RBimyjFobCKKah8Tmp+jHWfiJOUxICC2S
         DqY2KzdYH05YROlu31VNFVzcs5nJctzEAHwPV07V3NBFTlVIhiLdx1UNh+04xJpUTH8F
         CP9A/e0uLRP5t2V0sv5Oq9adweWGgo+Y1Z0ujDx9TACzD4wUE4F6GkNqAcUcd11BFZh8
         9Q3RO/0x2GaWDvtnAsKryrmOdxWTQoEyHBbiRIjAa8kUhNxLk2Pa0jOruQzEsd7x/ZwI
         UEz2vo+OoIutlt05p5/e85pzOhPB5k7Y+0YcdouWkof4HRoQ4RQJgMFNS1lA1hhQrlr8
         SBnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790282503; x=1790887303; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XSsb4UKluBoCwaXiKfh2vD1lBL1hEi0b1Ecf9NmzjNU=;
        b=DpaTHAheOe4aY4VWN4BgwUnLj3/bLsZS73dkfZRQ1BFCd1qh1Fe/YAY1wGAsbe2mL8
         Ur4V9zVQ0PD2/LVyGfBPK9JqmNYLBc+pyaAyWgjN+yTzus76ZNYQcbCVUJwI44I8RAIW
         wuTibSpefMU2UZn3EbPUh2ssAOIasL5gz9iqZvdglOdkCvxZGY0ct5mPzLrg9ZvuK1jH
         TqtdbPwXc4mqW9NscQQ3WITQ7tDddb42fznLtnlGxQ8qYT7VMtQYzE+2ATI9V1JOAfHC
         DhSlYFxDl4dhXZuIJFW1CCkckhvZ8CjnU48Qnk/uPYNs5QjZ9dEr7yxpI0KhtKToePom
         8WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790282503; x=1790887303;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XSsb4UKluBoCwaXiKfh2vD1lBL1hEi0b1Ecf9NmzjNU=;
        b=KiH1q3crc8zU7G+20a/D9zhqUHSUiKmhvXty1V0yUNK/9/QFK9J6DnNW27ZpIHhVxc
         W4syzvLe4wh52y+ToimMC8TreLfLhndhP5upWaekzd37b04061C2qfu0pGWPoz5Fgw+V
         e2mau56qCTu5qPZ06J4OuyM6iB5sSPpFCKFVktIIqOBNJoOdEteDwwpClFQHH7uEDVDx
         +1BhLkYtpD6a9VfzFDz9ZT1/xNbs46TxwEp/d6Oz2/+ucCJdfBRhaJuMEtrU+p9iHIve
         +Z5Vpn7xQeueLMBzUXSgyaEB3tUNrz8oINWDcPq+/QckvyM6nSZUjmCBfUBCE0AXaNKH
         ydtA==
X-Gm-Message-State: AFuF++mbMfKmZvzKTkn7Ix9UtkcP3OgAdouqS+GudZgkJ+pe5GY5sP52
	1/oHAuQPvKAuvPT0sw/XMBymwAHBbOF7hy7Twx/33+b35amcsZj+8MgEyBXgQdSCxXF7TPfhpwM
	Fske2THx1S/eHBeiaBn6WXSDC8tMnC4M=
X-Gm-Gg: AYBFou0QSAYpV0qlzoRD35Kb2kvfa0Ui0i7EO1vU0c/Bvku29dgNsZGhk3lBTZiUbWp
	xSCDvD4lFMi5K92Yl2d8z+AqLs+NXVgl7FAWQrl0wg9XiKWrSXQSgFTHlbv9NCp6vH38l145drr
	8ilSmUGyPbsnKyrMRN1rE71XpUi0E1vNZPi3TXCXI3ZkAAlQr8afBjy8BUKNJVRR5QXe+LDXpi5
	4gMqPswDceRrw4jz55vtwgwWlKicbhsdKKNM9FVpCShFKCg0jmG0phZS3xlXPNtbBtRIZ7alKCg
	8lYM0+c3qwABoDGUNBJZvCvErWWUQbQaZ1YIaIkbvcLzZ+0Xc0ApFHzDjSudWmLrJZqOiXgKTlm
	7HC3u1l333FAKXEInX2Lwkwub94n5FgmJjXRZbbHkr3noQ5s8HPnQv76SFyka+Pbifv4=
X-Received: by 2002:a2e:a994:0:b0:3a5:f982:9c78 with SMTP id
 38308e7fff4ca-3a63bf5f624mr9795581fa.2.1790282502453; Thu, 24 Sep 2026
 13:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-ci-large-test-resources-v1-0-c28416d59475@gmail.com>
 <20260923-ci-large-test-resources-v1-1-c28416d59475@gmail.com> <arS_l1hPIr7I2Gn-@pks.im>
In-Reply-To: <arS_l1hPIr7I2Gn-@pks.im>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 24 Sep 2026 16:41:05 -0400
X-Gm-Features: AclHuK8K-Hd9T2_2pZW_Zfxzq-_z5CfQz8S7UdHdHT6M3jaBDXH6jtuAIpf7noI
Message-ID: <CAJ-ks9kJWc0e7aEX4vAL-RoJ5kVvfjDABqV86_hZf2Fn-085GA@mail.gmail.com>
Subject: Re: [PATCH 1/2] t4205: compare huge output without diff
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 2:13=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Wed, Sep 23, 2026 at 01:13:28PM -0400, Tamir Duberstein wrote:
> > The huge-commit test compares two files with a line larger than 2 GiB.
> > In Linux GitHub Actions jobs, git log produces its huge output but
> > its subsequent diff process is killed with SIGKILL.
>
> I've never seen that failure before. Do you maybe have a link to it?

The failures happened on a private repo that I've since lost access to
- but I believe it was precipitated by GitHub runners having half the
memory in private repos as in public ones [1].

> > Use test_cmp_bin to compare the output byte for byte without constructi=
ng
> > a line-oriented diff. Remove the two large files after a successful
> > comparison, releasing more than 4 GiB before subsequent tests.
>
> It would be great to back up the claim that test_cmp_bin is better than
> test_cmp, e.g. by comparing peak RSS and its runtime.

As for the comparison: on Linux arm64 with GNU
diffutils 3.8 using two identical files containing 2,147,483,649 "1" bytes
followed by "0\n" (matching this test's expected output) gave:

Command              Mean +/- stddev       Maximum RSS (KiB)
diff -u expect actual  5.276 +/- 0.572 s              4199924
cmp expect actual      0.506 +/- 0.099 s                 1264

>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  t/t4205-log-pretty-formats.sh | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
.sh
> > index 4be5c51489..6279a7e9bc 100755
> > --- a/t/t4205-log-pretty-formats.sh
> > +++ b/t/t4205-log-pretty-formats.sh
> > @@ -1189,7 +1189,8 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'se=
t up huge commit' '
> >  test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'log --pretty with huge =
commit message' '
> >       git log -1 --format=3D"%B%<(1)%x30" $huge_commit >actual &&
> >       echo 0 >>expect &&
> > -     test_cmp expect actual
> > +     test_cmp_bin expect actual &&
> > +     rm expect actual
> >  '
>
> Hm. Sure, releasing these files isn't a bad idea by itself. But we
> rewrite "expect" in the next test anyway, and "actual" will be rewritten
> two tests further down. So does it really buy us that much...?

You're right, this probably does not buy much.

Would you like me to include the performance comparison in v2? As for
the deletion: would you prefer I drop it?

Link: https://docs.github.com/en/actions/reference/runners/github-hosted-ru=
nners#standard-github-hosted-runners-for--private-repositories
[1]
