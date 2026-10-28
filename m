Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793221082;
	b=TFEyPoKLjB8Cqxl1kkNbVXiVBLpxEiM4ZEowS185HCHdJIU52tSU08fQ3OCTjoSvuph8
	 qx4EDWDwAg8hwdITwbuISpRdHIxiiIGW2ujc8tfTJJ1BJiGKpC3TQWUrsxf8SrPBP9aVf
	 KtHDAbQ8qgmtxIqkMvoyXcISrtOu1GqcPj9zcWDgLEQQQdsJB0kPfIDPCk3Ro2e7eozno
	 JssvvqGoRWCZobKEnsAvNtWm+Ao0sGZJw9YFKKTZ1ja/nzhQ3yZ/XWu0s+b+RmsfT4RZV
	 7AqQP47QxW6JXBG1ZkdDgWkeBbKhtc6ck89UiS+ADowAlx5MwWZqRcTFeDtSAy0t4vw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221082;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/y5D2u/b5pNrnLK+PRRIxd2bhue5gu2WWC785GiHdZw=;
	b=Im513ENRgISksEtY1l0kHlz3XkIgXsu2Qf4wd+HOyEW+C8osuDJRWfgeu1Qdp+mBpUik
	 Lgx78+fTPIKBwF0qyBfB316gXrjvfe4waQmr9Fuur91E7cmKWkJm8udccvoXd3r5GnclB
	 ffaNu66ji8h9N3k47geTDAwtP8NypwsWTPnCL/rNDRZFAEqGVrYsoDT+EFGtiTnW1WOS2
	 Q7JG2+wl0zkki9x0sV+r43H+ZbXoyFe1fvIXq2SOBX3TqTa8G9j6TYJHsoT908tBQl4pB
	 pIvgYqjEVIUMRw7hIO1WP7s4KSo1HsC4NxpQJs0jejJszt/mFU8HFOXobTrRdyj7v5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u5MG6OiZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA581606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 20:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA581606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u5MG6OiZ
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b47c1a3c74so2003866a12.3
        for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793221080; cv=none;
        d=google.com; s=arc-20260327;
        b=WvM6vJQifwjD4myDZATqCZvfFk2PKDNxhKs7xNmgz/MwC/xKkO6S3+8/8RsAYy5VPa
         v5C72D7U+w2q9zVhhKoXWtdqjAHPo/as80eTsnRL3LZhvJgxjeqR2Vlkcg7LdrC6n4vA
         CHkC9377rNjTeNiGf3ZWrnrCj8DTfFHVldbwBNdPISpQ0Z971DVJBtIAHsjZy02BSIJL
         fgrglngo5utp3buzPRd2YxxRuiFhq6NoP4AXrr/NxzLUVAWqfY4WYzFe64aI+z1msKfW
         pEsAGTnBZbYg79MC7uDBYVSKt+j2jiXfRJOH4Qpn0xgXDZd5fGUMzvAB9+CNANeleOmp
         RYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/y5D2u/b5pNrnLK+PRRIxd2bhue5gu2WWC785GiHdZw=;
        fh=2HrKvCXoQx6TsRus8Ank0wmERSvXtzUf66E+Sda4RKg=;
        b=Uez/ILnYNOM03XVPuqEJZOkXNYnbiCz11h/k1amLRrQcwHRZMoZXfncIxAdxkG6d/x
         32evKglnREJH06Sqsj1lpNuKltpucvxLJGvR6O+5M+sffN7e5WjH7dIWjhEs3kfUOuij
         Kyb1krbR+8cwkkYbpvH6+KTVZRBE590vAo9zT0saw+iOgTfJttXvPx80yZfML4n44/xc
         cGtNszRpnwxBZ6358McsVovg3Pofao7r8YsDMxxKMcodSHfz2ObJSsi/kYoGkMJixwbJ
         lSekp+LYO3QppD6mb4Qe27ymRbWQaykITA+vF5xRW/LOc8bRemZfqduQJsQaSbslF7G7
         lNHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793221080; x=1793825880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/y5D2u/b5pNrnLK+PRRIxd2bhue5gu2WWC785GiHdZw=;
        b=u5MG6OiZre7rkKnyy9UJCBjjhxy+2k3M+AnSgv1XXsvopezNdPXCtm6SAiXnpT0Q3w
         PXFwdHWzdcFiEBq7bqGT/w3E2zpm2ogLSIps9qtj8V0aebrUQj7v3EiOeqOcq6Kxblpl
         3icBzXcZ0e8bHqoVgNTtxUz1vxJ+bfW4YNgQDjfm+g+/zGzAy2plWCH1fTFJj5l1S5JS
         ngL3IboNeAlkH8ki9Zb3IG7UVfHBksNfxHKGd0et1gGqa+nMZFGr7cRndkK0rcYEkkgv
         9Y5FfosiVvz370GlhxMeZKg19azOSE/QkHW+U2YJvEEWC4+5Z4WHIrMtH89yRy0Hrmer
         TGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793221080; x=1793825880;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/y5D2u/b5pNrnLK+PRRIxd2bhue5gu2WWC785GiHdZw=;
        b=U42wPnA9+mNUlwCf39xDBpPV+yhCiXQRxMILzOqX2YjV96rvjTZ54th4RIr/PASUAn
         dtaObcnQqi1hAoAhUnlGwRvFIE6Rxbe7o17qAaKp9GqV816vFMiKZrOkDhvpqgo9ADqt
         f/4wl8Yz0m7M97tp/aoW43b6DYjsu0rC6LfSQfr6ZYJYhHgA2bAw83zT5FjBmk77oxxP
         6f8RChD2TuZYbwTLZUUfUNTQ0jvRZVNASB3nuo+yP0o0SyAVVXzQD7gKqsIwcvVaQdDI
         SZtZeZPbFAw77/CANhBWOTrDUyjlFBVL0N3e3/V7hskQYXiiEWBHH9KoimW6lVjHCgpL
         8wDg==
