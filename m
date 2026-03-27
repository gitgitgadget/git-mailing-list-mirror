Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A289E35F601
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630081; cv=none; b=YU5f6HzUfWv3OtP7CuBAqx727fUhbbv+GGlxqNUd1PjX4Wu3vbR7GK7NGGG6yXm4vmBf+AlDP5iOJa4R8sSSpUo76rbHMGo3QrT7WrExD0ZIQXGvgxfH196WUVVaCAsSbVrWBtCrOMpV4pTEExxnsoh/qZae654WgV2UWqaqVME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630081; c=relaxed/simple;
	bh=U+uiCa9Vjzs1RsUdElJCxqQlMx/vxU1/glL/I8dGMa8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=q+LK+zP+A70SjToeN0BnGTn8nGitQPQXf1Vsrj8CBnMk9bz9mMpTMWA5QfQ2eYWtxHYdd9NrltuuGwj5hoBRYOBWHdEeQ9GJ82oI/DN4e0xCpS27KmCQ5CgDLDXWAmXHRyqMSCWybQVSBokpSd1nZfl0QUlWXltmOg/KOpsSFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoIAZ7p0; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoIAZ7p0"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7991db3dc98so26138937b3.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774630079; x=1775234879; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CF9fip8+PWcnIQV5V4722S8Z6YvSRfTzBp93YbtWbAE=;
        b=FoIAZ7p0ut5lf1DNfTcoFFzJ3pwj83PR6gzehsrfNqqVOhgmdXfBaMzyUPW3fFwG4b
         XVi7rR0WCmrZnWWapXW6JOlHX5HIRPTbdm6deFK4oxsXj4Kgk36Cc2nUicPJIihnwutR
         tyrYFkLEazaeWKK4lqCXnqFVA/Hxb25CRyIprhbUAr6TeKtCy3yizRN665TLMsfr/xkn
         6MM9qlmSvRPh2sVSRbtSdXBxpJmhTcitnODrjX5YVMCSk/QxGpezanboshGlnfkUwNZV
         60W0e9asIS4Ps1fKPNpz4Pc4mhLacpd/Nsyv2ayMOF7oQCYy2hRb/K8BrLlw+zcgFDkZ
         rfgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774630079; x=1775234879;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CF9fip8+PWcnIQV5V4722S8Z6YvSRfTzBp93YbtWbAE=;
        b=U7xe38jkG3G3hUqBWH2h9INPwlMVKSaGWpIICDA2CnHK+NrNlb798hxXW7UYIy89eP
         wk2bLNK/9w97dFsHhrdh9FnasmPYQ1+jWmODL/kO3r5oabE5F2SnrN0jC4VOpnH3+PHi
         E2RkX7XmuidiLyLob4M/vO8wfOkuld57XTONcsnGtCVzw0lm8bGaMywniFQrxPIZlzxC
         AZnVM+OmDhqgykFlDZ0HEM00cdVJGM5Ic6V9J+wmE+P+VdjdrAhxH4kkvGfrpnP0Q4YL
         iPxJetSFmdKj5f6jIVwOW1RYVssWLM7pQQtDq35sQGl41ZV6Az9oYDvIk7tLmAqs5pad
         +XZg==
X-Forwarded-Encrypted: i=1; AJvYcCWVw3Y0lx3VfGqs2DSK+Xp6kGlPWH9YHfN+oQj1qt8ZvYcdpxyAWsGgWkDnKgYUW3pCjLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85pxVZzRK097QIBjPAWQ2zxP5bZ9MF1Xglq2kxsttnHKqMGyl
	I/rWS0c9rdUaZHu+HwKY1KiHzQUF0tYgw+IW/65cTjiU/UxyH0DM42ga9TEBI25E
X-Gm-Gg: ATEYQzzdDm47Uu+LpQ3ShL+Cm36mdJOkE/6xDTOVGR7VT7zZ8YxVo6vtSogDvaanzTp
	a8ibM5qIdd+xjFRgwxng6UaSMcAVhRGvRy6KAfJmSDPi1wez419BMBPdkYZ9TOBwhKbB89OvGNm
	FLLLw7ge2Nv/ApAdWB4TkUr3eQU8ijNvgDm0il1Bchem/f+rwz7/qnqM4g6r5WXM9BOadOK52tI
	HMEM2citYOrFCN+yIdcCEoEb6Vz2oOb/bwRFRocfdLd3YUwLvvMGRFaWV4LowDoccpHPelNj4kt
	6MuH7d7fD0zYxwHaA3jcW+nlfRMOP2dR/CPEnKSiQqdtEm5r+mHx6zLRnvUPwJNSMXXM+KRR1v8
	291EPETa3xwnrkMUat+e9OILnjNUfTTgf/PMxbuJ7nF/eOpVtPoVzYutoUN1YXHLkokKpjWWkCb
	rkjIABiXlNtEMyf17POUEDFwovuxh0mxAt4kUqkm07QlhujP9S8dOcMxK18B3PWCH3pmV9OUyI8
	AzPUrCwFGWUQK0uBcXTDvPvxu1/UFTDSA0VQRqPW9DcWA==
X-Received: by 2002:a05:690c:8d0c:b0:797:a27b:864c with SMTP id 00721157ae682-79bde02b5afmr27512327b3.38.1774630079144;
        Fri, 27 Mar 2026 09:47:59 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:6df3:c833:b851:8831])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79b17e4a0absm30565967b3.22.2026.03.27.09.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 09:47:58 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] docs: fix git stash grammar
Date: Fri, 27 Mar 2026 12:47:48 -0400
Message-Id: <4B4B5BCF-BC0C-42A1-A6F1-52FF96EF0BFC@gmail.com>
References: <acXIl2cuBv0ifiK6@exploit>
Cc: Quentin Bernet via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Quentin Bernet <quentin.bernet@bluewin.ch>,
 Mirko Faina <mroik@delayed.space>
In-Reply-To: <acXIl2cuBv0ifiK6@exploit>
To: Mirko Faina <mroik@delayed.space>
X-Mailer: iPhone Mail (23D8133)


>=20
> Le 26 mars 2026 =C3=A0 20:04, Mirko Faina <mroik@delayed.space> a =C3=A9cr=
it :
>=20
> =EF=BB=BFOn Thu, Mar 26, 2026 at 12:17:46PM -0400, D. Ben Knoble wrote:
>> Now, _is_ the grammar bracketed wrong? "git help stash" says
>>=20
>>           For quickly making a snapshot, you can omit "push". In this mod=
e,
>>           non-option arguments are not allowed to prevent a misspelled
>>           subcommand from making an unwanted stash entry. The two excepti=
ons
>>           to this are stash -p which acts as alias for stash push -p and
>>           pathspec elements, which are allowed after a double hyphen -- f=
or
>>           disambiguation.
>>=20
>> So _if_ you want to provide options (other than "-p"), the "push" is
>> required. I think the existing brackets indicate that.
>=20
> When it says "In this mode, non-option arguments are not allowed"
> wouldn't -m be allowed as it is an option and not a non-option? In fact
> if we do try to run "git stash -m something" it does correctly stash
> while if we do something like "git stash pathspec" it does give back
> "fatal: subcommand wasn't specified; 'push' can't be assumed due to
> unexpected token 'pathspec'".
>=20
> If that is the case then there is an issue with the way the usage
> tooltip shows the optionality of "push".

Indeed, thanks.=20=
