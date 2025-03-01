Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E325E1DE8A2
	for <git@vger.kernel.org>; Sat,  1 Mar 2025 11:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740829015; cv=none; b=TUETS2WGGexGKUJshW7ZFNsKA3+jvtY1Qsk3cf9TozuEbcqQs5Br7D06Sl54yLWJqq3D6dwEyJlhQrl8vzby44wwGkuMrn8k5jRux1Z5aiawv2+tGf3LjAJo2qRPMMeKcEgQx3ppBcm0uJgLxcGCzVV6tgLwKPJEu/hSe8lZBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740829015; c=relaxed/simple;
	bh=2aiuQ0zKp/4GBwG3YUYD5lz8Al540Pwb9D/yuEWLVNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Cwqb4hb7xgKZc90hPkpeMTbbdplzYALwXcaHj/XaPtU3Qf2wp0YlUIjgy2GalqJ08+RS3rmtSHxJ5iyKtM2HJkZNamDULVMga8OmWmnFHvtEsT3H84zCPhsjB4KhWcTg2OiQw6M4m/U4eozMraN0EqUPWDJ75LuFT++I9Cplxxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=cctsX3S6; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="cctsX3S6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740829011; x=1741433811; i=l.s.r@web.de;
	bh=NbumPJMRHjUp+hAmdNbPgZMXkDHbWGPtMNF0w+am9+w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cctsX3S6YSdgA5jcpuGoGpUVL7Z73aGEaFR0V1Yw99W+2xOtGmyUbGvboza/iTW1
	 JHS7oC4v7krr6g8w8Yyhj+6Mk2MbZPlA3zQn2i796QNqx1aM0g5wfini6nzFVTSBi
	 2Eh7LVm5fPKDuL1oWX6FZHqK336TXNl949d7BeJ4RIteoonnv2QE52201Qr2Wrhh5
	 DyNQAw2YM5Hl10Cx/Iv4L7JL0gfM1vYYvZ5FuVrK6zXcBi6pZKzo/cdQTYilltu+u
	 n9iqxlIHtkgWWLIJbT9TXT6/rJSykQSzeQWfEkay7YEhQpIETYRosz2oMPIHLH0Rl
	 i48ywS4FyHVAPTZuWQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.144.81]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MhFhe-1tIq3z3v7K-00Zei5; Sat, 01
 Mar 2025 12:31:33 +0100
Message-ID: <bca5c0ec-0995-421e-9745-330f729357d6@web.de>
Date: Sat, 1 Mar 2025 12:31:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Subject: Memory Leak vulnerability in reftable/readwrite_test.c
To: H Z <shiyuyuranzh@gmail.com>, git@vger.kernel.org
References: <CAAJd+fZSUiiUm05D_eO3HS7p=WoxAWSZo51dUNjyGjUNJBvyGg@mail.gmail.com>
Content-Language: en-US
Cc: Patrick Steinhardt <ps@pks.im>
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <CAAJd+fZSUiiUm05D_eO3HS7p=WoxAWSZo51dUNjyGjUNJBvyGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0kS2k3BfA0upwZiJYh7pCGbgdeRXNp+/sVBsjwMz74AWBPq1voF
 EJf3CZgkIzYHF1LroHsf7k+ziMegNhbK/PoeOUJzxhZOcaFijsmHD6HZWDwWM8pefcAGOQV
 lJR3H+6Zs/QUHh5uGRuJ04yPG6BJ++VJxlE1+8qL7XT5OX/Ke5mthooyjUCkBG34UmCsAXH
 TNkKzDp4yr0TpB2O8xKzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:F9ooTDMwBcY=;QAzRb8NilanqePkwRZIR7k/sRrW
 2voqsqJpvQggP6e5TsJk7E8RjhrcMf70Bh+ceHQjmoMeafZpKuBBwDgsoLvm/9R2BOvV1V1ni
 J/isFKkP5LdiY56fD0VN9cuFTcvu9KXrodKYuMdITldV2pPnvRnqiWrwgSxmcBirJtfKyDwna
 Jp79Olhh9PoP5zl3+3xqODFrzevOjckfDP9wDi+wBle+K1Z5IJIqGqP4oTunREcc4nFSH7nbZ
 DhsPIw69jJe0A1aIW+NFO+Jkmn7rv4WnhEZtenOiQBJdIS9SEwfo+CUKuTOhpSgSKUdN8Kto6
 Ck5fNLHB9ZXYgHsAGi0TgtbWIcQq+gLjJ1Pkjt1074scY/s6845iaP6wxacO0YECpU6zn8r7l
 Ymh3/ZchNQcEnSi+9mpIy8g7CZiS2iohlNj1eerzxG71Ep4nRb3k915/QqnhWhJPc/hEb4uf8
 q5myC0p5ZaaQDKhTn1djmIosVp2vhWGvDw1DUgz+0QOr8gIdfhwZ3Lf9syUJmiadHcAC3R9OG
 Ez4ryXv7SORIfNG3EneSvbygHFGFFJ9oD9p243O5gHjqgEH36rn73BbwGEedSevIM3Rm8hs4S
 YN11oTpksFLHr9ImqSPVQzdqG77rPfY4TPHASUK/IFaox93Vd6kUS/V+iUFOHDLriKXjar536
 Lg76ik0Qsq88lOTGAW0isyoOXfch/HLEgnn+ZqS6eBvd5rcKFfcTdUtw05t1tnTi56ctmUOXl
 mppsPJzvfmcXC6C6mA1BG9jRbvhqGmAxra/APUMPKigMKcIMsdtIH3sxw/tpg/GDGBdu3V9pP
 lQbW8QQ98lKzwwQ/BzbZ/t+MQMxPYqNeSOK65eZ6r7+Jor+IGxo0bM5JIC/XUDQyRC0Sm06hQ
 hd9FL7JOaZsEIQDdwrJktrXUBiGjW41TjTBI+je8fbO6xPjMKkiFSdmCoX4GsdGB2uOOcvjLG
 P6dFmx2x6pVrol2wVAmyjXo5FVrFqYHK+/liR6FG+KaR594yX3VN8mK6EelJSDrq6z7j9hsw7
 Mo6UArN04/3YWqTPJKHTSXOYvU53AuUnQfHNRucGFsoT0y137OkZyZ9wEGf3G8HEEV35I/DF8
 Sx+KRHE7vcSh8V5mGf+KrdO36WyB9w8zkbbzRZ+vqjC6XuHJ29PsT9AO5Gh5y438S5gg132LI
 gV6WVjnjVP+YKlBum1pcytX1gQNCCzU7WpPgqyTLvt1cwlZIM3D0wAhSprZBzeh7uQi7c+ODo
 yXQvPMkgXekf5r+YOTGYBB3IqoQEwnL5MVh8iK6NDDlcNtJrLO9caD5CNKS1xQGoMA83y5pWv
 YnjpbjrVEVblsZj33GdcN+zq0tD2NQLQ05ZEn0ibmjwVkoPVbRuO0iMLfG/lAAyG5H7T7WlyW
 vN9DwyEVhnT1exdqCtrPZTqed3q1wqw5Nm73begvYn2QIdFKm59gjQXnXs

