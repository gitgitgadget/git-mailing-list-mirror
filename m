Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0056A1F744
	for <e@80x24.org>; Mon, 11 Jul 2016 18:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbcGKSJc (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 14:09:32 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34156 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826AbcGKSJb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 14:09:31 -0400
Received: by mail-yw0-f182.google.com with SMTP id i12so98945788ywa.1
        for <git@vger.kernel.org>; Mon, 11 Jul 2016 11:09:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Q5rKF8RmHWbpcNfJyrFF+0HYV72Ck22U8j9xjlCuKHc=;
        b=tv6o1bs1MKfw4b32Ua/q6iwzA2djavxLFk2zGYLHD1HS1BiCQHyK6lGIPKAPn7ByGj
         hAQmeoVkQTbmy79kKjtI/c0TLQujzJUsJBCjFp6fcOiZz8FXuB9HooaCgHS0A5HP25i3
         w4YftN/VIN4RGQC54p05HFPpe4yppNBMmdkEoV5jR5qv09Mth1n96zMH7VLrEdZvA3kl
         pLfODdXDkZaQnA6jsP4S6/peYZyMeczmtdFloQMV4Dnh2v3+RpccEOr4hSZa90zF7/tU
         Yu8oqhzq8821uU0sePnrLM9jo4O8t5Vg0H1Ucyw8Oa7r1OZGoin9QSvFf3ikG7wNwUeg
         dSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Q5rKF8RmHWbpcNfJyrFF+0HYV72Ck22U8j9xjlCuKHc=;
        b=fhA1r7ZQJkEd/THUtAnPt5KY+B8wAGgMkrgObQF8Z+Z4ek5RMfpEiIkremqS+4mEsE
         RYL3zLtRr+/O3suo/7GfKGXr1o3GY6PYgpV1nI/4rPdVx9dwj63vxl9fKKv6V4zuLarc
         MAtnPNT5mEAdmdQxQH4uBsv+HEsAMiNuIdx+HMNryiFiP6IUPUe6WRDxm9nq96+qroLi
         e7DH4deC0g6w8EUiRFYZh0FbXAho7kGWPoT74E+BOf3IyPOHM72KEDWuvBfIvsWyazCK
         /9oJlsu80V4ryv3he1ZfA/Bx1EDDY6eFw4ln2rqhhcZKuezxVQa80iVjRItYeFP/GI76
         TjbA==
X-Gm-Message-State: ALyK8tKdCZhwNZP9yK6Z6Y6a7lPI/z8hl6wW6pz6YrCoKkR9ah/3I7JTMvMczEx/vmUnvgyiD3xdWz1he6FIdA==
X-Received: by 10.129.105.136 with SMTP id e130mr4688956ywc.176.1468260570295;
 Mon, 11 Jul 2016 11:09:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.240.66 with HTTP; Mon, 11 Jul 2016 11:09:10 -0700 (PDT)
In-Reply-To: <5783C90D.1010909@web.de>
References: <57838306.5090505@web.de> <20160711144420.nsibnudjxvgdz7cl@LykOS.localdomain>
 <5783C90D.1010909@web.de>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Mon, 11 Jul 2016 11:09:10 -0700
X-Google-Sender-Auth: XszXMwc1qjvHEVIfx1m3DzLiWe4
Message-ID: <CAPc5daU4qMhpa7EuTyJWF+CtzWOcAPntqj800u-RGmHTUVShqA@mail.gmail.com>
Subject: Re: Commits are no longer gpg-signed in 2.9.0 when "commit.gpgsign"
 is enabled
To:	Nils Fenner <nilsfenner@web.de>
Cc:	Santiago Torres <santiago@nyu.edu>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 11, 2016 at 9:27 AM, Nils Fenner <nilsfenner@web.de> wrote:
> Hi Santiago,
>
> repeated your test here and actually found something interesting. When
> committing via 'git gui', commits are not being gpg-signed, while firing
> a 'git commit' shows the passphrase dialog and signs the commit correctly.

"git gui" probably needs an update similar to what was discussed in this thread
http://thread.gmane.org/gmane.comp.version-control.git/293292/focus=293426
