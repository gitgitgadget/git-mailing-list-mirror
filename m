Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408E51F404
	for <e@80x24.org>; Mon, 12 Mar 2018 18:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932624AbeCLSTf (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 14:19:35 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:46977 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932326AbeCLSTe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 14:19:34 -0400
Received: by mail-ua0-f171.google.com with SMTP id d1so7427347ual.13
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 11:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Bd1HlOsMlS34nOlAJ9XuBGPIrVKUgG9BwGeBKo/5lOU=;
        b=kF9qqe4VWj/9ooR42u7nh6CIYA2kSJaDQfKtvDyCGkOilJiIRKq7zAP2hEIujm9ClM
         w8xrmYlGJxUOTTdXchNEOIrFMmOqeJjltXYenZ9cEh8D6/5JUNpoYnQx48vu+LfWAYuU
         ut04XsX7vcPUBI1NFKRs4RiAcN+AQ4xsarrwO3jX5czvwqO7Kpt6ugICUj82xdzoPOIh
         kROVrxb4HZtll3YvODYyMUlQaWpzVvH3mg2D3Q1bGqM2l1JBgPBEJMcedFO1tOWv1dcd
         CMAeS2xsJzoQEKz4z75pgfO/gNtcehZO9RLQwOUxGYl+NdYy93gyp9rGV2MQgA5j+SZ7
         uvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Bd1HlOsMlS34nOlAJ9XuBGPIrVKUgG9BwGeBKo/5lOU=;
        b=uhmAqspJQlceDk5c524axZRwmxd31P1sNr4fW0SqK/NvYudWCiQuQZMEH0N01u1fhH
         rC0SlQ9P4wyne/j3mI/VxLN74FuYh0iMAuFahF+BnCnydRIrF5YH8Y9jkkCMyPv0bdde
         s4QgUv8o5abHybhxcX5SCeLocxt8FIBCk3H3ujuqm/c+q9vALhq/sfs1d1YQdVDY7tNC
         ifAexF6tomqE89TD5IWv+tfFxHKepCOsneNT4Ir7WrkUUwvtjpPjDNtYrA8Bj2nQjZZw
         1LdtE3s2jh0xaF0mK8oirci+W4N8ML0286dC2zguenaf92RME6CvWmRV4jhaqZxUbcP8
         HkNw==
X-Gm-Message-State: AElRT7E2AQZyVj1sdUOm8P7451FJextoY4/Xb79KL/VIWF9cg3jEC1Sa
        gz4LVtzweCCsA/6WlLUFUYeJ5LcSK3/B/1mpAoA=
X-Google-Smtp-Source: AG47ELvhJbMu/8ixUV3gcS7LK/FtAuvJJW04f/TxB8RsIUHb1mVrtpZGWYroJhsSOy0zN/59ZJC5sDQIFriGWjrSm2A=
X-Received: by 10.159.63.11 with SMTP id h11mr6570234uaj.94.1520878773442;
 Mon, 12 Mar 2018 11:19:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.1.49 with HTTP; Mon, 12 Mar 2018 11:19:32 -0700 (PDT)
In-Reply-To: <20180305171125.22331-1-newren@gmail.com>
References: <20180305171125.22331-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Mar 2018 11:19:32 -0700
Message-ID: <CABPp-BHh9byDtdr=HcUTY17dqnjd4V=My_xTH0jzLUv4bfWf5w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Improve path collision conflict resolutions
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 5, 2018 at 9:11 AM, Elijah Newren <newren@gmail.com> wrote:

>   2) Doing content merges for a rename before looking at the path collision
>      between a rename and some other file.  In particular (in what I most
>      suspect others might have an objection to from this series), record
>      that content-merged file -- which may have conflict markers -- in the
>      index at the appropriate higher stage.
>
> 2)
>
> Previously, rename/rename(2to1) conflict resolution for the colliding path
> would just accept the index changes made by unpack_trees(), meaning that
> each of the higher order stages in the index for the path collision would
> implicitly ignore any changes to each renamed file from the other side of
> history.  Since, as noted above, all traces of the rename-source path were
> removed from both the index and the working tree, this meant that the index
> was missing information about changes to such files.  If the user tried to
> resolve the conflict using the index rather than the working copy, they
> would end up with a silent loss of changes.
>
> I "fixed" this by doing the three-way content merge for each renamed-file,
> and then recorded THAT in the index at either stage 2 or 3 as appropriate.
> Since that merge might have conflict markers, that could mean recording in
> the index a file with conflict markers as though it were a given side.
> (See patch 2 for a more detailed explanation.)  I figure this might be the
> most controversial change I made.  I can think of a few alternatives, but I
> liked all of them less.  Opinions?

Actually, I realized this last weekend that this wasn't unprecedented
after all, and thus likely not at all controversial.  In particular,
there is already a case where git stores the sha1 of a file with
conflict markers from a "provisional content merge" at a non-zero
stage in the index: If a recursive merge is needed and there is a file
with content conflicts when creating the virtual merge base, then the
file with all the conflict markers will be accepted as part of the
virtual merge base and, depending on how the outer merge goes, the
sha1 of this file with conflict markers can appear in the index at
stage 1.

So, that really only leaves the changes to the working tree files.
And based on a few factors including things mentioned in the cover
letter, I suspect most would only have an opinion about how this patch
series affects add/add conflicts.  I'll send a separate email to ask
about that, to make it clear I want folks opinions on that issue even
if they don't have enough time to review the patch series or even read
my really long cover letter.
