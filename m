Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999873;
	b=A2jfHa0E2Vm9NOOkyubr0SETZyQhWwFk1kEfZTNwv+6KXgLtELPYQdTWLtkWbrxXNc5D
	 JZ8nSzsHfF7bY7VJ0sPAZwZKwlzRmOFYzeEQCabMVyQmtO7KBcb6+ShQbcACq+MOIhRPg
	 gPasAKfiw4ojxs+/HsQlmii3/GBOm2Zfv5fUUTNcFiB3j1qLugHHKzbvUOluwX4jp0xh5
	 4ahjFz+1FPhFTn3fN5oT/rxOAY5qyzDaXaIyOXwNhhRERID6mu9eeQJ52cs275IfpxDyZ
	 9cH5SKKHpDlJUypab5a+PdFWuMLkBAMheyVqNzUaSXUR42/q1qBjaok8TWGKqL+JKsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:X-Mailer:Content-Transfer-Encoding;
	bh=oKI67W7hcOY8VGujetyAEPJQpElEnuHVxVnZ9ExcyU4=;
	b=JL9nV706pC8WQXQT8XT1nSP8IAiADHPkVvb8VJmjOCqOFcXbgt1x+++vVjabobclPaOp
	 PbzKQPfDqQvDzUkICYXThyBNkB8VaNHBbWSb/JgSw0x8gJae3YnqawtpHrwotQp3W3rR4
	 SLTrxOu+5o4DCWXETEpcTEicUUnJNfuiZ/TtXzvyB9HcS6LzOZtuGDi+5N84aKx1BMH+s
	 0yMk6ennG9idvRWCKSkkOEdGF5TyHKVYkHiYnzHzG20BNfElUgoH4A2kdihGic++/tEzH
	 R51bDRC2ttTt+9/R2SEoccnwngmnlaUc37T5yaUAFL0jWZNNepkRhnZy2kwk/NHQHwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="UI7XI2k/";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B529606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B529606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UI7XI2k/
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so4503868eec.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2026 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999872; x=1793604672; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oKI67W7hcOY8VGujetyAEPJQpElEnuHVxVnZ9ExcyU4=;
        b=UI7XI2k/DbxNLwJ1JTlGP/s3U8pIzT4gpZ5x5tmp281WqTQCCBGu20XvZJsrkzuUFk
         Sy2Psl1YGR1IYu10lihNffzBYGpr+tbSHY3v6V8Gg8rQQXI+82f5AFK0eRYCD/O8P7Nc
         K0wwfgQSR0YY/016cNPGYFMyXfAygeB38WYNISGuAlk+ou+awAF3dr7mnuOCndlWytbJ
         HuGay08GMHu7/1pXOOyqx1WZJc00vqJ9rfbyhW2GZCBLPI8YkxkHSluon5DZ3r0Y4b7x
         9a91OZHrdYLBJVH+czc6Fsep+vvHhDwrvfJ4n7LXjLDm5c2rEfVNsSv6jo0O7nZwNNf+
         4AGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999872; x=1793604672;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oKI67W7hcOY8VGujetyAEPJQpElEnuHVxVnZ9ExcyU4=;
        b=w8mfnId7nRJCdpU1TJQk18E+ICJSaOqkoXIqeUKb/PEaYy5ExFn12VryZ4+Xg3KG4a
         +pVdBkrx2hSFXXeEbQiwvJ24OKIEgULYqK1vFHKd6nK56F71Fgz6Khi/Z6eNcwcXtmMi
         e31yYuNIUP+Lpum0RfgHLZIl/VHIWyHJek7gotmhzPVjY5NUskzFT6K6aiJXpFsX/PwO
         363kV0oZI7rw3WPgV9O6nv/RtoPMtOyiifs5DOfdkqsBnIqDSbIG9UAJwgo2FY2skpDP
         C7ot7qL0znUT/eXvbHgPuT1Mw+ZMblQT4jNq2Ve+cEel77N+r7hTLV70ZgQCSKcv4iFO
         PkOw==
X-Gm-Message-State: AFq9FYLwjYnnA3cE9aPZh/SL3ePmeznhPWfd+AUcSYdogXVVgHijLTdM
	iHpDoG7RsEIGS6fu2Bq0PEsFsMJejnEYxhlnJXIZWDcPbP7fBGw/nfOb58z5xA==
X-Gm-Gg: AYBFou03k7OlOwIPtdXW8PkZbgkMxUO5AD+qJQQzVrHBXbzvaLkcGJ1oPr3Y9cntVRG
	9iR3zAy11AZycRNYwW8j0yQN9OBWq93YdhEX1/TBvINpsGp6jdRJKtDbMfbbF4UxVbTaV7EqZXt
	/4rFcey+dM3eqBTmWX3lxYeZ8x3AeWTfPZOyeKlRYvWE7FAzklQU8Vhtc0zRcAvOrPcdCSQf9FE
	f6sWLxPPQbdqpRwIq0bz5j7iOLFkcX6H4grz78zXR3M4q5Igrwdu/xX+I5YciBxkOpDPf/JN/zF
	t9n5aUktIltHrT/I/fNGQZhViel97UmZu+G/hjRbNTWboBQ8raGvuRYMs1Xo3ODphWDtYvXH2r6
	YEVILGiVB+ij59Z+VJvkwGPJeWAI+uTvmZUyWmphP/ax33DZ3b4wQ1Uf3kf1I9sbVXr3jA9xCMS
	9fGYwFOWLWmsikOElZWijTt56w+2CN+5l6m8GBcqt8Aqje7hME8HnGp9qtP/5x5sAREWrHEyqPh
	9rekc0XU2XTi1aDkhmd8XHiLJHcEmXmQ3RLluvsu11C6pex8biV62Uk3OEE7ghvYU0qhGT7MO1I
	kFji/RY=
