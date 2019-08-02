Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C3FF1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 10:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389189AbfHBKKE (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 06:10:04 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51690 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728855AbfHBKKE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 06:10:04 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so67392370wma.1
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 03:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jpM1Yvhg6rFFUZL8FUfRVjSabPfIz3iDN+8KWPQm+EU=;
        b=pTURokvV5OnysNUEtM9CNPmKVjKPZbDgC+3Ko/4mmpA2Kjd4SXMWR78d50q360HTJM
         oxJ6u8hg+4jyExPevNMDvttnE9nCpHKFfh8XojhZH9PGaTYt6PD2LO1ddNFHyxKYxCIJ
         yjW1t0KJ9xofnOIFzemdkb71sE1kQvPHzXFHt+syrle2bwzd9dax9tkeA3aMIzuROC4O
         a0t9+mUrwl8SB67ccqrfIaeB+axKfKfvnR0uV60mh9kBNQe3mbIkLIW3G/HX/fnm/rsT
         7hmZD0daFHpz8U+PnnI3kz43EnZTFJvK2/6j82xuyNftbnpUk+IS7G4OUvW6Wx9kYLjl
         fxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jpM1Yvhg6rFFUZL8FUfRVjSabPfIz3iDN+8KWPQm+EU=;
        b=Ws6Ox4Fa4BjMhm4kAVGCS8MtcGGriv2IJ2dFvVPSVosgaOhXNG2hFKYdXLqw92gtnq
         rpj8Qi2hcsjuJ5DSuIKQ90jT+GXAfG+gEe2gWkMFcsQwntYiNN6V806N+5Ljwz7ODdxt
         BLMX4OWIKkkw77xS4JNzYJFwvN/RNZWn2fgGnXFyPgzhmD5a1j9i+NsUG/l9757iFpUf
         od/0gY9QWdBPlXaIxGAqnVZCamm0SRuVPkUXMRsO4Gb7vsRmQjNITbMHqEfHWDhjr+FY
         b9YUZOC3vcqhOmNaeP+vODNZI/FKoRoBsdQQtp/XrUwexMQom3A3b2UpkY7r1/+/D8mv
         EnmA==
X-Gm-Message-State: APjAAAVg43OHZbs6hOu5TvV44OyvWr+3Wzmjk2I4cwOby5J5fQvBP1ns
        UxGsYp4msbHfjEg0x0IxtOQ=
X-Google-Smtp-Source: APXvYqxhAvhajpzwtcDTjYRSjmTt/z93FCWqGuEGm6pH54dlhInXpZJLznNGlnE23nHxcJlUzAPg0Q==
X-Received: by 2002:a1c:e715:: with SMTP id e21mr3983024wmh.16.1564740601746;
        Fri, 02 Aug 2019 03:10:01 -0700 (PDT)
Received: from szeder.dev (x4d0c4277.dyn.telefonica.de. [77.12.66.119])
        by smtp.gmail.com with ESMTPSA id 2sm106829807wrn.29.2019.08.02.03.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 03:10:00 -0700 (PDT)
Date:   Fri, 2 Aug 2019 12:09:56 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Brandon Williams <bwilliams.eng@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] tests: warn against appending non-httpd-specific
 tests at the end
Message-ID: <20190802100956.GV20404@szeder.dev>
References: <20190730214000.GT20404@szeder.dev>
 <20190801155309.15276-1-szeder.dev@gmail.com>
 <20190801155309.15276-4-szeder.dev@gmail.com>
 <20190801174126.GU20404@szeder.dev>
 <xmqqzhksn3zx.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqzhksn3zx.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 01, 2019 at 11:18:42AM -0700, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Thu, Aug 01, 2019 at 05:53:09PM +0200, SZEDER Gábor wrote:
> >> Subject: Re: [PATCH 3/3] tests: warn against appending non-httpd-specific
> >>  tests at the end
> >
> > This subject line kind of sucks, doesn't it?!
> >
> > Alas I had a bit of a hard time coming up with something better.  So
> > far the best (well, least bad) I could think of is:
> >
> >   t: warn against adding non-httpd-specific tests after sourcing 'lib-httpd'
> 
> That reads well.

Ok.  Should I resend, or will you amend? (I see that 'pu' contains the
old subject line).

> Thanks.  It must have been tedious to make sure moving tests around
> won't break them due to some (hidden) inter-dependency among them.
> Very much appreciated.

Luckily, all the moved non-httpd tests and all the httpd tests in
't5510' and 't5703' work in their own directories, meaning that they
neither influence other tests nor are influenced by other tests, with
the exception of that $LOCAL_PRISTINE directory that I noted in the
commit message of patch 2.

I did actually diff-ed the output of the involved tests before and
after these patches, and they were essentially identical (the only
differences were that extra 'rm -rf', a couple of different
timestamps, different commit oids shown by 'git commit' or 'git
fetch', and the occasional races between the trace output and actual
command output).

