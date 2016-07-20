Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64C8520195
	for <e@80x24.org>; Wed, 20 Jul 2016 00:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbcGTAHq (ORCPT <rfc822;e@80x24.org>);
	Tue, 19 Jul 2016 20:07:46 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33221 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbcGTAHp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2016 20:07:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so4589963wme.0
        for <git@vger.kernel.org>; Tue, 19 Jul 2016 17:07:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=1+L0krUPcVDV/JjLw3Rz+jyy2mQcCwW+P0dgk5s15v8=;
        b=awbwHwnUDX36nthsKiCo69/WKjq8Y3RbOHZJyOS7wkSLWMh7r9lZwLJe5UAF3c7Jw1
         HPnX7pEBt6yRdABZW9ZfxaXRAv48CRFlCmdWZmM+OV7mLOFUqPIurWW5o/4P43uIozuC
         gxOX9nDLkKcLJuJXzrvSJwnw78rLAWuYXYzy7DiPbmNh4Zfy4E74/4Tk8KDYwnB2lI0r
         PIOA117oEOlJvPL0cSq3Mzasx0NT03Dj0HcJL/UGDLRWQlNfA1kV7f3wFsBbltndk47D
         f2AwJ4MAjTOoJ4gxTNAYvfGyTx3tTDIQHYs96iEhKwqT+1OOJm5kKNRHqekNtSIqq2Tj
         5K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=1+L0krUPcVDV/JjLw3Rz+jyy2mQcCwW+P0dgk5s15v8=;
        b=YuHntudxpZEa7Yk7ZDfSSuOBaJ4P1Vg3HQkjR3Gz8KXiN72g3Bjx8TyYhY0CCBm1SU
         Y8LTpYdF3RkCbZUt80Wi9LnTPrMvQ4Q/2z4ecF2NPVQx+By/aNLk6vbnxSsuWJHH8qGb
         SffACE+EacnXIwwxtVKd3Tcw7eQLD7S7+tZZ84N4NYeL2Od/DI0qt0H4r9yAyWuQrvj/
         7+Wt/Cn5Z12SBLa0f7hQJboCwhn7m+6Mo9aMXUUa+ujQyqhJos4+M5zcDQ6mq7V3nSMi
         FqZZIYWn0nxuPm9n1YOb6Nh864NCzbB2VX69L1tsOE5n8FYU+j8G116zi9t4zAPuVF9p
         ke2Q==
X-Gm-Message-State: ALyK8tK15BMr80D56yo0kWxbk3TMaMw4monoV2x+WzTRa2c4IrnMEfqrzH8s+DA5P5lcaA==
X-Received: by 10.28.31.133 with SMTP id f127mr7732634wmf.90.1468973263923;
        Tue, 19 Jul 2016 17:07:43 -0700 (PDT)
Received: from [192.168.1.26] (adan30.neoplus.adsl.tpnet.pl. [83.11.249.30])
        by smtp.googlemail.com with ESMTPSA id r16sm27133185wme.16.2016.07.19.17.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2016 17:07:43 -0700 (PDT)
Subject: Re: topological index field for commit objects
To:	Jeff King <peff@peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net> <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net>
Cc:	Git Mailing List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <578EC0CA.8060501@gmail.com>
Date:	Wed, 20 Jul 2016 02:07:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <20160629220049.GA4416@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-06-30 o 00:00, Jeff King pisze:
> On Wed, Jun 29, 2016 at 11:49:35PM +0200, Jakub Narębski wrote:

>> Do Git use EWAH / EWOK bitmaps for reachability analysis, or is it still
>> limited to object counting?
>
> At GitHub we are using them for --contains analysis, along with mass
> ahead/behind (e.g., as in https://github.com/gitster/git/branches). My
> plan is to send patches upstream, but they need some cleanup first.

Ping. have you got time to clean up those patches?

-- 
Jakub Narębski

