Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E8331F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 19:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbfJMTRP (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 15:17:15 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47897 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbfJMTRP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 15:17:15 -0400
X-Originating-IP: 1.186.12.3
Received: from localhost (unknown [1.186.12.3])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B22E21BF206;
        Sun, 13 Oct 2019 19:17:12 +0000 (UTC)
Date:   Mon, 14 Oct 2019 00:47:10 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Harish Karumuthil <harish2704@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] Feature: custom guitool commands can now have custom
 keyboard shortcuts
Message-ID: <20191013191710.535nho3pec2c5wlk@yadavpratyush.com>
References: <01020153c22ab06b-e195b148-37cc-4f89-92f3-f4bed1915eb9-000000@eu-west-1.amazonses.com>
 <20160331164137.GA11150@gmail.com>
 <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
 <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
 <20191003214422.d4nocrxadxt47smg@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
 <20191004120107.kpskplwhflnsamwu@yadavpratyush.com>
 <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
 <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com>
 <1dbb69d96229fa9400d7eae0b4fd467ab9706815.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dbb69d96229fa9400d7eae0b4fd467ab9706815.camel@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harish,

Sorry for the late reply. Couldn't find much time last few days.

On 07/10/19 11:43AM, Harish Karumuthil wrote:
> Hi Pratyush, Regarding your messages,
> 
> >On Sun, 2019-10-06 at 02:31 +0530, Pratyush Yadav wrote:
> > You don't need to "set up" an email client with git-send-email. 
> > git-send-email is an email client itself. Well, one which can only send 
> > emails.
> 
> For now, I am sticking with a mail client ( evolution ) which does minimal
> ( or atleast transparent ) preprocessing  ( Tab => space conversion , line
> wrapping  etc ).
> Now I can send patches using the output of `git diff --patch-with-stat`
> command and I hope is it enough for now.
> Personaly I dont' like any solution which requires storing our mail password
> as a plain text file.

I'm afraid this won't work. The '.patch' file that `git-format-patch` 
generates also contains your commit message and the author information. 
All those are needed to properly convert your patch to a commit in my 
repo. The output of `git diff --patch-with-stat` won't be enough.

As for not wanting to store your mail password in a plain text file, 
check out [0].

And then there is GitGitGadget too, which I'd recommend since you seem 
to be having trouble sending patches directly :).
 
> > You haven't sent '/submit' over there, so those emails aren't in the 
> > list (and my inbox) yet. You need to comment with '/submit' (without 
> > the quotes) to tell GitGitGadget to send your PR as email.
> 
> I thought, lets finalize discussion about all the changes here in mail
> thread   it self before submitting the patch. Otherwise, That is why I didn't
> submitted the patch.

Makes sense.
 
> > One point I forgot to mention earlier was that I'm honestly not a big 
> > fan of separating the binding and accelerator label. I understand that 
> > you might not have the time to do this, but I think it is still worth 
> > mentioning. Maybe I will implement something like that over your patch. 
> > But it would certainly be nice if you can figure it out :).
> 
> I think there is a small missunderstanind in that point.
> 
> I agree that, in the initial implementation ( which I did @ 2016 ) menu
> labels were separated from binding keys. But in the last update, it is not
> like that.
> 
> Currently, user only need to specify single config value which is
> `guitool.<name>.gitgui-shortcut` and don't have to specify accel-lable
> separatly.
> Label is generated from the shortcut.

Thanks for clarifying. It indeed was a misunderstanding.
 
> > Either ways, detecting an existing shortcut is pretty easy. The `bind` 
> > man page [1] says:
> > 
> >   If sequence is specified without a script, then the script currently 
> >   bound to sequence is returned, or an empty string is returned if there 
> >   is no binding for sequence.
> > 
> > So you can use this to find out if there is a binding conflict, and warn 
> > the user.
> 
> Will try this. Thanks!

[0] https://www.softwaredeveloper.blog/git-credential-storage-libsecret

-- 
Regards,
Pratyush Yadav
