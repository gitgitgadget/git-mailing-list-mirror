Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCB801FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 18:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751847AbdBJShK (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 13:37:10 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36066 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbdBJShI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 13:37:08 -0500
Received: by mail-pf0-f193.google.com with SMTP id 19so3003084pfo.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 10:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2BEb6DMCSelb1ByJXe0MLUHv2JLXWHS/mdEfvhP4TDE=;
        b=WwWOpPZePJXBj7kGZT5TGrqD0OhtotKdcEjMGf8MP+xO22fDP3WYxYqz5LKDYcY6le
         slO+dUuwyFdWF4S3oBLDPxvA/B7v4GMxNUD5qO82YfzcyozNflVCzCtP8aU0jvFHjZcV
         /Qi5w+7BqR0KUuVGuN49koerlY6wCevI+9MF/QpZZhmlWqm7ABL1Nn2G19tC4ShDyKZi
         MclvtGyzg6ev02L7BsP5NTBDLT6XWNx5xOZnJfpkiFJ9luGLocWLdgA7tkxLQUQxLK8I
         WN3Pek89QYEYZX3TC69whr4Q/b2OTbLvgES5pGb9KHNWb8IOv1jCfBoNUSx9h9YAemBx
         uCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2BEb6DMCSelb1ByJXe0MLUHv2JLXWHS/mdEfvhP4TDE=;
        b=qk4bpgEp3Uh9LoHOu9JHMu/kR3lsa6FAU183VpppNAzFig1JX/BUiBqMjqJJzNkRkz
         gpaWsAgKh+DC518IPAjWfLu1b+jY5P7hm954vqyEe8bGXFdQzSeQYFgz4+OqmCIM8EOT
         538EbJQVfFnkNz+dP6tH0J66ItBkHVXA2sPFtmxP7/MfE9LSVisWPxd1uO30EPhmC+Fm
         jGHJLN2jKzWMvlRPlyKsxiZLAHPdpsBz71vYW5nHy/KmBMRk9rRJbj6UmpYipZcaH6rC
         f3lAONSr+YqObHcXrPDy/qyTCQ9REAQzLNQynGY7UZgS4y5Iuvi/lO4kovNJ96WPaGK+
         +O7Q==
X-Gm-Message-State: AMke39kSqKTaUSpz0K7lmPY/2fSy1GLkHhiuOv3tYbC+ar/3MPgIcpYcWt0WYCqoDFnLWA==
X-Received: by 10.84.248.11 with SMTP id p11mr13197677pll.72.1486751774388;
        Fri, 10 Feb 2017 10:36:14 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id x2sm7022466pfa.71.2017.02.10.10.36.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 10:36:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch: print an error when declining to request an unadvertised object
References: <1486747828.17272.5.camel@mattmccutchen.net>
Date:   Fri, 10 Feb 2017 10:36:12 -0800
In-Reply-To: <1486747828.17272.5.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Fri, 10 Feb 2017 12:26:33 -0500")
Message-ID: <xmqqwpcxlwpv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

> Currently "git fetch REMOTE SHA1" silently exits 1 if the server doesn't
> allow requests for unadvertised objects by sha1.  Change it to print a
> meaningful error message.
>
> Signed-off-by: Matt McCutchen <matt@mattmccutchen.net>
> ---
>
> The fetch code looks unbelievably complicated to me and I don't understand all
> the cases that can arise.  Hopefully this patch is an acceptable solution to the
> problem.

At first I thought that this should be caught on the sending end
(grep for "not our ref" in upload-pack.c), but you found a case
where we do not even ask the sender on the requesting side.

I am not convinced that modifying filter_refs() is needed or even
desirable, though.

There is this piece of code near the end of builtin/fetch-pack.c:

	/*
	 * If the heads to pull were given, we should have consumed
	 * all of them by matching the remote.  Otherwise, 'git fetch
	 * remote no-such-ref' would silently succeed without issuing
	 * an error.
	 */
	for (i = 0; i < nr_sought; i++) {
		if (!sought[i] || sought[i]->matched)
			continue;
		error("no such remote ref %s", sought[i]->name);
		ret = 1;
	}

that happens before the command shows the list of fetched refs, and
this code is prepared to inspect what happend to the requests it (in
response to the user request) made to the underlying fetch
machinery, and issue the error message.
If you change your command line to "git fetch-pack REMOTE SHA1", you
do see an error from the above.

That is a good indication that the underlying fetch machinery called
by this caller is already doing diagnosis that is necessary for the
caller to issue such an error.  So why do we fail to say anything in
"git fetch"?

I think the real issue is that when fetch-pack machinery is used via
the transport layer, the transport layer discards the information on
these original request (i.e. what is returned in sought[]).

Instead, the caller of the fetch-pack machinery receives the list of
filtered refs as the return value of fetch_pack() function, and only
looks at "refs" without checking what happened to the original
request to_fetch[] (which corresponds to sought[] in the fetch-pack
command).  This all happens in transport.c::fetch_refs_via_pack().
I think that function is a much better place to error or die than
filter_refs().


>  fetch-pack.c          | 31 ++++++++++++++++---------------
>  t/t5516-fetch-push.sh |  3 ++-
>  2 files changed, 18 insertions(+), 16 deletions(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 601f077..117874c 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -598,23 +598,24 @@ static void filter_refs(struct fetch_pack_args *args,
>  	}
>  
>  	/* Append unmatched requests to the list */
> -	if ((allow_unadvertised_object_request &
> -	    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1))) {
> -		for (i = 0; i < nr_sought; i++) {
> -			unsigned char sha1[20];
> +	for (i = 0; i < nr_sought; i++) {
> +		unsigned char sha1[20];
>  
> -			ref = sought[i];
> -			if (ref->matched)
> -				continue;
> -			if (get_sha1_hex(ref->name, sha1) ||
> -			    ref->name[40] != '\0' ||
> -			    hashcmp(sha1, ref->old_oid.hash))
> -				continue;
> +		ref = sought[i];
> +		if (ref->matched)
> +			continue;
> +		if (get_sha1_hex(ref->name, sha1) ||
> +		    ref->name[40] != '\0' ||
> +		    hashcmp(sha1, ref->old_oid.hash))
> +			continue;
>  
> -			ref->matched = 1;
> -			*newtail = copy_ref(ref);
> -			newtail = &(*newtail)->next;
> -		}
> +		if (!(allow_unadvertised_object_request &
> +		    (ALLOW_TIP_SHA1 | ALLOW_REACHABLE_SHA1)))
> +			die(_("Server does not allow request for unadvertised object %s"), ref->name);
> +
> +		ref->matched = 1;
> +		*newtail = copy_ref(ref);
> +		newtail = &(*newtail)->next;
>  	}
>  	*refs = newlist;
>  }
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 0fc5a7c..177897e 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -1098,7 +1098,8 @@ test_expect_success 'fetch exact SHA1' '
>  		test_must_fail git cat-file -t $the_commit &&
>  
>  		# fetching the hidden object should fail by default
> -		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy &&
> +		test_must_fail git fetch -v ../testrepo $the_commit:refs/heads/copy 2>err &&
> +		test_i18ngrep "Server does not allow request for unadvertised object" err &&
>  		test_must_fail git rev-parse --verify refs/heads/copy &&
>  
>  		# the server side can allow it to succeed
