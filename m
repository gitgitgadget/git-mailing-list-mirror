Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A94D41F461
	for <e@80x24.org>; Sat,  7 Sep 2019 23:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395307AbfIGXjw (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Sep 2019 19:39:52 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:39593 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfIGXjw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Sep 2019 19:39:52 -0400
Received: by mail-io1-f66.google.com with SMTP id d25so20927143iob.6
        for <git@vger.kernel.org>; Sat, 07 Sep 2019 16:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z40OCI5AF5soxxh1mTcg3Z7W/SKOzzunxNmGvEfLb8g=;
        b=YUyjpPhUbCTz1B8rC8mAYfpJnAfMtvEruCHDEFi/83heM6Ylk91h0e6SmuIpk4BupI
         0B4Ydk6qgJfojrdBitSgwp1bFDpARHmQbKVq5MIt1zuBnAgjm63rYG89hMah9VvgpLJv
         VSHXq/C6dKllZQNZCAM7rUOKZZXEiP7JGkeZrVISskdxj1/KUKhWlGqit8htuGpF+9hm
         +zc3M5oPGOtHPFgCFQZJis4Oeg5z+rJAM7t7NMuHuHyIWpA2PfMnR8srrFVGQjBPDm+U
         QSRKPZpjm4v9arAw7SXDe1Ntvo/C9pMpVYRJR6iUjrDhtJt3KREcitMI5527fBYoNZK9
         XQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z40OCI5AF5soxxh1mTcg3Z7W/SKOzzunxNmGvEfLb8g=;
        b=OYn2xr/ykrUr+0jsMjSqDHkGlzEryB2aKES7CVkyaJHAJwF1WrbJF4oE7KPFRexoSP
         NibAPOaYfpOoLR5tVsJ8sPkeqe+cDxFs9gGPqKkw7IEmPOTOUP1UB2R7UZyAGAbKB1Z1
         O3FrazU0i1toNxgeVwspw3WgHKNpQKKk2zMeyg89gNkwKlwc1mH4jhTelLQrKsb8aqhu
         PclP0Y/eRlp8uAwUT+6MSPmKercPvG0Zxk0sNzXhYzSZ3uVF1du53v81Gpoagnjznb9X
         wubBAfvX8NVofYpT5K6DEaWoQOZP3rP5SGTyoTEVv4SUyPG8I5Ls1PwxqITiUC/sVd9G
         BvGg==
X-Gm-Message-State: APjAAAUto37iaK/D2xpUXdC4GKpM2xX/ZeiKPK22053hFXwIaKuKGHH9
        8FHHi13rXN37odIlIPPITwL3AlOomuU=
X-Google-Smtp-Source: APXvYqyoOmVY+vvbhYi8I2tyus2Opkv3ceboieCUfveenNkHVkJb0KKXZqeUHu4TI9jdTQWf+UyFRQ==
X-Received: by 2002:a6b:bc47:: with SMTP id m68mr19374572iof.70.1567899591551;
        Sat, 07 Sep 2019 16:39:51 -0700 (PDT)
Received: from localhost ([206.121.37.170])
        by smtp.gmail.com with ESMTPSA id u3sm8383439iog.36.2019.09.07.16.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2019 16:39:50 -0700 (PDT)
Date:   Sat, 7 Sep 2019 19:39:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Freese <ericdfreese@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] for-each-ref: add '--no-symbolic' option
Message-ID: <20190907233949.GA43535@syl.local>
References: <20190907213646.21231-1-ericdfreese@gmail.com>
 <20190907213646.21231-2-ericdfreese@gmail.com>
 <20190907232821.GA42449@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190907232821.GA42449@syl.local>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 07, 2019 at 07:28:21PM -0400, Taylor Blau wrote:
> ...

Oh, great. I was pretty sure that vger accidentally ate my last mail,
but I guess not. Sorry for the re-send.

Thanks,
Taylor
