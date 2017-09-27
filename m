Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1B220A26
	for <e@80x24.org>; Wed, 27 Sep 2017 21:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbdI0VCv (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 17:02:51 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:53151 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751946AbdI0VCu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 17:02:50 -0400
Received: by mail-it0-f43.google.com with SMTP id c195so8189882itb.1
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 14:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=plIHrGiHVR+oUtV22uEh0duYZvbWPb4q8OrvnswWB1s=;
        b=tuGa3nbZOctjiBC4NuYuycNU19wBun3L1/JBN2RE7Sr/GC5OfTDhq495uwOw03JD0x
         b6iAXUrMJhnYfk5Y/f2huihpHlsD4hQtb3MssIKpjDuHR5XOacXP8yzt+bELrGiwnlgE
         AfYnB+77pwszvy+juzhyYWHazJiTW8mzxcaTNPJ11Vv66vhH6YJlKtg+ykJQREj4RfY0
         6ct2+t4UNS8gRNbYLr2pkukXOnEu0ONye4ovTsqrdtj0xEM1U4r/7CaVDB2yPKxDHsuV
         fRYsXoeZufo9k7kHurHCioy+JZkNPr4SV7B5q/5jaDWDOZNTVbG9PKi2w08CiIMr9lCB
         afHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=plIHrGiHVR+oUtV22uEh0duYZvbWPb4q8OrvnswWB1s=;
        b=ISe9gI6QFy7IaFurJ1L9ZcCaHaZDDmXAY/RQLQXxIrVRx2zSInH4IeA8fzzbKB4wKw
         4DmLnomF9Q787Wbn8iOWuGXAQjCIYoUA0Fn9zHQf0Csaiuc1Yyb1wFux++7YfewQunyO
         GHWGZY5QJy9oqb8Ge9LaErZyBsbj3Y8k9MO+Pa8XHgtVJDwrb13G6o1PYWvTOu6Snnoa
         K9fPX9u33F24MH+v0yyF9NbMYLwdwAU7KwEoH+he9SB4us/0WzN9hU5ar39VYZ0KNSDy
         j9s00XvN5qGw6q8hAjWW75WwLXc6V6wRXINodY9Dk0RQJk6U4WSn2YnW4poAsR18PrLQ
         qfzQ==
X-Gm-Message-State: AHPjjUjMLjjhpABO83u/p012P+pNsLVY183h6NzZDFxeV5+bZdX6y5Fb
        HulNSvyZu6gjPl1PQAVSIvd+hJ3c+cVxos8ekEA=
X-Google-Smtp-Source: AOwi7QBMMSfBmJsdOfqk6VdbC1dykU3S6FFQyuou7fKCcbmi649MJ4F7g6/ATpV/J4UFBXyeIa2xjRY3qvtqjNJU3wM=
X-Received: by 10.36.93.136 with SMTP id w130mr2595534ita.37.1506546169401;
 Wed, 27 Sep 2017 14:02:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.103 with HTTP; Wed, 27 Sep 2017 14:02:48 -0700 (PDT)
In-Reply-To: <CAGZ79kZF5w7ucbUCKJAuAbz2KBoMJjWneAxFcjOPeted8SBNmg@mail.gmail.com>
References: <CA+55aFzThd6cayUVuv39k=sb8KCphLkWGCV4n2HUjfn7Pxkd3g@mail.gmail.com>
 <CAGZ79kZF5w7ucbUCKJAuAbz2KBoMJjWneAxFcjOPeted8SBNmg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Sep 2017 14:02:48 -0700
X-Google-Sender-Auth: ogPCz3gZ1_JN2sPfoyG8OBIovfs
Message-ID: <CA+55aFxwNOLaoeg64CYb-a6c89ceVbfc0b5vG_WCzyNBwynwfQ@mail.gmail.com>
Subject: Re: diffstat summary mode change bug
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 1:40 PM, Stefan Beller <sbeller@google.com> wrote:
>
> I disagree with this analysis, as the fix you propose adds the
> new line unconditionally, i.e. this code path would be broken
> regardless of "show filename or not".

Right. Because it is what we want.

The old code (before that commit) used to have two different cases:

                fprintf(file, "%s mode change %06o => %06o%c",
line_prefix, p->one->mode,
                        p->two->mode, show_name ? ' ' : '\n');

ie if "show_name" was set, it would *not* print a newline, and print a
space instead.

But then on the very next line, it used to do:

                if (show_name) {
                        write_name_quoted(p->two->path, file, '\n');

ie now it prints the filename, and then prints the newline.

End result: it used to *always* print the newline. Either it printed
it at the end of the mode (for the non-show_name case), or it printed
it at the end of the filename (for the show_name case).

Your patch removed the '\n' entirely.

My patch makes it unconditional, which it was before your patch (it
was "conditional" only in where it was printed, not _whether_ it was
printed).

> I wonder why our tests failed to tell us about this.
>
> Specifically we have t4100/t-apply-4.expect
>   mode change 100644 => 100755 t/t0000-basic.sh
>   mode change 100644 => 100755 t/test-lib.sh
> which would seem to exercise this code path.

That only tests "git apply --stat --summary".

It doesn't test "git diff" at all.

And the "mode change" printout is entirely different code (see apply.c
vs diff.c).

                 Linus
