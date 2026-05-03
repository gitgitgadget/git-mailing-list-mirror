Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535CC7261C
	for <git@vger.kernel.org>; Sun,  3 May 2026 14:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777819611; cv=none; b=duhJIHWHhgzONVU83ps6ThiV39nxvcIPnhsppo3pVNFUA9sqOC+/9RKLrwfh2c86uNS9MqdHelFN5lebioSlLP0cM1VheDienjCh+qqDS8nmwJepDSNukq9X5guy9l6GDwIkZtmPACfO7sNOETmc4Od42pktGPDbGWhzF3/TkBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777819611; c=relaxed/simple;
	bh=QC9zVwC5UNMp/iqSUD2DcSEXax/oqwvfxmE6ytqWb5M=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WyqS0fSAm6760eW8FYrAR3ZPNg3oABrIanRHsGRy9Y3pO2luQq1qT2uz4o0025P0nafqNzS0PD8efgDznUVr07J9MDrg/Zxk66FRMwwE2bpegT93hF27F0mfictz52jrKKoo4yOeDQDjGkazWgrGHqVnR11035CuzT8uzsgMe0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=pX9/Bqpa; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="pX9/Bqpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1777819607; x=1778424407;
	i=johannes.schindelin@gmx.de;
	bh=vukLq+wkmOjosqQFfmfngM/VZdHzzY9b4mLr2+TL3L4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pX9/BqpaERR5imQ3GIvskgyEE9XTIK+aSA6UR9+lC8RO2tM9+o4jf7Q/BzuASfBm
	 2xcZGhEz8BI/x9ex4noRR1I7IwRXB5Emuq6ZXPgXynMIO0nJ+fNcvbkoNJCPUVRrc
	 UonrorEsBG/HzrwggYPKlwb1iV/PGutpUuSA7XEPkK0sWgn3S0+6OEsWiTuO3QEAs
	 E2zDRScO/PDFq2KwEWHmtS80wDLLMcQMpyKGrK1KSJYirnBSjFLcOiQIjNVnBIlFe
	 L6xnJpriQZu598Trxk/x5HfkS8psbQupfpo9uHB2Q1UOJOVpd0TVhBW7iTe7+I+Ey
	 /3pSdL4YVuAR/WPltg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0FxV-1vMTFh3mPX-014Puj; Sun, 03
 May 2026 16:46:46 +0200
Date: Sun, 3 May 2026 16:46:45 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 1/6] index-pack, unpack-objects: use size_t for object
 size
