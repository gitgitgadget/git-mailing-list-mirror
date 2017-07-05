Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 353FF202AB
	for <e@80x24.org>; Wed,  5 Jul 2017 07:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbdGEHne (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 03:43:34 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34827 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbdGEHne (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 03:43:34 -0400
Received: by mail-io0-f181.google.com with SMTP id h134so81499030iof.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 00:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I1P8MbHpaRup4JGGKPWB94bhhW6bKO0EZvLmOwc/T4c=;
        b=ExO5elvcB0tPCq4Sw+WcqFOILmDL9yCfGXqeHbjzey2Xw0GKbJMnpDZtpXhJYGEeHs
         zWkcEi1G0s/7UNSz5xnMc3iVv7DH+oyh4GdsU3KiKgai95uqBNXGXq4d6ngZzU4ckbpT
         DRS6A7Flp9Pr7/A0lZyL6jBbQFxp9y2yV/gdXvRHhcu4vl2VnP5HfHvxeS1/DiA/N/Fn
         sM356ow5TKjFF9tGohEcYrCaUoka/Qm8BJCX3J8ncfp2GhxHKDILkoCwGA6Q5gQNWAvV
         i5rzIvDgD5LeV1cOpbkeYl6TjhGqnezV+jtB2dR1yl+Wy1vuH4WWsn8RJ8f5SVUOZu7O
         LZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I1P8MbHpaRup4JGGKPWB94bhhW6bKO0EZvLmOwc/T4c=;
        b=T4JOPQ0ULm74GmhjgK+LpzcX7lpFnK19SEIUtT0deAJn3RQXP+zBk4u2hOcFoMMX7H
         wunR3e/ehlvN56xP3KuJobQJlK8J6D70BLJdYIqCZCntFKFpgF3vDkN9FKnR8hEtqHEb
         Ca0qf/+Ag4wHzP1oQbce1NjgPcu7xmGCmg+BBOd9ZhA0BQcrp0f9iq5pI+5wm+lSyBK3
         WzUYIbrFgulBBkYUEBdSNwLhjNUZgy64BnDHUp1pyFTN0MwsrBclQCGhj2YpnDzILKIB
         gByQc/LvYnrQrfkVoineGU4xClwHRjBwJ05dA0nU9wLijWFfndVWQ1f7OL9mIteV6wX6
         Y1Pg==
X-Gm-Message-State: AKS2vOy9ryAKeEsns6yinM2p2PcwHwpvWXvMN+BwuSyd3GskDMWZBuem
        K4jKw77lDhz0GbXSAacuO7Z4MaPK99nHa/I=
X-Received: by 10.107.11.201 with SMTP id 70mr43385441iol.222.1499240608026;
 Wed, 05 Jul 2017 00:43:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.20.136 with HTTP; Wed, 5 Jul 2017 00:43:07 -0700 (PDT)
In-Reply-To: <CAPB=P5xsssm=RiAkEuAtpxe52+-sNAPVP2qnQGctLjNZFYznkg@mail.gmail.com>
References: <1499116727-757-1-git-send-email-f@mazzo.li> <xmqqvan8jdje.fsf@gitster.mtv.corp.google.com>
 <CAPB=P5xsssm=RiAkEuAtpxe52+-sNAPVP2qnQGctLjNZFYznkg@mail.gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 5 Jul 2017 00:43:07 -0700
X-Google-Sender-Auth: Mr3LZpY-jOVLP36C3MXipxYMP9Q
Message-ID: <CAPc5daXn=PJ47JkZQNnReNNSUhQK3eJm0Namd-A+e9TM4Dnr2A@mail.gmail.com>
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
To:     Francesco Mazzoli <f@mazzo.li>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 4, 2017 at 11:34 PM, Francesco Mazzoli <f@mazzo.li> wrote:
>
> Could you clarify the danger you're referring to? E.g. give an example
> of surprising --force-with-lease behavior that we do not want to
> encourage?

https://public-inbox.org/git/1491617750.2149.10.camel@mattmccutchen.net/
