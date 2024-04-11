Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A3417BCC
	for <git@vger.kernel.org>; Thu, 11 Apr 2024 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712865473; cv=none; b=vFDKKZASPzmJeiRMdgj5EA5j4qJgM3nDI7qYWC+uFuTMY/1oUBIuOSxhT6m0ZUc+LgBkjH46ksjpQPv2d+Ue1V7fKFETDNEAPzc9w4lHWpV3OGo8+m25AszR9fkBJ5VafNe9kZCcchSdSG2sssEn/sH0Houy1gNN5wFjpS5AR7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712865473; c=relaxed/simple;
	bh=i30OFBdErycKFSpgPvPeKnrM5UPICOSue+2y/S0iPJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G8jH22RLMaA57XYPvYIGKbOVfW1ZN6kmP7fXNoU+g8x3EjSVrUeHUeeRkFDGmtzH8UN0nvww5lxJmgE5Fv6Qp0rXMCiIEhY6VnpWH8CuP57tDF4oEudwXMvjgDfzaa5BsOZGluzrwjzZdRywcyLfMcgqWgo/dvdBudApa3RmCcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8p4g56d; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8p4g56d"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5aa17bf8cf0so42645eaf.1
        for <git@vger.kernel.org>; Thu, 11 Apr 2024 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712865471; x=1713470271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utryzr2rSzSy71BbHpIh+RiZs8vfcoqFhFM8rGT5X+o=;
        b=W8p4g56dKBmtlsHfGPOeCH224ZY9wGEKaiki0IMwdvJwFUiTFQVD2Ql8VCAZFJCKVX
         Jqjcz4AkI40dGfPUAfyS0p9VnLoX4p8ZVdTGZXhhKbjXwLWTgJNIYY9eMj+rqt/7RH1J
         E4ghBKoL4/xGJB9vV2oDhQcTfGm7ybGO2Y/fXgy1Sej6WVnRyg9ZZqbKf257xdHcIfiU
         ghy+qvR6UScwezaxehSresBA9R7O3J3nSrpxFfORVLCe1V81RDmvsit0Vkg/1oBb+ET0
         LtjSRVxqJbHeOupztkHQIiqfXJG698ParXUqdZdDYOd3mgbz6ZcERHIlQM7wVepFexWR
         3ypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712865471; x=1713470271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utryzr2rSzSy71BbHpIh+RiZs8vfcoqFhFM8rGT5X+o=;
        b=I6TaIgScqjt/cDRG1svfYwbwDiIqb5AAVF226ixT+/Bjw7oQHYz3wqcXnL3OvClQwP
         GAxwIXYCMCJ7ZTZq07t+beBg0JamgnfFW1qtinK4rxygi0TPY9OQWtgUy/mK5NWbP5hi
         9i0uZm0yPf47rqYmTyy1gcAraxAWffnDmc8FFSr1wNEicZI+ZKKGJOe6p/FJGzW5QIFw
         gnVPlNe3YLAarMCWvIE04jc+teW0wC3fksGQVbzaco/Jl3dgFfsilYI2HrgTfmwp5/UH
         zk4SU/V7VXH8NmB/m4Zmgfc5wYD6HPf2PaWyJ5mNWcMBqh9KPPiZ+x60prKt/fgQ3y2i
         eLww==
X-Forwarded-Encrypted: i=1; AJvYcCWnFek4FMUS/gJozas94eyeRz1E/YHYPOJ+8rEeVxFdZhH3Jz62v8xAdilATqEr47+MqehJWlN2z+5sy49n7XsKodbK
X-Gm-Message-State: AOJu0Yw0BH4d3BDDm+OT8Vy59ZhKZ9HezjPmi5tELUZchQe9rSJRlrs0
	4WGRBU8ukEt6DmwBVmRC34V9swgyPKb3tiEYz+7ETClXJ4cDJDCE
X-Google-Smtp-Source: AGHT+IHQDFBmCBiF2L0qMyXHag4dB6+3HgUmcMWSQRd0xRaorlqfvbl8Itfun1cQWHxQvngDR774cw==
X-Received: by 2002:a05:6870:d28d:b0:232:fa03:3736 with SMTP id d13-20020a056870d28d00b00232fa033736mr597816oae.0.1712865470924;
        Thu, 11 Apr 2024 12:57:50 -0700 (PDT)