X-Forwarded-Encrypted: i=1; AKwUvBwCsFaM1yjrtFCIwsX8olDU4GntK+Bs/jS2xEM+9PQJ+y6CgBYKYoYDvsmTSj30h6jIrB8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBLxASZuillTwuJNbTj//A9VlE7PAhlwydQ9qx756AXNH9o2dJ
	UEer6/sghJ8FaWeQuWHm3btH1JKAgccg+20GQHG2sw+0H2++TxyFVgkO0VV9O8y8S8MFmOVlDqa
	uGlk7y918NhPobW1nq2u6ePbxBv6+diw=
X-Gm-Gg: AYBFou0sXOd20rOdtmslsOY/DsEiNrReSMZv0/RTqrBmlvLG0qxrOJRh0h8M8K5jKso
	Kpf5IxpBSXsjtuVNktxGYGASpEpI4o6PcmTlmzUDs+M5W4Jky0rieQlC2KOhrdOf52OZWAlHjkb
	wnM/Z36qVBz+URqPxobCsQQ2cw1Tnl6nk6A4SB0eJ16tImjgfdAKw8UP8sugu0VAhaKHPXQNJ5M
	2rV9kRen4ZyVH8ZHfqWdQea28lbdz8gliPmR52sW3380gT7DCUtMPebZxIBGoDvM3zUI1woMdUU
	XSnc/NBRS4gHdi64553ECDqbk+xBvQ1jDnu3JtjfHgHQ0pnb8gOaKkYtypt++yaY3plm+peSwBc
	hp9foSKILwde2qznJfqsYGS0ZFKVvV5piSCYcsfmBH7jqlqNOM0vBhfAqnuhF2LrjRaW5OA==
X-Received: by 2002:a05:6402:a14d:b0:6b3:d0a0:39c3 with SMTP id
 4fb4d7f45d1cf-6b4b02c4725mr534172a12.27.1793221080112; Wed, 28 Oct 2026
 13:58:00 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
 <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> <ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
 <CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
 <CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
 <CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
 <xmqq33ttxw9h.fsf@gitster.g> <CAHwyqnW=W=XnRs210h1VxA5KWxdObwihCty6Gthiwh6+hDkD8w@mail.gmail.com>
 <xmqqcxswtqd0.fsf@gitster.g> <7438f8e3-4969-49a9-a0b0-41520ee35aa3@gmail.com>
 <xmqqbj8fm54y.fsf@gitster.g> <241e7bbc-7144-4ebf-af76-84a06a982574@gmail.com> <xmqqld7hafhy.fsf@gitster.g>
In-Reply-To: <xmqqld7hafhy.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 28 Oct 2026 22:57:22 +0200
X-Gm-Features: AclHuK8yWl7SOn8i95D3IKhySVD6suVPbLDCxrYKswVQ-JSAZmYPdXaYB1PS1Yc
Message-ID: <CAHwyqnWyFe1Ep_0wqZqTVg+2tQvpt=i9zyRutV=EZkvPt4Xr8Q@mail.gmail.com>
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 7:42=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >> I was hoping that with refmap, the users can tell the system where
> >> to store them.  As specifying a shorthand also works,
> >>
> >>             [remote "cabal"]
> >>                     fetch =3D master
> >>                     fetch =3D next
> >>                     fetch =3D seen
> >>                     refmap =3D +refs/heads/*:refs/remotes/cabal/*
> >>
> >> would be an easy layout to allow adding different branches than
> >> having to say
> >>
> >>             [remote "cabal"]
> >>                     fetch =3D +refs/heads/master:refs/remotes/cabal/ma=
ster
> >>                     fetch =3D +refs/heads/next:refs/remotes/cabal/next
> >>                     fetch =3D +refs/heads/seen:refs/remotes/cabal/seen
> >
> > That makes sense. What should we do if "remote.cabal.refmap" exists and
> > "remote.cabal.fetch" contains a colon? We could just ignore that entry
> > but it might be better to error out.
>
> Possible alternatives include
>
>  - giving fetch with dst take precedence over refmap
>  - storing the result in two locations
>  - error out not knowing what is the right thing to do

The answer seems to be the second one, with my v12, and I wrote a test
now to confirm it, I can include it in a v13 when it's time:

```
+test_expect_success 'remote.<name>.fetchRefmap stores an explicit-dst
remote.<name>.fetch entry in both places' '
+       test_when_finished "rm -fr fetch-refmap-upstream downstream" &&
+       git init -b master fetch-refmap-upstream &&
+       test_commit -C fetch-refmap-upstream base &&
+       git init downstream &&
+       (
+               cd downstream &&
+               git remote add cabal ../fetch-refmap-upstream &&
+               git config --unset-all remote.cabal.fetch &&
+               git config --add remote.cabal.fetch \
+                       "+refs/heads/master:refs/remotes/custom/master" &&
+               git config remote.cabal.fetchRefmap
"+refs/heads/*:refs/remotes/cabal/*" &&
+               git fetch cabal &&
+               check_fetched_refs <<-\EOF
+               refs/remotes/cabal/HEAD
+               refs/remotes/cabal/master
+               refs/remotes/custom/master
+               EOF
+       )
+'
```


Harald
