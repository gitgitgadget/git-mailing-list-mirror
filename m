Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793261443;
	b=JpVJvvjbaVX6877a1J6WwsVNsPF0s6zvpMKXEn0PUQkBtSQLaxSqUuLSDr/nYNJg+rKs
	 sCKG6CB9xaEu8NO8VgB8fCxKK6fOtbrU+jAtDfu9k6tXxASkHZRyWeLTetWyA5fScu9CN
	 7sFnKZWU9vgxzzASOnXGiu5NT3K8bNiCdGoC1ogzvhpxS2O/1gmoPf++D+6UeEDR/oOn6
	 W6JHUWM71jHLM+1wLf5ykeESxJ+ZOcB4nUBYWOFJYz7qJd+BfgWgIXzSssa31x8iYjqUn
	 Ft66d+fsyHmvAPju6Tzc2qoImCVVTHwZN5o67WG5v6mx5PFvXVgiK9PGHeZD2JI2+AQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261443;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type;
	bh=Ch6EITc/D+qMYNVq+V3SWfyoUSTLqm5RO1n03dhZX9A=;
	b=rvckfbWwe2q24FPiiOT6f/3VP3qC2F58PqplR/ErRz+XgbI9Wh8LAYjSGPN7arWqh+cK
	 NWdv1znBlsLT5lUfNpAhBqiASSf5o7tSoCaQhW5liTQZVBalj26LqnPuCY0xy/DrfZWQH
	 s5PNbQtrmNYMzQ7yyOu9JvBpytEZIMzDr/3cP9e/cl513E8ydnOWKSwCmD6FGb4bkPKAP
	 n2aU6ofkKOdomDWWJZoQpHINTwU4ehfI7BCZCiLwiakMM9lDm1CNDQFrxUvio9ZOZNg38
	 b0iRscMmI2vXQ6AWLinSHfwzYZx/NyqUb3zjcs9XeraAKeJiTOTdZNINlSEd5RTs0PQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wP+/zahD";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C99606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 08:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03C99606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wP+/zahD
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ab4891fc73so17330531fa.0
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 01:10:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793261441; cv=none;
        d=google.com; s=arc-20260327;
        b=GBZDJW6gjRDLIpl3WHfX+QGdv3LeSc9K0x65VkRKy2Wxsa+xrP9zidFRp1B8hrLrGj
         Ue2jbwWbt7U8zkQbBPQ7V0aq/mmHGrmpwCm/Cg3UDhAbD+XGSQzo+z3HVqdK1Y+3l4ae
         FE3b0EW+BdCCsHmWJfzcpYQstPS5mLqKrS8QyX1gqGOpfbTqhVX5ubHs6FzcsZQ9JcVx
         9OqDC/y7hwSce+L4/ZOHwY7n+01m2Ph+o6EF7IAG/yIvd2Hgd+Gl21ck/vde+dmyMgMt
         DF5ySJ2g1pIG5V2OmAQ8vC6WtR7W+Z0I4kKkwmYnJ0aFRiVBsD0IYkuWqodByVdZ5KoD
         y02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Ch6EITc/D+qMYNVq+V3SWfyoUSTLqm5RO1n03dhZX9A=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=a1oFFcu2jWXRyxu/ApqMhcjcfQpCfDev6kZnTyy5N67b/mMGOvr0JFaCAlYkbU6oCh
         3EgJrqP6E1Gxyk8wi14ZY5YExrz233NNDqFP4AlZDj8BJFjsu9iQQaOQWvQFLS5dm1va
         mR0O4zrtfk7WXuy+Qjn9hYJTSRdwY+RZiuff9XcuPQZ5AlMHh9MmCsQzSTHFCol/CqoD
         b2NmvcFOtPt+wqMP/l8UuJldbwOnBFeHkbiuYeoZ5+xEFRKqP7ALqFx21bsScim7fAxo
         tXlGI6mThINmnUZZFPKRKdRnws2elZYEs1jDPpJR6UzoXzRTEtfTBxRZUlPoG/9k6lyD
         PqQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793261441; x=1793866241; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ch6EITc/D+qMYNVq+V3SWfyoUSTLqm5RO1n03dhZX9A=;
        b=wP+/zahDZDtQlW6ApdzJdlQ+w4CyQsPeSWqEbhcWTvyhYKXDxRusA37mV0UjAhLVTF
         m2plUNAkC1UhnW219ChPdGkjG8RQKj0Plc3a1871A8UDRiPTcaYOtIktC5W/A1qzoWBv
         7SI1u/Hh86zibS6siW3yAutR4ZrvUE/jHpkhaHiHihB2JjGgzC5YjrzA/5vAL8xEr5Qs
         rfJhW8cPbAoKFHfF3hFGYvcnEx+FDRbCm9uxmLxvGNTrKdx2Gxysk1g+T5tJ6VwcRNxh
         SU19cTSSb5MfOakuewJ2goCsX8FrLAqxWUbhNx06kRv1xfJX/y/Cm/uUb79rHy6gIYRS
         rxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793261441; x=1793866241;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ch6EITc/D+qMYNVq+V3SWfyoUSTLqm5RO1n03dhZX9A=;
        b=SYC6eCm0Yx2p2LQfTaAhpYWRz4061xqsllP68mnDfqC1cqFM82C32maIQGegL9tCeb
         mU5cd59cgNJPCPoloTXdEwPmOVPyw8GkAOP3ct9yGINdN5dzNmV9cuSZsqJtsLhaUCeP
         kIM2H9G4aMkbZoazfEflXRqMUsw+78I7x4HK8gbdrLyE72uXsIU0wbE9PgZgJt/lqqa3
         G/uKTVVlCzHcQDIdW4VvI3CsTMbw25MTB/GZzDZ89n/R5BtCYKuO4k0jQnxbIfY0pkj5
         5ZEXv+T2YCKWwOuC/BMpXlcOqesORnmrEaKX5820sXbO4OY8dCUDMB7SSSfNsHGn+w6k
         0QlA==
