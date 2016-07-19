Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 057E81FEAA
	for <e@80x24.org>; Tue, 19 Jul 2016 18:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753698AbcGSSY3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 14:24:29 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36407 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbcGSSY2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 14:24:28 -0400
Received: by mail-io0-f174.google.com with SMTP id b62so26580337iod.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 11:24:28 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h8fiPo+d1GpYgMoGGp3EJrgVoDHtb+xME/GT98+5Wd0=;
        b=XGbx502iE9SED/s6VBPRaBWgQeAU2sDODiFq/9NDIcRufKEv5ppQUobTzO0HYrhq6a
         YfGKQVop8aTsPEAXDIh/bqX8ws2Wq1+MDZJfBbRnKkIChDI/F3+jE6qVEMCyvGu9RFP6
         xBoAesmd2G1m8joocuaU69sm8Zch+PYFwRHHhjb3yN9YULj1H5Mcb9gdiNgFm61q1Rmn
         CakRSe/934kVREvPpGyFuNZQAPnShDX4421ReU28vAoVWmiTNmEO9iI8FOW2f3uYqnLp
         S9FLPA7vGr1dtppl8Go7w7rhfUfCGgIolQ1YdgOhcWy3XA8JBT7aVLHPXsiNVic9KI+/
         zBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h8fiPo+d1GpYgMoGGp3EJrgVoDHtb+xME/GT98+5Wd0=;
        b=QTvcFd29uzLC88TQoyMapb7oTm+lkA2D/gfIG8Wzxi/OK9viUCTE5Kzihz6K6mo+M0
         wer9hoQotEM3Bg3nI+B8p61DMK7y7QsInrhmwSBt2eemoy3hJOGyDETd6+CUXhlaajRM
         giZuXgjQdOPih3eBlKA1wtF2Sav5C+QrxVArPQoyl9atXTR9xwkpx6Ch7QxPvt0GXc+Y
         JhOIIvuRgLI9oD2+r8vVkmlv22eeh7FpoLtT4io50HOH6C97cIipqwHJMBw5922DsIOo
         +Q6p2OI8InpER3oTJyZlOf+by88r2lS9kR++BhsipGeCPeQ9PtRrvGwzG3tqrWX15bgY
         nyEA==
X-Gm-Message-State: ALyK8tIKyBaiimIZMHVchKV37XnsYiZ2dqd1mNOUcORYG2XLnIITyVfbSEgPdjDM+Tk3ZegGGQ4DCoGxw0wS3g==
X-Received: by 10.107.2.78 with SMTP id 75mr3748670ioc.128.1468952667452; Tue,
 19 Jul 2016 11:24:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Tue, 19 Jul 2016 11:23:58 -0700 (PDT)
In-Reply-To: <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
References: <20160719144701.571-1-antoine.tenart@ack.tf> <xmqq7fchh5bo.fsf@gitster.mtv.corp.google.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Tue, 19 Jul 2016 20:23:58 +0200
Message-ID: <CACsJy8BDRPK2UKxoMat3i2HL38+KFqw2Qfet2Bev26HXRM-BWA@mail.gmail.com>
Subject: Re: [PATCH] worktree: add: introduce the --name option
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Antoine Tenart <antoine.tenart@ack.tf>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 8:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Tenart <antoine.tenart@ack.tf> writes:
>
>> Adds a --name option allowing to specify the name of a worktree when
>> creating it. This allows to have multiple worktrees in directories
>> having the same name (e.g. project0/foo, project1/foo etc...). This
>> commit keeps the previous behaviour by making it the default value, i.e.
>> by using $(basename <path>) as the worktree name when the --name option
>> isn't used.
>>
>> Two new test cases are added to ensure the --name option does not break
>> other functionalities and is working properly.
>>
>> Finally, the documentation is updated to reflect this --name option
>> addition.
>>
>> Signed-off-by: Antoine Tenart <antoine.tenart@ack.tf>
>> ---
>
> Hmm, is this related to an earlier discussion
>
>     https://public-inbox.org/git/20160625051548.95564-1-barret%40brennie.ca/
>
> in any way, or is it an independent invention?
>
> The conclusion of that discussion thread was roughly "users
> shouldn't even _care_ about the name, and if they have to use name
> to identify the worktrees to do certain things right now, reducing
> the need for such 'certain things', not making it easy to give a
> user-defined name to a worktree, is the way to go", IIRC.

080739b (worktree.c: find_worktree() search by path suffix -
2016-06-13) from 'next' should help identify worktrees in this case by
specifying 'project0/foo', 'project1/foo'... Granted it's not fun to
type all that when 'project0/foo' is something long, and bash
completion probably does not help much either.

Note that we may need a unique name elsewhere too, e.g.
refs/worktrees/xyz (even though we haven't settled on this yet). Then
xyz would be more exposed to the user and an easily recognizable name
would be a good thing.
-- 
Duy
