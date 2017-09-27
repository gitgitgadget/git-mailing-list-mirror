Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6EB42047F
	for <e@80x24.org>; Wed, 27 Sep 2017 21:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbdI0VJX (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 17:09:23 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:52666 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbdI0VJW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 17:09:22 -0400
Received: by mail-qt0-f173.google.com with SMTP id o52so15093016qtc.9
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 14:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yWNgVri24usxsQU/smcnV9+XGsTdGHAPFURatVWZtJM=;
        b=hNs/N1RvCzzOl1j/meBkTknyys0ImRmPO3fIlOSNTsE2q19ES8LYX3CE0Os41p/Bjq
         A+ypDBNmNpD9nq5R4hXJsSFlAEVvTI7kO6kLQXEV6H8drvAxDcPF3j2eBUSIvToQ1M7Q
         vhrgg4cy0O1LAVCewLOip5p49niJZfCNI72XKHRU9swT12LUCGpZmWqKZi+kq/FJk06C
         9KHUA6tlrL/4zb3o4MS0wJdUYb4NpmKX6dfITPa0o8eE5Dl6MPN9UcR80KYcHM6ZaYKr
         B/eNBazKd3hBGAJOo1cIog/A6vkbxKQjkQiUwOzB2O7+F2QCsbRC1PN2BPUc4QyZh0Tf
         /75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yWNgVri24usxsQU/smcnV9+XGsTdGHAPFURatVWZtJM=;
        b=Sdi8PheXUXcSZNnrSR+sYhydgUOUPGlic4TzdZFPrFqT8dLqt49LIzrnmCTEnLuPWb
         xMqTR7z25t6UVOUVREGkd0Lqz1gnAvCvfCUYwNVARymDFlMEiRfVC2jmaaGNueD55G5A
         fyTXLzqa6hHxbyt3aITC8gWonn5NEPegIMvi6HxJQ5YI3iRFV+1Es6Ga8qOmvc8kzVjp
         B+YDi/Y4fx6f0BjRVs6glhlz1r/dkdhL/rwT+AOsftevcceDs5FK9kZTyE/XpQHP3Wx7
         15LponWUL3q20DyyjBSamjDoP7GeOHmbpZ5eqFqTZxo82k13FqQC+HlVp2GZuGwjKmrG
         n+YA==
X-Gm-Message-State: AHPjjUjI/iHTrbaRB1cGh078YGK1eSI4ea2XLX/ioWBuB6aImHEDZUR7
        qMmMeyojCEb4hqF1DYiW32/7OzApWEgOn35HR7MnIQ==
X-Google-Smtp-Source: AOwi7QDiDCvIJJQ+7UoRjWxN0XdF3DcSj5OsV9V9Ch0ARZAjyvlHaHNmmp5YBDwkyHKGx8itIA7K7d+Fe7gUQM28Xdg=
X-Received: by 10.237.53.23 with SMTP id a23mr4248682qte.125.1506546561519;
 Wed, 27 Sep 2017 14:09:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.51 with HTTP; Wed, 27 Sep 2017 14:09:20 -0700 (PDT)
In-Reply-To: <CA+55aFxwNOLaoeg64CYb-a6c89ceVbfc0b5vG_WCzyNBwynwfQ@mail.gmail.com>
References: <CA+55aFzThd6cayUVuv39k=sb8KCphLkWGCV4n2HUjfn7Pxkd3g@mail.gmail.com>
 <CAGZ79kZF5w7ucbUCKJAuAbz2KBoMJjWneAxFcjOPeted8SBNmg@mail.gmail.com> <CA+55aFxwNOLaoeg64CYb-a6c89ceVbfc0b5vG_WCzyNBwynwfQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 27 Sep 2017 14:09:20 -0700
Message-ID: <CAGZ79kbCgTNaunfneWHP3xkLeXwW72CZZWs7Sv8A7QL_UYE_HQ@mail.gmail.com>
Subject: Re: diffstat summary mode change bug
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 2:02 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Sep 27, 2017 at 1:40 PM, Stefan Beller <sbeller@google.com> wrote:
>>
>> I disagree with this analysis, as the fix you propose adds the
>> new line unconditionally, i.e. this code path would be broken
>> regardless of "show filename or not".
>
> Right. Because it is what we want.
>
> The old code (before that commit) used to have two different cases:
>
>                 fprintf(file, "%s mode change %06o => %06o%c",
> line_prefix, p->one->mode,
>                         p->two->mode, show_name ? ' ' : '\n');
>
> ie if "show_name" was set, it would *not* print a newline, and print a
> space instead.
>
> But then on the very next line, it used to do:
>
>                 if (show_name) {
>                         write_name_quoted(p->two->path, file, '\n');
>
> ie now it prints the filename, and then prints the newline.
>
> End result: it used to *always* print the newline. Either it printed
> it at the end of the mode (for the non-show_name case), or it printed
> it at the end of the filename (for the show_name case).
>
> Your patch removed the '\n' entirely.
>
> My patch makes it unconditional, which it was before your patch (it
> was "conditional" only in where it was printed, not _whether_ it was
> printed).

I agree with this.

>
>> I wonder why our tests failed to tell us about this.
>>
>> Specifically we have t4100/t-apply-4.expect
>>   mode change 100644 => 100755 t/t0000-basic.sh
>>   mode change 100644 => 100755 t/test-lib.sh
>> which would seem to exercise this code path.
>
> That only tests "git apply --stat --summary".
>
> It doesn't test "git diff" at all.
>
> And the "mode change" printout is entirely different code (see apply.c
> vs diff.c).

Why doesn't this surprise me at all?
(Whenever I write emails I assume the best of Gits code base, such
as non-duplicated code. "It's all in the mighty diff machinery".)

In that case let me write a test for this and resubmit
your fix without whitespace mangling.

Thanks,
Stefan
