Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB54279EA
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960439; cv=pass; b=ntJz+VrSmQBBA268eplRISsKpnfmRH57uUBXXLjFt7OE7V6WR69ZR5vIa8Lsa/BGacVhAmuv7lZiTrdmShfpKQ5hKiltDgUAjBNqnv7bRkmlLyvqhQvq/UfzFiMAnkT6HEkSTzHw+zywYKofj/DDMtPzCDSVaJsYw9mFjTbrGLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960439; c=relaxed/simple;
	bh=dIVz10xlL6DYrXc6h8Awq7Gfi4RCRU3ASyINA3J5+Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4FbGhqRGxxh1Y+d0P0kGRc8bm4Aj7Gg6vrtTNC6SaxS7lyWW0qGi0IhMvaORbpD+4pi85wNXhTXIf/JI7nz81ki2uPwu8sNe2HrwRjjNG6ePLPawYRYBdywg65d5XyJ6ZUH7KM7NMS0Ox/VWa/zbPF+hdxF2lhl3BtekmyYjiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAhYbFrf; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAhYbFrf"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so6029752a12.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 09:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783960436; cv=none;
        d=google.com; s=arc-20260327;
        b=Ofsj+fHch32Jp8CeGVkRdPNHFtDhB4q/aqOj86rBp2IQza19YpTL7cyvo6eTr0W0g+
         1bQKYt59BQ+B2DRG4K0gu0+DqZmD73WC0S8MmVZh0S7wqj1cC8fYsQwEA/WtRSRqm5Ko
         YxJ0XlAxjjhfQJHRGHAqPlqEHkrW4v1a1lmMHxhPyfeXQASP2N/H+KoAlVHor13uvLlD
         e8psZ8ezoYbzB5rOUXkfxj8kOzNZDQzW7Lr79Thm7xQRdheoZ3KA4QnsNBT5kKBQxOza
         V3QV2nYWIoo5rd5A4UvSlkvQDkjRnn8AsuajO89RthZ/gkRuX1MJ+RFTySTKElXqBvni
         62pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gR2WOdWfS+M0LMToEUaCGy9LtOiGT52f/qCwPUEOp4Q=;
        fh=AGgRvg9/Yur/Y4a1QVxXRzqj/NYvx+ygOd85MNAKiVk=;
        b=Z2yBKV1AQh8sJApI9ekCKQgeckjTdfL0EvAGI2y8L78iOCGIrBLLBK4JkjZwgGU9+f
         xMwG7oomxCeA46gqge5L5HMSVifayunogEzTDOAxk4LMGybzoLF7Pzo+NVGjFjDjSZJT
         6UjYpWQXHYb9aZJF/9ReyJ/i/HT0EiucY0vYo+rdI+lXk2U5KiPKY4hrv6lg47LPNFAP
         FdD/69d22wkMtlVAH7Z3JBDGzWZ42TpfgTHqm1ns0AtcOUIyt41Ovkvqfnd3hUapQUzN
         fVQQR4a7o9JkoK38WZCr/HVUypDN08lPruoL1rwEYMxaf6kuOWdzlMK3qax7UOudAw3M
         8Xzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783960436; x=1784565236; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gR2WOdWfS+M0LMToEUaCGy9LtOiGT52f/qCwPUEOp4Q=;
        b=jAhYbFrfjP1N7raLzTnnusZLh8JUIONe187CpuicbEzMTyLw61MXDxTxIJ9LBT94Vo
         bdRMU3mfBGVSi/tZfqNRtbEp/CJC1Kg548PVdoXTO9PZPO8xWHLtB1T5xqphQW06ltCl
         vBkYCHQqyuj7dlx/B8p1s3D3f6wBPdqMewkFaoDr20JL86P7KRk0n7kzlYMdmYinRqi3
         fyyNLvATm2S+P7s7xMOKuiPOwvlfk+Sxbx+4SDYpa4NnbiHgftL3KS5JFymZAIMpTvFX
         qV3Bl7Qiijha2AyzhaPDruVXWbNv5zg7GXnouOxmh94EqYbv1RhYvDAkdOhv3Yg8XRoi
         pEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783960436; x=1784565236;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gR2WOdWfS+M0LMToEUaCGy9LtOiGT52f/qCwPUEOp4Q=;
        b=J6AjQ+o39pyx6JDNrMsA7Po10WrkIt3pVXMuN/SAS4L5qbnhWBp2VR3CaHJtAYC1vl
         4OIv4SCbdXF2dOL0RkIoIIVBGlEgZQF1M/ZlZrEe4r5y4HA7hUpcL11ET5/pxdDnHL9H
         YxIw0R+tyl7AwoOV/aDsai40+1Vh0j9Y/3A9QoJJNJQkYSuBEwHk3TVRoMWxb7hhrPqp
         kr7dzPan54BP1PyufWIsPV3mu2xS7QNxkslgCj5bhgsb6GNpgzgN3XFo8pWl9ZKN/zpT
         WAjV30A7xaR6U229C13X3enyG3GYcyYbuDRbvsFQ7BbW8mh92ZrHi3H10CMQDPA5y8zk
         0Czw==
