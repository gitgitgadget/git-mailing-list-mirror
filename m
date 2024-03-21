Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942F6FBF
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 04:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710996934; cv=none; b=Jj5+nA6vm1FFVMX63TS36bDGED7W4G84l0X3IBiHkGvhOY611kBI9+uNMI3+FIlFQ87lIIeU/hF18njxIo2iFhHMIfpNV2I/MkjzNxOZmoZek3B+ntsDUm8fhlSEA/TGzNHhnrxGxIueCSIa50JkGpsQTFSjh8ZcqxVqr39z3Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710996934; c=relaxed/simple;
	bh=Cbd6Yrg9erA5MWUjvSSta2ZlJV11k1qdBLjs3lW1rys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpWeOwy2nFUa+oNoMMPVKknZQsHdqNFAkNyrm6WIOJPPYqDJPzxmTqgKpVXHdXQc2HipYsNrOlrC5r6vx9tL/9RByWf0OnHaNt5kch8T5glCtqFRLLiKIDjUDDK1W2XOECues+7fozksFHSk9SV2//SFI6NuZzD2CER5j/fR4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-69107859bedso3974316d6.2
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 21:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710996932; x=1711601732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Buw+rlShIAYd4zZlJFwsXnK5XBfMrUESJyryfMoQNMw=;
        b=rUXhYKgcRmFKICtd+WwZFcREnqGobPh29IyGQpngPjNH8WeMvG0/o2mDbYxyf1OrLQ
         hVuGV7S/O36Jfl/7vihXaxEolT5d33sOszidR4Ah8IC6BEhuVvCMNnUhuayjCtWBTtlW
         MmQXP4VrGYlN35ADBOXFH2y70TDY6KPSKm1MKYlhzojC3xJkMtR+B4VvjzBytMzzqnzA
         0XEMPFP1lEtqzY34+OgPLPCq2NzWYIOcfz8CyVSefu1ShoIgXHJB1oXKcy06bPrR//Jq
         LJV6O1mGi6GdH67AUvDkbmoW15RQf6BQhqN/a8NaJwDzR5PzRQejSSQRi77gzrVsfxBe
         KHhA==
X-Gm-Message-State: AOJu0YxaG0jMZnuWvZiRdfiOUwnQYxrKAweCC1Srbio8bk/3pepfFeo6
	9fZblSqJhTN+4/tN+YESHzC37Hog/4MIUs926xsPh8z0lGVA395H/7lVSAVn2IkgrsORRpS+qBA
	n0okL8ZxkyYXlVfmNM+TeYIfPmLw=
X-Google-Smtp-Source: AGHT+IFzP/Z12VbS1ntJtFUAl9EH9P90xroxbpjFQSi9Tx5ecdasQZW/J/EZ/BwO4aEQwfadC/NjvjQuTGd3UR7LQdk=
X-Received: by 2002:a05:6214:514:b0:690:bb11:2a0 with SMTP id
 px20-20020a056214051400b00690bb1102a0mr22084710qvb.10.1710996931700; Wed, 20
 Mar 2024 21:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710994548.git.dsimic@manjaro.org> <688128d8ef09589712634888074ffd71a192a7aa.1710994548.git.dsimic@manjaro.org>
In-Reply-To: <688128d8ef09589712634888074ffd71a192a7aa.1710994548.git.dsimic@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 21 Mar 2024 00:55:20 -0400
Message-ID: <CAPig+cQekOLrpcK_NcL951SRZAg-1Y1aFzE0-i-uCTK_XuiajQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] t1300: add more tests for whitespace and inline comments
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 12:17=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
> Add a handful of additional tests, to improve the coverage of the handlin=
g
> of configuration file entries whose values contain internal whitespace,
> leading and/or trailing whitespace, which may or may not be enclosed with=
in
> quotation marks, or which contain an additional inline comment.
>
> At the same time, rework one already existing whitespace-related test a b=
it,
> to ensure its consistency with the newly added tests.  This change introd=
uced
> no functional changes to the already existing test.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> @@ -11,6 +11,98 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +test_expect_success 'setup whitespace config' '
> +       sed -e "s/^|//" \
> +           -e "s/[$]$//" \
> +           -e "s/X/\\t/g" >.git/config <<-\EOF

Representing TAB as `\t` in the sed replacement is not necessarily
portable and (as far as I can see) we don't rely upon that in any
existing tests. It probably would be safer to employ a literal TAB
character in `s/X/ /g` as Junio showed in his example[1].

[1]: https://lore.kernel.org/git/xmqqzfutjtfo.fsf@gitster.g/
