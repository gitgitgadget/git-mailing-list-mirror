Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20E181F453
	for <e@80x24.org>; Fri,  8 Feb 2019 18:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfBHSnx (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 13:43:53 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37942 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfBHSnx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 13:43:53 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so4721017wmh.3
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 10:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e/zwagVSXR04J9XdgO62s8ZESrFT/D1sHEKF94eMUOk=;
        b=YXpOHzxLNWoIqb0rtAhtoDFx3yFRfGpTtbpUo5ldgJNCOPm074QiIHEvKZzEpGWmon
         q+Y88NQEpINJqqaZeRaSfe/hgF9ce+6bBhJdM+ibTFRswQ1k4HgOs6u7Bjp2oIlqNMyY
         Fojng2P/1NQRLISEmhAmg2o/vCS6MIDfyfjzvdqz1HqzYKqSP199/cOYl4qB0h95iGJQ
         i3jRszPgH9H05di0s5Sry6kevIhjRg73SQ9J8oL2UtCaalt6c0Nr3zBU3CQb/QbBz0WZ
         wOop649Ez1zemevPV064ORv7YzU90By73EX80roAjFNFxTSrx2QOwPqAzqbD5AFisgyD
         GfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e/zwagVSXR04J9XdgO62s8ZESrFT/D1sHEKF94eMUOk=;
        b=aLaeffO2x+t9CLBnGTAO+PSx3J8BSJ4hliL1HfEBweBuvjqlkKfPuTUpLP4x6yWjYw
         s/6tPWyPsqa7spsQ8oOWwLgxA5fFYsYtMk7jlgf175BIDIqMHVzKyaErmLCNbsI+ydkE
         bPjQguQEnL9lcsaiZr/IGhsb62HreWQ63JlVYn0dcP7X4B9L2iFVttqLjsSmbwqEQN3+
         sFmjtJI7zA34Cej8+H32KTLzzQBTD06CZ1fRv87DAUmfgLKSF2F8sbhuiIeDwPHJJpo4
         8BX/78Ditu2MZW80kLQ9tvjrTFyIgQ/E3BJVwjRdaAdMSCKbSvn8q1WjskmEEd1QhRBp
         pz9g==
X-Gm-Message-State: AHQUAuZC7w8OjhvUR2k+0w68czz4fJo9Hxt9YZln/gradq+9Pb3aCGzw
        WW9i2LCEgi1vl+zQEDCjZ8s=
X-Google-Smtp-Source: AHgI3IYiMBrd83700vlPpU05ffLBxBAMqxTbXGFMt/QkyYO4QIJD6dPJwnzS3WhzHp+CbXHMCpZiWQ==
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr8430647wrs.108.1549651430424;
        Fri, 08 Feb 2019 10:43:50 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id f191sm3295235wmg.12.2019.02.08.10.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 10:43:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Teach submodule set-branch subcommand
References: <cover.1549521103.git.liu.denton@gmail.com>
        <cover.1549534460.git.liu.denton@gmail.com>
        <xmqqo97npjej.fsf@gitster-ct.c.googlers.com>
        <20190208053152.GA3378@archbookpro.localdomain>
Date:   Fri, 08 Feb 2019 10:43:48 -0800
In-Reply-To: <20190208053152.GA3378@archbookpro.localdomain> (Denton Liu's
        message of "Thu, 7 Feb 2019 21:31:52 -0800")
Message-ID: <xmqqwomajf2z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> By the way, just for the record, how would you like me to handle
> patchsets that cause merge conflicts?

When it happens, I may ask you to rebase onto a specific commit.
https://public-inbox.org/git/xmqq5ztxstkh.fsf@gitster-ct.c.googlers.com/
is a recent example.

My preference (read: I'd be grateful if contributors tried to stick
to it, but it won't be the reason for patch rejection if they don't)
is:

 1. Choose the right base:

   a) For a fix to a bug that already exists in the last feature
      release (i.e. v2.20.0), build on 'maint' and make sure it
      merges cleanly to 'master', and the merge result builds and
      passes tests.  Depending on the severity of the bug, we might
      want to make sure that the fix applies maintenance track even
      older, but it would be something you would be sending patches
      to git-security mailing list---over there we'll figure out the
      right base on case-by-case basis.

   b) For a new feature, build on 'master', if you can.

   c) If you need to use something (i.e. a new helper function,
      updated type, etc.) in 'next' that is not yet in 'master',
      identify the topic(s) that introduces these things you need,
      merge them to 'master' and build on top of it.  If you did so,
      please note in the cover letter what topics you depend on.

   d) When updating a topic that is already in my tree
      (i.e. rerolling), stick to the same base as the previous
      round, if possible.  You can find out the commit the previous
      round was applied on top by fetching from me.  Your reroll may
      start using something the previous round did not use from
      'next', in which case you may end up doing c) above, which is
      OK.  Just make a note in the cover letter to let reviewers
      know.

 2. Make sure the result builds and passes tests.

 3. Make sure the result merges cleanly to 'next', and the merge
    result builds and passes tests.

 4. In any of the above steps where you are asked to "make sure it
    merges cleanly", you may see merge conflicts.

   a) If they are too much to resolve for you, for a change that is
      not a bugfix, you may have to depend on the other topic(s).
      Identify the topic(s) that touches these lines that heavily
      conflict with your changes, merge them to 'master' and base
      your topic on top of it (i.e. going back to step 1.c).

   b) If they are easy to resolve for you, do not worry too much
      about them.  It may be helpful to note in the cover letter
      "this may have minor textual conflict with these other
      topics".
   
   c) If you are left with huge conflict while working on a bugfix
      change, we need to resolve it on case-by-case basis, so send
      it out with the chosen base.  Noting that it conflicts heavily
      with 'master' or 'next' would be very much appreciated when
      this happens.

Thanks.