Received: from [10.37.129.2] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id b9-20020a05620a270900b0078d6b676b9csm1430520qkp.17.2024.04.11.12.57.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2024 12:57:50 -0700 (PDT)
From: John Cai <johncai86@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <code@khaugsbakk.name>, Jeff King <peff@peff.net>,
 Patrick Steinhardt <ps@pks.im>,
 =?utf-8?q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>
Subject: Re: [PATCH v2 3/3] show-ref: add --symbolic-name option
Date: Thu, 11 Apr 2024 15:57:49 -0400
X-Mailer: MailMate (1.14r5937)
Message-ID: <F53A2B72-D089-4C0A-92D0-E96EDD410A74@gmail.com>
In-Reply-To: <a9ccd0db-2e52-4521-9d72-49d2a85656f5@gmail.com>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
 <pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
 <a9e6644327a04f1d309eca812ace9c4159781353.1712597893.git.gitgitgadget@gmail.com>
 <a9ccd0db-2e52-4521-9d72-49d2a85656f5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On 9 Apr 2024, at 11:25, Phillip Wood wrote:

> Hi John
>
> On 08/04/2024 18:38, John Cai via GitGitGadget wrote:
>> +--symbolic-name::
>> +
>> +	Print out the value the reference points to without dereferencing. T=
his
>> +	is useful to know the reference that a symbolic ref is pointing to.
>
> It would be helpful to clarify that this prints the contents of the sym=
bolic ref without dereferencing but also prints the OID after dereferenci=
ng the given ref.

Thanks, will clarify in the next version.

>
>> +When using `--symbolic-name`, the output is in the format:
>> +
>> +-----------
>> +<oid> SP <ref> SP <symbolic-name>
>> +-----------
>> +
>> +For example,
>> +
>> +---------------------------------------------------------------------=
--------
>> +$ git show-ref --symbolic-name
>> +b75428bae1d090f60bdd4b67185f814bc8f0819d refs/heads/SYMBOLIC_REF ref:=
refs/heads/main
>
> Do we really need the "ref:" prefix? It is not specified above and I th=
ink anyone calling this would have to remove the prefix before they could=
 use the value.

I can see how it would be more ergonimic to just have the value without t=
he
"ref: " prefix. I kept it because that's how the refs are represented on =
disk
and git-symbolic-ref prints them out with the "ref: " prefix.

I don't have a strong preference, but I lean a bit towards keeping it con=
sistent
with the output of other commands.

>
>
>> +test_expect_success '--symbolic-name with symbolic ref' '
>> +	test_when_finished "git symbolic-ref -d refs/heads/SYMBOLIC_REF_A" &=
&
>> +	commit_oid=3D$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BR=
ANCH_NAME) &&
>> +	cat >expect <<-EOF &&
>> +	$commit_oid refs/heads/SYMBOLIC_REF_A ref:refs/heads/$GIT_TEST_DEFAU=
LT_INITIAL_BRANCH_NAME
>> +	EOF
>> +	git symbolic-ref refs/heads/SYMBOLIC_REF_A refs/heads/$GIT_TEST_DEFA=
ULT_INITIAL_BRANCH_NAME &&
>> +	git show-ref --symbolic-name SYMBOLIC_REF_A >actual &&
>> +	test_cmp expect actual
>> +'
>
> I think it would be nice to see a test along the lines of
>
> 	git symbolic-ref refs/symref-c refs/heads/master
> 	git symbolic-ref refs/symref-b refs/symref-c &&
> 	git symbolic-ref refs/symref-a refs/symref-b &&
> 	git show-ref --symbolic-name refs/symref-a >actual &&
> 	cat >expect <<\EOF &&
> 	$(git show-ref -s --verify refs/heads/master) refs/heads/symref-a refs=
/heads/symref-b
> 	EOF
> 	test_cmp expect actual
>
> to show what this command is expected to return when there is a chain o=
f symbolic references.

good point, will add this in the next series.

>
> Best Wishes
>
> Phillip

thanks for the review!
John
