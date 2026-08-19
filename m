Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C822356749
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 13:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145238; cv=pass; b=GUAmUejBBsR5eozwsHte0+epLWlUnFCRo+jGdgrd7FM3Nr/fCKILWEPvmIXqLfkNgw95YhJT5htPcgJINtEvCZzaJLviumiRCMBztx4afCxcCe+Sw+3qZJJdsnejovIOM9Bj/4BKJ0q54EFrTssJwqNKJFAbhd8lGJ09IMEvfDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145238; c=relaxed/simple;
	bh=NYQRla3VxteSFFIt/J7USpLXsGgJSq5b++AttN0BJRw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mw7jLIZH6iuNd1ybQlLhE6Fr7efa/jjeXbijJg+KUrUFnODw1aU6ty42FjwqOzpW+0rVakT8AOTtY8P9u3b7+3WyURIQi4VtdTZS03ZpMbQeDUmv/SoS47dya4Ocz4qMkU0jS0Da6CXlxj4VOD8zwKnW8ZBx3XTq2hppIUzdByg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLtxW0Go; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLtxW0Go"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-73791ee3612so613332137.1
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 06:13:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787145233; cv=none;
        d=google.com; s=arc-20260327;
        b=O/LMTAamoDyRqFEMtKRk3WRjzrccdgk2dsFlHFAB8wpa+OEFs/4Nz7V/+PPY9ETREQ
         2n8GwQVLpHpOsVWBb5ChY8DSBwC9tHh/XX8r/AUYKLsYTK/FpAA7xAN+rwprgXntf4cv
         73c089MkzhHkove5Ks3cZp3Loiwq6xHCrPkJNcetqzqnZ1QAnPGdkQXKpHl6vTTaR+Id
         stsgsIG+eZzuqdJcsUv0Kq3Md6Lik2hrxyrIGnN312fsqX0O/fxSeL4tcxf4JCaPngAs
         FiP7zVwEYxVEKYVVlryMudmC7w7l3sQ6UlTo6onMMXZBhNSon3Mo8rL4trOYW1HiCf0m
         NZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=WS8ssaT6Ii8v/qEmfCEemxPrFegoXEChLHKbTCKthzw=;
        fh=4hRD6dug9K2dA8/Qy44rHfFMnlFofhUgf7dxeZXl9E8=;
        b=RiyzvNB3FehYmswFogU7A5eQqXnhZwIdRlOMzaGW/NKkKinjXECeSKh5rwJI1UGVZe
         GTg1bishNdqxk2k6pybN5rcCXabNo9pqKhjRP9mkC3r4NZRf/WarWIIRXcqn/pHtnPj3
         BK4ZNuUXlQaodJze6EelKQClsB+LiTT21+gEKBsbftJH7+wO/HUZN5hVD+oKr8jYoYqI
         0Pl/z1Tpgyy2U+f9OBNl1Oy10Y1qM2n4UMXziKx+s3d7sICBqXek7g7Z3W1QU6FDctvQ
         edkq/48fhHd5UHoH8LSB8fD29i6u+swmvR1ZhijCYBKEMAiXi92cbQENgqogUYG6VrcM
         YhAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787145233; x=1787750033; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WS8ssaT6Ii8v/qEmfCEemxPrFegoXEChLHKbTCKthzw=;
        b=TLtxW0Go4qxDwi5992vZSjtK4U2TjfL3/FZDRd0UHO35PxmJbw3YevANOnJtOfDrHf
         +ZsLvt/j6BuCeA6QBpksQ42rBinaenYlEZKLQcio5gfDWLyr6VB7y+8JUafLU1X36Q0p
         eye1Pipo6JcPuCmfOvHZlPLZw3/PnATn7jdUQdUEEmok5DaBEKBWS/JugcfnSVQrvDci
         7idWdQnzb51L9/5z43HvfUiGVo5ATg4rE563Cd3yub/dF2rPRT6O3ki6dGvdX3HN5FAb
         DXs0+cb9tv+jeX83hbKtsdjH7ijexAWhKCs8DgBc6UerscFzmwhBLOjf90ST7SpVDkvx
         WuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787145233; x=1787750033;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WS8ssaT6Ii8v/qEmfCEemxPrFegoXEChLHKbTCKthzw=;
        b=c1FGfICK/OF60/41X02nRH8U1xHlLeBR7KNpRLGn7PVwnIp2k28cJnGp5OGrHR0cuN
         /crLLwAQpd6KA10GSSnkCFuAoEPta8T0ySX8wF8/wbLJF8Pat4pqKqdzN+fPrgX19+zr
         9Qpi8DAZXd1bQb/KRzWmuCIA59Q5RkFfQGrjqT+aFko4uF+eJpmHJFGL7sCLPOHRGYLk
         uB/C2vVyINVT1cAaItODaEMdN6BwkoqU4arSBZ5tcvGBnyYdcUuDQcZ1/EJmF70US7KE
         MKtD3NFXhbMqdXZYqdTZSplhK0DZynIxglGsddi21F6p39FKCNW9Eu3zinI9If6e+COp
         KXDA==
