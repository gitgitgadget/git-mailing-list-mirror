Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F05E1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 12:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbeJQUhA (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 16:37:00 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34245 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeJQUhA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 16:37:00 -0400
Received: by mail-ua1-f66.google.com with SMTP id k4so4690919uao.1
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 05:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dcMzhgx+1UpiEwpVs+jL1WktD/7agoi2+h3ZCjJpggg=;
        b=UIURuE3gaDJN2Eu7PkJxJp6GRbP2YAnBoqidKEdrgjXVWVV/2cgzHQcS11GXGmzxH2
         EY2fLTYY+pZYpJsWfOoIoXgRMFp1tdYfsCfXe2MTcXXWQO2ZdE4CQu+QS0n1E9BplYOg
         M64jcxhP6H53AYFttZPMYP8nAm7wfjciXu/aE4LCBV8H6MBEBLFF+/DPZQUB8vNoVVII
         niallVUXON0JgOWYiPc1jqlFjIw244zz3ZMDTRuCnhpJBSSyltV5TJZyWBEgRBaDFa+K
         IAbMjCQDx8PX9l+gig/1JB/R/haIka/roUMb1sEgLn1spIPy4AQ1z9xhtZQO/O5ffVQ5
         V8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dcMzhgx+1UpiEwpVs+jL1WktD/7agoi2+h3ZCjJpggg=;
        b=Vlbecbkuulqe1mhaTKQQnoNaTkHp52DnIzlP+o/vur7ny8jZK9lACWzrdUaOhgzFvh
         d7G6uPdOxzMPIAAp+YX1CvnS/Eg/dFDTGH+eZWyO4ew75u9j28vUPbdu1GTX+MiBlmeh
         VhyBkSJlRFlZ+yGi8N0/bg38JP569jTAP+c3Vmc/82xacSxpZmx+G3Cai2AzcQ2ZgfQu
         d/9dRyneFaTLI4lhNNLFC5YagFjvUksIWKd9v1PJg1DrA9T2SqVUMO1VNZQvNG2AifKt
         nt6NJaqLXrXqqKOZWHrx9IQi0+6OTRgSS8/ZkZAxrlX88/oyRyMv8QPR43nzZ2u3O5sE
         PmDQ==
X-Gm-Message-State: ABuFfohGaTspvHd+YlhMVe4xJOYtYh9QQSh0cW3ErO7UggnwzbOjlgvV
        220KANW1FOdZpyDN8+G37hhJ7Gtu
X-Google-Smtp-Source: ACcGV62zAbA0oIVFvIu+s1qd8WwkgkiK49NsI0m4/VfRdPHFNBjUK00PADYuiNRJZhFJNPHpcaBKlQ==
X-Received: by 2002:ab0:433:: with SMTP id 48mr10564142uav.22.1539780087462;
        Wed, 17 Oct 2018 05:41:27 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8586:348a:8c9:d17b? ([2001:4898:8010:0:6ebc:348a:8c9:d17b])
        by smtp.gmail.com with ESMTPSA id v85-v6sm3556483vkd.18.2018.10.17.05.41.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 05:41:26 -0700 (PDT)
Subject: Re: [PATCH 00/19] Bring more repository handles into our code base
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Cc:     jonathantanmy@google.com
References: <20181016233550.251311-1-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <feef12c7-e609-dc6e-104d-7381471afb9c@gmail.com>
Date:   Wed, 17 Oct 2018 08:41:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181016233550.251311-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16/2018 7:35 PM, Stefan Beller wrote:
>              
>      This series takes another approach as it doesn't change the signature of
>      functions, but introduces new functions that can deal with arbitrary
>      repositories, keeping the old function signature around using a shallow wrapper.
I think this is a good direction, and the changes look good to me.

>      Additionally each patch adds a semantic patch, that would port from the old to
>      the new function. These semantic patches are all applied in the very last patch,
>      but we could omit applying the last patch if it causes too many merge conflicts
>      and trickl in the semantic patches over time when there are no merge conflicts.

The semantic patches are a good idea. At some point in the future, we 
can submit a series that applies the patches to any leftover calls and 
removes the old callers. We can hopefully rely on review (and the 
semantic patches warning that there is work to do) to prevent new 
callers from being introduced in future topics. That doesn't count 
topics that come around while this one isn't merged down.

I had one high-level question: How are we testing that these "arbitrary 
repository" changes are safe? I just remember the issue we had with the 
commit-graph code relying on arbitrary repositories, but then adding a 
reference to the replace objects broke the code (because replace-objects 
wasn't using arbitrary repos correctly, but the commit-graph was tested 
with arbitrary repositories using "test-tool repository"). It would be 
nice to introduce more method calls in t/helper/test-repository.c that 
help us know these are safe conversions. Otherwise, we are essentially 
waiting until we try to take submodule things in-process and find out 
what breaks. As we discovered with the refstore, we can't just ensure 
that all references to the_repository are removed.

Thanks,
-Stolee
