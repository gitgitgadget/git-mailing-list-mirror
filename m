Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25E92F9984
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 09:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717004; cv=pass; b=XpAHTTR6HUWuMLePC6POwoyopjrDsZMZ4C9Uq54gIgukGQwsiynTtPRHCz4eFME+TPhOrAVRbTBIMS4x8uymeE6DKBvSY8sLkStxUpYEvDmvh5PbxyN8ZpScgyyup3c0QWnhHVecWw0Bp2WmYTm/ztnfBEL8mWFQVZmz/EUayYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717004; c=relaxed/simple;
	bh=3Ajuf7kOBDtRPcuaMDh8DBWz8IS9VWexrW//tVSRD7E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFJgYXvOLsiSQ9ixNB2R65k/Bu3Z3cXmeeUhnnPaBnBs0Lf9fdpTAsKQFXV4IYrrO3u/bWOIaheKACgi4a7hD0pCM4wns+K6ybvqnGG4l8bmfOhL8Vgh2CtTXfEpTdKb7EFpK0juXybj6F2A5NLJ1HIMbQxMce98bv2dF/Cv9/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbEHX/0K; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbEHX/0K"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-948af5e704cso1219650241.3
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 01:50:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770717002; cv=none;
        d=google.com; s=arc-20240605;
        b=Z6iCNzdbTXDcGV99hcmBCWpTurqZrNcogXKNy4gYpfWubwZndCI4TtQduQHHu4+rY9
         J05vYUFGaGeZwI6aFW83gK/QsOzA5W1HFDcehLAdR5QQwv8eDo/7cOu/05qL0hjUFUxt
         D1zhG/U77Z604ldFtX/0r/g5ADYtOb4T3FKcpahSvYRnRUGIUGie9S7pewvKRUzbQzZm
         GC3V6foX+ls/go86oDVSHg9TO/ZyDog55z+XWn4sGRBESNcFTEPV+SJQNKMixOYPlaEt
         cHqSVzg67hfjiBwCPUobrE/ivTJdifd5c8nrrE7VsdPbgOb5ghKnblBSc83mpeZZuK9l
         q5sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=nEWWJy28z3zUO+X/uvIExMOEGUHa2gsqc5rV/aaoSQk=;
        fh=odhZ9wCYhVF3RnjMJT5QV7Z4qNS7uNJPwz+vEHKzBg0=;
        b=Ar373qLZUP1sM/Fl+yt3O2+1MGAAu9sVIPNZkY0zWTs49sBo/E6YSWoAjY1LLRDLck
         cgRy+mEf817JbuRU9wM4F051wByUVyt44LeAzC1VLL6kHFIKltb0N3HMvh9U0ctGDIIs
         /A/CzHA5a1rmwRqCcCtekwAb1ILpQwhQnvMdR1dsOzTNeiwrHVhTVQPhb3u1WogMCquC
         GF7sx2Bi/vdFsLm8XZFvxo7conkBgkTBx97QBIqQWjEZSPhITmLCx/A3fqh5n44tpmt2
         93CCSew67Zw4nC7wVcTXI8EpyYunkY73/QcKm7Fm7Tqt5hX8IjuArckkx1pyZ/S+GcSw
         nuNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770717002; x=1771321802; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nEWWJy28z3zUO+X/uvIExMOEGUHa2gsqc5rV/aaoSQk=;
        b=gbEHX/0Kip9ePRsZ170EB8IHP2qtuQdG7vzhlrptHh2IWtalxpK4Wck7KvXalUe/4l
         00VpB/1ywOzVoCKZTBUiOdpjgQY6XSWuZBIe6nUaWgg9OUw7ZgayZvcRfyaBBcfE0Keh
         bMvbuqaSzIinVpcmWPO3s35wV9vdv6jrXl5wFL+Z5mV+bnXxdX3BEya7M2TPauDhh0Xn
         7j3YpLgTIBGZZrOVZAbqripa1SAjv0WGWUvxxc5ZG/R8LhEKojxm1GTMzXneUTQNkfs7
         uNQY7osq4cQ8s6OnIVUwaGg6TXlH5PvVg9CG8UuLVt6f0/OhH0PnwQkRMCF3nLEaToo+
         uBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770717002; x=1771321802;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nEWWJy28z3zUO+X/uvIExMOEGUHa2gsqc5rV/aaoSQk=;
        b=hY44i6fnnTyTM0d+3hufEvlHZhWLbEZSJbGvQVlvurWUt0qNKeWxjUnEU5V5j8DaXp
         UyP7NHEyYc8eghWSLrK+LE5O8VJO3OimsaT0tOdmAoxFgi12bl3GgKY9P7s+KPe5EiQT
         8uzBAdpunus6dvCl8zD+qybpUEl1X+L3ajM0VUBQYN5J8uBgjTpL7cr0P7yEEOGX7hsr
         Y84CLeVk2KN/dNwVDMdgdIp9irBstG1zB/Mbb8tgWYxtxCpGCSDi+OdQES0bmIm8kvjP
         7WCkRUhQaHpU7nE128XtwEJgG65KZ3XVHxiCzuLUQf+EezP/WbtcUIctWQ2zZVReMoAV
         TDzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMVhoYxLsdVMgwZzaR1q5oDYSbl6LrSq8EKn5x7byZbaLa4Pycu2VNqHTCCyDV6U4u5Ew=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYQUaS9GQlSWyGbIENmWHlPDeuXaRe2I+1oZyl2xrV6E5NowW
	/KFkyPAHMLrzOkvUuCjyxedXlXKK3/WB2cMSDtihyzX2yR44ylfFYgH604VaKhXFLtvIIO4doxL
	6WRlGxuPXMW+zPNU1FmSmv7RehZx/dCw=
