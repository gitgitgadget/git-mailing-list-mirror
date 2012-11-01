From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Thu, 1 Nov 2012 03:46:55 +0100
Message-ID: <CAMP44s1v5Au7=Pt-_9MV54VGC-SiTte=aL0S9ekZB9yxiU+wKw@mail.gmail.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<20121031102712.GB30879@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210311900450.7256@s15462909.onlinehome-server.info>
	<CAMP44s2y-co4TELg28==axRmbF7xq3Qp7U8wjg6XtGAUMgf40w@mail.gmail.com>
	<20121031185903.GA1480@elie.Belkin>
	<CAMP44s2-UoT03OeTmM9=nh9wCUt84exPNuHyuThp=WQkxvCNLQ@mail.gmail.com>
	<alpine.LNX.2.00.1210311613550.3197@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 03:47:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTkoH-0005V0-HD
	for gcvg-git-2@plane.gmane.org; Thu, 01 Nov 2012 03:47:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756815Ab2KACq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 22:46:57 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:54444 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681Ab2KACq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 22:46:56 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2151791oag.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 19:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Zrf3f/xF1IPC7caVQxlV9L6n/ZYI6cX7RkwVIyvE0/c=;
        b=O/vXkwdEQabVRkborWfcHm+jzrNxrfvS3yA+x7KHwfZ1rHIWn8zGr+gijZDGkSDHeW
         mLDqlifMphhceh7axaP/IBGChPT+mMJk+tTE16GIcoaojktq7dn25NB6COTO8Q+WmUdh
         BlsnprHNhS4zpU4C+aSl+N+6oJNZYJvB4gCjP7Hoqyr430CDMLGdVWXUXPks6ZQ8ifta
         wX+ci14WnYTpvFW1RRWb4VuthMOlZSiqZwmAMf19SXXG4SwiAClb5N5ieQWhUpIkqiRT
         9Rl2swMG4YAGDd+cV+8IT7KdidwhY3qch21h3gxQKTlNW2cvFyYugRksvG3TyBOmM7xY
         0jlg==
Received: by 10.182.116.6 with SMTP id js6mr31781071obb.82.1351738015411; Wed,
 31 Oct 2012 19:46:55 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 19:46:55 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1210311613550.3197@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208860>

On Thu, Nov 1, 2012 at 12:14 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:

> I think that may be true where you have "next" in both places, but I
> think:
>
> $ git checkout -b new-branch master
> $ git fast-export ^master new-branch
>
> ought to emit no "commit" lines, but needs to emit a "reset" line. After
> all, you haven't told fast-export that the ref "new-branch" is up to date,
> and you have told it that you want it to be exported. If you create a new
> branch off of an existing commit, don't change it, and push it to hg, it
> shouldn't be up to remote-hg to figure out what should happen with no
> input; it should get a:
>
> reset refs/heads/new-branch
> from [something]
>
> I don't know why Johannes seems to want [something] not to be a mark
> reference (unless he's complaining about getting an invalid mark
> reference when there aren't any marks defined), but surely something of
> the above form is necessary to tell remote-hg to create the new branch.

I don't know what Johannes wants, but it has been discussed that not
everybody is using marks.

When you use marks, the following patch fixes the issue:

http://article.gmane.org/gmane.comp.version-control.git/208730

> I think it would be worth testing that:
>
> $ git checkout -b new-branch master
> $ git push hg new-branch
>
> creates the new branch successfully (which I think it does, but wouldn't
> if "git fast-export ^master new-branch" actually returned nothing;
> parsed_refs gets it from the reset line).

And it does, with the above patch, a similar command is even in the tests.

The reason why 'git fast-export ^master new-branch' returning nothing
doesn't affect, is that transport helpers wouldn't use negative refs
(e.g. ^master). Transport helper passes whatever the uses specifies. I
you say 'new-branch', that's exactly what the transport helper will
receive. It works because transport helpers use marks.

Nobody expects '^master new-branch' to do something useful, everybody
uses marks.

> AFAICT, your code relies on getting the behavior that fast-export actually
> gives, not the behavior you seem to want or the behavior Johannes seems to
> want. And the reason that you don't need any changes to fast-export is
> that your process maps marks instead of sha1s.

No. In order to make use of this bug, the user would have to do:

% git push hg ^master new-branch

Otherwise nothing would get pushed, with or without my first patch[1].
To make 'git push hg new-branch' work, you need my second patch[2].

Cheers.

[1] http://article.gmane.org/gmane.comp.version-control.git/208729
[2] http://article.gmane.org/gmane.comp.version-control.git/208730

-- 
Felipe Contreras