In-Reply-To: <20260430141320.GA6659@tb-raspi4>
Message-ID: <1d2034e3-5a1c-81e7-88a6-65558da2360a@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com> <dc660106ea8511e6adc44d2b70e9a4ae8b18090e.1777393580.git.gitgitgadget@gmail.com> <20260430141320.GA6659@tb-raspi4>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1621456132-1777819606=:4082"
X-Provags-ID: V03:K1:GmUaklyizFwzgqbg7er4iO+Sp/7AeP2wLPYucVmR3O/wU/HHPrs
 J55LXwkZHyT8AjfnDWdqUbFzXEQReZrKxQu1prubaBZ/d55e9r0NFNAmoOqidIwLpuwD3fC
 ZHvIDVlPGTZzyk6Hq+E0f9r6RbZTvAQmxnRfWvLHcHHlArZjFDMY+XqeLsOwEd1DFkXobGT
 4Q8Kdwe0kU7mh7Scw/JZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yejhV5L7Pao=;Gv8qVlYBZdBpZAwuLKSZQYyfMSZ
 F6M8Bq/affHBHQPaCsin1TG5ySvc92UpjXQhE0pdb+40j3kM0m5OyHPn76l50x2CWm5RZdHs8
 /Qg0WobDfuNLfDoTRl2mECZWC88TBpo8W0+GrsHf9ctUDmf+qjXWlqh66QR5K9rbAFLIqUnBs
 quElHlJdjUSKvzHbekvdPcXys68g2axnwpuCCkC0OZbk19nk3IGoBmRSVnPG7853xvoyOs7/H
 2mThihf8j9YQ6YVJvEv9ZfYyfzjzQhbt+xaZpgx5gZvSiXOdjCYB9TBH9bZIzqEOomVgpZ3ly
 pw/LjOq3j4Y13iVoY0JJPB7x00RP9mhbfqERP47+wBgyDHEqW4ditoCGZkCXma0IMvFki7h6e
 ejJ2E2oqAwsaQd5RB9QhnIndfZdxKeM7/rGMzw5nzMZqXQXP4ZUmgpeEGvPPcU+RZJ1nRELy7
 jZTzEneC8F4GpoVjhlVSp02gJhL8rjs7C5X9ryfxhfPTDiPIZB+rU9BOTA+pjflJo+zgHGP2k
 Eya3t7wGt4TRC3Wwmx/NENQ1pwAKphlJkZvkd/rGXm6G8E+aL94jT75auDG2j4EaAOAT4LVKP
 6VLAjyJPyeEcbfLC8GUZGfmoLVkXMGOtPwLGFuy17mmS9WGn/lceAFwYf7lpbaJq9sZXWqw8v
 NNGBBM+T/51BU4mT1s9arofM+R+j/mTtVyeJXb0gOuluea5Yw2twD5MPe3b1J1VLLgTeWp1ZT
 VvUYOrgm+jq+gWKSel9kA7MgtXNKF3IHEmS9+EX3ZlL4FrK89BPiSEBJHBfiKuvSL6GSRzCSi
 z4y6FM4O+UyctDcEdHXr+yniaN6fD/2zLhyz3zuD8tYB2PlYeITFWzjBJVH9Gsch95y5HLY32
 HAZNo7l9a4dAsdmZBMAeN0hsh/likle3eMWhI5YxnNKyp/zuht4TGzVpISvM++rHmMhnFdes8
 AO5SVmXiAIy3pw5UDMZrmrWIgy/kVAOthanDjUyjzvApS/X/cvp4aua6aMPdVvFIP+IQjGOc9
 Fd/ES1gpYt7cMIVTxolvOhXc5e2AB9GD4ZOpfyF5TA8WSKVG+r9WL2JhhEe35+vGBvIziiRW+
 xtWuO934VmThNvroG4DQho39NyGn9yBIitmKlFUflbFT6CT7Pg2l3PrNveDMu/NUYKK1OfwH8
 9P7zUioi05vE5gplR2WNqofg4+LfNMuQzXnbXGvbIDuEK/FEtCrUdkfpAlP6TU8tMLKkPcpAk
 f3pwqezYRm/y+WEmGsrmPriE6zSnPa20i8Z6MqHMPVjIgciV9jVGghzbCH7xBGtbfEN3X3ynF
 FGFn1xrDp/6tpBJR7Yfl8IAHWp2S3B+WSKrhj/K3C4oqh8cmIEP1XdPxjV9MZa2s24udR3L6j
 I2TcNPp8NxDU6sWw2emSfp0bz5vSMrW7rJAUd1M7tqB6usKrkY4EBIQm0kJpoa3JMmWrlNnG6
 CsEq+HJQkN/fpik6iHy9vI3S98+tiD675zxiNiwiA3Ao/uCX+s/uzYbHTFV2D12HMS5i44315
 YzfXTkB3TEEwJgOg/CVUqw2oSr81gAF3fptjLw23+++UeHQ8K8ouSI6S8AyOLMuWzTpaf37eK
 4hV2NjZoK+Y28EP5Qaou48g5zIWhSbN1bvrx1ickdDCbO2nZJZhDJ2cnldeyIs3vBGgnUx7FI
 OcAcze0eafwFKk2QizsBVjyzhrTbznfvhz+SEcJruUNTzsBlGw9vKVaB4BGFSdRYCVjd2bCEU
 4Ct7PRkegGc/WjITEws7JozbSrectvaHfREsKjWsPM8AITSh0rS3kjdb4ScML1yFELi3mGEtY
 /cflYWX2pYC0SyRk6xZ8sMa6DgM/URcy6bCG7CkImxgcz2Prr6ian3RlumWPXK5TzueAcYRpm
 J0VJpAhom6mtPj9+rPpG1p0kUbp5feu2UxbuYWfves1KUfSlvFIHGWKfc1D6k8m2gwa+buo0N
 J3MivBdVuLK0o6rMAlsm1HE3wiTjqFExqL/NcDt80YQWzRGtUSQkOZQDHOEeLmxPZMJH4uz0R
 SPMZv98vBd/OlVd54ZUlOwNrd1qUCCU0hEHg8i1OskdVEBjtp2XWcnICXOSaKmDac6dkhVATr
 91087t2H4CtmEHMyko6QLJ/4lAr6wzzyPn4O7oul2l7jG+qbqpi0WB9XhbIT5k/WOGCLrfnkA
 hjCS6LdrwGR86T6r/7am7QIHi4jqDtua6MgDaFhsV24EjR7Q1CFoOuLb0rBdzZDIXCA6IMa9J
 Gn2FKIHj+De4bKo9Y/gzZo/i18x3R+qcynNVp+UD6ZolJkBWQ0K9n1oezHBMaSvQ8W3GqDska
 FpYxzWAmseKKCG/9VaWoiO3IQLnwvGg9kpDEjBM7KiAtgCTZJZNWy6ngdxzVjRb8iXSqSm/Mg
 H9YEA0QvcQPVH7QeEPFZtrQOOSkKj5x3/1YYwUITGsnhB2a7vW6Fq+vojDfV82Io6Oz/Y4csD
 fuLDQOyK0zvwHWNQfk7m8yVyCkwrzrhug/PzPCVlTGdQ1w+fkxK0o1X3e/yEISPBXL0U84htO
 1f2xPY+wPhGj32kd1y71g40okxYxehaWTJMWFFceSQmAnEVhY60EtIkjYHI3rc7jC3rf8yK5I
 3htfZ9Apsx0cUhwsC1CNyv6MrA+Rz6TES3Y7hh+rvS3MwQd69zybUz2fw0szAnd5f+ZtJsQl6
 k2EuFpIrVuFFUT+2teYOk89upIdNeOtBtM4FqSmTP8PDZFiBAi7Gb9Gt44eNdxvcBjm66V5hg
 BiFu2rM7s84VYA/Ri0D3VYos04FSxwQC9XMZR4JnqledGxlEF4cJozdJ8ncxSU8wunSpa9bmQ
 AwdvP1yDS/z3mffsgp/FowmbwiCEHzIZt1LEzpPVraNaOa6s3zUZJsjCVYqVSdasVp+Ncmaur
 K3o0aIcB9G+wwD29Aw8LLjgJAzZWIFqrjD6FONoZOa5zbeftTBbF6n0FLMZ+XJ5jEMgr9+5K7
 3usDTr+ismhvKig9GQ4IwAfZWZoAldj5JaTYxdGfix+K7heBfwyLQgBzJflcZBejqIwg2Zg0M
 8wLo2wAVVmGAXiPUHt4MaFqQSXuzVn/huZLwiHF+Ahv3+TWwnojxbXLTfPoRVCcNWof5bBFFW
 bhWW2UW17LwkgSdF2BIi5vBHvhrFMcuf2C/lvvalpHArn4kvKwbHfQw4QV6PtadDPcMaDK8az
 ANdRbOmzkgLy3ByMnE95rWsIvDW51/oIesKJ/nHtWO+Rj+iMFHSPyuWzYSVB6QkINbQw2rXhu
 HfobTrDBULV/znIxDf1EBpKc8inXL48Sy0c3IK9xWyOJ7fJkKnad+znU1HUs+7OqYq00ZTegk
 3xZvcu241inwFfFuFKrBfUrF0FHVd+AsShP3XaJpIecXTj6biaXsKfraajx1JQpDczMm5oVtC
 5QhQeLVfJosjhTbsAHnGBXiqDNHIggA8FvQaoMGHfIip/e4M5TARtYb+Cok6e7393ZzeVq+gK
 g14JRs1ZWsGPU9aaORGgaJBHtXsQ7RbNNAG5hESiY/5AnSti1jW5GwLu6NT/F1XBmibSw0MMF
 KPpJtL9KHNSwBYhnybdFoC0+hbWhqSwE8j+r+yuW6LSrlqEgbg5Po8/zyP5tvyeK8OLjynzim
 2W7oFH633KR0qJAIyIuOvRFDRbBBG6KfEW6wIh/JGCWrayhsqtFFDcWVdViLont0mJEjb1ROB
 5fYzZiqpz4qq38uEoW0clY+zO5zxquTAHCsU3j0uSQJmRghrRV/IBq93LqwsnuCBu15h1LEe2
 SrqVKWBVVA3jYtPfUw6xHfI9d6ddavXm3xgRU+nHLFhfwi5DRsst4PYkyyOT3k0Wgk+fVTiop
 7jT0yiWJZL6dSLuJuy7Msq3xxWx9dIlmmA2cl7H0w6joVgSNxuVKeGlJysMiTvkD4qbM4wFt9
 3uwOXzNR7MrAry8HRknI4iqHz0p03l7Ah44UXJasFFxUG49L4cO31m6MOSXQ4GH0XrPzpfCRu
 VQuEKwmSSDYJ8svqLKVBiPGMfq5ooaxwkE+9xC7VM0K4LlFF5s+rxFUydmdyJCd5z1EDL+JGq
 oB/Y+Z4wwCRw6oXuri5vzUN4JyCUE6LgqP0fDojMQ01flHgoOzzeGiMfuLo9Q0FaHeow9/GVu
 CgUlCVs4eas4hj+eV0Skup0f3HCk7TBXp1bz0UksB2utPxKtQaym9sxQDAmkMz5vnJJbu7OeR
 j8GyV3IxoAFDPTpWnROuCBdcIFoeElBX0wbWcWGlFtP8oGGyELGPH2mfFq7ZWOlr0M/wrNV4W
 Hit52+nZKLODKi6uVVZ967XHuIgVnADUlDLvU6X2lWSfx/4wOis6nUrYScWP5dhDAtp6Gmm3t
 y8LKZdwaGllRS/OSaawb9fL/V01JjQ7Q67rL+60lzesy6XNlYjE1/Hi/QNdTStbHYiLDnVxho
 O/kj71n54XDL6vLo0N7yCCstuq0DFvQQA6yBWCgcOAxdppHU24u8ae++nDRdZzfjWBfre6tZ1
 ceZiWmphpVW3jVyzlyISDAJnJfpz+4AbMp+Nb/liDZ6Xy9cP/ZFLAwa/fzI/RqGbxZ2d+C7fk
 0GeSlgPHK+jgH4WxEiemwGU4nGTP+WNuqNHFFum74Cuhe+lirOXbHERWXD+P7/N9OYOtyQwlX
 /XYGlbH4xb/rJkfVeqWaH9WOOhgxEqUrMwh6UDGibXkOE43+noe5LLzmmS5oLrf/GMBO1jlOi
 N1wrk2GMWI+vzKBur9jZ5/MjNi6Bypzdy7EgZ3L9brsbhHzVqeJ3q33/EWCKS6pOatFmxMJL/
 /Y0sa2VBknAbvpia65XaPee2MWNVyXhey+0OyVqY6bRCyeoqj/wxp85T6U4+X+W5NpBFEccNT
 evLbUZBIANmYhJ1NFn2JoNUedEaBWZB46PJyYPLnAG2eZrGMmflzTTJ1noNlMwOjyx4wmr+Wj
 lD0WF5rKfK4a3Brpb7IAm1DrAEeLTY+g+30hXEXoejuFQ70MkFbOTLYj1KXpRjLDVkdMW1naD
 0dygQFg1s6BKenkuCbmQtF7KuGWR41RPk/ALCDWwxAhAFyPmkkpiDJl4Cf+n3dFQ9g9IWEn6i
 /FCQND0nJs+KBZgoLUDXaaz1F3snQRx22uvRZ/JnSu9te2VPS8BcFt+ng4EnooIHLyAATmc14
 BbfP9V+R0C4Pkuiz7OHZ9tXXci2hKDU7rte1Z/1Dr7YGIWbHWUpvDtsVpoxIxibIdLA3aoK3a
 Q/ag0ssReFlWaxMJb1PJSie+cL/QgxbJlqMK+DfsjNQQ4fhlnxnflNIriuP3ExLDJ6832H+iu
 CheIJvDTkOobiUlqtDtXH3eLQzSZ3Fp2GIaAr3TkUPQRlbRZAr7LSYmxfg+JcwjMI1HJKSD1H
 jzXq7ORtSKQymuAE/pMKGMfiwPLBrT6cs8cCEEale18En6eqZ3NwiupjjBK1GPHmooSHLAtO9
 KPR6CdOe0k0pmrzYh6ri6A1Yrx6LNppYrUQNcyPgYeky/LFSlO/fL05O/cfh91bEb3GVxL15I
 2mwnQmqjN/38LVUx7s3n2ClL0uiR07h313ntkaoB8W1IQM1wMu1MP3ZBWavNDVRGuWqti+hkn
 Tsxj7+VRFeurpavs4vH4yQQIOec=

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1621456132-1777819606=:4082
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Torsten,

