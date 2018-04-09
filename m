Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990901F404
	for <e@80x24.org>; Mon,  9 Apr 2018 21:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751688AbeDIVfl (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 17:35:41 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35283 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbeDIVfk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 17:35:40 -0400
Received: by mail-qt0-f194.google.com with SMTP id s2so10989316qti.2
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 14:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=iiydoJSChtzxG5ppYetQLDc8YxGdI3qlqAdNfsijXWo=;
        b=toPqKdP4w/cZKpYJvddcSxh0k4vwJKQbhZcwinE4iyAiznu+tsFrSmIdPp8ltaJcDp
         trk+ofyUzWxsYm0Ei/AyukaELIq844MWGoHRM468to9YKGleQwa9pPFWNtyA+V8pShQL
         55OHd+iVdu6YRD3ohpR+N294eAgu1acvY+euh3po9NPC4CTXz/4F7ylHOJmSKFljlB+f
         9oOrgaaC5cuHfuwOwNfBRoqKxQXEYapQ0wu8MlTPvWA33Nt0jY4TJBUJSwFQKHS7iB6j
         O5gvpsB/Rtw5Nva8ktJFXrYV0i/9fDFF6K7v8kURZT8ivGx47plNkHL4Us0yvUAIm0Fr
         4iyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=iiydoJSChtzxG5ppYetQLDc8YxGdI3qlqAdNfsijXWo=;
        b=WoU70VTsKgQKwKcyocD5iWbrk7nHVw4OGniGW80IOB7Mbt6+y3//7bvRNPOvhDyMkA
         p/QK0IucmzEptgPOxdcJiT5At4gkqDeqMvfcBMtb5TAPkY9Dj8ektn2UM0PKA83Isp7v
         KRoaNjfacHiWxhWEISQKz5tAu5T+KDV7l5dXImXnArY9uiwtfChY882sqkFEbYFbQzJR
         dbsGiVn3cyWjrzsbT9LGxqJA2jv9M02W2xN15wKr1fL0SRoi80FScJRon3fVWecK7JG1
         cfEEXgXxPDJ7i1Y4K0MDa/ocU9haU+jdzO3Moxu4x/qpYNYHudIoUeB/Xl+vVZIKiXoJ
         o5/A==
X-Gm-Message-State: ALQs6tBN5BWTJ/oekNbC26SECuN4B+ZHiCO9IumXIrHunG+ITczlMJC7
        o/hzX1vci6u4tTGQq/+wgDvYOB1X8mpozMp2pc8=
X-Google-Smtp-Source: AIpwx48B5R9kXpDtbPnSfELruAF/HIRpUZEqO6c3h4I9nmmAtgh/dDAFc/qZPLdcvI6qxR74rkQaSMYTHdRABLR8nYc=
X-Received: by 10.200.80.78 with SMTP id h14mr29869214qtm.154.1523309740173;
 Mon, 09 Apr 2018 14:35:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 9 Apr 2018 14:35:39 -0700 (PDT)
In-Reply-To: <20180409194405.GM2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com> <20180331151804.30380-1-t.gummerer@gmail.com>
 <20180331151804.30380-7-t.gummerer@gmail.com> <20180401131138.GE2629@hank>
 <CAPig+cRYgLwLZnXeOc2VWBmh8j_AxSGmf2x-DJ1kAbY3BzsAPQ@mail.gmail.com> <20180409194405.GM2629@hank>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Apr 2018 17:35:39 -0400
X-Google-Sender-Auth: yYbnmYgY6pQa6oiOStlkf_01-g0
Message-ID: <CAPig+cTa8pwL9xveCnxtdT1zFBTmqUecqYL5Du9B6cTGAWR_dQ@mail.gmail.com>
Subject: Re: [PATCH v6 6.5/6] fixup! worktree: teach "add" to check out
 existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 3:44 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 04/08, Eric Sunshine wrote:
>> This is making me wonder if "Checking out branch" is perhaps the wrong
>> terminology. What if it said something like this instead:
>>
>>     $ git worktree add ../next
>>     Preparing worktree (branch 'next' <= 'origin/next')
>>     fatal: '../next' already exists
>>
>> This way, we don't need the special case added by this "fixup!" patch.
>> (I'm not wedded to the "Preparing" message but just used it as an
>> example; better suggestions welcome.)
>
> Yeah, I think this looks like another improvement of what I currently
> have.  I'm not sure about the "(branch 'next' <= 'origin/next')"
> message though, as it doesn't cover all the ways the branch could be
> set up for tracking the remote branch, e.g. tracking by rebasing, when
> 'branch.autosetuprebase' is set up.
>
> But how about just "Preparing worktree (new branch 'next')", and then
> keeping the message from 'git branch' about setting up the remote
> tracking branch?

Fair enough. Extra annotation (such as "'foo' <= 'bar'" or whatever)
can always be added later if someone wants it.
