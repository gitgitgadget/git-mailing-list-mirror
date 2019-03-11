Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951A720248
	for <e@80x24.org>; Mon, 11 Mar 2019 22:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbfCKWx4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 18:53:56 -0400
Received: from kwanyin.sergiodj.net ([158.69.185.54]:56084 "EHLO
        kwanyin.sergiodj.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfCKWx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 18:53:56 -0400
From:   Sergio Durigan Junior <sergiodj@sergiodj.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Possible race condition with git-rebase + .git/index.lock
References: <87k1h55bx0.fsf@sergiodj.net>
        <CAPig+cS_NLgwr6F2OqMpMZ3GBO-Cyru3G3UBxiT4ULJ_V1Bqvg@mail.gmail.com>
X-URL:  http://blog.sergiodj.net
Date:   Mon, 11 Mar 2019 18:53:53 -0400
In-Reply-To: <CAPig+cS_NLgwr6F2OqMpMZ3GBO-Cyru3G3UBxiT4ULJ_V1Bqvg@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 11 Mar 2019 18:50:20 -0400")
Message-ID: <87bm2h58fy.fsf@sergiodj.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, March 11 2019, Eric Sunshine wrote:

> On Mon, Mar 11, 2019 at 6:17 PM Sergio Durigan Junior
> <sergiodj@sergiodj.net> wrote:
>>   # git rebase origin/master
>>   ...
>>   Applying: commitX
>>   Applying: commitY
>>   Applying: commitZ
>>   fatal: Unable to create '/home/xyz/dir1/dir2/.git/index.lock': File exists.
>>
>> The first thing I did was to check whether the index.lock file existed,
>> but it doesn't.
>
> What platform is this on? If Windows, I'm wondering if something (such
> as a virus scanner) is holding the lock file open long enough to
> prevent Git from actually deleting it (and perhaps Git doesn't notice
> the failed deletion -- until the next time it tries to take the lock).

This is on GNU/Linux (Fedora 28, to be specific).  I haven't had the
chance to test this on other distros, unfortunately.  And since it seems
to be a race condition, it's kind of hard to perform tests that trigger
this.

Thanks,

-- 
Sergio
GPG key ID: 237A 54B1 0287 28BF 00EF  31F4 D0EB 7628 65FC 5E36
Please send encrypted e-mail if possible
http://sergiodj.net/
