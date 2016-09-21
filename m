Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640D01F935
	for <e@80x24.org>; Wed, 21 Sep 2016 17:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758584AbcIURyh (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 13:54:37 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38298 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758478AbcIURyf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 13:54:35 -0400
Received: by mail-wm0-f43.google.com with SMTP id l132so104716134wmf.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2016 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1RjCO7jPONpU19hNBOAbJCGNzYj7AOh4Zvq9GTtys3I=;
        b=sasUT1TgAmD/5qpd3KDap67JCkvnRxQBzrHE3H23dIdypql6W0rJEWboHsW/IntmOZ
         0lnZ2FPol3HX+3VdBMDVXy5YmFVno3GSrOWGMXwBA1kt5KhgLYh24iTq7rqy33O4HR64
         f0sTmwZQAHkazOvDsc/oRmFnHskr3r+KNDWODD9q7QYdmUjj4yBeia04ZOc3rHNvLNK5
         +iWs9zcku9KD9G95nxpYExYwiX/mVMmMH21f+QY9rWsLfWZwFRzdkn/5qKlmdRVWz7ND
         XtnHJIy/P5wY8gtGenseud7JUZ0dgi3GMNUxRjBH+OPKdowat7Y77UYA6yDWqywYktuJ
         yo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=1RjCO7jPONpU19hNBOAbJCGNzYj7AOh4Zvq9GTtys3I=;
        b=ITRjDpO0E3DqUq+q14ZBVIHRUCgjn9erBik/B7RKk4Ojw7J8zxkxX6vOVMdO6yo0Nh
         T6XzYFuvGcTqqc006MZFQzsaLSj1Lek7vZ061Hd5lSAiA4iShgDsJKNilV0wtDMIKFXx
         f5+vjGJJByL7asorkyjCX8rae+tPbmRxfgRzDn/X/V9E/hVyi7zPaV6FaG7HNKolA72u
         LlyBqVAs4q5OQIliTWzXVZUG426J81hCgSpjgfoVqAZM7sz2wcAEJXQETTI+AV8vp/FO
         SpRRoM+4YO/JFu4uMYNfj0++03WFed37IopAr2b4EvayNcYZX/tGvSMz/teTXxEXYTHQ
         YsAQ==
X-Gm-Message-State: AE9vXwNWOLTh0Jv7/BDBKQs9AbFdTnkOYxcOdRxF7Y4bQDB9TxGdHMK7D0M5c83wk/Rt3w==
X-Received: by 10.28.99.137 with SMTP id x131mr4090857wmb.64.1474480474020;
        Wed, 21 Sep 2016 10:54:34 -0700 (PDT)
Received: from [192.168.1.26] (enn40.neoplus.adsl.tpnet.pl. [83.20.3.40])
        by smtp.googlemail.com with ESMTPSA id bl3sm34633098wjc.26.2016.09.21.10.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Sep 2016 10:54:33 -0700 (PDT)
Subject: Re: v2.9.3 and v2.10.0: `name-ref' HEAD gives wrong branch name
To:     Junio C Hamano <gitster@pobox.com>
References: <20160920162309.l0neYMQ3l%steffen@sdaoden.eu>
 <CAGyf7-FR11Ludt3vNZX7Ek4n_JLSON5+Y9By83GvNgpg94TWcg@mail.gmail.com>
 <b1d35732-4b4c-e0c1-59da-44d3e3b28799@gmail.com>
 <xmqq8tulb45n.fsf@gitster.mtv.corp.google.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Steffen Nurpmeso <steffen@sdaoden.eu>,
        Git Users <git@vger.kernel.org>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <60391836-a1c3-bfbe-b2d0-476d8bc82044@gmail.com>
Date:   Wed, 21 Sep 2016 19:54:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq8tulb45n.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 21.09.2016 o 18:37, Junio C Hamano pisze:
> Jakub Narębski <jnareb@gmail.com> writes:
>>> Have you tried "git symbolic-ref HEAD"?
>>>
>>> $ git symbolic-ref HEAD
>>> refs/heads/master
>>>
>>> If you don't want the fully-qualified ref, you can add --short:
>>>
>>> $ git symbolic-ref --short HEAD
>>> master
>>
>> This does not work for detached HEAD, but perhaps you don't need
>> to worry about this.
> 
> I am not sure what you mean by "does not work".  Asking what ref
> HEAD points at to symbolic-ref will tell you it does not point at
> anything by exiting with non-zero status and that can be relied
> upon.
> 
> Asking "symbolic-ref HEAD" has been the way how "git branch" and
> other commands find out what branch is currently checked out for
> almost eternity ("git symbolic-ref" appeared in Git v0.99.8).

I'm sorry, I was wrong saying "does not work".  The problem is not
that it does not work, but that you need to take care of exit 
condition to correctly support detached HEAD state, and not end
with empty name for a branch, for example...

But if handled correctly, git-symbolic-ref is as good as git-rev-parse
as a plumbing to resolve current branch name.

Best,
-- 
Jakub Narębski

