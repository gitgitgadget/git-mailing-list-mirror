Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 974871FA14
	for <e@80x24.org>; Wed, 12 Apr 2017 23:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755421AbdDLX0x (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Apr 2017 19:26:53 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35273 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755360AbdDLX0w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2017 19:26:52 -0400
Received: by mail-io0-f182.google.com with SMTP id r16so58966005ioi.2
        for <git@vger.kernel.org>; Wed, 12 Apr 2017 16:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SIuMge+mSO2mPKcV6SxZbncLRoSInr8esLW3sDCcaGU=;
        b=CSNLpAandtKzKdqH7b4CieZGeFbl1PChgDG3iiNvDqsA0dmFuSLQochAJ9CxbCNs8p
         1klSDDt71EbfR8AC9mSVdRdDcDX/U64NE/Z/hOWzWyJ1VR5vRoNxPr0rm3ZMi5hnrSyX
         83VvSGnIEi0SlZku7J6xV5ZMWHijstVXe2uYmLsD+g2AbY96eTdfFRfIsFHmCVYyj856
         2zYEwDt73AHlwvujw66qWCqMlWSY5sGQ3s3kn9xnpRQzRaJ7tUIvBnkucS53ZgnTv7bv
         yytgdOindtQNi0DNCUKZ3FSO1KxnDPFOABIVYJurNULenGTZONZtAtFftpnga7BCm6nx
         u8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SIuMge+mSO2mPKcV6SxZbncLRoSInr8esLW3sDCcaGU=;
        b=XK3udfGnvAe9uYoLXydbNHBoxcLJngNMGnBoOQBdfsqSD64znDlo7a7euDTGoSqu6P
         r7Lz09IGmpZD111iEj0EB2VsbzzQXopHAtlRrFSj4SMWTUyaDX+bPnZrzFU9pbf0VTQk
         F3nSU+34dhJI/1jadik8opUmpzMMqe4CdXukQREdnfqXz+jqZSU5305W61AUIVwXcf9r
         qwXGAM5RSEvfrBTOMEW7A2Gf7p/COUB0JI7nhDgE1Tky5KAxh4IgpCCoU17iqxU2r6cx
         pfIMSZ7DgsIkOI7wH4x414l//ZENQ3UAO9ZVk2laYJA600mC7yuRU/9VV4aRKUgJ9LPb
         gkiQ==
X-Gm-Message-State: AN3rC/7ViarONEL1IFwnSqQ4baE1Zjn4+FYrfz3eytd4mAvcZ9/sK/Wa
        t5JJoWcc+bY4jpH/a/GdXZb0bwz2w0Lzh44=
X-Received: by 10.107.59.1 with SMTP id i1mr836374ioa.18.1492039611428; Wed,
 12 Apr 2017 16:26:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.162.204 with HTTP; Wed, 12 Apr 2017 16:26:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1704122355440.2135@virtualbox>
References: <CAKNkOnM366uiJKkz31hS8V3NTa8qksP2pXrH4+F-zodZaNdsqg@mail.gmail.com>
 <alpine.DEB.2.20.1703021617510.3767@virtualbox> <CAKNkOnOkSgFei7jpck8Z7tH+jYn_MXvarA86GAadT8jJt4aO-g@mail.gmail.com>
 <alpine.DEB.2.20.1704122355440.2135@virtualbox>
From:   Stephen Hicks <stephenhicks@gmail.com>
Date:   Wed, 12 Apr 2017 16:26:30 -0700
Message-ID: <CAKNkOnNMH72QnuDrja3XNG8Z6zLsuXdCERA==iBQztRQW1+O3Q@mail.gmail.com>
Subject: Re: Rebase sequencer changes prevent exec commands from modifying the
 todo file?
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 12, 2017 at 3:05 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Stephen,
>
> On Tue, 11 Apr 2017, Stephen Hicks wrote:
>
> > Thanks for the tips.  I think I have an approach that works, by simply
> > returning sequencer_continue() immediately after a successful exec.
>
> I am not sure that that works really as expected, as you re-enter the
> sequencer_continue() and neither the original author nor I expected nested
> calls.

Alright, I can reproduce the longer version in place here.

> > I'm hesitant to only use mtime, size, and inode, since it's quite likely
> > that these are all identical even if the file has changed.
>
> Not at all. The mtime and the size will most likely be different.

In my experience, mtime is almost always the same, since the file is
written pretty much immediately before the exec - as long as the
command takes a small fraction of a second (which it usually does) the
mtime (which is in seconds, not millis or micros) will look the same.
For shell redirects, the inode stays the same, though the size will
usually be different, but this is not guaranteed.

> I am reluctant to take your wholesale approach, as I perform literally
> dozens of rebases with >100 commits, including plenty of exec calls, and I
> want the rebase to become faster instead of slower.

I'm in favor of that, but not sure of a reliable way to tell whether
the file is modified.  As mentioned above, mtime, size, and inode only
get us *most* of the way there.  This leaves it open to very
surprising issues when suddenly one edit out of a thousand
accidentally doesn't change any of these things and so doesn't get
picked up.  This would be a very difficult to debug issue as well,
since everything would look very reasonable from the outside.
Potentially it could be mitigated by actually writing a message when
the file is reloaded, making it more obvious when that doesn't occur
(though it's still not the most ergonomic situation).

> > Say, the command is simply a `sed -i 's/^exec /#### /g'`, then the
> > timestamp (in seconds) will almost definitely be the same, and the size
> > and inode will be the same as well.
>
> Try it. The inode is different.

You are correct that sed -i does change the inode.  `c=$(sed 's/^exec
/#### /g' git-rebase-todo); echo "$c" > git-rebase-todo` is a better
example, albeit a bit more contrived.  I've added a failing test case
to demonstrate the problem.

> > Granted this is a contrived example, but it would be unfortunate if
> > accidentally keeping the size the same were to cause the change to not
> > be picked up.
> >
> > Another option would be to hash the contents, but at that point, I'm not
> > sure it's any better than simply unconditionally re-parsing the TODO.
>
> Again, my intent is to make rebase faster, not slower. Hashing the
> contents would make it slower. So would re-reading it.
>
> > https://github.com/git/git/pull/343
>
> Thank you for starting to work on this. I left a couple of comments.
> Please do not be offended by their terseness, I really wanted to point out
> a couple of things I think we can improve together, but I am also way past
> my bedtime.
>
> Ciao,
> Johannes