X-Received: by 2002:a05:7022:158c:b0:19e:49a9:890a with SMTP id a92af1059eb24-19e49a98964mr6713641c88.47.1792999871603;
        Mon, 26 Oct 2026 00:31:11 -0700 (PDT)
Received: from ksivaraam--20260831-PCX54 ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369ff5a4d68sm8190664eec.14.2026.10.26.00.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:31:11 -0700 (PDT)
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] Make our clar tests ignore the long-tests
 argument
Date: Mon, 26 Oct 2026 13:01:03 +0530
Message-ID: <20261026-ks-unit-tests-ignore-long-tests-v2-0-fdbbefbd19fb@gmail.com>
X-Mailer: git-send-email 2.56.0.99.g5a7d1e8045.dirty
In-Reply-To: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
References: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13.0
Content-Transfer-Encoding: quoted-printable

(Resending in the proper thread. Still trying to figure out how to make b4 =
send=0D
 v2 in the proper thread. Sorry for the noise!)=0D
=0D
This is a small patch to fix a hiccup I hit while trying to run=0D
our test using the following incantation:=0D
=0D
  $ meson test -v --test-args=3D'-ilx'=0D
=0D
  ...=0D
=0D
  Summary of Failures:=0D
=0D
     2/1063 unit-tests                                     FAIL            =
0.16s   (exit status 129 or signal 1 SIGHUP)=0D
=0D
  Ok:                 1061=0D
  Expected Fail:      0=0D
  Fail:               1=0D
  Unexpected Pass:    0=0D
  Skipped:            1=0D
  Timeout:            0=0D
=0D
  Full log written to /path/to/testlog.txt=0D
=0D
On some exploration, we find the following which shows us what's wrong:=0D
=0D
  2/1063 unit-tests RUNNING=0D
  >>> ASAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1:print_summary=3D1=
 MALLOC_PERTURB_=3D103 UBSAN_OPTIONS=3Dhalt_on_error=3D1:abort_on_error=3D1=
:print_summary=3D1:print_stacktrace=3D1 /me/git-1/build/t/unit-tests -ilx=0D
  =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=0D
  error: unknown switch `l'=0D
  usage: unit-test [<options>]=0D
=0D
      -i, --[no-]immediate  immediately exit upon the first failed test=0D
      -r, --[no-]run suite[::test]=0D
                            run only test suite or individual test <suite[:=
:test]>=0D
      --[no-]exclude <suite>=0D
                            exclude test suite <suite>=0D
=0D
  =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=0D
  2/1063 unit-tests FAIL            0.01s   (exit status 129 or signal 1 SI=
GHUP)=0D
=0D
So, the '-l' switch that's passed to unit-tests is the problem.=0D
=0D
On searching for how these were handled before, I stumbled across=0D
9faf3963b6 (t: introduce compatibility options to clar-based tests,=0D
2024-12-13) which handled this by adding such arguments as NOOP=0D
arguments to t/unit-tests/unit-test.c. So, this patch does the same=0D
to make unit-test ignore the '-l' passed to it.=0D
=0D
The CI pipeline passes (for v1. v2 only had a commit message change):=0D
=0D
 - GitHub: https://github.com/sivaraam/git/actions/runs/39756087806=0D
   (a couple of MacOS ones didn't run owing to the lack of a runner)=0D
=0D
- GitLab: https://gitlab.com/gitlab-org/git/-/pipelines/2975804623=0D
=0D
---=0D
Changes in v2:=0D
- Fixed the s/prerequiiste/prerequisite/ typo in the commit message=0D
=0D
- Link to v1: https://lore.kernel.org/r/20261022-ks-unit-tests-ignore-long-=
tests-v1-0-554a590d418b@gmail.com=0D
=0D
Range-diff vs. v1:=0D
=0D
1:  66759f627c =3D 1:  60bc3f0d83 unit-tests: reshuffle NOOP arguments to m=
aintain order=0D
2:  0bea06fe46 ! 2:  c39dd72a2b unit-tests: ignore --long-tests=0D
    @@ Commit message=0D
         So, ignore -l / --long-tests in our clar tests.=0D
=0D
         This does not show up as a problem while running our CI as we enab=
le=0D
    -    the expensive prerequiiste via the GIT_TEST_LONG env variable.=0D
    +    the expensive prerequisite via the GIT_TEST_LONG env variable.=0D
=0D
         Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>=0D
=0D
---=0D
Kaartic Sivaraam (2):=0D
      unit-tests: reshuffle NOOP arguments to maintain order=0D
      unit-tests: ignore --long-tests=0D
=0D
 t/unit-tests/unit-test.c | 3 ++-=0D
 1 file changed, 2 insertions(+), 1 deletion(-)=0D
=0D
---=0D
base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926=0D
change-id: 20261021-ks-unit-tests-ignore-long-tests-9f32078e9100=0D
-- =0D
Kaartic Sivaraam <kaartic.sivaraam@gmail.com>=0D
=0D
