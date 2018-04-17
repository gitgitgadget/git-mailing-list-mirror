Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C84B1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 19:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeDQTAK (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 15:00:10 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:37618 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752135AbeDQTAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 15:00:09 -0400
Received: by mail-qt0-f173.google.com with SMTP id w12so19875816qti.4
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fVVJxGUcHneRGwEcFwguj+eLkhQcZe3RWkjc5atn82E=;
        b=snryI2ImeI+XMWVXSzg5E3Sw9bxJyYR8rlE2N91zatHBFytfsMojUztHUoV67s061Z
         Jf1ossEuldTYywlvmc6c68UlHygw8/LXYcEcJrW340IxeCCj5eSRwPrtK/+7p4iMnETA
         7DNHCIpdJOZiD8DfmXQ3lE7GN7l92WgzZsa6R/hmuAEjTBMRKlOpiuuIkB9avjMcHUvK
         3ZxusU/UOr4UFIe6+IvYiR1n++BeR3UKOeURH1wtbDdLraAHiBoqoHDFFA65Khm1Pori
         sA6b8pDf/zpVHAGFd2PndSvbKndOuGqff/tNYZNua+lJokCjTD628++709j2iQrhb8WA
         VsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fVVJxGUcHneRGwEcFwguj+eLkhQcZe3RWkjc5atn82E=;
        b=WlawE0ZNaOW6YMnRg1LO7BWB4CBKWiFgAoyK6rp8EgfIni6iKuOdjuBM49v+w82TQW
         5bVTrFFEo5I66Uoj7J9i8tU6BhqniCqgq+KxeXFVmOE1ZoV7zFc5YnEimXnEjrtC5HVN
         26BNZfVi0ZMyrB7tBtd9SPn9HPGHWcX+JzjZpefFBym4i4q/qmHM8zdZnq2OXZz99ErJ
         uSmIZkqqDZ9PBOFGr+tUooQnkJ02DeCmn8ob9xnulAeV0/NPyhDVCGrCkaTVG/qpl+Vb
         rNPEDvpgw7b1afsaAulmntl0wBdqbzLrgA2CN/CKERQ/fCebqy8UKG0YP+g/tvW7VdPN
         3trw==
X-Gm-Message-State: ALQs6tAD76I0Rfz5/AooG3nemXUeRVnyUfnAC/NLB+W/4OX9yBFTcZqY
        qgFBAS56gw5BSJPsug0XJO4=
X-Google-Smtp-Source: AIpwx49nkWCPLM0F4VPSBuThupa84hIjfh+MYOaxRcD/s2bHxTfWCWZLcLKxViXj1Dhx/MWDNJSwTw==
X-Received: by 10.200.42.146 with SMTP id b18mr3361872qta.262.1523991608321;
        Tue, 17 Apr 2018 12:00:08 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id y6sm10608934qtn.56.2018.04.17.12.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Apr 2018 12:00:07 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] read-cache: teach refresh_cache_entry to take
 istate
To:     Jameson Miller <jamill@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180417163400.3875-3-jamill@microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <abb3ad34-94ff-4778-3e44-eaf1ccac1849@gmail.com>
Date:   Tue, 17 Apr 2018 15:00:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417163400.3875-3-jamill@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/17/2018 12:34 PM, Jameson Miller wrote:
> Refactoring dependencies of make_cache_entry to work on a specific

Refactoring/Refactor

It's helpful to refer to functions with parens i.e. make_cache_entry().

In addition, it appears you only needed to update refresh_cache_entry() 
so perhaps something like:


Refactor refresh_cache_entry() to work on a specific index, instead of 
implicitly using the_index. This is in preparation for making the 
make_cache_entry() function work on a specific index.


Also, be sure to certify your work by adding your "Signed-off-by: " line 
to each commit.  Details at:

https://github.com/git/git/blob/master/Documentation/SubmittingPatches


> index, instead of implicitly using the_index. This is in preparation
> for making the make_cache_entry function work on a specific index.
