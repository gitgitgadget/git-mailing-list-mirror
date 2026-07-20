Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88731352C34
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577428; cv=pass; b=gNOzzivHq1GlY0ECiXvK8LQsRhW+D7eGzdIlxwXbJ9cmgQUrWK226DpkAoRdoEdZOAaIWsw3a0YZiQKAkgf9bp9bcb4GF1kIh9wlMRrqVVjhIv32KNR8mIc6xslqOlQS9rzCFIfchU5q+9WkIobzGPyi5hNga5tox2rbWbe5D9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577428; c=relaxed/simple;
	bh=a7T/MGfzanhZMFReI8YSvFFHS4AeP/x85gZXIc/m19w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZpxnFNwL3fBYcGn9jhXQB32StGzJnGE8EX0mS+YgZ0i3RIUkUuoSElRiPmpFFwHqlBVq1kiGjIW6DNZE4/8bjwKw0kbTbiAWBhRXF9DpagQYDVvD01xuwrsCpn+Vx2mzm4lt2cTTnLfQvldAZubc4hFFxQZmtk+5NCRqIk8yd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpVfJC6u; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpVfJC6u"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69c1220bd51so11962981a12.3
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 12:57:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784577425; cv=none;
        d=google.com; s=arc-20260327;
        b=cV8Hyozv8tDRlaXaOm0GUNiKHYYH12KmSkk+g0GvZMfiZzyZxSXy0bv1tlIlkwjPJz
         2xxQTmxViO+hMod6GEDAIxrOQbyWMZaQ9FJkkpJfLPuQWfgilzLRXPPKfYyfx5XpaMoP
         u1tw0udsBRRXxZdG4FRSsBcmasdZ3UfHfyoFYDBvKfQ7T6swZ8KsScrTG6t4zNYo5EPj
         BOZmKkR8YNWT5JFTiS+srVSOSoIz4dt3Li33NcIQQVvZA0JWIZdMdSDE70Txo3vQos16
         FVSwxuRWcDkiv5/YurW73VcAB75INPFT0oISau0YzpfPzvSa8KPdQzJEYc742ozlIwRh
         7qLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=a7T/MGfzanhZMFReI8YSvFFHS4AeP/x85gZXIc/m19w=;
        fh=D+R3Mw3ESfrCLP5krFgFKFmZiutm6kbIEyabfwhs57g=;
        b=lQBqjTFU/0L/KTVYOoYLhTghL5DJrs+u2Ed8IN+dFPQ+F6YV8WEpT1lvLEI7uf2V5v
         X9fruYKeGWKMvbyd8kGSf+cWLRikOzg8BP3ZfyuO6GRRUwTRhVn9l7YJy4O9EGgE4e8V
         nCONgKIy7TS0YhJHyMJD+7GUUVsJ3uZbpkTmNxy8rBtdNjN1+ofYnJeo/HrMRzP0yFW+
         JnOjyWKEANJ6qqdhGBmRzFhXsAlG0zdWRb4a3iRw+ptTc/WyzadgrtZzyFUQnxgfSqbi
         9BK0ZqG9KfBbRp4uW6f9bSPaiPmPq19SvgJBF19Qzgzhon+2JoL+gtoRAPRHD0117bAG
         vWDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784577425; x=1785182225; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a7T/MGfzanhZMFReI8YSvFFHS4AeP/x85gZXIc/m19w=;
        b=SpVfJC6uwfMkWBCQpv6M7W5zzPEDzFutfvMlXnoGOCFb+wuxIAmKnhNaUdRc6f+JD6
         5cy0yXOnsxjDNFJa75LR7gFMcMk3bFAAIboho9hVcclcSIkfZJkB399dzddlGTHrWmjd
         XNvtrPqaRJVqEwcVrHqqgBaF40Xz5A+ok7L3cTju4SIVKv3fKOg0VCK93BdaxG3M71od
         wJHQKD6mypP02H7SpEV8GEnpWrV0nrU2SykbcNbP42QPlSLm7iCpFRoCqzTgIlj8O6a8
         5hLl/cHnlQ0Mw+1XBa7ESru3lGLccwhkhZAqQxSZpr7sTaGysNCX1XoOUXhp7rSmviKB
         WxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784577425; x=1785182225;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a7T/MGfzanhZMFReI8YSvFFHS4AeP/x85gZXIc/m19w=;
        b=a1CNWuWq1oYudDMktd1J9Bg/vDgEVX+sEQl6cGxoFBWQPnROAZtvQ3ZQIUFSSasc6i
         dvpW+xPMQRqSfEWj8hLlXRbI/hrvvV0zoyF8Rw3Dk8j7nRMenySOXVqbSNV/snuZnbTs
         wxCpRy9m2GE1YqVSMmFa0243DR01bRfRgXueyiq0Nz1B+RvRFYlAWuE0VkecJIJLWabV
         WF1Sn64rkq47a8IqdZyI2DP0kVl4kPxSEXFo6ZOqu+8eQ0h3up0FkbgcG8of4MtJeL7a
         YwvhxGj76y5JKWnhg4DpmHSVJAdWYEUqTnl4/hdaRkPqAp579+N4glx312+1K39MJZRZ
         aQDg==
