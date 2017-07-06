Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65CD8202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 12:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752707AbdGFMUU (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 08:20:20 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:32881 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752686AbdGFMUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 08:20:16 -0400
Received: by mail-it0-f68.google.com with SMTP id 188so66587itx.0
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :disposition-notification-to:mime-version:content-transfer-encoding;
        bh=6OxhvF0SJLbWgeqO0/rIkfgCPErp+Qm6anxZEmMn/xc=;
        b=b0zuBgNEhKxfXlBsiS/ifZg6NNa8fI5kFIdDNpVe4yRJPgqsEEFbE1hIxrhmkkCpxw
         kHrVWLkwMDK2caLhpBGusvht4kYzudEgWoBi3yNv193zqzHJcAFpU0TiPReeolx4E5vg
         GZBnuB0CCF7jyXLRJI2LSeHagsofqSz+3sD7U0lp+ytVMR9dGFWcd4u6Y/cd70ZmR9w7
         TU+wERjVtwGKvy79z3at3Dv5UbwSFb71YLe7Wn3vm/SL66i+AqW513ZDuUlDigIbhKfj
         kcAvt3FKHKkFmBqcW6GX+gmA+9aS2ka00UlDurpOsE1FLblVhnA0J4KkFq8wcXF25qFS
         Iwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:disposition-notification-to:mime-version
         :content-transfer-encoding;
        bh=6OxhvF0SJLbWgeqO0/rIkfgCPErp+Qm6anxZEmMn/xc=;
        b=MDEJy9yfgNJI4e7eN5VHn9rIEI31Wr+p0MxEBLCQ3xFVf9ooBkb8p43NC1IXrlgTLy
         HFhnXaIj2ISsCevaPrApM25BqCg9Sv8kuXc/6sZfrnyX1cSeK+/GzTT76fYZs1Uqi/nE
         3id2jPs2r6sPy9HeGzONOdDbpmOleTdyJVlIaI+LI+1gTw42cOfOPALNUwl2npnwj10S
         R+6/uxZaJQK2eAnQueNtZQy21eCBAeS3it6F3FB+tzOgl0h+pFJgGDOuKdZc1sHsdwIt
         5ZiyB1Z3p2e7+91yncQqL+6xiavY4vhiHpz/8Wo9hLFMQRz67nj/+QF6USGqc7P0X8nD
         B1jw==
X-Gm-Message-State: AIVw111T9W3OWjT7tf7UXJTvUhhDQQypqHTOHOl4GnVACQiO53FMdhoA
        /u4E+a8Hgm+wHA==
X-Received: by 10.107.26.79 with SMTP id a76mr16726811ioa.224.1499343605536;
        Thu, 06 Jul 2017 05:20:05 -0700 (PDT)
Received: from unique-pc ([182.73.109.146])
        by smtp.googlemail.com with ESMTPSA id 131sm86683itk.10.2017.07.06.05.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 05:20:05 -0700 (PDT)
Message-ID: <1499343609.2239.3.camel@gmail.com>
Subject: Re: [PATCH] merge-message: change meaning of "empty merge message"
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     gitster@pobox.com, git@vger.kernel.org
Date:   Thu, 06 Jul 2017 17:50:09 +0530
In-Reply-To: <20170706044640.GA11020@alpha.vpn.ikke.info>
References: <xmqq60f9mo6b.fsf@gitster.mtv.corp.google.com>
         <20170706033149.6275-1-kaarticsivaraam91196@gmail.com>
         <20170706044640.GA11020@alpha.vpn.ikke.info>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-07-06 at 06:46 +0200, Kevin Daudt wrote:
> 
> The function is called "rest_is_empty".
> 
Thanks for correcting that!

> But isn't it better that commit and merge use the same code, instead
> of
> duplicating it again? Otherwise one may be updated, and the other
> forgotten, getting differences in behaviur, which is what you want to
> solve.
> 
Yes, I did think of that. It *seems* that neither "message_is_empty" or
the "rest_is_empty" are exposed to other files. Have to work on that.

-- 
Kaartic
