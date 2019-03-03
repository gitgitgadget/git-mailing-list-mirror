Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93E3520248
	for <e@80x24.org>; Sun,  3 Mar 2019 19:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfCCTqn (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 14:46:43 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44734 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbfCCTqn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 14:46:43 -0500
Received: by mail-ed1-f65.google.com with SMTP id b20so2508845edw.11
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 11:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VK3b4e1B7Ti2mE7tXFSQDJjk1zYLoSHb+YjjJjWfFJ8=;
        b=CFdpN9SOLz66+RueeR3+NGnsBhXhIZQRG3ECz3FH/9T9sf82TTZJS4HHmfbnpaNPuK
         ia7GfNVcjHyz+icRzuRdMW5JDGMQ5YZ7yZKSGZ9O0EGtuG/teF06x4d7wlmvmqAa+VDU
         hSaDeVPH4kum6JqqlVF5kLhLgPVA6KVKWM4hOEKV/WuxCEaCU2YoGbD29ZOGZUMWaY3w
         hQyoA2fwHSgilx8hrod/sgM9HFp7KtN9/YD4wlHcVbaBJlM9B1wYCOum9k6U7WiGUMUj
         ANvrp2O+pzzpKdukr8D7Or4lDsYY+8NZ+otEYV63Exg7Jb4bzEili3AWmM83LwIqB+eP
         XnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VK3b4e1B7Ti2mE7tXFSQDJjk1zYLoSHb+YjjJjWfFJ8=;
        b=sjBbvYUmmKTa0uZ91au2OHGtI/eBJvlLAf+lgbLEXm7F68I6NuL+B/rW3NjKxH98GF
         HhvSgDmyQOIrlLUtmlt2ZixaYX8s0lW9juJBthPdFF7UKUFFftkK0FgpT3L3XhPhiYDT
         4IsVRhaQHjtowShlyPC9pCNzv5qNnKMqCKh5P8stDjgwhVWRwi7y70w1sD3SfB/pJrRc
         IivIIm06/EqKSGQpHJIsNL9kVOcT/lGaLGhZhYwc54jhZkY/FOk59T+QuQK2AG7r6Mdc
         82BYOz7fDAmIrqfq2XUwyFHhiRpV7lOluY8T1mV7XnRGNQ7SMdFZ98W4cARLvjWfdE4s
         HOGQ==
X-Gm-Message-State: APjAAAVcQ+iiRskrSjTkYvFuXBTtYympsKbW1/eHYxv4aFrUjULcAEU8
        DPCf5rM/4vpCLsKEEhSp+H0RLxBRCdFdn6GXLneAPA==
X-Google-Smtp-Source: APXvYqwQz+doVRixvNl4yWd1VNCHNe3+jweiBmLEL817b+c/A/caLRhyo5yqZfMl6kK+Qy5WWphc0f6POLgY6CMDSkc=
X-Received: by 2002:a50:a535:: with SMTP id y50mr12585029edb.163.1551642401618;
 Sun, 03 Mar 2019 11:46:41 -0800 (PST)
MIME-Version: 1.0
References: <20190301175024.17337-1-alban.gruin@gmail.com> <20190301175024.17337-5-alban.gruin@gmail.com>
 <CAP8UFD1HBbOX7wS664vBT8mxjGUJ4rtWYYJJX9RQqhN20-T8uA@mail.gmail.com>
In-Reply-To: <CAP8UFD1HBbOX7wS664vBT8mxjGUJ4rtWYYJJX9RQqhN20-T8uA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 3 Mar 2019 20:46:30 +0100
Message-ID: <CAP8UFD0bH--hLSXuc7Z9RN5oLNPWjVdCFS4+zeLo9qXTo93pxA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BRFC_PATCH_4=2F4=5D_name=2Drev=3A_avoid_naming_from_a_re?=
        =?UTF-8?Q?f_if_it=E2=80=99s_not_a_descendant_of_any_commit?=
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 3, 2019 at 8:33 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Mar 1, 2019 at 7:11 PM Alban Gruin <alban.gruin@gmail.com> wrote:
> >
> > A ref may not be the descendant of all of the commits mentionned in
> > stdin.  In this case, we want to avoid naming its parents.
>
> Properly speaking a ref usually just points to a commit. It is not a
> parent or a descendant of any commit.
>
> Also if the commit, let's call it C, pointed to by a ref isn't a
> descendant of a commit, let's call it C', mentioned on stdin, then C'
> isn't a parent of C, though I think we want to avoid naming C' from
> the ref.
>
> I think it might be clearer with something like:
>
> "The commit, let's call it C, pointed to by a ref may not be a
> descendant of all the commits mentioned on stdin. In this case we want
> to avoid naming the commits mentioned on stdin that are not parents of
> C using the ref."

By the way things might even be clearer by replacing "parent" with
"ancestor" in my message.
