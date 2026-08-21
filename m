Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C566F360EC6
	for <git@vger.kernel.org>; Fri, 21 Aug 2026 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328501; cv=pass; b=feA4I3WefC2U3oxw8NN3ygDYThyYk3KFtphw66q2Hsi72yA6lcAOZi6MqoV/S0ZGGn2HtS56GTzUECVQOaHxuFaiPUd/fJSfPHCFAxHWys6ItfM55r29iovGRXJvFocrdVCs0HCQpb/i4aWHgfXZ5CskrE5qBd+0O6gqmvAsyak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328501; c=relaxed/simple;
	bh=r5G8NvN8dEBXcMuwdXQB0OMVM59vMQlTf8kwmJmlp98=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sono0lRZNxwXOHE2aKR390qiyFK8M4uIpGGabAhsGYQyGI2ad8bOpzLIdgaGwXL5kwsjWNBgJWqAG9joyqI3lw4uUf4AYPGv0+4KS7crrvMfrn2CqUx5xUjt3npB6tW42duuFlmBFwVzGoyyqTiXMSNtYUT4vm1m784WhmZKZBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpRVEul6; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QpRVEul6"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-73720e58dafso618727137.1
        for <git@vger.kernel.org>; Fri, 21 Aug 2026 09:08:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787328495; cv=none;
        d=google.com; s=arc-20260327;
        b=pPwqWn1WigPFy8IsWoOUezjVP5k07IqevyOr0C9DgJISwPoSXNBBr1R37vQPp9OB14
         tEtgXMCE3s612LIdXl2wsnp7xrr1wcLc1QbPDehCFrPl+wmbxkaDH0WF21hruoy/RMg/
         KNGe12LSnERazBJw9HymzAEqi31hGmD84B/HvkxB01J4WpxBjDUKW4Ra0qQ7YnIk8csf
         USmNcWsB9lbNJFwElim30c75Ge850xDMn4oWVyLaIEdaNtUUqFiXhRSIGUVKLoH9leNw
         hmf/VKqXyahZFbsKzY2lhiTIXyaMG2e/oHS30URWkSh/yEVHtPpqf4rU7em7GNk1lZAm
         9X9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=PS7qwEEIffdisJCMt7nAvq9BDJaa/pXceaT+79tLHFs=;
        fh=R0e903i4GOHrQVdggdwhyX7TTQ+IR/hBSCjxTjTr7jQ=;
        b=CFwobIRWgnv141a/Q3c1/jssT7flgG0i0G1bZyQqJIKOd2yob/y0EU/QKzPk76PK6v
         1flZc3smsMuqyhYnR94YBM5ZfGm7J8nrlubicuxxGRKUUzudPB6hnGf3vLWAkpxUHJqU
         6vtNBbwKA13Ch9VTNNhg1KC9HT1rQRt7ylqkvqyyF+yqJPiG05PC0R36AeX/CrffijwL
         6LqKGOQxpjBo8RmCd1CHGF3AJTkfpkmvA+DPVIZuqBAcA3Q+yUu1Abr3V3feM6tW1KQP
         jHZdYFjaRE7CV5gvir57hajot9wCwoaGo6cvmk3y0bIn8xnHIjsT/mkFfRiGdSNpsAxz
         tPEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787328495; x=1787933295; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PS7qwEEIffdisJCMt7nAvq9BDJaa/pXceaT+79tLHFs=;
        b=QpRVEul6WQqte98ACFnIo4Pc65K3ZD2a4f0hsQkCl2TebR6dRJiKnV9Ajl0Cp/0Lw8
         /BuPY2N4BtlXF6x/PpLq9Md4pEfgYUenTFOuUS+shd4xis42TTku76uZXa8pS1i4zGSK
         1kLyKiAJMxZS1BnAx1wernggHskYmpybLOrRhxzwtycW5FcuPRpfG6sTzuJzbIsMy9q6
         zTOuVDGzo9KbUGMzUDQxKtPykH0UR0SZXXan0qrxyB3KcAmEDNOjmObwDbg64whzlY0T
         9gnGzZ9z6c6VxZQA9jBCjx60cByxCpJJV72Sg65d+06cRAjEyh8hGAxU+D+Ua0tTob8K
         j3aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328495; x=1787933295;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PS7qwEEIffdisJCMt7nAvq9BDJaa/pXceaT+79tLHFs=;
        b=Fp+H4DdWf2X1s0x7SkycqRIH5d6MPLWT2ToREjZKGTG/QYobEPUYTy2l1UXH+buOiq
         A2pyKHdTUUn+e7A1aY014G01qjETzz7TPCn/s903A3p7p365AcZaedOD5Z7ZofvImnV2
         ltrRg0iPModQFYo0IYVL5eqcM8bQcIA0uqllNrW+l2Kyo1TvXqCdvuH7b+cj2h4OqSnc
         Npk/jNsGfS3puMSkSxN6G1nMc0esujn0J5sIuZJdgnXyOIFEOz+4D3z6Jf/CjPDF9Vq1
         i3QAzRY+QXHZWOOxSNaC0I8J6EcMVZ8RPlG2i6HovJnN/PGgHBZ70LNMh+2UnJHXOf6L
         XohA==
