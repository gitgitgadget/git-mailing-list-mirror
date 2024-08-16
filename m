Received: from sonic315-15.consmr.mail.bf2.yahoo.com (sonic315-15.consmr.mail.bf2.yahoo.com [74.6.134.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C33D1DFFC
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.134.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723804600; cv=none; b=foQAaE9meVPk8Y1lbwzGKTqt8ndf8s1CDcdRVJWOGg744k6YSA80XpjCCYJS55XhrKHQ6rolP0Tsiy67YS+pIJ7QuvHU7ea1JImk5mcQlSWJsj/Jm0Abiwsidal2MbWOZ5Bx3OSzXnODBHaWgjeaY1Ct/4j0NJyRJ/T+8dDFtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723804600; c=relaxed/simple;
	bh=PjfR7WDbmH/YRlluA+lps2WZO+EsS65ucKQ8W2T1jUE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sRCqY5oMfBYBNqBms/4Jw8f1jcEMDty7gkgAHcfHZ2wXoMvY2TPzqTNSQm96L1rdk174CUF2in/3TdFOUAn1Ko4nSpS+7YHrHkfhZC6myy7rGfHGt7apFYGcJbCCHkc8OcQXpochDt14xPVybHZhtzW8qVD+iMWtNdrLnqCTklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=X4kl3pXY; arc=none smtp.client-ip=74.6.134.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="X4kl3pXY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723804597; bh=PjfR7WDbmH/YRlluA+lps2WZO+EsS65ucKQ8W2T1jUE=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=X4kl3pXYUkuKHVVnVGhydrv+kZO/LkLHn6NZTGuLsYzFtS5G37T9ohyU2bnBu1mGciNGhJ1KC1ofqelTqgN8ae+2RaomQBHEoq2Zoi8+MhjDHTbu2LzWFe1LCVw5KVxKRbJ6y4hpFLkq/taI+8hSq9m7yFWbTRNKScRS6P240QUxL/yMctAb1ZyBeLOLRFYsgRl5PVI/Nhmrfyx0WX6ltbX+2McY/Ox8aHOYeimSktUGFe4ur+tMHstw/rhGeHzo7wwA7BapUsf4mXIa7qWW2zquHcIfA2OJi1c6kxvaMdL9XrymrwiZq6bZ9O8uLsaD0U0IsWhbtZp/FCzc+DmUKQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1723804597; bh=kQ7ywSUFphPdQF3V6qRJypf7fHZ9esE6m0OBM4m2vXy=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=EfGqDnzw3Y+uiwUMCadbMXpbH2qBZRpxrQ2Qm6Fqrw1KJZ5Jo0knKX/IpEiEAXMoY5AUD2UUv7Vqzrk/9Dosg0M4WHKluLs+Oxy5eEtj9YYp0nT8VlyCUrrwy9BZBRJ8eCl1pmgfxWrw3GOdUsHLnnprZ0n80aZVd8UFewYptaKelrmJgUdKqI9R1YrKZoR/P5SpmL1sKNTL40Lf97lWc+CpG29ARLaQTtHDFSFFSerQ15/hlqgTXXe9nEFwqwE3InUNY2FyFgH0mk3aj2bfo6nD1HPihAWQpGvuhsCdkLWvD5nZLWsw7or1tdFcK55AVZHISlqSSJAXNAmRImR6Sw==
X-YMail-OSG: S7fhtWsVM1man_T1chttn.66S5altCfw.nRK2Ulk9gMtslJTiPaEGsDoL.YkGWo
 88c1l.dXGXImCD21nbrw.bkZ.SBC_nwjuX4QWBJCvSuwD2sKlyCxN0bRlhEu6XpSDBsvciMKuTK6
 RmqlQj7ntXwpQjEHzyP9iybBSmqdCBbJfsq.bZdY9vPkySt0Sb3WSz0bh7gwntjGuRsj4o.kzkkL
 11RaX8M.XMh4W.hB_nM9hX9YQB7Xo_APUoU0JizPteAh06AZ6lGEE17scB1B5YEjoAPIAp9vP3wD
 1fIqzHfq4nrKZM_WGtDHtGvaz9hZq_OG4UN64SBvFhdDF5FZbOjAjX9DAW2ODhLShDBJMVNrVUzt
 8IvsHBbIHtLVVHh3pL6DiWm0aVzMHhOAQtVVf2jUY5FRTSjF_BlgEOBu2VWWbNM5H813LnpppF9Q
 duPD_1F3zEwtPG8isV_BmqxzcYi5IQXWEH6pO.hy_e_NHv9YQifc3I1K72l8sef0k9vxZx_ZKoa1
 h_6AUT9kyZW.79dwU7FnSRhVbcxGklU5oKA6Hy1ej0ApzEWyegqS4TNDCb9WVtp.8NphVdSdWJD7
 QHRxdQ.RkCfqkO426V3ut_W2hwAg27tUWAvepxXo4Dh0gALI3ZN16UklBC0mleUP7gCxNRJRvSvx
 siHUHbIUsJJxiJT33rJNlI5.6FjTfshv63fdDaS7Inc9w6g.JqK4ljZDBqxEMkmE2wVVYXyQxC9Z
 5txWn.MVoxH6EeHWq6.SJx_K2agW6Yk2yP5cNuKZlXPtQcipWhOE1EP_ECcfM4DKqQJsZdC.FGpi
 Up0mkyrnO9r.0fFHGBiY11Dil2LM1OCEMImYJHjGILpD.2bTqD7iTDC3Okm.ilWmkwSYQHAaNlBy
 Prg9x5TsmVuwFObrMA4kxDu3mNOdCBbeK6lcPb1pYApwY4Y8XKDpm5GO6LC3z_hSz32obfES5T9f
 .1S3M5dHRcstLdd9YJupQUrLxlh4SrMnbEdU1tG2bmdhMwa5PXYBWpxCzz99snSnPA2myR46sf_I
 rIbYKnxAQUutEnw2B.EhI8Ek6XS4cSOUbogoqKkyXBBxBegv9oC85JKWGi1HlTv_3P7MrLGh5C2O
 qNS5fX.jU2Kgg.gVystBTngbuihkFhVOi9TRPzX_STJvYKTvUzqnORF89RbhPEoRVxpXhOU6HVlg
 jiJwRUejFOJmFqeZcgXLwKP8CYbqD8b_v3WGKDVWsyHNgDwk5u9uleBbSbXH2mpl9_UZAz6sZj2d
 jmm6pq49pMe.vuQIYdFEtYRa7ZCcLhgVDZ_tLwsjN3OyueEC8a9gns85vol07Pj_WI8KN51r8aT6
 bkb01C2zVAHOzYqDKlxbwkhQVg1wHU58BOGZlM_OKW2KEJ.co4_RTUXVY4wdnjwl4D.mpFMbWFxY
 fDvdnE_guUmrN7wSa1PzzLZH8t.Bwyw3sBAqUSV.uI6AXQM9c3r9RJSsrNNxR4ULOUG40jId7npo
 UbMvFwGujgw2N8iCo4uAPp1e2OTwCpEAA99o2lsZqITSa3pmTnU5WxbscS9Q0KGWEmsZLecQnmBV
 9dpbmVfSiOxtMSKMPLvdfi_n2TeA8DyzoH1hm9mZoiE8iuCJgDuWsnsyJvh40vW6rUjBr3lb1WBk
 ycEvUIcHHXX8fBIM.CrEQ10hwuwtRKKck5MPwx7uonI70Z4LaM7X635aTS.KgxiP7IThIutLWrUD
 EjPCtIO5CEkiN5o_AoOlmo9EDmeU.XXrl9hy8C1aewp3SXco50sNxF91z6pAtXc7oTjXsQMCR491
 8e2dlQCrZm7ZfhxmlIRnufOkrFAA7Ft4WHWhNCa.wzLnG34eFhiMpOIroniWN.Jz6jvrxaS2O_cg
 Yqq0Tadu5nnadPurCkaifpgC8h_5GMu.OsOUMC4sBqXdeadUrYaUX.CBQCf1bN0whUcEhQ7PSPZQ
 s1nfkOZk1Y0lJbG5TneOnB5zfqQiKL31__e5uHnKLDJl.Ryo7Mfm_jgJaAcZGvRwkLg4hmvjGPoH
 U9gN71Nd9PH0W_rUfLTc3AGnSbKBmjjO86muw9Y9l.oLG_XYyO8wM0rNVwS7FvG._AMaFWXr3WEt
 ykOCfky_rpbrPMBg.Bxc5cWV1uW.cHBp2g.c8wFo.npjb1kMnDytPyn3Rs_SgMOXApS.SaU.hjWI
 rHWYpW.b7z.dCfF7dIKaplMJ2lv.1bBnEQmTWIgM7Iej7..fEQUzTSj9cPpQbaR8hrZGLG3Tu2mQ
 XeuEpwHuVzD_CH_wHm_yKPlZFgEOSoqQTrsQPnS8-
X-Sonic-MF: <avihpit@yahoo.com>
X-Sonic-ID: 915a2fed-74f4-4403-99ec-5b5464a4fa06
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 16 Aug 2024 10:36:37 +0000
Date: Fri, 16 Aug 2024 10:36:32 +0000 (UTC)
From: avih <avihpit@yahoo.com>
To: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Message-ID: <1371885213.4494853.1723804592269@mail.yahoo.com>
In-Reply-To: <xmqqsev5u4yr.fsf@gitster.g>
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com> <pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com> <232340902a1feeafe526528eb88b8d0814d11545.1723727653.git.gitgitgadget@gmail.com> <xmqqsev5u4yr.fsf@gitster.g>
Subject: Re: [PATCH v2 4/8] git-prompt: replace [[...]] with standard code
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22544 YMailNorrin

 On Thursday, August 15, 2024 at 07:27:12 PM GMT+3, Junio C Hamano <gitster@pobox.com> wrote:
>> From: "Avi Halachmi (:avih)" <avihpit@yahoo.com>
>>
>> The existing [[...]] tests were either already valid as standard [...]
>> tests, or only required minimal retouch:
>
> FWIW, our local coding guidelines to spell these with "test"
> (without closing "]"), but this change certainly is a good first
> step to get rid of non-portable "[[ ... ]]" construct.

Right. I did see that, though only after I wrote the patch.

FWIW, the common form in this file was "[" (46 instances),
then "[[" (13 instances), and finally "test" (3 instances).

So I'd still think changing "[[" forms into "[" is the better choice
for this file in a compatibility-focused change, as it leaves the
file in a mostly consistent usage of "[" throughout.

There can come later another change to tighten adherence to the
guidelines.

But if you want to revise this commit and use "test" instead of "[[",
just let me know and I'll do that. I'd be fine with that.

In such case, should we also change the existing "[" at the file
to "test"? (in a new commit?)

