Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF36525B2F4
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468720; cv=pass; b=RIPGWIjV1aFl2ICZxWUqJDfQuJ5D79TkCOHHk6Blb2M6BJBHOKeGA5UCFNo1YHk9Az2V031w3SU6zvRIr2F6AgTxG45+OuVvhkyF6l/4IpAyoIr8ISOK3JFAkfyJUA6JussMCVs8Jw2w1ld0XmxG4D2wsUYV542KHmEdQ+icU5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468720; c=relaxed/simple;
	bh=W7SOyNPQ0Ezs6lzGqfinIyAzqiPtmSjamB35R45M9IY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drJgcqRWIKIPHpeKyOz3dOsLYLXnTwwLS8YwcITuHN208opfx2AF8tT87PgXWgEGmap05YtwPSQ6zr1d7U7N6bollHAIZic/ajVmQH5ludsqkS+nTnLRQY44YjPg4DbGSVYGUiYvEA4WEuPrU2R2KGnFl2CK1SAi4FISIa6F1F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L88cUrDK; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L88cUrDK"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90e9ad1a373so16414286d6.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 13:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788468716; cv=none;
        d=google.com; s=arc-20260327;
        b=aWqlMuppL7hntn6zcl8p65+HMrcJ7ERz0F2BO5fSvX42ulIdvn4Ezvw8ytCh554BBj
         SS6vTt/802e5DFThgB/RKakJNcwtI7Xo2NamwGS+JCptYUkM4eCFBorSHHebkI/mFrPC
         i4dpEw0lRV+DDGJVmLVeYFp9/wHdFzh3yaLM02dPftZ2O1u9jdDeI7eW0LrqvvN9aEP9
         K6jDp5fCtrBNcU4sXlyUGs8a5Us+Oxmy7pAhA8jwZ1ZOOffEXvlBJ90cbEWBL0BtJJyp
         gZ/4cjcysZkkZTHDXENtNaw0pVs3k5BST5qL8q/yMrdiMKSphC+K9d2GJ7m+YD7s8zyA
         uHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nfvl8S87AZctWYcUNdhuKdRoc6xwr0rL4FUHBrD8bjg=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=J4CTM09Api2Cqqt1MZMf5CmhBz88eudwGp9PMRx1ZCAs/FigMFeKgMu5G7edCwlIWF
         8NL8WuZkA8xgvJiucnVinwN8qU3vVwbWuXK89T3ZyfUzv8eK29UAExqFWyOz9C7CG+mU
         8SjLE1OsKGEJbrWTsagbWiM9EPbz/8sb4oLwWlSDOzc71vnG8juUtBl9vY8iFhVy4Rrg
         oFTVCvUj3YmqzmEYfzUOyN1KZ5LM6slGRmlf19Bu5lLgkSYFitsUV4ZDbB8hWDSz4Daw
         3icK6EKr3NYm/89lJ8cGV3QaCNNHNh64unIbuxUL4NLztKUR5zj9Shh3iulRLLCZYMYy
         7jdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788468716; x=1789073516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nfvl8S87AZctWYcUNdhuKdRoc6xwr0rL4FUHBrD8bjg=;
        b=L88cUrDKmtrlPRxvPQ+c2xOt20D8aMgJIQL0k3ZsAjhSFsQ1OqyUo6rzIWORb5ltK9
         bXGSsrJFgonbz5kJ/Msddm1QXTeSJ20DvPnBPiNvIaeW7Iw7U5BHVwG68vQ/ZlmiIyCn
         qa3d9hwXB1bpKEcx0xd8csNm81+TLi/7Q+O5OSmcb/+MyMmWNuR2jnOf331K4XXx9wXi
         RarBpD/kq9lQdVpt0bfqZqNhsU1NMVluJm8Z0Vw51FKtM9/hqLqcY8Z84vttJPDmwfoN
         D7/21BoUBG1pUIA/7pJ5BQhLTY9r44Q3Jww9EiZjehnD11jfgVRA5B8SyGRJhPwIbBVW
         HrBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788468716; x=1789073516;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nfvl8S87AZctWYcUNdhuKdRoc6xwr0rL4FUHBrD8bjg=;
        b=Jp0CmoAg2sKwvXlUEPMSX/W6IyZcDg66Z59PBlfBu9tw6e2ohDjkdKDaswoIiJCh00
         0BoUNeC7ccTBG2h/p2aqDTz/xHek1DWAXrGlcm5GDr4vfvn1KTW1Xe8KrsleWu2rqqcK
         F/O+kGEz0I13uvluxybAd9WD4UtJrAJVafXBiPusHotWcH91XhVhbElN8RYxSG17TJbN
         WSwF+FIKDZX0zIbIC/4rgizD5Qmm60p2tGsaXIyK4wWXgezuiUgzAKoA2HccoO+nI0eG
         e3idkOBpc0eo7dUUSxTj4FBkojEMvjJtuD2ux6tCMmsccNCLImPbi0QiWp5xquYDeyvy
         ZXHA==
