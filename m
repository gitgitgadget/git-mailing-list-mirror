Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D9281F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 20:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752581AbcJKUJt (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 16:09:49 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36171 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751297AbcJKUJs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 16:09:48 -0400
Received: by mail-wm0-f51.google.com with SMTP id o81so6692992wma.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ffc33lcWPBJNu9cdJceb39oQI9flqsZZZ/68Dmifk6Y=;
        b=WH6tvPjxJlD73LrtkRKwYStWfbCGNAxYUgzd8XzK8Wjp0Ab47pwJ9iQ5Gy/qOguSsH
         kMeYpbACTTAYVZ2+SJRI1wPz79ZKb2uelOMOWRGAbFxHr+CSG5QBdxtJzemPFcmpN5W5
         AHpvCHXp1CEDtSPD7EyIRjkFAO+5SISPZkItCN27ZTPDQDs7faBg+CRGaZnzaaAxHo6x
         t6OCkVldtAU1sL3Cjb5UJonI0wXrgV+eDBnl/ql15vBIe7eF3bueKcdrRH9UE6vxNNKR
         Wta+o2ub5GjPmvt1MNGz3yXgoVXHAsdMpPc1AXYCPzTn8OYaQ58BljcEmVUYst5KlKdy
         eZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ffc33lcWPBJNu9cdJceb39oQI9flqsZZZ/68Dmifk6Y=;
        b=J9aBcODaIQzNnoirc7m0mOcwG0pdILCq+lvW7UMGbBJ4WrRCkZoReT5gH9Idkp2hIH
         kiDCdQnMf0HOLXFKCY85iO/+poXdOmn+XgiOXYwYMuRdjxeHl3Zk72k4+TbQcIc9IiYb
         386tQc0UyL6SU68T5GjwzygP6efFd0DAZ5OQfS4q70qOOpRSp4oA8HB8VLPBdH1rqvls
         kVtu5zlfhGUMiomORDz/niiBYJ/CznKXIePm5Px2FHsmC6Frq5zUFw2gZnYhmYsdZ38F
         r3yrOvsHacnf8UOTmK/ZWpSUadeVhpsYBE2V97RqDBl0xTR2aH1Vv2XOE1N+g6QM7oqe
         FfjQ==
X-Gm-Message-State: AA6/9Rk+1g8tB4NmF3mbExGlHChNl6knxrnF5IJk9NTEQlKneWzxzWqM/8H2y1b7dy3fTg==
X-Received: by 10.28.232.21 with SMTP id f21mr418659wmh.131.1476216586967;
        Tue, 11 Oct 2016 13:09:46 -0700 (PDT)
Received: from [10.42.1.91] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id 10sm521291wms.22.2016.10.11.13.09.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Oct 2016 13:09:46 -0700 (PDT)
Message-ID: <1476216585.3876.10.camel@kaarsemaker.net>
Subject: Re: [PATCH] contrib: add credential helper for libsecret
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Tue, 11 Oct 2016 22:09:45 +0200
In-Reply-To: <c87e4dd4-7253-d7c2-010b-6d8c7f587093@gmail.com>
References: <20161009123417.147239-1-grawity@gmail.com>
         <1476198080.3876.8.camel@kaarsemaker.net>
         <xmqqoa2q8ypl.fsf@gitster.mtv.corp.google.com>
         <c87e4dd4-7253-d7c2-010b-6d8c7f587093@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.0-2ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2016-10-11 at 22:48 +0300, Mantas Mikulėnas wrote:
> On 2016-10-11 22:36, Junio C Hamano wrote:
> > Thanks for a review.  I'll wait until one of (1) a squashable patch
> > to address the "we do not want unconditional overwrite" issue, (2) a
> > reroll from Mantas to do the same, or (3) a counter-argument from
> > somebody to explain why unconditional overwrite is a good idea here
> > (but not in the original) appears.
> 
> 
> I overlooked that. I can write a patch, but it shouldn't make any
> difference in practice – if c->username *was* set, then it would also
> get added to the search attribute list, therefore the search couldn't
> possibly return any results with a different username anyway.

Makes sense, so a (3) it is.

D.
