Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 841B81F404
	for <e@80x24.org>; Thu, 30 Aug 2018 16:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeH3UEc (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 16:04:32 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39970 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbeH3UEc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 16:04:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id n2-v6so8558450wrw.7
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=+g/4TPt+6+hVlXLHEthSsWmYOi5On2gRNP4U+XN23s4=;
        b=K3zixybQWR8yVXffQzgfRvG9x+OFpW6dDiYdOyhCUiLo3Up2jgYciyKhjxG8irNUMU
         8eVT6b//2dc13KyKUSFK4UjqEOuTfABzqDOfYFVEjSnsTX1D1YwLkPGpt+zu5IxO9xls
         eH3GrxvY4GRoxvZuE7TcFPl+kHZIZ1RTQma6Ev4kS6gIrhu4d4X6HDDLhG4QLUXDxD9R
         5pYu/uySXYgligWZ/OGCe4enzDWyWuh0CVkObYR+o0WssibGTcqjSGwVjZzhCbv6BGe3
         wStE/SuKv92BzNyCDU1zmF0onrfny3uSsV3RJdVeUn85jQtoHDA1ILoaSr7sVmaNLbdR
         OE2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version;
        bh=+g/4TPt+6+hVlXLHEthSsWmYOi5On2gRNP4U+XN23s4=;
        b=Jk23zsw8NiMGAkCf3Sl40q/O6D2eqbBRXFSpYVEuFZC4j6LC1sIccGjp9wrDaIGMuY
         buZsAGgdM6KoDbKzkSBycdyc/yrSxXnxB3P2WUDc8vl9AlwpqqlrIv1+fOPZEaQU+kZq
         9IkgAW8eibmw50gVmycgOFv9yRj/1KWSwOrjjEgV5DlpoTLgWdpj4B+rfyf5yf3cxY0r
         8QMhKpy5kTVPhL4mJUBK/zG+yvLrDxiIHmTeG3vISNG6w9R3+oNEG0JDNUKWRJ/88oTs
         ZhYr3c3fIMPPZuubml6RECp9HBAwUBr9M4nemhqo8fmrTFMNv0e1mCZ09gDRktLSeHQq
         KmPQ==
X-Gm-Message-State: APzg51BIDZ/vx8EQKT2BttJ1NJOxmOrhlj10qR1jUbIdw69IqaL6SiXz
        Y/y0Zlqp14PPsXHDYw9y91w=
X-Google-Smtp-Source: ANB0VdZV7BMnilhfPK5ncy79Dfx4OE+3TIcPp1xnUnjWF1GXSFausRWTxuO/EWNUXKOSsAoOnpyR5w==
X-Received: by 2002:adf:b2b5:: with SMTP id g50-v6mr7721753wrd.218.1535644900550;
        Thu, 30 Aug 2018 09:01:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v192-v6sm2572777wmf.40.2018.08.30.09.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 09:01:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, corrmage@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] t3401: add another directory rename testcase for rebase and am
References: <xmqqh8jeh1id.fsf@gitster-ct.c.googlers.com>
        <20180829070613.11793-1-newren@gmail.com>
        <20180829070613.11793-2-newren@gmail.com>
        <xmqqo9dkakl0.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFYhw9iU=jxt-1uY75GSt-_JtLnYQFf0kfjbqtK--xi3w@mail.gmail.com>
Date:   Thu, 30 Aug 2018 09:01:39 -0700
Message-ID: <xmqqlg8n6dy4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Is this a single-shot environment assignment?  That would have been
>> caught with the test linter.
>
> Ugh, yes.  Sorry.
>
> I was trying to allow backporting to 2.18, so tried to build my series
> on that...but moved forward slightly to en/rebase-consistency in order
> to re-use the same testfile (as mentioned in my cover letter).  But
> that meant my branch was missing a0a630192dca
> ("t/check-non-portable-shell: detect "FOO=bar shell_func"",
> 2018-07-13), so the test-linter couldn't catch this for me.

True, I also only caught this during my integration cycle, not
during the review of the patches.

>> Perhaps squashing this in would be sufficient fix?
>
> Thanks for fixing it up.  That works...although now I've spotted
> another minor issue.  The FAKE_LINES setting is only needed for the
> interactive rebase case and can be removed for the other two.  Oops.
> It doesn't hurt, but might confuse readers of the testcase.

Ah, OK.  So the squashable fix would now become like this, all
fixing the ones from the first patch.

> Would you like me to resend a fixup on top of your fixup, resend the
> whole series with the fixes squashed, or just ignore this final
> (cosmetic) issue since it doesn't affect correctness and I've caused
> you enough extra work already?

No worries.  This is what the maintainer does (when s/he is not
playing other roles like a reviewer or an individual contributor).

I'll squash in the following to the 1/3 patch and queue the topic
with the other two patches.

Thanks.

diff --git a/t/t3401-rebase-and-am-rename.sh b/t/t3401-rebase-and-am-rename.sh
index 94bdfbd69c..e0b5111993 100755
--- a/t/t3401-rebase-and-am-rename.sh
+++ b/t/t3401-rebase-and-am-rename.sh
@@ -141,7 +141,7 @@ test_expect_success 'rebase --interactive: NO directory rename' '
 		git checkout B^0 &&
 
 		set_fake_editor &&
-		FAKE_LINES="1" test_must_fail git rebase --interactive A &&
+		test_must_fail env FAKE_LINES="1" git rebase --interactive A &&
 
 		git ls-files -s >out &&
 		test_line_count = 6 out &&
@@ -160,7 +160,7 @@ test_expect_success 'rebase (am): NO directory rename' '
 		git checkout B^0 &&
 
 		set_fake_editor &&
-		FAKE_LINES="1" test_must_fail git rebase A &&
+		test_must_fail git rebase A &&
 
 		git ls-files -s >out &&
 		test_line_count = 6 out &&
@@ -179,7 +179,7 @@ test_expect_success 'rebase --merge: NO directory rename' '
 		git checkout B^0 &&
 
 		set_fake_editor &&
-		FAKE_LINES="1" test_must_fail git rebase --merge A &&
+		test_must_fail git rebase --merge A &&
 
 		git ls-files -s >out &&
 		test_line_count = 6 out &&