X-Gm-Message-State: AOJu0Yxw1AVyMpGqj8UOlr9H6JegwMFjTMlebGc/apLV+iR+FddEelw+
	vGmQOSwO5bVd9EMcmQX45W7WhoerIueFg6vuUhQIMO1aNcyfoo/HfJvzkGZCDNqI3uJYTmWFM8e
	PQqcEAQ4CTSokGbsyC0siiV24sHxNzJXnuRpw
X-Gm-Gg: AR+sD13VO29B3g5D/OjwgawdeqcaE4YtdguuLvkzTCRzrgyiNjoH/DuH7WNOLI8riWE
	0HJawYZOPXyK0OHLwV2guP1GphY8LFTqLTgys88UZqjJdp6u27BlxSnIw+6n8eNIIOE3NzWimIw
	cW+H/nNT/a/hXsyv1eZeNeinsVoTOi7oRKN9WCbTgrDhvITik8b5pVsQgxbTWu61Fwzeye3R4uI
	pbDwgYLGX+ye9zOKAHDsWVoTGtoCr/KXW0IXL96VpeY095CO0D/xtDcFBSNgAv0l22ygo9lFAEn
	Ix1FFfDGHdigkW9G8nPD8Y0co2PfJBrGJORAY8dghgqoCI85b/ZxHKJATCpAKFWKliRJ2dOwWnU
	aphP//uxu8FSomUfUZh11Y73Zl1xc3vOL3pVDISHDPBH9ng==
X-Received: by 2002:a05:6102:5f0c:b0:774:f009:e93c with SMTP id
 ada2fe7eead31-777f5c6160fmr1934868137.0.1787145232601; Wed, 19 Aug 2026
 06:13:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Aug 2026 15:13:50 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Aug 2026 15:13:50 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aoVdlC7myRFenPfV@pks.im>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com> <aoVdlC7myRFenPfV@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 15:13:50 +0200
X-Gm-Features: AcwNN1XqWQGAJDsnpfriaVOvImKCXc_AXh6qvT5Ox4iamNRWyEWiBZbCJGnIq-I
Message-ID: <CAOLa=ZTtOJLXkfZ8jKpuA9REg5CP_xxD8+kDxPAYLeRz_xR1Wg@mail.gmail.com>
Subject: Re: [PATCH] hook: introduce the report hook for git-receive-pack(1)
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000c079960659662cf7"

--000000000000c079960659662cf7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Aug 18, 2026 at 09:55:55AM +0200, Karthik Nayak wrote:
>> When running 'git-receive-pack(1)', there is currently no way for the
>> server to intercept and modify the status report before it is sent back
>> to the client. This is useful for servers with custom logic that need
>> to transform or gate the report based on the outcome of external logic
>> post reference updates.
>>
>> Introduce a new 'report' hook which receives the pkt-line encoded
>> status report on stdin and whose stdout replaces the report sent to the
>> client. A non-zero exit status causes `receive-pack` to die and the
>> client to treat the push as failed.
>
> I think it would have been useful to add context why none of the
> preexisting hooks work for us:
>
>   - The pre-receive hook runs too early, as we haven't updated
>     references at that point yet and we need to have the full view of
>     all resulting updates (both objects and references).
>
>   - The update hook is too inefficient as it runs once per reference,
>     and we cannot trivially determine the last update.
>
>   - The reference-transaction hook cannot be used by us because we care
>     about the phase where it was committed already. And while the hook
>     fires in that phase, it does not allow the caller to modify the
>     result in any capacity.
>
>   - The post-receive and post-update hooks cannot be used as they run
>     too late, at the point where we have already reported success to the
>     client.
>

Yeah, this is worthwhile mentioning, I already have made the commit
message a lot more descriptive, so it does become bloated. I think it is
justified though, since more information is always more useful than less.

>> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
>> index ed045940d1..7e6643ad89 100644
>> --- a/Documentation/githooks.adoc
>> +++ b/Documentation/githooks.adoc
>> @@ -527,6 +527,29 @@ The exit status of the hook is ignored for any state except for the
>>  status will cause the transaction to be aborted. The hook will not be
>>  called with "aborted" state in that case.
>>
>> +report
>> +~~~~~~
>> +
>> +This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
>> +`git push` and updates reference(s) in its repository. It executes on
>> +the remote repository once after all refs have been updated, but before
>
> I'd drop "remote" here -- from the point of view of git-receive-pack(1)
> it really is the local repository.
>

Yeah, makes sense.

>
>> +the status report is sent back to the client.
>> +
>> +The hook receives the pkt-line encoded status report on standard input
>> +and its standard output replaces the report sent to the client. Any
>> +output written to standard error is forwarded to the client over the
>> +sideband channel and will appear as `remote:` lines on the client's
>> +terminal.
>
> This assumes a bit too much about the implementation of the client, as
> it may not even be git-push(1) in the first place. We could still
> mention this, but we should say that this depends on the client.
>

Yeah I'll make it specific to git-push(1).

