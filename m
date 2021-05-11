Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD152C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8385861168
	for <git@archiver.kernel.org>; Tue, 11 May 2021 20:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhEKUoG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 16:44:06 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:60737 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhEKUoF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 16:44:05 -0400
X-Originating-IP: 73.26.133.58
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gpanders.com;
        s=gm1; t=1620765777;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R9GuwAKkA53cTk3L1du7iSry8ve0Iar251833PqI4xA=;
        b=F8CxqgNAI5YCfCBFSM4S36KVbxoJNZEsqpz1IbsNSvUyQyhzzskpYWIl3Wd6J/4m4k9K7o
        +ZT3zqudVwoFRv6wDAVGJ1nZvDnrMFozePeOz2kpnWxtDdGXLzV1gKNuRYVaP9G2md8ou2
        vfNu3Me+Q1ibUzqm91E6FCYHuPRUHn8WxkdIxnkiuhW0t0DUqQ39xnAG5E46H1HmBki3bl
        HwVX2Qne40h7sBJpLNvbsKA4D4UPuz8nO0OthIKYcTNxLelR/nfroSrdcEFG+1sEhw5C4S
        t0zvq5aFkIMDKUKbIKIVI2o1MuKw994QX2sF0FmY91A+IjCtF93CJdhQGUfb5w==
Received: from localhost (c-73-26-133-58.hsd1.nm.comcast.net [73.26.133.58])
        (Authenticated sender: greg@gpanders.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3C9BA60005;
        Tue, 11 May 2021 20:42:57 +0000 (UTC)
Date:   Tue, 11 May 2021 14:42:54 -0600
From:   Gregory Anders <greg@gpanders.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJrsTu5YtGNpQvZh@gpanders.com>
References: <20210511191510.25888-1-greg@gpanders.com>
 <609ae32e3b9f_60649208e0@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <609ae32e3b9f_60649208e0@natae.notmuch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 May 2021 15:03 -0500, Felipe Contreras wrote:
>Is there any particular reason why we are checking for an absolute 
>path?

The existing behavior is that the value of smtpServer is a hostname of a 
server, *unless* it is an absolute path in which case it is interpreted 
as a program to use to send the mail (e.g. a sendmail alternative or 
msmtp).
