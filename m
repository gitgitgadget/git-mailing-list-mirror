Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1128B19C560
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 16:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731946589; cv=none; b=eMq/AqUEB2VwnvYBB7SiKP8bLYGTLPs/IdwrsipirAj2OOH/XSOhbEeuu7bAOfojKFSnutCR+f+XoLsE1pkJ1g5d0jpqdsYWVel3yZcAWAWwjzrAyD4r3KgvQME1AkP39nuPMO5Vt7SwEY1gWqG5aLNw1BRc7AHJofiijV9D4BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731946589; c=relaxed/simple;
	bh=cDGPyzuOrzGqe31osYlkMPZekM5J7q6Yoqcdjiqopaw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QGdNBYk3m8B4+8B/tilpdU2qS6Lt/5n1kh5qG4r4n0B8kEntvdlQG439HXjBNMOpGSOfi6xZJnkov8v1Fug3qE8SgImFzTRHb1d4YudrfLl6qPWyA7siwH0nbcjXDZbUdnZXJ3CY920fLa6eAVrX7bQd65W3OnkiFGnRqpG3mf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFII0T58; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFII0T58"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-50d399891d6so863031e0c.1
        for <git@vger.kernel.org>; Mon, 18 Nov 2024 08:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731946586; x=1732551386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cDGPyzuOrzGqe31osYlkMPZekM5J7q6Yoqcdjiqopaw=;
        b=cFII0T5838zPH6dl09m4gfZPP1FPQxtP+yW1iJ5z01GOQFRvHkSW9Q6UgP+9Hz2MAW
         rg/fBnmMSsOimJiMcS1dIupfsBKhoBplj5R7JXHyAGPdCemJXXzMQ74njRHBk1crZNv3
         uvQcYJU4SZuTEzKIivbxuiVjm24T+GflVUNu9cx5Fjyzs+EJg0FZ3M82Y8b9jCorXIjD
         IwpEgXD6VmUOS9k+AaboQjVXbtxAUEVcaqR4FD7bFHs4/aciPmu38re3z8pjsYYPwxCy
         Ll8F5kKjw9JQ68VPTZs3/kWrSwPOji2oCkDj2gupa4D+OvAQ8QH2iXv6IMjEj5JWnJvf
         IfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731946586; x=1732551386;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDGPyzuOrzGqe31osYlkMPZekM5J7q6Yoqcdjiqopaw=;
        b=say2rkQOv1KadrrMBzyrBO1O16iyMXGmvoLJxytnyP+LWjUReXkqtOdl7ts6Fur87O
         FsLLfooBn2xpaRxFZreNALS2WoNW082Uycrvo7w3vuAeDVdbrRQYPBLWEblouor42+yt
         r3gOdPrwSVnPz63b6/464xE4EPyyBEoJEAt9HwmQqdlzUwcrY0nbMt8scb2YDRe8c+bd
         D1+/8s6ZWxMPGag7yn5viRMuS6bzg7KEVh58X3HvaNhFoTnX7O1Fvg15r95y8sr6gpNk
         fMQzDaJdDcdl1WtPxTkWJi3yx3MseIgbxgqR003naohpDwvMmT6nTb7MjiMCLlSp46BG
         V9bw==
X-Gm-Message-State: AOJu0Yxmq1Ql6xqqWIzxhd5KfL9KgGlW/WtK6gAFls8V8D+ysvtFc2BS
	OS5Hnj3aYABITX4Wjn61h8aJrvduGroEfIGgMM77hkMlYmxjauaKv2fm6SMZ7DqONVyrVrDVP07
	nqFNvOkDmhblx+Z2sffl1EVbBgNs=
X-Google-Smtp-Source: AGHT+IGMAhU8MuUE9n3QqMQbfiDgNwmr1IFu+gZ19/XQq2QZt29UJAWyGWNy7Gsl6gu/JCkBgmyH6eeoalc6zk6vN8o=
X-Received: by 2002:a05:6122:208c:b0:4f5:22cc:71b9 with SMTP id
 71dfb90a1353d-51477f0eedamr11899161e0c.5.1731946585862; Mon, 18 Nov 2024
 08:16:25 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Nov 2024 08:16:25 -0800
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zzr1at9niamTkEm1@pks.im>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-4-761f8a2c7775@gmail.com>
 <Zzr1at9niamTkEm1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 18 Nov 2024 08:16:25 -0800
Message-ID: <CAOLa=ZSP=GCu6_2=BauH8fvetjryygL6vopStFm64K=s7yBp=A@mail.gmail.com>
Subject: Re: [PATCH 4/8] midx: cleanup internal usage of `the_repository` and `the_hash_algo`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Content-Type: multipart/mixed; boundary="0000000000000560b20627323dbf"

--0000000000000560b20627323dbf
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Nov 15, 2024 at 02:42:17PM +0100, Karthik Nayak wrote:
>> In the `midx.c` file, there are multiple usages of `the_repository` and
>> `the_hash_algo` within static functions of the file. Some of the usages
>> can be simply swapped out with the available `repository` struct
>> available. While some of them can be swapped out by passing the
>
> The second "available" should probably be "parameter" or "variable" or
> something like this? Or it just needs to be dropped altogether.
>
> Patrick

I think it is best dropped. Thanks

--0000000000000560b20627323dbf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e7f5334dd4defe5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jN2FGY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNU54Qy80bTJoK0xCdGYwOUlZbTl2c21FTktoa3BLeQpweS9HQVlPSHBm
Y3UvQ2dDc1RLWm5Id2dPMk5Ub3IrbGQ4NEZTMkpOOEhyV1IySFU5WWhRdTYxSldPelVLcHZRCkdI
bzlzWWRVclZZZFdBSklsNDZOMUl5S1VQUVRBTDM1Nmt4OG9tWU5KY1dxb3orZXFMT0o2bmUvRGg4
VHo2dkoKUEZ6SE5iZHcyS1BpT1E4a3MrQ3MweDVkM2d2TlNOWWtCMytvQVd2bXhtZTB1OUZwcC9z
RktxTGNWbFpyYW91Twp0TkRGN2JJcUJZWlE5bDF2a0dDd1NFWWdySElSYzJHekFXVS9MK2d2VGoz
c1AxQ05Gbi8zcytxdlA2VW1OVDYwCmxyN1puQlZyc0pFUWsrUTE3M0pYb0JyZVJKYys2dnZJQjlT
QjlIMEFab0FyQmVwb09aaGRWOXgzOStIVmFlZ08KUVhpOUh4SEhhSmtmNEVPUTdGcHh6eThlZkZx
UXJqSWVueGRLY2VDU29PSElZdkZoMThiQzh6MitCRmxhU1RqTApqV0VCOGhMMSsrbWhNSjVMSnU3
ZjlSWitkaVFtU2xicmZnd0ZzcG9QZk1hcmF3dVA5N0txRkJ2S2szdnZSd3FpCnd4bWZLMno0cDRG
QzBiOWlNRUxXdkMrbHQvU040VU1tM3duOVpCaz0KPVN6MnAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000560b20627323dbf--
