Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172623B6377
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787141483; cv=pass; b=oI8yQ/DTbUGDHPEC3AMGz1epGyJMhZms6rc2Uh0iw8U6kpAPwkDD53IhRgsaaNv1fDGNBefRpk0Ou40nYITorOQEKNzTha0zNz7y/bxk6sr9mcSmyqq7LBAGT6hsoohdOB+9Se0eIlvEbtqJXXMfD8umboqETLO1+qfwjRdpbak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787141483; c=relaxed/simple;
	bh=l10z1WaiFs2m7CBbQVEyB++/J/edju9r6dErKyLloJ0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=rSN50BgI3S9Ue7suoIUMa9EQEGLEm2zwfBg1u0N/zqnjsLQ9mbWfqFiRE5SC8ojKTjS0rKffxk4LuuBpK1UneWqfJddMIuiLzn5Q/eBCviOclSoREBviMvj1CPYYekHal+kfpm4I6kfl7GovHCAJpCCIh6VIc8ICDXuvt5Y9Dps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMN7xdc3; arc=pass smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMN7xdc3"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-966e7380109so692988241.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 05:11:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787141481; cv=none;
        d=google.com; s=arc-20260327;
        b=UUvPuKimWAe46cEqKaM4NeYSphV0n9J2U+NwTi31ACFCcUcXW6PgBEJC2jdwjXE9Gf
         kgbGMVq5px0jwGm3OUX0JK2pIyRbp+19dAYRbSs8hZl4zGcAg/CNbOz+HmRUGiwqjw43
         P75K281E6+sPaSuOIZ0Igt8RbqmO8AiQ7rhWnQ3MJbMgaDRWsFZso27GccXYtHe0nmw2
         Dqgo8ZC1XKvITpldZBKeQ0tcKn1jWDhBAn9o0zkmU8tD4+7TYRGtEp8clheS4BIf4jDu
         +ElhbYSrq7xpPf21u3pOreS8BkKEtJ3JJpBsAscz7mnxy4PAp2jPkJMEvFxLV/k/FAhq
         q7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=oA/l5PPWEfpXlY1GYFL3bnd5HL6qH1I3WHRluGs+a0Q=;
        fh=397sm3eC/DEsAu0FHnC8E6joc58plR39iZHiFPXD6Nw=;
        b=soXSxOlsRIEUT3ZjVvTUK03hNMU6XL8tqj3va5LLuD2CnEFCDpVdDI23r59n2R69l+
         YshI1E5J0ZNoni8lKmgAN6EgSGBEg4woZf1ql8MZbJZg04fH8X+8+7b5yIuGAz5FXvrk
         wAbUB5k3TzcZ/Pt1w16G5XjAUR+azHsjWnEK2UDhSSvqlC07H0jZEznr/h4WqX7Z6sLV
         Xx5r1CxWMxi5/mjWXUrmTICOM2mDUlEt7SXcRLLvWfncfChdA+hQ7KrPWCDN7JHuN4aU
         jr5tg60m7WyJ5z9P+qYxvTEEepXDHDjTFbV/dUboBhmMkVyXEB/sS2w3HQzmHsvwyPCW
         gtFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787141481; x=1787746281; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oA/l5PPWEfpXlY1GYFL3bnd5HL6qH1I3WHRluGs+a0Q=;
        b=VMN7xdc34sFnBOHJuHlT6Ju01fcJZRbQlLUz55o5OeCEcr9kn9L4Td3NLlnKHBpjOf
         XdeibY0SqGtx6W50aEiHV3rGfvk4wMlF7CJ1SOXajoq1Com0ucb97totZFOwUrDUgL9c
         RVRBEoxo16NZNZPtZRfUMa8EqgVgLP/Q3MYewIojuj8ompsY4ABQ+0T5aVu2VDQRYN01
         9tBGjojvJZXijP8QFWH7/7t2K2q6rbL4JrjMSjJJz2GXV7xC612wUUe9cw92uwt8lgdm
         kszNsBZpKpekJRsq9Pdj5H/swLdVRT4YGoXw533DOh3GTz7oz8qJ4Sipemhc9J9JN0rw
         auQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787141481; x=1787746281;
        h=content-type:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oA/l5PPWEfpXlY1GYFL3bnd5HL6qH1I3WHRluGs+a0Q=;
        b=cVa4sk9r1kj4nLoIlGdzYJBmZzvijIgu2fZ3gyap5VVsUVjrT8WKo4WIOk/DQpgJzD
         iIimv7zBmRMjUKAul5wqhYVnsDq1/+3XnLO7/wYQdxHFlxaja/Hx6/FiX2E/ZJxCSsFN
         d23HPdPhqFlR6GIuspo3cgOyTUI/asbq33MNQOE+/aZRtkG7MmdLMPPNY3PeLlN2g6d9
         VmkN5B2+txCqfknLTzi2nr6hDgwEBfLoce7xjMA6c+SKuGh0MWJEokI7cX/QhNKLS6PI
         djo+GOw8V+8ARengQoLcolSm+FIT8ZoAnp1FdDekP1baJKPefkMpkBvS43sGvRQlrAG8
         JfRA==
