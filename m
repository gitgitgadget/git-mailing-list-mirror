Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793764734;
	b=NDC4+f8ds/iI88Wbn8hV79ouzVmiABJxwOLc2Ff8C64WY3k8B8U/+NbiXjRJ7pomt8Dy
	 gNAztQbcq+LhOgEMWKHkHZtioHLRfhHhHouyYIUHB45jhDzCDajt2T1w8rZZhjcEhb91G
	 Q5p1eop5YcOSr5S6i/MSy2ksOq8v612KNB3DbtJVpFtlAnAPGjBgIDtzXcd3f9dh3/6JE
	 sASMRwagy/wi6ZLaQrBClC9lwk68Lt3atzEB2EK0LJgAH/8rX0q32LqZ572g1zdsqgxLl
	 mW1C4AAdlZnoHHfF6pfBfjU4JL7LZyjpG060bkMDq1sto1sB8UXoRJQ5viRIMZT7Lmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764734;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=R0DTw9qTD+SAxnFI5b0VUadGdj6ARMXNKKtTsw4MfqM=;
	b=SgtilV/8TkLxalnrxnLkEBCwbxft0n36CqVH1e4enNzA8JlL6RkoiclvLOxol1MKK89t
	 LwDbrYw+plYRn9+xl3JfRjvLi6MbDmcg/ZIoKjkGSfupjBMGsOYhGQbqbzu38HDbxCXM+
	 kHoaVi8G2m+2smVv0E8TGBM1x/GXv5JuK9QeF26Wtmt4SV6GNRbvqV/0eqtCb1AFKCKXa
	 rf67j+6LZ4QLrcfUKvlRt7tzSBXiOYIQc4Z23kZ3sDYQoyMo8N01VPkt50IhGxWUr9YWm
	 VA8MvyL95mRAXi4Q46g8YnK2NlaGSJwcS+WGCWg/tgBRspUczPCuFTI4iDV8E6U0fyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J4UOMdV4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88E2606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 03:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B88E2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J4UOMdV4
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91befbcad6dso4075796d6.3
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 19:58:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793764733; cv=none;
        d=google.com; s=arc-20260327;
        b=F037B5OAusnKRKuAbt+9cAJu0NI5/UxSetfCWmdY79Gvp0P0gTuPLBCsyFFeTnctD7
         fNPR/oTJTNY71mZ0L+Z+e75mh6EZE5Qtt5okTrwPanMlw3wna4bDxAWVfJGDqhvvKJXI
         7rntDWezSt9AWLGjRMZUEDeJVMmrRTeNewDx2rnHKLgTm1qZaz2S9cIluJaMD8Zv56+l
         OaXYey+2zF3hIc6dYxRTg8AEG28ZwfXZYslxxvospXgDIJJVXhmAYXhLpBJgwA43ncZY
         Pc3kvDWvBfRQVlpcn5c6BYHSXd5YON1t5JxQ6GoW3ltRrh+54sdv4Rs06jdHICCmzr0C
         KvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R0DTw9qTD+SAxnFI5b0VUadGdj6ARMXNKKtTsw4MfqM=;
        fh=lxqtUJYTDsZcCJCwb96DtNY068ppEtVxRDFXmhd0SBw=;
        b=EO/4nl6LcKnq2+KQxPlGTpvmS0YBoiIcNxJy2kiRERCdWTfKrnzh83BNnwutZl8XBV
         atf2VzgLFsmONrmv4mGPfhVDNZ0deQmWlZniOPX8hqikKdd/zSlVjX9VorAN1b1aVd6m
         7WH8xt42pfiYqEIP0kROmlwxMKkq13VKGMN7ig2X73TPAVhMnJYQ7MXi3c4sbH0VxhNt
         7BGgVcXqxGS63KukeNNGasCCc4nZadsun/Mn28yUmpy6kWuQdSCjhT5KVr/2f1ualgvo
         xJWfEQ/zpD28znkByvg/W5MXw3NtWiTLX7XQqZaQpUicavNXg576afAHBCiphJkpfHV4
         kcBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793764733; x=1794369533; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R0DTw9qTD+SAxnFI5b0VUadGdj6ARMXNKKtTsw4MfqM=;
        b=J4UOMdV4KSBBagyj+2niTOVJNFIMS4jwJ3zIZFi43h751B9Daw6xYXZevVqlShJUAZ
         wu73O/XYIATeR1T78T3+N2Ja62m6zTtGWuMczuhX9O5sWu8DcUQcsQNqQWz6UqU0dq/k
         OOt422O3o2L1qLFYYeCoI4r1USCJYXqU54m0uhcaMXQN5zPz4t2mcUIBgdt1KTdOkx/E
         oL5VLBTIGvMcJDYSjWGmbmTOAS8FNGklHnRQIqREONRpU1VaLp9p9eTwy3Igqs8rf2iv
         eK9Z5Ey49sg+8WO8kERxUuParZ+al+HS86EiiJvX/nShB89rFBHhtnrbc+vJP0jeFq37
         GuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793764733; x=1794369533;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R0DTw9qTD+SAxnFI5b0VUadGdj6ARMXNKKtTsw4MfqM=;
        b=PIP/SCKefTf2LpUW1QjVysO3R4A8Q5SLEnpkdaulBuQ5T9rygBnF48xaHOdCKZJuzM
         YcAZZZeI1IZ4p5ethFTx4TW9tewTwKoU2YM11N8y0ZuIRTKB9/F1isIi2M/9xjd+sIXf
         e1R4+ilUivYCdK1/PlVD0TvUBYB/lI03x4f+0wyAiDgWW4/7XZb7whWUmpVjcThBzJGW
         1JMAuQKKGm7ARgGDS5obM4avAnDAJAvwivPULNoMHrH7jhbSQ8OqvWvI28iDd9bbojTt
         yt1ZxEPFfVWRRkZzNS/aHfLPIRJlK8PKGHBCwZNyhm+moUYHKBJjDXeJDcR2litwVAuO
         BrcQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9j7kuXW/89XRBTEgaWf1WPj/yBThFt0NGHf8u+sEO44BIuX+IWmLvC1Q/HEK0z31NZq8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/A53Gwdc+1gVYDnA+cTmRqu7UGYFovny2hhOLZRm5O1oIb6fmB
	VSOULZhUHdGohVfMGqh52FOk3qcIteMDvKTHMvPTqLqLAgvnpncTdn8Pup+ai75B7UoOV8B6Cwi
	rhBBkQQEap4MdkX6I4RSPPwVXn/fXdbWydyOHxtk=
