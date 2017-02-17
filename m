Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0829D20136
	for <e@80x24.org>; Fri, 17 Feb 2017 18:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934735AbdBQSQw (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 13:16:52 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36296 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934140AbdBQSQu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 13:16:50 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so4560604pfo.3
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 10:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6+yP5euXg1kiaON/qkO6kwQ+U3V4+EAys5DT1iH6LcQ=;
        b=aemxqi7bol4o6FxCnQb5KALwT6fLWeG5pBiqTxvRe7z3GzgNnn6QPSjOTi/xSfrENV
         TdXmHk6wgk1FpxeTvLAZVdzy2ZLb4aMlIrbKap0+6wh6ny5WQTnqrLGtdcz3LV/+jdCj
         GKSoqLcKOGBtv0+4ntngxV4sLrztEVqkoLdEnfl2iiIr45CbAeWWvvf+qG1fnx59Tk6W
         T6dQPNFsIuhC50bt01BrAxUUPgLZ0EroNU31n4QnSH8opLKr6JIOAUuygWCvdEknD47W
         /ZqhLn04v4b4V9T47siHvGcWWLMedyc2+nipK+XVs8Ip3NKPTIbNMSZaQ+0ya/PDyooO
         EOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6+yP5euXg1kiaON/qkO6kwQ+U3V4+EAys5DT1iH6LcQ=;
        b=a/Pccjv2edSFjEvJckFgai7fwIxuAzED4M13CcangqysZhsbpyZHOfIcmMk+u316NC
         0l4O4P+AzGU6FECuznRMvVFUYwU/LGp5eNGVq2F/vDTijlvZ9k8jHvVmODr4C6glxIXB
         GsjUcvAehyL1tdjkcOfFTXHCBJT8iUc7uca/aDL2+83qMmnQafXb7M1oJb2neKgyY1QX
         vhYXz3lYx0sIJcCwLGxOZ56ufy02XQmhpIAc34qXdNOCS1j+ma14BU/Wg+Z90ParbWgR
         Ay/KuLqwSGraBoYuoCtGnHRilIocdm8lSGCXyxSqWMPxrs1JFA/qxe3jZ9lHq1xjUSb1
         60uQ==
X-Gm-Message-State: AMke39lKieNc1Pj3tA4iD6xeArBxTzK4BPyLTCvQl8v2u3emIldvvPcTDh6mDX/IJDEr4Q==
X-Received: by 10.98.204.83 with SMTP id a80mr10816706pfg.114.1487353856794;
        Fri, 17 Feb 2017 09:50:56 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id u24sm20852067pfi.25.2017.02.17.09.50.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 09:50:55 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] rename_ref: replace empty deletion message in HEAD's log
References: <20170126211205.5gz3zsrptop7n34n@sigill.intra.peff.net>
        <20170217035800.13214-1-kyle@kyleam.com>
        <20170217035800.13214-4-kyle@kyleam.com>
        <20170217083112.vn7m4udsopmlvnn5@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 09:50:54 -0800
In-Reply-To: <20170217083112.vn7m4udsopmlvnn5@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 17 Feb 2017 03:31:12 -0500")
Message-ID: <xmqqk28ou2o1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Feb 16, 2017 at 10:58:00PM -0500, Kyle Meyer wrote:
>
>> When the current branch is renamed, the deletion of the old ref is
>> recorded in HEAD's log with an empty message.  Now that delete_refs()
>> accepts a reflog message, provide a more descriptive message.  This
>> message will not be included in the reflog of the renamed branch, but
>> its log already covers the renaming event with a message of "Branch:
>> renamed ...".
>
> Right, makes sense. The code overall looks fine, though I have one
> nit:
>
>> @@ -2616,10 +2617,15 @@ static int files_rename_ref(struct ref_store *ref_store,
>>  		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
>>  			oldrefname, strerror(errno));
>>  
>> -	if (delete_ref(oldrefname, orig_sha1, REF_NODEREF, NULL)) {
>> +	strbuf_addf(&logmsg_del, "Deleted %s", oldrefname);
>
> We've been anything but consistent with our reflog messages in the past,
> but I think the general guideline for new ones is to use "command:
> action". Of course we don't _know_ the action here, because we're deep
> in rename_ref().
>
> Should we have the caller pass it in for us, as we do with delete_ref()
> and update_ref()?
>
> I see we actually already have a "logmsg" parameter. It already says
> "Branch: renamed %s to %s". Could we just reuse that? I know that this
> step is technically just the deletion, but I think it more accurately
> describes the whole operation that the deletion is part of.

True, but stepping back a bit,...

Do we even want these "internal" delete_ref() invocations to be
logged in HEAD's reflog?  I understand that this is inside the
implementation of renaming an old ref to a new ref, and reflog
message given to delete_ref() would matter only if the HEAD happens
to be pointing at old ref---but then HEAD will be repointed to the
new ref by somebody else [*1*] that called this function to rename
old to new and it _will_ log it.  So I am not sure if it is a good
thing to describe the deletion more readably with a message (which
is what this patch does) in the first place.  If we can just say
"don't log this deletion event in HEAD's reflog", wouldn't that be
more desirable?


[Footnote]

*1* Is the reason why the code in files_rename_ref() we are looking
    at does not adjust HEAD to point at the new ref is because it is
    just handing one ref-store and obviouvious to symrefs in other
    backends?
