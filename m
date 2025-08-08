Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C19185E7F
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 02:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754621261; cv=none; b=B2/jdt+SYn26K7TwMLVyhdx8Qaemq1XlmpTMuAxPjjdE6/oCmmaRcJMBh/UgT792PMrrKNYOJneweCK5K7CBS5mxpuoOyt26r0uj9CnFnjazwfrHQN+ckfDV9Um/AXicujc9/nqd5ASvV5D4L+tu1j1EQFp5s0Dw73G91U5KQcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754621261; c=relaxed/simple;
	bh=11eixBGAFGAtqmj/KHYSW5r+RS8xjI3/+5A2RPb1y8o=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=U2M6EV/b/s4mSmSwpzBmJtUy2uvmpCLxFYeg8gCtU3xTrfk8pY2+8t6MmKO80FKIH5fiYDQci8HeokRkIqWqwozLbg2kMgN0H0wYeR23tTQxdWWLtnumcrA1yWIKsdZ+QldaUJMrj7Iw66J6W6gMEBH5iyg+3IwT8MO7LK0MZyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2ktlrT4; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2ktlrT4"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b4209a0d426so1710102a12.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 19:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754621257; x=1755226057; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTu8lemjvzcWfM9Nu6cpeZzY6aozJHOg0oYqNKWYIeM=;
        b=c2ktlrT4cLv3q938J+j2OfwkHcrmPOsPiWUM1s04xaMmU9nV6gwx3s1zE0fY+YZqkY
         9rR9nHEGe3RRDf0+sz12ribyJIq4jlPTMyLwA5r/Qp7acCw9PG4FuiExWi46dL+hIbkr
         Abq6rC+CuK+aHl7mMlTHif3Vav+eAPsSjBP9HyAX93V4yBaYm+KkU1zF2T5rBlKcidmS
         CBeWdr1R20PZHHjhjBnpW2tNEGgWWdZbH8XQEyazJIPQCU2OrXV9rKaeAr01GzL8BdvF
         VvT5vlHrVHMvgqxEwUUrsIBp2PAl/MozjkQI0gEwbVa+dkwHljXM52ZKq81pLLl9o8G7
         sSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754621257; x=1755226057;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTu8lemjvzcWfM9Nu6cpeZzY6aozJHOg0oYqNKWYIeM=;
        b=eLvF74aBXO1RsgxLMiRykafOkQlpQWa/mnP2IoYH0l6/wS2EE0UNv38ZL7axSAfNAS
         UoR6uMP/fDOSlgVo6ttejYENrTipa5SK/15cT1u4xe+58ODbM15rX7jcIQm+frcHYz1E
         f9OSQdE/dV826WZ7IiKrKmJ29U/BspmfsWsc0H3qvaQOPwiryoSv2Gwhrc2DOV/WurrN
         UMB08/g9YDfsUR0Sm5e8wWoZhC6eHU9p9itJfHTO9NRZLolV+xM0WNI6S9EETNSBwm32
         QhXwq4YrFdk5R69s94oDs+GVyP+QdsKws5ZHpjfFVPmG3PiE6/J67lhWq2u0LURblFvC
         yTkg==
X-Gm-Message-State: AOJu0YyCuC8p0Iz+M1+INXU+64AFFgM4JIWA+GMefCKnXRPzd6sZzWL0
	P4zAb7jJvF8dt0kaWapnq0y3cpZv/zYQiFP+B8H+22d3o7Q2Xif24g25
X-Gm-Gg: ASbGncvM3s2Z5q+qlZEkRvPHnjHQlCh6cmTcw3CU2zKgIVdbHHDIQZ8fMosEB9MbuDQ
	c7PwiS6M+S1cXzOdiVJj7bn/4DXvHesjmXvW2n1BSlzQdxTgWxuMiMIFAkWQuFtkhYzJ91J2W4a
	iJ6Mg2cOVBvEs9in5wPN6Fmrx02y9NvOfU1HYPTPxmPai4F7nLwfXlO8CcdV8nXJF+DUkIWq+CL
	NBPHua+Mau4WAPCpd+rNRTMor0GYmLzdKu/uVj3C60jzT+cb2PmL3ao/h7P6urLha0UG1a0C0WO
	2n4Nzjk1FDRU7yewCcs/IsS2ktUBEAA35Uo0tB3liIY0XfFR83Lgc3jITqIqdqhGiu6TuTuPc6Y
	WftQl40zl7K7e9GPeHXMWbpHcjkfbGzEIsDhB8GZHrLLsErAX+T0VWIXG8F4=
X-Google-Smtp-Source: AGHT+IH7iCOcMfecPukHSkdymqOoyvj+8Gieh0g07KzDMeCB8MBOBBTt33b8SPn1GD5McdWS+Jnhvw==
X-Received: by 2002:a17:90b:3951:b0:321:2f06:d3ab with SMTP id 98e67ed59e1d1-32183b4573emr2243804a91.21.1754621256952;
        Thu, 07 Aug 2025 19:47:36 -0700 (PDT)
