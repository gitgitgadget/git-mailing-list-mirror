Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7321F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbeHMT31 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 15:29:27 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34302 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeHMT31 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:29:27 -0400
Received: by mail-wm0-f42.google.com with SMTP id l2-v6so8163762wme.1
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xu3wRZJjecE8+6uf6wqNkBu9G0Bh2gLh4wq5lQQA+ZA=;
        b=K4wrt9Cpcs9my9iSPPlfINctDtchbUvTw9uBA8xVd8bIjCglQvPU+tVVbUIEI9JWjW
         vPsG33KMvfY8u/8lMeRB8SrZVVRoiJ5hCvmGIXzb4WYSZk3zX3x07LL+JLjDij9nplLI
         a7gZ6+55NXVghaVw2olZb7j1aYZ1o+pkO2QzLr20iHfDuKclqAMZ1VusAqoqppwtZH6/
         l3/ccx/qq9nADq3gQvCmHmBICMHepNn0HtEdTZwVybzjsE4bcr3o784fmI6xQ8ZStBay
         b0kG91EXGqOFKyQkxMeQC3oSoV29IGAGOg3YDWW0NjZC9bcWTrWgrRDqXSREvs8+xrJ3
         BGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xu3wRZJjecE8+6uf6wqNkBu9G0Bh2gLh4wq5lQQA+ZA=;
        b=q+DUedCUmkNr5XEUALqiPOMUMaCc/3SkXteYJMM7ymhdMIIRc6IDltAJy74N8nla6d
         YsEuEATTeih+fcF5fWfTRUGAUgPszTKvbk2fQD53U2ZTTpL9sG/ONjUgmINaHjEyOBjL
         j8CYKIzfWs4DRFygQSrJu9CoNhiuMj+2Lto4iu12jID+0dyIhrrVIqDw971fc0dOKSCN
         MxW0m5+w0oPgDd//T979+Z5Lbi/fRxCqpx3nxjCEk6OUMYiTx72pXd8zv7O4L7p7vagZ
         bLBRH+QBrGrwI81Bs/AealUO+Zg0jVcFa6/EIGHLB90IwlV5OBOwn77zhVZM87exCFlF
         8ZBg==
X-Gm-Message-State: AOUpUlG07ZkFvCXX7sku2zgc5Dy8Wf8uQCA1Op9tY3VtLoiPNGq2MTbZ
        ohKxi/CFhB5cRu7inW0oYKs=
X-Google-Smtp-Source: AA+uWPx2oSZ4nPsypLW2WGhQs4VMVMH48zEle2iKI7z9ZsutQ7E9oCYq5VWO23CuHI2HqpwMydYBbQ==
X-Received: by 2002:a1c:3e8e:: with SMTP id l136-v6mr8314535wma.45.1534178784967;
        Mon, 13 Aug 2018 09:46:24 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h7-v6sm17828141wrs.8.2018.08.13.09.46.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 09:46:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?0JrQvtC70Y8g0JPRg9GA0YzQtdCy?= <guriev-ns@ya.ru>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] status: -i shorthand for --ignored command line option
References: <CAPig+cTD7XYbaPBzj36Eudrud80r-cz1CPLDsLA9CHJC6Yc-Qw@mail.gmail.com>
        <20180809062142.15638-1-guriev-ns@ya.ru>
        <xmqqpnyrczo8.fsf@gitster-ct.c.googlers.com>
        <a178d91c-74dd-e04a-8db3-70cd75ad6793@ya.ru>
Date:   Mon, 13 Aug 2018 09:46:23 -0700
In-Reply-To: <a178d91c-74dd-e04a-8db3-70cd75ad6793@ya.ru> (=?utf-8?B?ItCa?=
 =?utf-8?B?0L7Qu9GPCdCT0YPRgNGM0LXQsiIncw==?= message of "Mon, 13 Aug 2018
 08:02:47 +0300")
Message-ID: <xmqqftzi6wps.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Коля Гурьев <guriev-ns@ya.ru> writes:

> 09.08.2018 18:44, Junio C Hamano пишет:
>> Unlike "-u', "-i" is supported by "git commit" which shares the
>> underlying implementation, and that is the historical reason why we
>> never had "-i" shorthand, I think.  
>
> git-commit supports the -u flag, its meaning is the same as for
> git-status. Although the -i flag might be confused with the --include
> option of git-commit,...

Yes, I was describing a historical perspective on the reason why
"-u" was there but "-i" was not.  Since it is merely historical that
'status' was a mere synonym to 'commit --dry-run', which no longer
is the case, that no longer is a reason not to have "status -i".

That is why the paragraph you are responding to in my message
exists.

>> While I do understand why sometimes "-u" is useful, especially
>> "-uno", to help those whose .gitignore is not managed as well as it
>> should be, I am not sure why a "typical git-status" invocation would
>> ask for "--ignored" that often to require such a short-hand.
>
> The --ignored option is often used for opposing purposes, to show all
> changes in working directory regardless of .gitignore files which may be
> written sloppy.

That's not "sloppy" but "too tightly", I think, and you won't get
"changes" to them (only the presence of them).

I know a user can view more paths with "git status --ignored" in the
output than without the option, and it may sometimes be interesting
(after all, that is why we have the option in the first place), but
I am trying to find out why a user needs to constantly asking for
"--ignored" (otherwise there is no point adding a short-and-sweet
"-i").

"git status -u" is not by itself a useful tool to "hide" the
sloppyness of the .gitignore patterns, as "git status" by default
acts the same as "git status -unormal" does to remind you that you
forgot to list a pattern to catch build artifacts, and the user who
wants to stay sloppy needs to work on it by saying something like
"git status -uno".  The short-hand does not encourage people to be
sloppy too much.  I am hesitant to add a short-hand that is too
convenient and encourages people being sloppy (or leaving a too
tight list of exclude patterns and not fixing) and wondering if "git
status -i" alone, without forcing users to type a bit more (like
"-uno" as opposed to "-u" alone), is such a short-hand that helps
undisciplined use of the tool.  That is why I am asking why a
"typical git-status" invocation ask for "--ignored" that often to
require such a short-hand.
