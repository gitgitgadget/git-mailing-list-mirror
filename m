Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BA2720375
	for <e@80x24.org>; Tue, 14 Mar 2017 01:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbdCNBad (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 21:30:33 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34490 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbdCNBac (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 21:30:32 -0400
Received: by mail-qt0-f195.google.com with SMTP id x35so8463147qtc.1
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 18:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nZ8LaeHohktVi9f/joHnxC/bQRi7S/j8J+tPYMVI8c8=;
        b=Nz5E2225i8+6wXp76r+RXWo96QTRx7+xkjk0ucUkm88CzBGT8YKHwh36YDIP2KARF2
         2luO9eQkKYq8d0Qn8qtQaBVW78LxZVkOmeiT/xW8ooM/X4ZwQTi3XRqI2CZy8NBU/oN1
         NBq2ZW6jDXUW5SBVEKWLAQVeZilEusGWqu/vGzzPuxLUJQu8kTuecZKEzl/2ysi9nIVX
         P5lqsthSVbwxsHLifIVTOavEDiMBkhcLVv3WFP3zL27Lylygopfsqv/WHmmbdlFl2GmR
         r8CcxNJH6QIZcUvbpSsuZJzGQH0TsaW/k/g/0VLIfXWM1m56lGxBBHXo7hbJtOVtyeEN
         kCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nZ8LaeHohktVi9f/joHnxC/bQRi7S/j8J+tPYMVI8c8=;
        b=UpKvHWKvTTWUgnrXYk0FdxnsHj84VEoMpeNcP2uctOGKaP630s2opIEM68sF147KNr
         Ao+SLI35wVUBzZtwhIUaxMugcOu6kcJ3s7PdAUB7fjsPLRwYJwBAfCqpBGSuwWeEHTwe
         ACm/sfnt10rLTMuqZ/IM7/9UMZ8Yw2INKuDw52hoJLwmGoEwbLN31rAojp2Ud9rhOo6Y
         vX/eSoF/9nTsEbNAeicocsjfa4tCOykJrOq26DNGMuJnSBWJ9Yfprb4g4Xnpi/2J/OsT
         +8Q9HRWwNollqYtRg3bE/M/8N2xS4UURXrWyuAlS99ho+yJOPdCQR4RZw3UKJLFcMBDL
         E+fA==
X-Gm-Message-State: AMke39n9Va1LTdaTZvLSfvUmlaAs0n0OzQ//uJsgA/W2tpcA9zW9IoKoSqYEkbqojHvKZw==
X-Received: by 10.200.41.230 with SMTP id 35mr38439214qtt.239.1489455031259;
        Mon, 13 Mar 2017 18:30:31 -0700 (PDT)
Received: from dhcp-mcfad-10356.eduroam.cornell.edu (nat-128-84-124-0-116.cit.cornell.edu. [128.84.124.116])
        by smtp.gmail.com with ESMTPSA id j1sm13405999qkf.57.2017.03.13.18.30.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 18:30:30 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [GSoC][PATCH/RFC v3 3/3] credential-cache: only use user_socket
 if a socket
From:   Devin Lehmacher <lehmacdj@gmail.com>
In-Reply-To: <20170314004420.GC66601@google.com>
Date:   Mon, 13 Mar 2017 21:30:28 -0400
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D11DDB6C-7B6A-43BF-86A3-6DA48109C07C@gmail.com>
References: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
 <20170314003246.71586-1-lehmacdj@gmail.com>
 <20170314003246.71586-4-lehmacdj@gmail.com>
 <2ACF39EA-B76A-462E-993C-ACBB143A1581@gmail.com>
 <20170314004420.GC66601@google.com>
To:     Brandon Williams <bmwill@google.com>
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Best practice for submitting patches would be to ensure that each patch
> compiles without errors (with the DEVELOPER=1 flag set) and that the
> entire test suite passes with no errors; this is to maintain
> bisect-ability.  Only after you've done this should you send your
> patches to the mailing list.

Thanks for the advice. I will be more careful in the future.

-Devin

