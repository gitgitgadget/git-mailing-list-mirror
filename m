Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9889320248
	for <e@80x24.org>; Thu, 11 Apr 2019 10:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDKKz6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 06:55:58 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39582 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfDKKz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 06:55:58 -0400
Received: by mail-it1-f196.google.com with SMTP id 139so8676171ita.4
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 03:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hGsjcOUTiE7TYoICJNLd/bAxyyoBBPWWDvdHwCNzO2U=;
        b=uFsZjmtljpwr/UmMXK4q/pgfdeHGrYkllcs/Bw49ROetOkTe9Kp4b/q8Z4S+oiYdFQ
         jc6SIzz45jlu8nj7zg4IU1yQ4IDtMlC7p4fmQj8PgbyRhgkreEYgHvEkdVmrRadpQsJO
         dJpXSOjKlI558uMl+yfpLnzvSbP7U6xflSt9QfcuyNeq8+fvEuFkQMQo6h+dpidkrbHI
         VQYouPNb95DWAFeZES/HsM5s5QDlOXCMBImdM75T7hKFI/+aqVM/c8FqABSvEh4aHf5H
         c/t//BPtA402GoBJ03V/8H4JBe85qNCXwzy9QQ7ZpeeZRuJnnKqLbU4rm1ySevRFN3+y
         t0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hGsjcOUTiE7TYoICJNLd/bAxyyoBBPWWDvdHwCNzO2U=;
        b=Y5eur7DcDWMmpxGdY+u0XSWjkj+dmpAjSDa1DC2g9raHqSZqfSdNLD7CBrsYcXTNZW
         cB9c8M/IltnEmbfY5fneJLbDlJPZQSp9rNcuLPZsHnpZ1bAR6kYlizdx9ghT8yFdH7Wp
         hG0Dzms+CBOHx4tiXuzevdLyMVVTcJlIRKwKExB0QbLRGA9qljIGvELi9gs3IuBDeKbL
         QJ4fYZRScn9VYJ9kPqYXWw1AZeS/xj6HUJ3asdTV2Fija8Jr4fi+sv0qt2SWn2mWoiV6
         rmtZqn87Zjf/TyO2rOgsHcTRfe3r+12y42vadYtv69y1POUXAR7LZqXnwKCZpWyBL4J6
         Qf5Q==
X-Gm-Message-State: APjAAAU7+Am5jDwgANu3sO8ZjIJ8iKR2W7az8bNptrRTP32cV7dnrF8C
        qQRbyP7vJoILR45qRlwAoCcWA3Y2itGBhklpfNE=
X-Google-Smtp-Source: APXvYqz4+rTWbbdS+F29PEF/OOYe828j5SMzw72LpZgcFTCOhVhQXS76PN4an+pvsvY1rzRXDYvWN5faU8lfY6yMWeY=
X-Received: by 2002:a24:5e06:: with SMTP id h6mr6925533itb.107.1554980157383;
 Thu, 11 Apr 2019 03:55:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-12-pclouds@gmail.com>
 <CABPp-BEVMc+k7fTtZqqAf=WdpFi3W-Tcjw+Ah57bcetOXVwxkQ@mail.gmail.com>
 <000b01d4d814$64907000$2db15000$@nexbridge.com> <CACsJy8CJ5VimEJsJMN4G2sFxn7X72qM-8QLBo7NNSjWx39npug@mail.gmail.com>
 <xmqq7ed3e5gj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7ed3e5gj.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 11 Apr 2019 17:55:31 +0700
Message-ID: <CACsJy8B2Mm=W56XAkVwtnPHPUCMpJcSdgrLxxKFYsS-q7r9a8Q@mail.gmail.com>
Subject: Re: [PATCH v1 11/11] doc: promote "git restore"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 11:58 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Duy Nguyen <pclouds@gmail.com> writes:
>
> >> Just curious: At what point did git checkout become not commonly
> >> used? Git switch and git restore are not yet in git as of 2.21.0,
> >> which is rather current. Maybe I missed a thread.
> >
> > I declare "git checkout" not commonly used the moment git-switch and
> > git-restore are released!
> >
> > More seriously, this is an attempt to promote new commands. The
> > "commonly used" here refers to the set of commands that show when you
> > run "git help" (they are called "common" in command-list.txt
> > classification). Since the people who type "git help" are mostly new
> > people, I think promoting the friendlier alternative is a good idea.
>
> So it is mainly how the word "common" is defined?  It's not how
> common the command is in the minds of the population of Git users,
> but how common we want it to be?

In this context, I think so. I suppose "recommended" is a better way
to describe it since we suggest a common set of commands to the user.
-- 
Duy
