Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A5640D57C
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782067631; cv=pass; b=TP9n+RCXJvbFZ58KBCeLm9XDgEdMlExkCaeyKqtQuEWH3Vhs1I0WBQamzG8upxAxdStqSv6YtaNJoi5TMQ5p48DSgm9EPAXHq010fAjuXIoquSCqmORc7SAUrYpsYGR3VAmwDdv+/hQ6zGPjLDzOEe02y6TFMrKE8u36j2MZxuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782067631; c=relaxed/simple;
	bh=ZR6ngOTpgbCMoEzO1NWSgZIVWDa10YWERTVjNPEv5MY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NslRTdHk1kc44YbUoDvw8/+NhtziLRGepUxhhIWZT7K8UDYX5D3zOaZLodxlvQyvWMYfZ7iB9nVYAe3vnqwE9d3/X8DUelWtH8EXHpelG+euTubQPNWd6vc0sqF+BGg6Oax0PN9v7eJs8vSiBglLj7Sv8hE1WcT6PzSuPXZA+Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tdi+XqDL; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tdi+XqDL"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-697ad7f663cso350827a12.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2026 11:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782067629; cv=none;
        d=google.com; s=arc-20240605;
        b=Lp5P4o9CZTy1RKgivPZtGhoRUxZ6mX3+DascUcSzAj1R8UN4QSrZbUO3cMO8XMIB1h
         K28t5Itt3rWPxLUGyO8mdWwRd8Yv+d11a8kXVX46tj/yVUnamEZvTcTTc7trfdpw7CO0
         78r6RhraEm3HaU5Yv0vmu6A/JciozIyoh1sjeLS0/qdSRTdEnt8igBA21ezmCkSGbKet
         vXJvKBdrOgL6dahOYYwN4OLZUKvrupXHkOgjDUpL+QHQ1KP5qUsdR1XqQkz90UrW8iAE
         /lTn5lLnDN5F3nZsF1S7xGAV3Mx5s17OvUsHqywJOog1EPjNuNiDJQGSojZQ+lLJVKli
         baqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZR6ngOTpgbCMoEzO1NWSgZIVWDa10YWERTVjNPEv5MY=;
        fh=2CxpmtaBaFNvfCckpc5+EPrDvpdff9dOfxGk08y8kqE=;
        b=iv/7J5cXElj1julhHJrrv74OYG7opkgh2zp2sdUftQhLQLrg10sDPrP8wFwDYpqc+9
         pFJcrwebIVv1/T24Csc76AgI6/14LaanitASTcWjFQZzOcolBGB3afF74Eqsbs3fgRgJ
         neYF4oWlF7URIii3zL+hS3Bm0C1B9JsNX2lpEcldAFpB4soklMPIS0bcXxoRlnDrR7Cs
         styaZchS/M37bGIpFZzVdlx8mzFDnI0hgS5F88rfDHNDhDAXXzzUa7kJ6x64Jo4XGYg4
         tvcEm3slRCnZeZFzbKzO9epYa02aVoJjBsxM20N4qHXwS24zRObsudMUIa657hDqGVGm
         jbQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782067629; x=1782672429; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZR6ngOTpgbCMoEzO1NWSgZIVWDa10YWERTVjNPEv5MY=;
        b=Tdi+XqDLsvp16xsIIq2q1oufrfo0b3qDZ/sbLOaZJCrv5DuvbgkvItv2lVG6qQTgAH
         boYW0jCB25rbjbF3kF3anrZ8AegGXwRKyPpSB4s+82ZGyrCTDzRH+ab3d6GFaPkNfo4y
         hUT4XsAhZbgS8TpHSpJVkixc7H7Nt/J937G0PFKGHlCZN7PZhIyeQRLEPJivbVC+GePD
         1RM5lS32EE13duqro9DrHQMJTCcLohpYyhax5qhsSKmwTl/3dEPgZy3d0V4tuNI+zMFR
         b7hRryha0hqwZB5lCu1bjtOg9nk7koKXp6uwJsBCOnPDgvm9HjAxY2zqATGW6D7Wh0Ki
         /MTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782067629; x=1782672429;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZR6ngOTpgbCMoEzO1NWSgZIVWDa10YWERTVjNPEv5MY=;
        b=l8mVRo20hZTFjYHa7NHhfm1NsKcw9pR8TeYXj1iv7jvP66kJ48Q9/M0s51FjzTkZEQ
         dOvS3b7eQ+y50SnAAeqhWmBYF+/mzp6yE0ajiDRCaVsup4DeBdq6WrEJKsTyKpp8jZsA
         zScXDccvIxBNiVgbvtE+AHcgo2EWKLrJy76HyFil/HoDqy4B+pZlBnJkJU+c9gdW4i09
         oD8qyzjruIh8PdVG21pQN3zfvtl4tYxm6TH17u5dlhZjwv026r6ml4OY5EBIDCSFzZZ4
         6B/xbyjxKQa6gT+0CrxYBUd1oQva+WdqlY5uyjLY65Z0Tpbsm1u8EdltqUBnkXER3Taw
         KQQg==
