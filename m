Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8772035A
	for <e@80x24.org>; Fri,  7 Jul 2017 17:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbdGGR6D (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 13:58:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34030 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdGGR6C (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 13:58:02 -0400
Received: by mail-pf0-f195.google.com with SMTP id c24so5479010pfe.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CdHkKp0vKkndAsRE1n0kJe4ojMH4uVZu6/KbOlyfOT8=;
        b=OIRPK2O7v0nk0WQuAVlyNw68TEG8IjVV+w8WfyLBGq5NZdKIiYVDaZ8JvOsZ4SR/VE
         NccSjRfTcvN4Dtj16J3FRQzimmERkKIn9sX2oEm/PJCIvbrcYiCqw92nj47njv5JA1Nv
         V3d6lRhA2rJpugdvzcHVvY43Dk9AJ8p9Vy5M0EeTsRxKwSRE/XXlOAvQax574z9jF8Sy
         HeoqDiQiWw+T24QKSKvslDlfMHT5hBGsRP+CubYclSaxB2Jnxehh/fnYZLiShB9v8ze4
         zs2vu2MoBgXCl4B0W01o/DSMviDMhq6Wkb8IQD9il+RmKHhml1AXy2wLWAzOqqAi2kJl
         IhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CdHkKp0vKkndAsRE1n0kJe4ojMH4uVZu6/KbOlyfOT8=;
        b=GRznZ0QWq/9hWGuUP8omwSAdBZPma7IBNW+CNrJDPIrp9DwP6WOpFPzJ4KKfyjppTc
         nSgK0e5oxTlLU0HmxPRU0ot0pViAkITjuFP7WlgXmdckyPPsC3UK7++0G5+Inw0Y7QgC
         l4T4PcPTeIS0g2EX8l0a6OZvrn5MLdprzNyiNQ+24BjUlgKxH1U2nu6wlcUxp46TpUtY
         6IFx2/VF149WNAhE4hgW+kzs418ay8YuulmwIVV4DkWMD8IPMoXOSBNuQMEezeyrlzW4
         lU+ZlCMHdQshbC8ilv2VG3FIMcJVXcWhoA22GvJ/yeDo4fIURjnXuFgrxrwzuszqxrtz
         +OCg==
X-Gm-Message-State: AIVw113CZKjDqreZWnwn3lutYAD0PDXi+R06TRF8n0xHZnOV0qK4LAm8
        PMxCrY5u3N+LKC7NDeI=
X-Received: by 10.84.196.131 with SMTP id l3mr4392994pld.232.1499450281341;
        Fri, 07 Jul 2017 10:58:01 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id m16sm9085715pfj.130.2017.07.07.10.57.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 10:57:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dan Fabulich <dan@fabulich.com>
Cc:     git@vger.kernel.org
Subject: Re: Why does git-checkout accept a tree-ish?
References: <EA993AC0-022C-423D-ABD7-4747FA09E7FE@fabulich.com>
Date:   Fri, 07 Jul 2017 10:57:56 -0700
In-Reply-To: <EA993AC0-022C-423D-ABD7-4747FA09E7FE@fabulich.com> (Dan
        Fabulich's message of "Wed, 5 Apr 2017 16:51:40 -0700")
Message-ID: <xmqqshi8b04b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dan Fabulich <dan@fabulich.com> writes:

> I was looking back through git's history, trying to figure out why
> git-checkout has so many features. I was struck by this commit by
> Junio in 2005.
>
> https://github.com/git/git/commit/4aaa702794447d9b281dd22fe532fd61e02434e1
>
>> git-checkout: revert specific paths to either index or a given tree-ish.
>> When extra paths arguments are given, git-checkout reverts only those
>> paths to either the version recorded in the index or the version
>> recorded in the given tree-ish.
>> 
>> This has been on the TODO list for quite a while.
>
> Prior to this commit, git-checkout would only switch branches; you
> could use git-checkout-index to copy files from the index to the
> working tree. But in this commit, git-checkout not only subsumes
> the functionality of git-checkout-index but also learns the
> ability to copy files from an arbitrary branch (now an arbitrary
> tree-ish) into the working copy *and* the the index. (That was
> important because git-reset didn't accept <paths> in 2005.)
> ...
> And so I wonder if anybody knows just why git-checkout gained
> these two features in one commit, without creating a separate
> command.

The whole thread would explain it, I think.

https://public-inbox.org/git/Pine.LNX.4.64.0510171814430.3369@g5.osdl.org/#t

