Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219BF171C9
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770899155; cv=pass; b=KNnm2p734Z2wJr9kQahLgpqH+eUxY4htGnu3P+HfQzzXtASa+/L5tqUN3pRZCqxgUo9OD1pFaoM2Loa/nnMdY/eY2JFkTurxurRoLQGw+z9aIE84v4tlWAu9kgUk+yTYrnDbG5pFgTipchmGEAcCMfQRRrrsWIcFWmslI+IMskA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770899155; c=relaxed/simple;
	bh=KaK+qmeBVt09N2kZ8TA9Inrz7fCa4L5pYK5TnovRW/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Om8vbV4f9hhjpjuC7M6a8QJmnSkFFaBXD5RU0dmr4JXGVUrwdu8BiFx1/CgwqXOvVNkp5ChFwBz2hC4dl/yzT2tZX9Q5zVmsl5CNeIftY4Ts00JmT7dbNRr/MeOjxovR3RJ4n8MBVeqJ0UAyI2S8I+uU0cmdMDfZApJRJbFEzug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=br7V0afu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="br7V0afu"
ARC-Seal: i=1; a=rsa-sha256; t=1770899136; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OChRA3uEM12u90Ad+mXh5xdC3B8CLkIuwmtzxL30cCDYin8NEyeDbXX+WYjd/DsCnEyDhVV78y2WucSKHNxI98b86gpqewzkpbWoCjXb/wyi1nlgonSfr1liE5NCnVbTZrnGDVq7EssQYqUqF6DIEIj/dWCJxjTf8HtjfLKUyWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770899136; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UlVcQtdwkBLhSBbZm7u4cAstOWRlpsf0Nl0e02HV5Fw=; 
	b=jhlQaZHF6m3DP04k3xkg5+YHhJ+j6kL9k0eL2XDLGU2aX9T6jOj1mU+wJ8oIq9s1xC1VKaO/TBsSUv09PJQTB0dWAXeH/pccGKmbD23Dtind1HAjPghkfSB1PAlMAE987R7s5y3Mi0AMwKXZR/mP1Ar9Z4Pmj5DLU3RD2x6GwiI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770899136;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=UlVcQtdwkBLhSBbZm7u4cAstOWRlpsf0Nl0e02HV5Fw=;
	b=br7V0afuHU4lVG16X6Z/ngDgNaShxbrK0w3WJdU762gK2srJyM4WBDyxOp6Vjglg
	3jvNt5xtbGaUTQcjVPMzdpvWrB07w1u9ci0B7Xf4jhIm1qnMd91/8XNODesw1ycHgB6
	JrBzC/drmwTfk3b1jARTWoqh7qfCpeIC9OzG9WP4=
Received: by mx.zohomail.com with SMTPS id 1770899134646120.47706361675;
	Thu, 12 Feb 2026 04:25:34 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Emily Shaffer
 <emilyshaffer@google.com>, Junio C Hamano <gitster@pobox.com>, Josh
 Steadmon <steadmon@google.com>, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 2/4] hook: allow parallel hook execution
In-Reply-To: <aYx5B-nf4dlFpw3v@pks.im>
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
 <20260204173328.1601807-3-adrian.ratiu@collabora.com>
 <aYx5B-nf4dlFpw3v@pks.im>
Date: Thu, 12 Feb 2026 14:25:29 +0200
Message-ID: <87ms1ep2rq.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 11 Feb 2026, Patrick Steinhardt <ps@pks.im> wrote:
> On Wed, Feb 04, 2026 at 07:33:26PM +0200, Adrian Ratiu wrote:
>> From: Emily Shaffer <emilyshaffer@google.com>
>> 
>> In many cases, there's no reason not to allow hooks to execute in
>> parallel, if more than one was provided.
>> 
>> hook.c already calls run_processes_parallel() so all we need to do is
>> allow its job count to be greater than 1.
>> 
>> Serial execution is achieved by setting .jobs == 1 at compile time via
>> RUN_HOOKS_OPT_INIT_SERIAL or by setting the 'hook.jobs' config to 1.
>> This matches the behavior prior to this commit.
>> 
>> The compile-time 'struct run_hooks_opt.jobs' parameter has the highest
>> priority if non-zero, followed by the 'hook.jobs' user config, then the
>> processor count from online_cpus() is the last fallback.
>
> Wait, the compile-time parameter overrides the user configuration? That
> doesn't seem right to me.

Yes, the rationale for doing this is that some hooks are never safe to
parallelize, so if RUN_HOOKS_OPT_INIT_SERIAL is set at compile-time,
then it has the highest prefference, for safety for these hooks and the
user cannot override them.

Hooks initialized with RUN_HOOKS_OPT_INIT_PARALLEL are known to be safe
to parallelize, so the user can also overwrite the jobs number.

Maybe we need better names (or code?) to express this?

I am certainly open to suggestions.

>
> I'm also a bit sceptical whether we should really default to
> `online_cpus()`. If so, we start to assume semantics of the hooks
> themselves, and that they cannot conflict with one another. But this is
> nothing we can really guarantee. It might be that multiple hooks want to
> modify the same data structure, and if so running them in parallel would
> lead to races.
>
> So I wonder whether we should rather make this behaviour opt-in than
> opt-out.

