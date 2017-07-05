Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9398E202B1
	for <e@80x24.org>; Wed,  5 Jul 2017 16:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751700AbdGEQnl (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 12:43:41 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36859 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdGEQnk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 12:43:40 -0400
Received: by mail-wm0-f41.google.com with SMTP id 62so228441468wmw.1
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mazzo-li.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T6PzwmxwhTC5+6v+fU6yDZZsWNHqO6lmYnbwUSC6wTQ=;
        b=eNYsFcdhGpPOxXn0i8Ld3V2k/ivNvVyCUS8Qhq1rj2G9VID6KxDeyN9Cly6H0MwqsR
         uztyNLc3S6BbQcRBsyEGSDpT5/yFoARj8tn6qf3aLxi/G1EgTKBoLliCyZ2+WPuks8pD
         X+uyVfgcHkxzH7TH5QgREJJBdO7fxKFmheUPHR6cz/9edtZiw82tjm73wlgRcawO0fkN
         +Xa5JpjhmaYttc2R0iFzspygVq0yVVLZ7+HIW8Qp0Bioc9w9OWw2lnP/iGtvPmuusCR2
         UtDePeqj4RK0YXCH91k16JNKLDT+4WNnXF01YCG6BNyVDK/de+y9XQPaO1CV6arZDAnU
         2i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T6PzwmxwhTC5+6v+fU6yDZZsWNHqO6lmYnbwUSC6wTQ=;
        b=kXeUVjc3TlZURMeJyNzwtqkcS1dPr0fdg0SSm+u6E9drRZRkQvrMbYWuxhpk/HvVWU
         Wx/M0qK/8niii5dcDf4gMz7a3rghsMmrWvHFRjR7v3TnPGBwx0J2OZt2ShJDPSAn+bT6
         KWc6Hoa2BAfSnzq1oIZomHf+gLFk5pOCSL6YfhbeSqMpMQGM3p5xiASFzlw2mZinl+Wo
         SqlTTKb3uYhj7R/+lD/POUPQEnoBcMITkxFLgyrrtjJRbFlP9LHmn2HtN7AkVuPRw78r
         3ZO3Zb3zEhgeg24PiWMDRnhEeMgKK6EyIhSYaCxLWoZ+dvOeS7JISJRgIByljFCd5FrW
         POpg==
X-Gm-Message-State: AKS2vOz+Gb1d8VsIFC9KzcxZCM7qbjIAd4QZ6rzfG/vk+J8pvfFSSRSK
        A7LhnI3kGS85NHMkVA+r/w==
X-Received: by 10.28.111.215 with SMTP id c84mr33938652wmi.72.1499273019135;
        Wed, 05 Jul 2017 09:43:39 -0700 (PDT)
Received: from [192.168.1.252] ([2.227.248.226])
        by smtp.gmail.com with ESMTPSA id e31sm34238526wre.54.2017.07.05.09.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 09:43:38 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
From:   Francesco Mazzoli <f@mazzo.li>
In-Reply-To: <xmqqa84ikj61.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 5 Jul 2017 18:43:36 +0200
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <EA42AB04-D538-4B4A-BC19-CAE9A80EEA76@mazzo.li>
References: <1499116727-757-1-git-send-email-f@mazzo.li>
 <xmqqvan8jdje.fsf@gitster.mtv.corp.google.com>
 <CAPB=P5xsssm=RiAkEuAtpxe52+-sNAPVP2qnQGctLjNZFYznkg@mail.gmail.com>
 <CAPc5daXn=PJ47JkZQNnReNNSUhQK3eJm0Namd-A+e9TM4Dnr2A@mail.gmail.com>
 <CAPB=P5z7MA+TuVaFLUQQdOoJXUb74YxEPS6k4O+NorneVpLitg@mail.gmail.com>
 <xmqqa84ikj61.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 5 Jul 2017, at 17:17, Junio C Hamano <gitster@pobox.com> wrote:
> 
> The take-away lesson that the earlier thread gave me was that the
> order in which the three options are ranked by their desirebility
> in the UI (and the order we would like to encourage users to use)
> is, from the most to the least preferrable:
> 
> - "--force-with-lease=<ref>:<expect>" that is safer than "--force";
> 
> - "--force" that is known to be dangerous, and does not pretend to
>   be anything but;
> 
> - "--force-with-lease" that pretends to be safer but is not.
> 
> The last form should eventually be eliminated, as there is no way to
> correctly intuit what the expected object should be.

What's not clear to me is what the intended workflow using
`--force-with-lease=<ref>:<expect>` is. Intuitively it seems extremely
cumbersome to manually pluck a revision each time, especially when
dealing with commits that all have the same description.

On the other hand for my workflow `--force-with-lease` works quite well
because I tend to use it in cases where me and a colleague are working
on the same PR, and thus I'm not doing anything else (including fetching).

Moreover, it seems to me that the problem `--force-with-lease` is
just one of marketing. `--force-with-lease` is strictly more "safe"
than `--force` in the sense that it'll reject some pushes that `--force`
will let through. I think that if we advertise it better including its
drawbacks it can still be better than no checks at all.

Francesco