X-Gm-Gg: AYBFou3+j3Ik4g3vBUaFkcjZKlRL2YnOTBFzVFyUeW4cfQIkhkGKROh7/62LhM4pi5I
	3ld/eP8pI34hSR7ebD5JhtMZ7r3Rqp9QR33Sin1w3enqp1WDhPy2eU9gT5wds3tYth7NJ0CZodY
	Bsmw4cysusbUB8XGkuja2vFY+YsPkaSid12ivSjUu9joFQbMbuya90wSN//Zt2oLJzPJg4yFvfT
	GHsSsOe5LvOUzX8rmiyICv4yKfjkGejwEOYCeXHq9FOdmBH+KTnHv8djwiUResrsvS5Zi/FUSr8
	cVjdpOdHv/XTqMlB9wzjTEnP73HRMI6warY6fyPhU4Q5tuI1awjnvR68rFs+ux6TWYhV8BCxMVd
	XFsbANoLjKe63sKNOlNc/xrU8S7ZGKSovzMqFDZ0BgCyR3acikIg3Vi4g5cqSf4r/n9wUFK6CEm
	8VLDyglMkfr6xyRGETzMiAe1CRX6k+6YHmk4tLYhUIzOn7l/2ioW6K2zQ=
X-Received: by 2002:a05:6214:8620:b0:91c:7b68:6fbb with SMTP id
 6a1803df08f44-91ca4a0cf5bmr251542066d6.2.1793764732692; Tue, 03 Nov 2026
 19:58:52 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
 <pull.2288.v4.git.1793648430.gitgitgadget@gmail.com> <99a1234544840e63e6f3dcf3c6beae3ba02af84b.1793648430.git.gitgitgadget@gmail.com>
 <xmqq7bitakkm.fsf@gitster.g>
