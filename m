Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489340;
	b=Wfb+6/4Em/OYAn4ClRbFeLXGnVPFuuHS7G9Te2er96n0IF+joe5XazyIlbzDUbY0Pe/J
	 kzaCxBlyLD/4D+W0Uqh2RnRdDhqt7HUtnA5ee2BVf2NUviHT0Rz5bvwd0aohGeMA/sLSl
	 +jp1/Ov/eOHNfcIbB6/7syCcjfKuZCCCOrajDEXsqgYYCmEUi0bzufmWEZVYOF2QJqilM
	 xFJTfWj9Lqhp5lRNfNpACvIr+3bNdFJ1ISi7Lzc3aFI3ZR2JfJbbNvKZHrG2Nwht9DeCy
	 wznymxiStAGD/yNl5jyLJbBSwcV6LlCLqUcZqGd5ciSnL/ZHLDzF6M6zoTm0GGsiyBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=B0Gfll65UBnIbkz9BQLxMqaPRdLm026FNgFF1jkpQyE=;
	b=iPWcjRoU+TbCjA2JBhLJDgli2i8Wj9V0L4uc+1RVfxhm94616uSNK0qEwhppv4CF6+hI
	 TE6Eakeib3cDG61JbOm/6CTwk87lHTQ1oXdxbQRlP5fajOUvs2SpswcXTzdR9HPOj0P3F
	 hMeT3/zU202NPDe3q3mhuJQtRfmSn0ZdhcfPEXMLzkeUIuyAY8cclNx96hEFvPfgNxPvM
	 VxrAldpl8FtgN0CYH6qK29U5GWdmwajZ+Cv5DEgDh4CWQm6E7KH6nZQr5XGEAAFp63Lxt
	 FQgtuF1Mmb8kFq140nTFYg068ghsUD0VyECUaRiODOch7ffPldg/YN/qtQ73gv69Ong==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CYdnQh3U;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D9606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E90D9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CYdnQh3U
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48afcfc4bf5so2537543f8f.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 02:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792489338; x=1793094138; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=B0Gfll65UBnIbkz9BQLxMqaPRdLm026FNgFF1jkpQyE=;
        b=CYdnQh3UveMozxoj5KBtx4+mG4Ts8BHSb7LcfT8PtEGDMs2N9ZhuLwodwHgexQ/trk
         KLSZSuNUWOV+ga44Gtlbx6mncvp/DfJF16TPg1sK4XXle5SJJ912iz1d8dOp909beZ93
         ga4UXV8oJmwU+nOgk3yeX+eBJKRnF9nBwxWNauK9STzLu3E81qnLqGcgTI4Shm3nglfr
         gCymMfEoL7Kz9/x+IwiRmvyOE1UbVfRGQaZguShN8o+joVBUqwEEfKl/a+3HM1JnqWzS
         KEi1z0Y99k9y2uVhP6YM2SgOG14I5aI7A095WwSJYCHsWVdbGsD0aCZhaT/mbM/QUDD9
         Eatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489338; x=1793094138;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=B0Gfll65UBnIbkz9BQLxMqaPRdLm026FNgFF1jkpQyE=;
        b=I+o3Pgijr8tPmYCVOGS06ZZGXC0l2pkjxwwvh2Motwnnskb9MpOZRu/r3iJm0mx4ID
         e0mFUqGM90iSr2J9RFLv+qH9KK0BYruc1DTJlc+1otBuQ25fi8ibH2VGmJ9FWZII7SK5
         5UtjWtFtxpKkPUk4MD0QJkmuTeyD8gw/0Cx3lv65DrHKdviB12cpvhuqwoYAlxsIorrz
         Aw9RSULzRmkigFSltsMk+/DaeePRG8uM5iLsA2Fy/SZs7J5CYXkTzzjI6ePM1X3q8dzO
         FJAmBFWdqUxPz/KMt6aHJW0PqgoI45OgJ+CFEBkGMioWo9LM4S5RLrdLQClBh/nXsxow
         bu5w==
