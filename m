Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 020B91F424
	for <e@80x24.org>; Mon, 23 Apr 2018 21:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932635AbeDWVir (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 17:38:47 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46093 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932517AbeDWVin (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 17:38:43 -0400
Received: by mail-wr0-f195.google.com with SMTP id d1-v6so45117154wrj.13
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 14:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OLn3iCXWvAispZtpiACL+axY1LpXPYAAKgBkBNzfD+4=;
        b=UrHJr612pXVHou/E1+Tyt6IS3ZrXA+lftg06gIA/emNvL9C9xK01JaiAz70QujS9Ih
         aFFXt6BfsHNt3WAK6dhq0a67HxjrTIhLsLLLkvC3nB0fFMblRAvojogRXOxewjeuMm1M
         N7AzUZt5inBJrqRytAgO0B7WFg6UKZunjzIe+491o0fHPCH2piAKVQ6VV1CtWDO9N2wM
         ThxFBRLV9oXAToWQLHGR9rFLbEudFi/OQvgkqIFE6b99MqzbgE+/dPqRdU5f2dhEqRF1
         hQbGssvQKeVv4o/9nf9uW5hnShh5GMO2E8vsZ0/+aNZWCDaq6cmY9VGU8WoUmyIU4oK3
         bcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=OLn3iCXWvAispZtpiACL+axY1LpXPYAAKgBkBNzfD+4=;
        b=G4QFYd6JsOnT+oTS2QRIAf/OPE7DxHPlbMHpaHZfspYVyTFZVFCLkCNmEPD0UogQkP
         jmdLPYLJS4UeCouJ2hYSWoOzP+na47RIAkvqaPA+eFVIiCFi3O7aEEfGAio8/CfDQy5r
         lwngwV5Y6z1tSK66ikm+TYg7woG6tFKjfdqq9Mwb4DhzMFOGNv1wpydHnNWsWdLxDDxt
         +9jaxN0y+xRYNx1bmT00YG0YPt78RPaUU2rqOsSZhO3/YDGHUowx8RnnqAGarwfH7q9P
         A7VOkYSo2zSlMmpFJPZYlREn3ZF+2lGdIRabs9as0mlgxvJR9q+j7NdIgBo/ujPEzhtD
         xhgQ==
X-Gm-Message-State: ALQs6tAQ8ZkF/RihRS9vMSZAE4vKZ+PnX0+LGVBqPZ0S2uG4HYu77d7W
        IhR+8vEUnne8hHTIKj6+TkYlGNqU
X-Google-Smtp-Source: AIpwx4+EwdsmqnfEjnAzNazCcHEkWTxd/IdrbxzYp9VjLMhhHQlrmotYlvLq0Z8Kt8/LeYM0yWpJaA==
X-Received: by 10.28.28.85 with SMTP id c82mr11034702wmc.69.1524519521725;
        Mon, 23 Apr 2018 14:38:41 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (eey82.neoplus.adsl.tpnet.pl. [83.21.36.82])
        by smtp.gmail.com with ESMTPSA id 55-v6sm28279075wrw.52.2018.04.23.14.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 14:38:40 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        "peff\@peff.net" <peff@peff.net>,
        "avarab\@gmail.com" <avarab@gmail.com>,
        "sbeller\@google.com" <sbeller@google.com>,
        "larsxschneider\@gmail.com" <larsxschneider@gmail.com>,
        "bmwill\@google.com" <bmwill@google.com>,
        "gitster\@pobox.com" <gitster@pobox.com>,
        "sunshine\@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy\@google.com" <jonathantanmy@google.com>
Subject: Re: [PATCH v3 7/9] commit: add short-circuit to paint_down_to_common()
References: <20180409164131.37312-1-dstolee@microsoft.com>
        <20180417170001.138464-1-dstolee@microsoft.com>
        <20180417170001.138464-8-dstolee@microsoft.com>
        <86bmeggl1m.fsf@gmail.com>
        <bd2011f0-41d4-4550-5392-65a3816ed4d3@gmail.com>
Date:   Mon, 23 Apr 2018 23:38:40 +0200
In-Reply-To: <bd2011f0-41d4-4550-5392-65a3816ed4d3@gmail.com> (Derrick
        Stolee's message of "Mon, 23 Apr 2018 10:40:54 -0400")
Message-ID: <86efj5fvrz.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 4/18/2018 7:19 PM, Jakub Narebski wrote:
>> Derrick Stolee <dstolee@microsoft.com> writes:
>>
> [...]
>>> [...], and this saves time during 'git branch --contains' queries
>>> that would otherwise walk "around" the commit we are inspecting.
>>>
>> If I understand the code properly, what happens is that we can now
>> short-circuit if all commits that are left are lower than the target
>> commit.
>>
>> This is because max-order priority queue is used: if the commit with
>> maximum generation number is below generation number of target commit,
>> then target commit is not reachable from any commit in the priority
>> queue (all of which has generation number less or equal than the commit
>> at head of queue, i.e. all are same level or deeper); compare what I
>> have written in [1]
>>
>> [1]: https://public-inbox.org/git/866052dkju.fsf@gmail.com/
>>
>> Do I have that right?  If so, it looks all right to me.
>
> Yes, the priority queue needs to compare via generation number first
> or there will be errors. This is why we could not use commit time
> before.

I was more concerned about getting right the order in the priority queue
(does it return minimal or maximal generation number).

I understand that the cutoff could not be used without generation
numbers because of the possibility of clock skew - using cutoff on dates
could lead to wrong results.

>>> For a copy of the Linux repository, where HEAD is checked out at
>>> v4.13~100, we get the following performance improvement for
>>> 'git branch --contains' over the previous commit:
>>>
>>> Before: 0.21s
>>> After:  0.13s
>>> Rel %: -38%
>> [...]
>>>   		flags =3D commit->object.flags & (PARENT1 | PARENT2 | STALE);
>>>   		if (flags =3D=3D (PARENT1 | PARENT2)) {
>>>   			if (!(commit->object.flags & RESULT)) {
>>> @@ -876,7 +886,7 @@ static struct commit_list *merge_bases_many(struct =
commit *one, int n, struct co
>>>   			return NULL;
>>>   	}
>>>   -	list =3D paint_down_to_common(one, n, twos);
>>> +	list =3D paint_down_to_common(one, n, twos, 0);
>>>     	while (list) {
>>>   		struct commit *commit =3D pop_commit(&list);
>>> @@ -943,7 +953,7 @@ static int remove_redundant(struct commit **array, =
int cnt)
>>>   			filled_index[filled] =3D j;
>>>   			work[filled++] =3D array[j];
>>>   		}
>>> -		common =3D paint_down_to_common(array[i], filled, work);
>>> +		common =3D paint_down_to_common(array[i], filled, work, 0);
>>>   		if (array[i]->object.flags & PARENT2)
>>>   			redundant[i] =3D 1;
>>>   		for (j =3D 0; j < filled; j++)
>>> @@ -1067,7 +1077,7 @@ int in_merge_bases_many(struct commit *commit, in=
t nr_reference, struct commit *
>>>   	if (commit->generation > min_generation)
>>>   		return 0;
>>>   -	bases =3D paint_down_to_common(commit, nr_reference, reference);
>>> +	bases =3D paint_down_to_common(commit, nr_reference, reference, commi=
t->generation);
>>
>> Is it the only case where we would call paint_down_to_common() with
>> non-zero last parameter?  Would we always use commit->generation where
>> commit is the first parameter of paint_down_to_common()?
>>
>> If both are true and will remain true, then in my humble opinion it is
>> not necessary to change the signature of this function.
>
> We need to change the signature some way, but maybe the way I chose is
> not the best.

No, after taking longer I think the new signature is a good choice.

> To elaborate: paint_down_to_common() is used for multiple
> purposes. The caller here that supplies 'commit->generation' is used
> only to compute reachability (by testing if the flag PARENT2 exists on
> the commit, then clears all flags). The other callers expect the full
> walk down to the common commits, and keeps those PARENT1, PARENT2, and
> STALE flags for future use (such as reporting merge bases). Usually
> the call to paint_down_to_common() is followed by a revision walk that
> only halts when reaching root commits or commits with both PARENT1 and
> PARENT2 flags on, so always short-circuiting on generations would
> break the functionality; this is confirmed by the
> t5318-commit-graph.sh.

Right.

I have realized that just after sending the email.  I'm sorry about this.

>
> An alternative to the signature change is to add a boolean parameter
> "use_cutoff" or something, that specifies "don't walk beyond the
> commit". This may give a more of a clear description of what it will
> do with the generation value, but since we are already performing
> generation comparisons before calling paint_down_to_common() I find
> this simple enough.

Two things:

1. The signature proposed in the patch is more generic.  The cutoff does
   not need to be equal to the generation number of the commit, though
   currently it always (all of one time the new mechanism is used) is.

   So now I think the new signature of paint_down_to_common() is all
   right as it is proposed here.

2. The way generation numbers are defined (with 0 being a special case,
   and generation numbers starting from 1 for parent-less commits), and
   the way they are compared (using strict comparison, to avoid having
   to special-case _ZERO, _MAX and _INFINITY generation numbers) the
   cutoff of 0 means no cutoff.

   On the other hand cutoff of 0 can be understood as meaning no cutoff
   as a special case.

   It could be made more clear to use (as I proposed elsewhere in this
   thread) symbolic name for this no-cutoff case via preprocessor
   constants or enums, e.g. GENERATION_NO_CUTOFF:

    @@ -876,7 +886,7 @@ static struct commit_list *merge_bases_many(struct =
commit *one, int n, struct co
      			return NULL;
      	}
      -	list =3D paint_down_to_common(one, n, twos);
    +	list =3D paint_down_to_common(one, n, twos, GENERATION_NO_CUTOFF);
        	while (list) {
      		struct commit *commit =3D pop_commit(&list);
    @@ -943,7 +953,7 @@ static int remove_redundant(struct commit **array, =
int cnt)
      			filled_index[filled] =3D j;
      			work[filled++] =3D array[j];
      		}
    -		common =3D paint_down_to_common(array[i], filled, work);
    +		common =3D paint_down_to_common(array[i], filled, work, GENERATION_N=
O_CUTOFF);
      		if (array[i]->object.flags & PARENT2)
      			redundant[i] =3D 1;
      		for (j =3D 0; j < filled; j++)


   But whether it makes code more readable, or less readable, is a
   matter of opinion and taste.

Best,
--=20
Jakub Nar=C4=99bski
