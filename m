Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82ADE1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 22:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753519AbeBFWnU (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 17:43:20 -0500
Received: from mail-yw0-f170.google.com ([209.85.161.170]:44720 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbeBFWnT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 17:43:19 -0500
Received: by mail-yw0-f170.google.com with SMTP id x62so2543473ywg.11
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 14:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=6g9ZtGeVv6Q8C+iP7CyMFRMcC6r4DSq1oSkSppEEUck=;
        b=P+nSosBQ6u+dFRyzOcyQz10puhF4fDn4nII2JUef5orsmwgWEeCD0cd9Z4nA5kZv+W
         KHi7fWD7P7ZOsJ8SlYKdFpEsH/NGf92kGZy18jzuAiMdHSykx3xYsJAL+eWJVompE+aN
         lcu0ImOnTBvLsg+ymIYzK44cPbsSjtS6W9i1VFlK7XozI/PrWopFL3kSXOCoqqMUG/YJ
         3G0SVlPQlPDsnfwzNrWIufuOdbrfs98z92l4NjjhrKPUWEBT03lY/uaHnESuuRDb8Iwu
         4yWOySzMFJD/fOetbukyQlc9iCTRVhjl3AeM4h7vxTCWR7wo247UY+wHnJvMQZbXfOCH
         RQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=6g9ZtGeVv6Q8C+iP7CyMFRMcC6r4DSq1oSkSppEEUck=;
        b=su6aSOGIwfRX7LuI0sI9yRvrQYjZJqh+6c8w3egB87I069ucGRaj9ORnBZ3javp0vV
         w6hc2CCIBynQ/V1vGy/w2zai/3jcicCtVKr0UGu7zVxIe31Qhia5aZKhl7m+FvlrGGAV
         OYWNfRm8Kd4gw0VJNY4F3heLaP+y4zgsztGb7IWIw/UcaL2afX8gkgULwncznJ+GeRFZ
         6QIVjvHYFk8J6pyy7nqWB8w6ovhmZyhfBFuaEV4IeAI2wdC0nncrxRe1v4HSi2pfE+Sr
         8ljvhIbDakwu7CMZdjeoIP6UK0I5KMTPGKWD+R3+7kw6ubt/Nf72EYHDRwUw0RK9WTTV
         165Q==
X-Gm-Message-State: APf1xPBghBnPnCs3uGJogMpuf4hIDueX+5y2pq6TydR+855oy5ktu1bC
        7V02HuDA3ety0MpXYmwOakSDWQ4nk79ex58/Ls5/fobLRdU=
X-Google-Smtp-Source: AH8x225BFtHjKvrCclDRXCPF2ULkdg9CtCJppG3cSgfE3INfF2JUpjlxK2o4Jz9kXWYTdBh+5BSMYXsXPKDAjZpMnQo=
X-Received: by 10.129.156.134 with SMTP id t128mr2563874ywg.108.1517956998604;
 Tue, 06 Feb 2018 14:43:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 14:43:18 -0800 (PST)
In-Reply-To: <20180206022033.GG7904@genre.crustytoothpaste.net>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-56-sbeller@google.com> <20180206022033.GG7904@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 14:43:18 -0800
Message-ID: <CAGZ79kakYV3aeWcEZDnboLyUodDgE2UU9C4ad8kq8_PRE17HHA@mail.gmail.com>
Subject: Re: [PATCH 076/194] push: add test showing bad interaction of replace
 refs and submodules
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 6:20 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> On Mon, Feb 05, 2018 at 03:55:37PM -0800, Stefan Beller wrote:
>> The ref subsystem has not been migrated yet to access the object store
>> via passed in repository objects. As a result replace when the object store
>> tries to access replace refs in a repository other than the_repository
>> it produces errors:
>>
>>   error: refs/replace/3afabef75c627b894cccc3bcae86837abc7c32fe does not point to a valid object!
>>
>> Add a test demonstrating this failure.
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>
>> squash! push: add test showing bad interaction of replace refs and submodules
>>
>> replace-objects: evaluate replacement refs without using the object store
>>
>> Pass DO_FOR_EACH_INCLUDE_BROKEN when iterating over replacement refs
>> so that the iteration does not require opening the named objects from
>> the object store. This avoids a dependency cycle between object access
>> and replace ref iteration.
>>
>> Moreover the ref subsystem has not been migrated yet to access the object
>> store via passed in repository objects.  As a result, without this patch
>> when the object store tries to access replace refs in a repository other
>> than the_repository it produces errors:
>>
>>    error: refs/replace/3afabef75c627b894cccc3bcae86837abc7c32fe does not point to a valid object!
>>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>
> It appears you have multiple independent commit messages here.

I will drop this patch; it appears as if it was targeted to be part of
006f3f28af (replace-objects: evaluate replacement refs without
using the object store, 2017-09-12), which landed.

We can revive this test outside of this long series if we feel inclined.

Thanks for spotting!
Stefan
