Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B07BF1F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 14:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbeJIWHP (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 18:07:15 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:36885 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIWHP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 18:07:15 -0400
Received: by mail-pf1-f181.google.com with SMTP id j23-v6so972806pfi.4
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n6DVLCkyiYMo109Ed1gZAZrvJIXxLEacsCW40MjxoJw=;
        b=uVrrylCM2pyKzHH574tvYhrr6WSXmqskhSeVgWP4jZRDQrJ0A3K//bmqQmb902jYPa
         XqxubM2qzJd+cZOvTDsu0IXxKfp+FyWtadNmVRdK37stq9HyluRYfJBjDDT1K71l3gtp
         BD8Xry6DtqLSSDGZu/X1krk1oL2+v+uctgj2VUZ77w/dDhFMTgUx7IPdo/A5qE0SStVK
         C+b6QCkiXsapRUWNZ3zPEjfVsS/E/fb7ZrJD7le10vWAvXUN0iel/UN8S7QD2GEX1dhz
         M7owb0eWVAaf5J2QWOSWbNAfbljagYVkc4ETxMfp1s430ehoazLqj48+PwHDgJCqr9N+
         6f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n6DVLCkyiYMo109Ed1gZAZrvJIXxLEacsCW40MjxoJw=;
        b=jw8nSlitaNVLZGnqHpDoRal41CKL5+rJe1dYAc+C0O5bjkbZOJjltKpWGxXALT4LwX
         F2+Az28F1rZzHbp1h4JKt+cJbVUv1+50s/LqMbpuZevDaebuISEzk1XLmYLZV2iLYV6k
         WoSCR2DDPeV5sVsdf8OYBQ9qNeNt5rIFro6RgqVypDJHC6yHPoFCvwh64T+izCWtbVJT
         tcA3s0vMqCv/1lEPwfcE8EBV7x+SxQ74oO2dDh9Zz2e7gtw229N0RPrZiwgq+OmYsXe2
         SNRnu/sCU7p7e6GYSoRDymNigU4BENdwNeyzls5XOrNfZ959kK2QO6eNYoFZCLGTg/y9
         jtlg==
X-Gm-Message-State: ABuFfohzwnwIj5ukA8n1lhAsxx84QO9DKoRgl0FZaG4meCc5qca1FNIU
        4v9sKs9Gg9yJrQ61hd+c9PdDvw==
X-Google-Smtp-Source: ACcGV62pXQMclj60RJBHNyjVFLBPk/Z214R1udx9XN47CUWqO3JJP86f35i4eQmu6FQ1BZ+2civU4Q==
X-Received: by 2002:a63:d30c:: with SMTP id b12-v6mr25994581pgg.61.1539096597693;
        Tue, 09 Oct 2018 07:49:57 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:6960:b0a2:2062:954b])
        by smtp.gmail.com with ESMTPSA id i2-v6sm19321251pgq.35.2018.10.09.07.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:49:56 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 9 Oct 2018 07:49:54 -0700
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com, sbeller@google.com,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v5 0/4] Filter alternate references
Message-ID: <20181009144954.GA12981@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1539021825.git.me@ttaylorr.com>
 <20181009030918.GB6250@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009030918.GB6250@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 08, 2018 at 11:09:18PM -0400, Jeff King wrote:
> On Mon, Oct 08, 2018 at 11:09:20AM -0700, Taylor Blau wrote:
>
> > Attached is (what I anticipate to be) the final re-roll of my series to
> > introduce 'core.alternateRefsCommand' and 'core.alternateRefsPrefixes'
> > in order to limit the ".have" advertisement when pushing over protocol
> > v1 to a repository with configured alternates.
>
> Thanks, this looks good to me!

Thanks again for all of your thoughtful review, it is much appreciated
:-).

Thanks,
Taylor
