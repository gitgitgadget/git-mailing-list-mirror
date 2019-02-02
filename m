Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BE2A1F453
	for <e@80x24.org>; Sat,  2 Feb 2019 18:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfBBSBd (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 13:01:33 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:44974 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfBBSBc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 13:01:32 -0500
Received: by mail-pl1-f169.google.com with SMTP id p4so1592068plq.11
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 10:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kv5kQjyZGiSKYr7nCkw1Aml/pwh0Qp6wieo1eHTXngo=;
        b=XMbT/4j2i2jAQplRgSpndoMYFkSKR9vMs4H/r70VHSMtka4aI+PQcI/lfVAeczIFER
         JvUBMvDaUQ8tqvdbkhG2K6Z/F2ZFOgI38K1iuqin7I84uDNaLVJJ9f38h3/sW5cs5YXn
         KozwmWTCKDSIr8VnjwXTIGuCWZXDYtwjZDzCUm61GPfH2ENWl+7fp0zbKf/7Q/y3BK07
         YXywUFCkid52CrV08iFyy+LR7elVt0hTl9oDhIbLNEwZf96kxcirX/EpoZnRuXsv6CYa
         uAfx8Jsp1zzxVMiQiEbakexdIuI6/0fXutri97dbPjb6cCQ3Wx/+l6cfYMF+VFRejQTF
         isGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kv5kQjyZGiSKYr7nCkw1Aml/pwh0Qp6wieo1eHTXngo=;
        b=q8PTODnYk1R56mdJ+JIuOKyZ5VyZ8WE3WZpsqMYeB0YybX1gPKLr8LS3M3LDUkrw5V
         ZfK36ZxS12/EfjLok9iXQzIPi3svT6A5EqCq+dyuI8bgi24MblJTVlX+QgY34KSVTKxY
         pVKD3kfFLouX9EYdYQKhc0GgDcf6tW/YeQGtizhSrIrqqYqSut3Uuj139qzROxgEnUYV
         oI8rlpQQGrYsJMmduaMyqm1BXJJ8p4/hI39U23/HFcRmQ6MPpklJ5iFT2WjhGRjF3DIh
         tbthZzlPrLfXyZmPNu5SDCTiIDVwKRi8iw3ykWAhLXcXFXteATrCnO0V+m8jRFDtVTZq
         o5gQ==
X-Gm-Message-State: AHQUAuaK9TYEnuw7LFhJf1CAE13sYpZpwJkPI0xsi6caSh/XyqK6TGLW
        stMe8fqhjUfolWNx3OGIy9WoRoYf
X-Google-Smtp-Source: AHgI3IbEHYlGtMaOFYUyAl2AH9Hr7dQseleH6hRCvFquujE1a5Qdr/M9z/EuQPe4pf1pQNav0qOUMw==
X-Received: by 2002:a17:902:bf43:: with SMTP id u3mr681300pls.57.1549130491122;
        Sat, 02 Feb 2019 10:01:31 -0800 (PST)
Received: from [192.168.43.71] ([27.62.90.100])
        by smtp.gmail.com with ESMTPSA id l22sm16734304pfj.179.2019.02.02.10.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 10:01:30 -0800 (PST)
From:   "Kaartic.Sivaraam" <kaartic.sivaraam@gmail.com>
Subject: Re: protocol v2: More data transmitted between client and server
 since v2.20.0
To:     Jeff King <peff@peff.net>
Cc:     Git Users <git@vger.kernel.org>
References: <CA+ARAtpAN_DJ-zgiwPEBqV1EotgsmggRRQWB59u8O_OPR_kFrw@mail.gmail.com>
 <20190128212305.GA23587@sigill.intra.peff.net>
Message-ID: <0da174c7-40cd-c245-abbf-6aa7a657f5a3@gmail.com>
Date:   Sat, 2 Feb 2019 23:31:26 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190128212305.GA23587@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

Thanks for sharing the details about that spooky behaviour! Also, thanks 
for suggesting an alternative way to show the advantage of using 
protocol v2. I'll refer your post in that blog's comment to let them know.


Thanks,
Sivaraam
