Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0088F1F453
	for <e@80x24.org>; Fri, 21 Sep 2018 17:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390651AbeIUXi0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 19:38:26 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51374 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeIUXiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 19:38:25 -0400
Received: by mail-it1-f196.google.com with SMTP id e14-v6so2922180itf.1
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 10:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=InXCrGaKO3MIiAIhEel/8aYP8WCEPQlpB9MsmjLgSW0=;
        b=qksjx91d37DwLrz4lFVLpgYk7DU1VLyyWGZiEmhDbQ9xk8Obn7y62S0leAkjjDIwHm
         KItqXOAarLkmFo1bbfgWMZCure0OE39+zwZLzPI55KEhedllfIiKuItXDNFC7nm7TJ9y
         KOfAsQyTqRE3h67w17LfltM9fve30+TRW8PMQaG8NZxuMrMsPgb2s8hV5aomTyy77gRA
         9P7bxuv3SFi6JBf2/f2xzkU0KcB6AJSzHkvKW81l79K+M91RNR9aR3PIG08YOMNXL/Mh
         ABSdv7wT77tL0etS9RpXVd0NJAeYLKy/uSVXlWZ4iw1hTVB6t+TDM5zb5FzP2KxMryRY
         2AVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=InXCrGaKO3MIiAIhEel/8aYP8WCEPQlpB9MsmjLgSW0=;
        b=RlxUY9Mij5Oj9PSLejD7AhvPXLfKlW4cIuL2pyDQ3U0O/VfG6ZXYiRV3nm7LE+FxXl
         omjgZq71ukwrLlzK44IyLJ36q9m4kUJ1bA7+LtfSNJ9gFJpMSKVuXzqrTPjl5q2fJ98f
         /kDf5hCF0qaHmLhQHW9ONFjs3rxPbWEjOOp/dcy01xXbA6+5DUTSrV0AgvFZgkW28nU7
         wgXuLA932K9E/dRQS3BBkoftIu4yIUcxM4Pw9NADJrJFEuMTKSbjXffg5rf8E/1OrT/7
         s8kmNHZKGuzPBn8lV1t20g6LoFjXMj7jbSAaIBGz9SKyoDcGOg+FVWo7ni/iF7/7NHXG
         kSlQ==
X-Gm-Message-State: APzg51D5LHIpY6ICYNyaE3qlOhgL7TDvpNTCxskbv1cDxpuZjqg8ivjN
        soWjp/2tc/kgRHcfWPL1qcPT8g==
X-Google-Smtp-Source: ACcGV61397RnFsF0jPitl7MaabnaRQOUMeBjvmWruo78ssATtIBXW2SP53ntyP4T8b8yTPu5DIDciw==
X-Received: by 2002:a24:b303:: with SMTP id e3-v6mr697325itf.70.1537552108367;
        Fri, 21 Sep 2018 10:48:28 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id m13-v6sm2708055itm.40.2018.09.21.10.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:48:27 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 21 Sep 2018 13:48:25 -0400
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 2/3] transport.c: introduce core.alternateRefsCommand
Message-ID: <20180921174825.GA17718@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <4c4900722cab253b3ce33cb28910c4602ce44536.1537466087.git.me@ttaylorr.com>
 <xmqqlg7ux0st.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlg7ux0st.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 09:39:14AM -0700, Junio C Hamano wrote:
> Taylor Blau <ttaylorr@github.com> writes:
>
> > +extract_haves () {
> > +	depacketize - | grep -o '^.* \.have'
>
> Not portable, isn't it?
>
> cf. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/grep.html

Good catch. Definitely not portable, per the link that you shared above.

Since 'depacketize()' will give us a "\0", we can pull it and anything
after it out with 'sed', instead. Any lines that don't contain a "\0"
only contain an OID and the literal, ".have", and are fine as-is.

Something like this:

  extract_haves () {
    depacketize - | grep '^.* \.have' | sed -e 's/\\0.*$//g'
  }

Harder to read--at least for me--but infinitely more portable.

I'll wait until a little later today, and then send you v2. Thanks for
reviewing :-).

Thanks,
Taylor
