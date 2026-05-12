Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66A383336
	for <git@vger.kernel.org>; Tue, 12 May 2026 16:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604880; cv=none; b=bIUdLSEWw8AE6DhPe6OGo2HzSaYPo17XUFo6DoYO9FOjApdvvfC+jK7tBGIe4tT9nvHOdLQ9WZbiSpgzLidbp7GrTdjM9prgrvIEWCbFa6DNeGQPMWwhna8PBT8kPPWo+wGe7PaU7CVRInCnKtI7puU+/UfGg1QGZ4v3z4PuzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604880; c=relaxed/simple;
	bh=Snq0YKmTYy87BwRdCVDbNKzPc5+y6TQ+BXzMPJzr91w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GYACExpbLSWcrnEd04ls4YIuFgtBDMWJ/DJ0yGwMDFr7Jeg9x7lJNuaKUCDHdCDyQLKQnJuQkKOI/QX/XlaozDhCOesv2FAE+5YWPlu+zeWNDabxiAZGSi/TBKkpQAdT4gwL22qAiy4zPfN4PeueJwdI/WhH8lKO1KF0QakOvSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6yMNZ/f; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6yMNZ/f"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50faeb8317bso42290631cf.2
        for <git@vger.kernel.org>; Tue, 12 May 2026 09:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778604877; x=1779209677; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/Jkm5oCS3h2rnoagPpulMpgaH1nH+nO4bbMrdif2U4=;
        b=E6yMNZ/fFlYNRewZM64GfTF2WmWbsw/O/5pdI9DFjFD4AnoF23a96jILheKyuY9Jfm
         7waaXfKRY9l9lYDsQdrGk6Kg8A1Ta13CBNIOf/6OR5NcJiOiGpJkKGc9/yh8AST/TQL5
         pTPmYcZh9Qddgir6LVisLmeTjmvHJ8WHDG3QBokwm9LDHhlK6xKDfR2WiU9Ey/0yJHUx
         FOhAflmLGJPKxSpEunRjAjXOSrPcWf4W2R1F+/k2Eu0k6I/NX+cI5fLpBl88N4FtQ09T
         6NNKteEZJLJZkyDrO30gGdKT48TVMFi7k4kAfciN/W2aGMHK9fpVqWpnd59oXX4i1eT1
         J2CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778604877; x=1779209677;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/Jkm5oCS3h2rnoagPpulMpgaH1nH+nO4bbMrdif2U4=;
        b=ks3OzLwmLSI9u33A2QdKlaHDxDaT3DUTRlD6xUI4JJPP0eTznQXJnNo2pJ/vPBpMDe
         nP1Xnr50L/hk0a63QJHalMggWv2OlhwFIiyr3gAwED+1fQ3zV8XXiddhVomtE/k9iW5O
         FHGRx3qFc+Lb7grRRu/k5DuKPsvSh6ciUlj8Y01PrK6+gu9FVIosuGZ4Owh5/Af9DkB/
         tRtVBIuUhULmNjwOb8Rz+eDoAbQvphh1Rw6Co+lGXFmgD+PAd0iReAYrd/RHGY5son7m
         svVrHjP9Y806RPGj65hbLPl1j0EKNnI+J3c+08QZF2gVHISNRGrBxOX4GTExC1O7oO1R
         17Dg==
X-Forwarded-Encrypted: i=1; AFNElJ+FbBJ27eBRjY1mBSihrMhI1YHLFlltU9rtMVZV8PBz4JeHDmNIjeKs9/7UxEFtbgSPQ6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3ZVDI9ghCXGiL3HNjwDqDccDabeI5yxb0xQlR5MZzBbmqTSsl
	Z6jFFkbGMINOzhrtjelWy7LFAxW9fZ2jsHtSvVXOJg+qU0ODL4kOtzGa
