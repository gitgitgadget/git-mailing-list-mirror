Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA2A1F424
	for <e@80x24.org>; Thu, 26 Apr 2018 06:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeDZGGm (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 02:06:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36898 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbeDZGGk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 02:06:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id l16so10790664wmh.2
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 23:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4SLPXvAJvU5TXdrlVj1eJaUEbTlJwuw9LrZnat9H4sc=;
        b=ijm1hkVY0dPWO6lUZgHtIvfHbs1Orl4EPLauYQ51nMhwadHFSKzYcDQy3XlCUGgl2y
         ZZTTG6c323eDej7dMH5j7Ljjm1nfik+fzAAfRK3wV/zOxppZWHEu0DDMTohL4KMA3iRH
         cFBr3ZuNCj+LH4MznndSxCt6SlD8RbuT6ho/28qmWbVimOJX5PenU/vP3AhTeqNOrToQ
         eQ+VzMuGzHnISq0lPd/UAwYUDtaQ4c64Ny4JIImBMFES6TLVddoVnH5TIaCGAXDzelb9
         yl4PkQXp5cOPVoWFf52oYyk6Q8p053cbue58BejylHK/z7oWhovMgFXeYvAXBbHVbCpt
         k3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4SLPXvAJvU5TXdrlVj1eJaUEbTlJwuw9LrZnat9H4sc=;
        b=fqGKLeNPjnXv3ppRQhH/ocW6Vemfw2I2tSTSmy1u9nSiNiyUDBEnUbMqdawfqktU6d
         mDqGRdGxRpgDvXiJ+7V0ThCAiQkhlSwCtsSdDvhXOK/CMX3N4GQbgtKJAIS9BSVZdO2e
         U1Wv+rBWA64IhamdihsTrGdks81op97lTlUcWHsAUBeLwpDDvbuLg+AmILQpyWBbWMkd
         qY7ZgmNACGK/DCJ8+T87Qs3uP5tyT6302kZ1YHml7jt+1KVloC28lhbQYaGtM7WguYcm
         2hOzC3Xh7zK2+LT2IYYqXqS2fDu8EDR9vR4Tfq8hlpngJnxzJQmp0KrqGvdBpGBGIWeV
         /nXA==
X-Gm-Message-State: ALQs6tCAS8IL/tuRsXdDYgdl1jq9VvV9XhG5mxi56SK6vYX4SbnsYnjV
        TdMDKWVZOUBu5V4qsCyySQ8=
X-Google-Smtp-Source: AIpwx4/SaEFW9EeWltZy/35MB5Gi2Fkfkdc0gv0oan0Jr/or4aPzXc9qNtG+lsWAmhLSwrC0jKHDaA==
X-Received: by 10.28.44.86 with SMTP id s83mr16151737wms.30.1524722799295;
        Wed, 25 Apr 2018 23:06:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 90-v6sm1325399wrl.79.2018.04.25.23.06.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 23:06:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Sergey Organov <sorganov@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v9 00/17] rebase -i: offer to recreate commit topology by rebasing merges
References: <cover.1524306546.git.johannes.schindelin@gmx.de>
        <cover.1524659287.git.johannes.schindelin@gmx.de>
        <xmqqmuxq39rz.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 26 Apr 2018 15:06:37 +0900
In-Reply-To: <xmqqmuxq39rz.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 26 Apr 2018 12:51:28 +0900")
Message-ID: <xmqqvace1oya.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> - Rebased the patch series on top of current `master`, i.e. both
>>   `pw/rebase-keep-empty-fixes` and `pw/rebase-signoff`, to resolve merge
>>   conflicts myself.
>
> Good to see the last item, as this gave me a chance to make sure
> that the conflict resolution I've been carrying matches how you
> would have resolved as the original author.  Applying these on the
> old base (with minor conflict resolution) to match the old iteration
> and merging the result to the new base1f1cddd5 ("The fourth batch
> for 2.18", 2018-04-25) resulted in the same tree as the tree that
> results from applying these on top of the new base.
>
> That was done only to validate the result of the past resolution
> (and also seeing the interdiff from the old iteration).  There is no
> reason to keep this series back-portable to older tip of 'master',
> so I'll queue the result of applying the patches to the new base.

By the way, the rebasing made the topic textually merge cleanly to
the tip of 'pu' which made it slightly more cumbersome to deal with
a semantic conflict the topic has with another topic that modifies
the function signature of get_main_ref_store().  This topic adds a
new callsite in sequencer.c to this function.

The old base that forced the integrator to resolve conflicts in
sequencer.c with some other topic, thanks to that exact textual
conflicts, gave rerere a chance to record the adjustment for this
semantic conflict.

Now because the series applied to new base does not have textual
conflicts in sequencer.c when merged to 'pu', the adjustment for the
semantic conflict needs to be carried by a different mechanism.

    Side note.  Do not take the above as a complaint.  Dealing with
    interactions among various topics in flight while keeping them
    as straight and clean topic is what I do.  It is a normal part
    of running an active project.

It may be an interesting exercise to attempt to rebase tonight's
'pu' onto something younger in 'pu', say 'pu~4', without changing
anything in "pu^2" (which is the tip of this topic) and see how well
the merge recreation feature of this topic handles the evil merge.

The gist of the evil merge looks like this:

diff --cc sequencer.c
index a428fc7db7,e2f8394284..729cf05768
--- a/sequencer.c
+++ b/sequencer.c
@@@ -2483,6 -2527,349 +2556,349 @@@ static int do_exec(const char *command_
 ...
+ 
+ static int do_label(const char *name, int len)
+ {
 -	struct ref_store *refs = get_main_ref_store();
++	struct ref_store *refs = get_main_ref_store(the_repository);
+ 	struct ref_transaction *transaction;
+ 	struct strbuf ref_name = STRBUF_INIT, err = STRBUF_INIT;
+ 	struct strbuf msg = STRBUF_INIT;
+...
