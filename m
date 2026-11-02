Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793598677;
	b=p/mYG0ryyPKL6Lgl0mGcCtblB97hGEArTGSbcUyyeIwpyQUxlmraB8/w/ch8RLPHKdkr
	 lFo4s3VmtVSgaG6DJdov1F39ne8oFrK1mUaT3pSuzRRGQK83ifA3A86wYIStq8iJF+MhA
	 Q9FKA8lDZYOV1XYJ/QQn92u9rNol8mbOEAQUknnIRMjGdb8T8YeiEiXjkqsXd9sG4kKjG
	 7kI9xXKQapYShreScRYd4/k94FmZr1FOUwWTniezEJetdAWdP3rSaLj75S83u4TnkhYVU
	 cu2HzTTAExKmV3YOBzpfDkxLqwh/dd0/HzmbiTJds5+RTdhFNsF8u9vWOYoWgEDJQyw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793598677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BXQVwA7G0kjsLPegA23ZoMZrLPjOH4TBqosROihJkYc=;
	b=dXuCmEeHQtFM2jnO7jYK2G5EVoFWp4jlr67833/mJXvLDXuIi+/f5JuPZneMtkTLIA1O
	 v5AVqdRxymSK1QVUah7VlE6+cz3drLEML+IbQFXF3pdUVDKgstZ67yHYPso1F5RFFD1n6
	 IfOjVoto6PgSM2q6/TIvs0GFJxlFch5rphW2Qsj7Ehzo9TnS4kRe3C/E287BMuZo/vKBQ
	 1Ce1Vq/fzmOZn6Q3tq4oVYcDqTZ13Hj4y9vSCbtm9+vWjpCO9FQTAybpH3hf9Q54rOm9r
	 vH9Uog7GgFopIgYVhjuqRsgjDJp9OrB29UN/AQptf1k2EsyRSapj5apt7n5fgafeUbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fpTgXxcI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AB1606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 05:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8AB1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fpTgXxcI
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3a772ec8389so19714031fa.3
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 21:51:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793598675; cv=none;
        d=google.com; s=arc-20260327;
        b=MhJD5cGBdKGxCPrECN6qjviSJpcM5wXexhlhw5wlmaIO9vUj+t3ni0CnG8FevJx7jM
         5OQt6/PfeVqB76O70Dupdz9A1vKwcKSl5p+0epvFt59mx4CddWmbOGK0YUX7/EYdatXY
         lIAW1nNsaDlV2JMT67QSciOO8aCbd/91l6XdI01clCAtEXZp7pQ455DfH15wkZL7pNsW
         DyReL9o2E5+P5XjnUnwhlhkPQ991WTmxWOlGRXbhgVjnXlXY7aL2kAt4IvDyMhHLwM3H
         SdtsgI46pvVjDNSDwcgGH9UPkOh7eJ9BL/awfJn9SUwpOcm82D2KuBpzdAH8Lhv/1vzc
         tdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BXQVwA7G0kjsLPegA23ZoMZrLPjOH4TBqosROihJkYc=;
        fh=fJAHXxZeP2buYEykQLIAC31rSg30qBXXnbeGxM0xcfc=;
        b=iEtf3BInmXH9769+CNHe87XQZiZRVYSWwjtuGZ9qaR5UgIdxYrHdZtmA+dkUlx/vEU
         JLp8R5O1zYq4W9uroyior4R2fWRFk6G+aA2aCQVdyQl4+On95Sd+z53atnjAX676xdwD
         9dWoxrODtjWrcLBhWpoGh4u/Qo34nixvTOybEN2+rtctN2RtkhJ9MxTuuACLQUaT/XVN
         W2O1gLCvjRGP9gSvKnb/wz/rOXjvRhfBJZSPBB0A88stQJTf4kdBb6IHpkYK5wXQcFmf
         5wvJuNuJm7ckaE4I9eCr0JKNG1RLZ+tcLpCtsXTVAMVZl8EG4vZtULdm0dP3wccmpKcj
         elHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793598675; x=1794203475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BXQVwA7G0kjsLPegA23ZoMZrLPjOH4TBqosROihJkYc=;
        b=fpTgXxcI3hR8CkF59jUelLvkFFA2JIcC6lnw6/8o3oUD5DgmB3JnUkXgmFAusyHaj7
         FvyRAREkH/PGhSEvLCFrz0M9Ic35x6Ivkm+JZoZIHDRo5+6ApKUUKeZY0Wz6EiKVk87H
         slHIMaGNo4zekPIGR4RlHpItWI0c3dsPE3kqNQFNGsyYHlW/9O0SdkMfuJR9t7zW575q
         +Jk4qlYNqUO4D0Q8kS8tN54kjpANfIj9qESTaYEIoeY31OmPA96mcQtD3L+Cm4b2rhSq
         LW2vo6M62oFP0jkRVExsLehQdI0QyC3Q6AeJnGckxMYuVBbmvD51UWomZ7uL5JnASR7u
         MauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793598675; x=1794203475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BXQVwA7G0kjsLPegA23ZoMZrLPjOH4TBqosROihJkYc=;
        b=RrJBFV3deHSclcQjtqg76/T8gx+lopiIOWwW2NMooEwMT3eyF5wjh6rzUlZvn5KQbx
         d7iK8Dg9vmwExls3GW+NupDSE/+nRoepksRpzFpgBwdTMy0GNaTDB7Et+fUD+YRNP2O6
         VMujuD9fDYgIFOFju+UvtbGXiGoVTsk7jGmudvN6TAz5pjH9aYFoefwpeAMWaUB+yKaw
         Rl+E5FeXUtIeZlcByiYiWvKlEZd2yaN/dIZP0MQmv2XVQVByt3wAKhmPceilQtesnFAq
         eeHZQe8qlT2GJMAoazFINP9SkNFz8sZ+mE1sDcC3uEWqF6fm0MgeQsRt0/I4aJH49Yeq
         9K6A==
