Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A66B1F42D
	for <e@80x24.org>; Fri, 25 May 2018 14:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936092AbeEYOas (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 10:30:48 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39545 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935826AbeEYOaq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 10:30:46 -0400
Received: by mail-wr0-f195.google.com with SMTP id w18-v6so9616504wrn.6
        for <git@vger.kernel.org>; Fri, 25 May 2018 07:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q7/AyKd8ny1G3LkE4gstcBk3wf3oABMnEYldKTwmQG8=;
        b=S2U5CwSUjtcrwpQBxvNZS44U+2s01Fr0jv9nt+bsPtw1JGFCbPh2xKLDaWr5LQSgqA
         pxx3CK3gnPyW3mWGwumPEwC2n4xZDogHZVikqFAaKWD6woKyuCKcxVpQJZBQqjF9AQr+
         QLwEAV7aZPB2p4oVKqcuXHtuRDz8+CvaSvFrqSa4f1zCyM22NK8iLgJI1xToITMWyATh
         afb/aFbUVlz72vY90H3Lze/n7zfyqQ8ktO2Uf20dIbrm3DjZzDb4xlOkfqqyPiobTdg9
         +QV7lceKu/C7/yO85g98BkgqVVjG5xS8PnkP7jRmmz1Bn+rPkyt3kNivn8ANsfow8xZe
         dPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q7/AyKd8ny1G3LkE4gstcBk3wf3oABMnEYldKTwmQG8=;
        b=b9Lh/iEGjJNGurBpfkYm3pgo4yL3lw/6FET6zJFOjF2FPfNqv1Y4HmYhEdXO2SnL5N
         2VVZdOVfX11Wum8QuUlCTTvm+LWeeg3kjWu5/6PlxKmOq9xCHGwQyLfc/jrZL7BebbtL
         KSHGnSqxUhE50BPa8LiFSWoRYjjPaoLDzMMjhuzfAEVusrXgVD2Rex4FuwJKEPBBmXIi
         UDhwBq4b+0IUJfG585oYI264lyP0bq7G7w3q3QHsVIAuUWN9ecam1B1oB4bFuvyqfJfE
         xf5RZdMHHjSof9uplmOy6hNpOmeMBi7dW+605GbMBTRgUd2nKi5Yosnb1lz2NeUurKNT
         AJIQ==
X-Gm-Message-State: ALKqPweaMa1noLIGbeWQkDVW8Y+M9p2A03qLfIw88X/92rgP58SKUhBa
        8KjcNcuBsXuBGdcO7kR1q9g=
X-Google-Smtp-Source: ADUXVKLNKJDuOdXE+1IKyLuR1nn5pxwR40LDQxKgNeYMpGoyy28s5YYpfuFbUX/UzeKe4rjvsoJPgw==
X-Received: by 2002:a19:9358:: with SMTP id v85-v6mr1701473lfd.83.1527258645475;
        Fri, 25 May 2018 07:30:45 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w17-v6sm847581lfe.73.2018.05.25.07.30.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 May 2018 07:30:44 -0700 (PDT)
Date:   Fri, 25 May 2018 16:30:42 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: turn --ita-invisible-in-index on by default
Message-ID: <20180525143042.GA10607@duynguyen.home>
References: <20180513175438.32152-1-pclouds@gmail.com>
 <20180525033942.GA234191@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180525033942.GA234191@aiede.svl.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 08:39:42PM -0700, Jonathan Nieder wrote:
> Hi Duy,
> 
> Nguyễn Thái Ngọc Duy wrote:
> 
> > Due to the implementation detail of intent-to-add entries. The current
> > "git diff" (i.e. no treeish or --cached argument) would show the
> > changes in the i-t-a file, but it does not mark the file as new, while
> > "diff --cached" would mark the file as new while showing its content
> > as empty.
> >
> > One evidence of the current output being wrong is that, the output
> > from "git diff" (with ita entries) cannot be applied because it
> > assumes empty files exist before applying.
> >
> > Turning on --ita-invisible-in-index [1] [2] would fix this.
> 
> I'm having a lot of trouble understanding the above.  Part of my
> confusion may be grammatical: for example, the first sentence is a
> sentence fragment.  Another part is that the commit message doesn't tell
> me a story: what does the user try to do and fail that is not possible
> without this?  What is the intention or effect behind the commits
> mentioned that leads to them being cited?
>
> ...

Sorry, this i-t-a thing had been on my mind for too long I mistakenly
thought this problem was common knowledge. Reference [1] in that
commit points to a previous attempt d95d728aba (diff-lib.c: adjust
position of i-t-a entries in diff - 2015-03-16) that was reverted,
which gives more info.

Anyway this is the diff we see today

    $ echo haha > new; git add -N
    $ git diff
    diff --git a/new b/new
    index e69de29..5ad28e2 100644
    --- a/new
    +++ b/new
    @@ -0,0 +1 @@
    +haha

Notice that the diff does not tell you that 'new' is a new file. The
diff with this patch gives you this

    $ git diff
    diff --git a/new b/new
    new file mode 100644
    index 0000000..5ad28e2
    --- /dev/null
    +++ b/new
    @@ -0,0 +1 @@
    +haha

You may argue that an intent-to-add entry is a real entry in the index
and showing "new file mode 100644" here is wrong. I beg to differ.
That just happens to be how you mark an ita entry. If Junio chose to
record ita entries as an index extension, then they would not be
"real" and could still be used to remind users about things to add.

From the user perspective, as a user I do not care if it's a "real
entry". I want git to _remind_ myself that I need to add that
file. That file should not truly exist in the index because I have not
actually added it. I did not tell git to add anything to the index.

One consequence of this is you can't apply the diff generated with ita
entries because the diff expects empty files to be already in the
worktree. This to me does not make sense.

Of course there's other things that also go along this line. Like if
"git commit" does not add an ita entry, why should it appear in 'git
diff --cached', which should show you what's to be committed. Right
know it shows


    $ git diff --cached
    diff --git a/new b/new
    new file mode 100644
    index 0000000..e69de29

which to me is ridiculous. Why would it show me a diff of a new file
with empty content? I as a user have not mentioned "empty content"
anywhere through the commands I have used.

Since this commit is already in 'next', it's too late to update the
commit message now. Maybe I can elaborate about this more in
git-add.txt if needed (and then I can add more explanation in the
commit message that updates that file).
--
Duy