We certainly can. There is nothing set in stone here and we can even
keep the previous default to jobs == 1 for all hooks.

>> The above ordering ensures hooks unsafe to run in parallel are always
>> executed sequentially (RUN_HOOKS_OPT_INIT_SERIAL) while allowing users
>> to control parallelism with an efficient default.
>
> Ah, okay, we only let the compile-time parameter override the config in
> case we know that hooks must run in serial. That makes a bit more sense.

Yes, that is the idea: some hooks must never run in parallel.

Of course, if we can find better ways to express this, I'm all ears. :)

>> diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
>> index 49c7ffd82e..c394756328 100644
>> --- a/Documentation/config/hook.adoc
>> +++ b/Documentation/config/hook.adoc
>> @@ -15,3 +15,8 @@ hook.<name>.event::
>>  	On the specified event, the associated `hook.<name>.command` will be
>>  	executed. More than one event can be specified if you wish for
>>  	`hook.<name>` to execute on multiple events. See linkgit:git-hook[1].
>> +
>> +hook.jobs::
>> +	Specifies how many hooks can be run simultaneously during parallelized
>> +	hook execution. If unspecified, defaults to the number of processors on
>> +	the current system.
>
> We should probably note that some hooks will run sequentially regardless
> of this setting. Maybe we should even document which ones? I expect it's
> not going to be that many.

Ack, will do in v2.

>> diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
>> index 5f339dc48b..72c6c6d1ee 100644
>> --- a/Documentation/git-hook.adoc
>> +++ b/Documentation/git-hook.adoc
>> @@ -128,6 +129,16 @@ OPTIONS
>>  	tools that want to do a blind one-shot run of a hook that may
>>  	or may not be present.
>>  
>> +-j::
>> +--jobs::
>> +	Only valid for `run`.
>> ++
>> +Specify how many hooks to run simultaneously. If this flag is not specified,
>> +the value of the `hook.jobs` config is used, see linkgit:git-config[1]. If the
>> +config is not specified, the number of CPUs on the current system is used. Some
>> +hooks may be ineligible for parallelization: for example, 'commit-msg' hooks
>> +typically modify the commit message body and cannot be parallelized.
>
> Yeah, this info is probably what I was searching for in the "hook.jobs"
> description.

Yes, I'll try to make this clearer.

>> diff --git a/builtin/hook.c b/builtin/hook.c
>> index 4cc6dac45a..cd1f4ebe6a 100644
>> --- a/builtin/hook.c
>> +++ b/builtin/hook.c
>> @@ -76,7 +77,7 @@ static int run(int argc, const char **argv, const char *prefix,
>>  	       struct repository *repo UNUSED)
>>  {
>>  	int i;
>> -	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
>> +	struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT_PARALLEL;
>>  	int ignore_missing = 0;
>>  	const char *hook_name;
>>  	struct option run_options[] = {
>
> Hm. Assuming that the user executes `git hooks run prepare-commit-msg`
> with "--jobs=2", should we really honor that request? We know that the
> hook cannot run in parallel, so we might want to refuse such requests.
>
> Taking a step back, I wonder whether it really is sensible to declare
> complete classes of hooks as parallelizable or non-parallelizable. We
> have to assume semantics of the hook scripts themselves to be able to
> answer whether or not they can be parallelizable. For some classes of
> hooks like "prepare-commit-msg" we can assume that it's almost never
> correct to serialize them. But for others we cannot assume anything.
>
> Which makes me wonder whether the design here is really the right one.
> Shouldn't we stop worrying about classes of hooks, but rather worry
> about the user's intent? The user will know whether two hooks can run in
> parallel or not, so let them tell us that this is the case.
>
> I think this could be achieved via the configuration:
>
>     [hook "my-parallelizable-hook-a"]
>     path = /some/script-a.sh
>     parallel = true
>
>     [hook "my-parallelizable-hook"]
>     path = /some/script-b.sh
>     parallel = true
>
>     [hook "serial-hook"]
>     path = /some/script-c.sh
>     parallel = false
>
> This would tell us that we can safely run two of the hooks in parallel,
> but not the third one. So we'd then first execute all serial hooks in
> serial, and then in a second phase we'd execute the other hooks in
> parallel.
>
> Sure, this puts more responsibility on the user. But I think this is a
> more flexible approach as it also empowers the user and caters to more
> use cases.
>
> Please let me know what you think.

Those are really good points, thanks.

We can certainly keep jobs == 1 as a weak default for all hooks, which
can be overriden by users, then leave it up to the user to decide what
is safe or unsafe.

However, there are trade-offs...

1. As you said this puts more responsability on the user to know what to
enable (i.e. don't push the wrong button).

2. It forces manual user intervention if parallelism is desired.

3. We can't have a safe global default like a runtime config because we
clearly can't eneable all parallelism and would end up keeping a list of
safe-vs-unsafe hooks anyway if we decide to add a config like
"parallelize-everything-which-can-be-parallelized". :)

The current design was thought to provide a safe default with minimal
user intervention.

Maybe we can find some middle ground between the two "extremes"
(deciding everything for the user vs pushing all decisions to the user)?

Maybe keep the compile-time safe/unsafe hook list, default all hooks to
.jobs == 1 (preserve existing behavior) and allow the users to enable
parallelism individually or, via a runtime config, all known to be safe?
