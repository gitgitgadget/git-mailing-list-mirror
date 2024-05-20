Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC8A468E
	for <git@vger.kernel.org>; Mon, 20 May 2024 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716197810; cv=none; b=tUJpQ3h0b7DR6T7QYdwmg0YEoVciyzF2tQXp/HOFYKPQTgigadV4/m7o/FmII2HbukrdrMH1G3kDZSPx1C3C/9a/KCH6BQfqEkJcXQzyOWWOOPoi9/sZtnhKq4OEH0GMgYwj2bnJgwmiKQ5Z8zN935/eE7scT9E2jdT6Uzmp6zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716197810; c=relaxed/simple;
	bh=zFLg63/cuZQyth7oAc5nwwRJyOGL9/bZbFum/uKXxQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MW00zGFY1IedVaNsum7xA3UTiU9NQTRZOTSKvPWags9aVYfDG9YW6b1RriImxqWKK3UA0PGx7/0uF9Dazsb9wBaEaDCpDS8EbwgHzrepVrWalvitgy1v4qIBEAa3aikphfxclgLdqEXoYMZR5zemXvzCDIz6JBXtP8UiCRu1yPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47eff9b3c23so409392137.0
        for <git@vger.kernel.org>; Mon, 20 May 2024 02:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716197807; x=1716802607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3H0QNTVYCnbKVXsR7ahBjeLsvU0ccLICJw99VFk49Xs=;
        b=Ahr3e5MYzSOABQLn6Am4HAVx4hCJ5Uw72KnCFl9Np0cFZ/R+1Z6HiFEAXUAT/mQQ8j
         +cseLZbbQyXVK401/ARvZHCUfW9EbI6QWDwTlscQGJclrRnIM589Fayre7FXYFO3UvR3
         QWrzx2YA9MTRqWH4Sx3Nrq88B816RSPoQvlueaLr1FF7Erf/0ALG8UkFRMeKwPKhmvGn
         u6OeVPcsN2i4EdODG3YjKFAfQxPwYcuI7FzQPGC2RS5KPmhgjagIvkmAne6sqYvcfETH
         glM3VYUmCKC2/KvN2fnCZXxK0NcGwpPZSr4QXKfyOtwJH5PBoCNZiq1fp1WYXln+xtsJ
         fMNg==
X-Gm-Message-State: AOJu0YwvvX6Q2Yy/ohY7cx1PrlAV2zdzEkCO1wqI0MFZNtzKQCgMIBlS
	CkMVTJhStgXI09uJ8SRMpNjChlIRBWspxMKEbVPK5YuylBGTKRhDXIIaFQB6YhxaV4z/kBePbdw
	8Fi+sGmOEJ3nfndWemBP1EObF/xR2VA4z
X-Google-Smtp-Source: AGHT+IEYvkcPY8YXnPC2alhxjYVq/6xaET1jf0Z8/W0Rqf2WuWG5qikHWtsYAY1WUxZZAlc5OHICf9z/MdHoIUc+6IU=
X-Received: by 2002:a05:6102:3709:b0:47e:f86b:b455 with SMTP id
 ada2fe7eead31-48077e75c98mr29346280137.26.1716197806998; Mon, 20 May 2024
 02:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8baa12f8d044265f1ddeabd64209e7ac0d3700ae.camel@physik.fu-berlin.de>
 <CAPig+cS+BcQ2t564m8Q4GO+MAThgq8pV0fEFD4S0FBfwokO2Ng@mail.gmail.com>
 <054f58c2de4af289008f28b140d4a4c9ab56f084.camel@physik.fu-berlin.de> <bdbf99ae4d6e3669b3506a7d4a26730aa9cd0ed4.camel@physik.fu-berlin.de>
In-Reply-To: <bdbf99ae4d6e3669b3506a7d4a26730aa9cd0ed4.camel@physik.fu-berlin.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 20 May 2024 05:36:35 -0400
Message-ID: <CAPig+cQL73gVDDSH_=8Y6D0Pro58W1O2Rb-hettVcfZudXjOZQ@mail.gmail.com>
Subject: Re: chainlint test failing on Linux sparc64
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 5:04=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Bisecting was successful and has lead me to this commit:
>
> d00113ec3474a1652a73c11695c7e7b5182d80a7 is the first bad commit
> Author: Eric Sunshine <sunshine@sunshineco.com>
> Date:   Thu Sep 1 00:29:46 2022 +0000
>     t/Makefile: apply chainlint.pl to existing self-tests
>
>     Now that chainlint.pl is functional, take advantage of the existing
>     chainlint self-tests to validate its operation. (While at it, stop
>     validating chainlint.sed against the self-tests since it will soon be
>     retired.)

That's the point at which chainlint.sed was replaced with
chainlint.pl. It also leads to the same supposition expressed earlier
that the "actual" file seems to be empty for some reason, perhaps
because one of the commands which creates it is failing somehow. At
that point in time, the creation command for "actual" in t/Makefile
was:

    $(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
        grep -v '^[ ]*$$' >'$(CHAINLINTTMP_SQ)'/actual && \

which uses `grep` rather than the `sed` used in the present-day
t/Makefile. This may imply that Perl is somehow suspect or that
PERL_PATH or PERL_PATH_SQ in t/Makefile are incorrectly set, or that
t/chainlint.pl itself is not generating any output for some reason.

After running:

    cd t
    make check-chainlint

what is the output of:

    ls -l chainlinttmp

For me the output using the latest "master" branch is:

    % ls -l chainlinttmp
    -rw-------  1 me  me  14797 May 20 05:26 actual
    -rw-------  1 me  me  14797 May 20 05:26 expect
    -rw-------  1 me  me  15086 May 20 05:26 tests

My suspicion is that "actual" will have size 0 for you. If that's the
case, I'd suggest running the commands from the "check-chainlint"
target in t/Makefile manually one at a time to see if you can figure
out which is failing. For instance:

    % ./chainlint.pl --emit-all chainlinttmp/tests

If that produces output, then that's a good sign. Try capturing that
output and feeding it to the `sed` command:

    % ./chainlint.pl --emit-all chainlinttmp/tests >lint.out
    % sed -e 's/^[1-9][0-9]* //' lint.out

If that produces output, then something else is going wrong (such as
PERL_PATH or PERL_PATH_SQ being incorrect).