On Sun, 3 May 2026, Torsten B=C3=B6gershausen wrote:

> On Tue, Apr 28, 2026 at 04:26:15PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > When unpacking objects from a packfile, the object size is decoded
> > from a variable-length encoding. On platforms where unsigned long is
> > 32-bit (such as Windows, even in 64-bit builds), the shift operation
> > overflows when decoding sizes larger than 4GB. The result is a
> > truncated size value, causing the unpacked object to be corrupted or
> > rejected.
> >=20
> > Fix this by changing the size variable to size_t, which is 64-bit on
> > 64-bit platforms, and ensuring the shift arithmetic occurs in 64-bit
> > space.
> >=20
> > This was originally authored by LordKiRon
> > <https://github.com/LordKiRon>, who preferred not to reveal their real
> > name and therefore agreed that I take over authorship.
>=20
> Good to see things moving forward.
>=20
> See even
> https://github.com/git-for-windows/git/pull/2179
> which is probably obsolete soon.

The word "probably" is maybe a bit overwhelmed in this sentence by the
sheer extent of what still needs to be done.

There have been multiple contributors who despaired over the task [*1*] to
split this PR apart in ways that would stand a chance to be accepted (or
for that matter: reviewed) on the Git mailing list...

But yes, it is my hope that I can wittle down that PR into more
contributions along the lines of f9ba6acaa934 (Merge branch
'mc/clean-smudge-with-llp64', 2021-11-29). I still have to upstream
https://github.com/git-for-windows/git/pull/3533, which is another teeny
tiny step toward completing what the PR you mentioned set out to
accomplish.

And yes, the pattern that Stolee already recognized, to duplicate function
signatures into the ones that the 20th century kindly asked to be returned
and the ones using `size_t` instead, this is the pattern I specifically
wanted to use so that incremental patch series have a chance of getting
reviews and to trickle into git/git.

Ciao,
Johannes

Footnote *1*: I specifically asked for this kind of splitting-out:
https://github.com/git-for-windows/git/pull/2179#issuecomment-525926366

--8323328-1621456132-1777819606=:4082--
