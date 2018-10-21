Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33961F453
	for <e@80x24.org>; Sun, 21 Oct 2018 16:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbeJVAyf (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 20:54:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44612 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbeJVAyf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 20:54:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id q6-v6so5987175wrw.11
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=SYsEqI+tgsLqRjMoqFR2F+qrShvwsV4VpKaQNEEacIo=;
        b=lQDA6g6uekBgAoGCsDuRNoPqdEH1AJI1DFZBQVN4XtOIWv5kbHRbJaCBmuNDXn3eUZ
         0WC7qDZgk8FR1OqiQsPXz3TRkWLumu+TdW9YCwA+KpaTzFgjjxDaSmIX96u9jJE7dfCc
         B9bq+2hZ9dOi2ZlqqJw31+EwV6gPl39Hxz8038rg8+iwlkIU//CIYq+bSzKNADNDmq5g
         hljAOa9KaqmARtK09XfgZXVGKNjb5lqBwucpmE7deJoepFfHKGDLEyGeS+iUJ9QA3nGV
         ROgU8r+Z2SE+lTvbDkzsza+a7CI5z8lwRJE45bxLiDw/x0rEROu+oitslPPLn+1ZDcQ8
         6+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SYsEqI+tgsLqRjMoqFR2F+qrShvwsV4VpKaQNEEacIo=;
        b=E7pHanUzB2HT0a/Q/peaRULfA9De4e0hH3fvf08zj7/NUPSL1ozi3+0O5+ktJZIwHn
         XK1bwgOOA8AZ8mjD0ahgUYwu1ZWf9zcwLv59Q6se0WTHHBS+/lli/S2fBuzZPkGH8hOU
         Igtv2hIVed5UNXQkUZEEtKovEIRkUgFn2LQLH65Pa6OltQDl7545DKLPlnGpSiMSTDDl
         mZ7cDotZeQ+HmGOp1+OagEYdQh1WonNzErz8pBR4sFpdhp5IuzOX/11UmVKtisFy8G/1
         BYEC1gsvNQbB5MO9ramUqYKbDC5CsrD/RT7FmgV0yLbw70Ny/DcdtxJh/V6EuacegZ3D
         bf6w==
X-Gm-Message-State: AGRZ1gId3IbKuZK9i30HlX1vTICM5yK3BuUjd19uc3e43dXS8MkTjl9q
        S9FaYxLdjTLOfiK7a+n16CGgKMRiqIE=
X-Google-Smtp-Source: AJdET5caIVuP7jj3nXJdepKd9nc55Pp1zyxJrEujzKSDl6o0Gtnx8utHrFzt1jW0wVwg3tkEshA3RA==
X-Received: by 2002:adf:9d1f:: with SMTP id k31-v6mr10841497wre.18.1540139981112;
        Sun, 21 Oct 2018 09:39:41 -0700 (PDT)
Received: from [192.168.178.21] (2-230-197-194.ip203.fastwebnet.it. [2.230.197.194])
        by smtp.gmail.com with ESMTPSA id t3-v6sm25923221wru.47.2018.10.21.09.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 09:39:40 -0700 (PDT)
Subject: Re: [PATCH] gitk: Do not mistake unchanged lines with submodule
 changes
To:     git@vger.kernel.org
Cc:     paulus@ozlabs.org
References: <20181021163401.4458-1-dummy@example.com>
From:   Gabriele Mazzotta <gabriele.mzt@gmail.com>
Message-ID: <fcef23d5-e2b3-cb3a-9ccf-75a0cc126d0b@gmail.com>
Date:   Sun, 21 Oct 2018 18:39:39 +0200
MIME-Version: 1.0
In-Reply-To: <20181021163401.4458-1-dummy@example.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/10/18 18:34, Dummy Name wrote:
> From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
> 
> Unchanged lines are prefixed with a white-space, thus unchanged lines
> starting with either " <" or " >" are mistaken for submodule changes.
> Check if a line starts with either "  <" or "  >" only if we listing
> the changes of a submodule.
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>

Hi,

I accidentally pressed Enter before I could set the committer
to the correct value. I can resend the patch if necessary.

Regards,
Gabriele