X-Forwarded-Encrypted: i=1; AHgh+RofbbMcmj8InwWm5qQApdM1SGkV1Vx4/yM/rWj5zLj22GF1sHfEvYMb48rYhMTiljbE92E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZOTBPN32QRxn2KaOuj9aX8zp2onE+EA5+H5n+fWSfjXDVmfT
	vfF4za512yYVu7SNCvYDpI9wFE+24p2S4ynlXbtNe6mkPg8r+kT3sKPwRj0SuWnd2dycw0+MraP
	1GV6lYoxBeoLmiMV0jD+WzE1Fa1Hptkud4X3i64I=
X-Gm-Gg: AfdE7cnD0eG3zxIyoS+1Gl3bLlzYI7nWH9PH6W/Sf/Tbux/YLs6DX5bZPp6A0ECghXo
	r708HvsTpmdQbAy0wot6lGtnS/txpHhkuz92YSySSbMcLESOSDxOSOBJEgJeFyMPsQvIOR89+KM
	t5KwLKoiEle8fhbMY6f2qlSfH1JKinvP4mr7zRtPd2rIbAPeD/knKFsyJ62TcgWVwVUJIImICiF
	S8MiTq17EuEzDf4MnOKJEfSylxrK/Vw6NSy1JG3c/nwxN6CvugzJm+6W8zw3Q==
X-Received: by 2002:a17:907:ea6:b0:c12:da4a:97d5 with SMTP id
 a640c23a62f3a-c16b47fe546mr732707966b.50.1784577424290; Mon, 20 Jul 2026
 12:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
 <ff645b21591a4b365b30acaf67a295510889141c.1784538618.git.gitgitgadget@gmail.com>
 <xmqq4ihtcx8g.fsf@gitster.g>
In-Reply-To: <xmqq4ihtcx8g.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 20 Jul 2026 21:56:25 +0200
X-Gm-Features: AUfX_mytFjhs3lVRyuElk2LcaudWv7JGs0DH-KLpjlIPANbz03YrL0e2RJ6M_cM
Message-ID: <CAHwyqnV=ZbthekwTcmrK5twCOgNETW+0Z5uj=w3oKjUK6Hv47g@mail.gmail.com>
Subject: Re: [PATCH 2/2] remote: resolve URL-valued push tracking remotes
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for your continued support on all my topics!

Yes, I should clarify in the commit message what the actual motivation
is, which is for me to handle remote renames in a smoother way, since
'gh' renmames remotes when forking a repo which is messing with
@{push} and compareBranches for 'git status'.


Harald
