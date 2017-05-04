Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8E9D207D6
	for <e@80x24.org>; Thu,  4 May 2017 19:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752785AbdEDTTc (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 15:19:32 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36410 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbdEDTTa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 15:19:30 -0400
Received: by mail-pg0-f67.google.com with SMTP id v1so3480189pgv.3
        for <git@vger.kernel.org>; Thu, 04 May 2017 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=R/mTs8AhLY4gpVMnG3BNci4VqcRjsAAube/HbrDPHGQ=;
        b=PwIXXh7qDhxJX1+kFL3amxY1sgn4kmFSLacimJf3xnf4jyh7QaDwUg2tLE9fhv2Vve
         NCcIDTg6UQJRIfpIEFkxYbmhAXpR+V8RVTyg4gUQjLk/bT5J1TCiqyDieEWpynalYkTT
         8hlymlLjA2/kXsLv0pURsElQc+otB2d1Fr4jebtoN9i4tCf1iz1wej4pAvkgwM36yqg8
         o4mlddPE9HOBQ5w+oIrkdK4sYZp8taEXHClUWzXfNNy4Eja77U+3b3o9y443Pk2Benkk
         pg3IqgPYb0ocbVHK8FU0Qy7ThvVcYW3vTRTFhXTYar0uHwo9/mG9xJdq5r30g1o9wETp
         eAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R/mTs8AhLY4gpVMnG3BNci4VqcRjsAAube/HbrDPHGQ=;
        b=HW/tbrDAl5CaRyMt5bq3D+yf4JCGb85JfFf1QQNCY/Y2RItahRjr8wf2THWnr7gKkm
         5nPBlik0cHOH3f6/HJqFyMocMosUcjVTj6WwlvdkYb4H6LYAKcVrbZAAxsZBHQaItBmL
         IhcVXaWirdkEzZGXNkGjKVud0YvlJHEA15gI1rXmHWYSuDnTb7run5jDn2X4p3RKxI3p
         IfmE6SCw8BETugDX2Yk91TeCx2a1tZR7dppM0w8Dy4RTxpKlMZ60w75gVoBeXeOVC3mj
         iLSFbNS3cc6O8bTDHrqx8bnJ9l2fWxqpKupXgKAtaKTUP+IW6UsG66czGANCZV6vd5hw
         O6zw==
X-Gm-Message-State: AN3rC/7jvXs2buM3PhADN0pFrFSe1E9P8KBRnKDpdOlAXZ2vDI3oaQxy
        ixeoH3Lcf9HCoA==
X-Received: by 10.98.42.2 with SMTP id q2mr12414265pfq.165.1493925569566;
        Thu, 04 May 2017 12:19:29 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:5588:c10f:2622:1a6])
        by smtp.gmail.com with ESMTPSA id g71sm5400004pfc.41.2017.05.04.12.19.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 May 2017 12:19:29 -0700 (PDT)
Date:   Thu, 4 May 2017 12:19:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/5] Start of a journey: drop
 NO_THE_INDEX_COMPATIBILITY_MACROS
Message-ID: <20170504191927.GB15203@aiede.svl.corp.google.com>
References: <20170501190719.10669-1-sbeller@google.com>
 <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
 <CACsJy8AZevgFda4ZJAmH_Nyrtuk72FUjdk6B8_SJB=n6quPnbw@mail.gmail.com>
 <xmqqa86tbamh.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa86tbamh.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:

>> I attempted the same thing once or twice in the past, had the same
>> impression and dropped it. But I think it's good to get rid of cache_*
>> macros, at least outside builtin/ directory.
>
> One thing that needs to be kept in mind is that a mechanical
> replacement of active_cache[] to the_index.cache[] in the
> infrastructure code does not get us closer to such an improvement.
> In fact, such a patch only has negative value (keep reading until
> the end of the paragraph that begins with "One thing is certain" to
> understand why).
>
> The entry point to a codechain for an important infrastructure code
> that can currently only work with the_index needs to be identified.
> There may be many.  They need to be made to take an index_state
> instance and to pass it through the callchain.  That kind of change
> would be an improvement, and will get us closer to mark the
> resulting code with NO_THE_INDEX_COMP thing.

Thanks for articulating this.  I agree with this general goal.

[...]
> But one thing is certain. Many users of the API, just like a lot of
> builtin/ code works only with the_index today, will not have to work
> with a non-default repository or a non-default index_state.  Only
> the more advanced and complex "multi-repo" Porcelains would have to
> care.  Keeping active_cache[], active_nr, etc. abstraction would
> isolate the simpler callers from the inevitable code churn we would
> need while getting the "repository" abstraction right.  This is why
> I see that you understood the issues well when you said "builtiln/".

One small change we could make is to reverse the sense of the
NO_THE_INDEX_COMPATIBILITY_MACROS macro.  That way, new library code
authors have to define USE_THE_INDEX_COMPATIBILITY_MACROS at the top
of the file, providing a hint to reviewers that they are using
the_index implicitly instead of relying on explicit repository or
index parameters.

More generally, if we are willing to follow through then I see
Stefan's change as a step in the right direction.  Sure, it replaces
calls like read_cache with read_the_index(&the_index, ...) which does
not change semantics and may not look like progress.  But:

- uses of 'the_index' are easy to grep for and it is easy to
  understand that they are using global state.  In builtins, this is
  not important (which may be an argument for making builtins get
  USE_THE_INDEX_COMPATIBILITY_MACROS implicitly instead and
  restricting this change to library code), but in libraries it
  communicates what is happening to developers looking at the code.
  It is like a /* NEEDSWORK */ comment, except in code instead of
  comments.

  See Go's context.TODO <https://golang.org/pkg/context/#TODO> for a
  similar example in another set of projects.

- it makes code consistently use the term "index" instead of mixing
  "index" and "cache".  This makes code easier to understand for new
  contributors.

- a minor thing: it means more of git is using functions instead of
  macros.  IDEs, grep habits, etc cope better with functions.  That is
  minor, though: the compatibility macros could easily be replaced
  with compatibility inline functions to achieve the same effect.

[...]
> Also, dropping compatibility macros at the end of the series is
> unfriendly to fellow developers with WIPs that depend on the
> traditional way of doing things.

Agreed with this as well --- for widely used APIs like these, it is
more friendly to decouple adapting callers (in a separate patch) from
the patch that removes the API.

That is, one way to do what this series attempts would be the
following:

 1. rename variables that shadow the_index.

 2. add coccinelle patches (or one coccinelle patch) to
    contrib/coccinelle implementing *_cache -> *_index migration.
    Is there a way to do this without making it fail "make coccicheck"?

 3. migrate library code (but not builtins) using that semantic patch

 4. make compatibility macros opt-in instead of opt-out
    (USE_THE_INDEX_COMPATIBILITY_MACROS). Opt-in all builtins.

 5. optional: change the compatibility macros to compatibility inline
    functions, perhaps.
 6. optional: rename *_cache to *_the_index for clarity, perhaps.
 7. optional: migrate builtins, if there is a way to make the patches
    for that look sensible.

Thoughts?
Jonathan
