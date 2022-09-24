Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA87AC07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 09:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiIXJdB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 24 Sep 2022 05:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbiIXJdA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 05:33:00 -0400
Received: from clausfischer.com (clausfischer.com [78.46.66.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A83E7E3B
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 02:32:56 -0700 (PDT)
Received: from smtpclient.apple (host-79-16-150-161.retail.telecomitalia.it [79.16.150.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: claus.fischer@clausfischer.com)
        by clausfischer.com (Postfix) with ESMTPSA id CC0D28A0109;
        Sat, 24 Sep 2022 11:32:54 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: Scriptable mode for git bisect
From:   Claus Fischer <claus.fischer@clausfischer.com>
In-Reply-To: <Yy5g80OtVG4op8L1@danh.dev>
Date:   Sat, 24 Sep 2022 11:32:52 +0200
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E10623C2-FF73-4E5B-AD28-C255B02F3B0F@clausfischer.com>
References: <Yy4c6/jHupgThj7j@clausfischer.com> <Yy5g80OtVG4op8L1@danh.dev>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I tried that but it turns out it does not always stop at the bad revision.

Claus

> On 24.09.2022, at 03:44, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> 
> On 2022-09-23 22:54:03+0200, Claus Fischer <claus.fischer@clausfischer.com> wrote:
>> 
>> Dear Git maintainers,
>> 
>> I have looked at the manpage of git bisect but have not found
>> what I need:
>> I would like git bisect not just to report the 'bad' revision
>> within a bunch of text but instead either stop at the first
>> bad revision (the last good will then be HEAD~1) or report
>> it in a scriptable way, i.e.
>> 
>>  BADHEAD=$(git bisect run --shut-up-and-report-the-bad)
>> 
>> Have I overlooked anything?
> 
> After running "git bisect run"
> You can take its revisions with:
> 
> 	BADHEAD=$(git rev-parse --verify refs/bisect/bad)
> 
>> 
>> ***
>> 
>> The pourpose is to keep the source trees of two different
>> projects that share a few files synchronous.
>> My good/bad-script is a script that checks whether these
>> files are similar.
>> I want git to stop at the first change in source tree A
>> so that I can update source tree B with the same commit
>> message, then proceed to the next change in A that
>> changes one of those files.
>> 
>> Regards,
>> 
>> Cluas
> 
> -- 
> Danh

