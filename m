Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176DB1F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 17:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754265AbcJTR2V (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 13:28:21 -0400
Received: from mail-yb0-f181.google.com ([209.85.213.181]:34136 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750720AbcJTR2U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 13:28:20 -0400
Received: by mail-yb0-f181.google.com with SMTP id f97so25295324ybi.1
        for <git@vger.kernel.org>; Thu, 20 Oct 2016 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=212hGRLHThKl5eCfAtYpKptOfWE9b828ICNpBcgSjNE=;
        b=dyeiEh6BYH86K7vV+aBfHlhQToxUgUoKsYpoNK62Ie6/j/9Ao4tUo8r+KAaezKkQbk
         wyxhA4t9geQQ2UhpqyvGE/K+NTUgIyCQRb+sUxQjppJI3edAYoBdiM9U+b+TDbd8fZ2C
         +qMJdwkuZFS+f3XnZUZBDY/nNE5aDhp1AoQGbiIYW/Q8sauz26SRtZnUiZpG0ktcmFjF
         qDm9hAIBf3figTCdQtBh2yP9g+xGz/2zpxVLcwaN2V+jtn//d8v/LFUm4I1kSKqLAIVb
         ZxmcQBe+bJ2tdGXvWfCrju14gL5tzqJ4JTQpHvJn7psEXOsIeTxmdTt6FoBGlOmmG/XN
         OjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=212hGRLHThKl5eCfAtYpKptOfWE9b828ICNpBcgSjNE=;
        b=Ap7MvL+IiMUm6WkVZNIdAi9wilT/SH7EFzr1OAUOmryRXXiuDp0i73SetO2OSlYTTh
         wfaaDiz4qafi8v208u1S5iyjNE1KfLHnBEc/jMmh+badkF2XNQQh09+XX3qlPLMPjbst
         082V9oJ0HsIiIln1wPtfrjl8lqnZUBKaNXbGBvLuL6lKbbQxmkdIXUyLV+Y4yFBXcuNB
         HdbROAhQD5hWUugwV7BWEqs/9M11ZSXhvs24BBTKFpQBZlrzlsJC4tN50OY79oAs3xi+
         iuhfolpwI77l3V8MBWXIFhsUwnio3zSu7v9XDCSW197NXNvlV52nGaFj3vlwOniyd3lH
         ToFA==
X-Gm-Message-State: AA6/9Rm9LiHLsJYhUrKidwwonXH10vfVXYZlUXkg9deRf2iUFizHW+u33i/TysQ8PnvDtBc+JH+bkbMMPvcI9Q==
X-Received: by 10.37.220.141 with SMTP id y135mr3157070ybe.132.1476984499242;
 Thu, 20 Oct 2016 10:28:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Thu, 20 Oct 2016 10:27:58 -0700 (PDT)
In-Reply-To: <xmqqa8dzhtki.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
 <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net> <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
 <20161020021323.tav5glu7xy4u7mtj@sigill.intra.peff.net> <xmqqa8dzhtki.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 20 Oct 2016 10:27:58 -0700
Message-ID: <CA+P7+xq25LcdmtzmBNChiGhGratcdp7m0EOsQuEh68=gJQ9HNQ@mail.gmail.com>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2016 at 9:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>>> I still think it's worth while to add a check for git-commit which
>>> does something like check when we say "git commit <files>" and if the
>>> index already has those files marked as being changed, compare them
>>> with the current contents of the file as in the checkout and quick
>>> saying "please don't do that" so as to avoid the problem in the first
>>> place.
>> ...
>> I suspect both of those would complain about legitimate workflows.
>>
>> I dunno.  I do not ever use "git commit <file>" myself.
>
> Users are different.  I do use this all the time, and it is not
> unusual at all to have changed contents on paths other than <file>
> already added to the index when I do so, i.e. an unrelated small
> typofix in <file> jumping ahead of the real changes I am working on
> in other parts of the tree.
>
> "Please don't do that" would break.  Jacob says "avoid the problem",
> but I do not see a problem in allowing it (it could be that the
> problem Jacob has is in other parts of his workflow, but I do not
> know what it is offhand).

I still think we're misunderstanding. I want git commit to complain
*only* under the following circumstance:

I run "git add -p" and put a partial change into the index in <file>.
There are still other parts which were not added to the index yet.
Thus, the index version of the file and the actual file differ.

Then, I (accidentally) run "git commit <file>"

I want git commit to complain here that the index <file> and acutal
<file> being requested are different and it thinks there's an issue.

I do *NOT* want it to complain if I do "git add -p" and put parts of
<other-file> into the index, and then run

git commit <file>

Does that make sense?

Basically if the index and "git commit <file>" both say "add <file>"
but they conflict in what version of <file> I want it to go "hey..
uhhh.. that's a bad idea"

Thanks,
Jake
