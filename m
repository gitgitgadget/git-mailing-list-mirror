Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30C51FE4E
	for <e@80x24.org>; Fri,  1 Jul 2016 04:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752506AbcGAEpN (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 00:45:13 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35822 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036AbcGAEpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 00:45:12 -0400
Received: by mail-io0-f196.google.com with SMTP id u25so10376889iou.2
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 21:45:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=IvSMBaMa50q1q3E/KkZs1LjzauzNoGCMW+LxNBGi9MU=;
        b=XaoyOTzuDO4uYJhBYtphhYCbmHuRGxRiNKShrIdj+l0oZYgu2SNGvNLNzphflf4eA0
         InhCLxiGurH7r2fMryG3SK8aUKZsHY1wGZzVfnqAGDu8eJqyoieDUake88PIZxXIkEM8
         YyACYTSJcyrBJv24B/8bm4ZXF+uHKaBO1wl34gnWA5oie5Jo/lQvbNtcHMJw/OP2HFY4
         ua+PPwu0YAMHLRnV556oZYePG8KmwnjpaFy047IbSzPToH3CwP52el4ag6jtcC+9RyT1
         7DAY3rx2zivvHnS1+SWxNkDS0GKjU9nA/SaXHnzr1gOqJ7XW1pf0QmvZF40tJrJ/ZKi5
         DytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=IvSMBaMa50q1q3E/KkZs1LjzauzNoGCMW+LxNBGi9MU=;
        b=TnHURslrHguxE03+QD1x/WTGihIB3d8O316h111wHHSX6els5B+7/OevCdi24Dxq09
         4sISGXTK0EudFbQ+k65W0e8ceIkjfdenDZH5ATw/Qe+mEBcMRUqMoDET2oSBBIkzoW2G
         m6N1PWV2NybcygDt0SihsqYBHRv24ScBYGbR+ZVhYJCBS2ZmLdhGRV0TevHJns3HZF+M
         FY81QS/FEhu40R3p6HlChzmWgwg4VN28O0QQAja6ifKRvvu2X0Vm7fvu78/Pf6iQ5wX+
         SSI69kIh0TLEekC/4tDoFjO+1F/FZg/KUQVMK7WOR6MbYBSg6QYCbHij4+Hx+fn7lMtA
         aqDw==
X-Gm-Message-State: ALyK8tLETQ32i/dFztl0pFBymZTcUwsdTtU7UM6EscMXArRosnyEj9yuf5CYYA/h73Riv18x1Qnqe1OQzjmiAQ==
X-Received: by 10.107.47.94 with SMTP id j91mr1613354ioo.168.1467348311047;
 Thu, 30 Jun 2016 21:45:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.7 with HTTP; Thu, 30 Jun 2016 21:45:10 -0700 (PDT)
In-Reply-To: <20160630090753.GA17463@sigill.intra.peff.net>
References: <20160630090614.GA16725@sigill.intra.peff.net> <20160630090753.GA17463@sigill.intra.peff.net>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Fri, 1 Jul 2016 00:45:10 -0400
X-Google-Sender-Auth: mcTWBLEq5fTiZuSn_5a0BKdnEPA
Message-ID: <CAPig+cS334=jN54Ab46VoNoD7uzEgLXwaNE1ePZwqgZYja33cw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] t9300: factor out portable "head -c" replacement
To:	Jeff King <peff@peff.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thursday, June 30, 2016, Jeff King <peff@peff.net> wrote:
> In shell scripts it is sometimes useful to be able to read
> exactly N bytes from a pipe. Doing this portably turns out
> to be surprisingly difficult.
>
> We want a solution that:
>
>   - is portable
>
>   - never reads more than N bytes due to buffering (which
>     would mean those bytes are not available to the next
>     program to read from the same pipe)
>
>   - handles partial reads by looping until N bytes or read

s/or/are/

>     (or we see EOF)
