Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B55201B0
	for <e@80x24.org>; Fri, 24 Feb 2017 09:43:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbdBXJnU (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 04:43:20 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:36556 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751084AbdBXJnM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 04:43:12 -0500
Received: by mail-ot0-f173.google.com with SMTP id j38so10909591otb.3
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 01:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Beq5+arJKBqDhlPIvdASL02xfJSJLRCChp+fo3re52E=;
        b=Ozj6tniEAN7b9SHQH6ooHoB+yUA5g7I5HaViLz3EFP+TyZzTY+JB3NCIJ8knie8gBY
         VAZ1PkuLAloPyBSEUyIpJApSGUPFRuRtg03+9pqIlZkUJD4xum5MH7OMYtdmf0gjvNlV
         fcVAfP7lvRmDRA9iw3yoZQc9+3949hkbTEXYt0fdE57q7MenMddV+h+7A5EG1NwpPhfQ
         ABolFJOqGYVaGcVnfq4lmeLuQLHf+7Vf+BITg1Aj9nC9nzs0MWi/U1rb2xGtdpOiQtyy
         AbfmOFqKs/IfXNdsG4fH/Aislgli2lEhDlTJTGNhNn87Utp1ymHafFgNA2jhpb7tTvGp
         Eddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Beq5+arJKBqDhlPIvdASL02xfJSJLRCChp+fo3re52E=;
        b=oLJ8x0P3HG+FkhW6gj0YrqoIVH/4yXlDEcJu6UmdrEz63FCtMXOI0vY/D4Bk9t9fu0
         9JBOKNe+QCkuNytSvqKfvwAjjOXNcSevZLg7wnyBMyF+JNE6RHQ2+iBdwFaXYFaxITHQ
         FxVQUbHPqMwu7yEBHVuPA2aluvMLcjC9vayF1/x+Ckd/L7UQMsl0lZ132A0JJtbQn2bg
         zt03pRTmGibaKCgI7o2K3XXav65I+ljsBopcGHNIdEp76Ca0QKoNCIKM5UxUAnoAj/9o
         B2ddXfXQLWSuBPpm54CJmFT0QQUxkrEo3K5/b4C6dBZk5RwhSMcZkaYvBVXQ5GA8cyQT
         VviQ==
X-Gm-Message-State: AMke39lP2DpREah9Wvcd+Hlb1zyz2LB+hlv9o567Gr/IhrGnKwJ491T7bXleahPl5jjTMGY7/HSbMRVkc/ZvZw==
X-Received: by 10.157.6.233 with SMTP id 96mr947051otx.37.1487929389150; Fri,
 24 Feb 2017 01:43:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Fri, 24 Feb 2017 01:42:38 -0800 (PST)
In-Reply-To: <20170223164306.spg2avxzukkggrpb@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 24 Feb 2017 16:42:38 +0700
Message-ID: <CACsJy8AtQG8YXQ+YfSFifUxqtd==THj5weJK5jooyiRN0yamiQ@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Joey Hess <id@joeyh.name>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 11:43 PM, Joey Hess <id@joeyh.name> wrote:
> IIRC someone has been working on parameterizing git's SHA1 assumptions
> so a repository could eventually use a more secure hash. How far has
> that gotten? There are still many "40" constants in git.git HEAD.

Michael asked Brian (that "someone") the other day and he replied [1]

>> I'm curious; what fraction of the overall convert-to-object_id campaign
>> do you estimate is done so far? Are you getting close to the promised
>> land yet?
>
> So I think that the current scope left is best estimated by the
> following command:
>
>   git grep -P 'unsigned char\s+(\*|.*20)' | grep -v '^Documentation'
>
> So there are approximately 1200 call sites left, which is quite a bit of
> work.  I estimate between the work I've done and other people's
> refactoring work (such as the refs backend refactor), we're about 40%
> done.

[1] http://public-inbox.org/git/%3C20170217214513.giua5ksuiqqs2laj@genre.crustytoothpaste.net%3E/
-- 
Duy