X-Forwarded-Encrypted: i=1; AFNElJ/G/EyQnCXvvIEDWP1ZDcCvb1ikTBdFB3WI38tHy8Juab84olXs9QpYCDTTndR0IApQC4s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbw3daowBOS6jNnvp5uzawMuNd3b8FRt1vYK6mLC/IUwcnXRv5
	d7ohe0tRpjFc8dTGX24dC6XOZX50pbYbNys7yj9Evol2cf2WyaSzmGo9TQ6rcKUJ2f2HbeXXiYC
	H4Y/cptR81Go5t+Om/b3ouUyYvT7jtLA=
X-Gm-Gg: AfdE7cnJYVfOO1+WEpr5B30tY8Tl8o71hbus1vEH0He/WJ90DjMkh/GdCRakqARn5CR
	PAcYfp+l21Tq0/P28a4QXR8zsyocRhXjO51WqsLQuzmLNjdFnUmVSpTjDTjFZZG5RelskQ04Ih3
	RIqS6/BprGbXwqI8HVqZoh/Rr//ylwnUkOUK3m4RV3euZsnHb4K3z5V7m012kLYIYk7BTImpTfE
	pXrmMhkA6G9zt1D3X26Rt/eNyp8j4hG5dsnETOXELCFZDBZ1du9jZ3cNjQKFfQouT82N9Jp
X-Received: by 2002:a05:6402:538e:b0:697:4ee0:47ee with SMTP id
 4fb4d7f45d1cf-6974ee0de53mr4970718a12.22.1782067628712; Sun, 21 Jun 2026
 11:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
 <pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com> <9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
 <78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com> <CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
 <37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com> <xmqqcxxnsufl.fsf@gitster.g>
 <42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com> <xmqqh5mymt8i.fsf@gitster.g>
 <xmqq33yimsdp.fsf@gitster.g> <CAHwyqnWt59h2HO5EJbFswYr7QEA7oNZKdBt_vTk5axNbWFZbpA@mail.gmail.com>
In-Reply-To: <CAHwyqnWt59h2HO5EJbFswYr7QEA7oNZKdBt_vTk5axNbWFZbpA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sun, 21 Jun 2026 20:46:32 +0200
X-Gm-Features: AVVi8CfGkB5HIAIYC6Eh4P5RUhgcnKfmkuVwmi4dZgm2P5xRNGoCP-FKQRt0exs
Message-ID: <CAHwyqnVce7NKft9AEyCUnR=S_y1ygiXjhf-qmJqmi-tuUXcw=g@mail.gmail.com>
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"

Looking into this more and attempting to implement the logic for
re-assigning the upstream, it becomes quite a lot of code.

Maybe an easier way forward now is to avoid deleting these cases. We
can always add the re-assigning logic later on without breaking
backward compatibility.


Harald
