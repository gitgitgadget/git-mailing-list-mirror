Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0E1208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732710AbeHFRvG (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:51:06 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:41496 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbeHFRvF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:51:05 -0400
Received: by mail-pf1-f173.google.com with SMTP id y10-v6so7054774pfn.8
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XfybdWnpna5wfA4zSn18KNFgp/FbTIGDGPeoaIrdbJk=;
        b=c5AqFma9ZHceFzpM2oe+E/4d8jo1qZdHyVFVv8VX/H3u62FTTr9Dt0U85CW8hcXKym
         Nzxd1WTpoScLWqoz+pK2e9Gjy5kOUOlUh9rzTC7+aPiXt0lyfsGqkLowGRfHF9fCGtmf
         IwDkt4Y8qd4tCKu0XvYVqEMlLxd+VsuZM2L1dBWf2vsJhXmX/1XLEt9dccGrC2r/2zm3
         1YgKncwxhd/SA36yp31qhycuJ9VfwLSk6JUL/UZBGWlhaStSI5DBm8+gCLoGG7ZVVCt8
         aILXZPHZ9W0wKGs996uC5XurO9tEutJQ/ovgGc3zaK4hXJhNrplH0FRIm+C53eWg6zH4
         w0Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XfybdWnpna5wfA4zSn18KNFgp/FbTIGDGPeoaIrdbJk=;
        b=fyjm58SXgTrnQwGUkyNmOJSgvr8ZMNiqDbj2pqq8hQvxMukqaM5OosZODp0icgFwP0
         qT9vkZjfEJ6RjScQoIx/alGC3zrXhLyFCf4fzp/ReepIbR8UjdR3DXhagJmtxrbMeEIa
         ShAFexeAM2+TgIVVcdYUq0W+wNZNgjq3R053eDLghQgZWBt6AFQI7eB/zgKaGYB+DDaz
         Ngm/heZp1u2eIdjzlr8bvzo3mgf0pAoj6C9/HDdJ6ffUeMSsz5MK2uCbzHGrmTw95CJN
         kU0Ig2sv6+bwH8tmEhpPkIJfLtakiMWQIOIMbSu0s0StFuiy1KIThvKd/2No7/7wN5wW
         Is/w==
X-Gm-Message-State: AOUpUlEJa9pENs/fusC7rTQAlSgabHTn8GmBF7DI4IbY5tGbDCv3z7hV
        4V+H1f7gwUE9q0oLbEyrU1s=
X-Google-Smtp-Source: AAOMgpdNdZErEMyi/lttPlPEaOJ5ZghoCZQ2eKdDobrlULpjikJYbqf9V0Uthypx6XU76db/wLnx5g==
X-Received: by 2002:a62:d842:: with SMTP id e63-v6mr17857423pfg.88.1533570084921;
        Mon, 06 Aug 2018 08:41:24 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d10-v6sm12154320pgo.2.2018.08.06.08.41.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 08:41:24 -0700 (PDT)
Date:   Mon, 6 Aug 2018 08:41:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Subject: Re: Fetch on submodule update
Message-ID: <20180806154122.GB105466@aiede.svl.corp.google.com>
References: <CAHd499B2VingKU-+7idv9FROYgCmOAzZ7YAQgWdwY1YUeTUVHA@mail.gmail.com>
 <20180802060842.GB10757@aiede.svl.corp.google.com>
 <CAHd499CFHUwpNdYp2sMjChi_WWzSihi5VRzLMQbKsGrKf_Ktcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd499CFHUwpNdYp2sMjChi_WWzSihi5VRzLMQbKsGrKf_Ktcg@mail.gmail.com>
User-Agent: Mutt/+ (31e72e18) (2018-08-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey wrote:

>                                                  Automatic would be
> great if submodules were treated as integrated in a similar manner to
> subtree, but it's not there. I wasn't aware that `submodule update`
> did a fetch, because sometimes if I do that, I get errors saying SHA1
> is not present (because the submodule did not get fetched). Granted I
> haven't seen this in a while, so maybe the fetch on submodule update
> is a newer feature. Do you know what triggers the fetch on update
> without --remote? Is it the missing SHA1 that triggers it, or is it
> fetching unconditionally?

Thanks for this and the rest of the context you sent.  It's very
helpful.

The relevant code in git-submodule.sh is

	# Run fetch only if $sha1 isn't present or it
	# is not reachable from a ref.
	is_tip_reachable "$sm_path" "$sha1" ||
	fetch_in_submodule "$sm_path" $depth ||
	say "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"

	# Now we tried the usual fetch, but $sha1 may
	# not be reachable from any of the refs
	is_tip_reachable "$sm_path" "$sha1" ||
	fetch_in_submodule "$sm_path" $depth "$sha1" ||
	die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"

The fallback to fetching by SHA-1 was introduced in v2.8.0-rc0~9^2
(submodule: try harder to fetch needed sha1 by direct fetching sha1,
2018-02-23).

Jonathan
