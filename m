Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927551F404
	for <e@80x24.org>; Wed, 21 Mar 2018 03:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeCUDbg (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 23:31:36 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39890 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeCUDbf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 23:31:35 -0400
Received: by mail-lf0-f67.google.com with SMTP id p142-v6so5755281lfd.6
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 20:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=slcedP4W3pltJXJpfHaaZpgpNOGEdw58RxsxUuKpHMU=;
        b=cVLSU2Dk3bMqP/tx4lyTHMK83M5BSIqBucoOc6MPA5M744teuQy+Xp0ZvCLeyRXlYP
         VjSjl1NbZzgc1btNKvurMpPzGOgId1hDbT7Tyehx8Y/z5s35EVe3szqzU2fHtRs/d64n
         NIeQZ2VK5vPQvXGFbx05Igl1smSK8vtLhbwflo8pnJ3DabGIUHITjHTEoOqhIf1fMjVa
         RT/d1NGweZJGSsJg5i31d9uGlC/ZixXdgKvuBtohN46aO2tkQTiLi2zHF9fw38yzmqY5
         7W0sAA4VhLjaNDMF0HDJ1eFh0gpdsqghgIlWx073XXlwTsAbcq5b/yAMFdy609USKMSb
         TRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=slcedP4W3pltJXJpfHaaZpgpNOGEdw58RxsxUuKpHMU=;
        b=hZDQ/xkXAhhw3hW7vZWWTAC21Zo0DqrFR8yfsk4UXfdoI6gmuKBU3gXw4LBKPghpow
         8Qf7FTZHZBllSv+IHU1rIp+WLKui1MTMmqIjH/MQdwtxj+xq3U4Pf27ueI4LjLjxaeXA
         0hc7WzHKUx0hbFKQSzwPjk1XdRzWYDZXtVQFS2ppwOsAfa9mO+bLlk/1s1ZjcTLA038s
         Xyurft4ZJ1s2dMGhk/hHBv+zP+OIQl9xlbPfqgM3wTJ4ArVUra+d730yfBREcq1PNTL6
         NzXSjJHmOVGE7503r/du6kaTkBfB4MqNeBpESQonBGW4HyOAs6cpEDytBS5/i6kltX8T
         piPw==
X-Gm-Message-State: AElRT7FV5XrJj4q7lERQ6hefieQfrBRSP+YQVFJD33qUedl4eJITeP1t
        kn+FF0Ag+5iPyTSJ2lFuRTxC13KEEKhcZW9XcDLHcA==
X-Google-Smtp-Source: AG47ELthPmJ3XU0Kg4F2iQy5gqcGURREgWC+tKg0HCaIyCg/oGMnIrxcE3GmlIoJ1vrwNuPHTM0ZHXsEAOwDGaXP5Rg=
X-Received: by 2002:a19:1449:: with SMTP id k70-v6mr13310805lfi.23.1521603093859;
 Tue, 20 Mar 2018 20:31:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:d591:0:0:0:0:0 with HTTP; Tue, 20 Mar 2018 20:31:13
 -0700 (PDT)
In-Reply-To: <CAPig+cSvvg=hXjXLKM2yYqqy=q+z_T_TVkuUJe0W=R_494CMkA@mail.gmail.com>
References: <20180320204507.12623-1-wink@saville.com> <CAPig+cRw4MSfcKJcgT-srCE7sDYi3qA0TrNApXBDBsgodVb3Pg@mail.gmail.com>
 <CAKk8ispSvaAr3iRhC4X+gufeKm20AQzw9_mvuysT7SiDsZQYJw@mail.gmail.com> <CAPig+cSvvg=hXjXLKM2yYqqy=q+z_T_TVkuUJe0W=R_494CMkA@mail.gmail.com>
From:   Wink Saville <wink@saville.com>
Date:   Tue, 20 Mar 2018 20:31:13 -0700
Message-ID: <CAKk8ispayA9ceLLRTQJd8_h_S7VaQqSoTBKGz+GjB3EbB7WO+g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] rebase-interactive
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 2:47 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Mar 20, 2018 at 5:23 PM, Wink Saville <wink@saville.com> wrote:
>> On Tue, Mar 20, 2018 at 2:11 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>> A problem with this approach is that it loses "blame" information. A
>>> git-blame of git-rebase--interactive--lib.sh shows all code in that
>>> file as having arisen spontaneously from thin air; it is unable to
>>> trace its real history. It would be much better to actually _move_
>>> code to the new file (and update callers if necessary), which would
>>> preserve provenance.
>>>
>>> Ideally, patches which move code around should do so verbatim (or at
>>> least as close to verbatim as possible) to ease review burden.
>>> Sometimes changes to code are needed to make it relocatable before
>>> movement, in which case those changes should be made as separate
>>> preparatory patches, again to ease review.
>>>
>>> As it is, without detailed spelunking, it is not immediately clear to
>>> a reviewer which functions in git-rebase--interactive--lib.sh are
>>> newly written, and which are merely moved (or moved and edited) from
>>> git-rebase--interactive.sh. This shortcoming suggests that the patch
>>> series could be re-worked to do the refactoring in a more piecemeal
>>> fashion which more clearly holds the hands of those trying to
>>> understand the changes. (For instance, one or more preparatory patches
>>> may be needed to make the code relocatable, followed by verbatim code
>>> relocation, possibly iterating these steps if some changes depend upon
>>> earlier changes, etc.)
>>
>> Must all intermediate commits continue build and pass tests?
>
> Yes, not just because it is good hygiene, but also because it
> preserves git-bisect'ability.

That's what I figured.

Anyway, I've played around and my current thoughts are to not create
any new files and
keep git_rebase__interactive and the new
git_rebase__interactive__preserve_merges
functions in git-rebase--interactive.sh.

Doing that will preserve the blame for the existing functions. But if
I do indentation
reformating as I extract functions that will be shared between
git_rebase__interactive
and git_rebase__interactive__preserve_merges then we still lose the blame
information unless the "-w" parameter is passed to blame. I could choose to
not do the indentation, but that doesn't seem like a good idea.

An alternative is that we don't accept the refactoring. What I'd
probably do is use
the refactored code to figure out a fix for the bug and then back port
the fix to the
existing code.

My opinion is that to not accept "improved" code because we lose blame
information
is not a good trade off. Of course what I might think is "improved"
others may rightfully
say the refactoring is gratuitous. If that is the case than not doing
the refactoring is the
right solution. I don't see a right or wong here, just a typical
engineering trade off.

Thoughts or other ideas?
