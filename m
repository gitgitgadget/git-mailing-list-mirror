Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795285886;
	b=CpSCRC+KiE50Hu1skrZMMGCxvTO8TebiGA5TNv83bl+EBCb+dc/pw3yffKD3q+7GV/OT
	 G7Q2jqERb59v68YyOgrGkrWA5S9HojeRRAsMZV2B49omGGbkyjBx+tsJG/Hz2oFpbF1EF
	 cANd18y8OU+cubWJpjNzciPfqy03LO0ILdEsz7wA6dMSyfx3trJ7AnxRupoDr2w4wPpYU
	 ee5IP2M66x9v0S/rr14GyPDQmIJ4c7T1h0k36JMUeB4ImR6OMyjMRvyj4bbe/Vcvi7E6o
	 4Hf5hkMo9bvbjQnwoEedqmRhINSt0PKfydWeDDmOH/ZxIVItnywqMvOvPeS9mAwpmOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795285886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=G04KAns5rke62O5EVuy4dcF+JUJiYvja7s5bgOvkfgw=;
	b=gz0p6D/guCfcAdWhOrQRmpAfkNP4GH1FWAJzUGN0HqEBtpTml4hwwIZG6H+kcrBkaiZg
	 VcAh+q2tyAtftthA5cwdanAm1Gkw5qUCM8uMiDByl4Qgn0j9Cu/ahbtOV8Dww6zWcw6Gx
	 Ka9jOv/x9B2mvQYWUgzLY3TGtqas76k+KLAUWtcy7qXsVBQ1vZqADHc+z1LEEIZMT5sOA
	 YxcY62Z3mZxPWWLH37/h57sTYAJd5s8fnkT8DWCGNy1D9dKSY2Uy66kjU7rs/OayWHWUY
	 dOU1x/qiaFJEOG8sYwQ4brvoFSNVjeuZxEoJ0FR82J8cGv9OCSQFSEc1vnfs+EWPOJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=elk3oJIo;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A789D606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 18:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A789D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=elk3oJIo
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-943e8d35f74so206793285a.0
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 10:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795285884; x=1795890684; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G04KAns5rke62O5EVuy4dcF+JUJiYvja7s5bgOvkfgw=;
        b=elk3oJIoTn3ly0ZKoIvHSROs/3FVTAZqFRYN00xf2c3QMwp2sjGUDwwV7R1r0DvB0V
         jqvQr/1GvqDlGCtAgy+f8o+/mSOwh6ob3N6bs73dDjm49zHCCqPRRFraauhk6tPsUeOG
         q9t25679XaVewkGDiLb7LgDiDlYeRxODWhwhV7EKftY5poEwO9pPwMVhbBrLFncdkkb+
         nDqxdvyaw7c65ZSnUjOu6oAWEMfFlMrggegOmDVZpe0iliTooQqQoZYrFqn6y3MoRSzY
         /YQmaID+66OuTuUNHtHGtH7HdWEb9Vn2HVlpsTurAQVSgbXl+ebnvV8MmNtiBM1BUgZS
         9gGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795285884; x=1795890684;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G04KAns5rke62O5EVuy4dcF+JUJiYvja7s5bgOvkfgw=;
        b=bio7zZ5eWgIjCH0vvP/sqlphDxO2npZD7KdS1r5A71IQY3rKP/yoP9yM98Hj3j5rSw
         Bw04lME6ylKpP6RZ7eICb5Zd9xZjJHU5BN9j0B+H+Yv8DnF2kKVRUeGke1sc1uvBo175
         rS8TV5VGV3X/1sZb+LK64xxoKXp8wg1wPjEMshA9JEN/cHd5tJ4spHZJ32tqEr6e+4Zr
         3V0MxcY4BK2DtCwoVTPbP3yudd4YR1fdPaCTs0TAqC+xa0uEFpKhZyxAcfRWmWb5PYX7
         lfYYE8Vu4eAcoERordPI7UomtheACe2TmjGzo89E3DPHXT5cLbfUsFgIV+iQEc79ipfp
         pSFg==
X-Gm-Message-State: APuU4Z/53BGdyMfyWjismVs00jYIdjZf9PvZvCZXTpiklnjfd8EVr3dY
	VDd7axTQaP7jRzm9XQqlll1h8A8kpnBO+bXvedSzn5DQrERD+4UKveam3ptqAw==
