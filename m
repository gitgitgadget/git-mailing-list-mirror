Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04254313539
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774679021; cv=pass; b=mzJHEODqc0f2KWk2LpraERCTSxww0wpufUwfx02qlFZF5W+JBtNrMJBRs6im087ozbdtiKC2KwqbXjY7lPmIEJ1YluBchXMgPFXp834wTOui9ZlvFSBlM/K3Liz6edpL7Y2uTBbn/6yg0WKFeMhX5kXKFeVD4IpR6d+yqfmbZXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774679021; c=relaxed/simple;
	bh=sxkZKA42e+2JpV1CuNPImVmSnA8t2F00daK2/QYsAFY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=oZHXNumNIdQPQExZ0cCQutnk8KLgcHi2/sDuk8evt0Z2SFYRmF3qyireXvsZYbSlTBaWV7rFullB+GyU8CykyZkMe8lQwhQ8laWsTFjZHHIFOmf9UZO/gZ0K4hjy2Rv9MG2e9xfcTPGlWZQW+JVW/AQamlXJSetRe/L3XmbSlqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVgRWxWm; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVgRWxWm"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82a73593410so1141204b3a.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 23:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774679019; cv=none;
        d=google.com; s=arc-20240605;
        b=WgGGy797kWQ7uTVyEP+tDh+jGoQXIeFqQae38MOTeVJrMMSiVMI2EnHlOu9mSfuop6
         Nd1XMM9/Q/on7LInfX9GfRvwYdZQzRQl9pcqAigY0SVgiJ5n6ifn/XJzLYbnhNiycwYY
         FBqgkU9/t8rE2WJV+aBrGg1KAzwtQmL93QtLyoJOue/j+Jma1NvpFJy4bMYDEQBhK3JU
         jgIL0eNilP60G5ymhwJBebUqUQbS4OYw/9K73C6NMi2jR+fGfn4uc160gevb/3UUGISj
         qxT/qNNnwTQJrYZ/Yljb5DNcsGKtWZa4i2FRmz8aLKfV0u+Az2v5q7zLT3kDBjPYus5h
         tfcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=sxkZKA42e+2JpV1CuNPImVmSnA8t2F00daK2/QYsAFY=;
        fh=JI8ha+9b1bnfbFhCq8iKZoIyGdaNkrNpQHjP5X/Vo50=;
        b=deDOXPPKruB418vfCq7SILlA8CE1MPl0Q13XG08U9WwWhFHS6qBPJwpB8pjENMG58n
         YxDLGLTmHd909dJf0/XoCEXuhsTLw8G56TqNP6ZLwOHrvxkZgYgyQmpUpfG866mF28sj
         tVjE1yVWiB0eoe9MyYwJFx1sFLMd4vrdr61O/ApHYLy3eE+aiAf09A+sHbNtyL6yvgus
         uuQkYR8/T56Ydcmn/bcZbdpBZUhwzXNuHShuOddPCnoTQ3N9ZnCe1c6SFiVD/YBnjr/l
         wBSHSc9lTKU58kKG5wTXTNb7+tCo+qVsMYcIhYGXsC5EmzzcBMB3VHB+ly1FpVKbI8Uj
         bHpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774679019; x=1775283819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sxkZKA42e+2JpV1CuNPImVmSnA8t2F00daK2/QYsAFY=;
        b=DVgRWxWm6WC6wmiROq0OQncEdXlmsa3kcCkHzBRxtAlyoCiq+w3nLIUxrLqUWe03M1
         6AIcbRKEoMGBoOv7duQNfFf7sXQc0fak57S9NR+I+h6Ned8G7YpvoqLjmen990jxiX6O
         Hle8Wh7snorkWSi0qatKupzzRcARFBYEQ+eZsbpX/YTaHnZTRzIB+B4BCa3gWir0sUaK
         AFahpQOWCv+W1wMABGyJkXoMTIidtkYuw4/9zCCityzSpWwywhvGgCROVei55W6BTNu0
         itwTu76tvUNbpwpRfR7CIl2+E/RQyfB2h4ZdGC0mgAgkWNjTFaE7KwhBj0p0sbfH9voo
         iZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774679019; x=1775283819;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sxkZKA42e+2JpV1CuNPImVmSnA8t2F00daK2/QYsAFY=;
        b=XFqS12o/SaL1pRZFeLTaIqORWlCLYgvtpRgeFjIYMw+gCluNkHgjJ5NCAVC2/gpaZv
         uR7YXAsZS+CAk3ihywSatro2WQtD82xJvGnduKmGcZKNige8IWTSylbMQdkVDHavfFQb
         lIB/xCA8B9SGMzmgH4XhGQcN97DlKGKIzhGd+o9tpdZEC34euZegm/0EgoCdF9Eo3ipo
         V89KtmpakpQv0TBGeBGATTkgu65MzRFZgmaFtlS7xvgTXZ0OQPANbsyC9Hj66HDwRyCd
         7Q9RLx43PhZHWfqXO4s0xLRUXh3WEBs26GQqEF/hnAHB6yWMO6F5OFIJ/DRPsTceFz1O
         NEUQ==
