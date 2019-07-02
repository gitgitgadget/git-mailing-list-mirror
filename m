Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22C681F461
	for <e@80x24.org>; Tue,  2 Jul 2019 18:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfGBSwr (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 14:52:47 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:43824 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGBSwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 14:52:47 -0400
Received: by mail-io1-f47.google.com with SMTP id k20so13180969ios.10
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 11:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qlMwscuT3y3e4YhTEKE2+0HYzvkyiFxnnQ1P6/w9zqk=;
        b=kLm7oBlYodI19PEVPreIDOCVhZFSt066V+7xkH9B03WxGPg3SA/eFsih3GS4TzHf0g
         csI9exBR5Qg3edgrdZRIfWvCOr5758wU+m81KB2BP0rjM3v1gYT4EEO0nT2MEM6OqT3+
         wBAHwYd+sRBKpxkOYTIazulz7xF+ewWd5BbJKlUO2AOnH64+8FByZo79J/TvYesN/LY3
         ysCXkGWUuMOhQN0dI5X2aADIbyVXHkLiTUbDgQ43CqoMF6ZN0TUW8kv/KGT+brcfINTj
         YZXrLeMCHLuItb74kOYwgmbwba2VaYuUENna6Ia2i+bf7gv9VeVCF5jh39TVSLwkoTWZ
         jV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qlMwscuT3y3e4YhTEKE2+0HYzvkyiFxnnQ1P6/w9zqk=;
        b=ryJLA1vDwjlBOYdPqeh6/nwfDam/ApspRrTQxYsB9soXhrAuK81RLBaDIN7ljx/kxJ
         7j1xkzmB47U47AiE3R0+qcwqYYRgiOp5FacTvNq0Q/rkRSh2RoegSV/yN8OyUrYqeNk8
         GRzsLkhTw6Y/CWwL2Tf/naCcJnB1CdJJZJIFr9wlIpZc6ai0D6wr03tuwK89x3lVOooC
         NwaXgBOpRc1kpDayzQmfswm3OHCziO24xHUkl7zuRCKhs8VA9/fXpoH7Z4QvSX/IkVL3
         Ypp+/gtbxqPvaqJetWecOd7HAdUKXadtdYsIi4lswKu598yDTaxUjIe+rbr9dYLKBBNc
         luwA==
X-Gm-Message-State: APjAAAWhx8LFRbBTrKj1JpGPIHVMQZ521YEid3elN7gxeojtKmQsOO+O
        OLAVEplaKl8MxL4WI5fz1rEcgqa/Tj7OGLOpJw/nwQ==
X-Google-Smtp-Source: APXvYqyImAm2k0I8ZA80ymKWuplZGKEtL9dVTolg6u7yJcFeobPfS2yRWrnoHWotRdpLO4geuHVVdnP3wgnn1N5+OPo=
X-Received: by 2002:a6b:3883:: with SMTP id f125mr3622799ioa.109.1562093566112;
 Tue, 02 Jul 2019 11:52:46 -0700 (PDT)
MIME-Version: 1.0
References: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
 <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com> <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>
 <007d01d53049$4db5bec0$e9213c40$@nexbridge.com> <77a2b000-f1dc-6f3e-54db-abd227ce6163@iee.org>
 <xmqqef3849v6.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqef3849v6.fsf@gitster-ct.c.googlers.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 2 Jul 2019 11:52:35 -0700
Message-ID: <CAGyf7-GhD50Dy0O7JjV4vTyQfFcifyKzeYDS_HtAXy604HxqVQ@mail.gmail.com>
Subject: Re: Tracking parent branches in Git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>, rsbecker@nexbridge.com,
        Eric Kulcyk <Eric.kulcyk@microsoft.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 2, 2019 at 10:36 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> In this whole thread, I have been wondering if I am missing
> something crucial, but now I am deeply puzzled why after many people
> made comments, nobody raises a question about the "--no-track" thing
> in the early message in the thread.
>
> If you do not add that, i.e.
>
>         $ git checout -t -b bturner-some-bugfix origin/release/5.16
>
> (note that I added '-t' for illustration, but it should be on by
> default when starting from origin/<whatever>), then you'd get in
> your configuration file these recorded:
>
>         $ git config --get-regexp 'branch\.bturner-some-bugfix\..*'
>         branch.bturner-some-bugfix.remote origin
>         branch.bturner-some-bugfix.merge refs/heads/release/5.16
>
> You created 'bturner-some-bugfix' branch out of the 'release/5.16'
> branch taken from the remote whose name is 'origin'.
>
> Is that different from the answer to the question being sought?
> What am I missing???

Sorry, I should have clarified my "--no-track" in my original message
when I provided the example. I did "--no-track" because if I push
"bturner-some-bugfix" to a server, I'm likely going to do something
like "git push -u origin bturner-some-bugfix" so that my local
"bturner-some-bugfix" branch will track the remote version of itself.
At that point, the remote-tracking information would change from
"release/5.16" to "bturner-some-bugfix" (without any sort of warning,
for whatever that's worth), effectively "losing" the ancestry.

The other issue is that my local remote-tracking information doesn't
help the server I'm talking to; it's not shareable. Assuming I could
use remote-tracking to track ancestry, there's still no way to
communicate that to the server so that it could know, when I go to
create a pull request for "bturner-some-bugfix", that it's tracking
"release/5.16" in my local repository.

I could certainly be misunderstanding the request, but I think it's
asking for something less ephemeral--and more shareable--than
remote-tracking, and it seems logical to want to be able to retain
ancestry while still using remote-tracking setup such that local
branches still track the remote version of themselves, rather than
some other (albeit related) branch.

Best regards,
Bryan Turner
