Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B4B91F453
	for <e@80x24.org>; Wed,  7 Nov 2018 00:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeKGJfM (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 04:35:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55906 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbeKGJfM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 04:35:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10-v6so12444407wmc.5
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 16:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UREMLLt7IBjZlolCymSuftO/JGiJce7piyZhhIhE8Cw=;
        b=nQQHs3Xm846z8J76BtnbrgLz0oU7fKnmenb4bf7VAwuVBhTC28i5pwLudS0oCmGcBs
         8GwQZltVmIzZ/Ol6+mru0GEwWY83JFYtM1kwEIE183ZpfmKImiMgRCFllMa3MD4Vlwzy
         S9+sGPj0ce4r/BvZVq+7xaYQAAApi1cXmzdmEp8rJBEx/1Ls6leeep7JPd0n99NhbbEQ
         8o83ypuet1qcHnkdb4i/Mcbh/1ICcaD/R+gp5F/cQ4W0neuZVsyqmY/p9M4TfqZK35Xg
         2N//13iwRrcdbN7aeODV6ytvvDAaTOiYZjf1PYxIJvLqDQzvT3t1JFoTN/OfHcCKP/Rg
         U+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UREMLLt7IBjZlolCymSuftO/JGiJce7piyZhhIhE8Cw=;
        b=FJ1yi3IEy5iqowt9KO3vgR2nVPomS9CcxtXtkGCif3CTv8BOZfMo020xmfRvrh8H4i
         acsytubws9ZPAx/K2xNDye7Ec919Ts5E38m7dgSPZ2lfi8ZTy+g5MiAtde/q9XRohouQ
         sbuXszrGcHEFX+UtDgJ80dZXJbO/LdsxC+oj4Ni+7AoxpdONgqq1990vGuqtt6qDD6eo
         BgulPMoJ3p8LjCqPYd9Q5uVv9TZDlL4bYGIgc8yfSv64epYyQyAEbQQxrOjEt7ev5Fcw
         oxFwMUMsP9cbl3mU/GFPpPdlcxVZY1+69TFjGdQYtf/kIeMIOaJMxWMBBVzgZkcVL8x7
         1JWA==
X-Gm-Message-State: AGRZ1gKXSKJc7mn/GubeW/Haep2EmyeSy9heG2d4uhyaSluWMqe67e6U
        agDNTp8bjP9lQk6LbhkcTRc=
X-Google-Smtp-Source: AJdET5dD22dND9lyP5uU9dylOPlMJuuW3mRaAY7qWg4iFaX+/Y6k6wJFTFwsT4ieeIseGadW9nTxqw==
X-Received: by 2002:a7b:c0cc:: with SMTP id s12-v6mr48049wmh.39.1541549241466;
        Tue, 06 Nov 2018 16:07:21 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k66-v6sm3386134wmd.47.2018.11.06.16.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 16:07:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Halstrick <christian.halstrick@gmail.com>
Cc:     Git <git@vger.kernel.org>, rene.scheibe@gmail.com
Subject: Re: What exactly is a "initial checkout"
References: <CAENte7hoHxQCiQwSaAGPyaeFK8rb2Q23DcbePd01fcvgxtodZg@mail.gmail.com>
Date:   Wed, 07 Nov 2018 09:07:18 +0900
In-Reply-To: <CAENte7hoHxQCiQwSaAGPyaeFK8rb2Q23DcbePd01fcvgxtodZg@mail.gmail.com>
        (Christian Halstrick's message of "Tue, 6 Nov 2018 13:38:45 +0100")
Message-ID: <xmqqa7mleond.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Halstrick <christian.halstrick@gmail.com> writes:

> I am trying to teach JGit [1] to behave like native git regarding some
> corner cases during "git checkout". I am reading the "git read-tree"
> documentation and I am not sure about the case [2]. Git should behave
> differently during a normal checkout than when you are doing a
> "initial checkout".

When you are starting from commit H and checking out a different
commit M, and when a path in the index does not match what is
recorded in commit H, usually Git tries to keep the state of the
path you have in your index as a "local change", as long as the data
recorded for the path is the same between H and M.  A path in the
index that matches what is recorded in commit H and with different
data recorded for it in commit M gets M's version in the index and
the working file is updated to match (but it requires that either
the working tree file is missing, or the working tree version
matches what is in the original index, to avoid data loss).

But imagine you have just cloned and are trying to finish that
process.  What Git has done so far would include creating an empty
repository, populating the object database and pointing branches at
various commits.  HEAD now points at the branch (usually 'master'),
the index file does not exist (you haven't checked out anything),
and we want to populate the index and the working tree files to
match what is recorded in HEAD.  We do so by starting from commit
HEAD and checking out commit HEAD.

This situation presents conflicting goals to the above "keep the
local change" rule.  To the rule, this situation looks as if you
removed each and every path from the index (as the index hasn't been
populated yet---in fact, the index file does not even exist yet in
this state), but the data recorded for each path are the same
between commit H and commit M (as H==M==HEAD in this case), so "keep
the local change" rule would leave the index and the working tree
empty X-<.

That is rescued by the "initial checkout behaves differently and
forces the index and the working tree match what is recorded in
commit M" exception.  It probably should be obvious to the readers
by now that the absense of .git/index is used as the clue for this
exception to kick in from the above use case.

And that is exactly the condition that is checked by
read-cache.c::is_index_unborn().

