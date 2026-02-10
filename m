Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC191B0439
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770732356; cv=pass; b=nmHNVo9JBwPb3TXDDwdq5QthTpWYTXqt+n6jjMjn92kDlKn64RENXC+av93sxhna/VyEBi25CY4pVKoT+erBiW1sRA8dbad3zyFUrA3UD10iLGiGA+n+Xh5fHy7L4WMeg1C5DhlGhPzW2n6H52v1kZnvaO1NCPnp368YMZP7//g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770732356; c=relaxed/simple;
	bh=IBz9qq2yHhbC8mm3A2+5PqdPHfokU1Q72LwVk9Is1kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7uQvk6htT9VbF7B9BKfZ3D/1dejI6Tbi7x6m3QWbUg3iKsRQfEBdzbjHgOXSRy1FXYvpE3ypNHy5XCP2oBzdRT8aFnGlnhMapKGmCV88qRIkHA1cBnGlFso9qEavpaXLXnuQ71v37w4lyrwCFed/onHuuSuzcuMe5mSKJr/s/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtxUenkn; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtxUenkn"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59dea72099eso4145810e87.0
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 06:05:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770732352; cv=none;
        d=google.com; s=arc-20240605;
        b=aBUazWZ34hjf2mFltYQWMZrb6Y42otrl9WsCbigOSEKjw6uTC75mMiRa3eAby9fFox
         amDrtATl6BdGBxdVyiTDZ0zITDUHMfRVgfE2qgV5UOG1GJANXIN748qjop2zG/fFCumR
         h5bOqdzz44EQNoGJFGv0fePcuJZneznHMHB1CNUVQt5wWr79PT87fQUAz64XnXJ5iGaA
         9pxQXbPqIJaCjpzb6mDW3CDthiPlGY47blZ2Wo1IddrvbdCvkA+C1pS8gBGDhceFpraz
         4E9PiQqMuELB3L488h9cROfTJKM1ndGijYkxUL5hLCVselUWnZZVIsHuxLCCt+j+tl9F
         fuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HdJmLMBSua4IC7pRt61yw200uAbAyoQ02XpRPkJLoCw=;
        fh=3jerdxHDStfgdSZ0H2kPZDd2Qqeqc/b5REIi4x2RU+g=;
        b=HXjAIRyAsNwicHC/eN1eaf01gFVwnJaWpQESA7HBLlBRDVWTv+AmijkMGEHQkU951Q
         qb6si0RR7TtJy8u3/sN6ondyFIe7gSJTq9Sj4fcp3H3tZDhodpGbl0zclaQq78Ix5S97
         ecbPbrmBnUn/yG5TTClI613/aSkiFJHerXbeMD/MIAEHskGt8bJ6vqKURwLNQhIaWDSp
         t2MWm1REyVP53Hpn/fj9943slQrxHtuXX/28NAA7UV1+1TAGx5hH7/4sZWW31fsBUD9z
         tOPBwj/P+xyAmoUVcEd/Y2ZmB3dpAimGUGencqnsIJQmvID8vCD2zbtrsND9DqP3x2IB
         qijw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770732352; x=1771337152; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdJmLMBSua4IC7pRt61yw200uAbAyoQ02XpRPkJLoCw=;
        b=mtxUenknlCu6Z5+NyuO7JRWq3ADl3VFtma1j3wBH+hSUUKGqLjSnGBLKfbfZ6Ivzzi
         tVbJYcmZyV2yP2ZSDxoa+xI7Amm0hNkjjoFp+2cTF3yMHlKDFiPBDAqaIvJdp+e4PcF+
         rfbez+yGS4wsNsAUbgKb0u1svdZBD7bu/GnJWH3E0UxA3K2ubCFYyZNdU1205yeTaRod
         PqfdILb5WbT32LIq78jUXVmezietWjA7P+1exrbjIUh4MGam0EKy+K7rVOWhVRIYwVyn
         yNUbCKMEKqiR87qT4kFnHq95q5W2nLyIFczVSNqAPbiXYeoT9eb6F1+73tSnloFshuQx
         czGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770732352; x=1771337152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HdJmLMBSua4IC7pRt61yw200uAbAyoQ02XpRPkJLoCw=;
        b=D4uAkKWzidaUu2TsN22YWEVvqoK/+53Eq89TMbJJ48O3DmT9P8xEE0LnLzFZI7hndp
         VShSgYfEzMrnQI3sYAzl2Yj+D9VDFmD5HGUk2MvN6bPQ0N0LVMBy+voHenewy+WzAsSP
         F1O2OEFEJH09a6X0ZFaNLSatz2csZCEPQZ+fCqEtu9upLE1ISMzecy/CASI/xaTtoLQR
         1QmYzUopv1vME+mRpgJ3S4/AMfWOFWanyhpfRCdTUkau4f4r/oYDB9Z3m7s3j8qzEKP9
         9JcAfqvpqBaDwg85tE4CSEhREPH6xjjpT0v8MCMJ+UhqSpQluStIg9BTDXP+ljoNHH/v
         HBfw==