>> To reject individual ref updates, rewrite the corresponding
>> +`ok` lines to `ng` lines in the output report (with an explanatory
>> +error string) and exit zero; standard error can accompany this to
>> +provide a human-readable explanation. A non-zero exit status causes
>> +`receive-pack` to die.
>
> We should probably document that we expect the hook to never return
> non-zero, even if it rejects reference updates, and that doing so
> indicates a bug. This is mostly because git-receive-pack(1) shouldn't
> ever just die on the client without giving it a proper status.
>

Yeah, this is a part I was thinking about but wasn't sure if it should
be added in because, we could also do an implementation where we simply
ignore the exit code of the hook.

>> +Note that by the time this hook runs, all ref updates have already been
>> +applied to the repository. A non-zero exit causes the client to see the
>> +push as failed, but does *not* roll back any ref changes that were
>> +already committed server-side.
>
> Good thing to call out.
>
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index 86933d8d7e..bc22b3ec31 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1004,6 +1004,41 @@ static int run_update_hook(struct command *cmd)
>>  	return code;
>>  }
>>
>> +static int run_report_hook(struct strbuf *report)
>> +{
>> +	struct child_process proc = CHILD_PROCESS_INIT;
>> +	struct async sideband_async;
>> +	int sideband_async_started = 0;
>> +	int saved_stderr = -1;
>> +	struct strbuf out = STRBUF_INIT;
>> +	const char *hook_path;
>> +	int code;
>
> Nit: I think it's more commont to call this `ret` rather than `code`.
>

I copied over another hook to start, and left the naming as is. I'm okay
with changing it to ret.

>> diff --git a/t/t5412-report-hook.sh b/t/t5412-report-hook.sh
>> new file mode 100755
>> index 0000000000..47f20e8d67
>> --- /dev/null
>> +++ b/t/t5412-report-hook.sh
>> @@ -0,0 +1,176 @@
>> +#!/bin/sh
>> +
>> +test_description='test report hook'
>> +
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> +
>> +. ./test-lib.sh
>> +
>> +. "$TEST_DIRECTORY"/t5411/common-functions.sh
>> +
>> +URL_PREFIX="\.\."
>
> I was about to say that this looks unused, but it's used by
> "common-functions.sh".
>

I didn't know about this too before.

> [snip]
>> +test_expect_success "hook stderr is relayed to client via sideband" '
>> +	test_when_finished "rm -rf upstream" &&
>> +	test_when_finished "git -C workbench remote remove origin" &&
>> +
>> +	git init --bare upstream &&
>> +	git -C workbench remote add origin ../upstream &&
>> +	git -C workbench push origin $A:refs/heads/main &&
>> +
>> +	test_hook -C upstream --setup report <<-\EOF &&
>> +	echo "hook-stderr-message" >&2
>> +	exit 1
>
> Should we maybe not exit abnormally here to see that the push succeeds?
>

The test right above 'hook can report a custom failure message', does
that exactly.

>> +	EOF
>> +
>> +	test_must_fail git -C workbench push origin $B:refs/heads/main >out 2>&1 &&
>> +	test_grep "hook-stderr-message" out
>> +'
>
> This should have the "remote: " prefix, right? If so, should we verify
> that?
>

Yeah makes sense. let me add that.

Thanks for the review.


> Patrick

--000000000000c079960659662cf7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 217d211416122562_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xRnJBMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOTg1REFDTlRjenAyb1BIUFFaRG9lSUpxOW16WHgvUQovTGNjYTRxSk41
VVFUSjBiQkYxNm1JNXlnSEtuSGFLYUZmRUVEZ3FJS0NZTXF4bnBYaEdwVkxKdlltUGtPYWJRCnJa
RUVHU2NTSzRiSTJBT2VDNzRXdSs1QXRVZXFGdmZTaTJpNWZLMVhSWVlacjNXNS9Dd0V1bUNZanZR
RThGZ3YKV0NHaU8rMkk2bEROMHR4aXBBRGNLeHY2Z3BUVURPTzBkNCtWTk0zQkNab2ZXQVdaWEFH
anhlSm9RbVNsMnhVTgo5bGpzRXVvbEltYks1MjJIUnhVT2hWZUJzMkRNekdRbEgxWnFRR1VrM0tG
S2hRbUFzS1RxbEJGMzNmUHRXZC9JCkdQN2NGa2NJTHNCdTRFVm9QSXgzdlo5bllpZ2VyZUFRYWRi
UlU0R1p6MEdNRlloNHVOWlNkMkJXSzY0WHZTY0gKRW9xVnJFb2Izc09JUDhyUnJtNTJ2ZnJYZU1M
YU44bHU2cWNQYnBQUlhZUXZBOFFCcjFGYm9UT3I2Q0x1aDhldgpkYnFiUERHQ3NpbWhLbWxGR09x
SnpSN3JGcHR0VlRzajZQbGlFbDArU1N1WU52aEI2d2U1NnZpRFVoUkd3SzNoClhrbyt4dGdXU0NR
WnVlTjlpYmx0QTlsQ0pNU1NqL3pKRjk0ZkpmYz0KPVAwSE4KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000c079960659662cf7--
