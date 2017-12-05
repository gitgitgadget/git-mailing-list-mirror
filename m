Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9134920A40
	for <e@80x24.org>; Tue,  5 Dec 2017 22:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbdLEWb2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 17:31:28 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:36906 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752316AbdLEWbS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 17:31:18 -0500
Received: by mail-it0-f52.google.com with SMTP id d137so4860235itc.2
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 14:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+lnnH1RXvnR0O8DlJgfl3SjS91nVDvO0kYAeGL7SEHE=;
        b=Sx3MbLol8liNcw+RM7IF3yng+XCFATc6V2wvunQhQgBtG9zphmr1e6T7urDOiowZzO
         TnAh41aLLncSEKohf4jvBkiMrkab2D8HV9b1tIUNSZUBOoSCsVYY0ySWpEsDNRfgLMKc
         h74jC+xCelp5t5YUoSrJLLP/YND6CeEbNktWTmgGde2YD/3531l6w425bOM0TnwcVuJU
         VJfeClvioG3xMOcUWxZkzGTyLf0OE/y6CNEjCDZZ5LRYc2UUVbKchZqSP9cv/z7YNoH9
         wlk4IpRDVK6ZnaL+xed3ehEKOxM/UtxHv+MdxTElbBou0iPRGCE8MztoWy/sgMiuUCrk
         D9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+lnnH1RXvnR0O8DlJgfl3SjS91nVDvO0kYAeGL7SEHE=;
        b=HzIYp2/ULScIaRjtDcTyd0QxSnS+ZYoBzCXQoXJZrbXv3f2TX0VkXc1+mqVefV0lbd
         VYW2VRW/soe3S9vIjB1pdvIsPDkyzIN+f27Y8CpCKc8clfrzvLWk0na9TpUbzJ3Gootj
         N1xwH+NA0wVUA2yKwfn5uICTC9N5OKm+8G7mOgw7ganLxjSjb2iCBdaMtndKiZCCX+Kc
         /j6jNyuzsQrJRLxQpH9NSELfzTdvOuRfa82BFD4FMds30EqynhHGNL9PQp8P1i0SIfJM
         r5ncue8KtUp5HuGMiBogpdl0GcxV/sTEDHmFVoJpRjVEwi/8/TpDi4S/KCTZtQoPq9Ob
         K+hw==
X-Gm-Message-State: AKGB3mIRVZ1SkNrzKeQoaYFM+BTwCs62PA3XhZHnrwbYeysfSlpFRnKH
        lvMeWNyeBVFhBoSr5z6CJ3qxr3dP9qg=
X-Google-Smtp-Source: AGs4zMYd3FuinF4n5dZBoAUvqVAHS6typBgeGBkm+PdBvKJSmN7twL8MCxop0JXiHayzuckXpOw1Ag==
X-Received: by 10.36.0.73 with SMTP id 70mr12482518ita.8.1512513077992;
        Tue, 05 Dec 2017 14:31:17 -0800 (PST)
Received: from google.com ([2620:0:100e:422:cc82:408c:b424:d98c])
        by smtp.gmail.com with ESMTPSA id n7sm476610ioi.57.2017.12.05.14.31.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 05 Dec 2017 14:31:17 -0800 (PST)
Date:   Tue, 5 Dec 2017 14:31:15 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Ben Boeckel <ben.boeckel@kitware.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff-tree: read the index so attribute checks work in
 bare repositories
Message-ID: <20171205223115.GA36335@google.com>
References: <20171205194801.GA31721@megas.kitware.com>
 <20171205221337.140548-1-bmwill@google.com>
 <20171205222954.GA9217@megas.kitware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205222954.GA9217@megas.kitware.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Ben Boeckel wrote:
> On Tue, Dec 05, 2017 at 14:13:37 -0800, Brandon Williams wrote:
> > This patch should fix the regression.  Let me know if it doesn't solve the
> > issue and I'll investigate some more.
> 
> Our test suite passes again. Thanks!

Of course! Glad I could help :)

> 
>     Acked-by: Ben Boeckel <ben.boeckel@kitware.com>
> 
> --Ben

-- 
Brandon Williams
