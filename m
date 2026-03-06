Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EB31DFE22
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772773264; cv=none; b=N0lfTIVmjtbz0hy6rLWFz7ZQx+WZds1XHldAnrnTwBTcn95/MDBMfGc4VzkSAUM2rw5H8IklMQIPs2X84CbOqR6egHXGJcIaXMgMIkusPg7SmV9ESPt9OiIiu78gKe39q0/6/yfdOagBFMCTzZxqaPzw7Wc2qfXy4aq39nJNiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772773264; c=relaxed/simple;
	bh=Zuug1pr+j9Ta2QiC3PS/9G/p3RSwJkoS1zNsE3gREdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNjnF6enMjXviPiyhOteKyoP5CU5HorKANEFluv1zCJTIM+Y8kElNV7Bn+Q4a94WJB7tgfnXWTj2Ux/laP9DqF44BCBziFUIDIuYNG408tFCIybC9fYI6Fo0KHCb9cok/dN+kVAHzsH7LxbpCU25TGUfLwWoqxA8XMw5iL5TrW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrdSi3/v; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrdSi3/v"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3598c1ad542so3212488a91.0
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 21:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772773262; x=1773378062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R9+nRn1r4oUlQbeLuSLrnYFrK0gjLCObILJ2pfRtQF0=;
        b=YrdSi3/v91Zmj4ReOPoGrE7aCFFEziJB2bnXzCOLx12llV2ujpasiY4Z5+0G9F7hKb
         qKzdLtEOTK2MJ0Lu72JSdgyp8stVib6Pn7j0hNlta+XAxnsTyJEy2uWSvFAnf+FechJx
         F+Ay17onZxMpsYDUe7utsSsYyZN0TeheTbYKImaVCxdI6WezylgctGzQ6FQRDtio0F7e
         qj6KfTngxN1IerfB7wSK72YP4ZZ84iA0jV6BT2h8xbBd3SHcODPx/d3CIYuDqC7XiKc+
         6mvCYtdQjhNDwSV92oQAxpFBa4/4ce41iOnNIxik0706LB6ZFq3jkbdfFYVFUBUlbJFu
         kZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772773262; x=1773378062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R9+nRn1r4oUlQbeLuSLrnYFrK0gjLCObILJ2pfRtQF0=;
        b=QPLepCjM/YivAgYjbp79N81DCvC0RTMAPzTNYLAEwNBic5umefQesGC3gCZML+NJc8
         pBMvTJjTqk97qkJeJV6YWmR1ry0pbZRjCgsOAtcLPGGFJ4z7peG+KBld7S9RH2qs0LU4
         W/0qn6N9ryz4RameMtbMOKczV75Ldedjy9rgzwNepzKuDvBSUC5yP6hms72o7fqmAGG5
         P778YhL+tuzur1RchLWBcWazh39Dwg7+mEooPKtcq0HtEcSnlHF5xwu7bkKI6N9NYnsH
         NoF2UrjFWpGTwGa25cSDwTur5Xm81jBh7tqGYWIXbEzLtjtqavSgQtwqFcNP+/u1XAno
         C2RQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6Lqqma8BGuNlBboTuwB5aAQq/S9ub4OGq0LH6/oZrXG2cr6OJiv144ixin2VcPkv7ETU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyb3HJariPeO17QP3BZaM81aoNBMU8Dlk2gdNAdqNndY3WMwHT
	EsZgSpNtKnYdHc8Og5SjSj2jZpD2mVXYWj1pybQHPWn7WZ455selObyB
X-Gm-Gg: ATEYQzyErgMBBXKrbW7H+1YR32czyAbFhofE6XR5rMQqglQP9V0QbDPAVya+yjxy45M
	Ng+QyK8Wz6E5HM5215/AQwD4+3IiQ0bzW/cP7nTE6iwRUSVXVN3Rnnulvj9H7vbGq/28mCWG1XI
	JbivquQWdvy+6Jca0Q1JiUmBSP/KhMeRtn+3Jf5BeBBgxZo8GxU+vuYON1F/FYRXQlDDnfEFydc
	R8NuuHDuYPq/ijANklteQFOV8YMA0aiXqzDvtloLMxEQE2decA2C3ylUgJD3miMdNG5tEHn0Abw
	aYg6knTD2nLf9CrrrCicjXRr5PEch79EiJlPh2iTLXfXvMJHW0Di2SdmFMJBQLt2lT1M008jTFf
	k5lMY3ScURkOC6rOVzPXOq+dn5I3qyh61DD0ztmCckUpoOfpefdjjOB+5IkFu0Di8B9wdTOiJWG
	H+h4nZFtU2iE+/080yD3KhpKQHkIizMdgD56K4bMvNJfAvwcek2SNgL/jHgpd/qym3IP74e7Dws
	ChLnyV35nH/uXTHMe8cjzgSgkthrtpDruvT