X-Forwarded-Encrypted: i=1; AKwUvBwYLWjGOrkPygtSIb4jFtzskGiu3bKUnvL5cPwmR8HX1wqd0YbpDOCoKqimFxSbAIgMNW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OMAKgwtZsO0CxFf5qwUFgwOtsuIUVrOLpIMIU/gi+TnLPNR5j
	PNpjoedftDMB5rNk8bup/UNEms3IMiaHO4LjSLt/fOy66inM93AamibKMaBAc2UxLz3xlitSKW/
	wpClLY7aHARkK1rKy5oFPeVt753S0HogPRBTPOlc=
X-Gm-Gg: AYBFou2trlxWeIAizkqPuVJK085JQuKNky661deyn96XLDUoBQ1LHUMVzk1mCo8aiwr
	SOrAu4gvj6Xththsu7Xua3sy80AhI95C6Tn0hclqgzstjQZLYA475HGol2Nt4wafwdXVrKx8hGF
	B+xz1xaIJqjBrMmCpYWsOhmfZHXvasoPM8/R5E+GHoba3be6SAtKn19kfPMSJShdAIbLUjdJxPO
	j16CdAk/8mnXFBvMHtrSqQ9vfQ5dpkDBmeZ4fP/L8fPWN9jjmidA07PXGX9ZtNabCmmjeafJfMS
	oVtXIQbWhC9p/h1NMzHV3NGFBYeyGjdnrAmo2e8zQsGkYgGSx2Bq29OFgK4lExbcxUclKpXu2rB
	BiVDgqO1AYSnjwThsZv6tYpzKGrXjcocWx12TEkeQDJe9ccKLfBAmgbCnGsp3EC4Tumek
X-Received: by 2002:a05:651c:545:b0:3ab:1d89:4981 with SMTP id
 38308e7fff4ca-3acb7a98ba1mr21045911fa.22.1793598674861; Sun, 01 Nov 2026
 21:51:14 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAKUOgLz3sefhypa9yzLszW43uQ=Jor_nRBAJaBXXv0d8M2ePBw@mail.gmail.com>
 <CAFpMFfA17dnuLSRt97BrM0u3cHAifJybr_Zc2ahr_zq2nspgsw@mail.gmail.com> <xmqq7bj02wak.fsf@gitster.g>
In-Reply-To: <xmqq7bj02wak.fsf@gitster.g>
From: Immaculate Mecha <immaculatemecha87@gmail.com>
Date: Mon, 2 Nov 2026 08:51:01 +0300
X-Gm-Features: AclHuK8m1bEhVZuRzG9zu8PsYLgfneIrTaNK7_HRNtX_MnKaKUOq6KA7nOcmWXk
Message-ID: <CAKUOgLy8iSh8RtSNoTp6KtLhe0SkU04DcTstERdbnN7xSDb9bQ@mail.gmail.com>
Subject: Re: [Outreachy] Microproject idea: modernize a file-existence check
 in t/t0081-find-pack.sh
To: Junio C Hamano <gitster@pobox.com>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, i sent this project request "[Outreachy] GIT_DIR inherited by
shell aliases in linked worktrees" , and i haven't gotten feedback yet
on whether i should proceed or not. I will appreciate your feedback.


On Thu, Oct 29, 2026 at 9:31=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:
>
> > Before choosing a microproject, it helps to search the list archive
> > at https://lore.kernel.org/git/ for the file name, and to check the
> > "What's cooking" reports, to make sure nobody is already working on
> > it.
>
> Great advice.  Reading others' patches and reviews they have
> received will prepare a newcomer to avoid making the same mistakes
> as they already have made.  Reading Documentation/SubmittingPatches
> would also help, but that goes without saying ;-)
