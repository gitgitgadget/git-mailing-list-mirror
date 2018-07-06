Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 683CC1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 18:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934291AbeGFSae (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 14:30:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46711 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933978AbeGFSad (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 14:30:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id s11-v6so5033404wra.13
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 11:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=f5WlRnyLXClMfhiHulkmaYqNdrmDriZlBJEvDN7ynXg=;
        b=nVFEK/t8KQcZGTpL11NbWFGLV8CrFB4muz2yqH13kWEe5xrYKa1Te/XUlBYisQMg+p
         DdeHsgfKaczV+aYfMg4CjFsdKxxDuZ6YbS3URVxBoPS1cKMOc3eiJgGC86Gatgpx0Y3i
         Mb6aJczPQ3kOjanxPvvqK/G0nLPM7SHI97P5cH2J36sPmChOhr+5vC/Dz/hCI0/TjRgk
         ogxaRmGWGFmWYxMLXvexUrel0bvaG9kZwyTmb0FXCfV2owUFhSRqWji417uEmBVD2fTW
         ZlBoKBpnaVG2JhP32Ws1XXNMmQGUv4VFnjFVFKJYWUoTjNZC4OP/SwCJzG/KHdm1GQrB
         mygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=f5WlRnyLXClMfhiHulkmaYqNdrmDriZlBJEvDN7ynXg=;
        b=tVnwo1tu08mWFy2JNdi+uB0UPnH7pMUj1p8WkUJ8oPmrsXNiXXbW05cg3jevCiYVjd
         3su8xHNYAFPJjWYBz/a2+MGibLgTE0u3smERuEsizl3H4TeUAlk/zlr0P3kLNSz+5k7V
         5utpVpbSuZFBgonBh8K4omJfXvoj8kTGwzUPlgScoA/SQcTT9NuZOKKTmnpQQfDo5KRh
         C/PZuxSI2DgvDW69DFnJi7GRbBE74EhTE6+hm38ZyuGKmZ1wLMvA3p4b8479LfmsNBo7
         30i73z7kNpmzKvWeMAOkGlZLGnTwS88Mg8vSSuUuGjne6rN5RgEhTdR04XF+vm+ZPM6l
         8aDA==
X-Gm-Message-State: APt69E00RQZeVClFGkYg5Ib1Vzl6H2ENIelH68pRNlXJlqrEe1yFGYM2
        8PTTsPXbpPN9JeKCPp9b76Y=
X-Google-Smtp-Source: AAOMgpd5jMjK5LYaNamjjJtJDgNk0YMaH8TF6Sz8pYpMYb5/IqCzgynOzraS3EVoa0zW2GRRnv/6xg==
X-Received: by 2002:adf:a86a:: with SMTP id l97-v6mr8553860wrc.164.1530901832184;
        Fri, 06 Jul 2018 11:30:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 189-v6sm18520384wmy.25.2018.07.06.11.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 11:30:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, dana <dana@dana.is>,
        Wink Saville <wink@saville.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH] git-rebase--{interactive,preserve-merges}: fix formatting of todo help message
References: <1530706658-20519-1-git-send-email-tklauser@distanz.ch>
        <nycvar.QRO.7.76.6.1807041505000.75@tvgsbejvaqbjf.bet>
        <20180704141635.GH24016@distanz.ch>
Date:   Fri, 06 Jul 2018 11:30:30 -0700
In-Reply-To: <20180704141635.GH24016@distanz.ch> (Tobias Klauser's message of
        "Wed, 4 Jul 2018 16:16:35 +0200")
Message-ID: <xmqqh8lckyih.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tobias Klauser <tklauser@distanz.ch> writes:

> And I'm glad to see that this part will be rewritten in C :-)
>
>> However, your patch also covers this:
>> 
>> >  git-rebase--preserve-merges.sh | 4 ++--
>> 
>> I completely missed that in the earlier patch.
>> 
>> Junio, this gets an ACK from me, could you apply the
>> `git-rebase--preserve-merges.sh` part selectively, please?

Here is what I assembled from various pieces in the list archive.

-- >8 --
Subject: [PATCH] git-rebase--preserve-merges: fix formatting of todo help message

Part of the todo help message in git-rebase--preserve-merges.sh is
unnecessarily indented, making the message look weird.  Remove the
extra lines and trailing indent.

This was a minor regression introduced by d48f97aa ("rebase:
reindent function git_rebase__interactive", 2018-03-23) in the 2.18
timeframe.  The same issue exists in "rebase -i", but it is being
addressed separately as part of the rewrite of the subcommand into C.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 git-rebase--preserve-merges.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--preserve-merges.sh b/git-rebase--preserve-merges.sh
index c51c7828e7..c214c5e4d6 100644
--- a/git-rebase--preserve-merges.sh
+++ b/git-rebase--preserve-merges.sh
@@ -891,9 +891,9 @@ $comment_char $(eval_ngettext \
 EOF
 	append_todo_help
 	gettext "
-	However, if you remove everything, the rebase will be aborted.
+However, if you remove everything, the rebase will be aborted.
 
-	" | git stripspace --comment-lines >>"$todo"
+" | git stripspace --comment-lines >>"$todo"
 
 	if test -z "$keep_empty"
 	then
