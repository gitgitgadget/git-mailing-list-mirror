Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 447AB20756
	for <e@80x24.org>; Fri, 20 Jan 2017 20:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753849AbdATUvk (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 15:51:40 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33724 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753418AbdATUvG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 15:51:06 -0500
Received: by mail-wm0-f65.google.com with SMTP id r144so9532161wme.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 12:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=e93lHOzBnne6DMiRAGWoIhHARYibwI19jbFzPNMvGCk=;
        b=qdTWkmdhFHAN/13YdNxmZLXUNvq+B85UsexynBnAT1tveD68sh0R0pO3OQyDRpi0cI
         j17rKCeQRxquVl/Lo2sHTTDREmqnLTw9RCky6m7Fw9feDB24KtNRAFFjt6H9kpUrK1o3
         q32wHnoJMCAs6V7VDlIza5H7BVpuktpV9WZI1rJphUA0KNUQyqF/nIsJLjSqo/Hp1Irc
         Gfu+1NCTieHOl7d5lNu+v+CRBPh0WLxz/7DqPKzwyHBQx1mjP1NFCBFqoRs0GrHQOVB5
         RLQMQSuQRH8J4jmjcAXpuebbbWCqA6a9RrpCyxum51mfx2DA8nc5ztNSAg0wvxHq0+1/
         QGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=e93lHOzBnne6DMiRAGWoIhHARYibwI19jbFzPNMvGCk=;
        b=n7kdyPJdRK7qtgDe7GdGJvGZVNRXiH1ojTIII6B3eGUmjulSkoGM9arhqab1JPfZQa
         lyZ42FDLSEAW+PJ76skLglB4DGRaNvg+UGlK4aulJHRizRYdg+Xn+oF6mvs9aTj3Uznr
         RHjuMwqwN6q+R20jHQbri7kw4QNtS+d25YKk9m7xj85NrwJ4TZd2ClCxwtRDDGdLsNfD
         aH190WSnpigcBC0Z2UwikJL7UJWh4ZG3DCjYXkLUIRx1yDq3RVpNY8EtldjpQaNWDu1S
         cR7Jpkn8f32ADnCQs4tLFIvVjsE9PLgluvFnxkJJYjsjohaerSHqc+3VPnbhvkQ/sXCD
         ZgxA==
X-Gm-Message-State: AIkVDXLM6HEZj+OTudCcLdToBx9O9GKNB+cV73fwLSEpgcOMlG/UXxxIDkYU8UHB8TjP1A==
X-Received: by 10.28.181.145 with SMTP id e139mr4552774wmf.127.1484945464604;
        Fri, 20 Jan 2017 12:51:04 -0800 (PST)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id c9sm7812558wmi.16.2017.01.20.12.51.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jan 2017 12:51:04 -0800 (PST)
Subject: Re: [PATCH] show-ref: Allow --head to work with --verify
To:     Junio C Hamano <gitster@pobox.com>
References: <20170120155015.4360-1-git@thecybershadow.net>
 <xmqqa8aly2o4.fsf@gitster.mtv.corp.google.com>
 <1bf9a446-0b00-f27a-4625-0bc8c25356fe@gmail.com>
Cc:     git@vger.kernel.org
From:   Vladimir Panteleev <thecybershadow@gmail.com>
Message-ID: <cf40c3e4-406d-f39f-ab72-812a88115100@gmail.com>
Date:   Fri, 20 Jan 2017 20:51:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <1bf9a446-0b00-f27a-4625-0bc8c25356fe@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And to clarify:

On 2017-01-20 20:26, Vladimir Panteleev wrote:
> On 2017-01-20 19:03, Junio C Hamano wrote:
>> Having said all that, using --verify on HEAD does not make much
>> sense, because if HEAD is missing in .git/, I do not think Git
>> considers that directory as a Git repository to begin with.

The behavior of --verify I am interested in is not to check that the ref 
exists, but to get its SHA1 while avoiding the pattern search. This 
avoids accidentally matching refs via substring (e.g. "git show-ref 
--head HEAD" will print HEAD, but also e.g. refs/remotes/origin/HEAD), 
and for performance reasons (looking up a ref by exact name can be MUCH 
faster than matching all refs by pattern search, e.g. in one of my 
projects where I use git as an object store, --verify makes a difference 
of 21 milliseconds vs. over 5 minutes).

-- 
Best regards,
  Vladimir