X-Gm-Gg: AZuq6aLp9wBsnvdQYq2a6yA8v/gE10WQb3eOqDrtj4wg5s6b0LGtog8Lv1DoKkCNc2K
	MAmeMqo2bews6BR9Wt6wbV3+46ucZpgYML1/B1ntb/qxDjoCyLsbdQGGUR+uRfzlQmgWr3EkmTE
	T4LQJZszlt9aYmSMbbHTZpxt8idgLQSEdNUYdmpxGmTQDuHtgZuH83aiXkCpgr0T+guAsY3qX50
	vmlLFKbwQyp8qVDPU4PPjfdzYblj9OD9O9vSHEWfh9m8AcydNTvj/XP8l2YqdBkmW3YGXBWkqYr
	F5kMgvTTyMdfVxsEtR9j/knNDocV1ZlZLPndPNurmFWHDI5xAdF+
X-Received: by 2002:a05:6102:c49:b0:5f5:30e4:c8cd with SMTP id
 ada2fe7eead31-5fae8c90cb9mr3333087137.42.1770717001619; Tue, 10 Feb 2026
 01:50:01 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Feb 2026 01:50:00 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 10 Feb 2026 01:50:00 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq5x857v51.fsf@gitster.g>
References: <xmqq4inrahti.fsf@gitster.g> <20260208152811.73213-1-shreyanshpaliwalcmsmn@gmail.com>
 <CAOLa=ZRaWA14sootWSPo5g4Yi4GBXf6HjdkdBY1Tt_+V0szCjg@mail.gmail.com> <xmqq5x857v51.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Feb 2026 01:50:00 -0800
X-Gm-Features: AZwV_QhLJr0POuhfxp7PD6fIjEDe219K1FQb1p8dc2fCzDr5Upsa3PL6XGCGbwc
Message-ID: <CAOLa=ZSkMgvi+KjVxzPe6oq1xfgDwrVvSgkkTn1ptu1hwpKDpg@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status
 through function parameters
To: Junio C Hamano <gitster@pobox.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="000000000000e14c81064a752d81"

--000000000000e14c81064a752d81
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> I would like to point out that we already have a function which provides
>> a main worktree, see both `get_main_worktree()` & `is_main_worktree()`.
>> In short, a worktree with id = NULL seems to be treated as the main
>> worktree.
>>
>> The harder part would be correcting all code where `struct worktree *`
>> is passed and has special meaning for NULL vs non-NULL. See
>> `strbuf_worktree_gitdir()` which also distinguishes between `wt ==
>> NULL`, `wt->id == NULL` and `wt->id != NULL`.
>>
>> So cleanup would require identifying all such spots and fixing them too.
>
> Yup.  That is why I upfront said "if you are ambitious" ;-)
>
>> This also is tricky. We currently already store all worktrees in the
>> repository in `struct strmap worktree_ref_stores`. Here, for the main
>> worktree we use '\' (see `get_worktree_ref_store()`). So perhaps we
>> should formalize using `\` for the main worktree everywhere.
>
> Is this a joke, is my terminal broken, or is my MUA hallucinating?
> I see a couple of backslashes in the above, and in the code I have
> a forward slash instead.
>

Seems like my fingers didn't type what my mind thought of.

> But you are right, ref-store-map does use a slash to indicate the
> primary one, while worktree itself uses a NULL, which is somewhat
> understandable (NULL would not be a convenient hashmap key).  And I
> do not think I see any downsides (other than "This used to take NULL
> as the sign of primari-ness but now we need to use a '/' instead"
> fixes we need everywhere) to use "/" on the wt->id side offhand.
>
> Thanks.

Yeah I share the same sentiment.

--000000000000e14c81064a752d81
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 78ccae469ce08878_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tSy8wVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK2ZHREFDaUFjaCtYOFBpMFQ4Q25xTHhzNng2cmtWYwo1cHVIckpuVG1Q
NTZyaVBDelRrSVNPZVZiczFIK1pyT0U0bFU5TDRlSWNHc2QrV3g4eXZ1RlhoaHZUb2l3NEFuCkJQ
WVF2MXlnQmdhd0hKbUhicTdkM2pGOHpJdWpHRVROamNMY2JhcW5oMlV3WHJxSmtvQVNKc2w1bzQ5
Z29ONU8KcUF5eHp4M2JLanVPWVN2NVdFbkFZaHEzVjR1U3VWSERUMXB5Vm5nTmNNRUwxTnZmUWlh
cXFZZFN4S21EQnV4VwoyUDdHRGJGYkNLTGIxNWh5Ly8rNDFkWDFXUEl5T2QySTBIUE1oSVpaWXFa
bG5Ud1dIVk4zYlNwd1NNRUc3STFUCktrUjF4M1ZzYUFYbW9LM3NqdzFzaUsyRFpSK0VxODBqaTZN
dHBYYzlyRHNJV05KdmljMHQ2MWxLWVNWRmRtbGgKaVFXTW5LQVA3TG5Kb2lTWjA4WG5hUDhiSGVQ
bDl4UXYzbDZFQVZhVmx3YnJKbHdoSWNNK3BCNy9uNzB1cTZuMgp0SGJrZUJHdms5SnVYd3dxYjUx
U2FIeERPbEFaaXhUZGdVYzlhbk8xL3cwSk53UFVFeng5bWNWMHVFbGxRckFaCnJaQ1hDdnNlcjV0
VUNmb00wMWhEVk55VmVkZlBtRE5mSHZZTUJKOD0KPXFTUWIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e14c81064a752d81--
