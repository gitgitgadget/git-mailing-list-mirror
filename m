Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C70F60266
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057343; cv=none; b=Z8cZt/A5COa6frNlpZN/98y7u/mA/0uWjNqtLqNPjGLLXY/HGPbqbpVRrn5yFyPSXmh1WwHsUlHTdeNPRTfUHHvsRF4pWidx/XFopLvI3kilbOKj2qB1PUifCfP8mufh4K1PhXH0Jj//oNmgQkBRkv73TP3QxLk0v42957/2OE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057343; c=relaxed/simple;
	bh=rgH5QWUyqU/JGBPydbcsHxUiQRMnHhsXK5DWLqjhFHE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dpYJVNjpW25x+NWQglSJTGOI58vE3f+8TafS+bwgLDcxqIiV6xOjZ48xiCXWgTDUMeAJSrfkNIzjh1LsSO6yCmYLWx/4fNM43saI6wEP2E89AD8rPl9wO1J27lw+y7O/CQRpCYhIOYvfuQ+eGwBZlWAUurQLngCIhoLkR0/jjYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObtkRMVH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObtkRMVH"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4156e5c1c7eso5825615e9.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 04:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712057340; x=1712662140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M4VkeSWsm3AkCg2xg63maFlWDv+BUGLWhqwot3Mm+ao=;
        b=ObtkRMVHqVALaEF9AJm1Ea8HFb49KApg0Qxi8hdiN/If+hQSzoooOljaBbsyfFpO36
         i7TWXrFSvilmbDEdtuS67hW8Y/DHdbyWQj399YHdtNf+66h8vHxRDkI1vCjjVJwyF+4f
         fV17X5trXnBZ3KCKEal/iepIDsfla5uocvtYulf8uDD2V4ptEnv1w395K+V8Pvg/5T3R
         rra7gLHdkbgJi0j8LrGlXu5tfioVjgyuWwkvKyqIOfa20KW3X/jtgL15lB68E3d9rNJQ
         d4UQpRKg23LrGnn66TEqxNCfpS35eCv14vp9LKmN+WYloFRay7lqRI3fKulwnckx+QbL
         6rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712057340; x=1712662140;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4VkeSWsm3AkCg2xg63maFlWDv+BUGLWhqwot3Mm+ao=;
        b=HX1aMOfBF+k3Q4BM8LnCxnDxuYGDzqVLiVoUL1Dx0dfPejDKqE/vUaG9XjgBDALjjL
         vKqNfxmF7WMtXslvMWO+jaIeGSoTXCmJ4WwtrH6cjkoR7HHHavr3ms9rfQawfOzTvHcs
         6is2UcOWKXfPVvJSQvNoduxbf1roxugLkemwPUa41fi4WkzVMruS8eklV2bE7hOywem+
         BN4U7Tzyc7kO5ltZVuIoWf05PA26qN2eOdRNZHs4O4Y5hIUlOe8N4LOpVam3kG8Alg/v
         //EuPZcrTko8wQEsCUfLiEqoalpSg3KWe4TWis7dOwCE6Qbsqa+ZoH3WTs8Uucosmi5p
         kVNA==
X-Forwarded-Encrypted: i=1; AJvYcCXy6PIbNu0svIh6F9RisZbMEGRlG7a+pMxQzAr3nXkbI4syWV2DZdPcAH/kn1p8QgcMWPdQ3t5A6hyzDx5MZsgBxt/o
X-Gm-Message-State: AOJu0YzoH+iaAXFCn1vmog5reompDtCGsxme1AgcKNxR3BFISoyKbMJU
	Mjn2io7fKa0QErBAJ/IBxSrUFK61iAId03O+xU2GrUIFzgy2XzKi
X-Google-Smtp-Source: AGHT+IEDw61NG9G9qRrvMI3bS4Npk5z8HadpE+b+Ra2aFjk7SNvpECKW5vA7m1Q/CT8rQPraitDmFA==
X-Received: by 2002:a05:600c:4fc7:b0:415:f758:9060 with SMTP id o7-20020a05600c4fc700b00415f7589060mr1656033wmq.12.1712057340202;
        Tue, 02 Apr 2024 04:29:00 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id w7-20020a05600c474700b004156ca1df95sm3860977wmo.18.2024.04.02.04.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 04:29:00 -0700 (PDT)
Message-ID: <740d1f1a-40ce-4714-91bd-1ba448e9d672@gmail.com>
Date: Tue, 2 Apr 2024 12:28:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug report: spurious "cannot delete branch '%s' used by worktree"
To: Tamir Duberstein <tamird@fuseenergy.com>, phillip.wood@dunelm.org.uk
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
References: <CAEYvaskGHYrQgke=gf1sXYhrwbd+SeTpcjGF0fpxK3hQbyPFKg@mail.gmail.com>
 <CAPig+cQWW1sLXyTBvk6D+1h15sZCtQO1opfhtFfiHr_kX0y82g@mail.gmail.com>
 <CAEYvaskXRyxNTLNeRPPyawFrBVRgCbSnJiuF7D7cOGiaDq=V2Q@mail.gmail.com>
 <CAPig+cQdFi5zBkDQWTEWXCTt5h9gVFNJv7obf=tWCkOvsaEHEA@mail.gmail.com>
 <4041487e-d8d8-481c-b490-884e31f533a8@gmail.com>
 <CAEYvasmb1TjwWpSbfSAogbOiB64sZQiHVoUhxvY+NoLmXnRuHA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEYvasmb1TjwWpSbfSAogbOiB64sZQiHVoUhxvY+NoLmXnRuHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tamir

On 02/04/2024 11:26, Tamir Duberstein wrote:
> On Tue, Apr 2, 2024 at 11:10 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 31/03/2024 07:49, Eric Sunshine wrote:
>> Thanks Eric. I'd have thought that "git worktree list" would say
>> something about the branch being rebased if there was enough state lying
>> around to prevent the branch being deleted, but lets see. What does
>>
>>       ls $(git rev-parse --git-path rebase-merge) $(git rev-parse
>> --git-path rebase-apply)
>>
>> show when you run it in <my source dir>? Also is <my source dir> the
>> only worktree?
> 
> % ls $(git rev-parse --git-path rebase-merge) $(git rev-parse
> --git-path rebase-apply)
> ls: .git/rebase-apply: No such file or directory
> ls: .git/rebase-merge: No such file or directory

Thanks for trying that - at least we know it isn't a problem with 
rebase. Lets check if there is a stale bisect (sorry I forgot about that 
earlier). What do

     cat .git/BISECT_START
     ls .git | grep -i bisect

show?

> Yes, it's the only worktree.
In that case can you check that

     ls .git/worktrees

fails because the directory is missing or shows an empty directory please.

Thanks

Phillip