X-Received: by 2002:a17:90b:57cf:b0:358:ee5f:9c04 with SMTP id 98e67ed59e1d1-359be38e449mr872237a91.30.1772773262352;
        Thu, 05 Mar 2026 21:01:02 -0800 (PST)
Received: from ?IPV6:2401:4900:862d:bb67:1c20:bec7:1904:ead0? ([2401:4900:862d:bb67:1c20:bec7:1904:ead0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2e0e1aasm4830044a91.15.2026.03.05.21.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 21:00:59 -0800 (PST)
Message-ID: <bb2a9b1f-5cdd-4c4e-91dc-a631beb009bb@gmail.com>
Date: Fri, 6 Mar 2026 10:30:54 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] sequencer: extract revert message formatting into
 shared function
Content-Language: en-GB
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, karthik.188@gmail.com, johannes.schindelin@gmx.de,
 toon@iotcl.com
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-2-siddharthasthana31@gmail.com>
 <c2048ddf-ced4-425d-af6e-14e9442e9d99@gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <c2048ddf-ced4-425d-af6e-14e9442e9d99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 26/02/26 19:57, Phillip Wood wrote:
> Hi Siddharth
> 
> On 18/02/2026 23:42, Siddharth Asthana wrote:
>> The logic for formatting revert commit messages (handling "Revert" and
>> "Reapply" cases) is currently duplicated between sequencer.c and will be
>> needed by builtin/replay.c.
>>
>> Extract this logic into a new sequencer_format_revert_header() function
>> that can be shared. The function handles both regular reverts ("Revert
>> "<subject>"") and revert-of-revert cases ("Reapply "<subject>"").
>> When an oid is provided, the function appends the full commit hash and
>> period; otherwise the caller should append the commit reference.
>>
>> Update do_pick_commit() to use the new helper, eliminating code
>> duplication while preserving the special handling for 
>> commit_use_reference.
> 
> I agree with the other comments that this ends up being a bit awkward, I 
> think
> something like the diff below which moves all of the revert message 
> formatting
> into a helper function would be a better approach. Note that I've also 
> added a
> repository argument to refer_to_commit(). You might want to do that in a
> separate commit, but I think it is worth doing if we're adding more 
> callers.
> I've also just used a bool for the use_commit_reference flag, if we want 
> to add
> more flags in the future we can convert it to an unsigned int when we do 
> that.

Thanks, this is much cleaner. Moving refer_to_commit() and the 
merge-parent handling into the same function gets rid of the awkward 
NULL oid path that Toon and Junio pointed out.

I will split the refer_to_commit() signature change (adding struct 
repository *r) into a preparatory commit as you suggested, then have the 
second commit introduce the full sequencer_format_revert_message() helper.

For replay, I will call it with use_commit_reference=false -- that gives 
the full OID through refer_to_commit() directly, no special causing needed.


> 
> Thanks
> 
> Phillip
> 
> 
> ---- 8< ----
> diff --git a/sequencer.c b/sequencer.c
> index a3eb39bb252..30f6da6f959 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2198,21 +2198,55 @@ static int should_edit(struct replay_opts *opts) {
>       return opts->edit;
>   }
> 
> -static void refer_to_commit(struct replay_opts *opts,
> -                struct strbuf *msgbuf, struct commit *commit)
> +static void refer_to_commit(struct repository*r, struct strbuf *msgbuf,
> +        const struct commit *commit, bool use_commit_reference)
>   {
> -    if (opts->commit_use_reference) {
> +    if (use_commit_reference) {
>           struct pretty_print_context ctx = {
>               .abbrev = DEFAULT_ABBREV,
>               .date_mode.type = DATE_SHORT,
>           };
> -        repo_format_commit_message(the_repository, commit,
> +        repo_format_commit_message(r, commit,
>                          "%h (%s, %ad)", msgbuf, &ctx);
>       } else {
>           strbuf_addstr(msgbuf, oid_to_hex(&commit->object.oid));
>       }
>   }
> 
> +void sequencer_format_revert_message(struct repository *r, const char 
> *subject,
> +            const struct commit *commit, const struct commit *parent,
> +            bool use_commit_reference, struct strbuf *message)
> +{
> +    const char *orig_subject;
> +
> +    if (use_commit_reference) {
> +            strbuf_commented_addf(message, comment_line_str,
> +                "*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> +        } else if (skip_prefix(subject, "Revert \"", &orig_subject) &&
> +               /*
> +                * We don't touch pre-existing repeated reverts, because
> +                * theoretically these can be nested arbitrarily deeply,
> +                * thus requiring excessive complexity to deal with.
> +                */
> +               !starts_with(orig_subject, "Revert \"")) {
> +            strbuf_addstr(message, "Reapply \"");
> +            strbuf_addstr(message, orig_subject);
> +            strbuf_addstr(message, "\n");
> +        } else {
> +            strbuf_addstr(message, "Revert \"");
> +            strbuf_addstr(message, subject);
> +            strbuf_addstr(message, "\"\n");
> +        }
> +        strbuf_addstr(message, "\nThis reverts commit ");
> +        refer_to_commit(r, message, commit, use_commit_reference);
> +
> +        if (commit->parents && commit->parents->next) {
> +            strbuf_addstr(message, ", reversing\nchanges made to ");
> +            refer_to_commit(r, message, parent, use_commit_reference);
> +        }
> +        strbuf_addstr(message, ".\n");
> +}
> +
>   static const char *sequencer_reflog_action(struct replay_opts *opts)
>   {
>       if (!opts->reflog_action) {
> @@ -2356,38 +2390,13 @@ static int do_pick_commit(struct repository *r,
>        */
> 
>       if (command == TODO_REVERT) {
> -        const char *orig_subject;
> -
>           base = commit;
>           base_label = msg.label;
>           next = parent;
>           next_label = msg.parent_label;
> -        if (opts->commit_use_reference) {
> -            strbuf_commented_addf(&ctx->message, comment_line_str,
> -                "*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> -        } else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
> -               /*
> -                * We don't touch pre-existing repeated reverts, because
> -                * theoretically these can be nested arbitrarily deeply,
> -                * thus requiring excessive complexity to deal with.
> -                */
> -               !starts_with(orig_subject, "Revert \"")) {
> -            strbuf_addstr(&ctx->message, "Reapply \"");
> -            strbuf_addstr(&ctx->message, orig_subject);
> -            strbuf_addstr(&ctx->message, "\n");
> -        } else {
> -            strbuf_addstr(&ctx->message, "Revert \"");
> -            strbuf_addstr(&ctx->message, msg.subject);
> -            strbuf_addstr(&ctx->message, "\"\n");
> -        }
> -        strbuf_addstr(&ctx->message, "\nThis reverts commit ");
> -        refer_to_commit(opts, &ctx->message, commit);
> -
> -        if (commit->parents && commit->parents->next) {
> -            strbuf_addstr(&ctx->message, ", reversing\nchanges made to ");
> -            refer_to_commit(opts, &ctx->message, parent);
> -        }
> -        strbuf_addstr(&ctx->message, ".\n");
> +        sequencer_format_revert_message(r,msg.subject, commit, parent,
> +                        opts->commit_use_reference,
> +                        &ctx->message);
>       } else {
>           const char *p;
> 
> diff --git a/sequencer.h b/sequencer.h
> index 719684c8a9f..a61ec6d81d4 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -271,4 +271,8 @@ int sequencer_determine_whence(struct repository *r, 
> enum commit_whence *whence)
>    */
>   int sequencer_get_update_refs_state(const char *wt_dir, struct 
> string_list *refs);
> 
> +void sequencer_format_revert_message(struct repository *r, const char 
> *subject,
> +                     const struct commit *commit, const struct commit 
> *parent,
> +                     bool use_commit_reference, struct strbuf *message);
> +
>   #endif /* SEQUENCER_H */
> 

