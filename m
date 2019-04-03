Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8982C202BB
	for <e@80x24.org>; Wed,  3 Apr 2019 00:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDCAB4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 20:01:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42789 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfDCAB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 20:01:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id p6so7329187pgh.9
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 17:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=48qjLs2HhiHL7Cic2NLgWRPMm1cmn3peG3UHcvWU9ek=;
        b=JxmPzlQN/im20fzZN8/65ydqEsScSNY6Pk828pqbhGZMEb/vQsZT42oT6I75zHD2Ay
         UZVN6l68CKcs3r0zc+5CUfPgXIvVK+LKTVfIccG4bPNodgFzvEmso8AQXEBRFg/HdmFt
         BgiK8qrPQy0f83LzhFrD2kXloq5zqlZaz7wql1kc0BI2ELSBY4fExrjsY9sLaIaUngsX
         s2jXDbePGfG6R30oDEGn8HkfzEiu4vDU0LWgROY7ivfF2GyFlXgeKzwQwaVPxtMaoTlR
         8ugsHCLxwtrNSimLEVmwh+oaD5nvxzozxeEX7hwRywnHsHpS/ZZv4zsyG707+NapYGtS
         PtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=48qjLs2HhiHL7Cic2NLgWRPMm1cmn3peG3UHcvWU9ek=;
        b=GLwN4ryr0qbrTv8aNwI5nQp4eArZ8U1CtgrUXiljDdQNS10+v0LZEOqkfjdHhUztE2
         L0fgfLrXMZcZikTljQjTxj5++dN61DxiyGcKuFt63FzrCAt8TVg8yMXYBn5HXdhhrodw
         L1kVRqmiwlah5f2VEA/jVQJPOz6BjTGTkgVyxUl7qfV2bIXk9J3ebPeCvoUI9y+giGIL
         8Qx46wXLRGp2eZcfMWl+PEh0/Su/8SBV1evenhWTmWWHUrKaIS6/UEIBzaDzN4l5XqQw
         pFugeSrajK+n9seYpwhFrfxyDiMC4e4+Tea3J1BTZxUz2iUP8TAWNhvK/kBAgaoCeU1P
         zb5A==
X-Gm-Message-State: APjAAAXn0RMjJYCeGwEAEjrYxu8hWIY3YChsCz6Qquq8G9fTPh2hj9Y1
        YA60rvN4zydNm7MbZ98wA10=
X-Google-Smtp-Source: APXvYqzR/cpYhyOsKFNbzbdxMLDMsIHjbhVU6m1u+9+w0pILfDwZbY3RcnpPc5Pd8cM2iQt7EeixMQ==
X-Received: by 2002:a63:4e4e:: with SMTP id o14mr70359556pgl.254.1554249715258;
        Tue, 02 Apr 2019 17:01:55 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id 75sm25641917pfr.55.2019.04.02.17.01.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 17:01:54 -0700 (PDT)
Date:   Tue, 2 Apr 2019 17:01:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        avarab@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 4/7] trace2: use system config for default trace2
 settings
Message-ID: <20190403000152.GB190454@google.com>
References: <pull.169.git.gitgitgadget@gmail.com>
 <pull.169.v2.git.gitgitgadget@gmail.com>
 <d048f3ffb801adc7f1b4e48248ca31ebade1b37d.1553879063.git.gitgitgadget@gmail.com>
 <20190401210034.GD60888@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401210034.GD60888@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon wrote:

> A question for the list: should these new config vars also be documented
> in the git-config manpage, or is it better to keep these separate since
> they are only read from the system config?

Yes, they should be in the git-config manpage.

*If* they are read only from the system config, the documentation
there should say so.

Thanks,
Jonathan
