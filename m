Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A084BF949
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 18:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791828426; cv=pass; b=kv9BxF0yKamQiltCsW9+G0yt0OiY5GUK8tTvv6Qxm8SGQa7XeUev3c45wR6OPNw2U4CYxLaCApDx31lZbgk6Whv5/BJ9xE+whitFR1dCga4dJejXeTxu6orAwuOgV0Of6TVn38q+BFCFwl4164Z/KaANbPQyXU/8UQ7pPPj8y7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791828426; c=relaxed/simple;
	bh=5CXt/I1YuEF+gQl9nGcnJj8TltZ8S9apjrjZDtsbLpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4ju1qGksLCG4cqEwZfDasbxGdiw0AKOiYjevlKeKpz5vRvZrQF+jgNcsKKOzZvrHtYn7vkY3N4+089/489msG9GsDmPaSxSB1MPU/ZF/2GYcI2mlrT7jmy5NsGOrR39BZycHtVBPbVOOzcMXoqBI8XNLrqYkJh/rD0gbyqF0fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6bPzE/V; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6bPzE/V"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c20ce3c118aso221150866b.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2026 11:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791828423; cv=none;
        d=google.com; s=arc-20260327;
        b=jVH/Z94Ue9Zp27gu17BZj70PxC/Jzwp7mksaREGk5cSZ0rMkzpoGTOkutBKiNPA956
         8tkHjzArB0kiIsxxpBHRukCit9/AfS2w4+t1eEaYHWhM5Fw7XY13fUGNF40dOwtqE+oZ
         cWzn5BgKmeYCvwNkECeDIjRmz3sGWu8vcSzAQeberNOAbyfJL+D+f0UXgFbWHd6a3Anh
         NUA2osZ1Hi9su9uOcZHYhVKZ4CnEVHGkLu4J1G2PZ3t/y3SpeNjtkLRZyfDMDLjm1ico
         qPsZOsyZnABSYbVkBIjCfdtV1EqFQZwZf4zeM8n8AkPj3asLmNMkHjdb/UKviGUJTKQ5
         vsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=N9RXpftN2vYj5CM7P747p6h7BorWxpgCbxMbdjxww+E=;
        fh=9Lzif198SaISN0B3ewSwpRPmQDDG0wg96+SUL1c8Xe0=;
        b=Mlvp1mNN3h5TfpsHHMM2ytdmdrVjGIesG67CL/c8wYACwuXrmEG1mNEGfiu5fYO1jp
         rqgeIDHboZEO/zTiTgn97rardzgV0lL0suv0SdDvswvJqZnxjaareQuv6ZPJUzr6wsUK
         m8ELisf9jdngeU63S68fDy9f/LrQXPL920U8Dh4GPnR0IJ9JHcUzQCKIM//6u777TV9/
         ttrpIh2EA9eVo6WK6Cfypae3IxUB/OhbROEywyibXN3LmtmfZpBI0Fk3udsm9if6irzg
         HllVoUQLKCE5ZVihd2/wZZPmQzsbM68Iie9cMttNMHCX+dJsobLzAeLR9Y1KsEsj0P/w
         4iFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791828423; x=1792433223; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9RXpftN2vYj5CM7P747p6h7BorWxpgCbxMbdjxww+E=;
        b=p6bPzE/VAwzK/We470H0CMC7T7gjIuYD2HV//hfFYk1V5ZajcRFk4B3eeIQ8tglQ2B
         rhPZ/ux4q59qa8FvBv91gH6jXE0f7DBKy8+qDeHLy6nG+8fqdWhzq7XBffoYUKJZX9CK
         7oH33j5FtatrkgDgann6wLA136udjPMbauNhQsoHvbMoVQF2s5UOyNNhtT0mjjiCAhJP
         lF07d4ffzTt87YQBryzqPEYWq+BT7s4WBveBMt5kRxpgvaaEykDIF12aFmKn2zFAHiiP
         TlEsgXUgrd97RsLnkA/WZPC+nNgPYWZFPOJWcBQpqd7YPAb6VGWQLht4dabt144740wp
         RfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791828423; x=1792433223;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N9RXpftN2vYj5CM7P747p6h7BorWxpgCbxMbdjxww+E=;
        b=Ya8HOyUUJfGqJlAT1yAi1VueoCjs9cd9C5iC75Bcd+E7ve6RLoBGA+Np5yW98OSw/X
         VeEw9od70Bveu1OoT81a7SJFPCl0ir+o6te+SABs3oGl70l3JtsFzdaYU1omJAHf0uzr
         Dt2A1x0ac0JWl3fcjnIQvcIqvSO0C3zVbB7K21zXYXzefi9Xdg0zvqCWEKLB5mb0VD7w
         VqNDIhYg3YOst8BVBkUBntWQLLuGI+18Y9XXYIKQ8kwJqHEx/nvQJqGf60YNLtdWA72H
         9mJui2hHyteaet5N/pNAXP0B01dGMH1wJAdsoKezX4SBVCK73+ZyLbYf4xGZT+FH5aq4
         W72Q==
