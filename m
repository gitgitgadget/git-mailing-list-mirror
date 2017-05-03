Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76DA01F829
	for <e@80x24.org>; Wed,  3 May 2017 18:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752742AbdECS1b (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 14:27:31 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32984 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbdECS13 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 14:27:29 -0400
Received: by mail-pf0-f194.google.com with SMTP id b23so5372727pfc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7ui0Eizif4FNRdHxFAjyPdi4b47WA8a7AIRvz643TXM=;
        b=Q1I8k9Ed6HIF1VU64EK733ybBIZ4YmGQDe/DCE7nuNsxtIKFmuCAYTe7jGGev1ZeKM
         rQMGVJz7x/3s9UmXUtyKg1+fRbrsw3dARTV+I3A/BtR1bKnOWVghYvdMM3s2qvotZbSU
         9j3Qup8HtOitZL5RlNaXYxnEAJ/keNn0tU3btmDcvKVHx0lEE7ErYAEzQmcDtDb6+keM
         PANPJc3pDBo+Z+MP9TizBHfwaqZOLNz1C73W1l7ppU5PPZIEZf4tkMI5hTW1SLHFKY/H
         akgseE9SvL8eikxuK+kxDhZWBEwkJGRQmTgiOQlPd7QHrijDUFDzIkltJzyrhN0VYfCD
         cS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7ui0Eizif4FNRdHxFAjyPdi4b47WA8a7AIRvz643TXM=;
        b=WpvpP0RbDIVnRmw5/GV1PhGIeb9fGbayt7Lx3IxkDb/s2++Cs0DM1ya92gazk5cMl8
         uQQy7LYFFnq0+PVAqK/jNGRy78zpzBYLJcvGRGLv+/WcWd5LuQ9pamsFtTZ8CY7l/8IQ
         03COua8UmAQ4OcE1ERXIQIBZkqdpzTdEtZyYoHgl/2smw13P8HeNnjAEeUe8J5dRnq9w
         ZWw8FLiub8lq3ZgnafoUsNvsiDll2AcR8zqamqoLMoSbVUJJjVhUiGVQVSiPyY2ZrX61
         /HbMOkht7vvN3WkhN+l6QeXY+aLMhTweRPKQWeFkkLCLCpakAy63nFC/glDAP0e1iCDU
         r45w==
X-Gm-Message-State: AN3rC/7UF8SX7NU/A2+z5C/zPQczEbmX3xktNNDw8+aspdSLcWb09vE9
        FUxD80OYF8FyRw==
X-Received: by 10.98.66.82 with SMTP id p79mr6419223pfa.146.1493836048696;
        Wed, 03 May 2017 11:27:28 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:8ce6:bd0b:35b6:826c])
        by smtp.gmail.com with ESMTPSA id m89sm7129700pfk.110.2017.05.03.11.27.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 11:27:28 -0700 (PDT)
Date:   Wed, 3 May 2017 11:27:26 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, peff@peff.net,
        gitster@pobox.com, markbt@efaref.net, benpeart@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH 00/10] RFC Partial Clone and Fetch
Message-ID: <20170503182725.GC28740@aiede.svl.corp.google.com>
References: <1488999039-37631-1-git-send-email-git@jeffhostetler.com>
 <777ab8f2-c31a-d07b-ffe3-f8333f408ea1@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777ab8f2-c31a-d07b-ffe3-f8333f408ea1@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff Hostetler wrote:
> On 3/8/2017 1:50 PM, git@jeffhostetler.com wrote:

>> [RFC] Partial Clone and Fetch
>> =============================
>> [...]
>> E. Unresolved Thoughts
>> ======================
>>
>> *TODO* The server should optionally return (in a side-band?) a list
>> of the blobs that it omitted from the packfile (and possibly the sizes
>> or sha1_object_info() data for them) during the fetch-pack/upload-pack
>> operation.  This would allow the client to distinguish from invalid
>> SHAs and missing ones.  Size information would allow the client to
>> maybe choose between various servers.
>
> Since I first posted this, Jonathan Tan has started a related
> discussion on missing blob support.
> https://public-inbox.org/git/CAGf8dgK05+f4uX-8+iMFvQd0n2JP6YxJ18ag8uDaEH6qc6SgVQ@mail.gmail.com/T/
>
> I want to respond to both of these threads here.

Thanks much for this.

> Missing-Blob Support
> ====================
>
> Let me offer up an alternative idea for representing
> missing blobs.  This is differs from both of our previous
> proposals.  (I don't have any code for this new proposal,
> I just want to think out loud a bit and see if this is a
> direction worth pursuing -- or a complete non-starter.)
>
> Both proposals talk about detecting and adapting to a missing
> blob and ways to recover -- when we fail to find a blob.
> Comments on the thread asked about:
> () being able to detect missing blobs vs corrupt repos
> () being unable to detect duplicate blobs
> () expense of blob search.
>
> Suppose we store "positive" information about missing blobs?
> This would let us know that a blob is intentionally missing
> and possibly some meta-data about it.

We've discussed this a little informally but didn't go more into
it, so I'm glad you brought it up.

There are two use cases I care about.  I'll want names to refer to
them later, so describing them now:

 A. A p4 or svn style "monorepo" containing all code within a company.
    We want to make git scale well when working with such a
    repository.  Disk usage, network usage, index size, and object
    lookup time are all issues for such a repository.

    A repository can creep up in size so it starts falling into this
    category even though git coped well with it before.  Another way
    to end up in this category is a conversion from a version control
    system like p4 or svn.

 B. A more modestly sized repository with some large blobs in it.  At
    clone time we want to omit unneeded large blobs to speed up the
    clone, save disk space, and save bandwidth.

    For this kind of repository, the idx file already contained all
    those blobs and that was not causing problems --- the only problem
    was the actual blob size.

