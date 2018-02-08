Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 526531F404
	for <e@80x24.org>; Thu,  8 Feb 2018 22:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeBHWSi (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 17:18:38 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37311 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751094AbeBHWSh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 17:18:37 -0500
Received: by mail-wm0-f66.google.com with SMTP id v71so12821448wmv.2
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 14:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2TdGZqNnJE+IHKzmljngUxzOPkpf0imXRISNRhx7Y0c=;
        b=qfih331teqklbx+Y+ICQxtWOCTj44bvcKc5UVRPA9CpJExnuJqHgIos5g4SWOURxPB
         vbYrC0Nxop78pL565DR8OhnGCcl54RzFkazqsikpI0c/kvTdIl27k0PE0BA01kqzc81/
         BTiBQkyrT0jYyEpEsDDX7XtP2/UboVMPNjXTycNGKVkEgyD/0353pBx0YsvfxlEmEGh2
         DUiXcbPLVoe4eF0o9N88OcXv4TYfhGG1k/Q/6/vozOuoV/P++3+ObrudfBjNF1BVch1I
         kx6owIo62e2g7gIphrP94ZOeOQdV4EDcqMqrnWCEh6g+xTvEZXZYXFP8yS9efCoxPSqE
         e6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2TdGZqNnJE+IHKzmljngUxzOPkpf0imXRISNRhx7Y0c=;
        b=LTDsrVEMQEbARqVFFZigiYcRZxhrpK8vtFAHQ9+Y/wm1ogea5LaIn2wRoTwAhaCfOx
         JWuLB491Oa2AEpsb7WDwdE1W+rlVGXsO+YT8tQ8TB2SxDPfFbwJkBN18mHzkvU9aCcsk
         l2G9ZG0F3iZlXY/r9D/QH9DB4dKhj0BPg1CgoJBlLT7hnw/f307+33MBZJQRxX42kor6
         BziFrh1+lyOiQpSfLAWHDT9hyq2OVKytLo0dQ2oZ0o44cHXD2mJNwRfrVsoPz5AJxEB4
         G+chYRd2a+juk7ZsPiizOQkZqp+3M8zbx640MgGYuXMEpxtw/uEeStTYOQDI8dAObWcD
         bqaw==
X-Gm-Message-State: APf1xPBWIdcrxBAsAGyjkidEpcHzlFQ6/SPE4tQGD5itMdK39rdmOaQt
        7yD9yT1QelzzfNttKXzGCPhwSUWeotw=
X-Google-Smtp-Source: AH8x227buxis0JfCg9L5IFkFms/qb5gOloFCF1TRRU0eLUq1gYoZH0+m4BQscMA24LmOZB7Koscmbg==
X-Received: by 10.28.114.6 with SMTP id n6mr332922wmc.87.1518128315690;
        Thu, 08 Feb 2018 14:18:35 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 198sm1004256wmo.36.2018.02.08.14.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Feb 2018 14:18:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Left-over COMMIT_EDITMSG file in gitdir
References: <CA+55aFzaxTrki92C8ih3M3BtYHU3BG8P2SWwvdWiTXZWFDH=1Q@mail.gmail.com>
Date:   Thu, 08 Feb 2018 14:18:34 -0800
In-Reply-To: <CA+55aFzaxTrki92C8ih3M3BtYHU3BG8P2SWwvdWiTXZWFDH=1Q@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 8 Feb 2018 14:09:25 -0800")
Message-ID: <xmqqpo5fp1l1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> In that rewrite, removing some temporary files seems to have been left
> out. At least one: .git/COMMIT_EDITMSG.
>
> In the original commit.sh shell script, we can find this:
>
>   rm -f "$GIT_DIR/COMMIT_MSG" "$GIT_DIR/COMMIT_EDITMSG" "$GIT_DIR/SQUASH_MSG"
>
> after creating the commit.  In the C implementation, we do have a
> number of "unlink(...)" calls:
> ...
>
> but no
>
>         unlink(git_path_commit_editmsg());
>
> and that *seems* to be an oversight.
>
> Similarly, builtin/tag,c leaves a stale TAG_EDITMSG file behind.
> Again, that actually did exist in the original shell script, which
> used to do
>
>   trap 'rm -f "$GIT_DIR"/TAG_TMP* "$GIT_DIR"/TAG_FINALMSG
> "$GIT_DIR"/TAG_EDITMSG' 0
>
> which caused that file to be removed at exit.

I do not think it was intentional---just a bug in the rewrite.

