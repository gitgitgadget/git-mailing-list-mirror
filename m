Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F57A1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932980AbeGIUHy (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:07:54 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:35648 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932764AbeGIUHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:07:53 -0400
Received: by mail-vk0-f73.google.com with SMTP id x125-v6so5534574vke.2
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=coYIv1QDs2d4c2wLsoT++bYF9Ev3QdRJ2xc4Zugj/qE=;
        b=vv35zakypfPvbj68Lk+ToOvOUT2bCoCVviUs5f4fWqA2l7KfuTfYl3K8Zkyi+vx/gq
         SkOAjW9ThKl65yqNPiUbH/wfcXpKt7v0mGFMWZxx/ReexsFJuO2JrBwPGh3qwzQ1MUhr
         is9E2JOPY/LHnsqfy8SwY8BRwOs0pPyvYwHASZn5VJN/y1Aok6wVCRag7JeMSrihE8Zd
         HX1wJI+2wmFHKwYgCxH1GEIj+yoopViyO6NSx+CPmMncLZ+WYVe9flyIH6w+SniZAEoA
         dEY63zsQQWD/dKb8aziVHndvmqoGY820yhKJyeF38tjNKehk//+T5vnrpKl67q1zfPBP
         hA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=coYIv1QDs2d4c2wLsoT++bYF9Ev3QdRJ2xc4Zugj/qE=;
        b=lTVPtThueZRtcsAhSKANJ8Mrj/iC+GnzNcNn6UKg4SCdMvPO2fXpXgpX1P8JPCDf/s
         FWcU7dfj7lpRFmghBthZxG9j3ojvHD2qE9M3vxwiHnmVzIHepJ+r2pk5XdA6Ao+Psjv5
         V4LRA9/vTcgB3Z7BFO18kLrjnt4bUkIbxdT+oSR2KwnTbeX2k5QpxzwIW+NXxDvYR4/A
         rYLh34xYMMNpALGUWvrIh2rgNEUVnVoABOFH6N3WVXBjlh45ALmiuyZwpxV2eEsQz0JZ
         C7iKaXJhB+lALBriAhqjvD87j3B1cRRVMqA7VJyBUps7II6qx/uyiKObEjiupHe6d+5O
         6mqw==
X-Gm-Message-State: APt69E3vbQhkQpeNFfz3vmocWU85hm92Zci15wBbhYA3UHuGmKYu4qRA
        VlYqrAQ4fy3iMzgLS10Hcmh//TJ6W7TVFRbQQ6XP
X-Google-Smtp-Source: AAOMgpfeM/BrcpFDFThL6Y9MOe48WzQV/835XCaKso3HG9jWCH+DirzfzWBmDO/cq/zrxxNmqCZ+/RL68ksbvl4UnICn
MIME-Version: 1.0
X-Received: by 2002:a1f:8515:: with SMTP id h21-v6mr10086911vkd.90.1531166872487;
 Mon, 09 Jul 2018 13:07:52 -0700 (PDT)
Date:   Mon,  9 Jul 2018 13:07:49 -0700
In-Reply-To: <xmqqy3ekcihe.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180709200749.190861-1-jonathantanmy@google.com>
References: <xmqqy3ekcihe.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: Re: [PATCH 0/2] Avoiding errors when partial cloning a tagged blob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org,
        git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > An argument could be made that we should not merge patch 2 just yet due
> > to the fact that some server implementations (such as Git and JGit)
> > still exhibit the old behavior, and the resulting clones (albeit failing
> > fsck) are still usable, because when attempting to load the blob, Git
> > will automatically fetch it. I'm on the fence about this, and have
> > included patch 2 in this patch set nevertheless for completeness.
> 
> I think the latter is probably a good thing to nudge the server
> implementations in the right direction by gently poking them ;-)

OK, I'll keep patch 2 then.

> The patches textually apply cleanly on 'master' but apparently it
> needs some fixes in jt/partial-clone-fsck-connectivity topic to
> function correctly?

I forgot to mention in the original e-mail that this is on
bw/ref-in-want. (I mentioned it in an e-mail I sent later [1].) I've
checked and basing it on both bw/ref-in-want and
jt/partial-clone-fsck-connectivity (which is based on bw/ref-in-want
itself) both work, so you can choose either one.

[1] https://public-inbox.org/git/20180706193847.160161-1-jonathantanmy@google.com/
