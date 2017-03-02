Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A142013E
	for <e@80x24.org>; Thu,  2 Mar 2017 22:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdCBWfi (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 17:35:38 -0500
Received: from mail-it0-f47.google.com ([209.85.214.47]:36483 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751553AbdCBWfg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 17:35:36 -0500
Received: by mail-it0-f47.google.com with SMTP id h10so2676179ith.1
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 14:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ogUiU8tCCUZfecPGS7+oBCR3UC5VWumtUkp+k7emlRY=;
        b=RT2THmr2Qxz055w4jaq18TrpZrrQyCIMVWtW+PLC6KbygU86jV6w9lwvGizZeyFbrd
         7Ac6bzBeKb4hnUBH75jBAGaHACLbgs/24M+0tAoEtWmnUbPk0uWW0Da1ZHWVT/7mV3cs
         9WzoPQtQQcmpCGpd1GcXKZfhWn5W1vel26KFmH9cBvqquwTLeCzyRJB8fMZMU9WZj5sY
         d3OSXctGoLKT9b9f94m7tCEYwmyjQlCNanKtxfwmQLmVNaQoUyrbxnKR163Dnw2qJ8af
         6aK7GvCAfHufz0VFilvevHwjs+pKWh5JMgop5PI4IXn3HerG7LuQhGEjXTDv7j47YErZ
         QWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ogUiU8tCCUZfecPGS7+oBCR3UC5VWumtUkp+k7emlRY=;
        b=Zb8ndepGKoufm/W4nXPSbZOkIxToUdpK9H0bWvToJb79oVg21gyhL+IaQ8Xm6mL/rJ
         bO3sdp9b+cZV0q0c4S9dcZVIS92dfeuufHnCPqpjOOxcOkyxwz4WGPA/sa1jeiWYmi4g
         b3X2RBQ2osukwVjRVU8yjMzByG2q8raVbZ/uvm0T8efCZNvYTmf1TSKqDvwjkPToQ3zC
         EUCDw/DKrsL+CdngsMeYVYVrmEiSsNDdyTwbVKldv044Hzrntykueq68IxWONYXEkjc6
         c1FgyzyCmHeiwXdSMIqH7ZfL6utYwQPPjObpY5AqIYsIs0c6fin1pKnpl/F3KsvZh62U
         9XYw==
X-Gm-Message-State: AMke39llv/eAmCkzVtdomzpq0zFRBoOBKu9MiYtqHDE/Lu3tcA7iM8lGkJLOhNdd9QB3Fl1/d8Vll7kt8+R7+w==
X-Received: by 10.36.66.141 with SMTP id i135mr120232itb.86.1488493635906;
 Thu, 02 Mar 2017 14:27:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Thu, 2 Mar 2017 14:27:15 -0800 (PST)
In-Reply-To: <20170302215457.l2zhxgnvhulw2hl5@kitenet.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <CA+55aFw6BLjPK-F0RGd9LT7X5xosKOXOxuhmKX65ZHn09r1xow@mail.gmail.com>
 <CA+55aFwXaSAMF41Dz3u3nS+2S24umdUFv0+k+s18UyPoj+v31g@mail.gmail.com>
 <xmqqk287be9l.fsf@gitster.mtv.corp.google.com> <CA+55aFziZRA29foAMbM-HS5fiup7T0TuYf4XQ1kNT_SR7FfSgw@mail.gmail.com>
 <20170302215457.l2zhxgnvhulw2hl5@kitenet.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Mar 2017 14:27:15 -0800
X-Google-Sender-Auth: za0g_Szn8UTfHFe8bzLO3UMquYY
Message-ID: <CA+55aFzdJcFZQdJ78rvZ92nNZRsKfcUKMCiXwTVYR34JAuznrA@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Joey Hess <id@joeyh.name>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 1:54 PM, Joey Hess <id@joeyh.name> wrote:
>
> There's a surprising result of combining iterated hash functions, that
> the combination is no more difficult to attack than the strongest hash
> function used.

Duh. I should actually have known that. I started reading the paper
and went "this seems very familiar". I'm pretty sure I've been pointed
at that paper before (or maybe just a similar one), and I just didn't
react enough for it to leave a lasting impact.

              Linus