Received: from smtpclient.apple (n058152109064.netvigator.com. [58.152.109.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32161282ab6sm6879134a91.26.2025.08.07.19.47.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Aug 2025 19:47:36 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v4] diff: ensure consistent diff behavior with ignore
 options
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqldnult4w.fsf@gitster.g>
Date: Fri, 8 Aug 2025 09:46:13 +0800
Cc: git@vger.kernel.org,
 hi@arnes.space,
 michal@isc.org,
 peff@peff.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC10362A-5B05-47D0-98CF-DE6AD468F01D@gmail.com>
References: <20250806123306.25532-1-yldhome2d2@gmail.com>
 <20250807020643.40213-1-yldhome2d2@gmail.com> <xmqqldnult4w.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> In git-diff, options like `-w` and `-I<regex>` require comparing
>> file contents to determine whether two files are the same, even when
>> their SHA values differ.
>=20
> Let's see if we can do something to clarify "the same" here.
> Perhaps
>=20
> ... two files are considered equivalent under the specified
> "ignore" rules, even when they are not bit-for-bit identical.

>=20
> Following the above, perhaps replace "identical" with "equivalent".

Equivalent seems to be a good definition, will replace.

>=20
> Also, ", Add helper" should be ", add a helper", as that comma is
> not finishing a sentence, hence the word that follows it is not at
> the beginning of the next sentence.

>=20
> Also the implementation details like the name of the .diff_options
> member and the name of the helper function have changed, and the
> proposed log message should be updated to match.

Will fix grammar errors and update log message.
>=20
> As the "dry_run" variable is used only once in this block, we
> probably do not want to add it.

Sure, will fix.

>=20
> We may want to leave a comment to explain why we ignore the error
> return from xdi_diff_outf()?  Perhaps like below?
>=20
> if (o->dry_run)
> /*
>                         * Unlike the !dry_run case, we need to ignore =
the
> * return value from xdi_diff_outf() here, because
> * xdi_diff_outf() takes non-zero return from its
>                         * callback function as a sign of error and =
returns
>         * early (which is why we return non-zer from our
> * callback, quick_consume()).  Unfortunately,
> * xdi_diff_outf() signals an error by returning
> * non-zero.
>                         */
> xdi_diff_outf(&mf1, &mf2, NULL, quick_consume,
>      &ecbdata, &xpp, &xecfg);
>=20

I think your comment is good enough so I will just copy it.

>=20
> In this codebase, these "original value of the variable X was this, we
> tentatively save that original value away, tweak the variable X to do
> something, and restore the saved value to variable X" variables are =
often
> called "saved_X".

Will rename.

>=20
> Perhaps use test_grep helper shell function, i.e.
>=20
> test_grep ! "file1" actual &&

I guess this is because test_grep has more useful debugging information.
Will replace.

>=20
>> + git rm -f file1
>=20
> Is this because later tests will break if you leave "file1" in the =
working
> tree and/or in the index?  If so, we should use test_when_finished to =
make
> such a clean-up.  If you insert

Yes, exactly.

>=20
> test_when_finished "git rm file1; rm -f file1" &&
>=20
> at the very beginning, before you create file1 with 1..50, when this =
test
> piece finishes executing (whether it completed successfully, or failed =
in
> the middle of the &&-chain), the specified command will run.

Early on Patrict suggested the same thing, I will read test_when_finish
to see how it works.

>=20
> On the other hand, if the later tests won't mind whether "file1" does =
or
> does not exist in the working tree and/or in the index, it is common =
to
> leave it behind without cleaning it.  When running the test script =
with the
> "-i" option, i.e.
>=20
> $ sh t4013-diff-various.sh -i -v

Good thing to know. Just curious, I also found that running ./txxx -v =
causes
failed results and successful results to be mixed together. Do you =
usually
solve this by using awk to extract the error messages?

>=20
>> diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
>> index 52e3e476ff..e7be8c5a8f 100755
>> --- a/t/t4015-diff-whitespace.sh
>> +++ b/t/t4015-diff-whitespace.sh
>> @@ -11,7 +11,7 @@ test_description=3D'Test special whitespace in diff =
engine.
>> . "$TEST_DIRECTORY"/lib-diff.sh
>>=20
>> for opt_res in --patch --quiet -s --stat --shortstat --dirstat=3Dlines =
\
>> -       --raw! --name-only! --name-status!
>> +       --raw --name-only --name-status
>> do
>=20
> Wouldn't this make the "if the option is marked with !, tweak the test =
that
> notices these two equivalent paths are not-identical" extra code, =
whose
> beginning part we see below, unnecessary?  The $expect_failure =
variable
> would always be an empty string, so "different but equivalent" test =
should
> see "git diff --exit-code" exit with status 0, right?

Yes, I will remove the optionally set expect_failure part.

Thank you very much for your review,
Lidong=