X-Gm-Message-State: AOJu0YxTelvXpxxGH0KKd7UFv/KsUlGnLf6izVZCsU176WvYl8ACjqS/
	Yqnilb0VADuffuILVaoe/iPZRRVNyTTmP3KjbTGsAJmeL7e0wXShS7Vyna2y/3VNo5WzfKjAbp3
	VumAleQcPJARyncH9+vElvB39BhtiH4Q52XHDV4GnrA==
X-Gm-Gg: AZuq6aJ1iuSsje3uMy7rW0ghytZAUr86qMhEHZdeQ6UbifYQKkdxqk7+CUyn2DWjCF7
	WaEKGVXYZ0lnadAUzO0aLe+Ym0m8V7H2TyWf5p/6+8PluA8hZ/z1SFS4xd3yOVeLz196SBLUOxw
	Kr9MVfshtrw56IZRl+jiK58AlDysAmNL3ueL145UBkSn9f1ELiFzIIeOWmXW+YEMtf5lsbSaBBM
	D8ke8fW59TK8aYpClSJpKp0RwTrWDSUQunufKIzOrcEKnV/NnneeByP1SB5pmnTmChUzdTjbFrc
	km5X2ISHKjcs0BpSMERbMMW4D5JzUkGrkNSNzp3O9Q==
X-Received: by 2002:a05:6512:6cf:b0:59e:592c:9c89 with SMTP id
 2adb3069b0e04-59e592c9cc9mr233309e87.10.1770732352157; Tue, 10 Feb 2026
 06:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207114007.40-1-kumarayushjha123@gmail.com> <96329bc6-0490-454b-a21b-babb85c98bc9@gmail.com>
In-Reply-To: <96329bc6-0490-454b-a21b-babb85c98bc9@gmail.com>
From: Ayush Jha <kumarayushjha123@gmail.com>
Date: Tue, 10 Feb 2026 19:35:40 +0530
X-Gm-Features: AZwV_Qguf6DE-KbHHQP-f_3ER1K7A_PJp6sN7df-_tchKvNpJyKTTBO6GdRbCs4
Message-ID: <CAFNBzOckR2yfGvLMHm0VZW+iKJTgFxzfxQAskdBV2HQ_3yXggA@mail.gmail.com>
Subject: Re: [PATCH] [RFC][GSoC][PATCH] attr: use local repository state in read_attr
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone,

I=E2=80=99ve incorporated the feedback provided on this patch and sent an
updated version as a follow-up patch series:

[RFC GSoC PATCH v3 0/2] Make read_attr() repository-aware by
introducing a lazy bare state
[RFC GSoC PATCH v3 1/2] repo-settings: add repo_settings_get_is_bare
[RFC GSoC PATCH v3 2/2] attr: use local repository state in read_attr

Since I=E2=80=99m still new to the Git community and the mailing-list
workflow, I wanted to check whether I might have missed anything in
the process (such as CCs, subject tags, or proper threading), as I
haven=E2=80=99t received feedback on the updated patches yet.

Please let me know if there=E2=80=99s anything I should fix or do different=
ly.
I=E2=80=99d really appreciate any guidance.

Thank you for your time and for the earlier feedback.

Best regards,
Ayush Jha


On Sun, Feb 8, 2026 at 10:12=E2=80=AFAM Tian Yuchen <a3205153416@gmail.com>=
 wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
>  >The codepath read_attr() is in is usually not that hot but it is not
>  >cheap.
>
> I'm a bit curious=E2=80=94under what circumstances would calling this met=
hod
> result in significant performance regression?
>
> Regards,
>
> Yuchen
>
>
>
