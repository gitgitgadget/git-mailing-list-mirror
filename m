Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66D6C1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 20:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbfIPUki (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 16:40:38 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:32805 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbfIPUki (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 16:40:38 -0400
Received: by mail-pf1-f181.google.com with SMTP id q10so651409pfl.0
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 13:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=nFS81jg7/h9+4PusAqPzPRnrTYaqLvkbYIRlEVqVdSk=;
        b=VrwUZRFGGA3GLOBkW2zj7zFn2zQS6BZl5ZW101weW9ih/N9a+wJjW38KafF0LB9TIm
         ylmeE6ULYjmwMIfdNQrQ/GteNESuw0FM9NzgzbGIoWeBQul+6HZ8qhdvB4p75TBXsPZj
         HUBgzOpdQdWl+A1Ttov/cCJcHFTGCXBQcSxXQMym9iZaL953zHZOWxCoyuQ85qSY4x7/
         DDvFsR71+lKkGeHOkzMf2RvEvgCsF5oIoATHc0HO6gcLXJr8dxyZLW3C6+u2ycdaYJOC
         gL5Ef8x3AbXQE2mZz+LwRcsow4bzcGzQLyluUyl5/wpwkrZHbqWlQS5O4Xs80ay5ERLq
         VHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=nFS81jg7/h9+4PusAqPzPRnrTYaqLvkbYIRlEVqVdSk=;
        b=JBXmmE/wccXo8qocnAR1KZWcmM2xo1iUmalQPUIW9f3XFc5LXO/wrjf1/+k8MT0BUG
         vhRA3S+DgWQIdrq7iITRWJwBUmLYxw9Sj3CAdWzyH5if84cnAXOEU/0Hsnwtsa3fvrUO
         2dNT+91H/Jc2YxraomfnPJsAzsSQy5R/iVmveGgw8dwq1GJPcl9D21ZWJ9wqbnP8HhTR
         kD2gL+1car13i7H0kC0dhzZepidE+qiZ9cWqXEwM8cZNwSvyTDq92CGeaQTxN1t4Dd5i
         sism0IekeIIughgbh7X1Qxm9YdS30W4CivJ+2TPepp0qrgw/gej/w4S2vSycXK7TmDjj
         4Kig==
X-Gm-Message-State: APjAAAV3sE/S23jmee3pmPhTQwNFmBCQBp/3eCU1nv58aUwu9dM5y5z/
        vVhpLjCP89gYvewCLHDvI7eBXA==
X-Google-Smtp-Source: APXvYqxr+H63hlBn3XAHsI+or5wK4Pk0+yt7nIWKJhSie03T62zjnUu8PFYdzxfxkOX0GIR0u5UwYw==
X-Received: by 2002:aa7:9d8d:: with SMTP id f13mr293832pfq.196.1568666437160;
        Mon, 16 Sep 2019 13:40:37 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id v3sm6051859pfn.18.2019.09.16.13.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 13:40:36 -0700 (PDT)
Date:   Mon, 16 Sep 2019 13:40:36 -0700 (PDT)
X-Google-Original-Date: Mon, 16 Sep 2019 13:38:05 PDT (-0700)
Subject:     Re: pd/fetch-jobs, was Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
In-Reply-To: <xmqqh85cb0hr.fsf@gitster-ct.c.googlers.com>
CC:     Johannes.Schindelin@gmx.de, git@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     gitster@pobox.com
Message-ID: <mhng-98edf120-10e7-4944-bfee-fd984047a6b6@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 16 Sep 2019 10:43:28 PDT (-0700), gitster@pobox.com wrote:
> Palmer Dabbelt <palmer@sifive.com> writes:
>
>> ...  It looks
>> like there are some test failures when I rebase to the latest master,
>> which I'm happy to fix.  Just let me know if I should:
>
>> * Send just the first 4 patches, holding onto the last one for later.
>> ...
>> * Send just a single patch, which wouldn't add the --fetch-jobs and
>> --submodule-fetch-jobs arguments.
>
> It is either one of these two, I would say.  I am personally much
> more comfotable with the usual "backward incompatibility migration"
> form (i.e. the former), but apparently I am nto the only person on
> the list so ... ;-)

OK, well, just dropping the last patch causes the tests to pass when rebased on 
master, so I'll send that out as it's easier for me.  Is there a policy for 
deprecation timelines?