X-Gm-Message-State: AFq9FYI+Sq1QnFG/38/2mI7Fw+7Q/LdlbIfBvFHynzynKTjiuJI1kEKy
	n0DxcOfsnnEBtxMMN7N35Mcm7byS7wDtPhouc1xRFEEz1JZHgs5DfyOtzujjgVQmcQUUxMUBkr1
	mSYfgZX4Zc/bIHBCKx17TB1FWWhMVKxDKM5FGhWyU6A==
X-Gm-Gg: AYBFou0ZCghrVUu5H5iHUF41j2Rd4U83tJqmn6q7W0JnwlDWpgQDxY9gGsGbKdWULsj
	rQISAMvpnZnqF2zwhF/eVb/I8Phc9M7m2fVW6psZU7cJFS/AmvVcXcoT33kBzHpNiDQXBzofIUY
	3+YyMwg4MQlsmHIYGsMNFjSb8S0nX05r5w0j1KgHctHbUVc8Mvwop5gS//Wym70cCOSL3C1mhzG
	6jeLWjDUwlMe01+k0P17RoqpA4zNOoaeDnQONg8I3P49/meOI86lYGuxn3hExbKBg+6X8ERwhEI
	MKinqbOPaKdOFBzTfOGimdwdi/SVzc62f9ANZ8ojnhmbPI33Xg3Rr+eUQGdZh3ZoBzVstGTIMgE
	Y+akKfzXiqMYr/g==
X-Received: by 2002:a17:906:730f:b0:c2d:d4dd:8b5 with SMTP id
 a640c23a62f3a-c31a9fc0b88mr993168766b.19.1791828422867; Mon, 12 Oct 2026
 11:07:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKA8Uu30SPCV9uAtn2K_0sVrD=FEt7DzdgYUWfwtbh019xK0MQ@mail.gmail.com>
In-Reply-To: <CAKA8Uu30SPCV9uAtn2K_0sVrD=FEt7DzdgYUWfwtbh019xK0MQ@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 12 Oct 2026 19:06:50 +0100
X-Gm-Features: AclHuK9XnJvQBP9TyQDRmncPQqzVItxT6TMeKWDjZLNdjs58ilW5PZy2Zsu_Fkc
Message-ID: <CAPSxiM8Xjysm7XbXEmtkMkaFnOcb2wWY5-YRUKd4tGsx=DodUw@mail.gmail.com>
Subject: Re: [Outreachy] Introduction: Joy Gundu, applying for "Reduce Git's
 global state" project
To: Joy <cryptocurrencydiva@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Hello everyone,
>
Hello Joy,
>  My name is Joy Gundu, and I'm applying to the December 2026 Outreachy
> internship with the Git project, "Reduce Git's global state to enable
> Git's libification".
>
Thanks for your interested in contributing to the Git project.
>  I'm based in Abuja, Nigeria. I'm a software engineer specializing in
> Frontend Development (e.g., React/TypeScript and APIs), and I'm
> learning C through this project.
>
>  So far, I have built Git from source and run some of the tests, and
> I've started looking at how global variables were handled in past
> patches.
Good.
>  I plan to work on a microproject once chosen and will send a patch to
> the list soon. I'd welcome any advice on how to approach it. Thank
> you,
>
Go through this links if you have not already done so:

https://git.github.io/General-Microproject-Information/
https://git.github.io/Hacking-Git/
https://git-scm.com/docs/MyFirstContribution
> Joy Gundu
>
Thanks.
Usman.
