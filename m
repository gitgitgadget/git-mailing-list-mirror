Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E320B13D24D
	for <git@vger.kernel.org>; Sun, 30 Jun 2024 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719763936; cv=none; b=KAmb0iSMuBqkz0P+0OjcCM1Gxm6VvPxIG/uT+YdXU45shq8I2Upx4F/M4z19nDtWTXPELPHCcOp0yQ2DMksrFjgef/mWvUY0vdhs24vLCC4lflCdN7tA4NMqgzApgLl3729RfjUu2rn7shmvdqeq/lypWoxUMEqh2mRVwGmFBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719763936; c=relaxed/simple;
	bh=uzSeYCVnU5X2IMU3+7UHxhLNdyrMtT2ISgs7pGo4R5s=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hpsjkrO0bQnPVEM+DUdKy4KUia7R+OApqoWr8xzeSVpw3GCSauJ1iLH8sIKygmjC4ubF/kLxGn7/1LzEwg5wKPb01fM6RanpwS0Lv9DpqNllIn4J12GrbwrzoXXXmNYg7yU6HyZRpNGoDdFX9BnKuoIY2gJpNUJfC4qut65HXXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVaSvhD6; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVaSvhD6"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5c40a0ad3a8so1796102eaf.1
        for <git@vger.kernel.org>; Sun, 30 Jun 2024 09:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719763934; x=1720368734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9pAx81JE/KhPQLetjjaU7KtXQUOreVWmz6ZIFMNo4+4=;
        b=SVaSvhD6zPhiPTBwTT8cMNPyde0gWHfpuiByCSJ/b3mZ0ipfdmWh+nHOCPSnvdY2ON
         2pghmeNHuVuYKGBNwobJTLRDTyQzKY7bIQwiFiKATy8dvfZoR465ppMFYNwMZIPJA4Or
         4rO6pronJbLPtYqNlWjLABmlGnDYSsADgG7SCJei4/hUAXi12JWUqucwSor1UO5qKnOr
         JZ24VqRnkp86VmZtVLFoD1kLGuoJ1hQTLfUFtq0QY1JA1lhf9GeVOM02S8uUZdeo1CBM
         3+081lev+v/qh+pfrGzxsB1v3FTEX9sorCkiGyQioaHUtd8S6vFm2MCTiqAEaHmvR5D4
         oy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719763934; x=1720368734;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9pAx81JE/KhPQLetjjaU7KtXQUOreVWmz6ZIFMNo4+4=;
        b=XriTXzqPhyzr2OazpGqArE1hgA61iv+CEAcWIIhkGZvSkY7SkerrlqklHqNR+A0C9H
         w6AfFlj6e0Gv95BkwsktL5fCFHfYY2tAbvI5YOZBbr10xnEBFRjgmkditPHlGrND5jPO
         0Zlzgc/do8Dqx/b7we+c1LfOmCC3jMJVpXC5T4w2r8iHm+rpbdQZzJs3zOtMyeQrzP4e
         /9/P5d4TKJUauVOY0xt1XMcgTHzAGtb/G892iQruqWICwI+Z1fFkTGEdFSk6dVmJYA6K
         gLB9fj4nK1rLv98pU59sD6oymM2/b98Nf7n5jR7j9qmACEz483JKWRuOxWs4fYkvD7Zg
         yYzQ==
X-Gm-Message-State: AOJu0YyNMEd1S5oeVvJI4xSiHM5rOKVtObod8hi9w+dfc26x7wshQByL
	8eQR52ugauMILRGLw9vVLPiFeLd0RXY4BToxgnXtLxb0ZPFgEK/QPIjJ0gzDCvyTRK4fpkGcLwD
	YTFzbUZ9DEgV94loeYotLqv4v6lc=
X-Google-Smtp-Source: AGHT+IEA13dfls3vv3EQSk/wYo4+8XTJm2LzK2UeXRfUgBml/TeSQRRa06V8O+HPIhu4WaqBPjIwlB19EoRVJf7u0Ok=
X-Received: by 2002:a05:6870:7194:b0:25c:b030:d07e with SMTP id
 586e51a60fabf-25d97033ab8mr3274196fac.3.1719763933949; Sun, 30 Jun 2024
 09:12:13 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 30 Jun 2024 12:12:12 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqfrsyv155.fsf@gitster.g>
