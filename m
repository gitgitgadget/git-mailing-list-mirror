Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CFEF20984
	for <e@80x24.org>; Tue, 13 Sep 2016 22:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758145AbcIMWAU (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 18:00:20 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:37308 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758428AbcIMWAS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 18:00:18 -0400
Received: by mail-it0-f46.google.com with SMTP id 186so64694654itf.0
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 15:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7f8Y9NYFYrQ2KhGaP0OUCaiSOxteNV6A8a1i7FH+Pl8=;
        b=gbGAXyXNanmkVbhKk94pdZFMl9djjh3VOJsvC9sXnOJ7dHONM4jzwYmZpXMrU+eWzG
         heNZ5Xcm07JFta9zgKr50cyGCdgV/cy2icvzhxd2p/DBm4NK8Kr/A3YUq6MnxWBG+JwI
         VBOIVIcOyT9LHEfdWnOtqI5uZ7euNDcixDYcmJGrOi9xrniZWbcYA2ja2D8CqAxczjvS
         iZckSQmfykHbrPz9KqFVjmgXSzcGxqKvrxIrE6ulEA3nvwtdvm20O2MRgXWNfWU7b9xO
         yAIGueJw9RrOstlOXMIXACO0NgWv6oMPQBuWszgtZN6vr6+c/TnHynwdUXpRqo4N6u9Q
         UPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7f8Y9NYFYrQ2KhGaP0OUCaiSOxteNV6A8a1i7FH+Pl8=;
        b=gVp7r2p3V+3MqdmE7rbIvc2lGyEdXTQUOU1/IdqY2inpUZNjzBO7174LrHERBVvEwC
         8/BwZCd4kM8vqA992mOIiztS/b4o9qOvXYUOxFQJL5uoTX/a4SWqorE8W56u7U+YGEYV
         uSRScWnaRN0w2lTiiUd0egN9bc80D9Z9JvLCWtYNWzFfOkPco25ZbsaRscyWS6/pCxYC
         E+K8Y2xtqTlHlSnXjmtJWQGeBviIqgg7NEhjicA0QgcrGBcCGi3PQBVdbjzTptSixbnc
         qL+NX9BVac5NFyLgJWFKcHtThWAOOtIKTcamtGpOKwBIquy/ghWpy7b5iVHdoYOXHpNW
         BeIA==
X-Gm-Message-State: AE9vXwOwpgF+2ELZnAGtleZWIDCY9yfv5BmNR44Ow9s6VTS+bFAAYCR//PW+MBYziyUWToTcIJiuFFrKwoscFgGU
X-Received: by 10.107.12.166 with SMTP id 38mr6126773iom.159.1473804017550;
 Tue, 13 Sep 2016 15:00:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.173.98 with HTTP; Tue, 13 Sep 2016 15:00:17 -0700 (PDT)
In-Reply-To: <20160913032336.cur3rrzpgepulqi6@sigill.intra.peff.net>
References: <20160913032242.coyuhyhn6uklewuk@sigill.intra.peff.net> <20160913032336.cur3rrzpgepulqi6@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Sep 2016 15:00:17 -0700
Message-ID: <CAGZ79kYNfUmBG+9irQoZ+C6qfiiz0P7pGKHZVk-8569gk4+_EQ@mail.gmail.com>
Subject: Re: [PATCH 06/16] diff: always try to set up the repository
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2016 at 8:23 PM, Jeff King <peff@peff.net> wrote:

>   2. If you're in a subdirectory of a repository, then we
>      still try to read ".git/config", but it generally
>      doesn't exist. So "diff --no-index" there does not
>      respect repo config.

Nit:
So IIUC your cover letter even this /used/ to work but
broke only recently? So I feel like the message is a bit
misleading (i.e. you argue for a change in behavior instead of
calling it a bug fix for a regression. I think a bug fix for a regression
is harder to revert as compared to a "new" behavior)

I agree on the code, though.
