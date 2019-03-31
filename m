Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F44220248
	for <e@80x24.org>; Sun, 31 Mar 2019 19:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbfCaTsD (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 15:48:03 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:43658 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731326AbfCaTsD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 15:48:03 -0400
Received: by mail-vs1-f54.google.com with SMTP id i207so4223780vsd.10
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=So3vSzOsntQ4utCjwAxfTgtL5G5GRtnZaWQKybYVjWQ=;
        b=AwYpJiMUlmYSwiEn+KSiCSiSMOa1NH89LmBZijImiTYxkWxYZRlEMIeN33x9ifZ032
         iHIXY+mnE+2SexUx27z8unaDW0jh8JyCWXIuJ4/DYNsZFrYMyrPNGv6rAAIKATIcjmwz
         /kfPPj40cUtYh9nPRE+R7AudhSRQRLbmVPZAETZUChaiON9R/SgNY4Z6kgctTA02IRQA
         1ts2HlDhxCCdhgrXt4Rm37jEL+ErcdSJJhfsgxRZ58SvqVep3eOGm0Ej+jHZS8UIDUx5
         e4ea5Yak6XnI2ninN0oc7BW8D97bYuOBr0sqpG2YP9AbxrHYC96vsPlp/hIOL+dW1MVU
         rqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=So3vSzOsntQ4utCjwAxfTgtL5G5GRtnZaWQKybYVjWQ=;
        b=Yd8HFzSLA27Yve12iXTDTHQGybAe1w3neIHc4im3juIJUfHX0ABwlSLjjvKeSmv7ko
         aaAUfdRTTZS+N5tDnAV7NShF9BrVH0p5Rowh9TTh20fXNQKBemZU3pAwfdhxhfRg7hvJ
         Ay6vanrq326qhPlUfCno6h0FH4y/1z0uZCSREak8Nk2uGUUOZjcZpkdatn1DCVKdjd/o
         LxnoGeKH9jPLVoPmbpERebSU9BLyy5lGQRUquxcfo7/D3QDC+3DzSXAopsiXnzZ4BiDI
         ZlUT/hypZM7oBkNtoEq7nRQL6iG+EYgKuSCE+y3oi0jC80qw93zyMo1eLs5x01hjFpPk
         s79Q==
X-Gm-Message-State: APjAAAUr6YmBzFfMpdzYezu5zVp42Z7ix9RzLAXF8jPhKFFXfCIPfo5y
        gsIafcDISkjOdVTDD9Vb5quCdhXJceISVHwqsyw=
X-Google-Smtp-Source: APXvYqyDGLflVutAwM80QJwwzhZdXwEVtW0xSPuTPIPB6jBJr5qoUnJdwW/h21JA2TPimk+xFFTdU+yDL45Ea586m2c=
X-Received: by 2002:a67:7d91:: with SMTP id y139mr36745811vsc.168.1554061681835;
 Sun, 31 Mar 2019 12:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAODFU0qcwZm=2YnGm+rccDT2e5yZU3pyYGUGTwr9izod+e0s0A@mail.gmail.com>
 <CAKPyHN2Unp7Cou86fefYo9nD_ApokMxRMih=d27=rp634bYKwQ@mail.gmail.com>
In-Reply-To: <CAKPyHN2Unp7Cou86fefYo9nD_ApokMxRMih=d27=rp634bYKwQ@mail.gmail.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Sun, 31 Mar 2019 21:47:50 +0200
Message-ID: <CAODFU0p4FxZP34L=LAZX=25EFn6NK8vD7p47bsUu8yd+TpCb_Q@mail.gmail.com>
Subject: Re: git-gui: unstaged changes windowpane resets after unstaging a line
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 31 Mar 2019 at 21:15, Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>
> Hi Jan,
>
> On Sun, Mar 31, 2019 at 8:45 PM Jan Ziak <0xe2.0x9a.0x9b@gmail.com> wrote:
> >
> > Hello
> >
> > After performing "Unstage Line From Commit" action, the "Unstaged
> > Changes" windowpane is reset. The reset does not happen with "Unstage
> > Hunk From Commit" action.
>
> because its not necessary when staging a hunk. Though when staging a
> line it is better to run the diff algorithm again.

Yes. I was thinking comparing the old state of "Unstaged Changes" to
the new state and preserving (or approximating) the selected filename
and scroller position if possible.

When unstaging a line (or a hunk) there is internally no possibility
for the currently selected filename to disappear from the "Unstaged
Changes" list.

> Anyway, which problem do you observe in particular?

The problem is that the selected filename and scroller position are
reinitialized. It is uncomfortable when "Unstaged Changes" contains a
lot of filenames.

Sincerely
Jan

> Best,
> Bert
>
> >
> > git version 2.21.0
> >
> > Sincerely
> > Jan
