Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F46921841
	for <e@80x24.org>; Tue,  1 May 2018 10:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbeEAKvj (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 06:51:39 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:40758 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751828AbeEAKvi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 06:51:38 -0400
Received: by mail-lf0-f42.google.com with SMTP id j16-v6so15808948lfb.7
        for <git@vger.kernel.org>; Tue, 01 May 2018 03:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IxNR83AD9i9PaHVKGXVSvhpQ6Wq55FusaPX0vMIH2fM=;
        b=Mwv/5LQTDT8YKwDtfOlBTrTglL/bfNxbnmzcRNA4SEUM3dnvCgVKqzuHdUDVhEPsx1
         ycXopWm0nwADgcEa6c7e1Cs7HqblIegSik2Uc7qOFxGCwDTUlPSFGaiPBMnUD1G0MYxe
         cdNh2i/hDFlfXe8zPL0coKUF3lBdJUTUnRiE6ZTYDeL9U0w3xKJMqWQ2c7HLELoRS8WQ
         N5QnfDwdNyn8YVZOPPfOF73FPPp500m6RIgfMW2XSAJThZbVvK7KHJ4GMZja5KGNJzHW
         2cxylSykzc3UuqFoewBRHdRHzjxR+VzrnEafL1ffvNToOSgsGzLpuk6vwsAkq9NpjhEQ
         2+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IxNR83AD9i9PaHVKGXVSvhpQ6Wq55FusaPX0vMIH2fM=;
        b=glfOy/7PNJmp62f+mOUGu4qmgX/FC62gMA75IKIx2INa7nzGu4OJfmYMeNvvnlYjQ0
         OOziVaWogLAFvcjDYi7mIIBViXpQpevQzGIk4Dy2JCR1KAKgMfU8NqT5l9BbUh1xFzVi
         4rwwZP1ZXiTKrtdt8HoWa844ymb6SuzvhPjQ06wG1NVJOscuH56QSw9dIMgss6Ynesce
         DEDFhuy91HbXkv2J5dImV7ohay1xW2t7SZnGSCs7PCJUnSfLR0cUDL/quVhwnbY0SDvM
         8ZuVvhteUq+A+58NX1LXU/0bxPis+zAc1KlSALA8HhSTq5nvQmSfoEbhu4oExVkqcRN6
         GxKQ==
X-Gm-Message-State: ALQs6tBMOxUo7Uru8i0maD+AJBQ0Em/c6zinOCwrx+9gZ/lydbFQntUz
        r1YzFDSnG6NGic3P8C9VE+MfNA==
X-Google-Smtp-Source: AB8JxZpfrAbSOr69ce/0M8W+8WWFddKpqWkclFc/DZAo4S1+MmbVaInVde+oSm8v6bEkDzkorWNNgA==
X-Received: by 2002:a19:fc04:: with SMTP id a4-v6mr9722400lfi.136.1525171897173;
        Tue, 01 May 2018 03:51:37 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d3-v6sm1469521lja.36.2018.05.01.03.51.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 03:51:36 -0700 (PDT)
Date:   Tue, 1 May 2018 12:51:34 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 00/41] object_id part 13
Message-ID: <20180501105134.GH15820@duynguyen.home>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <CACsJy8CX7cgd4EGSHVUtm35Aq92Us8WBA-r746vEaZiFP5Q5Lg@mail.gmail.com>
 <20180430235943.GC13217@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430235943.GC13217@genre.crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 11:59:43PM +0000, brian m. carlson wrote:
> > I guess I'll be helping review this series instead :D

Overall I think this looks good.

> 
> Yeah, I have code to fix that, but it's ugly.
> 
> You can see the work on part2 and part3 of the test fixes, plus the
> fixes for all of that stuff on my object-id-part14 branch.

Since I gave it some thought, another way of dealing with this may be
hiding this behind git_hash_algo abstraction, so we have one function
for sha1, one for newhash... and they are probably just macros that
take different struct definition.

--
Duy

