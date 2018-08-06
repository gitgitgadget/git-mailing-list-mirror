Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12726208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 15:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbeHFRxs (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 13:53:48 -0400
Received: from mail-lj1-f179.google.com ([209.85.208.179]:36895 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbeHFRxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 13:53:48 -0400
Received: by mail-lj1-f179.google.com with SMTP id v9-v6so10995976ljk.4
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vdnDnX00HLBonmHUgFBmsHx71tY0XEyGcG6a7zagwDA=;
        b=V5uUMifR1qKekkpTm5qE4HrhH8I3efyz0hTyxDPpuyV7X7Ez1/k/guq0yROoqDhPjI
         wJP/6YIX9Y9XnuIiL+lBLIDOOxrJ1VhlaStitqX/l2GOlQQpWu86tJ+ObUR0uY1X9NDM
         4yWWcXKuglRdTNKy7WRyLn3zk56XsgKK4j3f5aQ38nYR9seTLl9Iaedy3Ixjwt3FlbX/
         q0zLh9xa7ljYceSySQhywyKVECQ+PgjiMWX/yQule3egA41lUUI9JOnTQ35GteUj+4V6
         irPP1qW5pnnxUt3yYY1mNumPzSHpdHqT2x9axtmJVFLwDSTlPYp2ZwwCQqdZDxMRls3m
         Xf/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vdnDnX00HLBonmHUgFBmsHx71tY0XEyGcG6a7zagwDA=;
        b=Nzi0lWN6DqJ0cx0F/Xyo+/mRxCuCWOroIAxFLS6YGNfZuM0QUpRGq9W07GtVX87IPD
         7xf+16Q5p7o1UhHebdrXWQWXhVMlxWQuSaiLZHXSzNLxZxzKVAEIDpDm8kPNV2GGw0xe
         WdEfQozSfRsNVCSuEnNosixjR8+9cGFCpWLGVbkdjhhAZtfBN/A1BcIY3DMoOumky8fv
         HZWqPT1GESFSUbHzhUAu00yKFWUM2PIXKqnA1fwXOjbQiPvQr/X0shc6zvLtznwC3fw0
         1cZkykS1YkBGuvBsktfM+6CYFMqXUP8cI//dk5B2NSeC0dZHWzrrE5oRInZ/Zsp76TFv
         +nYQ==
X-Gm-Message-State: AOUpUlFPPRdtvlM+A8hmaNFll9/kIXmoqOIK8B8pKzkw0cNbefGlx8R5
        QCoqUTTrqv4lP2X04Mt8NMosQ6dssIJo9aHgJRc=
X-Google-Smtp-Source: AAOMgpf9fg2NZ30ynB2YtBAitEJpmLJVU5mBAFJPEMCPKoDMdkNjUygEsFFrUoXYhzZ80AAR39Xk0kNVtUQ2hMojTng=
X-Received: by 2002:a2e:8147:: with SMTP id t7-v6mr13789693ljg.32.1533570246402;
 Mon, 06 Aug 2018 08:44:06 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 2002:a2e:5ce:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 08:44:05 -0700 (PDT)
In-Reply-To: <20180806154122.GB105466@aiede.svl.corp.google.com>
References: <CAHd499B2VingKU-+7idv9FROYgCmOAzZ7YAQgWdwY1YUeTUVHA@mail.gmail.com>
 <20180802060842.GB10757@aiede.svl.corp.google.com> <CAHd499CFHUwpNdYp2sMjChi_WWzSihi5VRzLMQbKsGrKf_Ktcg@mail.gmail.com>
 <20180806154122.GB105466@aiede.svl.corp.google.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Mon, 6 Aug 2018 10:44:05 -0500
X-Google-Sender-Auth: AoB7VWU-dzYS_GroHw-522DsIpk
Message-ID: <CAHd499AcgCNfZtthwsqiki7JKrDTmMzq48z12H5Mf+mLKrf_QA@mail.gmail.com>
Subject: Re: Fetch on submodule update
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 10:41 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Robert Dailey wrote:
>
>>                                                  Automatic would be
>> great if submodules were treated as integrated in a similar manner to
>> subtree, but it's not there. I wasn't aware that `submodule update`
>> did a fetch, because sometimes if I do that, I get errors saying SHA1
>> is not present (because the submodule did not get fetched). Granted I
>> haven't seen this in a while, so maybe the fetch on submodule update
>> is a newer feature. Do you know what triggers the fetch on update
>> without --remote? Is it the missing SHA1 that triggers it, or is it
>> fetching unconditionally?
>
> Thanks for this and the rest of the context you sent.  It's very
> helpful.
>
> The relevant code in git-submodule.sh is
>
>         # Run fetch only if $sha1 isn't present or it
>         # is not reachable from a ref.
>         is_tip_reachable "$sm_path" "$sha1" ||
>         fetch_in_submodule "$sm_path" $depth ||
>         say "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
>
>         # Now we tried the usual fetch, but $sha1 may
>         # not be reachable from any of the refs
>         is_tip_reachable "$sm_path" "$sha1" ||
>         fetch_in_submodule "$sm_path" $depth "$sha1" ||
>         die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
>
> The fallback to fetching by SHA-1 was introduced in v2.8.0-rc0~9^2
> (submodule: try harder to fetch needed sha1 by direct fetching sha1,
> 2018-02-23).

Yep, that's the root cause; I was basing my concerns on a legacy
issue. I just had avoided using `update` when I expected a fetch, so I
never saw the issue again, and thus didn't realize it was corrected.
Very helpful. Thanks again!