X-Gm-Gg: Acq92OHiqR1/YxLUP7sPaW6Cgfg4NcxPq9Ech7VTvOq5DHTl9BGbTtS+MJK5LpcZIh2
	KTlu+F6ZH4QOf0EvdKGDyqOKPQSmG6TVNM4PjcC4yqg1qXG9IRNQTpQL8RHHEwv2k4Dz/sCRY2n
	TwkXhuxG8Y7AgyomkpzN9PbLAPrPudx3lYAjfh6G7QXZQmCSLU2bqKuGo3JDImIOD8vcDa3SuME
	crk6oKkIQSGYFNWpt6Pa6Z8XRLzj3+g5a7hNHGqSNQyYX53J8hEE9ELVcXg0pwW7G46rhHKPliw
	tb1WMhM+e0L3IBCU+wgTcYGAzS47gfccEXMiSZZ4K4wzHk5+Bh5IBvSVjJrx6l3/oVye/BaLg0g
	irFRGt10HV09vBykN1EDonipZxkY+dKolWJkVt9Pl730Zc3iBnJHcPlNmYKrCSTx7Pm5eARryYE
	uZ436H/L60VT/3to8t2ibxfo8f7igq0ATznmpDmQtQ17cGPSiEs1OsAztk7YE/2mV1yvVcJ9fJc
	b/laQudkIIK0SSf8wAVCVIWwuXRq5LRxxPNwRiRiS1RtPNcoko=
X-Received: by 2002:a05:622a:2606:b0:509:127d:ee06 with SMTP id d75a77b69052e-5148e9e4c08mr262195501cf.58.1778604876833;
        Tue, 12 May 2026 09:54:36 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c? ([2605:a601:9b88:8300:e033:f3ca:f5b3:2d9c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5148e7c0289sm135562261cf.18.2026.05.12.09.54.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 09:54:36 -0700 (PDT)
Message-ID: <e33ed325-4533-4f83-bcf3-acea2188f208@gmail.com>
Date: Tue, 12 May 2026 12:54:35 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] fetch: add --negotiation-include option for
 negotiation
To: Matthew John Cheetham <mjcheetham@outlook.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
References: <pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
 <pull.2085.v3.git.1776871546.gitgitgadget@gmail.com>
 <ae81ef36a1b3ca04e39e891cce827fa55540b9bb.1776871546.git.gitgitgadget@gmail.com>
 <VI0PR03MB1163403743E62E0FDC4AFE52DC0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <VI0PR03MB1163403743E62E0FDC4AFE52DC0392@VI0PR03MB11634.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/26 10:38 AM, Matthew John Cheetham wrote:
> On 2026-04-22 16:25, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> Add a new --negotiation-include option to 'git fetch', which ensures
>> that certain ref tips are always sent as 'have' lines during fetch
>> negotiation, regardless of what the negotiation algorithm selects.
>>
>> This is useful when the repository has a large number of references, so
>> the normal negotiation algorithm truncates the list. This is especially
>> important in repositories with long parallel commit histories. For
>> example, a repo could have a 'dev' branch for development and a
>> 'release' branch for released versions. If the 'dev' branch isn't
>> selected for negotiation, then it's not a big deal because there are
>> many in-progress development branches with a shared history. However, if
>> 'release' is not selected for negotiation, then the server may think
>> that this is the first time the client has asked for that reference,
>> causing a full download of its parallel commit history (and any extra
>> data that may be unique to that branch). This is based on a real example
>> where certain fetches would grow to 60+ GB when a release branch
>> updated.
>>
>> This option is a complement to --negotiation-restrict, which reduces the
>> negotiation ref set to a specific list. In the earlier example, using
>> --negotiation-restrict to focus the negotiation to 'dev' and 'release'
>> would avoid those problematic downloads, but would still not allow
>> advertising potentially-relevant user brances. In this way, the
>> 'include' version solves the problem I mention while allowing
>> negotiation to pick other references opportunistically. The two options
>> can also be combined to allow the best of both worlds.
> 
> Nice explanation and motivation for the need of such as feature.
> 
> One small typo: s/brances/branches/

Thanks.

>> --- a/Documentation/fetch-options.adoc
>> +++ b/Documentation/fetch-options.adoc
>> @@ -73,6 +73,25 @@ See also the `fetch.negotiationAlgorithm` and `push.negotiate`
>>   configuration variables documented in linkgit:git-config[1], and the
>>   `--negotiate-only` option below.
>> +`--negotiation-include=<revision>`::
>> +    Ensure that the given ref tip is always sent as a "have" line
>> +    during fetch negotiation, regardless of what the negotiation
>> +    algorithm selects.  This is useful to guarantee that common
>> +    history reachable from specific refs is always considered, even
>> +    when `--negotiation-restrict` restricts the set of tips or when
>> +    the negotiation algorithm would otherwise skip them.
>> ++
>> +This option may be specified more than once; if so, each ref is sent
>> +unconditionally.
>> ++
>> +The argument may be an exact ref name (e.g. `refs/heads/release`) or a
>> +glob pattern (e.g. `refs/heads/release/{asterisk}`).  The pattern syntax
>> +is the same as for `--negotiation-restrict`.
>> ++
>> +If `--negotiation-restrict` is used, the have set is first restricted by
>> +that option and then increased to include the tips specified by
>> +`--negotiation-include`.
>> +
> 
> The placeholder `<revision>` and the description in the body of "ref
> name or glob" slightly disagree with each other. The `--negotiation-restrict` 
> docs use `(<commit>|<glob>)` in the syntax definition and
> "a glob on ref names, a ref, or .. SHA-1 of a commit".

Good eye.

> `resolve_negotiation_include()` calls `repo_get_oid()` for non-globs
> so bare OIDs and abbreviated SHAs work too. Perhaps consider aligning the 
> syntaxes, and mention that OIDs work too.

Will do.

>> @@ -1547,10 +1548,14 @@ static void add_negotiation_restrict_tips(struct 
>> git_transport_options *smart_op
>>           int old_nr;
>>           if (!has_glob_specials(s)) {
>>               struct object_id oid;
>> +
>> +            /* Ignore missing reference. */
>>               if (repo_get_oid(the_repository, s, &oid))
>> -                die(_("%s is not a valid object"), s);
>> +                continue;
>> +            /* Fail on missing object pointed by ref. */
>>               if (!odb_has_object(the_repository->objects, &oid, 0))
>>                   die(_("the object %s does not exist"), s);
>> +
>>               oid_array_append(oids, &oid);
>>               continue;
>>           }
> 
> This is the change in behaviour - unresolvable revs were a fatal error
> and are now silently ignored.
> 
> Note that t5510 '--negotiation-tip rejects missing OIDs' still passes
> because it uses an all-zero OID, which parses as a valid hex string,
> and dies on the second check "object does not exist". Using something
> like `--negotiation-tip=notreal` that previously would error will now
> silently be ignored.
> 
> Is it worth another test? (invalid object vs not exists)?

Yes, let's add a test to guarantee this behavior works.

>> @@ -1615,6 +1620,13 @@ static struct transport *prepare_transport(struct 
>> remote *remote, int deepen,
>>               strbuf_release(&config_name);
>>           }
>>       }
>> +    if (negotiation_include.nr) {
>> +        if (transport->smart_options)
>> +            transport->smart_options->negotiation_include = 
>> &negotiation_include;
>> +        else
>> +            warning(_("ignoring %s because the protocol does not support it"),
>> +                "--negotiation-include");
>> +    }
>>       return transport;
>>   }
> 
> There is a difference between the existing `--negotiation-restrict`
> option and the new `--negotiation-include` option. Patch 3's commit
> message says:
> 
>    "The 'tips' part is kept because this is an oid_array in the transport
>    layer. This requires the builtin to handle parsing refs into
>    collections of oids so the transport layer can handle this cleaner
>    form of the data."
> 
> The new option passes the raw `string_list` to the transport layer and
> lets it resolve it instead. If the transport layer now learns how to
> resolve refs to oids, why not for tips/restrict?
> 
> Would it be easier for future readers for these complementary options
> to resolve their inputs at the same layer? Or at least call out why:
> "would prefer raw tips but for back-compat we resolve in the built-in"
> for example.