Am 01.03.25 um 07:07 schrieb H Z:
> Hi, I have found a potential memory leak bug in
> reftable/readwrite_test.c and would like to report it to the
> maintainers. Can you please help me to check it? Thank you for your
> effort and patience!

I wouldn't call it a vulnerability if it just affects test code, as it
is not executed by git (the executable run by end users).  We still want
to fix those, however.

> Below is the execution sequence of the program that may produce the bug.
>
> First, in file src/wrapper.c, function xstrdup allocates memory at
> line 40 and returns at line 43.
> Second, in the file reftable/reader.c, the function init_reader calls
> the function xstrdup on line 202 to allocate memory for r->name, which
> is the formal parameter of the function init_reader.

Not exactly true since 12b9078066 (reftable: handle trivial allocation
failures, 2024-10-02); the allocation is done by reftable_strdup() now.
And 2de3c0d345 (reftable/reader: inline `init_reader()`, 2024-08-23)
got rid of init_reader().

> Third, in file reftable/readwrite_test.c, function
> test_corrupt_table_empty calls function init_reader on line 935 with
> &rd passed as the first argument, causing rd->name to be allocated
> memory. rd->name is not freed, which would cause the memory leak
> vulnerability.

This test was moved to t/unit-tests/t-reftable-readwrite.c by 5b539a5361
(t: move reftable/readwrite_test.c to the unit testing framework,
2024-08-13).

t_corrupt_table_empty() calls reftable_reader_new() and returns
REFTABLE_FORMAT_ERROR before it reaches the reftable_strdup() call, so
there is no leak in this test (anymore?).

reftable_reader_new() would leak name if its block_source_read_block()
or parse_footer() calls failed, though.  We could do the name
allocation only after those calls to avoid that, but that may
complicate matters.  Alternative patch below.

Also its comment in reftable/reftable-reader.h mentions that
reftable_reader_destroy() needs to be called after use, but that
function has never existed.  Odd.

Ren=C3=A9


=2D-- >8 ---
Subject: [PATCH] reftable: release name on reftable_reader_new() error

If block_source_read_block() or parse_footer() fail, we leak the "name"
member of struct reftable_reader in reftable_reader_new().  Release it.

Reported by: H Z <shiyuyuranzh@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 reftable/reader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reftable/reader.c b/reftable/reader.c
index 3f2e4b2800..f38c83f140 100644
=2D-- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -666,6 +666,7 @@ int reftable_reader_new(struct reftable_reader **out,
 	reftable_block_done(&footer);
 	reftable_block_done(&header);
 	if (err) {
+		reftable_free(r->name);
 		reftable_free(r);
 		block_source_close(source);
 	}
=2D-
2.48.1

