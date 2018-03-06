Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A311F404
	for <e@80x24.org>; Tue,  6 Mar 2018 02:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752906AbeCFCU4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 21:20:56 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39726 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbeCFCUz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 21:20:55 -0500
Received: by mail-pf0-f194.google.com with SMTP id u5so8137121pfh.6
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 18:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YyGVhZHfIqUxhEomzjAql5BobSHhqUEOeinDzH8e+2M=;
        b=ElCeW7EX8pPLCwz0PNPCWZ9O+ksv5/i2bRLM65XSizCN0pZtT3bDuGTH7B17Xs4wm6
         BjzkjfW2c0GPnOz8qquFABdBB3p8HeZVLDpzC7WQT+s7yKig4VNgwkIeMJLgki8nuDZD
         P0vJEl4rOaU02YZCvRVh6PNcEMdnJC8CjkQxpBc6GYuoimSlOsiQGnppv3UUANIEvCNy
         e6nCO5G+63ZgtWBiodlY6CMSqWNac4K5IBGHaPiDRpx6ojNSV74sWMhfccCXZ71aMmnB
         XgHYWC6bGFbjvnQSWzIt7MHRfh5jQlbeHrsq+lF+HtDul41wpYPbUhYeEDn3yPSLnDO7
         wDkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YyGVhZHfIqUxhEomzjAql5BobSHhqUEOeinDzH8e+2M=;
        b=uZB/EX8zXzoROd4NOioYE3+oKTcrEs5jkcZgbV27H+y81DWR/DyuOQ7oMGnL83CHR6
         XJ6vetJ4yg9RFwpRLZhbKhJ1mx4XvU01NWP67xWwhwR3fWZegEh1Ve7IUBQFQEEQjvbk
         5/LEDgmqxhaJlAUF+3UDR7oERlEZmeOEOoXPtledsY2pYl00FO2Y4H2sB6JtV+qKw/Op
         qieZjiVltEkQLiE6dZQdGIceuTOAy8SY23E2q+x3EIpTATZQxHFgkpo0IjVzq/3ayoWS
         ww38Wp2yRpI/LE8QtDlq/V88Atwja/WEMUGITkVGx+WeMP5VThyqcnme2v+dattgJny/
         LDyg==
X-Gm-Message-State: APf1xPBwh8cd4+ubyJ5cdQTBsLmrh7nw32Z2xvJdS3qlrFGeim0lfd5a
        ZTP9Mg3dD/UlawNFB7+ciOYjJRRD5dk=
X-Google-Smtp-Source: AG47ELsDUYC5VAoWWhn8hp7hg0v9x0hU/cuQVzGcRK5hxRd2uLgWnz1i08On0qgsHdhwPixV2UoDaA==
X-Received: by 10.98.14.200 with SMTP id 69mr17130668pfo.168.1520302854475;
        Mon, 05 Mar 2018 18:20:54 -0800 (PST)
Received: from localhost ([2601:602:9500:3a4f:8042:ad20:287d:7753])
        by smtp.gmail.com with ESMTPSA id s68sm21923282pgb.43.2018.03.05.18.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Mar 2018 18:20:53 -0800 (PST)
Date:   Mon, 5 Mar 2018 18:20:52 -0800
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH 0/4] Teach `--default` to `git-config(1)`
Message-ID: <20180306022052.GA46077@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306021729.45813-1-me@ttaylorr.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 05, 2018 at 06:17:25PM -0800, Taylor Blau wrote:
> Attached is a patch series to introduce `--default` and `--color` to the
> `git-config(1)` builtin with the aim of introducing a consistent interface to
> replace `--get-color`.

This series draws significant inspiration from Soukaina Nait Hmid's work
in:

  https://public-inbox.org/git/0102015fb0bf2f74-cb456171-fe65-4d83-8784-b553c7c9e584-000000@eu-west-1.amazonses.com/

--
- Taylor
