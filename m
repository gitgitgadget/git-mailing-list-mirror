Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01602208E9
	for <e@80x24.org>; Wed, 18 Jul 2018 13:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbeGROJH (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 10:09:07 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35039 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730234AbeGROJG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 10:09:06 -0400
Received: by mail-qt0-f193.google.com with SMTP id a5-v6so3985178qtp.2
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 06:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=TB1Ej2sWciY3sVzAFoEDTRKPcY4TMiXrBH0YR84y5jQ=;
        b=p4PGMBu4tKzBYTU18G8Z45OxhsDKQwWtnyxTTlONZURtXuRTFAwNE7UOLtKRlw9B5D
         9DJ1MmXwD59oAzsKPkdqwFDMwI/E0DRQQNTZ0uI/1AkoskKIC9bm7xBH6XkGOSlOFs7h
         LBPKk1IwHeTrcNkMOk01Ax0dJko795KBtAVcNJYO6e8JP6TY60XAwuV8jw5Lwo88dHqp
         o/H4m7VjnGE+7eUxTuKAdqEzuKrRm8+mKfgUxfY5YNhpzm18ooX1n7p5QnyVzVvuF1cs
         eusi8ual93bQmYE0FKWhYyYI8DWITgnKwmhatbR9wxXhJLbxcxIpgt4I/4otBuITzaMm
         QK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=TB1Ej2sWciY3sVzAFoEDTRKPcY4TMiXrBH0YR84y5jQ=;
        b=IqOe26PkeWNtLtGDKg/O3nkQWtCLNw6WBvmiC2qTcf3TQZXifcPKsmuUG/KCCh3ntv
         Q9g5z0JlR78NmtJJjZj91iHN+eGTAJ5DNwk51mSolq51+tLIyIDBGqX0pA14yCMY4G38
         eeHJ/Bj6PX1QR99MJZOgmGYCmxpfpAOUqG6ILBGlHrtmAPSl2iN2rV3GfpxPWUyvQlHL
         iQBfwTk7ST3uKDCu30xI2/o3kw8zaSsnAZFb+a1aEuZwjvviy0hGzDjEz5XhXGjWn+Uo
         QNPm6e4j+lKCDYOFUsOu7JHBp8fZPfn9JAaBA+arOIRUl9ODhXv0xb4gPzlBgXFDkCKC
         ZEzw==
X-Gm-Message-State: AOUpUlFaEwwIhFt3DdNxjF1ah0mIR5yyNL7sI6t+nhiRB/pnItDOB+lo
        ToDIpkIrYVj10aLpmVM3fM8LP1Fm
X-Google-Smtp-Source: AAOMgpcGP7OxGjldPBM5T/x6ext8izvG02rNI8ZMA6Y7Hq+TvUbTVHoUm1WShNH3OAeLTK1QZ3AoxA==
X-Received: by 2002:ac8:2ad8:: with SMTP id c24-v6mr5783721qta.117.1531920668919;
        Wed, 18 Jul 2018 06:31:08 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d070:73be:3735:cf07? ([2001:4898:8010:0:b9a6:73be:3735:cf07])
        by smtp.gmail.com with ESMTPSA id d4-v6sm3221375qtd.72.2018.07.18.06.31.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 06:31:08 -0700 (PDT)
Subject: Re: [RFC] push: add documentation on push v2
To:     Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>
References: <20180717210915.139521-1-bmwill@google.com>
 <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a7c43308-a388-e307-6bea-47e6df74b65c@gmail.com>
Date:   Wed, 18 Jul 2018 09:31:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZEpNLkXuEQEiMB_nc-MOOp-KOziHyONmr4SiajA5+F2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/17/2018 7:25 PM, Stefan Beller wrote:
> On Tue, Jul 17, 2018 at 2:09 PM Brandon Williams <bmwill@google.com> wrote:
>> Signed-off-by: Brandon Williams <bmwill@google.com>
>> ---
>>
>> Since introducing protocol v2 and enabling fetch I've been thinking
>> about what its inverse 'push' would look like.  After talking with a
>> number of people I have a longish list of things that could be done to
>> improve push and I think I've been able to distill the core features we
>> want in push v2.
> It would be nice to know which things you want to improve.

Hopefully we can also get others to chime in with things they don't like 
about the existing protocol. What pain points exist, and what can we do 
to improve at the transport layer before considering new functionality?

>>   Thankfully (due to the capability system) most of the
>> other features/improvements can be added later with ease.
>>
>> What I've got now is a rough design for a more flexible push, more
>> flexible because it allows for the server to do what it wants with the
>> refs that are pushed and has the ability to communicate back what was
>> done to the client.  The main motivation for this is to work around
>> issues when working with Gerrit and other code-review systems where you
>> need to have Change-Ids in the commit messages (now the server can just
>> insert them for you and send back new commits) and you need to push to
>> magic refs to get around various limitations (now a Gerrit server should
>> be able to communicate that pushing to 'master' doesn't update master
>> but instead creates a refs/changes/<id> ref).
> Well Gerrit is our main motivation, but this allows for other workflows as well.
> For example Facebook uses hg internally and they have a
> "rebase-on-the-server-after-push" workflow IIRC as pushing to a single repo
> brings up quite some contention. The protocol outlined below would allow
> for such a workflow as well? (This might be an easier sell to the Git
> community as most are not quite familiar with Gerrit)

I'm also curious how this "change commits on push" would be helpful to 
other scenarios.

Since I'm not familiar with Gerrit: what is preventing you from having a 
commit hook that inserts (or requests) a Change-Id when not present? How 
can the server identify the Change-Id automatically when it isn't present?

>> Before actually moving to write any code I'm hoping to get some feedback
>> on if we think this is an acceptable base design for push (other
>> features like atomic-push, signed-push, etc can be added as
>> capabilities), so any comments are appreciated.
>>
>>   Documentation/technical/protocol-v2.txt | 76 +++++++++++++++++++++++++
>>   1 file changed, 76 insertions(+)
>>
>> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
>> index 49bda76d23..16c1ce60dd 100644
>> --- a/Documentation/technical/protocol-v2.txt
>> +++ b/Documentation/technical/protocol-v2.txt
>> @@ -403,6 +403,82 @@ header.
>>                  2 - progress messages
>>                  3 - fatal error message just before stream aborts
>>
>> + push
>> +~~~~~~
>> +
>> +`push` is the command used to push ref-updates and a packfile to a remote
>> +server in v2.
>> +
>> +Additional features not supported in the base command will be advertised
>> +as the value of the command in the capability advertisement in the form
>> +of a space separated list of features: "<command>=<feature 1> <feature 2>"
>> +
>> +The format of a push request is as follows:
>> +
>> +    request = *section
>> +    section = (ref-updates | packfile)
> This reads as if a request consists of sections, which
> each can be a "ref-updates" or a packfile, no order given,
> such that multiple ref-update sections mixed with packfiles
> are possible.
>
> I would assume we'd only want to allow for ref-updates
> followed by the packfile.
>
> Given the example above for "rebase-on-push" though
> it is better to first send the packfile (as that is assumed to
> take longer) and then send the ref updates, such that the
> rebasing could be faster and has no bottleneck.
>
>> +              (delim-pkt | flush-pkt)
>
>
>> +
>> +    ref-updates = PKT-LINE("ref-updates" LF)
>> +                 *PKT-Line(update/force-update LF)
>> +
>> +    update = txn_id SP action SP refname SP old_oid SP new_oid
>> +    force-update = txn_id SP "force" SP action SP refname SP new_oid
> So we insert "force" after the transaction id if we want to force it.
> When adding the atomic capability later we could imagine another insert here
>
>    1 atomic create refs/heads/new-ref <0-hash> <hash>
>    1 atomic delete refs/heads/old-ref <hash> <0-hash>
>
> which would look like a "rename" that we could also add instead.
> The transaction numbers are an interesting concept, how do you
> envision them to be used? In the example I put them both in the same
> transaction to demonstrate the "atomic-ness", but one could also
> imagine different transactions numbers per ref (i.e. exactly one
> ref per txn_id) to have a better understanding of what the server did
> to each individual ref.
>
>> +    action = ("create" | "delete" | "update")
>> +    txn_id = 1*DIGIT
>> +
>> +    packfile = PKT-LINE("packfile" LF)
>> +              *PKT-LINE(*%x00-ff)
>> +
>> +    ref-updates section
>> +       * Transaction id's allow for mapping what was requested to what the
>> +         server actually did with the ref-update.
> this would imply the client ought to have at most one ref per transaction id.
> Is the client allowed to put multiple refs per id?
>
> Are new capabilities attached to ref updates or transactions?
> Unlike the example above, stating "atomic" on each line, you could just
> say "transaction 1 should be atomic" in another line, that would address
> all refs in that transaction.
>
>> +       * Normal ref-updates require that the old value of a ref is supplied so
>> +         that the server can verify that the reference that is being updated
>> +         hasn't changed while the request was being processed.
> create/delete assume <00..00> for either old or new ? (We could also
> omit the second hash for create delete, which is more appealing to me)
>
>> +       * Forced ref-updates only include the new value of a ref as we don't
>> +         care what the old value was.
> How are you implementing force-with-lease then?

I had the same question.

>
>> +    packfile section
>> +       * A packfile MAY not be included if only delete commands are used or if
>> +         an update only incorperates objects the server already has
> Or rather: "An empty pack SHALL be omitted" ?
>
>> +The server will receive the packfile, unpack it, then validate each ref-update,
>> +and it will run any update hooks to make sure that the update is acceptable.
>> +If all of that is fine, the server will then update the references.
>> +
>> +The format of a push response is as follows:
>> +
>> +    response = *section
>> +    section = (unpack-error | ref-update-status | packfile)
> As above, I assume they ought to go in the order as written,
> or would it make sense to allow for any order?
>
>> +             (delim-pkt | flush-pkt)
>> +
>> +    unpack-error = PKT-LINE("ERR" SP error-msg LF)
>> +
>> +    ref-update-status = *(update-result | update-error)
>> +    update-result = *PKT-LINE(txn_id SP result LF)
>> +    result = ("created" | "deleted" | "updated") SP refname SP old_oid SP new_oid
>> +    update-error = PKT-LINE(txn_id SP "error" SP error-msg LF)
> Can we unify "ERR" and "error" ?
>
>> +    packfile = PKT-LINE("packfile" LF)
>> +              *PKT-LINE(*%x00-ff)
>> +
>> +    ref-update-status section
>> +       * This section is always included unless there was an error unpacking
>> +         the packfile sent in the request.
>> +       * The server is given the freedom to do what it wants with the
>> +         ref-updates provided in the reqeust.  This means that an update sent
>> +         from the server may result in the creation of a ref or rebasing the
>> +         update on the server.
>> +       * If a server creates any new objects due to a ref-update, a packfile
>> +         MUST be sent back in the response.
>> +
>> +    packfile section
>> +       * This section is included if the server decided to do something with
>> +         the ref-updates that involved creating new objects.
>> +
>>    server-option
>>   ~~~~~~~~~~~~~~~
>>
>> --
>> 2.18.0.203.gfac676dfb9-goog
>>
