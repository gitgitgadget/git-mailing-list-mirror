Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22984202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 20:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdCIUSi (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 15:18:38 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:36628 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbdCIUSh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 15:18:37 -0500
Received: by mail-pg0-f44.google.com with SMTP id g2so12809399pge.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 12:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=XguIW4rHJNt/TImQ6cvBiMAUzdPq8NqreQcGI3yGJBU=;
        b=nMKTpoyJc1rUE+kJ0WbXe0qIW86UG1GnRz1ytBWuyCm2Dy/g5Qqn7dbbQ/VMbEDnCe
         BsYxllOu5J3rZW/leGglixjSGaSO8SsOVbSNcuGti+DHUzsX6LGHRFBWcJPtlik4/0kO
         u68LzyzWGFBUaL2YoqrVDkWJ+hABX8v6Q7N/NnZ/lZSuLlznUtQIjKaYoM18RHO4h2ID
         Bj+OjmlMFSmKKxD677walC7fQU4jKnrnZpj1DbiKPN1Kgjt/9NtnDE3Ixjo7iUE3yzTR
         t22iRloNSnZYVUuGuXA3OHPAHOBmuijvYuk9Q7bmRPqCFj+KRfWAgXl3ggbq2CyPNV35
         1QCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=XguIW4rHJNt/TImQ6cvBiMAUzdPq8NqreQcGI3yGJBU=;
        b=Hja76k7JuCPcZ1/pRkXfBY9MDU1VybXnJgw2Na02zV12LZR2Hkaz21jGHLnUN9EOQ+
         SvADfkcblbJZKTbdVYchP+6q7HfeZMZRlaEJO9hyztnC3sPObRIYqC1UgQpBn3D8QTjs
         WrI6MsBWqSt6UbRlHmdZ40aiZf9GjsHM1ggM75Dtw/bCSA1VoewrGHl+FL0j4MzQ7Ntr
         /ntix9vwolj1n3MDI+UAlQsIbxaUffjQxHLuFL6I+LU1rLuslSuW/t1mhTrHssCXQqP4
         6FVS+thDuWLnPeZg2gEifdPCNwSl7XyF6dVqYm2XMyG56CW4nXRlZqG1tTlxRqCwc/+B
         ZARg==
X-Gm-Message-State: AMke39mP4CIvfwiLCjFe0nE9vLLPkYx100X+mLhIWiytp69QrdGITQD4JdX3u+BthxSLbpYS
X-Received: by 10.99.123.75 with SMTP id k11mr15797590pgn.17.1489090715672;
        Thu, 09 Mar 2017 12:18:35 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:bdfe:9271:5e21:646a])
        by smtp.gmail.com with ESMTPSA id u75sm14158527pfk.3.2017.03.09.12.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Mar 2017 12:18:34 -0800 (PST)
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
To:     git@jeffhostetler.com, git@vger.kernel.org
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
Cc:     jeffhost@microsoft.com, peff@peff.net, gitster@pobox.com,
        markbt@efaref.net, benpeart@microsoft.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <9ef37430-17be-dfc2-bca5-e4e33bc68df8@google.com>
Date:   Thu, 9 Mar 2017 12:18:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overall, this fetch/clone approach seems reasonable to me, except 
perhaps some unanswered questions (some of which are also being 
discussed elsewhere):
  - does the server need to tell us of missing blobs?
  - if yes, does the server need to tell us their file sizes?
  - do we need to store the list of missing blobs somewhere (whether the
    server told it to us or whether we inferred it from the fetched
    trees)

The answers to this probably depend on the answers in "B. Issues 
Backfilling Omitted Blobs" (especially the additional concepts I listed 
below).

Also, do you have any plans to implement other functionality, e.g. "git 
checkout" (which will allow fetches and clones to repositories with a 
working directory)? (I don't know what the mailing list consensus would 
be for the "acceptance criteria" for this patch set, but I would at 
least include "checkout".)

On 03/08/2017 10:50 AM, git@jeffhostetler.com wrote:
> B. Issues Backfilling Omitted Blobs
> ===================================
>
> Ideally, if the client only does "--partial-by-profile" fetches, it
> should not need to fetch individual missing blobs, but we have to allow
> for it to handle the other commands and other unexpected issues.
>
> There are 3 orthogonal concepts here:  when, how and where?

Another concept is "how to determine if a blob is really omitted" - do 
we store a list somewhere or do we assume that all missing blobs are 
purposely omitted (like in this patch set)?

Yet another concept is "whether to fetch" - for example, a checkout 
should almost certainly fetch, but a rev-list used by a connectivity 
check (like in patch 6 of this set) should not.

For example, for historical-blob-searching commands like "git log -S", 
should we:
  a) fetch everything missing (so users should use date-limiting
     arguments)
  b) fetch nothing missing
  c) use the file size to automatically exclude big files, but fetch
     everything else

For a) and b), we wouldn't need file size information for missing blobs, 
but for c), we do. This might determine if we need file size information 
in the fetch-pack/upload-pack protocol.

> C. New Blob-Fetch Protocol (2a)
> ===============================
>
> *TODO* A new pair of commands, such as fetch-blob-pack and upload-blob-pack,
> will be created to let the client request a batch of blobs and receive a
> packfile.  A protocol similar to the fetch-pack/upload-pack will be spoken
> between them.  (This avoids complicating the existing protocol and the work
> of enumerating the refs.)  Upload-blob-pack will use pack-objects to build
> the packfile.
>
> It is also more efficient than requesting a single blob at a time using
> the existing fetch-pack/upload-pack mechanism (with the various allow
> unreachable options).
>
> *TODO* The new request protocol will be defined in the patch series.
> It will include: a list of the desired blob SHAs.  Possibly also the commit
> SHA, branch name, and pathname of each blob (or whatever is necessary to let
> the server address the reachability concerns).  Possibly also the last
> known SHA for each blob to allow for deltafication in the packfile.

Context (like the commit SHA-1) would help in reachability checks, but 
I'm not sure if we can rely on that. It is true that I can't think of a 
way that the client would dissociate a blob that is missing from its 
tree or commit (because it would first need to "fault-in" that blob to 
do its operation). But clients operating on non-contextual SHA-1s (e.g. 
"git cat-file") and servers manipulating commits (so that the commit 
SHA-1 that the client had in its context is no longer reachable) are not 
uncommon, I think.

Having said that, it might be useful to include the context in the 
protocol anyway as an optional "hint".

I'm not sure what you mean by "last known SHA for each blob".

(If we do store the file size of a blob somewhere, we could also store 
some context there. I'm not sure how useful this is, though.)

> E. Unresolved Thoughts
> ======================

<snip>

> *TODO* The partial clone arguments should be recorded in ".git/info/"
> so that subsequent fetch commands can inherit them and rev-list/index-pack
> know to not complain by default.
>
> *TODO* Update GC like rev-list to not complain when there are missing blobs.

These 2 points would be part of "whether to fetch" above.