X-Forwarded-Encrypted: i=1; AHgh+RqX7ZxR8S3sO2oFqvOyXrxjf7QMXiMXL78R22gVwuxSv4sNoQfrhn4nU2wd7wDWAOE/Wvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBlqA0QVzKa6yfogle7c9rV70oYItTupAMxG4tqonDEtWNaGjL
	An23HVnb+ggGgYjtiXWcxscUT+Z3v2dFK9FBU/IM6R+ziUhxO6pbGrt8kh1qKRF1tSu4CFVRS+x
	E89O/YGcL/z6yBQMUkKUddR+YSq2x7k1tHlGP
X-Gm-Gg: AR+sD11vUwcB27Gs1lhwYTsLK910FZMXvD1gAetf7oApfF5j3jHv5UlX7m4YF2Wxejr
	sl2oZpNolOUHe3XMOZcgTNzvCewMfTeC2fDeP8PTt0c37Nj8Po87UXzpf9Wlg/XsMny7S4aYwh4
	M7uulzVUE2koy2Ybo9j0iVM+H9nHPHc4KMoypqP0ltKVxM7jdH1+OoAcvyDTkMBgep6iQcPvIn0
	MUMMAWWaDsNcHs4kqYEEkYqyu5b1v56GqJNeKgvhd7zNKTOm/4D6/dw/AZqeMWACBRhYt1u4AUI
	QyaLiTSk/YDQ0ZnXxSWHMRGQ3Z3islTsL9s5vJah9CXL6Koo81LDmbNGKAX/nEcauyaYlclDQjV
	Wjs3BbMdY+v8bILMOuW7GsCCHECezpMNS7LY=
X-Received: by 2002:a05:6102:fa5:b0:74c:11b2:a944 with SMTP id
 ada2fe7eead31-777fb5cf1e7mr1381167137.14.1787141480683; Wed, 19 Aug 2026
 05:11:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Aug 2026 14:11:19 +0200
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 19 Aug 2026 14:11:19 +0200
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <7dc975d2-324b-46a4-a389-9af96f4d5d57@app.fastmail.com>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com> <7dc975d2-324b-46a4-a389-9af96f4d5d57@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 19 Aug 2026 14:11:19 +0200
X-Gm-Features: AcwNN1Vob3MoLgk7ftY65HDmBjdGdI3FUoCtOmvUHV9jrPtP-Sn98Zgvgdfr5V8
Message-ID: <CAOLa=ZSN+h4TkZrqPPRNZ58Pyfamv9_tM=m7W8_RYhUU0p0q0w@mail.gmail.com>
Subject: Re: [PATCH] hook: introduce the report hook for git-receive-pack(1)
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000001eb8d70659654de5"