> 1. Suppose we update the .pack file format slightly.
[...]
> 2. Make a similar change in the .idx format and git-index-pack
>    to include them there.  Then blob lookup operations could
>    definitively determine that a blob exists and is just not
>    present locally.

Some nits:

- there shouldn't be any need for the blobs to even be mentioned in
  the .pack stored locally.  The .idx file maps from sha1 to offset
  within the packfile --- a special offset could mean "this is a
  missing blob".

- Git protocol works by sending pack files over the wire.  The idx
  file is not transmitted to the client --- the client instead
  reconstructs it from the pack file.  I assume this is why you
  stored the SHA-1 of the object in the pack file, but it could
  equally well be sent through another stream (since this proposal
  involves a change to git protocol anyway).

- However, the list of missing blobs can be inferred from the existing
  pack format, without a change to the pack format used in git
  protocol.  As part of constructing the idx, "git index-pack"
  inflates every object in the pack file sent by the server.  This
  means we know what blobs they reference, so we can easily produce a
  list for the idx file without changing the pack file format.

If this is done by only changing the idx file format and not the pack
file, then it does not affect the protocol.  That is good for
experimentation --- it lets us try out different formats client-side
without having to coordinate with server authors.

In case (A), this proposal means we get back some of the per-object
overhead that we were trying to avoid.  I would like to avoid that
if possible.

In case (B), this proposal doesn't hurt.

One problem with proposals so far has been how to handle repositories
with multiple remotes.  Having a local list of missing blobs is
convenient because it can be associated to the remote --- when a blob
is referenced later, we know which remote to ask for for it.  This is
a niche feature, but it's a nice bonus.

[...]
> 3. With this, packfile-based blob-lookup operations can get a
>    "missing-blob" result.
>    () It should be possible to short-cut searching in other
>       packfiles (because we don't have to assume that the blob
>       was just misplaced in another packfile).
>    () Lookup can still look for the corresponding loose blob
>       (in case a previous lookup already "faulted it in").

The number of packfiles to search is always a problem for object
lookups --- we need to be able to keep the number of packfiles low.
If we solve that for missing blobs but not for the ones that are
present, then git's object access performance is still slow.

I have some ideas for improving git's gc behavior to bound the number
of packfiles better.  I think that's mostly orthogonal to this
proposal.  The main point of overlap is the number of packfiles
produced if someone uses one packfile per large blob, but that is bad
for the performance in successful lookups, not just negative lookups,
so it needs to be solved directly anyway.

> 4. We can then think about dynamically fetching it.

This also seems orthogonal to whether the missing blobs list exists.

[...]
> A missing-blob entry needs to contain the SHA-1 value of
> the blob (obviously).  Other fields are nice to have, but
> are not necessary.  Here are a few fields to consider.
[...]
> B. The raw size of the blob (5? bytes).

This would be a very nice thing.

If we were starting over, would this belong in the tree object?
(Part of the reason I ask is that we have an opportunity to sort
of start over as part of the transition away from SHA-1.)

[...]
> C. A server "hint" (20 bytes)
>    () Instructions to help the client fetch the blob.
>    () If I have multiple remotes configured, a missing-blob
>       should be fetched from the same server that created
>       the missing-blob entry (since it may be the only
>       one that has it).

I am worried about the implications of storing this kind of policy
information in the pack file.  There may be useful information along
these lines for a server to advertise, but I don't think it belongs in
the pack file.  Git protocol relies on it being cheap to stream pack
files as is.

[...]
> Combining the ideas here with the partial clone/fetch
> parameters and the various blob back-filling proposals
> gives us the ability to create and work with sparse
> repos.
> () Filtering can be based upon blob size; this could be
>    seen as an alternative solution to LFS for repos with
>    large objects.
> () Filtering could also be based upon pathnames (such as
>    a sparse-checkout filter) and greatly help performance
>    on very large repos where developers only work with
>    small areas of the tree.

To summarize my thoughts:

+ It is possible to construct a list of blobs missing from the
  packfile sent by the server, without changing the protocol.
  This is a very good thing, since it makes local experimentation
  possible.

- Except in the multiple-remotes case, I am mostly unconvinced about
  the benefit of having the list of missing blobs around locally.
  For example:

  - "git fsck" can use the list of missing blobs to see whether a
    reachable missing blob is intentional or a violation of the
    repository's integrity.  I don't think this is useful.  In a
    partial clone repository, missing blobs are always permitted
    and do not indicate repository corruption, since git operations
    have a way of coping with them (by fetching them on demand using
    read-blob protocol).
 - In a partial clone repository that is acting as a server, the
   list of missing blobs can be used to deny a read-blob request
   without passing the request on to "origin".  Without this
   check, such checks could be a DoS vector.  Since there are other,
   simpler requests that have the potential to DoS "origin" (e.g.
   using plain clone --mirror) in such a setup, I think it best to
   disallow read-blob requests to partial clone repositories
   altogether for now.

- I am also unconvinced about the server hint.

+ Having the list of missing blob sizes locally seems very useful.  I
  can imagine a client that wants this information for some blobs but
  not all --- e.g. they are only interested in a particular
  subdirectory so they want blob sizes from that directory.

The blob-size use case is compelling, but I still lean toward
constructing the list of blobs locally for now where it's useful,
instead of adding a missing-blob entry to the pack file.

I'll think more about blob sizes.  I agree that we need to do
something to handle them.

Thanks and hope that helps,
Jonathan
