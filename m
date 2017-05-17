Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A51702023D
	for <e@80x24.org>; Wed, 17 May 2017 02:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbdEQCrb (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:47:31 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:36651 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbdEQCra (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:47:30 -0400
Received: by mail-pg0-f42.google.com with SMTP id x64so65886368pgd.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SbOl2Krppx+tPFCqMt9FY94DrRMdoRDekyRxTYgFlVo=;
        b=obRWbKBdE6tzNR818ZzsgH6t356Pqi1XLlLHGKGx8ktlHrhq/qrzGg2uQBo5gEJBcw
         9oUWU239o+YenND6LYU8Tej1imgRnzSsphm2ECXVfpPq08HV753C5xZFRuMqpWAHyFuy
         UugLBAptUUrigcGqg85af4GET2kckbGalJbjzVpD+1/CFDnqAMtj2dMVL8dcqyFtr+n5
         +3F1WyB8XA4BiVYumRqaBNPVwVK3n0MiIk/BoIFk+25hQAKVcaQfU3MADps08D1AEEx5
         T3xwmNuTGn94Pa4PqMy8UYjiDw87EBqRf/S1hzPfA6oDn7Kq3iZ9yTUEmtl8ylorXD5j
         Qltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SbOl2Krppx+tPFCqMt9FY94DrRMdoRDekyRxTYgFlVo=;
        b=E4v+bEKWcECnAjUfECgfUYK+rs1p/+mahjnyit+r2XSypWJRPAhl5oDMBk9DcddM7v
         wI5Oz0PRycb3nVb7p+fNeYD5kbWwxPjOVcd/gvWhP1BVhQZjV3+mrjoq8rCtn1WeLf/B
         VdDTpJcSDG8XhLkXSWG+6cXBak5VTLUpA5kr9OBcXLmTNBIa+S5miWBm+z9xtPwh+RHa
         lZC7IPA28RE+70vOabBATqo2zkFcMo7Lm1aGohNw/LrF0gXt8bea+42JZkjoVOXrr1ku
         dn8UoXAN05WzI/qZhFT45XDCzhoP0rEXK7Vz46HsDNlZIXBJgXWfz8nGZuEGnb8CULnf
         ebXw==
X-Gm-Message-State: AODbwcBu1tEtln45aMl5qiiySK61chN4+2OS2fBjnDODv4FVkXVm9oPX
        tVpVwjVz13MLSg==
X-Received: by 10.84.236.72 with SMTP id h8mr1427477pln.187.1494989249990;
        Tue, 16 May 2017 19:47:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id d13sm639806pfl.12.2017.05.16.19.47.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:47:29 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Diff topic branch + working copy changes?
References: <CAHd499ADTbO09OJhH_wWBbAcXZeLRLFAqOw5eTe6=abN-JUrUA@mail.gmail.com>
Date:   Wed, 17 May 2017 11:47:28 +0900
In-Reply-To: <CAHd499ADTbO09OJhH_wWBbAcXZeLRLFAqOw5eTe6=abN-JUrUA@mail.gmail.com>
        (Robert Dailey's message of "Tue, 16 May 2017 14:31:33 -0500")
Message-ID: <xmqq37c4yzb3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robert Dailey <rcdailey.lists@gmail.com> writes:

> So for a topic branch based on master, I can diff ONLY my changes on
> the topic branch by doing this simple command:
>
> $ git diff origin/master...
>
> However, this does not include uncommitted working copy changes. To
> work around this, I can do this instead:
>
> $ git diff origin/master
>
> (No three-dot notation above)
>
> However this implies a ".." notation which will include changes on
> master that have been made after I branched my topic (I use three-dot
> to exclude those).
>
> Is there a way I can do the first diff but also include working copy
> changes?

I've wished this a few times, but the answer is no.  Not as a
short-hand like "..." anyway.

You can still do 

    $ git diff $(git merge-base origin/master HEAD)

of course.
