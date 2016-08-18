Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50E601F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 01:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754123AbcHSBfQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:35:16 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:38223 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754180AbcHSBdH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:33:07 -0400
Received: by mail-it0-f49.google.com with SMTP id n128so13250382ith.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 18:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2nUz9tbBQGGsePjiJVw7ToC1AAKb/gV57hxGdUr9Q8g=;
        b=AB+ovogkzCOqZq0t1Zz/njCwtTownGu49bPrtSFStst98V12Okgh9gYyDPPxxUGuuT
         EiftJu+HsBfyrJL9Yp/Uj+QeChjE9HL/dCXqSzl7ps9ngum7lM5/8U1r0qE/GpkLXoN9
         V9Ut6L6w7DdgshirYQNvleFPc17TAOOhigTRcRbNGbVNRXVE7vZkIKuKJZiM5WoiXb2i
         wnX3PqL9ILtY1nRQzngvpmyUrg1ib3kEJ5Jbn2y10fLZvndcqvletk+AkHk2d0TJigOF
         fZyMzImhN7Z46M/C33RCV4Ka8vgq0hN8hxbbCI3bvslFYryRiDc/y7g8ywfHERW2EyXo
         IbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2nUz9tbBQGGsePjiJVw7ToC1AAKb/gV57hxGdUr9Q8g=;
        b=YplYUPPeM4aEUfdPuyzulPEzmG0q5TePS59B0ujH3okD1D5NfRv8uShK3hB+w75JlJ
         suWz7EGVrPG1S4rzdDJbvbiUyk7RkMF5ylI0fap8NKJdYtk5gr0qaebqm4z1WK7e/11B
         4Losu+WL+iTtRS6FOMBwPjrdbazcKZ5a1hnUWvMq9XJ6NqrhI6Yx1ZokYnqRLQ6gLt+z
         rv6vURyr6H7VqwsAkMvG15lRh913coB0g6m1F67ORR/ndcxyB0UD9t9gM77qVvMFODKd
         bN/LdVtzwSvjT90QO0zc/rSdXqR8q76FWV0/FnqRPRk/6vrLOWcYWSNW0kYE24TB51Ia
         RAzQ==
X-Gm-Message-State: AEkooutxh+ZrXkq0qnLc4GCYwxXvJ1GRVMF/GEsDtUlMMb3vTvhSBV6DDSMQQ+5jW4hgvpgebDSysyiL07a2ZQ==
X-Received: by 10.36.224.75 with SMTP id c72mr1212502ith.91.1471546245345;
 Thu, 18 Aug 2016 11:50:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.253.71 with HTTP; Thu, 18 Aug 2016 11:50:24 -0700 (PDT)
In-Reply-To: <xmqq37m17w4y.fsf@gitster.mtv.corp.google.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
 <20160818005131.31600-5-jacob.e.keller@intel.com> <xmqq37m17w4y.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Aug 2016 11:50:24 -0700
Message-ID: <CA+P7+xoz=2hzMtX7e79Zpsza5jLAtWMo-g9H9mcwNVd9=BBQKA@mail.gmail.com>
Subject: Re: [PATCH v7 4/7] submodule: allow do_submodule_path to work if
 given gitdir directly
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 11:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Currently, do_submodule_path relies on read_gitfile, which will die() if
>> it can't read from the specified gitfile. Unfortunately, this means that
>> do_submodule_path will not work when given the path to a submodule which
>> is checked out directly, such as a newly added submodule which you
>> cloned and then "git submodule add".
>
> Hmm, are you sure about that?
>
> A call to read_gitfile() turns into a call to read_gitfile_gently()
> with the return_error_code parameter set to NULL.  The function does
> a stat(2), and if the given path is not a file (e.g. we created the
> submodule working tree and repository in-place ourselves, instead of
> cloning an existing project from elsewhere, in which case we would
> see a directory there), it says READ_GIT_FILE_ERR_NOT_A_FILE and
> returns NULL, because that is not a fatal error condition.  The same
> thing happens if path does not yet exist.
>
> This caller is given <path>, prepares "<path>/.git" in buf, and
> calls read_gitfile().  If it returns a non-NULL, it replaces what is
> in buf and continues, but if it returns a NULL (i.e. the two cases I
> mentioned in the above paragraph), it continues with "<path>/.git".
>
> While I do not think changing it to resolve_gitdir() is wrong per-se,
> I am not sure if it is necessary.
>
> I must be misreading something in the existing code.
>

No I think you're correct. I was under the assumption that it would
die here. I think it's probably better to stick with read_gitfile()
here, it should work. The main issue is what happens after this needs
to be fixed.

I'll investigate this more.

Thanks,
Jake
