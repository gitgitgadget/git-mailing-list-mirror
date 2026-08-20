Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBE547986D
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240523; cv=pass; b=BbfdL1Oh680LBDFhEQZNrd1JvA2QoOVgFmSbhNru2KZOPBhLFGuWCBFym4eD3RbRIrYi17n1yFpL7hVcMWrvwEOdaeSYrLOPByi9OdTw+4xawMkyVy5uu5mswCk6ejuoivkl9X2wjDtFU5wHAPgS9my2E0MvFt2gicLw9BUic30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240523; c=relaxed/simple;
	bh=dv8htxFsSWCiXyymlEFYBVhgYMrhbKQPdMu9O0812hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtL4hJDz8qkLz8NZOvg+Jn6M7fHrU7zF1rmTD4MEa7EVGnerXpVq0S8jFq2ORdycvw2My8CrSgJtBJzEpQofPH/v2xIYFpN73ZAV3AQHnG9aYHb/gOMrL0zz7qQBegm9b2vFSkOEwWLh5IPofSyCma+kbnT8vcRtuuehFlazOeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0jPh+Co; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0jPh+Co"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5276d598b96so12687201cf.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 08:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787240520; cv=none;
        d=google.com; s=arc-20260327;
        b=KowBIKg8PBkwi3BRY3xPSkHsIuwclk+xHjph/6Q+mH45asuls2MmYvsZcecifN6iiY
         PFxnQdwIPGeLH7WPDw2kx9tM1qlc/lPZ/jjTBGnQmB9/xcJaCY9lw5dOzcija+nRvTak
         WVN6zLTErUJAQM4Hb/OOEUGa1M4GI0IqAvSWuIe/Nn9t4MMOAp/JEeRAZNqjIlJMqUwh
         X8COwsdOrl37VLQnALELYMFd1NhZyGJxNMg/eo7XV3+fUUxRaQE7YQSAZZESXAEI9rng
         pbWy4kbHkOoNVGPOU9c+Vjeyx2BbfUPJK56akSl0nqjo9sbV5N41GrNomKZ0TXEnWl90
         Bb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mWvrbbVB5bMvubvPM1jHTpXSuiavQlziEMa/nU5hgzU=;
        fh=ukSXpB0EXZ8VprUU042h590V1LFVrj36lc/Ud1oRAEg=;
        b=nlDAMBAwyhYST/8bswuS85QX/ZXDC7Mr7CTn/SZCmZ+x70r6qVVMtfZXQ6/ZAdERdT
         XpTtyUCb9y4cp6YMm65WacRI5M7VcntPpwRBfzgur7+B3IJ9yQnWq0vDj74uubMPfeKT
         1xV4VJ5gDNbOBqJGMWV5xn8bpQkPkMSqbftIUrMcX6dez43LYar5XYQ8T1Yq2UoYSN8t
         EooCTmePdr5FhqcJPyxhnu3vJz0xne9EhkjOn9EZctvzsZPxQ1I1/dyUpj5VUPQOQWbK
         fx2O3JZsNmuQYC5ZNAHkqckU8RpD177t9TkH4ONdwPi3vz/wn8ZDhUri+AEfmvR7zWZt
         Nsrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787240520; x=1787845320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mWvrbbVB5bMvubvPM1jHTpXSuiavQlziEMa/nU5hgzU=;
        b=i0jPh+CoAxUKNDC26pH23bDUZ534O3pixGCllifRORau9wvjCxFeK1rVMgK2AEA74S
         pNKla4N9Ej8L6WtqSWXTJ7pjq5WCjVqPSkQxJmai52tmFdltbEv0EF9b6zRzebpvzIik
         J7sk4nLFogA5L2MSqWJPFiZiDi0VmyjaHA7XxH+J3SVqSqnqQT63ML1RiJPwm6OkJ+WX
         bJw6yGkqusYP1G8OE725N3GBV9gRVlyBRukm5axACHeavpAqO4ezyzUCuE/fGeu3Y3AL
         Uv6r1dSYWDv+LXUlyW/GucgDUzakPdcTt9y2mW/k+E8lfjQDdLv3mWA3N7SMmtbcgcfX
         xTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787240520; x=1787845320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mWvrbbVB5bMvubvPM1jHTpXSuiavQlziEMa/nU5hgzU=;
        b=VyMyc5YkXpa6FX/xfRBkLTQuCFiuJGEOd+nSaH8iN5OUV5odq04xSw0zPWnBg0E0P3
         14pwBCYiZM/mnQgi6thiEygfViDY9JkGcJDsX62B6YLDgYRoSlFhg5x5eeIZ4xPyqpBJ
         OTMZM/y43GhE6YZyGEpD2rA4L9GMF3AKLaqYHWbxQx+Rmh+CG8SvAgedui99T/5EIuq1
         b9q2GnYcufDwl5eodPfLgaW4Df36kvpa6Rey44ErVUkYahf2xdep6HZVd6qe5vVOe2c8
         BiX49qFfw+d8OJRNYoOqT3WMbmychUoO6lg+OW4FY7T4SSONuXZ+dix78RybeekNfOfi
         5Dzg==
