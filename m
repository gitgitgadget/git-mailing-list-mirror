Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1660A39C648
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940458; cv=pass; b=Rr0t2Yajrg2cAPSol/hRUTRmZdiOPk9UylNv5gYY7xcCY/FrDvHf7V3EX2mh1yIZQbYCE66lqYEznlbOvAt343aqzGGkrrtgSMFns2e69FsrbLbfs2yS+qtAE+VaP875zBbQsuvSrQv4ypVlRd/67y5II4JDAcIEVYRn9NCkj1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940458; c=relaxed/simple;
	bh=k/dAbbJsSjOvxKKhdLF7tPDJWHCyhvv0NQp5cHIdb1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1l1Eg86TLeTmpmerLTgo6bAkWyFALnUUS1w5t3oYlN2UZbrbUNzOv5W3s9dO6sd4TMgk826WoqvK9Meb31nh2jVBkEkHyXH9cqwNu5C9NlHMO6PyP7I/QLavfqg+aF1qzv+WA1EGyrUhyusjYS1wC0aue/qEUcUXnBBRUsqEFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z3tamyXO; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3tamyXO"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-124afd03fd1so7620980c88.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 05:40:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771940456; cv=none;
        d=google.com; s=arc-20240605;
        b=DVT7606dwuigbk7GbzfWN5I0uiFK8grr2vRGywYYLY2UhOL08q0MAvX5QiNEKfwCY1
         zq/Ns04/m/RMipQ1SgTMusvSxLExHJqTWliu1GMYM3bBX1+/NvlZeT6Y2oWw1qZUOg0k
         taJca35zAoa75UwNdD2/u6e+UhzqRVGZpogYDO7KwLD98c2T7KLDSjRTqA1kAeyvwWLh
         lyaQoxhxrrL+yUR9pOwv6DsM/R7kOYIDnf4cA+GsEP9nz4qW90wSZck8qeuuDaX0k0Ip
         Po1X+4uPxJHm//bPRpAYXIvOeA2ti5YvPxbn+2MDyrxfKYaI1/ukwPmcott14g+aiYA7
         TISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k/dAbbJsSjOvxKKhdLF7tPDJWHCyhvv0NQp5cHIdb1A=;
        fh=zTHgSnOoigxay7MAqW6/2L46bMXCjzW0qVatUn5WI/Q=;
        b=NRsvL3LSIG7jqPdS19nM3/MjIFZqVc3aHWY6sE+R/8eELf9jY0slyhz6MtyI98k9R+
         mhVScwthJmLBZbWOFfJ3suQ0QmiTwuBQyAe+nQL3Hew/l48Nn/qNUMIR/u1BJ5f5fnBd
         JVYTXjF34UbOwapanPjGFVWyeF0VEMK5X8g2YMAbfDPaPYhsl9NJGctHZBDT+3XXY1/y
         R8jiHVTXRXhp7cK/NUtUjeygDDqjEUPAaYCUjhUEGvem3F+tnbwYRF3MlN/e1Nwzk4/8
         wyzBSCm8I9uwAPGkvvosWpND/yR1p72m3MZrjP52vNyrMK8GtswoBq12nEFPsxLExhOs
         kRKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771940456; x=1772545256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k/dAbbJsSjOvxKKhdLF7tPDJWHCyhvv0NQp5cHIdb1A=;
        b=Z3tamyXOn41ikRcjDd2Y2GKwYNzBlFBydZFxU0V9hEIoNRtMFdkpBg1m3g2zHSo0Yt
         NfZ3iyoN8bgFuDQzdY/cVN6vd90HvQFiZ/03l5YIZHuaLGB4zhL/o95ZNEIjqUyHUkL5
         1gPv9+vn3ZJkFNmXTyirtqaAOufRfLR6qYNqu5QUTBBBe30bs9K6koXF2fS9Io8IeqtV
         KgwIm9oSUWZQBwlXXZJJDanqLi6jCZORvV3FqcIomA066T9HhAi+Q+HB4UQb5wOdnftm
         OebfEbIe1P1ap6dS1H8ukcy8hTExs2BUMprjE9ODpXKO0tHWZ86brf16HBCZnuSbC/ij
         6uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771940456; x=1772545256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=k/dAbbJsSjOvxKKhdLF7tPDJWHCyhvv0NQp5cHIdb1A=;
        b=PDds/FmeeVlU039FZneI+FlZRTnKU5yQuRUGb46zHOt4bKyWmMXguBjEhTGG7rzezv
         qyLQkcqTShqklv4f0vS7qAUUjwkHInpnxajypnT0RVz9g2P8Ebf9OT/Me2C/OjKEX0wy
         ECvUFiYIZMNXbamVjOtZm/sK2O50HFmoAQ0TN/Y66mBgjpTd8kd6/8b9HC/iqmhoMI5t
         mIfo/PsiuYNaRwB9VWfLCE62MgXOgDAzIc3GlwGpeXYGB5G5ms8xqF8RIhZweg4x9Ll4
         FEKYAngG5JLF7qixVN2OesNEV8qjJV9AP/Vz9BoDDhqFoRwbe3RvhN032T6cUxMWwrQk
         FtEA==
