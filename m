Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A0120281
	for <e@80x24.org>; Mon,  2 Oct 2017 19:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbdJBTTB (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 15:19:01 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:55090 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbdJBTTA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 15:19:00 -0400
Received: by mail-qt0-f182.google.com with SMTP id i13so8839880qtc.11
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 12:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ru0CshZmXasDsG1mwjD7LWRmtOOGsS1lp8Tnww7qfT8=;
        b=u/yQhuXH6bIhSrYNTgjpCZSlS+PM7c3bFIVC4NKIb2H6pZ4vh4YEL2lC03AwNM2oyL
         Qwtby/hQ7kG/CtMQmgKyNKJ2uYfQUzqjk16PWoS5Q15MOKz7nUZxqXf9Vf/3C9T1spn1
         klDN5BXtHz+MjHq7LLK+wFGB2hMj/WREiU0ZD9Egnaqv/g1Mzfqd7Lm4mcL5SvkHbmU5
         b0EIRHrFZ+uVuU+He/+NT4w/CiRtS4R/ijdl23IRH/PIWIotMPsBqufwwO+AiElSOTDz
         ngOy5mrfBOhi0G+YmZVyNVrQAruYcJCG/bXAJMWZU4VE3rvcEaE34SZYgQ28zqHNlOOJ
         QUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ru0CshZmXasDsG1mwjD7LWRmtOOGsS1lp8Tnww7qfT8=;
        b=NneigXFGVlYuOs21mc+TCgL4BSLhlvWeZNz5xkEpEQF+Zr9LRSFezYNfOkPlKyoNDS
         tLK6aQy7Zzj+t7juGKigkcL3V1IuSfnoEwCVJy8SVgVPDVEFgbT6WGEvIj82q2SjVzWl
         Eebu3C6p/rs+PAQsfYYW4aXf5bkR2DhB7/yZQdRTw0CYCSguGLIv6KQH0fqTrxuzvzjv
         dUO+EKNqjt6A9mLAhZTMFl1wV1Pfl9bxuRIZhWrd1BJLHiCHmsQA0x+OrqUkw35B6cv7
         enDhBawTkVhaX2AJscfy3/b6u3Kgx3ZDc42JX49YLerXZY6yY2X+LpBHJJzBTnEbqctH
         gYXA==
X-Gm-Message-State: AMCzsaUBafyVOYbWDkwR2r51xKRQMiP7zhzIP1UI25MczEuli9Q1b704
        wLoifBeP9+P/YxsyO0R3KtloHcXez5KcjLqb9evN7w==
X-Google-Smtp-Source: AOwi7QDnNBpDeiSHLQjAR9W8okmQ7YzdU3EUwVJtQtSEsZdFpK1WsNktLuwKMVx7Lh4iKeOESWlPJux37VpYbcrhPL0=
X-Received: by 10.200.17.23 with SMTP id c23mr7785182qtj.198.1506971939699;
 Mon, 02 Oct 2017 12:18:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 2 Oct 2017 12:18:59 -0700 (PDT)
In-Reply-To: <ea1538e3-2b2e-f7eb-9c0e-e29c15bf2ea9@jeffhostetler.com>
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
 <E8C827ED458648F78F263F2F2712493B@PhilipOakley> <alpine.DEB.2.21.1.1709131322470.4132@virtualbox>
 <04DDB36236444FFD8C3668AA7B62B154@PhilipOakley> <alpine.DEB.2.21.1.1709300110350.40514@virtualbox>
 <5fb263a8-d83b-64a7-812f-fd8e3748feb6@jeffhostetler.com> <xmqqtvzjv987.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbghnWmvQweup=Z79HnVQQCMM65CKgEO3oqDoRp-Bj=2Q@mail.gmail.com> <ea1538e3-2b2e-f7eb-9c0e-e29c15bf2ea9@jeffhostetler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Oct 2017 12:18:59 -0700
Message-ID: <CAGZ79kbjfXC3CxMDouUrCUVt-OJXckDtg9U_7=R=FM-eon4ikA@mail.gmail.com>
Subject: Re: [idea] File history tracking hints
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.org>,
        Pavel Kretov <firegurafiku@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 2, 2017 at 11:51 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:

> Sorry to re-re-...-re-stir up such an old topic.
>
> I wasn't really thinking about commit-to-commit hints.
> I think these have lots of problems.  (If commit A->B does
> "t/* -> tests/*" and commit B->C does "test/*.c -> xyx/*",
> then you need a way to compute a transitive closure to see
> the net-net hints for A->C.  I think that quickly spirals
> out of control.)

I agree. Though as a human I can still look at
A..C giving the hint that t/*.c and xyz/*.c ought to
be taken into account for rename detection.
(which is currently done with -M -C --find-copies-harder
as a generic "there are renamed things", and not the very
specific rule, that may be cheaper to examine compared to
these generic rules)

> No, I was going in another direction.  For example, if a
> tree-entry contains { file-guid, file-name, file-sha, ... }
> then when diffing any 2 commits, you can match up files
> (and folders) by their guids.  Renames pop out trivially when
> their file-names don't match.  File moves pop out when the
> file-guids appear in different trees.  Adds and deletes pop
> out when file-guids don't have a peer. (I'm glossing over some
> of the details, but you get the idea.)

How do you know when a guid needs adaption?

(c.f. origin/jt/packmigrate)
If a commit moves a function out of a file into a new file,
the ideal version control could notice that the function
was moved into a new file and still attribute the original
authors by ignoring the move commit.

Another series in flight could have modified that
function slightly (fixed a bug), such that it's hard to
reason about these things.

For guids I imagine the new file gets a new guid, such that
tracking the function becomes harder?


> To address Junio's
> question, independently added files with the same name will
> have 2 different file-guids.  We amend the merge rules to
> handle this case and pick one of them (say, the one that
> is sorts less than the other) as the winner and go on.
> All-in-all the solution is not trivial (as there are a few
> edge cases to deal with), but it better matches the (casual)
> user's perception of what happened to their tree over time.

The GUID would be made up at creation time, I assume?
Is there any input other than the file itself? (I assumed so
initially, such that:
  By having a GUID in the tree, we would divorce from the notion
  of a "content addressable file system" quickly, as we both could
  create the same tree locally (containing the same blobs) and
  yet the trees would have different names due to having different
  GUIDs in them
), which I'd find undesirable.

> It also doesn't require expensive code to sniff for renames
> on every command (which doesn't scale on really large repos).

I wonder if the rename detection could be offloaded to a server
(which scales) that provides a "hint file" to clients, such that the
clients can then cheaply make use of these specific hints.
