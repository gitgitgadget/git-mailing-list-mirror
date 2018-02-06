Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 714B61F404
	for <e@80x24.org>; Tue,  6 Feb 2018 04:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeBFEm4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 23:42:56 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34898 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752257AbeBFEmy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 23:42:54 -0500
Received: by mail-qt0-f176.google.com with SMTP id g14so784082qti.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 20:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HGz407G+AVsZ+lDgsNqVqppMY3DhmfTPqjcqDPZobrI=;
        b=bwWFkXES7C9j5p8psTiW3E7vgdYZuuAx0hJqhojr5JRxiAR07FImI0P42lPmK4aGdr
         dRBcFXET2grCwQwNNVIFA1ZIMpov7lR3DtagfSJ4/RX+caKioKgHd02vCICGC4BKbYpO
         ++xO0qEG25lZFOv8ciFOwGj0EzWWQ8+QKxvB9/YNShpE7L8Rk0+7UsxFW84/SxpmKkgz
         BF3wVttGuvWYafkFbF50KcoJY5sTwabf/3ax3XaS46Z6Lf19eQKufMAHV4TPSWPNP1uB
         LAIhpHqp9sWgvl/D/rs80sTd68XxCMr9GnI3sqX46cEtj5CCcA09PlRjg0kaeoUtDFvp
         qWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HGz407G+AVsZ+lDgsNqVqppMY3DhmfTPqjcqDPZobrI=;
        b=tbTLnPQ6ZFWZYS9qNznGGuagSZbzg0UjaX04l5MeYR7qSHjx5bWCVwLWhbKi8AkjjD
         s6TxrDgecng2IoWArqDmWHRVsFNXacwmLluARgpJqDXjzVSpw7buFMQXl3Tldekcc4VE
         QYgB6jlVC4MQKA+1uEVd6JVL5GAWJb5T6rI4wVvMx56FBHRVjq96Bmk8iWBFGRienhMr
         qULFGPo0yta+0RHxtJELKizUkeqWF7+Y6BtAsYgtAXpQE9X6KqSTWfBbJzJX5F5NCQ//
         q66xkzY2SPjtoLL0BE8t7qn8MOlLHwqecX9aSPr4yVwKEoCu2cEegmY1XCniwD+zDZog
         /ZJA==
X-Gm-Message-State: APf1xPDM2VTeP3vE8Ig1WEByNhoO+LwsfmuGoLvEbYguYmeCYzBGgYUJ
        U77omMTGeY0Q+LJYP2RS+XMyZpUnn0Up0a6RDIR0rA==
X-Google-Smtp-Source: AH8x226ugJC5ieTir7dvHgasCXcXHFu5rUuZkQ1XmTIAz3Vh2cPNKU+2usHvNQAj4Am7ZrMmN9sMw21v7w5ivkl/jLo=
X-Received: by 10.200.45.109 with SMTP id o42mr1707797qta.277.1517892174078;
 Mon, 05 Feb 2018 20:42:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Mon, 5 Feb 2018 20:42:53 -0800 (PST)
In-Reply-To: <xmqqmv0n80ue.fsf@gitster-ct.c.googlers.com>
References: <xmqqmv0n80ue.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Feb 2018 23:42:53 -0500
X-Google-Sender-Auth: KcA_Hf9ibsQiMsNRVuxIWxZramo
Message-ID: <CAPig+cTFSWJX3FyXA6JJPhd1TT9eS0QOtm_R2qB6SX8W60ZWtA@mail.gmail.com>
Subject: Re: [RFH/PATCH] blame: tighten command line parser
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 6:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The command line parser of "git blame" is prepared to take an
> ancient odd argument order "blame <path> <rev>" in addition to the
> usual "blame [<rev>] <path>".  It has at least two negative
> ramifications:
>
>  - In order to tell these two apart, it checks if the last command
>    line argument names a path in the working tree, using
>    file_exists().  However, "blame <rev> <path>" is a request to
>    explalin each and every line in the contents of <path> stored in

s/explalin/explain/

>    revision <rev> and does not need to have a working tree version
>    of the file.  A check with file_exists() is simply wrong.
>
>  - To coerce that mistaken file_exists() check to work, the code
>    calls setup_work_tree() before doing so, because the path it has
>    is relative to the top-level of the project tree.  However,
>    "blame <rev> <path>" MUST be usable even in a bare repository,
>    and there is no reason for letting setup_work_tree() to complain

s/to complain/complain/

>    and die with "This operation must be run in a work tree".
>
> To correct the former, switch to check if the last token is a
> revision (and if so, parse arguments using "blame <path> <rev>"
> rule).  Correct the latter by getting rid of setup_work_tree() and
> file_exists() check--the only case the call to this function matters
> is when we are running "blame <path>" (i.e. no starting revision and
> asking to blame the working tree file at <path>, digging through the
> HEAD revision), but there is a call in setup_scoreboard() just
> before it calls fake_working_tree_commit().
>
> Also attempt to give a bit more sensible error message when "blame
> XYZ" is given and XYZ cannot be a path.
>
>    side note: I am not happy with the "only one arg, which is a rev,
>    given in a bare repository" condition to give the new error
>    message, but this should be a good starting point.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
