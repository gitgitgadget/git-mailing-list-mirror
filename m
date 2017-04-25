Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44C8E207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 22:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1949072AbdDYWbB (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 18:31:01 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35999 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948704AbdDYWa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 18:30:59 -0400
Received: by mail-io0-f193.google.com with SMTP id x86so55457735ioe.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 15:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kZLS4ZXkWOI20DCHjkN5MpIG8uI20esfMVTflSrS5Wc=;
        b=ByyUOLpcXjJMuNwOaRqHiC8b0lYWl7Dbdb+txCCF2tXGgTkHIhcPVnpJcts8CLWj03
         osCpBZGdPMfTZ+aRgatH/k62Jsk22dZLtxdOacLwAwQ5qZJRB4v7HQgAPcjqayqMDAhj
         6HpUAmymNGuULrKyEHfN5R4IAFEMhPsY5HqUNUXufldIYVwMqse5XLDppKTdpDlpE8aq
         BsDrqesqXsHcXZcM0Aua4NAzL0dARTzUVOaBqGbhmo5mAhr/EWuYgak3MrRdhUqxKZ18
         o87VftIOk/jzMU5EW9O9QLPAt/BmnjHoQXe59G9BiTyJayPj3ciabtC6I3YVsJOp+BRx
         QtCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZLS4ZXkWOI20DCHjkN5MpIG8uI20esfMVTflSrS5Wc=;
        b=A9Ehlfmt97IY+UHgWayzJrhoq4/lowyOn8ZVUdsUGZ5J7AeXDXqpMNE5YeOQygjfG1
         M3E/AQP/Kj5qLPcsx5tEFpgowmIXzp8BWlRzFP+PFAc9TAyH6VThTi+WHl1bBy4joKSd
         rhCYo1YMrxeAFFhP0lB08qqy+LUpf/HYnCyCzRcfZ2a5tDQVAFUej3ms3cj38uzgJ9fo
         K5MyYXsITN9Di96fOh+swkvNsKMa/4aGZkokmzKtp4FkBxiraJkfbRhSUIW+uS9EkRhi
         oey4S77qX7uQqgX83MF9f8xt3uVT44Yk4nhA88iLwxXrco4yyALUekC5SRhTXzBc7uCU
         RZqw==
X-Gm-Message-State: AN3rC/7E42j19P/QZut/dka395kR10ASf/O1bHjGSYXNu3yw3+eJ0tS2
        66WWIdIJXIlakNAp
X-Received: by 10.107.31.78 with SMTP id f75mr19909246iof.44.1493159459024;
        Tue, 25 Apr 2017 15:30:59 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:1ce5:6571:c8aa:de2f])
        by smtp.gmail.com with ESMTPSA id p75sm2628867itb.26.2017.04.25.15.30.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Apr 2017 15:30:58 -0700 (PDT)
Date:   Tue, 25 Apr 2017 15:30:56 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] sequencer: require trailing NL in footers
Message-ID: <20170425223056.GA104886@google.com>
References: <20170421220155.GA142345@google.com>
 <20170425190651.8910-1-jonathantanmy@google.com>
 <CAGZ79kapU5AL_iPJXCavCKAQ0Fw=pqWZS4F6Vri-Q1M1WMVs_w@mail.gmail.com>
 <f49a858b-26da-7e8c-e0f2-8d66158f016a@google.com>
 <CAGZ79kbhxjO-tFW4_kObTZiauetjsgY1NBSKvo1NV5nKNEy2xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbhxjO-tFW4_kObTZiauetjsgY1NBSKvo1NV5nKNEy2xA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 25, 2017 at 02:56:53PM -0700, Stefan Beller wrote:
> In that case: Is it needed to hint at how this bug occurred in the wild?
> (A different Git implementation, which may be fixed now?)

I might contact the original author, but it's easy enough to imagine
automated 'filter-branch' scripts that could produce this. e.g., this
trivial example:

git filter-branch --msg-filter "perl -pe 'chomp if eof'" HEAD^..
