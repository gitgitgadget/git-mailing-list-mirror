Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCD2D5C7A
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767343758; cv=none; b=VBbtHC9iNAih0b7VlHogUHXLnkOTEcFHku6TjiYqpqxpQ9W3F1S/apzVWsEAC9h/7750KIB/P7DLzxLjawBvxwb5lc9hqJrYxx64O93HhJxiYQE+GZud0sHtIc4qZHvI2nBj3Cf7WoToOBk3pAgc4fyNGYPCkUUoN2HHZRY+i2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767343758; c=relaxed/simple;
	bh=j2ljqIcx5IkFfW+qPYXWmAOIZCvGZ17ZebOIlPr1ky0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHfDI13vH3Aohu/MJBjHZGc6+4OelWP5JQo5qhkwDHkfv4OzJs+8/s85C0Oj9jdPVbq3cwXu+VFHUD8HRm18aFA2PhoCtsPMNSwX5YQjr3rUjpUnPxFmdzSIBaezJ3wYusR2F5GwUXSE/mBWUvvJWpvZXmaTv0no87R6yYQeyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVpgH4lV; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVpgH4lV"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5dfa9c01c54so7683920137.0
        for <git@vger.kernel.org>; Fri, 02 Jan 2026 00:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767343756; x=1767948556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2ljqIcx5IkFfW+qPYXWmAOIZCvGZ17ZebOIlPr1ky0=;
        b=PVpgH4lVWzFnHYr38JWkyQixyYB5kC1ekvswiFucPd4j0iad3WQgCBBYgUi3yTKiLu
         JaLjuqX/l5GAMWtLWyEVimcZHpVafiw9ZUfsCNKTwPEwZ9azxmj1hsEiPhhSUXcOC+II
         i0DztBIIKKIX0I84vWL1lLTuwlkfzINip5usCl0gjm0UGYmxSMoqLLXyxA5CHkcNnEH1
         w2exagutyTT3vlKZH0zJZdTzCvHFNaF6YCh4+59mZDTP7eoLk2Z8ELwLfHfR+ZWs8RWJ
         z2Ps2OThRZ7saHuBKE7wwV7PJ9vewGVbgOiiQVq438EagtJCeQ/t1JWFEub4FWGRTbrp
         oGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767343756; x=1767948556;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2ljqIcx5IkFfW+qPYXWmAOIZCvGZ17ZebOIlPr1ky0=;
        b=BJ7XHEDGWq/VevV5G5ML6xhrcPtUTC1uwZAfwpiXaDa5jHjXufvoswS4Skf9cF7rGR
         SKz6oXtfugcAskOfv1ILBwiRpYaSB0kt5YXdxU72xAMESDO/CxsVtPW+iVgVEQEF/Bd6
         kg0iaImA1NvyOj9PPGuCpR4vYiuxzXfkFOXsgCPaiE9J2INQnf18l5KrhyohJovmBlFG
         6vF6rCXJK4Zqx9dYZVZNh8Rpp/uIrD8f9+rHrOjLV6hkYA2TL7w4cyZnLWchyTAQZeU+
         Tu+VDfBq4hDDU1WcYF9B8jtdWz9fL5lO9/kBivE9/jOf11z7ol5+U6jVI+sdFRUZf8k+
         sEdg==
X-Forwarded-Encrypted: i=1; AJvYcCWujBPfaHaXdsri5JjkwRkuwkjV14lwQhN8hvfOGii9wdLAZ7cFPdG+79SudIx/HcqChMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRj8QZSE7dNotcc9fTzLPtCbsSVgbrOTQwvg1354EJC8JqOJz5
	4UIejQ9MeQy4Ba679qUYLyVsZDyPtJpiBzjchUO8NdWjJu3YYXStuM2N0K9ZAmabZ1bfVc56SXs
	OHUYFemKNgeXeBmz5ZNbbZQLuVS2AsaY=
X-Gm-Gg: AY/fxX7wEMyGOLVJhLMlM1aP9dgSuWp5/XSi8FOnaLcevV11sx2hUAw9A9sS9VhTRS6
	VlQdVNOBf73ASjNpsA/8Zy0ZgNHU8JuV8f1RvsubskYrxGEGWGSwCHQwlh58XEcKwtBjDnshvp1
	nagr+qUdC8wClqb0coLpmCV6YD6GX041XSMG8VQESWSlYU0JPSmEWPakGOygtiyUpaKYNChBTFN
	krb58pldXsksnpWciBZByyokjmKXQPdoj92EZ3/IIo1TmTBuzhw3bruG8/oBi9cyE3SEyxVXfhj
	OvKcmRfYLEZiXfAeGTp2PZ0OclSPSg==