--0000000000001eb8d70659654de5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Aug 18, 2026, at 09:55, Karthik Nayak wrote:
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
>>
>> Similar to the 'proc-receive' hook, this does not use the config-based
>> hook infrastructure. That infrastructure is designed for parallelizable
>> notification hooks. As this hook is a bidirectional filter, it would
>> require significant modifications to that infrastructure and this hook
>> cannot be parallelized anyway.
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>> To give some context, we at GitLab are building a custom MVCC around
>> Git. Each git-push would initialize a new version which is then
>> committed as the default post some operations. These operations take
>> place after the reference transaction and based on the output status of
>> those operations, we want to propagate the status to the user. There
>> currently exists no good mechanism to do so.
>>
>> Having a report hook which allows us to modify the report being
>> propagated to the user, allows us to modify the report based on the
>> status of our MVCC commit phase.
>
> Personally I think understanding concrete things is easier than
> understanding general things. And discussing the concrete case in the
> commit message would help with that as well as provide the context for
> git-log(1) rather than just the people who have read these emails.
>

I was conflicted about it, since while it does provide some context, it
doesn't apply to most usecases. I will add a little more context in the
commit message.

>> ---
>>  Documentation/githooks.adoc |  23 ++++++
>>  builtin/receive-pack.c      |  41 +++++++++++
>>  t/meson.build               |   1 +
>>  t/t5412-report-hook.sh      | 176 +++++++++++++++++++++++++++++++++++++=
+++++++
>>  4 files changed, 241 insertions(+)
>
> Should the git-receive-pack(1) doc be updated to mention that this hook
> exists? I don=E2=80=99t understand the setup here. The existing
> git-receive-pack(1) doc has sections for these hooks:
>
> =E2=80=A2 `update`
> =E2=80=A2 `pre-receive`
> =E2=80=A2 `post-receive`
> =E2=80=A2 `post-update`
>
> But not these:
>
> =E2=80=A2 `push-to-checkout`
> =E2=80=A2 `proc-receive`
>
> (referenced against githooks(5))
>

I didn't know about this. I wonder why we have two sources of truth for
the same. As you see, it's already starting to diverge.

I will add both of them with links to githooks(5), but perhaps a cleanup
there is in order. I would say making githooks(5) the canonical location
with git-receive-pack(1) referencing it makes sense.

>>
>> diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
>> index ed045940d1..7e6643ad89 100644
>> --- a/Documentation/githooks.adoc
>> +++ b/Documentation/githooks.adoc
>> @@ -527,6 +527,29 @@ The exit status of the hook is ignored for any
>> state except for the
>>  status will cause the transaction to be aborted. The hook will not be
>>  called with "aborted" state in that case.
>>
>> +report
>> +~~~~~~
>> +
>> +This hook is invoked by linkgit:git-receive-pack[1] when it reacts to
>> +`git push` and updates reference(s) in its repository. It executes on
>> +the remote repository once after all refs have been updated, but before
>> +the status report is sent back to the client.
>> +
>> +The hook receives the pkt-line encoded status report on standard input
>
> Another naive question (I have never used any of this). Should this link
> to some gitprotocol-X(5) after `pkt-line` in order to have a link that
> explains what it is? I don=E2=80=99t see any mention of `pkt-line` on
> git-receive-pack(1) or a mention of a gitprotocol-X(5).
>

We could link to 'Documentation/gitprotocol-common.adoc', but I'm not
sure if it is erring on the side of being too verbose. I'll leave it out
since its already existing and assumed to be common knowledge for users
of such hooks. But happy to add it in if others disagree :)

