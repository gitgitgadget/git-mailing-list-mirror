Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A338C1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 18:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbeAYSts (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 13:49:48 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32973 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeAYStr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 13:49:47 -0500
Received: by mail-pg0-f68.google.com with SMTP id u1so5621695pgr.0
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 10:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=g2sAIJTg8fWO4+qTeBWMApPWRyQhysie0oO27wmoUwg=;
        b=aggTMcJzOy+6OLlrFUnxdIUADUWgLDcJGkNRFE4+bFufbWOM0Babi4YOpzVAdhBou7
         9NO7mwcRVrbEB2Fx5ip1vLN/sGsdGrKxeGEjY57mLMQ7gU/awzMEz6ucjZv9WERGo2yj
         1DkI+mkHRX/EFIE/KF1qr+gHtPn052d3LujovKJUa3yDwImJDTGqRNI1uDQA9pi71uKU
         BLXsVFknELMX9MVI/ZL3b0w421Vh8n9FZrD+2qMBaxiW3yx25X0Hv45CicFhL8JlSBh/
         WTbaU7PmI+zrpyw6I4O65eRkmnrmHD41tjHqoIJzJZbQbLcga9TQ8tcYUhutk2QTD0N4
         0UnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=g2sAIJTg8fWO4+qTeBWMApPWRyQhysie0oO27wmoUwg=;
        b=YRSYPEsJ6yVb2sJNQo5aQG51A6D4gFsYusxQk2emeQaQ6WSjLi6rPjQRUyvc+rJRzS
         g+zU6yxqQ+aTBpcdKBTbWEYVf+xrCtFpYhGifcwPVxyvyXqLjuTYsKv1rBFTJer1xo0a
         r7IaPIJTDioWp/0SpF/lT20AvqMSsJB+tKlF2MyFwThGSEMAVM0NM/ykdIBFEm7WtEDw
         7Uot1p/Vjd1ijFjCGP555yleXwhMxuVJ3jF3AXDPe7elWm+RveHGPw8NcPucm6dtHca1
         lllrdLU7xfBMPEh+IctFqnamTLgVlVBKCvkMMq5Olt5KMP6ZkXC00QaueWRB+MSBlaAT
         LQuQ==
X-Gm-Message-State: AKwxytepDKfesTkQFrC11v/QBi4YqUTGxwWXKRdlAQLHhO4afpX6G0lC
        HzgTcGmhzNkCPnMA/Vy4P2xETqm3
X-Google-Smtp-Source: AH8x227EsP7Vrrpp1ue6OmrwWF6/gyHXMqAaotJTSrZwqQXPrmhSOwntnsdwGYGjv3e/37XLkq14/A==
X-Received: by 2002:a17:902:8646:: with SMTP id y6-v6mr12363205plt.406.1516906186973;
        Thu, 25 Jan 2018 10:49:46 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f924:a479:e3c:a7cc])
        by smtp.gmail.com with ESMTPSA id m10sm5292502pgt.56.2018.01.25.10.49.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 10:49:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge: support --strategy '?' for git-completion.bash
References: <20180125094031.6584-1-pclouds@gmail.com>
Date:   Thu, 25 Jan 2018 10:49:45 -0800
In-Reply-To: <20180125094031.6584-1-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Thu, 25 Jan 2018 16:40:31 +0700")
Message-ID: <xmqqo9lhai46.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Bash completion support gets the list of available strategies with a
> grep and sed trick which does not work on non-C locale since the anchor
> string is translated and it does not cover custom strategies either.
>
> Let's do it a better way and make git-merge provide all available
> strategies in machine-readable form.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  Another, perhaps better, option is add "git merge --list-strategies".
>  It requires some code movement, so I'll try with a simpler approach
>  first.

If you run the probing "merge -s help" under C locale, that would
just be a one-liner, no ;-)  I.e.

> -	git merge -s help 2>&1 |
> +	LANG=C LC_ALL=C git merge -s help 2>&1 |

Not rejecting the patch, but just wondering.

