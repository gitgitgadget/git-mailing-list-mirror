Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C49D3F9E0
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 19:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713726673; cv=none; b=s6ZDgnwE6oJl6AryHD3aaAZWaK8/SK3ZLqmQY1K09nYfXpPtZ2JwO0lXqEae0zdxQGi/7ZoSMlKG7dOtC0n0eDuVfp0Lrv0+8SzNy3bJ9b204Nv2jZaZZlh+GwMnISVqjK4ERDms2AmiLnvneCoaKO+KoUYmEspR9RGzRygeO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713726673; c=relaxed/simple;
	bh=kRP5GEmF2xN8THzbOM4II2w9cgiMzs4gP8bXNKWSmGI=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qYnPSrsR5J2amfa1CzI96dKiqSzC61zoZnjUuFll9AJGVawXiII/i7CR0R5D6wlej3ea5Fe6q+UJzKOP1yNzzEJN6SAw/Qtb+4Lo2sMCuNvmOkerWuhuojAsgUzD8hEM5wQuAiZHBU0YUH+Nwe5yV4eo9N1sxy+Pwdh9vbtfyso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTSP19dJ; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTSP19dJ"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5aa3af24775so2655159eaf.0
        for <git@vger.kernel.org>; Sun, 21 Apr 2024 12:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713726671; x=1714331471; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yebB8tQyrudxfz5kVpEHg17dXsnafgWJzzAruUGDNKI=;
        b=TTSP19dJUV1Bwm6I1+jmythsi4/CgDZz7ouIqZeCcOFbX6KKmnFKeTh7i0aYQVGd0n
         q8ZZsh89wxZCvkOOGD/58Ng2IKyKSvfglVL2cnCznmiPtmWVGhKJRhvTAV9TQtfvmlR6
         OiSxn3QiD3674MPvnOXECOA2tXI5wC+JtC8zUEYK23oxlcbtomhDX+ayjEkAo1AEoVP7
         Z/DedGmvNCkvL0ZkiIhc24W4pqdnXDb8pKtHnpO7CdrqXXGv573irYwxUe0bno08a3AH
         xRmhcSV01XcyetWZbbo71Qh1fd6XFbF6mBffJKsx+nadWd0J24fiA6g+dRahY3qw425k
         4FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713726671; x=1714331471;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yebB8tQyrudxfz5kVpEHg17dXsnafgWJzzAruUGDNKI=;
        b=GLNCjddyFCwU+wx16rN/7qQQZUWqoavksNrV88CeD9K/5Re+yPM9NKNJaC1WBF+/hn
         ZQ6vn+Ntp5ZlZizlkFFa5KjGYRIyhqgHuGWgt+mfTLq2nbrznFUhVF7SoBtIevcyhwWV
         fUXVKvRxgndTgjZIg1xR5aTIymJqiKU07OlSDgjf/RkPf7gZCKMMYRY/NHpUpxQFYkRh
         UhM1QRYTz0VMBWS1cSPtQ8bqkmQg/BGo6ln0ofiHi+HUIrVJ1NFXt+VcdrDWQVB9g4LA
         isPJGTW+oP2XzhIEwXpmdY0j55xzRPwdwHrd93qgUcPSIBK2qzHSO4Ado3qqicI5NM6V
         BHQA==
X-Forwarded-Encrypted: i=1; AJvYcCV8Y29IlDVU4cH2Pa/rU9Lfh/L3fgtWPm07XZ+ZImfh/ThCqB17Aw1o0xmc9eOsmGhotFmlskr5cpnADDhspCSiido2
X-Gm-Message-State: AOJu0YwuXIce/j676k6ScG/UU2iuAV/TmMiAIt+XK9/zxfOiSZC/3GKb
	QyY/Vvs/yL/c8AvymyxDXOnC6/GJObBAO9BplOALqXOTjRXooZ/qZNDfuC4lLZdULueTBVdhOVT
	6hzO+vbFs48XyCtlV+aQNDz3iZLA=
X-Google-Smtp-Source: AGHT+IHr1/IHusgMIT/e6z5oOIgzO+hfmog7IOZ68IurdskCAVyGe2itfTwiNk9aXpblmOw0OewNLybgHTbrKwVaPY8=
X-Received: by 2002:a05:6871:3408:b0:22e:ddde:adab with SMTP id
 nh8-20020a056871340800b0022edddeadabmr10000876oac.36.1713726671028; Sun, 21
 Apr 2024 12:11:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 21 Apr 2024 15:11:10 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZiNdvEhuhtH87Mw6@framework>
References: <20240330224623.579457-1-knayak@gitlab.com> <20240412095908.1134387-1-knayak@gitlab.com>
 <ZiNdvEhuhtH87Mw6@framework>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 21 Apr 2024 15:11:10 -0400
