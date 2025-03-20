Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65676226D1C
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 18:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496949; cv=none; b=cmXjFzxWAi2XHEMqs4chSn0imjdSHvN2ZvnNntZ/ZksQDeuy9pjgVvh5v/FBZoW427G8xbgzY64AUjmOE2o1Qk2j+52RSEraYviN/jW429myTzkaE5ruQLUPiahZSBSz3Vjc9eBK9XQboopgCXCPtuGng93BNitrkf93jHgtJlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496949; c=relaxed/simple;
	bh=VPrg/0+1U6PMM7lUWKZLrTvUKDvOS0co96mxPxViLAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lz3pWdjvNXa2vDvf4eCtOY/X4saIq1SKjSfyDApyEJTdQHBY4bbwCWOxF/ScUNfyXHpSsqUeq0CwU89dRkcuZ8n1vrjGJDFpSV60OwOfbOiNN0EDmSB5CIz3BBqlSYNuTUYTHlK3OqpU9BuqCD18oBBULPQJ2z0oGYYrf6xtEN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5a3334fddso26497185a.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 11:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496946; x=1743101746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vv1Dwm9l6UhhxWXnQKB+2yl02cKn92w/IZp3xc73JRE=;
        b=a9m8Yl1rucVKVipQJJokFJV52nVwP/WSPDPZSGiVqSq63dAB2B6+Z59I8KdeRkjVvj
         1Wo6/Ie/eftw47/nV5yQMgODrZmmXz/WVZK90swuomV/D1j/idshYB48QrmegMFRLm4v
         efGTZqvV88s/8JAkK7wADt/85QPwldgYMoCKd4evrANnL+fJFgA29l4Gz/qtmOtwGwIw
         mi8jqmzXl8QldKr4VWuhxG6l00MNFSdUgyKgAbkloN+0uIzm+l+hw8y1AYhLMqCdimnn
         IYLpOPeQFb/eY4z9rwXpWHMi0/YZOJM5hDtAmWGO2rJONaSowSZ36Cv57efbtqyFS0H1
         D1kA==
X-Gm-Message-State: AOJu0YyQg/HUKf96nXyC5ShuvfzVN48fXvxJCAXs5l+x4QW31NzpZX8O
	gKjxmulO35ojcE6OqTagkWCkyXZs6kyISNOf6TN33GwDywBylabI8ImIiyjWZSrjR77BlozQWCQ
	FS4lUKKa3dKrFXWf0n/UrqUeiRhM=
X-Gm-Gg: ASbGncvs2cT8BtT2J+HKgsWkjI5ioMXUcIn7bCpdPK3nDsHRI1/Jycgjkchzgr3dZYz
	LTQB9p2IxfW4xVhnKZytvL6rTdL8xuy3MRSjrXgnj3NSt2JllNllGbEL4BlZKXsVlW9EtIaI3To
	Zljffd2rr0sJji1eq1VxBw2OCE
X-Google-Smtp-Source: AGHT+IF4OouOfAkIUHbSnSOFO8ywnMrW/PU5cvczXMgDO4FeOryz97XTcL0pYvCTQwFGsGN33kcIo5YmONWS2gGnV8M=
X-Received: by 2002:a05:6214:20cb:b0:6d9:2fac:c208 with SMTP id
 6a1803df08f44-6eb3f335f78mr2755636d6.6.1742496945881; Thu, 20 Mar 2025
 11:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im> <20250320-b4-pks-t-perlless-v1-6-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-6-b1eefe27ac55@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 20 Mar 2025 14:55:34 -0400
X-Gm-Features: AQ5f1JoBs9bvM3QNBPMNHI_OJ3gMJfPn5VE3IfxiOFLlYinHHfymiHnSZ5zxXyM
Message-ID: <CAPig+cSPi0CV14o92FNFB0p2Z+nVTZ0mF67vd2ywsV6gGn7YSQ@mail.gmail.com>
Subject: Re: [PATCH 06/20] t: introduce PERL_TEST_HELPERS prerequisite
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 5:36=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> [...]
> Introduce a new PERL_TEST_HELPERS prerequisite that guards all tests
> that require Perl. This prerequisite is explicitly different than the
> preexisting PERL prerequisite:
> [...]
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
> @@ -5,6 +5,12 @@ test_description=3Dcheck-ignore
> +if ! test_have_prereq PERL_TEST_HELPERS
> +then
> +       skip_all=3D'skipping ignores tests; Perl not available'
> +       test_done
> +fi
> diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
> @@ -11,6 +11,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +if ! test_have_prereq PERL_TEST_HELPERS
> +then
> +       skip_all=3D'skipping ignores tests; Perl not available'
> +       test_done
> +fi

This message seems to have been copy/pasted. Should it be instead
"skipping apply-binary tests; Perl not available"?