This is a really key observation. It's a bit of work to unravel, but I
think it's better for unifying these things. Look forward to a better
organization in the next version.

>> +static void resolve_negotiation_include(const struct string_list 
>> *negotiation_include,
>> +                    struct oidset *result)
>> +{
>> +    struct string_list_item *item;
>> +
>> +    if (!negotiation_include || !negotiation_include->nr)
>> +        return;
>> +
>> +    for_each_string_list_item(item, negotiation_include) {
>> +        if (!has_glob_specials(item->string)) {
>> +            struct object_id oid;
>> +
>> +            /* Ignore missing reference. */
>> +            if (repo_get_oid(the_repository, item->string, &oid))
>> +                continue;
>> +
>> +            /* Fail on missing object pointed by ref. */
>> +            if (!odb_has_object(the_repository->objects, &oid, 0))
>> +                die(_("the object %s does not exist"),
>> +                    item->string);
>> +
>> +            oidset_insert(result, &oid);
>> +        } else {
>> +            struct refs_for_each_ref_options opts = {
>> +                .pattern = item->string,
>> +            };
>> +            refs_for_each_ref_ext(
>> +                get_main_ref_store(the_repository),
>> +                add_oid_to_oidset, result, &opts);
>> +        }
>> +    }
>> +}
>> +
> 
> `resolve_negotiation_include()` is basically doing the same as
> `add_negotiation_restrict_tips()` except outputting to an `oidset`
> vs `oid_array`. This is a result of the difference in ref resolution
> layer between `--negotiation-restrict/tip` and `-include`.

