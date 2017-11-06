Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A013720281
	for <e@80x24.org>; Mon,  6 Nov 2017 03:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751192AbdKFDYH (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 22:24:07 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:44785 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdKFDYG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 22:24:06 -0500
Received: by mail-wr0-f177.google.com with SMTP id z55so7289400wrz.1
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 19:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DSVFoIaxQLyLpY2I/rG4foj/Pi6jG2cUWu77QiC/4QM=;
        b=dEt12Kq8rt6SEl5A4hrI1WbtdTGfGM8GWfvff73xdEGMNgdu6AKW/0HKJnxg6pL5ac
         QqW0R6jdjG0WMPguxwV/3mBs8I76d5sd8QfBjBnnH84md1wJ0dpSW32ZI2xVXxGnpY6h
         ryWt10UR5ZC+PQGGmtuc5eaZOSEPjQG8svPx0RAENvD/wZT38kRqY0AJps/1HsGmLFQe
         ojjGQTTO+QQqa12V6LEgDO1Szb5OfhB8xGWjbgyYo3oUQRjTN0op0Htza2rrARF3adGk
         O3A+ZhtZrKILWm+fOtmiA+q4U6CyRVViILukFNr66S76BEweTqxeIMJgH+Ymu9/LjpPn
         X0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DSVFoIaxQLyLpY2I/rG4foj/Pi6jG2cUWu77QiC/4QM=;
        b=QSB8meoc3iGZU5/C2gt1jWB5VxYGJANpDHR8STLwBAXASkmTcG2m3g5qCe1eJGTV/g
         o4yn+mie/5z/hHrEVO6RMNKl+aptUdfzGeaVVqbDUNs3GWKLAlF7LrYuJPo7FW8arwbd
         6LFrGLSMDqmN3yzf+C7kJCrt4v4KdqoQGF6Y7l817g6sBXsHdSk6SdkioSnuBhmwPrpU
         eit4jIcG9RQ1dkcht5iCbDaoKpbHLJJfRMZVFvfdPF9GnelcFqPy7n1H1EyJ6eUpRvbD
         069x2rdMyf8EeDFQd5WmhbUhHlQJuneLPEYcKJLeSEr7OdPiGfDRcL1+AJSatCTcTEHG
         Y1PA==
X-Gm-Message-State: AMCzsaWTnTe/qWNftsPqk1Qzlm2RMxCH3OQJO4vxLNCqu9nht4x3Qt7L
        hYATipVshazsktEM4lp0kfk=
X-Google-Smtp-Source: ABhQp+TWkPeD0lgjZcLzzRMgfAdG8ldYFS4NLfBx91hQuAmJozurzlAN4XFogXDTrJ+WXYNXNQqtaw==
X-Received: by 10.223.162.10 with SMTP id p10mr12197650wra.80.1509938645220;
        Sun, 05 Nov 2017 19:24:05 -0800 (PST)
Received: from [192.168.1.22] (101.154.108.93.rev.vodafone.pt. [93.108.154.101])
        by smtp.gmail.com with ESMTPSA id 68sm6763878wmh.2.2017.11.05.19.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Nov 2017 19:24:04 -0800 (PST)
Subject: Re: [PATCH v1 2/2] log: add option to choose which refs to decorate
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     me@ikke.info, hjemli@gmail.com, mhagger@alum.mit.edu,
        pclouds@gmail.com, ilari.liusvaara@elisanet.fi
References: <20171104004144.5975-1-rafa.almas@gmail.com>
 <20171104004144.5975-3-rafa.almas@gmail.com>
 <xmqq60aqn1ok.fsf@gitster.mtv.corp.google.com>
 <b0e3856b-e627-0d22-90da-3da1781f98b3@gmail.com>
 <xmqq1sldmqms.fsf@gitster.mtv.corp.google.com>
 <xmqqshdtl057.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
Message-ID: <9168f7b8-3b9d-a933-e542-ae5b741cb824@gmail.com>
Date:   Mon, 6 Nov 2017 03:24:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqshdtl057.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Would checking the output of ref_exists() make sense here?
By that I mean, only add a trailing '/*' if the ref doesn't exist.

Unless I am missing something obvious this would allow us to keep both
shortcuts and exact patterns.
