Received: from mail-dl2-f33.google.com (mail-dl2-f33.google.com [74.125.229.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3DA4C9E1B
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602893; cv=pass; b=uMPFoggEfFD4lwKo50lIsnB3rrgsFEVRfRiKvCVu0PrN6+ezJ2/JcEeP7HjNS9O2m4eltl9BBFhkGdQz2TMgWptVT1CU/W601aS2pCsRd0capgkjX79fXDlUWdFCin/8wmPoI5I4EBNsPKAN1YALxRpwa6RT1c0c1RX5HV2u1wI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602893; c=relaxed/simple;
	bh=IMDNFEw2n6/AHqgAJqPWuVQwyPUyUy6+j4x/U48hiew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkgeUSW+3q0Ca9YkLABSoiS4pVZKTaOjgoAasSnG5R3fFKwA/HAGGymRoMRuRJwgyrDH/JPwEZpbzDnYrqVwfS0pWLHMUGkV+L5scIF6TfwVvjx6dDt2x09HdIdbGE8n0bCSCMgQI/dcNBPyzSFKOyEII/mZFiAfw6k1UV/yFhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHBNn3GA; arc=pass smtp.client-ip=74.125.229.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHBNn3GA"
Received: by mail-dl2-f33.google.com with SMTP id a92af1059eb24-1438e88300cso2672348c88.0
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790602891; cv=none;
        d=google.com; s=arc-20260327;
        b=H4rRql3iMu+pQ4LBCTfumwsUGCq/x8Pyy8T4cQz/MeQv8KYwXZ5rmX3SUeP7iL3Pzr
         eSqduoSmuiBsxvKxkhAiPVQuyOwnfiRX3ChTegNDxL+6L/Vt6LQjztQNndF4RY3l4M9j
         Nd3K1SrVr86h2UemqrGyZpfJVS2yzEuYGgeZBE7FSoQDiGGWm9zLdw/Sz10aeMfa3Ah3
         LuDbLgeCFfWpT1c20iQOQKrAk2Vv/4Wc27ctx7Z06FabjkFshtctdV/8R5yZEg1Uj37M
         6m5cN0EpmqYu3pGKH/dN2sSdk4lHjGIb7zm5Ub/VJdRB52EabAnLvkBopRagbHu3K9BV
         tvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WGEydU3ILkskdRQq4f8jBSSGrBrB3mCaSqIk9xtOcoQ=;
        fh=5nZn0HRpP9ZszniLRQU6Iy8lvPX91CYXGnNouZ7Jmpo=;
        b=Dn+oDzWrX8+v8GtLNFBdTh58jk8LeP2V/xXwKkASle8P73VFgy0oec7OYhdXPaj91k
         RCv1eCqRi9awATjEoienMdpOFV+junOJ54hURtVRPrzyiQnKi7aVpjOihQ4hQEfg+r2+
         hK3Al3QA+8WU9RNpQ94AJ3YCqGYYh5+OSjaebGZ7MGlBKGRp45d9tvhkh/SpWkoM4okn
         /jRloEhtaq0LKiXW+5YCm4Dg+zeNK1tEeLNKC9NSK5YbSohnJpF1cbTy3p23gSbTsfsx
         z+2I6ZxrUNEk95eBwQJDET5LlfC2misr8cILHmmzRzNcaqev9t1Ad3drFRaiyS95NRI+
         +ctw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602891; x=1791207691; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WGEydU3ILkskdRQq4f8jBSSGrBrB3mCaSqIk9xtOcoQ=;
        b=gHBNn3GATgVtYL3tDK8JL1KkoQIWsLs8yKyvbt7/VOp2mVsS1jWxp5rx1q2tSmsD6f
         b6eE7s4qb73Hx1qZ5WOWO8QcveHNvXkhajL9N7zav5umb7I40tSDHM8LqiXDPRyB6Jo5
         DAk/+6u2deGCMx2VeV8senuB49Ld7pm5pukQwiT+bXaGacFEo4ELhufKClGFc85ct6v0
         PqfR5kj4ydYei6Efnckmwztqwqhg0yD5cobtQ1xMQtdQEUsyceNbOmMN4UYmZ530W0CX
         v2DSsUZ1IkA0Fmxt4/oOWHkZ3QDm5NwMlR8TcnnE3Hcs5lF+t4/TYtPul+U3YzTI1cQf
         S0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602891; x=1791207691;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WGEydU3ILkskdRQq4f8jBSSGrBrB3mCaSqIk9xtOcoQ=;
        b=mwROz2bHyVjbSETGckk6Tc1v356iJHVOX9tAFqHMJRgKoTJIIIl6WEd9O9m3pRF1Gv
         4W+qcgh+BZ4egE5JJW0l5uV45Yv9fR0q5Im/uylBpvbvefhGzEANGBCoJZiKc2RGXARP
         4/Z/qeQ8zo3ufLpbow34tKP3K+6tPXzm4OVd0xeLeSL2qFlPEGwY4EnyUyIisxJyeqSd
         CQEI5KJDMPS8YYCiOK16s+AnFRMxEQ+wT2t0qXtxPpn9Cvo+nurhOoggqZSvL1AZp7Rj
         206Gx6/O9lyfIKLTQecs0iFdtUIh9Mz4Wz0FetCJhkN1+Dmm9eH34iUCWD99W0EkTxd/
         /8vQ==
X-Gm-Message-State: AFuF++kwfPqSZ47T3Fw6hAt6Ql8tx77vfiJYqE3xxQRrPhpC3gNkBkd+
	KQQKSOvbfGq8c9lp+cGpipgwTfhgm208BjXuE321hL5Jex//RFqMiWX7ZlUXV4xeRrv91MZouOe
	fHsHonKSO1xnASsXxK1jjtcg8gywtRDgs0LP+u10=
X-Gm-Gg: AYBFou1UoSI2agrNCHPl+dYvY7fSQXn5r+6HFkxxyHGkXYkElQIEYpYPQrFndKXVuIt
	Zfo5u4gsK1Tge9m6BRQUl6D03oiBYG9TWn4chhO+3/JZaV3bt/jrBeVs3Omw/gbZ3TysvmvlRUp
	7CbF9W/7wEp+PQ4CGrbZkGFroTNGYykpENxqvXPSnsJ8lsAWag3tyntRoI/VirxMYH1E/2utwAh
	o3cYfTttDbGw23LPadjVk2zgZQLg1uP5z4iGxoxLOlE2hKQebDd9eeqcWgU70kesJnVi9LDUQ/L
	8Kxeto3w+L6a5p5qWHbF2ULKwCM/fLp3+zC3WP4EbKyj3xuNAIDkmgEe1To5cXk8cA2cQU9gHJ1
	/3asqd9JW1ak1VkVBfmFaphvpbSWRsQvuKRlK49ncUS8aL01iGEUfJddMrkIeyvt2bqw+qfztIx
	9cnK6CVpGizMt78LlojGPVg869bwmTyakesG23OQc=
X-Received: by 2002:a05:701b:420e:10b0:143:4450:e1e6 with SMTP id
 a92af1059eb24-146d039e6f9mr9732470c88.35.1790602889966; Mon, 28 Sep 2026
 06:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813154748.2378747-1-christian.couder@gmail.com>
 <20260908164129.560396-1-christian.couder@gmail.com> <20260908164129.560396-5-christian.couder@gmail.com>
 <xmqqqzj3wr24.fsf@gitster.g> <CAP8UFD0WUQX4ts_US2Ehdp7hBmEs1_ztjJiGJMYA2ek4awduMg@mail.gmail.com>
 <xmqqa4pqp0j2.fsf@gitster.g>
In-Reply-To: <xmqqa4pqp0j2.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 28 Sep 2026 15:41:17 +0200
X-Gm-Features: AclHuK_w2a8ChVukzr1BUEcCUibDTs3eB8xGWZWfkeuZvzHBlLJpnFPY2JPJsfc
Message-ID: <CAP8UFD0iuUEBgUFmH0yK34THTXihgC1AACH3Qm3xJcO3ZunzkQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] promisor-remote: prevent infinite recursion when
 lazy fetching
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 11:39=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > I agree that using a plain "int" seems like the most straightforward,
> > but we don't have git_env_int() while we have git_env_ulong().
> >
> > So would you be fine with something like:
> >
> >     int depth =3D (int)git_env_ulong(LAZY_FETCH_DEPTH_ENVIRONMENT, 0);
> >
> > which is similar to the following in builtin/pack-objects.c:
> >
> >     name_hash_version =3D (int)git_env_ulong("GIT_TEST_NAME_HASH_VERSIO=
N", 1);
> >
> > ? Or do you think it's time to introduce git_env_int() in a preparatory=
 patch?
>
> There are 13 existing callers, among which one that you found
> explicitly casts to int, but many others make assignments with
> implicit cast (e.g., members of bloom_settings used in
> commit-graph.c are of type uint32_t), and config.c reads
> GIT_TEST_INDEX_THREADS into an "int val" with implicit cast.
> progress.c:get_defalut_delay() does the same.
>
> So I would say that it is up to you to pile on existing technical
> debt by mimicking config.c:repo_config_get_index_threads() and
> progress.c:get_default_delay(), or audit all callers of
> git_env_ulong() and migrate appropriate ones among them to use
> git_env_int().  From my cursory survey, I suspect that not many
> callers of git_get_ulong() would survive.

Let me pile on existing technical debt and explicitly cast to int with
the following in v4 then:

 int depth =3D (int)git_env_ulong(LAZY_FETCH_DEPTH_ENVIRONMENT, 0);

Thanks.
