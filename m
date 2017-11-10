Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D741F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 22:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754194AbdKJWID (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 17:08:03 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:49937 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751206AbdKJWIB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 17:08:01 -0500
Received: by mail-qt0-f182.google.com with SMTP id p44so3111138qtj.6
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 14:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ihWNU/1Dl2Kh2T1LpDM0fCqGN7PbMigPCecd/BfRf5U=;
        b=m3RM+B/atiFw/Ox/cEZvwh195sEPIndq9azoNflhPsyxRP2r3ep+ZRkCW0+wPSfIfz
         Ox70N+ldIwk/1b5MQYAvd19TQizl9Y3wXFUQZHECZYBJaeIHGWK8xKrVo5SG9UdDiPAR
         Vfx6bdLChPJ8rmCzFWpmoPWF9Y4+pU5ExnhwSdD4n0CzqNqkw9RguO0vY71R3qA6ma3V
         CEeIFb/TkqE+y2KYhZX9NmZPIUmJT6JcC7KADCemDTf9rT/uXJ8xLkduaPt5GMGvf0YD
         ZV7HXqV3uRbTLcM+1xpT9crmRX+hr1i0oYmXVr7XHb/rcpvFdd2E5RXmZmpSujSbb2+p
         kmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ihWNU/1Dl2Kh2T1LpDM0fCqGN7PbMigPCecd/BfRf5U=;
        b=R7eNbnSefFLiS5wkm0VWHh/ksJGUl55AMIb6ftmXM0jbTUQjC595q80hddk+rFoozl
         +OHL0EY6IM7APM3Zi8/F69eieuBXyDEyC3iDucHsqTNmr7KGn9nW7VHIcSkIuZEs4MWC
         3AhlOHWrgdIwQ5qVzs1jVwFhsMiRY8eB0Lp7o+L8j20a5+s9GgT5mxJtu2Rez81kxH8S
         mJYs/KmnyUDFNMVA2v62Z+YOeQ9tvnBJwtCw8wTiUqPeQto2joeduJJNxj68Ba8jGCsS
         BytSlsEVG2Z+1nn1a1ZbQUGLF5H8IMy7mDBZQnBU9PHxOltiPXFLIG6FnEz1XuT8ib8e
         k6ww==
X-Gm-Message-State: AJaThX6rSklLAeDmTIJ58vv1M5yLucIxtV+HnOCz9WW6b4kKhhmv+iHC
        UGUygf/KlMNWn5cFvm9TE77YDGgfWXLq1mF9LFI=
X-Google-Smtp-Source: AGs4zMYSdSV4HzdGHKS6Ziil6tVNTKZRSzidkGqd21AtWU0fwVeaGjUsVEMZo+kylYazQNAwVxO6vP62P9ugk08I3JI=
X-Received: by 10.200.5.2 with SMTP id u2mr3005966qtg.217.1510351680907; Fri,
 10 Nov 2017 14:08:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Fri, 10 Nov 2017 14:08:00 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1711101609240.6187@localhost.localdomain>
References: <alpine.LFD.2.21.1711101123280.6717@DESKTOP-1GPMCEJ>
 <CAPig+cRtpmtD8XqhdXrn1iWOEf9Yx=TXQB=yvXBZ+uR_+XRcPg@mail.gmail.com> <alpine.LFD.2.21.1711101609240.6187@localhost.localdomain>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 10 Nov 2017 17:08:00 -0500
X-Google-Sender-Auth: xp_LLvuZUC5gSPH7Kqb-gwhbw8w
Message-ID: <CAPig+cRYnwG4aTFh_5pgARbjoKPfzMBE12w4Boc6tzyKg54T1w@mail.gmail.com>
Subject: Re: [PATCH] bisect: mention "view" as an alternative to "visualize"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 4:13 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Fri, 10 Nov 2017, Eric Sunshine wrote:
>
>> Thanks for the patch. Some comments below...
>>
>> On Fri, Nov 10, 2017 at 11:32 AM, Robert P. J. Day
>> <rpjday@crashcourse.ca> wrote:
>> > Tweak a number of files to mention "view" as an alternative to
>> > "visualize":
>>
>> You probably want to end this sentence with a period, not a colon.
>
>   not sure about that, what's the standard when you're introducing a
> code snippet?

It wasn't clear that you were including a snippet since it's not
common practice to include the diffstat in the commit message on this
project...

>> >  Documentation/git-bisect.txt           | 9 ++++-----
>> >  Documentation/user-manual.txt          | 3 ++-
>> >  builtin/bisect--helper.c               | 2 +-
>> >  contrib/completion/git-completion.bash | 2 +-
>> >  git-bisect.sh                          | 4 ++--
>> >  5 files changed, 10 insertions(+), 10 deletions(-)
>>
>> The diffstat belongs below the "---" separator, otherwise this text
>> will (undesirably) become part of the commit message proper.
>
>   no, i actually want that as part of the commit message. my standard
> is, if there are 5 or more files that get changed, i like to include a
> diff --stat in the commit message so people viewing the log can get a
> quick idea of how much has changed. if that's not desired here, i can
> remove it.

The same information is available to anyone interested in it simply by
asking for it:

    git log --stat ...

More generally, commit messages should contain the really important
information you want to convey to the reader which _isn't_ available
some other way (by, for instance, taking advantage of the tool itself
-- such as the above --stat example).

On this project, the diffstat is never included as part of the commit
message, and it's likely that the patch won't be accepted by Junio
like that (or he'll just edit it out if he does accept it).

Thanks.
