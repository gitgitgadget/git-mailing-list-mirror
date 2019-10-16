Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47AD81F4C1
	for <e@80x24.org>; Wed, 16 Oct 2019 20:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437246AbfJPU5k (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 16:57:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35390 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbfJPU5k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 16:57:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so160122pfw.2;
        Wed, 16 Oct 2019 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6DJo1YDZGNIpjKdZdH6rc462z5b7Cwq3+7UbSq9+XHM=;
        b=qHCnf9eTXKpxO0DjmKS3txfjMTqoAdncu/i9m1IfVP56B4eIBGwSyHrx1AlSdXaX7G
         goSlaz3g76DvM+4BktSv0kODTIZit5TBhjU2RCygkJfuOiC2b8OgXg7S13j4jz2YzegD
         1+oflw0/7V40xm5KaaSL0XuY7T1BMiar92GONOn0NKAP8x70bHQHAiko+gPBSov4pss/
         hrrztV3sq0tf9iqPan5Yj0dRoNxjhbDQEzNUHKKwpoQn+EFMCILx5PzwVqtpNfYnan6e
         W6Xo5GtvlhUP+s515aFxDLVcZEBtKke1y46DPXgp+3v4nqlxJzHcI0F7OD8oUQ3m0+rE
         b9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6DJo1YDZGNIpjKdZdH6rc462z5b7Cwq3+7UbSq9+XHM=;
        b=Q/DKZ/YcUtOuOhStH4O5jEduoxJoVFYeRbeLncIP1pJLDHuO/IpK3w7tjdEQRmKDcT
         8dUX8FjOWH4s84pkXO0qbwCo9FsaGJBzOYVDd8augrbP6SJc7UWhKXFnb7CRsoremYg6
         zwZ7keKovfYsheIBCKcgaY7jMcRYKbBlvpFOPCPCnYJ18NHXhV38s3viUpiMCUNzUZqy
         dDieUApViPlNPsovZi/myujjgukrpdNRFiRZZY3kfMI1escgTFuTxMkp0CakpBDf/oKf
         fJ+3ha6d3llvgIY9gMh3dS1M5FZWR/sGkePj+4itTwQ2+J8aDu56zXZwvQIyJlFV+bK9
         Uygw==
X-Gm-Message-State: APjAAAVRnK3v1JWvnK0DFtZnErkKMnAuRGWeVDW5O8D+5/GteDCUBvwM
        2Rq3sCLtXuxAhdZq9eW+9HIy5cNS
X-Google-Smtp-Source: APXvYqwlSoCKEmM0ff1PN7hnPYf5NP5EflGZDfdZcgd4AO1BAUblQMPPNMgcy7ifaCLANECR/hJ7uQ==
X-Received: by 2002:a63:d50c:: with SMTP id c12mr99234pgg.199.1571259459163;
        Wed, 16 Oct 2019 13:57:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id e17sm29251243pfl.40.2019.10.16.13.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:57:38 -0700 (PDT)
Date:   Wed, 16 Oct 2019 13:57:36 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>
Cc:     workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191016205736.GA259536@google.com>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A few small points.

Vegard Nossum wrote:

> * git am (or an alternative command) needs to recreate the commit
>   perfectly when applied, including applying it to the correct parent

Interesting.  "git format-patch" has a --base option to do some of
what you're looking for, for the sake of snowpatch
<https://github.com/ruscur/snowpatch>.  Though it's not exactly the
same thing you mean.

We also discussed sending merge commits by mail recently in the
virtual git committer summit[1].

Of course, the devil is in the details.  It's straightforward to use
"git bundle" to use mail as a Git transport today, but presumably you
also want the ability to perform reviews along the way and that's not
so easy with a binary format.  Do you have more details on what you'd
want the format to look like, particularly for merge commits?

[...]
>                                                                 there
> is no need for "changeset IDs" or whatever, since you can just use the
> git SHA1 which is unique, unambiguous, and stable.

In [2] the hope was for some identifier that is preserved by "git
rebase" and "git commit --amend" (so that you can track the evolution
of a change as the author improves it in response to reviews).  Is
that the conversation you're alluding to?

[...]
> Disadvantages:
>
> - requires patching git

That's not a disadvantage.  It means get to work with the Git project,
which is a welcoming bunch of people, working on userspace (seeing how
the other half lives), and improving the lives of everyone using Git.

[...]
> Date: Sat, 5 Oct 2019 16:15:59 +0200
> Subject: [PATCH 1/3] format-patch: add --complete
>
> Include the raw commit data between the changelog and the diffstat.

Oh!  I had missed this on first reading because it was in an
attachment.

I have mixed feelings.  Can you say a bit more about the advantages
and disadvantages relative to sending a git bundle?  What happens if a
mail client or a box along the way mangles whitespace in the commit
message?

Happy hacking,
Jonathan

[1] https://public-inbox.org/git/nycvar.QRO.7.76.6.1909261253400.15067@tvgsbejvaqbjf.bet/
[2] https://lore.kernel.org/ksummit-discuss/CAD=FV=UPjPpUyFTPjF-Ogzj_6LJLE4PTxMhCoCEDmH1LXSSmpQ@mail.gmail.com/
