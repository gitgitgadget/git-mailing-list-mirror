Received: from sonic310-14.consmr.mail.bf2.yahoo.com (sonic310-14.consmr.mail.bf2.yahoo.com [74.6.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F533199E9F
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 14:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721918426; cv=none; b=tHvIOdP87fCBdJNCSfU2TwvKpCX3qJgNPurU+7qPop/D7QL9y463CW8SLrCujaGLdcSrYBKOZgY3wc1RiOD6g090Xx447O2lqcH8xNp/TwhgWrmHMH4QHHe7Wam+KGxu9lOOFsXbI9Y0CjnMOXn8EG280AeuIS6F3b+A7loxXPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721918426; c=relaxed/simple;
	bh=B/Aq8jKeDa/YAPsLn5W7I7I436fyz3UwOHCfhyUadeg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TnWrm04LOIUCmMOj3zEv9HkL3VyI5f/f1YAKEqUT3AbhzpyRWSz48tXfbqIO2mz1GWjkTNyICV6UQ6flW5bHeG4X4g8TAt/Ttm6GbHnjbN3vNtcWRSnjbn1k0PJiPNfY7/Bvqom6Rj+wRY/HdufWfu2L21l5tZwz59Oi2WH04oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=swJuS+DR; arc=none smtp.client-ip=74.6.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="swJuS+DR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721918423; bh=B/Aq8jKeDa/YAPsLn5W7I7I436fyz3UwOHCfhyUadeg=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=swJuS+DRskPbNjKqnlkU8CwyBcaYl4I6ZuzoV6bsiceu0rfaHyJyGqcO0tMgZCxYOASwSjMci0uYUtqSE8GjCbZSAaavo3GxtJXSn2coHdjH1BnGXSRhQdZWcwMsPoS6Hj0iYpviQ76bdGzrokUqoxq77SB/CvMZNjSv9q7AEPK7YZgee92W5AE0vUDWZ0uR2kxX3Ef6vDb2nymiauB0uIRPFIRbxJDbQ9O8ZCpkawzENdHDJSeGEvdaxwdZQUxpp+XgcO5GMVrFvoZ+miez5vR+9EdpOBLX/YHFzfAOrGpOdKG5Ixr3mZI/5a1HZzYljnxLoa31LzuUY7slEZdrKA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1721918423; bh=ZlaZLvcS3zS8B0JmE77ScEmDS6h6/eqQou07AqMYDPk=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=trVgqbNGJ+F3Cilncrw2BKBt/xb/Qv5lMnOjStf1zNGrNa5DWrmcItjafkqWBo9fvZ615X2Qsoo8H5CSHXao4nSZ7jUkOQSZC6uYWk2wmapdBdIxCYfbsRCShxBom3jI0jYVQkeXmCYgXfYC5X14dn7n2cHeF7JydrLMfSY8fl9EHagHEKKQ6QibmAaDYjZn9k7pRWIECEt1bsocgdEdVAOaAzDhHuTCAjFidEu6iwyUDAePRSLz+HEMhLaf8ZDssh9n268VuafStPNpseWNYkSRif8ubFhRYd7fidWHOuTplxUFAUae3zcoXeOnC6VDSGQuUTQZpVIQ4UdFS3qOvA==
X-YMail-OSG: 4WqkhNYVM1n2ia8QVSmlHVDdcRigfvDhY670wptG_mBARrLHMOgtBVTRpby.hZW
 r5gY.EOojpK8Koaboxi1QrQxBTbqzU6hrcxEX5KyvFY7L8ZTPB8i6LG30THW5pViKWQYZ3kVVlZE
 OYNLh7fO6yY0_nh0SBiDN7xiCy0YX55UKjiqWX9tn_OuvFFab4ksxGCGHWTo4pRsnKbtxWllFSOY
 OzlmC3kWpJR97xeA9aX1oMcr_iXJGUtkdIJ15Xs2ccltsS0Prs2dmwtlM8aX8GviQOJIQE8CCFkS
 n4c_xh9TEafmjAIZHiawp8ZoO_Yg140Mnq.K_krBr4ASUVwYAQbK5TR_xt0jkowEebsd1xRVaBLd
 TvHij6ZluZCRphYZFzV0V5DavwUojfRiNR5pQbLNroxqa8DVohFJwqE0ilIiNYcaX2wPjNphDLei
 EssaNSBJx5dAE_RfGwCR2wvBKr99.4zRURsLZHdOgge5XP0I_ExVvt6C9WzYxsOxdurUZI6Pims3
 7rjseteDEzA9QBFpNCCHYZHEJp4Lj1YKOEs1bj5hEwpe.AOHKcAffKqWgBGcVmZa_C82x2m.1.3u
 b_9Nx9zzRMB1iqNSne9FsD0DPJr4vHTEncfCc2cwyJG__b65a1z7zzW9fBKmZHHw.nHRC3pNII_J
 FvjBVoCwKkP54cMHtyydjsXnxFbfBEgzwSZH4O4eqYB0wrNB.Zh_w6DMv5brn_6lrQaf9TopGHx2
 H7QQHVKaflPsky2UFqaP.6c_xxmB5m_J5AnYHJ_GnyMtuY8Qlfh1gb_WyzkxY._hJx5xtaJW.eFu
 jtNTuk8La3h_tLSpjvDiHeB3FZytcWNkRaC6lOFnk3vi9iv9roVei1H..sdNrBFU0GEZFhFDYNaN
 puaZO0.wzEyclw40Y_fvAUCN9H05U0mS.LLqxlFhAdQ76ruAfndILB9QRu68dhuajwELDYDx8PvH
 jS3A5dZv6inWsb5lYheIn9uiyIjdlZ2kbxyez1TnQjG.19g.6KuW2prBdCS2aY1KAPzYc00LgEER
 k8SFYjvtFyHLFR_t9TG13C4c1VFPnt81GriwOfBK_epFudviVi9fmVDhuu8bBc3Po2sjjfzIrltF
 Y2rRYw1hjwKwtdgcAWPcR0ChnYCQeC3tFO39tYg9VmyDkinTf8Zc1x2pdk6DcGhA2i94plqktoA1
 AaqouP3J_LMBx5Nb9H_VJleGHRBn8ZQ_fHL9x8e.iSjfQ8YCiIEWP15m5C1BMICYBkVFHexKHRdI
 xediffLiJ5mZNYVBOIe4B1KD6F.jdhJFxJz4yfrqWiGuTVq4UuNDgQ76nfoQkY7Y1tYgDbsPbinm
 XWw1WvWLVNtjGisuVH6zy9Jz9muasCmOkLw_MKBVxOz1K5MLLGt7jpwMz4Zzul2TKyLjw_yj9jQd
 V6TIJ.NIeIzpRMAtticCq4ElOjtAMvYxU.YbP_H5n_xVWKNdw5vy_0gdMAZ82kMbvP9O9MhGOG5t
 .jhMf2aaUjjWLIqEjd_MCkit10p_IG2MIrOcux83Ib332lBjms6UjuB3ch6baOVxDxH74oztKqA7
 B4v.zdT05ascgDRMBNxSZx0klTiVHUqx7SZKHjzCh3VAabMu7Ba.eQA9Yp8h.1AJvutptID4G5rq
 Zi1PpBg2hj5i0494E2qT_sMbHL2aOSAVpMakfxwmnFjKw8FW4m.d6YjR8VOh8x7O9TOPAbNgniwM
 QRzdEACxZ6_F0Vt0Arw5ZcYGysWRGujS1qTnDnB6vg8dk4vUMo7OTs_bAcDHDQC_pouqmIBZrSog
 CThgcmCzrgBv7HOxyzOKKM7ly2gEyZTViIQlUBsIGmuoreRLnYREBcYgCh6qnHNt2YDAb3kcC.MT
 llrRvOTZmR8Lr5p0CP9JnEwv7Pv2WaEnlyRlXqlyfzerq6fWAyjkTeRxN9rk_IzII0jHyw.QVG5K
 hZ8AgXSU3rk8OlZneLtb2dlAUM1_HunnwZM_kNjQfzi_ariwhkhmJ0JPkR78bKZCo8szpTkgrPgo
 FIVm_IzBx4rZ75LFeHK.EkdCG68CFL_n_QJEWYz2fBsqf68mwytoM0.c2T6XKDecoIpzZNabtfUQ
 KuPjTQ.MMBti..O0IYCBSVMy.2v33dEB9_1I5xB_b.uo1KCO.NO_XPGviPH58FPwej3kMqphe1At
 Cj1b7C57u6VQrFdLWAqDnBWIY2cjnSKLi4XYzCPOg6yP48dSoMxyudWYBWfW1PNxmKSzavjZvsTv
 7vXnLtynueLmzLZOV
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 811e9906-db25-4ebb-8911-20e540f486af
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Thu, 25 Jul 2024 14:40:23 +0000
Date: Thu, 25 Jul 2024 13:28:13 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <258254527.2690084.1721914093743@mail.yahoo.com>
In-Reply-To: <1106076396.2672924.1721906849141@mail.yahoo.com>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <1c1b58e20cab6b4989b140282353073165f0067e.1721762306.git.gitgitgadget@gmail.com> <xmqqy15rzwi5.fsf@gitster.g> <1542063589.2363688.1721786934049@mail.yahoo.com> <1106076396.2672924.1721906849141@mail.yahoo.com>
Subject: Re: [PATCH 6/8] git-prompt: add fallback for shells without $'...'
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.22501 YMailNorrin

 On Thursday, July 25, 2024 at 02:27:29 PM GMT+3, avih <avihpit@yahoo.com> =
wrote:
>
> So mainly as a general solution, but also applicable to this patch,
> below is my best generalized solution so far, so that scripts don't
> have to reinvent the wheel with this "string strip dance" above,
> but I'm not too happy with it, mainly due to the gotcha that single
> quotes in the value break the world (escape the "eval").

Pardon the noise.

To summarize the options to replace $'...' portably, like:

=C2=A0=C2=A0=C2=A0 __git_SOH=3D$'\1' __git_STX=3D$'\2' __git_ESC=3D$'\33'
=C2=A0=C2=A0=C2=A0 __git_LF=3D$'\n' __git_CRLF=3D$'\r\n'

The current patch has this, which is not fun and not scalable:

=C2=A0=C2=A0 __git_CRLF=3D$(printf "\r\n\1\2\33")=C2=A0 # CR LF SOH STX ESC
=C2=A0=C2=A0 __git_ESC=3D${__git_CRLF#????}; __git_CRLF=3D${__git_CRLF%?}
=C2=A0=C2=A0 __git_STX=3D${__git_CRLF#???};=C2=A0 __git_CRLF=3D${__git_CRLF=
%?}
=C2=A0=C2=A0 __git_SOH=3D${__git_CRLF#??};=C2=A0=C2=A0 __git_CRLF=3D${__git=
_CRLF%?}
=C2=A0=C2=A0 __git_LF=3D${__git_CRLF#?}

If performance is not important, this works (with care about \n):

=C2=A0=C2=A0 __git_LF=3D$(printf "\nx"); __git_LF=3D${__git_LF%x}
=C2=A0=C2=A0 __git_STX=3D$(printf '\1')
=C2=A0=C2=A0 ...

A previous message suggested this, which has a beautiful API,
but it requires an additional non-tiny function, and it also
hides a great risk of escaping "eval":

=C2=A0=C2=A0=C2=A0 assign_as_fmt () {
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # hides the usage of "eval"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 assign_as_fmt \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __git_SOH=3D'\1' __git_STX=3D'\2=
' __git_ESC=3D'\33' \
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __git_LF=3D'\n' __git_CRLF=3D'\r=
\n'

But then I figured there's another option, which is reasonably
readable, scalable, small without additional functions, but still
requires some care, though the risk is not hidden and easy to avoid:

It's basically what the function does, but without a function:
(double quotes required only if it ends in \n, or for uniformity)

=C2=A0=C2=A0=C2=A0 # doubel-check to ensure the printf output is valid shel=
l input
=C2=A0=C2=A0=C2=A0 eval "$(printf '
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __git_SOH=3D"\1" __git_STX=3D"\2=
" __git_ESC=3D"\33"
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __git_LF=3D"\n" __git_CRLF=3D"\r=
\n"
=C2=A0=C2=A0=C2=A0 ')"

I think it strikes the best balance between the options, both
for this patch, and possibly also as a general recomendation.

So unless there are objections or better suggestions, this is
what I currently prefer for this patch.
