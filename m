Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63B301F461
	for <e@80x24.org>; Thu,  5 Sep 2019 18:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388215AbfIESjb (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 14:39:31 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:33948 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732133AbfIESjb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 14:39:31 -0400
Received: by mail-vs1-f73.google.com with SMTP id l24so481571vsq.1
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 11:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vXUjuC6kDg53JsZ0nvgLgLwuBRYUVrn6QIDTUubsaYo=;
        b=bVqW7/wjDfMSrUdV8vGb3sbNjzzkn056Lv+nwCRbDow1eLAZHobZm15iEyMEKkcRfp
         bn/r9UeOVSs7LlShKD/AapvUA+v+YL7/ad/tH7I1fq1izar7ShESUDzbKZ5yW3B1V6JR
         1rg20u8gROVRqIHkoNnlFLxBXXeYarZz+ZCZO+hHdyH9jU6n+q4vfdKDOTKHKF4lwMbz
         79K7uoPn4bC4vRw4CkUABhqMaY8EjQJ4G0n8tyAigsjejiebY7SVAASj2pcTTDqAXK9u
         fsmT243rKDgcLvoLLSq7HEV5vYfk6Q+UMuLNiLqLn9lcrjfemRqh1TOSERRGy9F8HRQl
         4u9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vXUjuC6kDg53JsZ0nvgLgLwuBRYUVrn6QIDTUubsaYo=;
        b=N2y417ACd+K99necFkBIQHV3bmsqBiM1aKmcmPNn9OwakwKZsFUhE4zM4C9G59arxa
         wpwsLDUI7Ia3mHiMwzTJ68PmB4GsW3Duqr5sTtprng2Xh5CrDEjLj3HsCYV0bKYugP0a
         qKEFwGKhaHrm7z3lpPtTTC9z9ABwANEW2nxxIKPxwEmbjd7t7e0Dpsj/M3+qb4rPaxyO
         7KzixjbXz5jU6utEdoSTe1U/skNxhUjTIb9fCwdrkdPv1iDRmQ4lysan+QmkzUgf6jY/
         ENym1d8hjPeQg2wSliLBDaBlaNTkLR4I1yj+OuEbhJXrhOvbeG5tNOcbgQdQqJc7QkSL
         +0QA==
X-Gm-Message-State: APjAAAXhd81JKD78NKbcSgzY8PVzSNOKfQPX7UtgLx6qSXS6nJjFziUZ
        BGWiFGnXCJz/NNUOZ44aTYwicpqmPqNp2tLIUqz8
X-Google-Smtp-Source: APXvYqziuXAkSqKzCZH8jpw3se/+eFZy7Gm7BIy+Wvfa8qfycW0poYmxq+d4aiKz6ZJBr/MjO/ySbDmcKsq8iIbPbG96
X-Received: by 2002:ac5:cdad:: with SMTP id l13mr2319377vka.30.1567708770016;
 Thu, 05 Sep 2019 11:39:30 -0700 (PDT)
Date:   Thu,  5 Sep 2019 11:39:26 -0700
In-Reply-To: <20190905070153.GE21450@sigill.intra.peff.net>
Message-Id: <20190905183926.137490-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190905070153.GE21450@sigill.intra.peff.net>
X-Mailer: git-send-email 2.23.0.162.g0b9fbb3734-goog
Subject: Re: [PATCH] fetch-pack: write fetched refs to .promisor
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I'm not really opposed to what you're doing here, but I did recently
> think of another possible use for .promisor files. So it seems like a
> good time to bring it up, since presumably we'd have to choose one or
> the other.

Thanks for bringing it up - yes, we should discuss this.

> I noticed when playing with partial clones that the client may sometimes
> pause for a while, chewing CPU. The culprit is is_promisor_object(),
> which generates the list of known promisor objects by opening every
> object we _do_ have to find out which ones they mention.
> 
> I know one of the original design features of the promisor pack was that
> the client would _not_ keep a list of all of the objects it didn't have.
> But I wonder if it would make sense to keep a cache of these "cut
> points" in the partial clone. That's potentially smaller than the
> complete set of objects (especially for tree-based partial cloning), and
> it seems clear we're willing to store it in memory anyway.

Well, before the current design was implemented, I had a design that had
such a list of missing objects. :-) I couldn't find a writeup, but here
is some preliminary code [1]. In that code, as far as I can tell, the
server gives us the list directly during fetch and the client merges it
with a repository-wide file called $GIT_DIR/objects/promisedblob, but we
don't have to follow the design (we could lazily generate the file, have
per-packfile promisedblob files, etc.).

[1] https://public-inbox.org/git/cover.1499800530.git.jonathantanmy@google.com/

> And if we do that, would the .promisor file for a pack be a good place
> to store it?

After looking at [1], it might be better in another place. If we want to
preserve fast fetches, we still need another file to indicate that the
pack is a promisor, so ".promisor" seems good for that. The presence or
absence of the cutoff points is a separate issue and could go into a
separate file, and it might be worth putting all cutoff points into a
single per-repository file too.
