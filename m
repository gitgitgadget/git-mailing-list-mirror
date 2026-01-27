Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D0433B962
	for <git@vger.kernel.org>; Tue, 27 Jan 2026 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519173; cv=pass; b=eSVLrFW0J2rJOtJEkM9N3S7dOQ4pEbGQaQAvyn5iwK89+jejbpyfgc3d2BH36RQvBpVtfatb0xrKm7nA+GtucMI22/eKWhnlQhvBLRJpQpo6yuY81JpgkQ4ddcmXpHujb2lq0dkUzxk/snjupo6vT6V/ecgZ7CP77/axuED5NqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519173; c=relaxed/simple;
	bh=KqL27WMEzJamAofifBlWrIrZVO2GKe0kUuHTAun7GOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJioxOkVhyIas+FASja0BhNaFJ/VCcgjDmXIGjTlUQQi+QeQKIub8GE2d8QsnwEDao72KUYGDSvIp5c0KQERWuPqEyUFBvsxZw+6TqE4RqtUN55xc+LE1UAw68hCcN7yV0j9vXi95sihY4QsEmbZG2AIn8P5XAznq6LL8Fb1veg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=j+oLi669; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="j+oLi669"
ARC-Seal: i=1; a=rsa-sha256; t=1769519156; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XVjW2FHZDoSTF+Xid2w037Wtwfs6saIaGPBOQ9ihMEACTKIXAjzMQ0gkv1m0HZhj0kUwKu5stNtcqsbyprGFE8S0Sc8HiXkoTi+gPiyf6RJtiONAh1Soyj/3xnVIikPq/7TxBuLiv69idTEmMqe8QpVM+wBstCtIKg9Xb3gt2uA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769519156; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fUJU/IjdInm1XgL7HQYWMsaL0Rq2fIHcHUUHbHSHQo0=; 
	b=X9NSwaZk7QVvos4R1kfO1jHUaojejhLcsBPh8gQOKbXfylD66vT7tATBzKV3wm2kLby0tPgxhqVzRWrSoDkyYXB6jVi+CyrwqYb/9j3SxbhYVC5lgHlb3dCUP1DhUKhVPKpRmoJBIB1wl8rYSVyaxFJ8zE0gPZIzQvep7WU3SeY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769519156;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fUJU/IjdInm1XgL7HQYWMsaL0Rq2fIHcHUUHbHSHQo0=;
	b=j+oLi669s7tGP9Yw5V8Paa7iP7z9VQydE62osfdLS6dypbbXnaEPNfdYki8UgMxZ
	LfVoo29CDdyMsBo3SvtkDjqbVQQuyZp3CzDqOqOEn0GjsEYfybImUq9h/5S7q7FHiss
	qRfvRPZjURYphnEiynL3LkyHKY1IVbUSjwgFZn7c=
Received: by mx.zohomail.com with SMTPS id 1769519154664336.73213240699795;
	Tue, 27 Jan 2026 05:05:54 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano
 <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v7 11/12] receive-pack: convert update hooks to new API
In-Reply-To: <CAJoAoZkBRr+CF9VHMaq15eS6o8Vgux1q88an5L6-eDLrP2AgAA@mail.gmail.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-12-adrian.ratiu@collabora.com>
 <CAJoAoZkBRr+CF9VHMaq15eS6o8Vgux1q88an5L6-eDLrP2AgAA@mail.gmail.com>