Yes, this code will be replaced with a unified approach in the
next version.

>>   static int find_common(struct fetch_negotiator *negotiator,
>>                  struct fetch_pack_args *args,
>>                  int fd[2], struct object_id *result_oid,
>> @@ -347,6 +390,7 @@ static int find_common(struct fetch_negotiator *negotiator,
>>       struct strbuf req_buf = STRBUF_INIT;
>>       size_t state_len = 0;
>>       struct packet_reader reader;
>> +    struct oidset negotiation_include_oids = OIDSET_INIT;
>>       if (args->stateless_rpc && multi_ack == 1)
>>           die(_("the option '%s' requires '%s'"), "--stateless-rpc", 
>> "multi_ack_detailed");
>> @@ -474,6 +518,33 @@ static int find_common(struct fetch_negotiator *negotiator,
>>       trace2_region_enter("fetch-pack", "negotiation_v0_v1", the_repository);
>>       flushes = 0;
>>       retval = -1;
>> +
>> +    /* Send unconditional haves from --negotiation-include */
>> +    resolve_negotiation_include(args->negotiation_include,
>> +                    &negotiation_include_oids);
>> +    if (oidset_size(&negotiation_include_oids)) {
>> +        struct oidset_iter iter;
>> +        oidset_iter_init(&negotiation_include_oids, &iter);
>> +
>> +        while ((oid = oidset_iter_next(&iter))) {
>> +            struct commit *commit;
>> +            packet_buf_write(&req_buf, "have %s\n",
>> +                     oid_to_hex(oid));
>> +            print_verbose(args, "have %s", oid_to_hex(oid));
>> +            count++;
>> +
>> +            /*
>> +             * If this is a commit, then mark as COMMON to
>> +             * avoid the negotiator also outputting it as
>> +             * a have.
>> +             */
>> +            commit = lookup_commit(the_repository, oid);
>> +            if (commit &&
>> +                !repo_parse_commit(the_repository, commit))
>> +                commit->object.flags |= COMMON;
>> +        }
>> +    }
>> +
> 
> I want to make sure I understand the COMMON pre-marking before
> commenting further on this patch. My understanding is there are actually
> two different COMMON bits in the tree, one defined in fetch-pack.c
> (bit 6) and one in negotiator/default.c (bit 2):
> 
> - fetch-pack.c's COMMON (bit 6) is set after a server ACK confirms an
>    OID is common with us and is read to decide when we've established
>    enough common ground to terminate negotiation. This is not consulted
>    in find_common().
> 
> - negotiator/default.c's COMMON (bit 2) is a book-keeping flag used by
>    `get_rev()` to decide if we skip emitting a commit as a 'have'.
> 
> Since we're in fetch-pack.c here, the `commit->object.flags |= COMMON`
> line is setting bit 6. The `get_rev()` call in negotiator/default.c
> never checks bit 6, only bit 2. As far as I can tell, this mark won't
> suppress the negotiator from emitting another 'have' line in the
> protocol v0/v1 paths in `find_common()`.
> 
> The v2 path doesn't touch the flags.. `add_haves` dedups via `oidset_contains()`:
> 
>    while ((oid = negotiator->next(negotiator))) {
>        if (negotiation_include_oids &&
>            oidset_contains(negotiation_include_oids, oid))
>            continue;
>        packet_buf_write(req_buf, "have %s\n", ...);
>    }
> 
> This works, and is what the new 'avoids duplicates with negotiator' test
> runs against, on protocol v2. If we run on protocol v0/v1, and if my
> assessment is correct, then we'd see a duplicate I think?
> 
> Sorry if I've not understood correctly or am missing something, which is
> entirely possible :-)

This is a great catch! It shows that I'm breaking some abstractions here,
and thus it's easy to make such a mistake. It's worse that I don't catch
this problem in the tests that I am adding. I'll add a test that
demonstrates the difference.

But beyond that, I think the biggest issue is that the consumer of an
abstract 'negotiator' is assuming something about its implementation. This
means that I should update the negotiator struct to have a function
pointer dedicated to "I chose to send this 'have'" and then the negotiator
can control how to prevent sending more 'have's reachable from those tips.

Thanks,
-Stolee

