Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D671F463
	for <e@80x24.org>; Sun, 15 Sep 2019 03:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfIODnG (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Sep 2019 23:43:06 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35358 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfIODnG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Sep 2019 23:43:06 -0400
Received: by mail-io1-f68.google.com with SMTP id f4so70527584ion.2
        for <git@vger.kernel.org>; Sat, 14 Sep 2019 20:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=v56F0uFcSHzzoztlVLoBvjneBXo+6oFpxC3Tj0r/xyU=;
        b=PCG/nCFTqwTHtJ6jnhd0YXvVSYC2qSR7isoAgLErzv7zbg5r2VNNgDDix266u0IJCT
         LYKOZ2LdyBsx+B8iJkDqkEP2SS/+y53am0M4iOQM/0vjtT6AJ4AcNeVhH7Jf5BWX0xA7
         WFwm244+rP1RtM++LkiAHcQbwkp/XMvCuxJDu08KkZpkpk4hDfeRxp2TUiryr3Um57S5
         uMvLeBWczby41yXG8RbOYPJvG1NKhQF7hXe5Pb0mUhaNMP+xql+DE9/ZjKIZunRy7LPP
         /j8MBEbAcTW0Ga82G20Wf+kQnWF+V2SS+yuFccF61I1bQrgfoQaJgaVOouUDtpC3l4ga
         x/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=v56F0uFcSHzzoztlVLoBvjneBXo+6oFpxC3Tj0r/xyU=;
        b=XvE13kO0WLQ+MRZBCM1be5ybmHpH3/AOJ/TYKJX0OR1P+z8V3cnn96SVNvvvYhGbBh
         VOuZYqByopoAscUPT9KxN3fks5JH30haLEVXzQjXAox/pfZ3/q6sY55HM9ieyUGXxmLt
         KKEqJezXSImjuVVtg+7Chv3nxee2GMoZ31aToRcU9zt27fZ5XGGOHKpgIlt3dEuUobLk
         TbtVEC1Eq7BMEH55YtpUeenwhwHoxwEJqurn+jkqUVWud043oDyI19UesLldImbe8e2B
         NnKdQ58vsglyKkPpJhzXjdRl3GnEE6NeI/MHWGHr6bG0O5KDYRrBnsEeoHIeLWC/0lgK
         9f3A==
X-Gm-Message-State: APjAAAX77JdcAlfzGlFG1p2joSB6RqmkAmVnrr7erASgVL7xPpJdop6f
        I6Tq1IWeaR4lDZe3m4NGRqh9P1E/SMEOH0jFSSU4HMzb
X-Google-Smtp-Source: APXvYqyWPIg2Jkf8BT2PWIK1z6Nj4Krgg0PIq1ziT9gOVkDuThvq8Cd2Ts0H/jEZRur0YDboGIAq1FOwT98m8/9IWSM=
X-Received: by 2002:a5d:9b06:: with SMTP id y6mr9498307ion.77.1568518984931;
 Sat, 14 Sep 2019 20:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAL-6oQorDOzAr4sDoddoAQv3hzAgUMx7K+V=bMcvScv8G=7oqg@mail.gmail.com>
 <20190913143229.5yop5oaascgavynl@yadavpratyush.com> <3fac912d-9e3c-bf19-e1e5-2691a835b151@xiplink.com>
 <CAMPXz=pNFpg7B0uYCBWvKwOqG8VZWfOxvf+8mZ9qc7w6DkF=+w@mail.gmail.com> <20190914212357.cg7t5cufqwd3wj66@yadavpratyush.com>
In-Reply-To: <20190914212357.cg7t5cufqwd3wj66@yadavpratyush.com>
From:   David <bouncingcats@gmail.com>
Date:   Sun, 15 Sep 2019 13:42:53 +1000
Message-ID: <CAMPXz=o_kxpKicfV6nurkU7j4nHXka2Xk1B2Qeosrjn-UB+btQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Git_Gui_=2D_enhancement_suggestion_=2D_Can_a_double_?=
        =?UTF-8?Q?click_on_the_file_name_in_the_=E2=80=9Cunstaged=E2=80=9D_area_move_the_i?=
        =?UTF-8?Q?tem_to_=E2=80=9Cstaged_changes=E2=80=9D?=
To:     git list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 15 Sep 2019 at 07:24, Pratyush Yadav <me@yadavpratyush.com> wrote:
> On 15/09/19 01:57AM, David wrote:

> > I can't say it strongly enough. Please do not change stage/unstage
> > to require double-click. This would be most unwelcome here, unless it
> > comes with a configuration option to preserve the old behaviour.
> >
> > Maybe the actual problem is that the present icon (perhaps surprisingly)
> > has the behaviour of a blank check-box that relocates. I don't wish for
> > any change, but if the desire for change is irresistable then the
> > simplest solution is for the icon (that appears to the left of filenames
> > in the unstaged pane) to be replaced with blank check box that
> > behaves exactly as the current icon does. That is:
> > When clicked, it becomes a checked-box alongside the filename in
> > the staged area. And if that staged-checked-box is clicked, it reverts to
> > an unchecked-box (instead of the icon) in the unstaged pane.
>
> Hmm, I like this idea. But right now the icons also show the state of
> the file (modified, added, etc.), so if you switch them to a checkbox
> you lose that information. Are you and other people willing to lose that
> information.
>
> Though I've personally never been a huge fan of those icons. They never
> really managed to convey too much meaning to me. So I won't mind
> changing them to something like the single-letter git-status status
> flags. This also gives us a bit of consistency with git-status's flags,
> so people used to the command line will recognize them instantly.
> Thoughts?

Ah, this is hilarious and embarassing. It confirms what I wrote in my other
message:
  Some days I have good ideas, other days my ideas
  have flaws that I missed, so I like to discuss first.

ie, Some days I'm an idiot! I completely forgot about those other icons!
I like them! In particular, the one that indicates removed files, and
the special one that indicates when a committed file has been replaced
by a symlink, or vice versa, are very valuable to me.

I don't really want any of this to change. I only suggested the change
because I didn't want to appear totally negative. So I tried to come up
with an alternative suggestion. But it was a dumb proposal.

So dumb in fact that I'm now arguing against it :(
Oh well :D
Anyway, I'm a fan of those icons, please don't change them.
