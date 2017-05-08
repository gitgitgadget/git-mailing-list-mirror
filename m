Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56E120188
	for <e@80x24.org>; Mon,  8 May 2017 05:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbdEHFOE (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 01:14:04 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36667 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbdEHFOE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 01:14:04 -0400
Received: by mail-pg0-f65.google.com with SMTP id 64so1384044pgb.3
        for <git@vger.kernel.org>; Sun, 07 May 2017 22:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FN18QC78dXNKD/1aFAJLpUVfYDYTMpSdTvolcqZqPk0=;
        b=AhhX95LvE2wNS+KfbzLa3cYls5+mEnj64J3dWqGfhnsm5CM1Qw6bddTzPv/cMY1MPd
         PST51gzAOBYv6a7hC9ZayOAykwpBZi+QvxiA1tI4MX0MMLbZ40IS0thDl75zHezWeZrn
         k++Zz4RkMSACPGxiMtSlNrczfHGrtbtMaB6plKSNpSz0sGeiiUurct6v111UoIGhn03+
         8xnXMe71aMO0V+AMooGesUE3eF7NKieCPTjMM1SuuZi9PbbYW83QYfaa1m+M6ROj+hYB
         1sBc3M+90zy8KCtdA6ACm4sM5RU9kpOlzvvEDGDBCP7qtPXsN6g/UEaDh5V3HozA38Cu
         LDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=FN18QC78dXNKD/1aFAJLpUVfYDYTMpSdTvolcqZqPk0=;
        b=LxTK/msoeWPv9gPIMAg9/O8WpMz071gUja0NA2jk1hGE0y5I8j6VzfTqFpjaXxuNBw
         47W77XLDpZ6gFuoZVFunCGkDZppBTCtxRt/0iG/8Uk5aZ3OlGEBaGgvH46VCooLYRt4I
         6fHhOK/B8cVut3vnyAoniLornHWEZeAe5dImJtKck8tXQsrmEFoqOh4X0hxDW+crZj0c
         c2MpIjDZ5kExYZCU6i5DYnI65fjNoJnH4LGO5sR4X2bIzIQaluypSwxjQo8FF7zcbaEE
         nZyYZNRyCAHoN8h4mkzQN4risY6JzB4f6m4s8rYqGzQvJ7lARr5o+SyADE4FqocB/9CR
         x8fw==
X-Gm-Message-State: AN3rC/5gNyl/3Db5ZCKdQWp3Cxa8YDVT1V2zN8yKKfRSgmg0aIc30Ukd
        1LFOcRbOesDXO4vbRd8=
X-Received: by 10.84.136.135 with SMTP id 7mr45302298pll.33.1494220443431;
        Sun, 07 May 2017 22:14:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:2823:d4da:fd9a:464a])
        by smtp.gmail.com with ESMTPSA id e185sm21529804pfa.115.2017.05.07.22.14.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 07 May 2017 22:14:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 5/7] t4003, t4005, t4007 & t4008: handle CR/LF in t/README & t/diff-lib/README
References: <cover.1493728172.git.johannes.schindelin@gmx.de>
        <cover.1493891336.git.johannes.schindelin@gmx.de>
        <8afbd831b79b5978c1c2f8641a911c02e4175de2.1493891336.git.johannes.schindelin@gmx.de>
Date:   Mon, 08 May 2017 14:14:02 +0900
In-Reply-To: <8afbd831b79b5978c1c2f8641a911c02e4175de2.1493891336.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 4 May 2017 11:50:31 +0200
        (CEST)")
Message-ID: <xmqqmvao7wx1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
> index df2accb6555..c3e0a3c3fc9 100755
> --- a/t/t4003-diff-rename-1.sh
> +++ b/t/t4003-diff-rename-1.sh
> @@ -11,7 +11,7 @@ test_description='More rename detection
>  
>  test_expect_success \
>      'prepare reference tree' \
> -    'cat "$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&
> +    'tr -d "\015" <"$TEST_DIRECTORY"/diff-lib/COPYING >COPYING &&

Good ;-).  Thanks.

