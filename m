Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E7DC6FA82
	for <git@archiver.kernel.org>; Sun, 25 Sep 2022 12:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiIYMmw convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 25 Sep 2022 08:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIYMmu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2022 08:42:50 -0400
Received: from clausfischer.com (clausfischer.com [78.46.66.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555B52F002
        for <git@vger.kernel.org>; Sun, 25 Sep 2022 05:42:49 -0700 (PDT)
Received: from smtpclient.apple (host-79-16-150-161.retail.telecomitalia.it [79.16.150.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: claus.fischer@clausfischer.com)
        by clausfischer.com (Postfix) with ESMTPSA id C02D78A0463;
        Sun, 25 Sep 2022 14:42:46 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: Scriptable mode for git bisect
From:   Claus Fischer <claus.fischer@clausfischer.com>
In-Reply-To: <Yy+n7/NolP5rCpwX@danh.dev>
Date:   Sun, 25 Sep 2022 14:42:43 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <C9CD178B-7A21-4F89-9D74-7CBD68DBF0C2@clausfischer.com>
References: <Yy4c6/jHupgThj7j@clausfischer.com> <Yy5g80OtVG4op8L1@danh.dev>
 <xmqqwn9srb9e.fsf@gitster.g>
 <69B998A9-0E3E-45F0-8733-F2A3F11625A5@clausfischer.com>
 <Yy+n7/NolP5rCpwX@danh.dev>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oh thank you, I didn’t know that / didn’t grasp that while reading (apparently too fast) your previous mails.

That is way nicer.

Thank you.

Claus

> On 25.09.2022, at 02:59, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> 
> On 2022-09-25 01:46:13+0200, Claus Fischer <claus.fischer@clausfischer.com> wrote:
>> Well since I usually don’t have many revisions backwards, typically
>> no more than 50, I can just traverse the tree backwards from main.
>> I remember the last ‘bad’ revision before the good one.
>> So there’s a solution for me.
>> 
>> Yes the bisect command puts the correct ‘first bad’ revision in its
>> output but it’s surrounded by a large amount of useless text. It
>> would be nice to have a ‘quiet’ flag that lets it output just the
>> bad revision. Alternatively, that it ends by checking out just that
>> bad revision before revert.
>> 
>> My problem is solved by stepping backwards to HEAD~1 each time, but
>> you might consider making bisect more scriptable.
> 
> No, you don't need to parse "git bisect" output to get the "first bad"
> revision. The "first bad" revision is stored in refs/bisect/bad.
> 
> And you can take the "first bad" revision in a scriptable way with:
> 
> 	FIRST_BAD=$(git rev-parse --verify refs/bisect/bad)
> 
> Of course, after finishing bisecting.
> 
> -- 
> Danh