X-Gm-Message-State: AFq9FYI1tKy/9tCaZRBciSahNTCxQBGveCJaeQ4fAKl/+1Yh1MwgiboQ
	S9hqiJ/IM32lYBumwQSqWTH1WoSIk6tnJ4EEfSNHQy96HZzldoEKit3yr1h191rNk061RNRf/Co
	BTKRallDigtjYbIb/ca0I8ocjas9F6+i6lSvST9w=
X-Gm-Gg: AYBFou3prVknjNZF1XpxIGZ4AB6aRTvshs8gZLFSbyLpj3dBAqD1kuXfsnyQIibsTYg
	VXm6GBHX2uprYYdWSIhOiN6EpBQ0a7Y+hLUzLrPpew54croH6q6M3jC9v4s1fv5cE/FqWpm2WC3
	I33aypevR8AS/PoowhQ7hia09GVauZmcxQ4xztcey/7b+Gk5gtpl2mQ722phi+7g19ZFov6Fack
	ikDhAENK5dp0FvI9FC9+W5un9/5vFhc6V4wD8desCHmfKdDIxiCx2l4l5QETyzOTsfZ4+o3NYh+
	9oaq0iANuqzTQ8w7JnP9kCQOLVwW/a8zhvcuEsWb/ClD2qOlOzSzcQV5y3om6yB11FZ4xxeqcvc
	ft9Hc/1nqCM+IZpfsQdz2WuB4tSaB7BP1T+KhwehCv583kN1YT7hfvv3CpnWfSyJLvlI=
X-Received: by 2002:a2e:a9a5:0:b0:3ac:45df:83e0 with SMTP id
 38308e7fff4ca-3ac9cf7847bmr10007431fa.17.1793261441018; Thu, 29 Oct 2026
 01:10:41 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Immaculate Mecha <immaculatemecha87@gmail.com>
Date: Thu, 29 Oct 2026 11:10:27 +0300
X-Gm-Features: AclHuK9CCyCFLAmkFIZEr5OU_lywNEYvhRJ5S3KjycPzd3ncC9jAhv8byM654uk
Message-ID: <CAKUOgLz3sefhypa9yzLszW43uQ=Jor_nRBAJaBXXv0d8M2ePBw@mail.gmail.com>
Subject: [Outreachy] Microproject idea: modernize a file-existence check in t/t0081-find-pack.sh
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm preparing a microproject contribution for Outreachy and have been
exploring a small test cleanup in Git.

In t/t0081-find-pack.sh, line 35 currently uses:

test -f "$head_commit_pack" &&

I'm considering replacing it with Git's test helper:

test_path_is_file "$head_commit_pack" &&

I checked the file's history using git blame and confirmed that this
is the only test -f, test -e, or test -d check in that script.

Would this be an appropriate and useful microproject, or is there a
reason to leave this check as it is?

I have cloned Git, built it with NO_RUST=1, and run the test suite. I
have not made any changes to the source yet.

Thank you for your time.
