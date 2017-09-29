Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 508BE20281
	for <e@80x24.org>; Fri, 29 Sep 2017 20:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbdI2UYP (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 16:24:15 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:46442 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752092AbdI2UYO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2017 16:24:14 -0400
Received: by mail-wr0-f170.google.com with SMTP id t76so236356wrc.3
        for <git@vger.kernel.org>; Fri, 29 Sep 2017 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=madiva-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XAJ85V7C1QjYMij57KrUNQ95Ssl0L3aKGpFYK+PDrJA=;
        b=Arl1LCjUB741kRLb4ylMqDueBlT3wws30R7B91OYmCNKNxcWZbapYZo/outs4a7yRJ
         bunMK2aiifYoxMzrfYMhDJrNI5wONL19I295Foe2Gr87FLwoSQ+z4d3QMYh5ATCPZd3E
         DWiC7xQrF8NKrEIL+xiTAAzkS6ze2r/OpbnDxhvyova05LBVxxq5lzUHGk/S+1qLrecb
         bW1xmpQPYwLUgxRVjyz6yw+RiyRg/VesPq866p6kSnP9JVUpE8r6cM9twpyIW1yF+N3q
         IzK+EuC7TyIuJ8lKKFIzInB6Uak7CafXT3STWEEcp2uag5L5+hcm8cM+7wZ/8g2yOKlN
         K+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=XAJ85V7C1QjYMij57KrUNQ95Ssl0L3aKGpFYK+PDrJA=;
        b=g/cMvYg6kkalI9oIpJiKI5u5wLZHMKI8NaDLUVhPKVCGGxCLLuKoC+ZUT71LdD4FT2
         fwK062180l63g5INIGR1KdAJWKo+EmE7AcmZiszp1Stg4hAnMYfp+QUQ0KfjIG0KXrBe
         qdBTHTNWhPLNFtDE4P7rkO3s8YawOCeuWq3jlQRmu21hTWvdhJxyil3IPpcmcYWwKBvW
         rqGjdQ99kCZBSxUhm/xBYo8leyHpZDl1ApdTsHNQq0ZJmFwV+5k0RSinPz4iRbvxEhyC
         ZZKsXGOYa+Ltzs+NBTZjWpBmFGehyzMJkwEXKF/vkPWWt/s6nPxEsVc/tqHHJNU4N4Z2
         GaaQ==
X-Gm-Message-State: AMCzsaUNejUt8ntavOHHvZC5eaZIMIuH5AGfvA0MqNutbSXcjqIKcAVf
        tawAOaZModpo4FI+hkM4oES/3A==
X-Google-Smtp-Source: AOwi7QBNIxdCeG9bmlXY8ayopUhL+GPnO3eX5gEc57D28YYvxR9ifYfYoG+EeI4MaOWpuZ9xmy0NrQ==
X-Received: by 10.223.187.201 with SMTP id z9mr2313629wrg.195.1506716652793;
        Fri, 29 Sep 2017 13:24:12 -0700 (PDT)
Received: from [192.168.1.34] (162.red-83-46-193.dynamicip.rima-tde.net. [83.46.193.162])
        by smtp.gmail.com with ESMTPSA id 69sm2338512wmm.22.2017.09.29.13.24.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Sep 2017 13:24:12 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] gitk: expand $config_file_tmp before reporting to user
From:   =?utf-8?Q?Ux=C3=ADo_Prego?= <uprego@madiva.com>
In-Reply-To: <xmqq4lrn30bz.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 29 Sep 2017 22:24:10 +0200
Cc:     Max Kirillov <max@max630.net>, Paul Mackerras <paulus@ozlabs.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <544DEAEA-9F66-471A-BEC9-B3D1F3C475AD@madiva.com>
References: <20170928041417.28947-1-max@max630.net>
 <xmqq4lrn30bz.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Well something like this is not paying _Paul_ enough for what he gave to The
People, so I do not think there is worth trying.

> On 28 Sep 2017, at 06:37, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Max Kirillov <max@max630.net> writes:
> 
>> Tilda-based path may confise some users. First, tilda is not known
>> for Window users, second, it may point to unexpected location
>> depending on various environment setup.
>> 
>> Expand the path to "nativename", so that ~/.config/git/gitk-tmp
>> would be "C:\Users\user\.config\git\gitk-tmp", for example.
>> It should be less cryptic
> 
> It might be less cryptic, but for those of us whose $HOME is a
> looooooong path, ~/.config/git/gitk-tmp is much easier to understand
> than the same path with ~/ expanded, which would push the part of
> the filename that most matters far to the right hand side of the
> dialog.
> 
> I somehow find this change just robbing Peter to pay Paul.
> 
>> 	} else {
>> -	    error_popup "There appears to be a stale $config_file_tmp\
>> +	    error_popup "There appears to be a stale \
>> + \"[file nativename $config_file_tmp]\" \
> 

