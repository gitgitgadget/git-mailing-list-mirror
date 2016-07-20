Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DEBC2018B
	for <e@80x24.org>; Wed, 20 Jul 2016 08:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbcGTI7U (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 04:59:20 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36907 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbcGTI7S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 04:59:18 -0400
Received: by mail-wm0-f43.google.com with SMTP id i5so58127276wmg.0
        for <git@vger.kernel.org>; Wed, 20 Jul 2016 01:59:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=UQj2Bzv062n6q90Gu5wlLvP6D8+rFMCLijX/xMw8Y4I=;
        b=YHnL0yhnJpSEJsEbRNHg3XYrZbmgvKaclwUuTC/RcvBcu8ZT9BVwNo7jNNEwmBP5fQ
         /W9WvU/+T9mIn0MX0P8wx/aJnSE5wqEbzMtZvM94Ie4iV8nqXxn7rcPU6vItJDda/WG3
         8pGG+4W6EulLQvp/KmlY2qJbLQydx7zq6eeXINJmC4enwKP+DShC6tVz2CCFhKFmDfax
         FHu56542Qoa0ki6IDIfZo3tNBuqmeLtkQBaqAA2Zypgm2faMBvMzR8KiZa6iohrylDs8
         XwDlNUTmCASAawRg2I+fXrmHPyYR3dWcoqw3hQkQLO0LcHjk0Ijt2tIjRRKmcruinjgR
         YcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=UQj2Bzv062n6q90Gu5wlLvP6D8+rFMCLijX/xMw8Y4I=;
        b=gkl6YcA2FY+/EJbra0PFCuYIEsLNC2JdgC0UHmoDHgfjwBjVgdghqvptLewtXLVDhN
         r/ONyS1C7Fp9pFLKMjs3gzy9NKYKeSpWZaqq3Rn72mkmHmQheavaJmT95yXrRu2bRzc5
         xt+lmHkfRxgZUytCVctIs80hTnDBBh9gYp8HaDrD4lU4am61kWjlML5K1f85UwOV3EDO
         jPcygdI0pBcQZ/4LodHNvr7WVeySjwHKD4HxNJxOQx/ZGxL9qDlwKyj/3huPx4K6BzQf
         k+iieM5pOZHYHI2KZeUrXoboq0NdK6BAehyLcBFeFm7Vj3n307CegJxWq20u7ppyKKcR
         hnOQ==
X-Gm-Message-State: ALyK8tJcMrbeDh5KJqp2cba6rV9nCsD+PbQT9HlPcjwMOvTY/wh1+i5AndAoxGL0FAd3mA==
X-Received: by 10.194.88.130 with SMTP id bg2mr138660wjb.60.1469005157075;
        Wed, 20 Jul 2016 01:59:17 -0700 (PDT)
Received: from [192.168.1.26] (adan30.neoplus.adsl.tpnet.pl. [83.11.249.30])
        by smtp.googlemail.com with ESMTPSA id v203sm4034220wmv.2.2016.07.20.01.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jul 2016 01:59:15 -0700 (PDT)
Subject: Re: Looking for help to understand external filter driver code
To:	Junio C Hamano <gitster@pobox.com>,
	Lars Schneider <larsxschneider@gmail.com>
References: <67D9AC88-550E-4549-9AFD-2401B70B363B@gmail.com>
 <xmqqbn1th5qn.fsf@gitster.mtv.corp.google.com>
 <xmqqlh0xfoho.fsf@gitster.mtv.corp.google.com>
 <7B44C694-7CB2-411D-9CC6-7334CCBAD20B@gmail.com>
 <xmqqr3ape2ju.fsf@gitster.mtv.corp.google.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j6t@kdbg.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <578F3D5E.2070201@gmail.com>
Date:	Wed, 20 Jul 2016 10:59:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqr3ape2ju.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-07-19 o 23:33, Junio C Hamano pisze:
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> > Git writes --> 4 byte filename length
>> > Git writes --> filename string
>
> Why limit to 32GB?  Perhaps NUL termination is more appropriate
> here?

Errr, I think limiting _filename_ to 32GB is a reasonable
assumption, for forever...
 
>> > Git writes --> 4 byte content length
>> > Git writes --> content string

...while limiting file _content_ to 32GB might not be
future-proof enough.

;-)
-- 
Jakub Narêbski
