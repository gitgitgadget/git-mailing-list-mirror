Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 816051F404
	for <e@80x24.org>; Fri, 23 Feb 2018 20:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeBWU6l (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 15:58:41 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54674 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751917AbeBWU6k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 15:58:40 -0500
Received: by mail-wm0-f65.google.com with SMTP id z81so6957368wmb.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 12:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OM4astDOrtDem/EFyhZbq8Kj11fnAlpEf8WkLvcpPXw=;
        b=kkLdV5HaA9KknN7xryiUsgRRg7zXN9t0MhPF9hcHyqn+3JyI+iMMsjQ55BmtZLxs7J
         Et8AKs7C4oL9mODpsbgF0M06oxMI3XXYokPzGKRpU6WAbeXZO8kJokMg2W0sdvNtN/No
         W9+pryuzLdAs/hLwnlTbON1EC1Vkv7xZCy+U2gXGZd8i+KIsjEk2cYZCNiSPe21MPKeg
         QnUQTyfZ2gsQPcoKTmtJauSvcGyyNfRnZSiLxHse7AvLvpTTa2+U54pUDBkPGcQXEoUI
         qc8LEjd8T+NTQk2KJDr0vzXXryw62XRK7CrrscqVbVDQuVOrCXdA1IqSMl+PbxftmAMV
         kBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OM4astDOrtDem/EFyhZbq8Kj11fnAlpEf8WkLvcpPXw=;
        b=fxIAm3q1c5jpVpZACsCmA/OlKPdGEGq3twp+9mIXIjhexYaAIauy03dqP7e7q7I2RF
         xXQoEtAsgx+PIRCAI1Khkx649/S6l/sxlCloN8kw5W7wDmV8bPzKdMWG86TYqgAfyRx3
         bdj7sWRNPwuYu73eBihpQLJugnsw7OKewHH40j7spapmknAUnB+MbODEU8I/A/rmtSRG
         J3b0xLg7tXU6YJL5eHajFJ4gNmRtnzvyilPp3fldWHxJsdNPVcAs6XFR16AJLvQ6+x2j
         Yd/SLnGy2LbovTb+66aljVEs39yqzSHMMoQvP1FiHCjT66Tz278i0WwtQ8ZgSnZHh7nP
         AwTQ==
X-Gm-Message-State: APf1xPAd5bqWDthmYzJrlc1U1NdQNFJtXmRTiaCWyELsBIlGN6vyU9+b
        Z70iTImbE4fH95dUYRFKvhg+TbGh
X-Google-Smtp-Source: AH8x227U2FQ2yNQrTgLMeAS7ge7lvCRXNslWoshHbMC4xLtmSyGXA4hgeqC6L5RTpylqEuPQnMRUBA==
X-Received: by 10.28.107.213 with SMTP id a82mr2586108wmi.91.1519419518398;
        Fri, 23 Feb 2018 12:58:38 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w134sm234308wmd.45.2018.02.23.12.58.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 12:58:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v2] ref-filter: Make "--contains <id>" less chatty if <id> is invalid
References: <20180223162557.31477-1-ungureanupaulsebastian@gmail.com>
Date:   Fri, 23 Feb 2018 12:58:37 -0800
In-Reply-To: <20180223162557.31477-1-ungureanupaulsebastian@gmail.com>
        (Paul-Sebastian Ungureanu's message of "Fri, 23 Feb 2018 18:25:57
        +0200")
Message-ID: <xmqqwoz3s9s2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com> writes:

> Hello,
> I have made the changes after review. This is the updated patch
> based on what was discussed last time [1].
>
> In this patch, I have fixed the same issue that was also seen
> in "git branch" and "git for-reach-ref". I have also removed the
> dead code that was left and updated the patches accordingly.
>
> [1] https://public-inbox.org/git/20180219212130.4217-1-ungureanupaulsebastian@gmail.com/
>
> Best regards,
> Paul Ungureanu
>
> https://public-inbox.org/git/20180219212130.4217-1-ungureanupaulsebastian@gmail.com/

You do not want all of the above, upto and including the "---" below,
to appear in the log message of the resulting commit.  One way to
tell the reading end that you have such preamble in your message is
to write "-- >8 --" instead of "---" there.

> ---
>
> Some git commands which use --contains <id> print the whole
> help text if <id> is invalid. It should only show the error
> message instead.
>
> This patch applies to "git tag", "git branch", "git for-each-ref".
>
> This bug was a side effect of looking up the commit in option
> parser callback. When a error occurs in the option parser, the
> full usage is shown. To fix this bug, the part related to
> looking up the commit was moved outside of the option parser
> to the ref-filter module.
>
> Basically, the option parser only parses strings that represent
> commits and the ref-filter performs the commit look-up. If an
> error occurs during the option parsing, then it must be an invalid
> argument and the user should be informed of usage, but if a error
> occurs during ref-filtering, then it is a problem with the
> argument.

The same problem appears for "git branch --points-at <commit>",
doesn't it?

> diff --git a/ref-filter.c b/ref-filter.c
> index f9e25aea7..aa282a27f 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2000,6 +2000,25 @@ static void do_merge_filter(struct ref_filter_cbdata *ref_cbdata)
>  	free(to_clear);
>  }
>  
> +int add_str_to_commit_list(struct string_list_item *item, void *commit_list)

If this function can be static to this file (and I suspect it is),
please make it so.

> +{
> +	struct object_id oid;
> +	struct commit *commit;
> +
> +	if (get_oid(item->string, &oid)) {
> +		error(_("malformed object name %s"), item->string);
> +		exit(1);
> +	}
> +	commit = lookup_commit_reference(&oid);
> +	if (!commit) {
> +		error(_("no such commit %s"), item->string);
> +		exit(1);
> +	}
> +	commit_list_insert(commit, commit_list);

The original (i.e. before this patch) does commit_list_insert() in
the order the commits are given on the command line.  This version
collects the command line arguments with string_list_append() that
preserves the order, and feeds them to commit_list_insert() here, so
the resulting commit_list will have the commits in the same order
before or after this patch.

Which is good.

> +	return 0;
> +}

The code after this patch is a strict improvement (the current code
do not do so either), so this is outside the scope of this patch,
but we may want to give this function another "const char *" that is
used to report which option we got a malformed object name for.

> @@ -2012,6 +2031,10 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
>  	int ret = 0;
>  	unsigned int broken = 0;
>  
> +	/* Convert string representation and add to commit list. */
> +	for_each_string_list(&filter->with_commit_strs, add_str_to_commit_list, &filter->with_commit);
> +	for_each_string_list(&filter->no_commit_strs, add_str_to_commit_list, &filter->no_commit);
> +

As it does not use item->util in the callback helper, this should
use for_each_string_list_item() instead; then you can do

	for_each_string_list_item(item, &filter_no_commit_strs)
		collect_commit(&filter->no_commit, item->string);

which allows the other helper take a simple string, instead of
requiring a string_list_item.
