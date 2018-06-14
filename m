Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F6CE1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 23:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965132AbeFNX7z (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 19:59:55 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:49754 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965119AbeFNX7y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 19:59:54 -0400
Received: by mail-vk0-f73.google.com with SMTP id k69-v6so3040117vkk.16
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 16:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=s50ejCCEh7Pb66hlbTi9gm+Anw0YWAtBmlN/XHxegbw=;
        b=CB8DZtg87nymAqU8PlW+uPia5Jn/AN2jNJqntfAa1FLK/928HocjpyGEql6babow3G
         czw/rPzWn6za/KeK+bVmPMiu3wVKUzB/p2jw8AY5pqdI6xHhOmdPRjEZJF5wXtkAofAx
         vtb5BVRi1reKSmQxhu152cdSzthuZ2IsEJ+p2CLiuahGIUrpS5ODWbCSZQIE4rF5vb2/
         1zqvCJMLc9jgRKTSjm97QYQ8Yv+vA3guRlAccitdvG5qabmcM3zE8ubLXZUyODXqOb1X
         V8neIkxvmsHkhQENUxDBqf+ZpDwmNDIRCV8OmwSbMrZdhMfWMGvrYqPu5rZdZMx+EWci
         3mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=s50ejCCEh7Pb66hlbTi9gm+Anw0YWAtBmlN/XHxegbw=;
        b=DXsBaFNsnJhjZcta1d6L6dba7jUgN0RNy/AEbegoMFOPR7ON5rCVsXZAaBo/vZihi2
         pR4EWh4itGtCwinrkbnoV0PqYN2Bqlej5EciKx0gdaIMb8KEsY22KqJbq68U7YpZB0cM
         JsxKBsGAaUXTIo2qFhTkH7FYRr/OZ8kcAHs9XW9RWxKA66WZHhg8CjCQgn3lqqs3K9FV
         gnbg7HSQNaENk3Q+clGL8phxedbh3/ttj5cDEsMfvC5utqbg/y8GZwBsAo6LHyAybE1V
         dxwxpdWfRLQ/kYa0nV/u0ACHb4IJZWhriVNhLIW3IWGiRgv2gMUxY/LhlDiSWgiigynI
         0gsA==
X-Gm-Message-State: APt69E2np72cZtUrrKIvu2ykMp1YvMw+BpWVKFSAX66tvMldai9NQR0V
        nl0T4k6I4+cRNEMSUM41Xhkmc/2bXi5h8k/QbFPI
X-Google-Smtp-Source: ADUXVKL1QmHMVUgvIayq3OKKGfqOjgTwuLvjlx61D/9AOBVKfmiBZHIPQJA3TJUfxGanTiGXg+fFuurTwsE+GHdZVbR3
MIME-Version: 1.0
X-Received: by 2002:ab0:196c:: with SMTP id u44-v6mr2045897uag.17.1529020793394;
 Thu, 14 Jun 2018 16:59:53 -0700 (PDT)
Date:   Thu, 14 Jun 2018 16:59:39 -0700
In-Reply-To: <20180613213925.10560-8-bmwill@google.com>
Message-Id: <20180614235939.205716-1-jonathantanmy@google.com>
References: <20180613213925.10560-8-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c4
Subject: Re: [PATCH v2 7/8] fetch-pack: put shallow info in output parameter
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> @@ -1122,6 +1124,7 @@ static int do_fetch(struct transport *transport,
>  	int autotags = (transport->remote->fetch_tags == 1);
>  	int retcode = 0;
>  	const struct ref *remote_refs;
> +	struct ref *new_remote_refs = NULL;

Above, you use the name "updated_remote_refs" - it's probably better to
standardize on one. I think "updated" is better.

(The transport calling it "fetched_refs" is fine, because that's what
they are from the perspective of the transport. From the perspective of
fetch-pack, it is indeed a new or updated set of remote refs.)

> -	if (fetch_refs(transport, ref_map) || consume_refs(transport, ref_map)) {
> +
> +	if (fetch_refs(transport, ref_map, &new_remote_refs)) {
> +		free_refs(ref_map);
> +		retcode = 1;
> +		goto cleanup;
> +	}
> +	if (new_remote_refs) {
> +		free_refs(ref_map);
> +		ref_map = get_ref_map(transport->remote, new_remote_refs, rs,
> +				      tags, &autotags);
> +		free_refs(new_remote_refs);
> +	}
> +	if (consume_refs(transport, ref_map)) {
>  		free_refs(ref_map);
>  		retcode = 1;
>  		goto cleanup;

Here, if we got updated remote refs, we need to regenerate ref_map,
since it is the source of truth.

Maybe add a comment in the "if (new_remote_refs)" block explaining this
- something like: Regenerate ref_map using the updated remote refs,
because the transport would place shallow (and other) information
there.

> -		for (i = 0; i < nr_sought; i++)
> +		for (r = refs; r; r = r->next, i++)
>  			if (status[i])
> -				sought[i]->status = REF_STATUS_REJECT_SHALLOW;
> +				r->status = REF_STATUS_REJECT_SHALLOW;

You use i here without initializing it to 0. t5703 also fails with this
patch - probably related to this, but I didn't check.

If you initialize i here, I don't think you need to initialize it to 0
at the top of this function.