X-Gm-Message-State: AFuF++kvNyYg9vtLzguZroexeiIBliBupw++zPkY6aO8uWG/dwR53oKf
	CuBWMJG5HbsisTCoTpfSIBJfOBiVa8ms01cCYMqcaIGXU7ZCPHXdSDaAN7sVP6Tnj0Jx58FYv2a
	uhD98y62h7V4XnyhuEM2jlzGOw6rzWnQJnKmp
X-Gm-Gg: AYBFou1loIkpV3TRV4gmBNlVpCvKSHqpwk0VAmbIIjmdf6bWMd80zwzYzNRA0xy9oIB
	8y5uu/TxxXJ3hKxedjo45BFDjz8WkxPieRH9JqV+L2aSK2xZMJbX8xtgDLSG1BMYp8cYFlqX/BW
	u6ml6pe6/twyMKrmbAyiY4q/fcg7qGqTzXVHdbL9Tzl8TxhQZ/ORb3VjwlCQgOtemOhN/KSdfaP
	aI7/2rTH6tGlNHN+NdUG6Lguu+sOaKBZdb1C9GvdaDNMe17ZBCcNMnCDfRvdplBz3pi6GtS35qu
	LeTavkkiIqURLVbXG7QXvLdKNObMESjLPVCZ0mm/qayJOZZzxF76mlZDXvd/rTD/FOHm9IMNuFm
	6WCZrFzQk6j5+IIPoAl/SG/+SMj/s7xDAJo+qrWnc5c8j
X-Received: by 2002:ad4:5cc8:0:b0:8f1:5e32:9b06 with SMTP id
 6a1803df08f44-910347294f3mr78498726d6.13.1788468716185; Thu, 03 Sep 2026
 13:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqjyp3f7mr.fsf@gitster.g>
In-Reply-To: <xmqqjyp3f7mr.fsf@gitster.g>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Fri, 4 Sep 2026 05:51:43 +0900
X-Gm-Features: AcwNN1WHx_jK0Zy8Q_W91iCVWk5Mig9fUSAhb0MgegT9qKjbReGmY-GDyy635kE
Message-ID: <CAF5D8-tfG87wuAimom1Jhqpzt_U7MNzo+kmZ=hK=iQ_ECR4cYQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2026, #01)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 10:25=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
> * yn/worktree-ambiguous-remote-advice (2026-08-27) 4 commits
>   (merged to 'next' on 2026-08-30 at 8e7670286a)
>  + worktree add: treat multiple matches with --guess-remote as an error
>  + worktree add: improve message for ambiguous remote branch name
>  + checkout: improve message for ambiguous remote branch name
>  + checkout: extract function to display advice for ambiguous remotes

The following description does not apply to this patch series; it appears
to be confused with the `yn/worktree-add-no-dwim-with-b` series, which
has already been merged to master.

>  'git worktree add' did not prevent DWIM behavior when '-b' or '-B' was
>  specified, which has been corrected.
>
>  Will merge to 'master'.
>  cf. <xmqq4igfa2pv.fsf@gitster.g>
>  source: <pull.2197.v10.git.1787841717.gitgitgadget@gmail.com>

Thanks,
--=20
Yoichi NAKAYAMA