X-Forwarded-Encrypted: i=1; AHgh+Rrf8/VEWuv95vgiZXnqy0ePVsNO6pB7OqktfKSxq8zEQrtrrfca4PZmQ82ZY96GHuGSneA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVly+K3l2zwMZLth9rKwfx9vqxS76aUPrPYpJieytw58OJl29r
	03KGLfjYN1Ldro1sDKKVM+0sWrCDGWUgxqQ9fP2eFF3FovEC3rZV9B7Gd1bvID7q7dhRvbWKDz7
	VescmLtgp6L1krZo5HWgqVwRJzBy14r4=
X-Gm-Gg: AR+sD11LB10zgcQv4fKmvHIg/+JTxdBRvn8mYNodv1U2mXw2vNiFzKChF4cK2SpfiqC
	cacZIg6UpwLI+4ASnMg8RuAwIedLo27L2l4hLGEb7EAy1rhuny9/RyhJys+RtxpTreB+dqNG3Ix
	2kbxwVoa84FCpIO7YYozfg+vXgcPHvxxFJN6zCBt9MESv8Tvvb/yqcrm6T9CBx9bt9F1IAWISgX
	oOOVIY7Pf96l62abHXxGEQt9KC1dPxW6ux+LvevOdWDo9D5NmqAS2gZxU730iIQBe/9+mxEBsSb
	ae7Om5aKVRoOZawSRwbNZdfeBPJVDcMONdjoandvf97rBs9EZG8SoTUyuU+V6RL9WqnqXUZ+XBl
	n+A==
X-Received: by 2002:a05:622a:4296:b0:51c:1c73:5943 with SMTP id
 d75a77b69052e-52dd5a226a8mr135221501cf.23.1787240520254; Thu, 20 Aug 2026
 08:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
 <pull.2197.v5.git.1787143859.gitgitgadget@gmail.com> <b838fdabb7cd0d044294d54fd30cb51f040505ad.1787143859.git.gitgitgadget@gmail.com>
 <CALnO6CCQppTnw1Y-6ibmcko0dM3hy8riPanD9BNyb+MW8a5nAw@mail.gmail.com> <xmqqjyplttzr.fsf@gitster.g>
In-Reply-To: <xmqqjyplttzr.fsf@gitster.g>
From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
Date: Fri, 21 Aug 2026 00:41:49 +0900
X-Gm-Features: AcwNN1V4YW6DzZk-cJK7k62X0Nw1P0P7NBGSx8BUnYNIQHtrzeXNx6USF-uPIB4
Message-ID: <CAF5D8-u+ZxTrmrGDzHvdPS+jDe+bR6ZAYNq5KZ5R-MRpjWedgg@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] checkout: improve message for ambiguous remote
 branch name
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Yoichi NAKAYAMA via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 11:18=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> "D. Ben Knoble" <ben.knoble@gmail.com> writes:
>
> >> +static void be_explicit(const char *branch,
> >
> > Be explicit about what? Reading below, a better name might be
> > "advise_ambiguous_remote_branch_name" or something, idk.
>
> It stands for "tell the user to be more explicit".  I agree with you
> that the refactoring should be done as a separate step, on top of
> which we should add the new feature, i.e., "give list of possible
> candidates", as a separate step.

I think it's a good idea to separate the steps, so I'll split the commits.
I am considering "advise_disambiguating_remotes" as a better function name.

Thanks,
--=20
Yoichi NAKAYAMA
