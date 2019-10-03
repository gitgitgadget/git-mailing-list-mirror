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
	by dcvr.yhbt.net (Postfix) with ESMTP id 05FBC1F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 06:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfJCGRf (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 02:17:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43056 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfJCGRf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 02:17:35 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so2827379iob.10
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 23:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAGLH18VcJd+8/B9QCZAiTFY13SpjAI+HuFrinucX2Y=;
        b=BRB24a7kPAw5+e85fn6kL7WbW075cvDhz/2/vwE+9ACP84jQGkz751Ljxxng9aPhcz
         vbkoMr8esiDy16oV7JkH/sKc5/9vf1pNoEptuB8PL+MN8GIiIqYx7XGriVLbZk8pJLzR
         WZ9ddoVa8kPGICAtuaMQCIzn3NEQNyoZCHOfG0gl6wNnoapLRBA9iinD86WX9fd9Coba
         IJ/HJ347yQ8FvkN9loZcd+X6yMFOXWF1jqcb5tklticvaVehowBjhrPkIM1pCOSWU7uR
         HoW0XnQEGupRcIOaaOOZ/5lFE6mT4lT/PbrzLM+0Um7hfWjcfbsgyHlZMzP6MDCrRb7T
         8Wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAGLH18VcJd+8/B9QCZAiTFY13SpjAI+HuFrinucX2Y=;
        b=OXdOdaEhfM1HoRSXvdkO3S6MAoiIRTZ1CxhDrfpFk53sZIEk5UkHzsgNDg2LR8Rbnj
         UIvRSMAOZO98eyQHNKEo4QxGXgHcIBSfVGjwvlUBSgXlY0u9z26YPhLig2blBj6J1ekx
         96IO8O9110RzMfVT7YoRfICVriFAP8fKsy4dNBreXanPVUfWXJVnQp8YzbowlIon2HHN
         JQNJeqa8vNhiTd/4+VXjsrJi4Hhr76w6VTwx9ZEZF1DnA65mBlAlMeL8zE5zid1pb1lx
         xpgO4/xv7xdOpW6wbkl6iceqM7tZVbMXLe7lRfzvapNHs65Xu6wj3GDQwFcmqJoQU9HF
         GOtg==
X-Gm-Message-State: APjAAAWEzFx0TVNnmB5gTmuumpykkWI1x4EnA90V1S8f1T7UKrDkDCos
        VKfIJKUkPzbTFJzYgirSZtTrqrWgW+y+4CHkgKY=
X-Google-Smtp-Source: APXvYqwf8EeTqrdJ/vbg4jhqivCJ5wIZg3wp8xb03NTGbYNe6gJJPHsWZmmi+woliBBtp6QTOtsRvml3Gdgv0WhsqD8=
X-Received: by 2002:a6b:254:: with SMTP id 81mr6740505ioc.17.1570083454744;
 Wed, 02 Oct 2019 23:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191002184546.GA22174@generichostname> <xmqq8sq2ewzh.fsf@gitster-ct.c.googlers.com>
 <20191002201659.GB24697@generichostname> <xmqqmueid508.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmueid508.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 3 Oct 2019 13:17:08 +0700
Message-ID: <CACsJy8CZCdF-jPeYaAxzpnSbtxbRX42ScSJyYFCfmxZ0YBhZGg@mail.gmail.com>
Subject: Re: [BUG] incorrect line numbers reported in git am
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 3, 2019 at 7:52 AM Junio C Hamano <gitster@pobox.com> wrote:
> > In fact, running `git am --show-current-patch` shows the whole mail, not
> > only the 'patch' file so users would have no reason to expect the line
> > numbers to refer to the 'patch' file.
>
> Yeah, show-current-patch was a misguided attempt to hide useful
> information from the users.

Not so much hiding as not having the information to present, at least
not the easy way, since the mail is split at the beginning of git-am
and never stored in $GIT_DIR. By the time this command is run, the
mail is already gone. Someone could of course update git-am to keep a
copy of the mail and improve this option.
-- 
Duy
