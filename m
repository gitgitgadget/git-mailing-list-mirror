Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6DC5202AE
	for <e@80x24.org>; Thu,  6 Jul 2017 03:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbdGFD2L (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 23:28:11 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35639 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752307AbdGFD2K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 23:28:10 -0400
Received: by mail-pg0-f66.google.com with SMTP id d193so1038439pgc.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 20:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=6kqN8dECjE+yaNUgZ856InBlW0t6TKgzfRz2nSWrQUA=;
        b=DoMKGt3TjM7dsseAvGzA90Js3W6H/njie+pGFmx7Ixfbg1UkyQwxeO9Taw5h28oKth
         PTvn/lTmzyXyzkEMqVIPf12nCRmffnVcJxgzoAQuxiK0dY9omVUDmBplfn0j+zdnm1B7
         uWe+t+7WuGnWvBIu1WHfZoGIPp9fOlsPA/UKpnRj6NRs9E82D/siqO38wXNhP0cO3JmF
         ZhwnLr0crUBK/zoEGQ661zh6hgfwumgce1nquWiC2pJrFOj4EEwjI16WNRF6bBAtJvtQ
         3ENsYOZM2UK7zN3huIfPuJBSksrUPL4MUuRJelIw79D3Z3TwXqzAuVhfAaBgzvh4bQ5v
         E8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=6kqN8dECjE+yaNUgZ856InBlW0t6TKgzfRz2nSWrQUA=;
        b=JuriRO3yY90X5oWmbQ4aVsLvJ0e/f9jaZ/47wCoM7kXK9Bon5gsUDOc7GTlrFlnWNR
         dyE/Wq52spz/b0w88fB2M5/fzmbfetkzDZWMp/VL4FBCgdN4SwEN9qXf85Jcahf5gGLa
         y7IBx/rE2EV85fkGnRscedp24NSGHwnhX5jiBDuLVH3nifKCv2OIc0vg/ZLJZhhCZCLt
         feXL/k9s2bHAS3FUjEiRxpb4iupbczwXBKLC244/A6OExGA5BaiC+J7CQtC/cyVvDuAY
         8PJEI6NjJotll9wdsuCsyjyWyCzLk5C8BkWxLeF4wwjB1O9lt/dV8vuh3sP7XqNOcmhC
         VfYQ==
X-Gm-Message-State: AIVw11350+5Ay2PQU+QZa3Lc1fG6Iawfgq+IjaXcWxc1/au6QJrQHTnB
        rsq0g95JxvklHQ==
X-Received: by 10.84.148.134 with SMTP id k6mr25630033pla.150.1499311689455;
        Wed, 05 Jul 2017 20:28:09 -0700 (PDT)
Received: from unique-pc ([117.246.45.117])
        by smtp.googlemail.com with ESMTPSA id d89sm1031463pfl.7.2017.07.05.20.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jul 2017 20:28:09 -0700 (PDT)
Message-ID: <1499311692.1776.3.camel@gmail.com>
Subject: Re: Requesting suggestions for a good sample "prepare-commit-msg"
 hook
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Thu, 06 Jul 2017 08:58:12 +0530
In-Reply-To: <xmqqzicihesv.fsf@gitster.mtv.corp.google.com>
References: <1499273152.16389.2.camel@gmail.com>
         <xmqqwp7miztv.fsf@gitster.mtv.corp.google.com>
         <1499275601.16389.6.camel@gmail.com> <1499278787.1791.2.camel@gmail.com>
         <xmqqzicihesv.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2017-07-05 at 12:19 -0700, Junio C Hamano wrote:
> I honestly do not see your point.  Yes, I said that the change
> indicates that there is no useful example found (so far).  That does
> not necessarily mean that we must find a useful example so that we
> can keep this sample script, which now became useless, alive.  
> 
> I am questioning the assumption that it helps users to have a sample
> for prepare-commit-msg shipped with our source, and I suspect that
> it may no longer be true.  If the sole purpose of finding a useful
> example is to keep the sample script alive, when the sample script
> is no longer a useful thing to ship, then it does sound like "a
> solution looking for a problem", no?
> 
Ah, now I see your point. When you said "it's no longer useful", I
thought you were mentioning only the part of the script that commented
the sign-off. Now I get that your point of not shipping the sample
script itself. Now that clears the confusion and sorry for the
confusion I may have caused.

-- 
Kaartic
