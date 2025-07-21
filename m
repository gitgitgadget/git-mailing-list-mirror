Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4C578F37
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115682; cv=none; b=sh01MLkBu+CwgNneIEvmb76od+8ngROj7nP9M1W7FeaiekNF8deTWub7B3Vb2qFwAXokNB1ZvYHMaDmwSFmDuOqT/Lp9weRRvFW0nc3Hz5H70gbQ+6vSWtDp9RNyUwm1QjZr8YlpRq1gIBY1wdWimJN2UiI/+z11a9fmbAj/TD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115682; c=relaxed/simple;
	bh=TWKSxlGyIhYkKx2IHsmr3S0PSja6a1SLNUKTNlAG5B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NWfmCPmUEgYp80PwZTNaM4ibI4jOUMhCcJLK3inEHTk6iyWD5MGBpMz1v9uZzBTEjr6BbrlMOjyD76GJr+8CrnQ4dwouTefUIywujhzIyorSFVjH3v5Qb1/ErvKVADG+vj3RPjtThEK4inYXBIjAuVSdflbjiffr2RwS0r3nnqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab04c419afso14981cf.2
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 09:34:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753115679; x=1753720479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXt6HZMVPk9JeeCAT5/bulVHyZLhdRrH3CcRWGn/4o4=;
        b=UfXQDPD85cnRJBtwi255LJoJaNdnRDOIES9ul2a4OImzFkpy+nNT7tOUUskduxx4L1
         bPzLfetEt9RI8zK+iCOR1E0WOy50Wbr8TG1amNFrs6x6iTov6VbrDZqM+itTbcJKGaEy
         6l6ejdRO6O/pkhsPX9vpWwQJ/oSy8PqbWmAv1lC3hR75Ps+hnLvac5SCD9d2+flT1hAm
         ORsJUHiwpDkR5TQXoRFSk2vCW5rvIM3bJgMRD/LikKlNRprEBaXWbP0hViClxGh97aaP
         KafizhfpgTkSYKgNhvhhNYCfoN4p9cYE1e4xLuCD4aNnpDc1xOC4rR6pMaVZNnm2b8C2
         sisw==
X-Gm-Message-State: AOJu0YxSaoy6azgWLbzmcnPCkfAZHqdF8WU9tyFgAeeWETCIPl0P/4Wb
	5LnMayVQ/D/J7MMUVY0zB55GlllGC8wiaOTPj04Gn5Smqll5hePSVIwZfxqPT5qqdluarUqekas
	p0Ohj1xWVgy/tAOD6xUL/Rilt70HF+No=
X-Gm-Gg: ASbGnctLjZN1wRfi2sgSE1DT5upjRbA86sN3Z8iPy6jMzvx7I2kPdxca6+p0wALVc2K
	X+OY6MlIYLyHapaB1ySGkkALC+Y8hQkujjjzfrtoy8TWWOITzYcKH3b60MerMRCAhP3GCgM6cXc
	b9xpAHxB41Ziz2ZRBTKo4ooSMz9uQTEf8swW9uSGk1q56X8n0lhFoN93zAM8ABUuzbkFaCGMGsN
	0HFLurKdTwQA1rI
X-Google-Smtp-Source: AGHT+IGh7wTe0LizsUN2EkJZQHeX8e6RbxLf8sbh6hmbeJf1IBIK1bgCvyfeUGAXTRhnUPeI0yGK73OWqW6zgduKF8k=
X-Received: by 2002:a05:622a:1990:b0:4ab:6e68:1186 with SMTP id
 d75a77b69052e-4ab909a7324mr126365061cf.2.1753115678967; Mon, 21 Jul 2025
 09:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
 <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
In-Reply-To: <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 21 Jul 2025 12:34:28 -0400
X-Gm-Features: Ac12FXw_pA-Jv1EWQeIDRc9M3Xd-xbk-ZMMf2YjQxgnLb98hvhIHkmKKtr8-u-w
Message-ID: <CAPig+cQGhy57YWLpyxZyMEUb5jc=9wHWYOOhjzEaj1yHf6MC6Q@mail.gmail.com>
Subject: Re: [PATCH v2] send-email: add ability to send a copy of sent emails
 to an IMAP folder
To: Aditya Garg <gargaditya08@live.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 6:05=E2=80=AFAM Aditya Garg <gargaditya08@live.com>=
 wrote:
> Some email providers like Apple iCloud Mail do not support sending a copy
> of sent emails to the "Sent" folder if SMTP server is used. As a
> workaround, various email clients like Thunderbird which rely on SMTP,
> use IMAP to send a copy of sent emails to the "Sent" folder. Something
> similar can be done if sending emails via `git send-email`, by using
> the `git imap-send` command to send a copy of the sent email to an IMAP
> folder specified by the user.
>
> Add this functionality to `git send-email` by introducing a new
> configuration variable `sendemail.imapfolder` and command line option
> `--imap-folder` which specifies the IMAP folder to send a copy of the
> sent emails to. If specified, a copy of the sent emails will be sent
> by piping the emails to `git imap-send` command, after the all emails are
> sent via SMTP and the SMTP server has been closed.

s/the all/all/

> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> @@ -299,6 +299,18 @@ must be used for each option.
> +This feature requires setting up `git imap-send`. See linkgit:git-imap-s=
end[1]
> +to get instructions for the same.

Perhaps:

  This feature requires setting up `git imap-send`. See linkgit:git-imap-se=
nd[1]
  for instructions.

> diff --git a/git-send-email.perl b/git-send-email.perl
> @@ -73,6 +73,8 @@ sub usage {
> +    --imap-folder           <str>  * IMAP folder where a copy of the ema=
ils should be sent.
> +                                     Make sure `git imap-send` is setup =
to use this feature.

s/setup/set up/