Message-ID: <CAOLa=ZRsNHgWriZhiCxBfbqS2D6gSytnG9Hy3y2BMK2vV+x0Lw@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] update-ref: add symref oriented commands
To: Patrick Steinhardt <ps@pks.im>
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: multipart/mixed; boundary="00000000000078248d0616a0156f"

--00000000000078248d0616a0156f
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Apr 12, 2024 at 11:59:01AM +0200, Karthik Nayak wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>>
>> The 'git-update-ref(1)' command allows transactional reference updates.
>> But currently only supports regular reference updates. Meaning, if one
>> wants to update HEAD (symbolic ref) in a transaction, there is no tool
>> to do so.
>>
>> One option to obtain transactional updates for the HEAD ref is to
>> manually create the HEAD.lock file and commit. This is intrusive, where
>> the user needs to mimic internal git behavior. Also, this only works
>> when using the files backend.
>>
>> At GitLab, we've been using the manual process till date, to allow users
>> to set and change their default branch. But with the introduction of
>> reftables as a reference backend, this becomes a necessity to be solved
>> within git.
>>
>> This patch series goes about introducing a set of commands
>> symref-{create,verify,delete,update} to work with symrefs complimenting
>> the existing commands for the regular refs within 'git-update-ref(1)'.
>
> One more thought crossed my mind this night: is it even necessary to
> introduce new commands for this? As far as I can see, it should be
> feasible to introduce symref support for all existing commands without
> breaking backwards compatibility. This can be achieved by using a prefix
> that cannot ever be an object ID, like for example "ref:".
>

I couldn't think of any reason that we can't do this. I think it would
work. I'll try to patch something with my existing tests and see if
breaks something.

> Thus, all of the following should work (with 1234 being an OID and 0000
> being the null OID):
>
>     update HEAD ref:refs/heads/main ref:refs/heads/master
>     update HEAD ref:refs/heads/main 1234
>     update HEAD ref:refs/heads/main 0000
>     update HEAD 1234 ref:refs/heads/main
>     update HEAD 0000 ref:refs/heads/main
>     create HEAD ref:refs/heads/main
>     delete HEAD ref:refs/heads/main
>     verify HEAD ref:refs/heads/mains
>
> Parsing is unambiguous because we can use `starts_with("ref:")` for an
> otherwise invalid object ID. Furthermore, because refs cannot have
> spaces, we also don't have an issue with the SP separator.
>
> I have a hunch that this variant might lead to less code duplication,
> lead to less confusing behaviour and also makes for an easier user
> interface.

I'm certain that the duplication in update-ref.c will go away with this.
Regarding other code changes, I think they'll stay the same.

But I do agree, this seems much nicer in terms of UX and also allows us
to introduce `symref => regular ref` conversion in this series itself.

--00000000000078248d0616a0156f
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f355dbfd0cf8bc1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZbFpNd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOEplREFDTkhvdGVVaEdHWDltelBLdkhkeWQzVmEwUApVNmgzUEw3bEFT
S3hqV3AzQ0gzUUFyZWxkZ0xWbTdlYVNXc011YWpaV2tjamlpSCtsQjNkQWtBT0hBeGs3WEUxClVq
NDVmUGZMQlNhUzM5TURvRHBzNzJEYzFZOGczQ0ZHVmZ0M1NkeHJwUzBPOEdYQkJ1bmVCbnZ0MUIz
aU9ETlkKcDlQRFZZalZkM0JDZkhKUkRUdkxuSUdNUmVTbk1JbDFJdVk1a2wvYlhiVXArTWRKRmdC
RDFkdVFSOG1lemgzbQp5N3ozNkFwNXQrbnNKTXB6aEtxMkJQOXRhY3RqZGR3dXJOeDA1MkZ3akJL
eTA2R2pKZlJUR1VwQjJLS1N2clZKCkJhV2RIeHhaR2lLMXhaeUIzMGNEeFZIajlUck9Za3BuQThE
d3NBWFlXZGxDenhybk9OZFZ2L0QwN1A1R29Rcm4KTllrTG5FQ3FzZlhGM2oxK2RVVWphQ1JPb0Fj
VGQydlllUWFVUllTd2VGZU5TWFFtZzY5a0NKK2FMMllIRFlLUAprWFFvcUxXaHhpR01wbHNXSmtY
UFBSMHVtTzdVUHkrZWRBV1VaMXhmYkNNdDVseSt0VEVCQkVXOUZHTjZZSm1RCkZYdzVhZEZIdVRM
QlBWL2t2MjJhUEovZXBYY2YwOXprMG9FbjR6MD0KPU1UOXAKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000078248d0616a0156f--
