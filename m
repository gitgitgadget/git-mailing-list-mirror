Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69AF91F403
	for <e@80x24.org>; Sun, 10 Jun 2018 01:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbeFJBbT (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 21:31:19 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:46415 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753548AbeFJBbR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 21:31:17 -0400
Received: by mail-ua0-f194.google.com with SMTP id e8-v6so11313626uam.13
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 18:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4/DI7wFGGSH+UEAP9L0wmOfv3y8FRjT+hFXBJOcr70A=;
        b=bssAKM2cgu3CGlbXNQXLZ8gTdIN1IAsH4BIMtCjrf7mmU1KaTb7gW8zbf3geP5Rrho
         D30+Km0rTi4OJ8fqYme6nxXLQEvTF6SF/anPS8iTBjy0TGSf790cu3amk3Z6g7kHrMnF
         QZuF7UOqyFduYs9UAYp/N4gXblTJX9JabzY9UAY1fnjbxkYE7/dOEt/5XDr/oAGBj17h
         EYcT92MXqE+luJZiY3FPv3F1NZNdLnYykuB4Dgw4wE+walivPelhg2s4NdSlmOklGCiF
         vIYM0Nyvn/dULw5v6FBBEUrn61CylNLtWDTSRYHxRdq/90XjvIuLaTp415S/MdCotUKK
         vEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4/DI7wFGGSH+UEAP9L0wmOfv3y8FRjT+hFXBJOcr70A=;
        b=qJaCSRgxSUROOAaCg1ODfdxWmrTyT1/cqTRm7ZHBABiK29bW3S7kj81PH20LzWoZTE
         qz5h8xhNu3psEm8aA+lNo85aSMyFsblIM9p7hArZxvqzeThcX9HMxcXEGROV4SPt/HnX
         WNvk8ANwZFrnaF7JGiBXIcpJvpC0RxfRAWfys4KoccqClDGdarOtpmh3bZBEk3e5DAEv
         YCzbhdY60GKdnrSYw2SNMdlSJpTwnljRyU5Bl3zko6+aaJzSi2hNAbPPhu6B66ggmPot
         uO3HpuP2b0U1snXi0t8/24FspF8Pcxp8Z6kE4IwAtjS7nWVYlEMe8ynB0Ja86gI80Lzz
         iU/w==
X-Gm-Message-State: APt69E0cex5CV22YRGHsrIcdkv1iZxZjUFOSKEkR001xYQGAJavlApDv
        7xEekhvurLlbIa8ZFu8TSnNl6z0Z47pxhasD/8EfJA==
X-Google-Smtp-Source: ADUXVKI5MbHqKdV1D+mm+WJCg4GS8QjJFJ+lVOPOkArHmWycDOAFKMRtLY+sGxCJd4FZLCL/mryIAGKjqZ4ivYxeXVY=
X-Received: by 2002:ab0:5e83:: with SMTP id y3-v6mr8079715uag.112.1528594276601;
 Sat, 09 Jun 2018 18:31:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 18:31:16 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1806100006000.77@tvgsbejvaqbjf.bet>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com>
 <20180607171344.23331-1-newren@gmail.com> <20180607171344.23331-4-newren@gmail.com>
 <nycvar.QRO.7.76.6.1806100006000.77@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Jun 2018 18:31:16 -0700
Message-ID: <CABPp-BHa+sxuFBa3EmSyio28ytF_ORn950Keh1P=L-VxXtOwMw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] git-rebase.sh: make git-rebase--interactive the default
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Sat, Jun 9, 2018 at 3:11 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 7 Jun 2018, Elijah Newren wrote:
>
>> am-based rebases suffer from an reduced ability to detect directory
>> renames upstream, which is fundamental to the fact that it throws away
>> information about the history: in particular, it dispenses with the
>> original commits involved by turning them into patches, and without the
>> knowledge of the original commits we cannot determine a proper merge base.
>>
>> The am-based rebase will proceed by first trying git-apply, and, only if
>> it fails, will try to reconstruct a provisional merge base using
>> build_fake_ancestor().  This fake ancestor will ONLY contain the files
>> modified in the patch; without the full list of files in the real merge
>> base, renames of any missing files cannot be detected.  Directory rename
>> detection works by looking at individual file renames and deducing when a
>> full directory has been renamed.
>>
>> Trying to modify build_fake_ancestor() to instead create a merge base that
>> includes common file information by looking for a commit that contained
>> all the same blobs as the pre-image of the patch would require a very
>> expensive search through history, may find the wrong commit, and outside
>> of rebase may not find any commit that matches.
>>
>> But we had all the relevant information to start.  So, instead of
>> attempting to fix am which just doesn't have the relevant information,
>> instead note its strength and weaknesses, and change the default rebase
>> machinery to interactive since it does not suffer from the same problems.
>
> I'll let Eric comment on the grammar, and I'll comment on the idea behind
> this commit instead.

Going to dump the hard job on Eric, eh?  ;-)

> IMHO `git rebase -i` is still too slow to be a true replacement for `git
> rebase --am` for the cases where it serves the user well. Maybe we should
> work on making `rebase -i` faster, first?

That sounds fair.

> I imagine, for example, that it might make *tons* of sense to avoid
> writing out the index and worktree files all the time. That was necessary
> in the shell script version because if the ridiculous limitations we
> subjected ourselves to, such as: no object-oriented state worth
> mentioning, only string-based processing, etc. But we could now start to
> do everything in memory (*maybe* write out the new blob/tree/commit
> objects immediately, but maybe not) until the time when we either have
> succeeded in the rebase, or when there was a problem and we have to exit
> with an error. And only then write the files and the index.

Hmm...are you still planning on using cherry-pick (internally rather
than forking, of course)?  Because cherry-pick uses the
merge-recursive machinery, and the merge-recursive machinery doesn't
have a nice way of avoiding writing to the working tree or index.
Fixing that is on my radar; see the first block of
https://public-inbox.org/git/CABPp-BG2fZHm3s-yrzxyGj3Eh+O7_LHLz5pgstHhG2drigSyRA@mail.gmail.com/
(reading up until "At this point, I'd rather just fix the design flaw
rather than complicate the code further.")

However, also covered in my plans is a few things to speed up the
merge-recursive machinery, which should provide some other performance
benefits for interactive rebases.

> In any case, I think that the rather noticeable change of the default
> would probably necessitate a deprecation phase.

Why is it a "rather noticable change of the default"?  If we popped up
the editor and asked the user to edit the list of options, I'd agree,
or if folks thought that it was significantly slower by a big enough
margin (though you already suggested waiting and making sure we don't
do that).  What else remains that qualifies?

(Okay, the default behavior to just skip empty patches rather than
halt the rebase and ask the user to advise is different, but we could
fix that up too.  Is there anything else?)