X-Gm-Message-State: AFuF++kR6mNjpLhSCCgGZNara0zW0NxLbK5vfPsdf+b1NICenMxHMm2P
	ZQvVTm5tu95MNyBrai2KkNidcR2IhYZb3BpUJeGcLtRcuDDBpywZjhdTdvWpBEE3Uc/ivaJO03U
	2oXIWFbaGQYLonbIbz9cvazrCdiGW+CY=
X-Gm-Gg: AR+sD114win2NnPOlg4nvxk5R9lKw/koJzvC58QyzfCWAYPV3u2mhbDKeoa/sQmV5mJ
	Vma2+DkaNRKBFrlqFGi5iAiw3pNn/HY7sGl7pn9afk2f2hr7B7XAiOT7vX5LpnO8UiQziJycNrj
	u5jKW3wvneFziE7PnpeqpaSAkAtlmFshtaLwG7F094TuqksnuO3sEnE34qz9gv7gmtgQn9E8wOF
	ZELK4nknMMUv00vB/vLsyAXZZd8xLlpfmoMokgxjghzfPVR3kivLvQvf7w8hClpA+CWaajIygCU
	qD822zbC9/IWk7I/ZWZsexGfCQ07GfBp5YRORnhRnmDBvNehkSecepCKNpX3xXeOqltdtuENE4l
	+zNEooVby2+BlnMFxsLiwrN2WWGkvNv8V/VQ=
X-Received: by 2002:a05:6102:6a90:b0:738:6994:eb8 with SMTP id
 ada2fe7eead31-77a5eee715amr3582593137.0.1787328495052; Fri, 21 Aug 2026
 09:08:15 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Aug 2026 09:08:12 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 21 Aug 2026 09:08:12 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aohXatWhxCAUQTcq@pks.im>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <20260821-758-introduce-hook-v2-1-e90e2f7ac2cf@gmail.com> <aohXatWhxCAUQTcq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 21 Aug 2026 09:08:12 -0700
X-Gm-Features: AcwNN1VHoNv5sw1MNDCDWGLp5ZclAnIC6iLU40vco7OET9cB1ESTLAip7pfxgZo
Message-ID: <CAOLa=ZTkW14coLA4st-m6B6P-9pUr+Yzh7Ph6nb0ohXJSbTk4A@mail.gmail.com>
Subject: Re: [PATCH v2] hook: introduce the report hook for git-receive-pack(1)
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, kristofferhaugsbakk@fastmail.com, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="0000000000000b860f065990d8d0"

--0000000000000b860f065990d8d0
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Aug 21, 2026 at 03:34:58PM +0200, Karthik Nayak wrote:
> [snip]
>> - Exit 0: the hook's stdout is used as the report. The hook can
>>   rewrite 'ok' lines to 'ng' lines to signal per-ref rejection to the
>>   client while receive-pack itself exits cleanly. The client marks
>>   rejected refs as '[remote rejected]' and exits with a non-zero
>>   status if any ref is 'ng'.
>>
>> - Non-zero exit: the hook's stdout is discarded, receive-pack calls
>>   die(), and no report is sent to the client at all. The client
>>   observes a sideband disconnect and reports 'the remote end hung up
>>   unexpectedly', treating the entire push as failed.
>
> I was thinking about this case a bit more. Should we maybe handle it
> similarly to the pre-receive hook instead of dieing? If that hook fails
> we basically update all references to "pre-receive hook declined",
> whereas we could update all of them to "report hook failed". That might
> make for a better user experience.
>

I didn't know that. Just had a quick look, It would be a bit awkward,
since we send the pkt buf to the report, and if we go this way, we'd
have to restructure the output again.

>> diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
>> index 0956086d61..e6cc0acaaf 100644
>> --- a/Documentation/git-receive-pack.adoc
>> +++ b/Documentation/git-receive-pack.adoc
>> @@ -236,6 +236,21 @@ if the repository is packed and is served via a dumb transport.
>>  exec git update-server-info
>>  ----
>>
>> +PROC-RECEIVE HOOK
>> +-----------------
>> +This hook is invoked by 'git-receive-pack' when it processes push
>> +requests. It handles refs whose names match the patterns defined by
>> +`receive.procReceiveRefs` and executes the actual ref updates. See
>> +linkgit:githooks[5] for the full protocol description.
>
> This feels like it should've been a separate commit.
>

Will split it out.

>> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
>> index ed045940d1..06c9e4b017 100644
>> --- a/Documentation/githooks.adoc
>> +++ b/Documentation/githooks.adoc
>> @@ -527,6 +527,57 @@ The exit status of the hook is ignored for any state except for the
>>  status will cause the transaction to be aborted. The hook will not be
>>  called with "aborted" state in that case.
>>
>> +report
>> +~~~~~~
>> +
>> +This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
>> +`git push` and updates references in its repository. It executes on
>> +the repository once after all refs have been updated and after
>> +`execute_commands()` has applied all accepted ref changes to the
>
> Nit: I think we shouldn't talk about functions in our documentation, but
> rather about behaviour. Functions are likely to change, and I don't
> think we should expect our users to read our code.
>

That's a good point, will change

>> +repository, but before the pkt-line encoded status report is sent back
>> +to the client.
>> +
>> +The hook receives the complete pkt-line encoded status report on
>> +standard input. The report begins with an `unpack` line indicating
>> +whether the object transfer succeeded (`unpack ok` or
>> +`unpack <error>`), followed by one `ok <refname>` or
>> +`ng <refname> <reason>` line per ref that was pushed, and is
>> +terminated by a flush packet.
>> +
>> +The hook's standard output entirely replaces the report that is sent
>> +to the client. The hook must write a valid pkt-line encoded report in
>> +the same format it received. The hook's stdout is fully buffered by
>> +`receive-pack` before any data is sent to the client, so the hook's
>> +exit status is known before the client receives anything.
>> +
>> +There are two distinct ways the hook can affect the push outcome:
>> +
>> +* To reject individual ref updates while keeping `receive-pack` alive,
>> +  rewrite the corresponding `ok <refname>` lines to
>> +  `ng <refname> <reason>` lines in the output and exit with status 0.
>
> It's `ng <refname>[ <reason>]`, right? I think the reason itself is
> optional. We might also want to clarify whether there should be a
> trailing newline or not.
>

You're right, since 'send-pack' will default to 'failed' if there is no
reason.

We do say 'terminated by a flush packed'.

> Thanks!
>
> Patrick

Thanks for the review :)

--0000000000000b860f065990d8d0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b1ef1e05b711e73c_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xSWQrc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meEZzQy9zR1VSdzBLb1ZkNjhXTnlvNGU1V0kwdDYzWApSNTV1WE5TUi9k
dUhzR1p1QThwZWtMUU1YUTJrSm1pTkg3SmhNNS9HMHRHQzR6eW82RnlYSXBRNXdKQWRjWDJlCmNG
UWRyOXIvN3JDZ0NxNVlGcllqVmZXUGF5YlF4bDBCVUdlZG5udXhCeWNYQSt6T2U5NjF3Mm5NbUpK
OW8ycGsKRHVPbXJxZkNPUVpnNDRubWZ2WmdaYXkzcTU4SUpGT0lXaEljVVZEMHJxSmRudEQ0WkQr
clMrTk1RRzE3dHRlSwozalI2NUxZeEFMRnRNb01Td29Bc0N1VHE3QXFFV0tsUCtmOGVydzlxRVRQ
aHF1NnI0cDZOQ3pyQTI2YTZqSnVzCmZLM2V0STJzV1hObXNsekcxV0s5TTI0L1R4dUNTK2hWbE5S
SGw2d1Ntazl0UzBCd1JCT3N1a2xOREZoVDNHM2MKM3JXMUk4L2dlU21RbElpV2JKNDRnRlZ2UVk2
ckpRUE9tV1V6R0Q1bnN1VWxQdG0vRU9BVTArOEpYaS96TGN0bgpDS2pqSDlpNTZNbDZSRnZvS2Fk
ZFYrWlJaV1JtUGhidWx1TG9PdkRBbzBvNHhpQzJoWUdRdWNOSDRyaWdVNGFOClgwZFlzUlBZaVQx
ZEVNU2V0WlFMQnVBNy9iN0xEMDVLaEV6VmV1az0KPVp4aWQKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000b860f065990d8d0--
