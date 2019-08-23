Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7E551F4B7
	for <e@80x24.org>; Fri, 23 Aug 2019 08:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbfHWI0U (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 04:26:20 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36414 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbfHWI0U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 04:26:20 -0400
Received: by mail-wm1-f52.google.com with SMTP id g67so8240352wme.1
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=JKp0BDI3ZIKQ5aHySYsrsBvvnvGveWfuRQk5+Zx2+EQ=;
        b=mLWC0XE+CytJYa3niDtUSmtC4YJxL3smXhpnZaTtuVT0Tmn499/NrOR7YVgL1TIgBF
         PfJvNIF9m7BGVkzm+O4HKhb6fyTL4wKexdh6GZ/Mn5rQccev5V8c2ed3xWFtyqLCAK+b
         gJ3jhJt4Pe94J7wJxd2HtL1RgVD71BHHdnpfoSPEQ6b43y2qTB0BfZDZo75nm3tMWx6l
         9eTOx8/znVIReI3ROqYmK++ql69e1qx7xEjmqvQRZS3fMmmTaUZ0MHvkiLNCBSbaqCmu
         sIRgHNrvIGqcXjW9/TzmTSA7r9cXiQEyLCztu3hlljo3ns0oNYlGLk1maG2qj5zSAX9J
         X8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JKp0BDI3ZIKQ5aHySYsrsBvvnvGveWfuRQk5+Zx2+EQ=;
        b=N/aNnbexwE7BxAvmgMIhiTDJ+Xt6KiSdmboJqwTSKOX+uuContq3+AJdfo1pV+iO8g
         4aLpHrgJ7PHjtcmrucgzh/PLBnfShYSVVPftJImTayr2TaWK4Or+m3SNBG9vVFmZcaTI
         ryvYVnjbSVGpdhDcftaOZhB9jOSAVM6bxVgsrJhPNXuQEpnI3p4/RF7hrqF7Eb6rPpTM
         ZNNGM080il/rQkW+wCryE2d5ymicieL9olX50S5vl7o7XIU7VR58wqhg6SFnjajm5glT
         8GGPIJybf4L93YkuqRHCMPXMUQ0sfQoChR/y3+KFNTYUwkyXFc4oMd/YlCDqij0MQerJ
         SswA==
X-Gm-Message-State: APjAAAV474DFnKZEoCAz/lOOKAQBzYi0mmLFpd4HZD8/KAET+ZgAMSvG
        TKB4WpQjR2m1zpXRA+NjbG5+QcTIC6M=
X-Google-Smtp-Source: APXvYqzVzG3fVR/nZsvacA3HLVD6hvo7hHxvqJxafsX5zaNgu27wvTHluMpcTMBhwQ8kfhpCpGyGYQ==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr3636027wmb.41.1566548778601;
        Fri, 23 Aug 2019 01:26:18 -0700 (PDT)
Received: from szeder.dev (x4db558a2.dyn.telefonica.de. [77.181.88.162])
        by smtp.gmail.com with ESMTPSA id p10sm2415481wma.8.2019.08.23.01.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 01:26:17 -0700 (PDT)
Date:   Fri, 23 Aug 2019 10:26:12 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Giuseppe =?utf-8?B?Q3JpbsOy?= <giuscri@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190823082612.GA3775@szeder.dev>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
 <20190822170817.GB35435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822170817.GB35435@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 22, 2019 at 10:08:17AM -0700, Emily Shaffer wrote:
> On Thu, Aug 22, 2019 at 09:58:48AM -0700, Bryan Turner wrote:
> > If your goal is an accented "e", wouldn't it be better to set your
> > name using é, rather than a trailing apostrophe? "git commit" would
> > likely preserve that without issue.
> 
> Hmm, I don't think it's a good idea to get into the business of telling
> contributors how to write their names.

Well, maybe the contributor didn't know that Git can cope with
accented characters in user names.

