Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67E151F404
	for <e@80x24.org>; Wed, 20 Dec 2017 19:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755474AbdLTTii (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 14:38:38 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:40757 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755501AbdLTTih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 14:38:37 -0500
Received: by mail-qk0-f174.google.com with SMTP id q14so15346668qke.7
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 11:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dVL0P+hyOCnlLwueFqtys9m1fK4zSrZ+9ZVkdVTJLg8=;
        b=TfYukuGAd4YumCXMYBKUDL5H0QQMXo/Kiiiz7qoZcSnzp6HvS4VPGNLJ3pSTfgfTIS
         e/juTaT5IdvObeglyeeTnSDhRnesFqevKEiJ88U0zM/bBaKu6aEUb/d2D8aEanQEuZY9
         Gd1b6gVyDNTHsjQIDuC/XVamVMMteoytStirIVSmO/ni26hMHpwCq6WVrWqFyOfoJADg
         A+aGxDYa//oF6nJFhAuRCplpmrvXUOQ/SmE1YbD68ZruBlsHYrs87QqpS5PuOzXLvwBg
         5kfLkbxgKKdX4KvQ1+Li9c7ytH1TxWsBAaK8ynUaFHn1kqU0JtJar+63e5LE3llbgOsk
         LVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dVL0P+hyOCnlLwueFqtys9m1fK4zSrZ+9ZVkdVTJLg8=;
        b=ZNSNg8FYrTAB06wzQ8xPHNoa2xkchLcUS4C3UdzAOcvGuo5DiAZ6GeWhtU7y5NehNG
         QdOQEA5uvrfU58EwBPXj12N8qu5yT2L0qeY8YxNFMlhAUOU/QBCJaFktmoOamIDdrLaG
         a2RMhSSBGmQrBoi4OwePGttBSMiiDZcz2frYCnig+xH+ER2epCNEE1GtirpRNCqoVRJZ
         WQe7kzWHdi7t0JhfknE0YrBMXslp7kU497Mm3KC7HnQorAFmPxBXGn5RbOB87bYp2rNZ
         UAkNqaifTVK/wAFcJhcJ3uMADJufRLwXk7RzTpKVpu4+XcQOI+fezSZUdGNh5pgBACU1
         eq+g==
X-Gm-Message-State: AKGB3mJM13lFwn9JtBM1uuDmECZYOC1XgZwubqy3ypbEL22eNxUC0t3I
        a7Y+E9a3hM1MYP0DmR9mQTYrzZn7tXP/QBJk9JOItA==
X-Google-Smtp-Source: ACJfBoupb7UGDTgw0DeNvyf5LOVhRS2qSOCliiKDUVb5QE7nT3eXI0jKCGeWaJYm3YgwP/JjchOqIhvEdn1Xgim3G9I=
X-Received: by 10.55.76.10 with SMTP id z10mr5523298qka.346.1513798716277;
 Wed, 20 Dec 2017 11:38:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Wed, 20 Dec 2017 11:38:35 -0800 (PST)
In-Reply-To: <CAGZ79kZpY8iXhCUOB=KuwGPOr7zvV7z+Q-L43p28=7ydaTvutg@mail.gmail.com>
References: <20171219222636.216001-1-sbeller@google.com> <20171219222636.216001-6-sbeller@google.com>
 <20171219224431.GG240141@aiede.mtv.corp.google.com> <CAGZ79kake8k2dM=NPwNoqB5Vkxy+k67PACz01-aXx6-njcisgQ@mail.gmail.com>
 <20171220000148.GJ240141@aiede.mtv.corp.google.com> <CAGZ79kZpY8iXhCUOB=KuwGPOr7zvV7z+Q-L43p28=7ydaTvutg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 20 Dec 2017 11:38:35 -0800
Message-ID: <CAGZ79kZ37hwHtu=n3He9P5p6mXkoRgL6yVo5Xz07yrUYKm7p7A@mail.gmail.com>
Subject: Re: [PATCH 5/5] submodule: submodule_move_head omits old argument in
 forced case
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 11:36 AM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Dec 19, 2017 at 4:01 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Stefan Beller wrote:
>>> On Tue, Dec 19, 2017 at 2:44 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>
>>>>   checkout -f
>>>>         I think I would expect this not to touch a submodule that
>>>>         hasn't changed, since that would be consistent with its
>>>>         behavior on files that haven't changed.
>> [...]
>>> I may have a different understanding of git commands than you do,
>>> but a plain "checkout -f" with no further arguments is the same as
>>> a hard reset IMHO, and could be used interchangeably?
>>
>> A kind person pointed out privately that you were talking about
>> "git checkout -f" with no further arguments, not "git checkout -f
>> <commit>".  In that context, the competing meanings I mentioned in
>> https://crbug.com/git/5 don't exist: either a given entry in the
>> worktree matches the index or it doesn't.
>>
>> So plain "git checkout -f" is similar to plain "git reset --hard"
>> in that it means "make the worktree (and index, in the reset case)
>> look just like this".
>
> with "this" == the argument that was given, if the argument
> was omitted, HEAD is assumed.
>
>>  checkout -f makes the worktree look like the index;
>
> No, here is what my installation of git (recent master) does:

Well, you are technically correct, the worktree is made look like the index,
but prior to that the index is reset to the HEAD, so for me it is
easier to understand
as "make worktree and index like HEAD"
