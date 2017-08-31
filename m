Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D440208CD
	for <e@80x24.org>; Thu, 31 Aug 2017 18:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbdHaSME (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Aug 2017 14:12:04 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:34826 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdHaSMD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2017 14:12:03 -0400
Received: by mail-yw0-f175.google.com with SMTP id s187so2043871ywf.2
        for <git@vger.kernel.org>; Thu, 31 Aug 2017 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=El8w+e3XZC1Xf0y8/SnBVOhdeBVGBYAqpPCRGgifEpw=;
        b=TZJOFioAAs7QDwCHjay+jxXMnqy2AA0D4k8V4l05eJIM0C7OpVkC8X5TJlDGmWne9i
         VCwAs1LDErPb7U86QyUkGPfe10tWJ4Tx3aAk6zFacWRQczR0qekgJOfwjgxHCRNNe0/4
         vn3UQuyKoPq/OiR8fGfje15OwW/l5PAEYdjJyjev3HFUB4e02iJFSkerFcFn//PhNrrp
         vtXEQJZo+tCtpocpIH+zpxe39WIm1IV3QwKJTwglmgAlW55oWW+B3kbvm+A8+M8fudG4
         m0QptxBnOH2fmRNEm6TjuOEB/axtGuiSgK6bc6MAQlKNgaoB55qGriXkC3f7rFGLmOvJ
         ZzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=El8w+e3XZC1Xf0y8/SnBVOhdeBVGBYAqpPCRGgifEpw=;
        b=hS9C8wA4R5NGk4rPCbYEPBtnl4CdycZdaDd/DfU8lKUyRMSOqAmyYqSerSQ447mWSV
         TT9Dje5IcNTXWeootBzXg1oLOIJZ9j9Uns6wV4s+OQYs2BNi8ef1RVRb6rlNAQSI2ksy
         CkyNc74pUe36j7i+xjWv55IBisdtAe21MfYX95ktmUR5uqT1m8PROp6CFRN5eSpNAukX
         ksN/K8TeJYz6VnR5qR70hhpPUQSg8Auc0hAV87G16bQ2iwLrmJrZbYF6+jZHdEHkrRLV
         vqgBqJ2d/D/6DtYOlmiXY6SlIb9Gffo5XX5QFuKcS9XKl8QlBxryZ9SS9p1AZB9ltU5Z
         Vf4g==
X-Gm-Message-State: AHPjjUj2Yd0US2EfUEt8MfDExoz4POosV7u6CTyJkdMSxjKcd28B6+mf
        MWUFYKnbhSJok6fxMhv3XObyJ1Aqswcj
X-Google-Smtp-Source: ADKCNb5PM//VdMw/tAN4lI5Zd7dJeJGE7aMnsuBt/fEYlKy38QnIyk5+2nF9+Et+sI8iT1KCB3BFmM0NyrxNGzQyQiE=
X-Received: by 10.37.163.130 with SMTP id e2mr592063ybi.215.1504203122562;
 Thu, 31 Aug 2017 11:12:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.21 with HTTP; Thu, 31 Aug 2017 11:12:01 -0700 (PDT)
In-Reply-To: <DM2PR21MB0041575B6D9EE53A07C7D3EDB79F0@DM2PR21MB0041.namprd21.prod.outlook.com>
References: <20170828202829.3056-1-kewillf@microsoft.com> <20170828202829.3056-3-kewillf@microsoft.com>
 <20170829081752.nq5r776rjyf2amzh@sigill.intra.peff.net> <DM2PR21MB0041575B6D9EE53A07C7D3EDB79F0@DM2PR21MB0041.namprd21.prod.outlook.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 Aug 2017 11:12:01 -0700
Message-ID: <CAGZ79kacO12xkjt3nBEyyY9VBkdDu+uJ2AnzzEkMnovcO5bigw@mail.gmail.com>
Subject: Re: [PATCH 2/3] merge-recursive: remove return value from get_files_dirs
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 8:58 AM, Kevin Willford <kewillf@microsoft.com> wrote:
>>
>> On Mon, Aug 28, 2017 at 02:28:28PM -0600, Kevin Willford wrote:
>>
>> > The return value of the get_files_dirs call is never being used.
>> > Looking at the history of the file and it was originally only
>> > being used for debug output statements.  Also when
>> > read_tree_recursive return value is non zero it is changed to
>> > zero.  This leads me to believe that it doesn't matter if
>> > read_tree_recursive gets an error.
>>
>> Or that the function is buggy. :)
>
> That was one of my questions as well.  Should read_tree_recursive
> be propagating a -1 and merge_trees be checking for that and bail
> when the call to get_files_dirs return is < 0?  I made a commit with
> this change and ran the tests and they all still passed so either this
> return really doesn't matter or there are not sufficient tests covering
> it.
>
> I went with this change because it was not changing any of the
> current functionality and if we find a case where it matters that
> read_tree_recursive fails due to bad tree or something else we
> can address it then.
>
>>
>> I'm tempted to say that we should probably die() when
>> read_tree_recursive fails. This should only happen if we fail to parse
>> the tree, or if our callback (save_files_dirs here) returns failure, and
>> the latter looks like it never happens.
>>
>> > Since the debug output has been removed and the caller isn't
>> > checking the return value there is no reason to keep calulating
>> > and returning a value.
>>
>> Agreed, and I'm happy to see dead code go.
>>
>> Minor nit: s/calulating/calculating/ in your commit message.
>
> When will that spell checker for git messages be ready? ;)

Different workflows need different setups apparently.
(me, as a heavy user of git-gui, likes the builtin spell checker,
though I need to find a way to train it to accept git lingo, such
as "submodule", or "gitlink")

Maybe:
https://tarasalenin.wordpress.com/2010/09/11/configure-git-gui-spell-checker-on-windows/

If you do not use git-gui... you are at the merci of your $EDITOR
($GIT_EDITOR, or core.editor) to have spell checking.