X-Gm-Message-State: AOJu0YyWU6oHKX4vrk50xTlmloA4CHhG5/MJySozEn9k+L28OFdSocit
	mdNyhpAlypPhNO/Kr3bv/G+NWo+7eyEzEksv7tOrxK1v0M0z5qVbqZ+W+ni1sDN7hIwAWtxbPjz
	dXNXln9gmGTS3UbVm35YmJUGTqZkxZ/c=
X-Gm-Gg: ATEYQzzZ+0gDPd37KERyuJTXfKkRaGEGwCUd2hme9fr7AeVwe9a6e5M5g1gbbYq8WNy
	u6yGX3eyP+Pj9bJ66UvUQ53UZ7Ez6rLKD6lNOJrLiMnaEzIWH2USJgXEkXFfGgcdDNPi99TqyWH
	A2unH/2m6HHEpp2lSXo5gqRDr0B3C2z1247J7LluKT8inNNqejGmu/1wsuS2MNTTLnWOjNq2AII
	TV+OOutNeUjFECV9uHxztJdbQaNuEYsn03s/lEJYdI3KqGoOfQNfGsSr53TNi0Rp9/2fQ5iQvAk
	0qLQa/xZjjFZHTblunh92qhP0BnuUO0MCNcJFItGTNLB7HiOZwY+wxGj1bjFCZzpwJSY6px7V/p
	GizpYyMnaOjWND67gqpAMKSZDKq8=
X-Received: by 2002:a05:6a00:1c96:b0:82c:24a9:d5f1 with SMTP id
 d2e1a72fcca58-82c96057dbemr4431678b3a.30.1774679018886; Fri, 27 Mar 2026
 23:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Date: Sat, 28 Mar 2026 11:53:02 +0530
X-Gm-Features: AQROBzCPsXVOQGwKVAcsbM2DTJ0szfYl3UNKabw8V37k9t5Fqp4IPPakm_qH2HA
Message-ID: <CAGWgyh9a7sfEXcd5B7tv6DzZ6Ma_=+zOK9w1vkwq81P4MRM9LA@mail.gmail.com>
Subject: Re: [GSoC][PATCH] doc: fix doubled words in gitdiffcore documentation
To: Noman <necrospre@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	karthik nayak <karthik.188@gmail.com>, Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hello Noman,

> Hello Git community,
> I am Naorem Ngathoiba Singh, a GSoC 2026 applicant interested in the
> 'Improve the new git repo command' project. As my microproject, I have
> identified and fixed some doubled words in the documentation. Below is
> my patch.

Thank you for your patch and your interest in GSoC 2026

> -and the contents of the deleted file fileX is similar enough to
> +and the contents of the deleted file X is similar enough to

> -these filepairs, that talk about a modified file fileY and a newly
> +these filepairs, that talk about a modified file Y and a newly

I believe these changes are incorrect because the current wording
appears to be intentional.
In the context of gitdiffcore.adoc, "fileX" and "fileY" are used as
specific variable identifiers for the files being discussed in the
diff examples.

In this instance, "file" is the noun and "fileX" is the name of that
file in the example (similar to how one says "the variable varX").
Changing "fileX" to "X" actually changes the identifier, which might
make the documentation harder to follow for a reader trying to track
which file is which.

Since "fileX" and "fileY" are used consistently as placeholders in
this document, I would suggest leaving them as they are.

Regards,
Siddharth Shrimali
r.siddharth.shrimali@gmail.com
