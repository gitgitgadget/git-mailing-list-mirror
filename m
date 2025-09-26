Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914E129A78
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902047; cv=pass; b=KLBLd0JaZUGsRIeUdnzR9r3QOc7UM5LTQP9wx3FRg9OzNZM2wI3Vc8a2bc0GgKyzHKkBU+9Wz8EkMAoNVsG9veoZdpQUGpf8YlEiQkc3D4Ijn9uqurR2lfZxNsDLJ6rplpCmM+3cbRyYDRwatzSDuw5+7yUc1P4avOcfzA05noo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902047; c=relaxed/simple;
	bh=owFWXUk/JNix4XM0ieDJb4XREHHOZlX+88SlZlmcLb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EaOfDut0g/iDAEzgsX0KYpXjmCi8jPD2u1uFLM7KfS1H/ddu8bgDnyonEBu6XSaRu1RSTNZLHoCWpjcFIzyoBL1lb6Ey3fSw6tptrxeLN/vlzlVjcTAeQ5183WgdxMNv9z7MRj7/D9KxlF28btYH+2l6/8AFqPKGdhoGeXU48HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=bp2HA4nq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="bp2HA4nq"
ARC-Seal: i=1; a=rsa-sha256; t=1758902028; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YiS0fVcqnyAu+pJQ7eDRgE1MP6pVj5x/+UQIyv5N5wmhv11uliIdqGXjrdH90eTveNNzUSE72bVYqQpV4a+QYZ/he8Dcto59W6Jduc+HCl+A06z1+BPRZKNuFVPVh84N0M86rS1aG7hVWy+bsUHFFb3NONbTwy7aSa5XbvG2hR0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758902028; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FnYozJ+ay4AMcbZ/c/DGD/xysQ5WMZMYE2C/KIxiP+E=; 
	b=geU1vbH06bwOgR2z+3W+Pe67ciWwu5toHvrRC8J0VfDaJGcPkFJNay4jhtDEqzPiqSRNk7+3If8NHl/o0FQG5gkv+d3OsrSY3ynzEcjyfNIDGcnxDPAoMlinbYzAXcSbx5duTLTfhFxOKCyXWFfg/nKKBwGUE3BCwsru/RsJeps=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758902028;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FnYozJ+ay4AMcbZ/c/DGD/xysQ5WMZMYE2C/KIxiP+E=;
	b=bp2HA4nqgGCVK1Mwwyl2KX9oAh3/ujrZKITlW+5oZgZ25JvEyuz973Ep+WQDUsv3
	uX/h+2yM7zzPiJUX5aGz2tTCP5BHADjKVrT2tcTV2UTc8MwAAQMy48Vyxav4fQ3sc4/
	Hd3dLmCA/LariPUtFhX2DQFY4jRkS8gyDt/1Sjro=
Received: by mx.zohomail.com with SMTPS id 1758902025924436.3883321093648;
	Fri, 26 Sep 2025 08:53:45 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>, Rodrigo Damazio Bovendorp
 <rdamazio@google.com>, Junio C Hamano <gitster@pobox.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 03/10] hook: convert 'post-rewrite' hook in sequencer.c
 to hook.h
In-Reply-To: <f408e46c-650a-4632-9628-cf817e393e7f@gmail.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20250925125352.1728840-4-adrian.ratiu@collabora.com>
 <f408e46c-650a-4632-9628-cf817e393e7f@gmail.com>
Date: Fri, 26 Sep 2025 18:53:41 +0300
Message-ID: <87zfahmcqi.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Fri, 26 Sep 2025, Phillip Wood <phillip.wood123@gmail.com>=20
wrote:
> Hi Adrian=20
>=20
> Thanks for working on this, it would be really good to be able=20
> to run  hooks in parallel.=20

Hi Phillip and thank you for your feedback! It is very valuable=20
and appreciated on all my patch series.

>=20
> On 25/09/2025 13:53, Adrian Ratiu wrote:=20
>> From: Emily Shaffer <emilyshaffer@google.com>  By using=20
>> 'hook.h' for 'post-rewrite', we simplify hook invocations by=20
>> not needing to put together our own 'struct child_process'.=20
>=20
> Right so instead we use the new api to feed an strbuf into the=20
> hook's  stdin, sounds reasonable.=20

That is the high level idea yes, maybe I can improve the commit=20
msg a bit in v2 to make it clearer (those are not actually my=20
words :).

Slightly unrelated:

I actually thought about putting pipe_from_strbuf() into hook.c or=20
someplace similar because it's a generic utility function, however=20
this is the only hook which needs it, so I've left it in=20
sequencer.c.
=20
>> The signal handling that's being removed by this commit now=20
>> takes place in run-command.h:run_processes_parallel(), so it is=20
>> OK to remove them here.   Signed-off-by: Emily Shaffer=20
>> <emilyshaffer@google.com> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0=20
>> Bjarmason <avarab@gmail.com> Signed-off-by: Adrian Ratiu=20
>> <adrian.ratiu@collabora.com> ---=20
>>   sequencer.c | 62=20
>>   ++++++++++++++++++++++++++++++++--------------------- 1 file=20
>>   changed, 38 insertions(+), 24 deletions(-)=20
>>  diff --git a/sequencer.c b/sequencer.c index=20
>> 9ae40a91b2..93cd6ab1f2 100644 --- a/sequencer.c +++=20
>> b/sequencer.c @@ -1298,32 +1298,46 @@ int=20
>> update_head_with_reflog(const struct commit *old_head,=20
>>   	return ret; }=20=20
>> +static int pipe_from_strbuf(int hook_stdin_fd, void *pp_cb,=20
>> void *pp_task_cb UNUSED) +{ +	struct hook_cb_data=20
>> *hook_cb =3D pp_cb; +	struct strbuf *to_pipe =3D=20
>> hook_cb->options->feed_pipe_ctx; +	int ret; + +	if=20
>> (!to_pipe || !to_pipe->len) +		return 1; /*=20
>> nothing to feed */=20
>=20
> Why are we running the hook if there is nothing to pass to it?=20

run-commands has a ppoll loop which calls the stdin feed callback=20
(pipe_from_stdbuf in this case) repeatedly until it signals=20
reading is finished by return 1;

Now that I look again at this code, I made the mistake of assuming=20
it needs to work recursively:
    1. write the strbuf
    2. reset the strbuf (return 0)
    3. next callback sees the strbuf is empty and stops the loop=20
    (return 1)

The line you're asking asking here is actually step 3. :)

This all can be simplified by writing just once and returning 1=20
immediately since it's just a simple strbuf to write to stdin.

We still need to keep the pointer null check though, just in case.
=20
>> +	ret =3D write_in_full(hook_stdin_fd, to_pipe->buf,=20
>> to_pipe->len);=20
>=20
> This will block until the hook has read all of the input. Unless=20
> the  hook drains and closes stdin before it does anything else=20
> it will block  the parallel execution of other hooks.=20

I double checked the write_in_full / xwrite implementations. :)

Sorry for the wall of text btw, I try to explain as best I can.

I think it blocks only if/when the stdin fd pipe is full, which=20
can't happen in this specific instance because the strbuf data is=20
small, so the write_in_full() call just writes all it has, then=20
returns.

In other words, the most important aspect I think is how much data=20
we are writing to the pipe in every single callback call.

The idea of these callbacks is to write small chunks of data at a=20
time, then switch context: it's usually the child hook processes=20
which end up blocking for their stdin input which is fed by the=20
parent which multiplexes between the parallel processes.

Of course, a balance needs to be found: I've noticed, in other=20
hooks, that if we write too small chunks of data in each callback,=20
we unnecessarily increase wait times for hooks.

This can be seen especially in hooks like post-receive which can=20
get a lot of data: if we feed one line at a time and let's say=20
run-command's ppoll loop adds 100ms delay between callbacks, then=20
from 7-800 ms we end up with something like 90 seconds!

Of course that is a pathological case and the solution there is to=20
batch more data in a single callback write. I've actually batched=20
500 lines in every write for those update hooks (we can do more or=20
less).

None of this is set in stone and can be changed. What I tried is=20
to get similar performance with what we had before these=20
callbacks.

If you notice any specific degradation or unnecessary blocking,=20
please raise it up and we can address it.
=20
>> +	if (ret < 0) { +		if (errno =3D=3D EPIPE) { +=20
>> return 1; /* child closed pipe, nothing more to feed */ +=20
>> }=20
>=20
> Style: we don't use braces for single statement bodies.=20

Ack, will fix in v2.
=20
>> +		return ret; +	} + +	/* Reset the input buffer=20
>> to avoid sending it again */ +	strbuf_reset(to_pipe);=20
>=20
> Shouldn't the return value do that?

Yes, as explained above with my 1 2 3 recursive steps above we=20
don't actually need this and the function can be simplified.

I'll do that in v2.
=20
>> +	return ret; +}=20
>=20
> The changes to run_rewrite_hook() look fine. I'm not sure whats=20
> happening in commit_post_rewrite() below though - am I missing=20
> something  or have you just renamed "child" -> "notes_cp". If so=20
> I don't see what  that has to do with using the new api.

Thanks for spotting this!

It's actually a leftover from Emily and Aevar's string_list API=20
implementation which I've rewritten / removed and this hunk fell=20
through the cracks. :)

Will drop it in v2.

>
> Thanks
>
> Phillip
>
>>   void commit_post_rewrite(struct repository *r,
>> @@ -5140,16 +5154,16 @@ static int pick_commits(struct repository *r,
>>   		flush_rewritten_pending();
>>   		if (!stat(rebase_path_rewritten_list(), &st) &&
>>   				st.st_size > 0) {
>> -			struct child_process child =3D CHILD_PROCESS_INIT;
>> +			struct child_process notes_cp =3D CHILD_PROCESS_INIT;
>>   			struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT;
>>=20=20=20
>> -			child.in =3D open(rebase_path_rewritten_list(), O_RDONLY);
>> -			child.git_cmd =3D 1;
>> -			strvec_push(&child.args, "notes");
>> -			strvec_push(&child.args, "copy");
>> -			strvec_push(&child.args, "--for-rewrite=3Drebase");
>> +			notes_cp.in =3D open(rebase_path_rewritten_list(), O_RDONLY);
>> +			notes_cp.git_cmd =3D 1;
>> +			strvec_push(&notes_cp.args, "notes");
>> +			strvec_push(&notes_cp.args, "copy");
>> +			strvec_push(&notes_cp.args, "--for-rewrite=3Drebase");
>>   			/* we don't care if this copying failed */
>> -			run_command(&child);
>> +			run_command(&notes_cp);
>>=20=20=20
>>   			hook_opt.path_to_stdin =3D rebase_path_rewritten_list();
>>   			strvec_push(&hook_opt.args, "rebase");
