Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A5571FAEB
	for <e@80x24.org>; Thu,  8 Jun 2017 22:39:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751547AbdFHWjS (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 18:39:18 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35778 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751478AbdFHWjR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 18:39:17 -0400
Received: by mail-pf0-f182.google.com with SMTP id l89so21767369pfi.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 15:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=UvpbTydk8vrrbEinuQbrIuE40j5v+OzVf7JKPkB+Pb4=;
        b=03XNPJC7FqGxaHIfo7Pl6TxbOmXyyyFystaNwEEMaSyAbmkZIL5g+VZr0C/pd4cPgu
         RMI93yvwzG1JZ3PWT9rRZ2N8Nn7/nQ8LIOquXHn80dldblsPUNNLx/yJh/Z3BNx5Bqxr
         ZYBhZLU8tqUhzsVHB+Y4dil9SfZJxVk74XPZ6C4zdKE+Dwk/pRIOKb3fWdFVI/GuvKi+
         wJV1k7bA0zkK5ok+D8S75MdzEeP30wSXToPH6nRrb/otNe8K2SJtpvE4w16jMb1sZo4M
         GN56POeSyWc4d3Ul3YH2H2WklwxNoncQkkuI2XR56XdLpP7T8OZBdDgmUUXM7GZcC7Dh
         UhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=UvpbTydk8vrrbEinuQbrIuE40j5v+OzVf7JKPkB+Pb4=;
        b=eefqb28dS94qMGQz2GkrUE40tCxhFyEgYmsy4qHp3RKANxDZSGIVQ4PfUnPpsUB+BN
         Z8DfcFMuFmFE0fwU/V1vocCy4XsBxOpFza98HGWK3XnOUKzwptuRD88OeCE8kNJ2Z5tz
         JiSfIpYhuwZ9eIf+3QTKRa+Av9xjUXNvClJEipHcfcwwLoewlLBY5NmNYnlqzI6FpO+S
         hMEyZ7Mg+p54vecgs4QRXnWxC3Ut4sYV2TAn0hIc+zIMQTqraMQGpWrP/3a5SHj4rVZc
         92DOsypoguchd7qDc4o7XXofiDUXGAq0HUQeGSj71dpgMfFM7Pj1bcqRtwQOYAqd3hFL
         41Lg==
X-Gm-Message-State: AODbwcDTTuor3Se8tjMQIeTyHlHDGFPJiHwOTFaShfX29YEBJDTKDNuY
        5Q49L4MFk0UKaOpM5P+mCg==
X-Received: by 10.84.218.136 with SMTP id r8mr36988497pli.265.1496961551311;
        Thu, 08 Jun 2017 15:39:11 -0700 (PDT)
Received: from [10.0.0.2] (S01066c3b6b1953d0.vc.shawcable.net. [24.80.205.243])
        by smtp.gmail.com with ESMTPSA id n20sm12672298pfi.127.2017.06.08.15.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jun 2017 15:39:10 -0700 (PDT)
Subject: Re: Re: git stash --include-untracked possible destructive behavior
To:     Brandon Williams <bmwill@google.com>
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
References: <2b695c73-9de2-5502-6d19-ba4ad0114978@syntevo.com>
 <197975d0-7ec3-0ff4-9201-48226fd3b60c@teichroeb.net>
 <20170608222949.GA121539@google.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Message-ID: <e45eed21-f808-b2a8-a01b-78c18a9c343a@teichroeb.net>
Date:   Thu, 8 Jun 2017 15:39:10 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170608222949.GA121539@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looks like that series was merged last week, fixing this issue.

Marc, the fix will probably be in git 2.14.

Joel
