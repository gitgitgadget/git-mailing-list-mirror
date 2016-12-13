Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 799A5206A4
	for <e@80x24.org>; Tue, 13 Dec 2016 11:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932756AbcLMLas (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 06:30:48 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:33551 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932706AbcLMLar (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 06:30:47 -0500
Received: by mail-io0-f174.google.com with SMTP id d9so218931751ioe.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 03:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OgR3A6/dyLn2PzRD+Qm3UNjF/qglertkmNJlI8ef5Lo=;
        b=aX2cQzYwHPnHDOYdGpGEQ324h3FIhypzSeWccEVifrlAlhHLGnwn1e/pmcQQ2JiDN6
         KBN/De+qct3YIOg0FfVRLWhQnaaZ2Oppr7/gMilNMTd76pKayIYL2iYsUaZzigvBwT1X
         Oc19m62AcD5M/67+EvyOH9Vz9tUjMR2nWo2mLWtHQWbUh3QOOrHEScBmxOAzJ3FijL++
         oeDLgkcFc3CIvEmTYPWrAJLqNRW42z8lllbn36aY2CQjz2jAsQwNEt4hFYjq8w9BVO1f
         37P/+83cltI5PL5dgbyc9J0hafTazhTa7ijKDMZdAL8dokf3cAVO8n5U7pgGiP8kWALE
         U/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OgR3A6/dyLn2PzRD+Qm3UNjF/qglertkmNJlI8ef5Lo=;
        b=PNWqpyf6Ths8TUZC4wGHfKbpTg3O1Oyjzva8JEv7c5hWGhJLb0qy2KcmIvs9UrFY61
         3rpexROz50gj4i/PC1WD1pfUxc/Qnj0kwNjoCu9SWMqhaF6bSnPIYKCdGW4jCNvCBo2d
         C0/fN37wMde1SZMwak5MzAJEF0iMd8mXAFAmkBherCoMlJy7Tim17NgemxGKROEf1zRo
         jFL1n9dvC1ANWAyQ0ju+ZpNCVetXP7VtAE2sLx/E6ztSbhZkcHCCJ7uROP0B8tueHZZp
         eD9N9eoA9bBkGTesG8uf/Nd3c58yAdn3G0McNpOqDpoZxEmZRthnu25VFi+GcgGy1TIP
         4+WQ==
X-Gm-Message-State: AKaTC02fA6OoWXsejuFRmDQD4D+mKWJn8wGrgZZzZEnXrmTr9JBswY99lkgCxXe3rnIqj8vHhfL2CHf0jF2nVg==
X-Received: by 10.107.132.74 with SMTP id g71mr85746204iod.19.1481628646445;
 Tue, 13 Dec 2016 03:30:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Tue, 13 Dec 2016 03:30:15 -0800 (PST)
In-Reply-To: <20161212195222.rxnabok6amklt2zf@sigill.intra.peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net> <20161212195222.rxnabok6amklt2zf@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 13 Dec 2016 18:30:15 +0700
Message-ID: <CACsJy8B52ZDRTUjGLqub_1wELtugv99xbDnBg1PX1LUTb6nVMQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] alternates: accept double-quoted paths
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Klaus Ethgen <Klaus@ethgen.ch>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 2:52 AM, Jeff King <peff@peff.net> wrote:
> Instead, let's treat names as unquoted unless they begin
> with a double-quote, in which case they are interpreted via
> our usual C-stylke quoting rules. This also breaks
> backwards-compatibility, but in a smaller way: it only
> matters if your file has a double-quote as the very _first_
> character in the path (whereas an escape character is a
> problem anywhere in the path).  It's also consistent with
> many other parts of git, which accept either a bare pathname
> or a double-quoted one, and the sender can choose to quote
> or not as required.

At least attr has the same problem and is going the same direction
[1]. Cool. (I actually thought the patch was in and evidence that this
kind of backward compatibility breaking was ok, turns out the patch
has stayed around for years)

[1] http://public-inbox.org/git/%3C20161110203428.30512-18-sbeller@google.com%3E/
-- 
Duy