X-Forwarded-Encrypted: i=1; AHgh+RpS413WMcuOGC6DfF0mqElCA4k7nwgbfvkro76yEts369RZhCHAkXMWG5TLhEkyR/2p1Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUFou5CYx26qmlNPznIJol7St3aHai74QkPj1T+66TMysxlLSe
	RN8n1M13UjEVDJep1NDNHeecZuktGuIoGH4TrfPxH6s1Iw2MQfn3spTgwoi9YFsAJ1YKqXSLxFT
	e9otSmnKpW47cLprx4TIm/zHl2I0j7vjaOWh2
X-Gm-Gg: AfdE7cn8E/2JR8DANPhLDabfMhBXNdAWbN7YHRaoWjAqKmTG+/bNkXuj5M/+iE/z1jx
	w6Zr/MnRSDNu1d5BnNtbRs+j/2CxXz9hQaFX4RfjYIiBaboOqGSwucYIJSZ/o91CzjfsOuhwqOq
	nVYVwlfUPtJJNKRYy+1Nv+iIcH02QowhmU0ANU1ED9vulJVrSGxGDEQlFL2SKwm/TpJ3rSfEFWl
	9cApK4fQCbeYa4oWtXRl0P9mPuBAnLffHtmwZHxar53Rhra+7q+MDTvt0MXVFuNMN5Ui86fJgNt
	+T9xCss=
X-Received: by 2002:a05:6402:1946:b0:69c:2fc1:d4dc with SMTP id
 4fb4d7f45d1cf-69c5f25bc21mr3882294a12.39.1783960436506; Mon, 13 Jul 2026
 09:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com> <d52d717b70c80b668e6d3a1fdf186ab4846664c7.1782338106.git.gitgitgadget@gmail.com>
 <f53f7140-b9c0-40dd-8bd3-89917a4eb2a2@gmail.com>
In-Reply-To: <f53f7140-b9c0-40dd-8bd3-89917a4eb2a2@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 13 Jul 2026 18:33:19 +0200
X-Gm-Features: AUfX_mx5hcByeS_Kju9Pj87WRdbmRFM6PMR6JDf6SOh_7lFEvnFJ4vrxo34C2E4
Message-ID: <CAHwyqnVSfZmCm51DcMLR0HHBk=vnZR8mQrXRW4pVvXh4==Md3w@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] branch: add branch.<name>.deleteMerged opt-out
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

> > +test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
> > +     test_when_finished "rm -rf repo" &&
> > +     setup_repo_for_delete_merged &&
> > +     merged_branch deleted origin/next &&
> > +     merged_branch kept origin/next &&
> > +     git -C repo config branch.kept.deleteMerged false &&
> > +     git -C repo checkout --detach &&
> > +
> > +     git -C repo branch --delete-merged origin/next 2>err &&
> > +
> > +     test_grep "Skipping .kept." err &&
> > +     test_must_fail git -C repo rev-parse --verify refs/heads/deleted &&
> > +     git -C repo rev-parse --verify refs/heads/kept
>
> As with the previous patches, I think this would be nicer if we checked
> the output for for-each-ref. Everything else looks fine.

Thanks! Yes, I have already created a helper for it, and it makes it a
lot clearer. Thanks again for a good suggestion.


Harald