In-Reply-To: <xmqq7bitakkm.fsf@gitster.g>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Wed, 4 Nov 2026 09:28:40 +0530
X-Gm-Features: AclHuK9tudPBHebKJs7AF-sNWsjYUSQOYUhpxDHGeyHY7GrfP5EkLvRvmQo3_F8
Message-ID: <CABh_KWg9bLLc64_UORHfLY3vhVSTfzN585fcQ9d6w8cZocGwvA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] t4041: test SHA-256 submodule abbreviations
To: Junio C Hamano <gitster@pobox.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 11:01=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> > The expected abbreviation for a submodule commit depends on the
> > repository's hash algorithm. Use test_oid_cache to provide the
> > expected value for each algorithm and remove the SHA1 prerequisite
> > so this test runs with both SHA-1 and SHA-256.
> >
> > Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> > ---
> >  t/t4041-diff-submodule-option.sh | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
>
> It is strange to test SHA-1 in 1/2 and add test for SHA-256 as if an
> afterthought in 2/2.  Shouldn't all of these come in a single patch?
>
> The change to add the second hash algorithm support is surprisingly
> clean, primarily thanks to how test_oid* support was done long ago.
>
> > diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-=
option.sh
> > index e80472af32..4539d6bba5 100755
> > --- a/t/t4041-diff-submodule-option.sh
> > +++ b/t/t4041-diff-submodule-option.sh
> > @@ -14,7 +14,11 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> >
> >  . ./test-lib.sh
> >
> > -test_expect_success SHA1 'submodule commit abbreviation uses submodule=
 object database' '
> > +test_expect_success 'submodule commit abbreviation uses submodule obje=
ct database' '
> > +     test_oid_cache <<-EOF &&
> > +     submodule_commit1_abbrev sha1:0000000000e
> > +     submodule_commit1_abbrev sha256:24c81a5
> > +     EOF
> >       test_when_finished "rm -rf collision-super" &&
> >       git init -q collision-super &&
> >       git init -q collision-super/sm1 &&
> > @@ -27,7 +31,8 @@ test_expect_success SHA1 'submodule commit abbreviati=
on uses submodule object da
> >       git -C collision-super update-index --add --cacheinfo 160000,"$co=
mmit1",sm1 &&
> >       git -C collision-super commit -q -m "Add submodule" &&
> >       git -C collision-super diff --submodule=3Dlog >actual &&
> > -     printf "Submodule sm1 0000000000e..%s:\n  > child\n" \
> > +     printf "Submodule sm1 %s..%s:\n  > child\n" \
> > +             "$(test_oid submodule_commit1_abbrev)" \
> >               "$(git -C collision-super/sm1 rev-parse --short "$commit2=
")" >expected &&
> >       test_cmp expected actual
> >  '

Hi Usman and Harald,

I wanted to share a progress update on my Git contribution.

I have submitted v5 of my submodule commit abbreviation patch through
GitGitGadget.

The latest version incorporates feedback from Junio C. Hamano and
Okhuomon Ajayi. I combined the implementation and SHA-256 test changes
into one commit.

The targeted test suite, `t4041-diff-submodule-option.sh`, passes all 48 te=
sts.

PR: https://github.com/gitgitgadget/git/pull/2288

I will continue monitoring the review discussion and work on any
further feedback.

Regards,
Srujith
