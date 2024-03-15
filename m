Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F31F19A
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 20:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710534590; cv=none; b=FKTExU8uFMPIBMpwkk2ZXMnK8D8e2rJ/TVjvTArUjZh6lGdD5QgLNCIVa3/fY6Qlyy3Qpor1ighRyf2rYXMBDZMkxv+tirMeVHYTAZt97y9IpC135RFgGe4FJrOrdKe7ZxLcYSTGcM4y0+OBM4iC4brcffgge8VOqovT7xdX6lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710534590; c=relaxed/simple;
	bh=imuXt5S7ELyuczuuDM3Y+hrMMX39ZNEKaR+huRkcyD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbGbKTbrmDAlb1I8Gq4+Xw6wCpz6nzmFSiEoyb5iqO4mf9k/Wx+lndsVTEphXbTy0IGiBySYUY3v4Uw5RZipxQ+bQjAbLvsVFo3d2wp3FEQOHT+4QOA0ZSQOlgpcV3aE6zv1e7Wzb9GOGzzt2iTuiulRKK7KjVtToZbU7dfSkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-789e6ceaff1so80945485a.0
        for <git@vger.kernel.org>; Fri, 15 Mar 2024 13:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710534586; x=1711139386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5e0Q5uFXNBWnwJSASBwO+0bmyacEE22h9YabWuRRfg=;
        b=DmvYOxXmGTddm50cz8jvniwmDovY6IKzO0UcE5o7ZnyLXByUwq9D6CSkTB0pEuTlMC
         ZajhYoj3LwGRDHR4FzqoIxDqPWKKf7ImGpGDb0oA+tpTdLHSV4YKUkKYa+OdyIedp7Zz
         BPZNFzvL78epTn8N5c7aFTeb3l3nZige5tJG7sMe70YmN6yvhsvSatDWB9X1ikyKZLRQ
         dTXJy93K9FURFhWmH/olHfXGdVUQLcysvf0Kabl70XZQ17+KWMoVMa6ukUyTz8ovOJMk
         S02/4EHDuVn/dCyMJ/WjhbnbzbuRmLxKF/Kt5NFVGKsy6tun/8OFdEffgo+4kggWFbwt
         swQQ==
X-Gm-Message-State: AOJu0YzB+1tLVtFj0LKs2vTqOHVyKBS7MUNZumb1wBc2BybeKhf70FZ1
	ZnpLpjV1ynKZTvD2mhDm/RqpjBp+fp24985sQz5XBrJmw4UJhM7JgPBdwGyrsd/fpQfNhOkn3HT
	AuSzNdzApG/6ZomxVzXeaZLjRRH0=
X-Google-Smtp-Source: AGHT+IHbga3R35NfIHcoCPazMJ2cSGpJFMglD0R8i9QQLjUUoRp0iPXwyDw+XZuVNKKRrHlonUt71rXqRZvOk1Dzp+0=
X-Received: by 2002:ad4:5003:0:b0:690:c049:8332 with SMTP id
 s3-20020ad45003000000b00690c0498332mr9370847qvo.6.1710534586101; Fri, 15 Mar
 2024 13:29:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1710508691.git.dsimic@manjaro.org> <590731e15a01558d1bbcdfc01df4f78573138742.1710508691.git.dsimic@manjaro.org>
 <CAPig+cRMPNExbG34xJ0w5npUc3DDwxQUGS_AQfam_mi4s53=sA@mail.gmail.com>
In-Reply-To: <CAPig+cRMPNExbG34xJ0w5npUc3DDwxQUGS_AQfam_mi4s53=sA@mail.gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 15 Mar 2024 16:29:34 -0400
Message-ID: <CAPig+cRG8eFxepkaiN54H+fa7D=rFGsmEHdvTP+HSSaLO_6T_A@mail.gmail.com>
Subject: Re: [PATCH 3/4] t1300: add more tests for whitespace and inline comments
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org, gitster@pobox.com, rsbecker@nexbridge.com, 
	github@seichter.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 3:39=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> These days we try to place all test-related code inside a
> test_expect_success() context rather than having it standalone. In
> this case, since the file being created is (presumably) shared by
> multiple tests in this script, you may want to add a new test which
> performs this setup step.
>
> Taking all the above into account, perhaps:
>
>     test_expect_success 'setup whitespace' '
>         q_to_tab >.git/config <<-\EOF
>         [section]
>         solid =3D rock
>         sparse =3D bigQblue
>         ...
>         EOF
>
> Same comments apply to rest of patch.

To be clear, this case is special because the file being created is
shared by multiple tests, so it deserves being placed in its own
test_expect_success() invocation.

For the remaining cases where you're doing some set-up outside of
test_expect_success(), just move the set-up code into the
corresponding test_expect_success() invocation. For instance, rather
than:

    echo 'big               blue' > expect

    test_expect_success 'internal whitespace' '
        git config --get section.sparse > output &&
        test_cmp expect output
    '

do this:

    test_expect_success 'internal whitespace' '
        echo 'bigQblue' | q_to_tab >expect
        git config --get section.sparse >actual &&
        test_cmp expect actual
    '

(I changed "output" to "actual" above since the names "expect" and
"actual" are common in the tests.)