Date: Tue, 27 Jan 2026 15:05:49 +0200
Message-ID: <87bjifmcia.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Mon, 26 Jan 2026, Emily Shaffer <nasamuffin@google.com> wrote:
> On Wed, Jan 21, 2026 at 1:55=E2=80=AFPM Adrian Ratiu <adrian.ratiu@collab=
ora.com> wrote:
<snip>
>>  static void run_update_post_hook(struct command *commands)
>>  {
>> +       struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT;
>> +       struct async muxer;
>>         struct command *cmd;
>> -       struct child_process proc =3D CHILD_PROCESS_INIT;
>> -       const char *hook;
>> -
>> -       hook =3D find_hook(the_repository, "post-update");
>> -       if (!hook)
>> -               return;
>> +       int saved_stderr =3D -1;
>> +       int muxer_started =3D 0;
>>
>>         for (cmd =3D commands; cmd; cmd =3D cmd->next) {
>>                 if (cmd->error_string || cmd->did_not_exist)
>>                         continue;
>> -               if (!proc.args.nr)
>> -                       strvec_push(&proc.args, hook);
>> -               strvec_push(&proc.args, cmd->ref_name);
>> +               strvec_push(&opt.args, cmd->ref_name);
>>         }
>> -       if (!proc.args.nr)
>> +       if (!opt.args.nr)
>>                 return;
>>
>> -       proc.no_stdin =3D 1;
>> -       proc.stdout_to_stderr =3D 1;
>> -       proc.err =3D use_sideband ? -1 : 0;
>> -       proc.trace2_hook_name =3D "post-update";
>> +       if (use_sideband) {
>> +               memset(&muxer, 0, sizeof(muxer));
>> +               muxer.proc =3D copy_to_sideband;
>> +               muxer.in =3D -1;
>> +               if (!start_async(&muxer)) {
>> +                       muxer_started =3D 1;
>> +                       saved_stderr =3D dup(STDERR_FILENO);
>> +                       if (saved_stderr >=3D 0)
>> +                               dup2(muxer.in, STDERR_FILENO);
>> +                       close(muxer.in);
>> +               }
>> +       }
>>
>> -       if (!start_command(&proc)) {
>> -               if (use_sideband)
>> -                       copy_to_sideband(proc.err, -1, NULL);
>> -               finish_command(&proc);
>> +       run_hooks_opt(the_repository, "post-update", &opt);
>> +
>> +       if (saved_stderr >=3D 0) {
>> +               dup2(saved_stderr, STDERR_FILENO);
>> +               close(saved_stderr);
>>         }
>> +       if (muxer_started)
>> +               finish_async(&muxer);
>
> I guess I'm confused about how the muxer is working here. I guess I
> would expect an async to get created for each child, then to dump the
> entire output of the child when that child terminates, but it seems
> like you're setting up the async to capture the output of all the
> hooks (that is, it seems like start_async() and finish_async()
> encapsulate run_hooks_opt(), which runs multiple children...?)

Thanks for raising this Emily, your confusion is perfectly justified.

Before sending this patch I actually thought that the word "muxer" can
cause confusion and likely it's the wrong word to describe this thread,
because it doesn't actually mux anything. :)

I kept the "mux" terminology only because it was already used by the
other hooks (eg see the next commit) at this abstraction level.

The role of this thread is just to asynchronously capture the output of
run_hooks_opt's children via stderr without blocking the main process
and to send the output ASAP over the sideband channel to achieve as
close to real-time output performance as possible (this was one of
Peff's complaints about our original API).

The per-process output buffering/de-interlacing or "muxing" happens at a
lower level, in run-command, which gets called via run_hooks_opt, and is
not concerned with higher-level "hook" concepts such as whether
post-update needs to output or not over a sideband, it just prints the
final clean output from all children to stderr.

Hope this all makes sense and clarifies why we only need 1 "muxer"
thread per hook type + sideband combination. I did try to capture the
new design in an ASCII art drawing two commits before this one. :)

For more clarity, in v8 I will also rename "muxer" to something like
"sideband_output_redirect_thread". Suggestions welcome.

Please do let me know if you have any questions or uncertainties, happy
to help clarify things (or identify / fix bugs).

P.S.
I've also experimented with factoring out this sideband_output_redirect
("muxer") thread into a common helper which can be reused by all the
hooks requriing sideband output, to avoid the code duplication, however
I gave up on that because this series was already 12 patches long,
though I do think it's a good follow-up.

P.P.S.
When running sequentially (jobs=3D1 and ungroup=3D1), run-command does not
buffer/capture the hook output and the single hook child inherits
stdout/stderr to which it outputs directly. If use_sideband is also 0,
then we achieve the best possible real-time output, like in the current
local client hook sequential execution (another Peff requirement).