X-Gm-Message-State: AOJu0YyVYtvSdExxFDHVWJbeZX4u1/gHGEbVye3L4p9l47T9u0gcsEHu
	n1CIe4vIo1BX1XPqnyZJAiV5DmnnBD4gxpbF7wvKxgSG1jXimDJ7cChofeq1bxtx+UFjqlzbYhi
	6SGDQfk10nqiTSkcJfngsANC+k4wPwsbfA0CU
X-Gm-Gg: AZuq6aILvegz40ub3ltRirkUiuEZZ0rZbA34uL+riyyX355GQLzUuLYvSQeDOaeqj65
	LrFVVH69/mq/IjcvhYJEO/B7oq4msimn4IKvSikCOQIum8qoxr6CF5T/19q9NdHMrgcBJ1c0qCg
	IELmdPtrGKC25WwtK/JKpNjO9YKMzQepVFR0VT1iuSnrLG+RzJPHgAHfz/dJbIvkD0dzzs5Ulh+
	R+kurRvWbjzZhfO3diq8hD+qLj3gRl98XDaEpkn9aCWDPVfBLvaymXp+mS6AkaQDMyl2BayHGfQ
	7OT2DF1j8QMoJfmOUebeQdxLMIpSkrZLtpd4kRLWIoAVXSvClYqLHeekgBv+W5bF7to+
X-Received: by 2002:a05:7022:61b:b0:127:5cda:aaf2 with SMTP id
 a92af1059eb24-1276acbf40bmr5199319c88.10.1771940456019; Tue, 24 Feb 2026
 05:40:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223194146.3476768-1-jltobler@gmail.com>
In-Reply-To: <20260223194146.3476768-1-jltobler@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 24 Feb 2026 14:40:44 +0100
X-Gm-Features: AaiRm52cD5DrXu5UhIVms8n8dRelUTPtdxOJY0wHKrpSriZQCAs1reQQ2ihkkdk
Message-ID: <CAP8UFD0OP3BP2RxiL2ip8WEC8SqT5LGH5dSco-2Jwzsd_4=60g@mail.gmail.com>
Subject: Re: [PATCH 0/2] fast-import: add mode to re-sign invalid commit signatures
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 23, 2026 at 8:42=E2=80=AFPM Justin Tobler <jltobler@gmail.com> =
wrote:
>
> Greetings,
>
> With c20f112e51 (fast-import: add 'strip-if-invalid' mode to
> --signed-commits=3D<mode>, 2025-11-17), it became possible to remove
> invalid signatures from commits via git-fast-import(1) while maintaining
> valid commits. Building upon this functionality, a user may want to

s/valid commits/valid commit signatures/

> re-sign these invalid commit signatures. This series introduces the
> `re-sign-if-invalid` mode to do so accordingly.
>
> The newly added mode in this series currently ignores
> `extensions.compatObjectFormat` when generating the new signatures. From
> my understanding, to generate the compatability structure would also

Here and below: s/compatability/compatibility/

> require us to reconstruct the compatability object for the object being
> signed. I think this would be possible to do, but would require getting
> the mapped OIDs for the commit parents and tree. I'm not competely sure

s/competely/completely/

> of a good way to go about this yet though. I'm also not completely
> certain if this is something that should be adressed as part of this

s/adressed/addressed/

> series, or could be done later down the road. So for now I've opted to
> delay its implementation. I'm open going down the other route if that is
> preferred though.

That's a reasonable approach to me.

Thanks for taking over this.