>> +and its standard output replaces the report sent to the client. Any
>> +output written to standard error is forwarded to the client over the
>> +sideband channel and will appear as `remote:` lines on the client's
>> +terminal. To reject individual ref updates, rewrite the corresponding
>> +`ok` lines to `ng` lines in the output report (with an explanatory
>> +error string) and exit zero; standard error can accompany this to
>> +provide a human-readable explanation. A non-zero exit status causes
>> +`receive-pack` to die.
>> +
>> +Note that by the time this hook runs, all ref updates have already been
>> +applied to the repository. A non-zero exit causes the client to see the
>> +push as failed, but does *not* roll back any ref changes that were
>> +already committed server-side.
>
> To my naive eyes this description looks good and without any obvious
> errors (typos ;) ).
>

Thanks for reading through

>> +
>>  push-to-checkout
>>  ~~~~~~~~~~~~~~~~
>>
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>>[snip]
>> @@ -2592,6 +2630,9 @@ static void report_v2(struct command *commands,
>> const char *unpack_status)
>>  	}
>>  	packet_buf_flush(&buf);
>>
>> +	if (run_report_hook(&buf))
>> +		die("report hook failed");
>
> Okay, it seems typical for this command to use regular strings (not
> translated) for errors. Which makes sense given the application. There
> does seem to be translated error strings but one example is =E2=80=9Crefu=
sing to
> update current branch=E2=80=9D, which seems to be more of a non-bare, end=
-user
> error than a server error.
>

Yeah, since these are generally less user-facing (I say less because
this can be propagated to the user, if the hook exists with a non-zero
error code) I choose not to translate it. As you mentioned, this seems
to be the way for such error messages.

>> +
>>  	if (use_sideband)
>>  		send_sideband(1, 1, buf.buf, buf.len, use_sideband);
>>  	else
>>[snip]
>> diff --git a/t/t5412-report-hook.sh b/t/t5412-report-hook.sh
>>[snip]
>> +test_expect_success "no report hook, push succeeds" '
>> +	test_when_finished "rm -rf upstream" &&
>> +	test_when_finished "git -C workbench remote remove origin" &&
>
> This teardown routine is common to all the tests. Is it better style
> here to write it out compared to using a helper function (test code is
> different from =E2=80=9Cnormal=E2=80=9D code)?
>

Since tests are self-contained, I usually keep the teardowns within
them if they're simple enough.

>> +	git init --bare upstream &&
>>[snip]

--0000000000001eb8d70659654de5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 598729efabe8de23_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xRm5XWVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meUQvQy85R2Q4WFJrK01WWWlSY3VqM0xWYUdXaG9hcQo1QVU2b3hhK1Jp
YnVSbnEwSWJqS0NGS2puSkx6VitseHJWejVzTFc2VEZodVJaS0xsSnAzVVdHS1RTbTNOUnpBCllm
K3pmUS8yVzJhZUNPTjNVbGVuZjJpeVJibkJldUFTUUI2VlJtMzE1MktidVlSeXVDNnJPQ29PcW1v
VFlrTDgKb0c5a3UzaTRBNUl0Y2NVZjEyMFdLQlNDUFp6Tzg4QmJ3Z21zR3pqWWErcDlUNDBrcG1C
Q2traWwzVzBkYVhaagoxa1loSkovSGp3bG9YbEZ6THhMeDh0bGxzRGFqNnZxSGpHVDFFRjZCWEl1
ZDVaTm8xZDFnSEtxV2tib2JEbTljCldqNTc2L2hNWVhYcWpJNXdIZVVCdXp3N3E1ZUtTTXpPN2FB
Q0pyVWFmY3Z6Z2V0bmJQRFg0SHdGdVEzSDFlbGQKVFJLNzVicWE3dFZHcG15d2t2UE1LK0oxejZ1
U3J1dzc3NnpHK29Obnl6UG1MT2VmS09IanFUSzFvMTByMExTcgpkTmt2K0FQcWFNc3prTGJHZk01
bUtGVnVCK0V5b2tiSldsajlBVGFSSStPbGZ6QXk5UGJkREFkRy9XcGNUWmp2CjU1bTNpckxqaERL
NTZ6VVVFRGF5b3JOTlpTU0FZQWprb05IeFJUWT0KPXE4R0oKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001eb8d70659654de5--
