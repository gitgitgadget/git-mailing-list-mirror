Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 023F6208CD
	for <e@80x24.org>; Tue, 15 Aug 2017 22:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752843AbdHOWnx (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 18:43:53 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34780 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbdHOWnw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 18:43:52 -0400
Received: by mail-pg0-f50.google.com with SMTP id u185so14041274pgb.1
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4Y7m2mt/5KEDXFBvmWA00TC7Tpmx8jha2k4yTcFAPzg=;
        b=S43ehJD1x1COin7JVpiZw2/4iBZJwl3w1v+GIhEIHIe+bSbbg9fFMEkcd/AXXHerBw
         L9gsAZSJEU2ai4ir3AhPjmOtp7Sh83phrAPDQ2NFtsLL6L3T95e4PtJ6r/z5MVBpEkiR
         d7piivho/JOBmrus63HyGdeqwWHqq4Hy14M8fue95VM8iVpn0xB2TehL287yyK5ys5xE
         Xi0Z78jheU+fJtoIL55p2bebc6thVahUY3yTUW8cnkxW5nyzI/E+gmIr5HwHwXi71QDs
         qRstmaW6OK/nRMuhras+8OccfqVcRdMJf7tl/uDHaFBBhtoQOHsfdXOrdGUOGRqbSt8e
         lDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4Y7m2mt/5KEDXFBvmWA00TC7Tpmx8jha2k4yTcFAPzg=;
        b=Hfaq7WjZ3M062Fc099SACfg8Dpk75QNI7lPHfAE4FnDKjyZ/r/eE7jAE9TT4e4p7ZO
         Jv+jm/VlP+5EL/rDwUJ2JQoB1Ph/PZjCM8AspzzO9kBHQv8wY4WMVq/LYtSkWANR6LXe
         5hN/wXC9Ukfz0xhhNBGbuRUoWYWRQkJ04idWG0IeTJY7RlZyNfHRWpfNK74D1/tB70Fb
         wmDNat+pAM0WihkGfynkEXCbR9T+8j5Ziy//YqHNFS9EpU/sWPsHbDH6wwHeJZwWfi34
         1yVowtefrGAWx9IMOZSjf7apXK6LSey4pQ6PJrWEz7/b6m+pIht9S+jguQHvbGmYzFR9
         c2wQ==
X-Gm-Message-State: AHYfb5hCPV4jUSCs32ETrtvjozoXSq1rpz+wd7SBsLkvd7s0hy9gzHur
        4nMp3CWCc9d/fCgNuSEDC0Y6dF377OeMUms=
X-Received: by 10.98.223.18 with SMTP id u18mr29543189pfg.166.1502837031840;
 Tue, 15 Aug 2017 15:43:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.132.193 with HTTP; Tue, 15 Aug 2017 15:43:51 -0700 (PDT)
In-Reply-To: <xmqqlgmkpizm.fsf@gitster.mtv.corp.google.com>
References: <20170815203503.12299-1-asottile@umich.edu> <xmqqpobwplde.fsf@gitster.mtv.corp.google.com>
 <CA+dzEBnMOoXYaP7QadQ+gzKKJ7OzJKAPwbW=zr=1fksCQNBVcw@mail.gmail.com> <xmqqlgmkpizm.fsf@gitster.mtv.corp.google.com>
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 15 Aug 2017 15:43:51 -0700
Message-ID: <CA+dzEB=ggLQGaEL21TChLkeiAvCGf4LZ0QFevBZCAEMhxyJwqQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] git-grep: correct exit code with --quiet and -L
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sounds good, I'll wait.

I've also created a mailing list entry on the gnu grep mailing list as
I believe the current exit status for --files-without-match is
inconsistent:

http://lists.gnu.org/archive/html/bug-grep/2017-08/msg00010.html

Anthony

On Tue, Aug 15, 2017 at 3:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Anthony Sottile <asottile@umich.edu> writes:
>
>> Ah yes, I didn't intend to include the first hunk (forgot to amend it
>> out when formatting the patch).
>>
>> I think git's exit codes for -L actually make more sense than the GNU
>> exit codes (especially when comparing with `grep` vs `grep -v`) --
>> that is, produce `0` when the search is successful (producing
>> *something* on stdout) and `1` when the search fails.
>>
>> Shall I create a new mail with the adjusted patch as suggested above?
>
> I do not mind seeing an updated patch that does not change the exit
> status (as you seem to like what we have currently that contradicts
> what GNU grep does) but makes it consistent between "--quiet" and
> "--no-quiet".  But I would not be surprised if people seeing this
> exchange from the sideline are already working on fixing the exit
> status and also making sure that the fixed code would produce the
> same corrected exit status with or without "--quiet", so an updated
> patch from you will likely conflict with their effort.
>
> So if I were you, I'd wait to see what other people would say about
> the actual exit codes we give when "git grep -L" is run without the
> "--quiet" option, and if they are also happy with the current exit
> code, then send in an updated patch.
>
> Thanks.
>
>
