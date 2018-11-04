Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 950FD1F453
	for <e@80x24.org>; Sun,  4 Nov 2018 06:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbeKDPsT (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 10:48:19 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37525 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbeKDPsT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 10:48:19 -0500
Received: by mail-it1-f195.google.com with SMTP id e74-v6so8423683ita.2
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 23:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zy5eLg30tQXuy2HwBbjSgiD8+gNKv6T+zo7WF783FlA=;
        b=e7pSuN2fAvmJUZOXoyvGxP30gptVe1BhksIFxCKxBOwtm4JAXyBhQCzXAh2FLPAFSG
         Yblu8c0aiIzNnOOTj3c8Ail2X59r4OJS9Qi8HTkriZu0PJ+CYBpG6vY9LnbvUvLO5CKe
         swy/MIdjJnt0utVZ78C1ZZ0OFQ60JQzImbqb1zFkC2W8JXNQEQdbJwvYnyCc5GjO7uOh
         hYP3lU+G0miyw4wlJNO/nG0RTSVWttxH2Ox1t1QNzHiGtWXKvWGLEoClhKX4Kq86Tymu
         t+l+mwZTRmUmw8f71oMjwyPa1toWTN1oSIB8BGxp27Xj+QSj2bZ9Hl6q66TfjKKRN4Wg
         +6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zy5eLg30tQXuy2HwBbjSgiD8+gNKv6T+zo7WF783FlA=;
        b=gaAMdZJxJnGUc3Zd7+AnFbuqGe0WG2WEGy1XCkEfwTTIbRmo7JatWKEShn5xnyxSk3
         tknW1nqtZAxF9jw8Qo/9H5zm/SpkN7vYswvDRmdq/vbtY/hEp3AnMgjI+MhKeu8Hoq9G
         bfDlHkB61N2hSyetghCabt4bmbScTue4XsV3TLVj8Od47ueEj35z/9/9MF1rMXTkzldm
         aLmwgY4gGzow3CjNDE0sJ3l1JOOQFcZ4Xs5XOQdPMnoT73Dk9Mv5FDkK63cSUCxiq4LW
         6OgnYjoyV1sr9c9POCxYKGpmBsED9EGilyrxdDYugWeyGoED/eZ69NT1KDB9HErKAq1X
         eHFw==
X-Gm-Message-State: AGRZ1gLPT/kXpcVrxwlBzHC3PnHhIOUTng0+b20tR/DnFoQY/PJULKKX
        +xYalMOgOqcI0in3qqzGHf4zqlAwJ73/y1IE08IlMQ==
X-Google-Smtp-Source: AJdET5fx+re8ksi+sSXqlgCQdyH0aEE5B1CNKVENJYOQW4MqQUfg9UEZFJFwktXQAfppOZYFyuud8gFqcVnKqwR8sd0=
X-Received: by 2002:a24:fec3:: with SMTP id w186-v6mr2283715ith.10.1541313267350;
 Sat, 03 Nov 2018 23:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181030191608.18716-1-peartben@gmail.com> <CACsJy8DbiVZYmY11Nt4c_+egSi5tz0iVq7rNv2BiVdyJ4htgvw@mail.gmail.com>
 <1f7efd07-4881-daa7-cd1d-145bbf3ffcc8@gmail.com>
In-Reply-To: <1f7efd07-4881-daa7-cd1d-145bbf3ffcc8@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 4 Nov 2018 07:34:01 +0100
Message-ID: <CACsJy8BqWu0YG_Q8EFNeDgrRhYCCKBU+zPJjrhAWFU_gTDCoXg@mail.gmail.com>
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
To:     Ben Peart <peartben@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 9:53 PM Ben Peart <peartben@gmail.com> wrote:
> >> +core.virtualFilesystem::
> >> +       If set, the value of this variable is used as a command which
> >> +       will identify all files and directories that are present in
> >> +       the working directory.  Git will only track and update files
> >> +       listed in the virtual file system.  Using the virtual file system
> >> +       will supersede the sparse-checkout settings which will be ignored.
> >> +       See the "virtual file system" section of linkgit:githooks[6].
> >
> > It sounds like "virtual file system" is just one of the use cases for
> > this feature, which is more about a dynamic source of sparse-checkout
> > bits. Perhaps name the config key with something along sparse checkout
> > instead of naming it after a use case.
>
> It's more than a dynamic sparse-checkout because the same list is also
> used to exclude any file/folder not listed.  That means any file not
> listed won't ever be updated by git (like in 'checkout' for example) so
> 'stale' files could be left in the working directory.  It also means git
> won't find new/untracked files unless they are specifically added to the
> list.

OK. I'm not at all interested in carrying maintenance burden for some
software behind closed doors. I could see values in having a more
flexible sparse checkout but this now seems like very tightly designed
for GVFS. So unless there's another use case (preferably open source)
for this, I don't think this should be added in git.git.
-- 
Duy
