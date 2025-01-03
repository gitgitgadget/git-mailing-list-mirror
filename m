Received: from sonic308-19.consmr.mail.sg3.yahoo.com (sonic308-19.consmr.mail.sg3.yahoo.com [106.10.241.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58E21885B8
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735901802; cv=none; b=rdd1djoqVe/gdocj3RBr5qAOTlgZ0UqO/cxU0f6F4xrhphPOl3JzKM6kkdnOOsAUMF/Ti+6tpuG4sr6W1lMtrZGJ+Trzujm3wNjdUwcFkka99/DPlY8+lXxMxWecjxW9Q97Rm/PjKd3eAymisz7jxyJ1wzyMOK7W2Z2LYutOBYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735901802; c=relaxed/simple;
	bh=qNNbYwmVbSCsXOT+5Cwh0lmk9FQVo43XfOcIhGFx4j4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=h5pSfcP9uBKqiI7EYVQm1UcpgRDOaiq3YhnIWxVOCeKAWxAzKqyogGbOyl0Vw+EafTfF2IISUm+ahMssq/bzcOekv+QXY/GpSzBcxPUCQBJvzrs9JRz9fh3vZzlzYnWL1t4NAwfp5H4C8rkQqZXAuPUclfGmOwvbMwoltSaxHts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=fail smtp.mailfrom=fedoraproject.org; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=cBdMKIko; arc=none smtp.client-ip=106.10.241.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="cBdMKIko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1735901797; bh=qNNbYwmVbSCsXOT+5Cwh0lmk9FQVo43XfOcIhGFx4j4=; h=Date:From:Reply-To:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=cBdMKIkogeEPaiO9KKoCpRDWdNW2+dlUXEWJb3ayC8UlU8b0n/FRCRJoJPicAMJzv6rG1ijhEfCbUrBS4V0ORLIQ6bl+T1yyvyoqgX1fD2jSBiI0n7IniACGFBZwO6Ly3El3G9DySf1wM41UZVdlG0pe+s5SvUXEnHAspl0ZQ6O+kDfNTjndXzrkzXu8eqhPxEZ+K62j4grdia0+hh+Z3/S2S5OseYRb688JNQvM/TsEy88zjn/yzJ42Qxap6NRGHge8HyvhDZ+6ADwvu7pd+mnslI/SmHOMB9hrAC5xQqEsNacSDQT5duXTMsrrJ4CQc7ubIY9NKy32ofl8NFZwjg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1735901797; bh=40MdsoDOvUdqEe+9F3e1rEJ8v8SFRpcvRoxcWb1P/zG=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=oxu2cVeXUuHA4+8eGQ94Xf3gY+ZI+iALNpvm4uJGR8J4vLv0Pe6tcEV9nTtJNJAk8x7mDhLUgCNGOsmb19z+smAZ7VdxL3PMsC8qZ0Cik4iNicaJ91TUxrG34vNlRJbKOK45EGJ13p+tjGNXGSP5WYlkU+/ONHsX7ku8E59PqFuvT3KjuqtRZnvIGJQTxFjWRcHdexyC3cZ3vNXAtVtDUxMUg6nl6jRm/ObsMq8GzPJHjLCoP8ZSRkxxJXub3GwoT/9dmTjVosT6E2Y23mtuRb7RskGXQTMpzjS+wSXLnheEOX5swTVBtNA0Do4CgmvPJsELCDR/JyerVNpMIDCQTw==
X-YMail-OSG: DhJ26MkVM1ljCWdWW4RXEaY0suRi7TpXhkmD6jSWjzA1rtmdywiQdvihA.Tg3aR
 PKWBtFdnOTuIo6zsh7xhG5ULn6jOG6y06f4adKVhAxDSOIqOi6lThpd889SKPW9m7GnTPo6C48Ch
 JHtZvvLWCy7L5vHUPLfhljpWRSUXtADONgGjNNIUCYoSRcsdisZIzTosLmRMb9GYk.NTUlKlqSpZ
 hC5sy1xHqwgOJXVLcc6gfb2c5apHecNjXWv9KPxDW95am2E_KI8BPV3llu0eGgJULS8a428ucbxu
 Uu0xfDZZK_EH5wgChx1PBbj3cOu5dAEPYqGRDh_GGcTRHdCV8YwdESc8CjDO69Un.pGyLJCgLO7T
 vGhN6OzMXfZR_38CuNUL1gnIwnzw_mTfj3QJU3yIrAhcmR9YFEmlG_DMocAegJiXvMdLgU08xKfO
 95eLemkVaQ47UxBz3XaW4taxLpsuzUnbq0qfyJY8eFJKSMTS2kkb3fwYUeeK4Um.cm_AfxpWwdID
 Nw9CFGojMpeBRNf1eHLiUY6.AXIiT8Q4G2s5rK_8VU1zOhdFcT8GkzzyptErGnBQcA0HHZYjEz20
 66KKLFlCXvvuizQun9KWrYARCb3q2pIT49nKfCICrw6b2z4PFkLZ8BbDTJCzkc5C7BPOHGO1dSg6
 WDfSMiIczNXI.etb5tIo7qYoxW5yXAtx3_FZdj9QY2ZPzUoUNASDc95H3LKQ0uOsmUrSerGGSiwt
 _e1eM78J6NvKMhnGcfe_Xan4piYNa4.4NXUJu.3DRNjABokTGZDd7R_68MdUG4g_i6mf83kPYhgO
 kR3ARqKiKdjfSpmridzmFpybuJPYiARACDKf3zpoafOl71NbuiIWp7JiJ9mryRzuwhU6WkZyl4bg
 doZSvrc10uaz3iqLuNErG_GiRz43fmjexLsQOA5LRks7u8BlJ7rkbknUdpXAAWwbq4wvxwDfQ96b
 f665hFKHDYqf5z_qDpseEdyUG.YCEfJ2heRVxVHlUEVcW08GG_dQ3JyfyfjjQnAO_9uydqnvTfum
 Cz391SWaBcx77g9vFt71ZFYPWTCZRgpI9u0hH_fpM1pt4Bm1UvLSMwS0qbnwx6GIgz.W3Mn0IOTe
 ZNKe5m8vrnPOdJj9aitqSDBZikJsucmd0z.uDdSxUW7JEtG3mSOj0ZI85lIS6g7y3klq.Sp8liZL
 jnmgN.l0r9qiGmxT.iqZ_f5Bk3f98pPiDD6rQEco8IWi3An6GYf2mKm7E1JF1aVVMBjtmEgx7r1c
 LYhNJ90IuPhNcmusoYfX4fZELm22TDTfx3u6LnHuGQj.xgxPu0rhUyuMXi4UZJxYfULABf5JhYk5
 iMc0yAaUW7mHT2jBu.WT9IDNV4xb61uAmB9H..DbPAx.wmRAbOoheJMMrWibPUGRqYA1blZ2zR3l
 Rg6BiZwYB2G331pDWQSm6nzMZmN8SLko4mDYNXSGP.vceGPtEvT5Qx_H.LVjL_fxSGWbgEh0_o1J
 yZBpl6jsXL3qfLd8OYc8DbBzlc_muCi6GgX.RM.a.ca7Mixj21a97tQNqqmgPfd3AMOwS000Z9TR
 PHfnOCLIUGsvYAqUHo1KE4ioFXe8A3gl0d3jWYn4CsehzGo8gAA6_oHYPs7JLyROIIw_nWWccSzU
 PUVxclh8e8swfE..EMbWogv0Wx_QcaMTHWL8GHmnFgoVtqLe_83nmb8MhnewDGJKoW0lHc7HFLPj
 ufOXJNAKutGcjqNbxuF_DvdZiqUQQQKos.I_W.P138QiKVOamrKtyevPMhZh2boggdnzWatdfNwI
 ggJ_7YMJ2dT8bLW4XEP71NxI5Sx5Vz9d0e06JUxoMEdoqQ7pg1mMIWJFBM2V.cqKdFFZhlrMKKi4
 NB17cXVPAzJf9nM56WfqmYgu6Ba99k6L3SisxA1hUowxJdeBe91vIovIBoRZrbg_V1o5OSHe8mmp
 eMPlg8bly47kGymEfFr9M1.vY3zcuskT_diCzcVh1zsaKswdQo0mDvT4epJDEt3wccJu7_zFH.R0
 j_kjP1jp0M..wRiQLNZcH21GHnGEnSlNurFwEt5Nhe4ftXOiZ5whLIucw.z6p07t5zjeM1kuAtTK
 ZvVclSi60rymc_GqdaMXp127T.UTSXQ6yTl.Q_gVNhBc18k_I2atwY0w6gkXNumbQQLiP3OvIRgn
 ywrO9u3r_tyWBKp.NH4I8KKPa.kJj03jjkNmmXDeHmurv57zZxHJ9wXzIM8KRz5_F2XH0vbdkpdD
 RxaErP76b3Dyl6DyrRp5SNNkV5aJivvl1WJJjdGRyIqwmemMBxryAZ3U_wM19iwrF6vduf6xQltD
 IOkQe0NmHz35PQTA_e6SFCkDtM2D7
X-Sonic-MF: <pjp@fedoraproject.org>
X-Sonic-ID: 968fc34e-6a5e-46d3-946e-6fd9323bebcf
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.sg3.yahoo.com with HTTP; Fri, 3 Jan 2025 10:56:37 +0000
Date: Fri, 3 Jan 2025 10:26:10 +0000 (UTC)
From: Prasad Pandit <pjp@fedoraproject.org>
Reply-To: Prasad Pandit <pj.pandit@yahoo.in>
To: Chris Torek <chris.torek@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, 
	"git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <394850972.5946685.1735899970546@mail.yahoo.com>
In-Reply-To: <CAPx1GvdmrTn0x-F8yOoGrSrhXPN6At54svch=Wf=9rcz9Ri=7Q@mail.gmail.com>
References: <1964163554.5326830.1735643984559.ref@mail.yahoo.com> <1964163554.5326830.1735643984559@mail.yahoo.com> <xmqq1pxmxyoo.fsf@gitster.g> <2075804114.5670956.1735812672910@mail.yahoo.com> <CAPx1GvdmrTn0x-F8yOoGrSrhXPN6At54svch=Wf=9rcz9Ri=7Q@mail.gmail.com>
Subject: Re: File missing from git branch
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.23040 YMailNorrin

Hello Chris,

* Thank you for the elaborate reply, I appreciate it.

On Thursday 2 January, 2025 at 05:10:26 pm IST, Chris Torek <chris.torek@gm=
ail.com> wrote:=C2=A0
>Git is different.=C2=A0 A branch is -- depending on your point of
>view -- simply a *temporary name* for *one particular commit*.
>From another point of view, it is *that commit and every
>commit reachable by working backwards from that commit's
>history*.
>
...
>One of these metadata items is a list of raw hash IDs of
>*previous* commits, usually exactly one entry long.
>We call that hash ID the parent, or parents if it's
>longer than one entry, of the commit.

* The parent-child connection between commits is fairly convoluted and unin=
tuitive to understand. Especially when user does not even see the parent of=
 non-merge commits easily. For merge commits git-log(1) shows parents.

* In my case what seems to happen is, the commits pulled from upstream repo=
sitory come with their own parent commits and my local commits in the 'main=
' branch are not merged with them OR those pulled commits are not linked wi=
th the local commits history. Something like say

=C2=A0 =C2=A0main-branch -> uc1 ... ucN =C2=A0 =C2=A0<=3D forked and upstre=
am repository are same.

We add local commits to it

=C2=A0 =C2=A0main-branch -> lc1 -> lc2 -> uc1 ... ucN

Here lc1 and lc2 are local commits and uc1 onward are upstream commits. Aft=
er $ git pull from upstream repository maybe it changes to

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lc1 -> lc2
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0\
=C2=A0 =C2=A0main-branch -> uc1 -> uc2 -> [mc] -> =C2=A0- =C2=A0- =C2=A0-> =
uc3 ... ucN =C2=A0(<=3D earlier uc1 becomes uc3 here)

* I wonder if there's a way to merge those histories with git pull(1) as

=C2=A0 =C2=A0main-branch -> uc1 -> uc2 -> lc1 -> lc2 -> uc3 ... ucN

And whether that wouldn't create new issues of it's own. I guess the divers=
ion comes because of the merge commits '[mc]', which essentially creates tw=
o paths to traverse history. And as the number of merge commits '[mc]' incr=
ease, number of paths also increase.


Thank you.
---
=C2=A0 -Prasad