X-Gm-Gg: AZFdTZels7o5PxCobPJZJvfxxdiYTM6IHR70HxgGIOtD39HscJRcZ3XzwcJqp3LVPwx
	ICL27V7d25VL/UkiL5ytvNEP2+J8/dWndaGrId8n8yLFm+9IWVgmqeKdjVm9USC/doF89RmXATh
	qRz6CsHc0NwCSuJaoBXsV7UlOCl72FowRRaMd7f5xfwLjzKghEmDvRzf6xnfuJaZbyGRbxnnyVi
	G47u4lwRJeDPjMyM8pV0oBTsHL95i2A10kEIBJzgI5Yg1rNqSCLgMJ7zzNocaA1GCS3dX/bd/03
	FYbniP7gHAZXZ7nlRdqaE9UxUj9+yE4Cf95aTS9MQVwFt0kBXLhRfiJwikm1cAQnTx23Jez3WU2
	IZ61T71eoO6R718oI+n0FXJVivXh4Rw4q6sbjdZIOGAgMELjYXw6isHnTShukeo/n2u07S8vLYn
	/JBbHwETpFffJVKqWm82KfloPg/MCBUU6786aA/PWOedA9h9VcglI6TbzGu1xrIzhVvpD+rA8EV
	j4j1Qnd0dfvLtokPkGnqu6dsVeIyZTO2XKshOVYjlUqafh64A5gpyZ5ychmHswLHf6Wv1iC0njW
	nN3WKUd1KnzvXn1P3l7BBqlFLgWd4aJUocbqUs+vHYccHod1wNodurTwXYysHGcDYPSxyTyQNX7
	YR1GKdkz144KXk4ZkO38lgKcwOQJrKNf0xoTCr/R/qjjMcpxvtLbs1RRXve5EP2DZL4cahlBBil
	OzGVtRihcTE6pamH4kSgrAb+c=
X-Received: by 2002:a05:620a:468d:b0:93e:d051:8f19 with SMTP id af79cd13be357-949ba9b3950mr1153997685a.40.1795285884380;
        Sat, 21 Nov 2026 10:31:24 -0800 (PST)
Received: from smtpclient.apple ([2600:1004:b057:bf26:705f:354d:1d09:cc3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb0315f4sm463733785a.3.2026.11.21.10.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 10:31:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] setup: fix incorrect word in code comment
Date: Sat, 21 Nov 2026 13:31:12 -0500
Message-Id: <99FFF51E-E7B7-421C-9868-8D93EFE633FF@gmail.com>
References: <pull.2500.v3.git.git.1795282558789.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ophir Bleicher <ophirble@gmail.com>
In-Reply-To: <pull.2500.v3.git.git.1795282558789.gitgitgadget@gmail.com>
To: Ophir Bleicher via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 21 nov. 2026 =C3=A0 12:36, Ophir Bleicher via GitGitGadget <gitgitgadge=
t@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Ophir Bleicher <ophirble@gmail.com>
>=20
> Fix an incorrect word problem in line 271 of setup.c:
>=20
> will only complain about an inexisting file.
>=20
> Change it to 'non-existent'.
>=20
> Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
> ---
>    setup: fix incorrect word in code comment
>=20
>    Changes since v1:
>=20
>     * Update commit message from grammar to incorrect word
>     * Change word to non-existent instead of non-existing Changes since v2=
:
>     * Really change word to non-existent instead of non-existing

V3 looks good to me.

Seems like the formatting of the notes ended up a bit strange here,
just something to note for the future ;)

In a similar vein, it=E2=80=99s a good idea to double-check things before=20=

sending them out to confusing readers with lots of slightly-tweaked versions=
.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2500=
%2FOphirBleicher%2Fsetup-code-typo-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2500/Op=
hirBleicher/setup-code-typo-v3
> Pull-Request: https://github.com/git/git/pull/2500
>=20
> Range-diff vs v2:
>=20
> 1:  3b7539bd5f ! 1:  2158470090 setup: fix incorrect word in code comment
>     @@ setup.c: static int looks_like_pathspec(const char *arg)
>        * If set to 1, the diagnosis will try to diagnose "name" as an
>        * invalid object name (e.g. HEAD:foo). If set to 0, the diagnosis
>      - * will only complain about an inexisting file.
>     -+ * will only complain about a non-existing file.
>     ++ * will only complain about a non-existent file.
>        *
>        * This function is typically called to check that a "file or rev"
>        * argument is unambiguous. In this case, the caller will want
>=20
>=20
> setup.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/setup.c b/setup.c
> index cedc031c54..3aaa1b65b2 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -268,7 +268,7 @@ static int looks_like_pathspec(const char *arg)
>  * diagnosis when dying upon finding that "name" is not a pathname.
>  * If set to 1, the diagnosis will try to diagnose "name" as an
>  * invalid object name (e.g. HEAD:foo). If set to 0, the diagnosis
> - * will only complain about an inexisting file.
> + * will only complain about a non-existent file.
>  *
>  * This function is typically called to check that a "file or rev"
>  * argument is unambiguous. In this case, the caller will want
>=20
> base-commit: f7de81456940dd6f3274e461149bba12965de609
> --
> gitgitgadget
>=20
