Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBD4F2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 22:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdCRWyp (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 18:54:45 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35644 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751181AbdCRWyo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 18:54:44 -0400
Received: by mail-wr0-f195.google.com with SMTP id u108so13647464wrb.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 15:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NaRfLd3VdsyzhPsGguN7Q1LT5lJZrzGWJ/JF8T8aK/E=;
        b=til3oTBupDjT+lZWJU2ECDzNdjaeH2xwurnh1sj2TKOHGjb+yzMwBXxomRfHY8p83Q
         IhpGE9bKi8Na1v8T1GgQmxPoKeipE8QI9AQzMTG0GaSRV1w3ACyhNrcAHYirLUuxbKDQ
         zILZuk6lYGILqSt7JlGrwgwacJ7w18fg5DxedjAUTCR843Js47s6RQ/+gHVWmRRUj/Fy
         vJFV22xGZh4KnHgHcDLbRYhpryaPdQCQf6Umk2P6/HXuEU7x98lJIX+u56pCBp7fThcz
         yxC7u/wXwCgPtMpHlX07eHb/I9bhkXCr34U1xUth3PGC0M3f7pppYEnXxy05pXAqnIYC
         lpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NaRfLd3VdsyzhPsGguN7Q1LT5lJZrzGWJ/JF8T8aK/E=;
        b=OC+kuPJy4QDW3+OTvRuvtr5znBZgHrbzudtEVFFh3RZpT3Wx5B4z9/xVmKWLkNuZB0
         EmIKjIQwyi2iIan5z7VRDTk2hFhnvQasjEuV3DSxnnVUV4bHGqXoZN26hIMwiWDVkmvT
         5KzUJoV2tMPgZva0nUi6PkfyokFuVjz9OUN6frw8sR9009e5eVGX3Ell2EKjkn6Y3SeU
         NaLpoWmDtnJtfu9JJ7wwnkb3Yx3lUfPtiFvKmRJ5hNg23pjvawlWrfdtc1KViiDVVndi
         IpCoVI4BgkDgGj4skUZtOgq0uj/RzE+m7y+iog0QDDG/DOScRv9byCwME+bp/zaTHOZ0
         azzw==
X-Gm-Message-State: AFeK/H3B+kCeN9wp615PSePlcPuG/XDlHUzah8OnzupM7S8geH/FTc30hoKlAD1SslF2CQ==
X-Received: by 10.223.174.164 with SMTP id y33mr18742718wrc.166.1489877674599;
        Sat, 18 Mar 2017 15:54:34 -0700 (PDT)
Received: from [192.168.1.80] ([145.129.9.233])
        by smtp.gmail.com with ESMTPSA id m188sm7729436wma.27.2017.03.18.15.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Mar 2017 15:54:33 -0700 (PDT)
Message-ID: <1489877673.24742.1.camel@kaarsemaker.net>
Subject: Re: How do I make 'git diff --no-index' follow symlinks?
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Date:   Sat, 18 Mar 2017 23:54:33 +0100
In-Reply-To: <xmqqk27m1ixf.fsf@gitster.mtv.corp.google.com>
References: <CACBZZX6Bknimu26in8YG7TbsL3hEpmXTYwQAZQ5xK-DFoSatEg@mail.gmail.com>
         <xmqqk27m1ixf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1ubuntu1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2017-03-18 at 12:30 -0700, Junio C Hamano wrote:
> Sounds like
> 
>     https://public-inbox.org/git/20161111201958.2175-1-dennis@kaarsemaker.net/
> 
> to me.  A key message in the thread may be:
> 
>     https://public-inbox.org/git/alpine.DEB.2.20.1611121106110.3746@virtualbox/

Sorry for the delay in sending v3. I've had a serious case of
Lennonitis (Life is what happens to you while you're busy making other
plans).

D.