X-Forwarded-Encrypted: i=1; AKwUvBzA5mNN2ec3GcBz77rboselKGMh4vHiPMMHSEd6VUuOiesgANZgFLxcd/tsOQR369U5OLM=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7EpKLLgVc7bhwPGcsTAVBA23RM+QDU0mnP6TFijfosOT0MeP7
	6ZFZUBj0vlLIJCldssXvSj1/WUGSMKpGEO2QHQ+BHi25+O5nwQmoNkVg
X-Gm-Gg: AYBFou1WKWObXrSlVbDracb3RSvgqJpZqNs3iurkEngpgA7miItLuIYQfEzggF3Ieln
	QnQwKg4S8tGlhocFLx1y/BddebS925kCXEllN/l9Q1rvshwE0D80xeNHldCDs1P1AKjrGYga6nk
	1XVdUuN66IYVZqrVQazWy7OaB7Wz3eIxSNaVuK7rpk++vDrH+JGwhXxnDHD1Cyc71k3/drb1JBr
	gS3hHFne4YJI36T1+LyRRo6mYtcwNHHgAriqRzRBF4tbnK1wb0od8vAsKX5NdDdKg0sN0BEhlLi
	eiD8YOkPG4WUrrtJyRIi7pGlR+IUs0ZPAIoZAYfTxZ7vH7v11R6c4xOtT+4t9UC+Pont8pfyWqm
	cXl+B6g8aTXbfbWpmKhB1iuiadi4qB1lrGiO+ytLH86+V4cRS+T/tLNLAUOjhLrbRGIoPH5Otks
	qk6NmQdodvwDGeLUyZsjDxu9MD4R3SrcrGVJQ6oferWQ8EPBtAvU8Ju1lpwhCs1lYmSQctwoIfg
	mwJInlQYsoxLHEDguykNpOtmVtrPR9l2L5fWZ3tXHZYCPFBBA5d
X-Received: by 2002:a05:6000:4805:b0:48e:10a7:40f with SMTP id ffacd0b85a97d-48e10a70508mr15354066f8f.17.1792489338157;
        Tue, 20 Oct 2026 02:42:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1e0632fcsm4280091f8f.0.2026.10.20.02.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 02:42:17 -0700 (PDT)
Message-ID: <e06ea3e7-7555-42b9-8ea5-65e9d3b25281@gmail.com>
Date: Tue, 20 Oct 2026 10:42:14 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] archive-zip: refactor 'path too long' error message to
 use Q_()
To: kerylefondji7@gmail.com, git@vger.kernel.org
Cc: phillipwood123@gmail.com, gitster@pobox.com, christiancouder@gmail.com,
 siddharthasthana31@gmail.com
References: <1a15474a4114ba8b> <20261019152725.714-1-kerylefondji7@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20261019152725.714-1-kerylefondji7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Keryle

On 19/10/2026 16:27, kerylefondji7@gmail.com wrote:
> From: Keryle Fondji <kerylefondji7@gmail.com>
> 
> Replace _() with Q_() in the 'path too long' error message. Although
> pathlen is always greater than 0xffff when this error is hit, Q_() is
> required to support correct translation for languages that require
> different plural forms depending on the count.

This is good. As Junio has pointed out the code needs wrapping now that 
it is using Q_().

Thanks

Phillip

> Signed-off-by: Keryle Fondji <kerylefondji7@gmail.com>
> ---
>   archive-zip.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/archive-zip.c b/archive-zip.c
> index 6f73ca6d58..e4f8ef5a36 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -328,7 +328,7 @@ static int write_zip_entry(struct archiver_args *args,
>   	}
>   
>   	if (pathlen > 0xffff) {
> -		return error(_("path too long (%d chars, SHA1: %s): %s"),
> +		return error(Q_("path too long (%d char, SHA1: %s): %s", "path too long (%d chars, SHA1: %s): %s", pathlen),
>   				(int)pathlen, oid_to_hex(oid), path);
>   	}
>   