X-Google-Smtp-Source: AGHT+IF+r2HWQpitaQB80S71PKKH+5dxS3DuUdLKSpmamky5/63R3YCHgI3sVZOv8NkAw0fY/LFirnbW1VsJGp5w79k=
X-Received: by 2002:a05:6102:8021:b0:5d7:debc:ae81 with SMTP id
 ada2fe7eead31-5eb1a6263f6mr12871211137.4.1767343755801; Fri, 02 Jan 2026
 00:49:15 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 03:49:14 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 2 Jan 2026 03:49:14 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAD=f0L88QW_tL2iKg8ru3mU7t-vmY=p61S33GN+6tSQBMQAjqw@mail.gmail.com>
References: <aUO7jQQAERTe5xYc@ubuntu> <CAD=f0L88QW_tL2iKg8ru3mU7t-vmY=p61S33GN+6tSQBMQAjqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 2 Jan 2026 03:49:14 -0500
X-Gm-Features: AQt7F2qysGtWgu_upJUgvEFaG8DO88RGeepHup7EVU3iOWQZwptWmUmxfUpihQY
Message-ID: <CAOLa=ZQ8zQKk7Jmu_Pwm-VbCY9u3WP7oC51JBVUSXEi9pk_UfA@mail.gmail.com>
Subject: Re: [Outreachy PATCH] environment: move "core.attributesFile" into repo-setting
To: Bello Olamide <belkid98@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, Christian Couder <christian.couder@gmail.com>, 
	Usman Akinyemi <usmanakinyemi202@gmail.com>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="000000000000c2cf80064763c8b0"

--000000000000c2cf80064763c8b0
Content-Type: text/plain; charset="UTF-8"

Bello Olamide <belkid98@gmail.com> writes:

> On Thu, 18 Dec 2025 at 09:30, Olamide Caleb Bello <belkid98@gmail.com> wrote:
>>
>> When handling multiple repositories within the same process, relying on
>> global state for accessing the "core.attributesFile" configuration can
>> lead to incorrect values being used. It also makes it harder to isolate
>> repositories and hinders the libification of git.
>> The functions `bootstrap_attr_stack()` and `git_attr_val_system()`
>> retrieve "core.attributesFile" via `git_attr_global_file()`
>> which reads from global state `git_attributes_file`.
>>
>> Move the "core.attributesFile" configuration into the
>> `struct repo_settings` instead of relying on the global state.
>> A new function `repo_settings_get_attributesfile_path()` is added
>> and used to retrieve this setting in a repository-scoped manner.
>> The functions to retrieve "core.attributesFile" are replaced with
>> the new accessor function `repo_settings_get_attributesfile_path()`
>> This improves multi-repository behaviour and aligns with the goal of
>> libifying of Git.
>>
>> Note that in `bootstrap_attr_stack()`, the `index_state` is used only
>> if it exists, else we default to `the_repository`.
>>
>> Based-on-patch-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
>> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
>
> Hello.
> Please I am replying to this as no reviews have been done on this patch.
> Thanks

Thanks for the bump, I think reviews are slowed down due to holidays.
You should see a uptick henceforth :)

--000000000000c2cf80064763c8b0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 116edff64cf8cbbb_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sWGhva1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOS9HQy85Nnk3ZzhQVUFEU25saWRjbE1iY1Vaa0F4awpQRlByZ0poTjB1
KzduVjBNZVBpSk51OEdSZHU0Yy84SDZzMHUyUDJ1L1lFakMwTUdkTncxcUVXbkk5RnlQV0pICnBI
Q1dRSmNFajBOay9LSzNrd3lzSXF6eXBrZ1JuVC9XOHFOcGc1SDRMcU1SQW5PTXNRck5rN2t6cTc4
S0hNTlQKN2hBeHZKT0pXWStvaVFwTGViZzZONjgzdVhhY096KzhvKzRhK0FRcDh0eHUybnNxVzhH
TW15Ti9YUEF3L1FzZApIZ3N6ekJRUCtvMWtyRG9kN20yd0dNUzZSRkZoZThuNlJhVWVLS1VWd0tm
L1pvUmlsWG9YQU52Vy9sV1p5RkJmCmVXWkJDU2pyTXpvOC9LYTdjejFvUHdSZWdpcXlLekNJbmVM
bmYrUjE4MDZ2bW5aR2pZZzZqR1hpTjdMTGk0RjcKTDdjVHh5WEZyQkViZmpjbnZqaXV6L3NSOVlt
NlRBcU9YeFBhbjRteWYrbTNNMlB0ZzZQMkVHOUFqK1MyK01yRgplUXZlVU91S3gyNHJsUFo0Rms4
ampsQmU2azUwdW9reFhBc092dGRTbXZnSnlaWnlBSlFvREM3b2Vpb2pZM0dNCmhqRDgraGdJSXlv
WERSaGVmK3VVVm5vM0p1anhIMEFxMjh4TnM4RT0KPVlEd0wKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c2cf80064763c8b0--
