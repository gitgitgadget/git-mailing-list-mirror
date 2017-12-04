Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64D3B20954
	for <e@80x24.org>; Mon,  4 Dec 2017 19:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbdLDTv0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 14:51:26 -0500
Received: from mail-yw0-f174.google.com ([209.85.161.174]:35916 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751205AbdLDTvZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 14:51:25 -0500
Received: by mail-yw0-f174.google.com with SMTP id r205so7149525ywb.3
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 11:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2W1Hi+CwVgkGE/YSrtZrWV4CmNBOTvtfAl8xQZZo+h0=;
        b=OChWqWQOYaZXxHMjYuIaxSz12kO0RMCXZwN5uw+285uBDh8wrBwyrn6CmVmmZqEwXr
         h+FNGrpw/A9hy7FpO/A63MEsRm5kuxKCbN311idlmNOylYUX8tKtTFQ3YLz83c6ZYuIW
         yB0Oc+yZu/yrET5jzkJuqhdLsLJkB8n0nabi/V/BzYnc3e+yAgXX1NnBL0RcYgCKN9TH
         6kVlInBHEdRc/THXScs2tjkAr6YSLmKTrRoHC2/ev911fsv+6/+Quv1Qei5aZAlkFcdN
         5tVgYOQyFertVpB2DeAi8sCyA/1BNOMI2/Ekg9kEszpD8Y0/pHkXNJdMvwJR6jCoUD5a
         iieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2W1Hi+CwVgkGE/YSrtZrWV4CmNBOTvtfAl8xQZZo+h0=;
        b=Ibh07cTOR7IT2j4wp29Pb3AX0MzJZHpYbjW6a+lEGxzCRGAxg3DSTcc3HfMH+F4Zs0
         JpPZpP8I91namSIcTs1fbMKwwhE5FTiGkTEYmR6qBXe5+Oo+FT34djL60H1QQLz4WS/k
         /Pzu/Q3gp3m6sGMNzKa3hQMiF9Q3NrchgLHAdXFEF36SktzrF9xtEpOHUuKBYSK5ef+z
         vhOyKagOptZPR6zhHo4PKOzG8kTO7IlsYSgJwT6L28H5PldGelq8E5qMvMi+/C3raSlw
         DcI2nWiq+Tek4mPMIQplvCEFZCxkSGJzFZoLhadiJg1UT34ZvQVwMqidKZXYOxVgPnB/
         4GsQ==
X-Gm-Message-State: AJaThX5kJsieIvMnU6GVTHLe3WTdkQugGd6eqr8/jWALPnLr3ZEUo6hq
        f9Kq0K4opEr8pzYG5puMrTKd8Q==
X-Google-Smtp-Source: AGs4zMYTsWGdK+U4xeeue27egn5n0+bHSlVQcGX46H9mv4zBdvzme/qzToz2JBTNnnGlwYQ7N7yJAw==
X-Received: by 10.129.229.14 with SMTP id s14mr11181698ywl.392.1512417084372;
        Mon, 04 Dec 2017 11:51:24 -0800 (PST)
Received: from dnj.pit.corp.google.com ([2620:0:1019:0:5840:7173:18ff:ed41])
        by smtp.gmail.com with ESMTPSA id z145sm4089199ywg.76.2017.12.04.11.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 11:51:23 -0800 (PST)
From:   Dan Jacques <dnj@google.com>
To:     gitster@pobox.com
Cc:     alexander.riesen@cetitec.com, avarab@gmail.com, dnj@google.com,
        drafnel@gmail.com, e@80x24.org, git@vger.kernel.org,
        jrnieder@gmail.com, madduck@madduck.net, pape@smarden.org,
        pasky@ucw.cz, peff@peff.net
Subject: Re: [PATCH v2] Makefile: replace perl/Makefile.PL with simple make rules
Date:   Mon,  4 Dec 2017 14:51:21 -0500
Message-Id: <20171204195121.6647-1-dnj@google.com>
X-Mailer: git-send-email 2.15.0.chromium12
In-Reply-To: <xmqq4lp6mg96.fsf@gitster.mtv.corp.google.com>
References: <xmqq4lp6mg96.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:

> Well the thing is that I cannot queue this and Dan's at the same
> time, while both of these topics are expected to be in flux.  For
> today's pushout, I tentatively kicked out Dan's relative path series
> and queued this one to see how well it works with the rest of the
> system, after giving this patch another round of reading.
>
> It seemed that Dan was happy with (an earlier draft of?) this
> build procedure simplification patch, so hopefully we can solidify
> this one reasonably quickly and ask the relative path series to be
> rebuilt on top of it?

Sounds good to me! I'm in no rush, and if this is moving forward I'm more
than happy to wait for it to land and rebase on top.

I didn't want to weigh in too heavily on the actual details of this patch
since I think the majority stakeholders are the folks who maintain the Perl
subsystem and those who build distribution packages. My work on Perl only
touches installation as a means to an end, and avarab@'s work does simplify
this for me.

Cheers, and thanks!
-Dan