References: <xmqqpls3zhc2.fsf@gitster.g> <20240626190801.68472-1-abhijeet.nkt@gmail.com>
 <03628ece-4f47-40d5-a926-acce684a21e5@gmail.com> <xmqqfrsyv155.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 30 Jun 2024 12:12:12 -0400
Message-ID: <CAOLa=ZS359bMtUd+ktvJgHsiG-0=VVdGWYA2mKCNjc_1BrzcvQ@mail.gmail.com>
Subject: Re: [PATCH v7] describe: refresh the index when 'broken' flag is used
To: Junio C Hamano <gitster@pobox.com>, Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org, Paul Millar <paul.millar@desy.de>, 
	Phillip Wood <phillip.wood123@gmail.com>, Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="0000000000006193db061c1dbe56"

--0000000000006193db061c1dbe56
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:
>
>> I have a question:
>>
>> Why does --dirty code path also not call git-update-index and instead does
>>
>> 	setup_work_tree();
>> 	prepare_repo_settings(the_repository);
>> 	the_repository->settings.command_requires_full_index = 0;
>> 	repo_read_index(the_repository);
>> 	refresh_index(...);
>> 	fd = repo_hold_locked_index(...);
>> 	if (0 <= fd)
>> 		repo_update_index_if_able(the_repository, &index_lock);
>>
>> I assume they are equivalent?
>
> Now we are going back full circles ;-)?
>
> Your earliest attempt indeed copied the above to the code paths used
> to handle "--broken", but then Phillip corrected the course
>
>   https://lore.kernel.org/git/054c6ac1-4714-4600-afa5-7e9b6e9b0e72@gmail.com/
>
> to avoid triggering an in-process error and instead run an
> equivalent "update-index --refresh" via the run_command() interface,
> so that we can catch potential errors.  The code in the more recent
> rounds of your patch uses that, no?
>

This explains for why 'broken' must use a subprocess, but there is
nothing stopping 'dirty' from also using a subprocess, right? It
currently uses an in-process index refresh but it _could_ be a
subprocess too.

Does it need to be a subprocess? I can't think of any reason to make it.

--0000000000006193db061c1dbe56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b4f4e25050de4c37_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hQmc5c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNnErREFDYWlOak1EaHhsK2JYeFI5ZTRxTjZEY1BCegpPbWFuR2lkc1oy
Y1l0MmVoRzc1NkQ0bi8ySHFSd2RLQWk0VXJKYXpvQkhCbVA2OU1tQTd6ZXhXQ1h3NHlVdE5aCk9v
WTd0eVFLTmNrNWhuN00vdUxhejFndFNrbDVDa09KOGVtSlpUNGdzZUpWdDNENXFLVW5GaFBKb0pw
QUpudGkKVGlkSHNKWmI5S3c5dy9YZ1lpQ3JEamlTNG16TVNwZnMyeGdDd2dYcktndlIrd1NNRUo4
b1VXTjVZdG50d1o1QQpmT3dCWDZRTEtINkoyTktjUElMNjRHRnZyb04zM1NtbzA1OW9XS1lKTW5X
U2UzOTNHbGp5VDN1QldPU25FN1dPCm1wcGVFczYzeEFtUTVIRUh1YzdvWTFGZXZFVEZPUEFXdzRo
d1hjZSt4K2ZrSjlPZDJnTEh1VTEwa1ovMlVtcnkKVXFYQU9SZzlkbElsSjhRcS9sM1BjbzJLTHIz
OVBRK1YzbkU2WFp4Yzk0eWJWQ3lpVGVDMVBacVROUXpCcVAwMgpPc0xsWDQwV29TbGtyU1gxY25N
U0N0ajZGRDU4QmJ5RG43YW1USnJUNU40cFEwOGRRYVhYU2wxQnNEVk9JTG9MCmlWVWRpTTdxeU5z
M0h4STFYRDY0WGthT0h2S0hZZTBoVG9SZTdZZz0KPVRCc04KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000006193db061c1dbe56--
