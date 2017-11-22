Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4351C20954
	for <e@80x24.org>; Wed, 22 Nov 2017 15:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbdKVPhN (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 10:37:13 -0500
Received: from mail-pf0-f177.google.com ([209.85.192.177]:44191 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbdKVPhM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 10:37:12 -0500
Received: by mail-pf0-f177.google.com with SMTP id r14so5707536pfl.11
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 07:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=neulinger-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=szJA6dDh0nklGlRyBoqBLBuX907ZmnBzWK08NJ6pD8g=;
        b=rd4PWJkpQafCh+UKGV5tOAqbajS6Br7Ql0zR8BGk7QUEP/Zg0MF7x4xugPYIqqkJgf
         nRFUKCp9TNgQVNRWuIyeELM5bhw33TtHs3Ae8kAlWjsd2si/N9cA1duQPiL6e7cP85Oe
         +fQwaQNIPvRQivo5JwLiWzlWpIH4YH5ZnFRKOnbig2/PC8V87w7RrNuzeUJJwuKWZB97
         A/k9ZLp8CNFvDwv/4iRlI7WIIknWlaMLDdknWjUZscuHVx2p+uU1sd9J11bkHFy6T7cT
         z9XKrZLXnOi2rleMHr9/n+L/YlV/ElxVZAlz5tiYZhEyCh1Tmm6/SLs3MsP0EiN5cR8Y
         +jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=szJA6dDh0nklGlRyBoqBLBuX907ZmnBzWK08NJ6pD8g=;
        b=RNpGY1846xRkJ8LF3cmfqclp7AEo5rMflEatx/ZOkalaAYRJBrt6+yoYyz9lVdB/tz
         8qEYlWbWhNFgzzovpwnfBxPFZH3HdYUrX1U2J+v4zKoMlhDtWC5Cy6Db6THU3jRiFc2f
         4VZAnenzd7hw88DoWA/4R3q0Rg0W4nk3MqJki2TwQG+aAZbwbhbTlBxoOx2YiJ2OHHH0
         29iu+LLhyrmRUhH1sGihkk8W5wv9p7TvaiwBsc6BzUvn2hY798OlRY8Sy6AIvmY2UzRc
         wxv+pCjQeGfQyKcWfjGTBDll9Q1P0mMPUOthAv6xrVyITirWkHbtspfA1iCQOctnsKSY
         09Wg==
X-Gm-Message-State: AJaThX5N7LjyTU2Ho/Dgm8BG7vyzhFid/etedDItbV7TFMzYuuDrCqTC
        iXhfnXYAI4Xp6vkBuh7QrBfEEMcY
X-Google-Smtp-Source: AGs4zMbNwUFgS482AZOy85iQpSn+tBEbGsEdNTTWHa1MR0qqsJai0z1Odgv/dViLvR337QBVPc9KYA==
X-Received: by 10.98.213.71 with SMTP id d68mr18274525pfg.171.1511365031466;
        Wed, 22 Nov 2017 07:37:11 -0800 (PST)
Received: from infinity.srv.mst.edu (infinity.srv.mst.edu. [131.151.93.93])
        by smtp.gmail.com with ESMTPSA id l24sm15854098pgu.38.2017.11.22.07.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2017 07:37:10 -0800 (PST)
Subject: Re: git status always modifies index?
To:     Santiago Torres <santiago@nyu.edu>
Cc:     git@vger.kernel.org
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
 <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
From:   Nathan Neulinger <nneul@neulinger.org>
Organization: Neulinger Consulting
Message-ID: <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
Date:   Wed, 22 Nov 2017 09:37:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:57.0) Gecko/20100101
 Thunderbird/57.0
MIME-Version: 1.0
In-Reply-To: <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

What I'm meaning is - why does it need to write the index back out to disk?

 From looking at the code in builtin/commit.c it looks like it takes a lock on the index, collects the status, and then 
unconditionally rewrites the index file.

I'm proposing that the update_index_if_able call not actually be issued if it would result in a ownership change on the 
underlying file - such as a simple case of root user or other privileged account issuing 'git status' in a directory.


I understand completely that it would be expected to be altered if the privileged user did a commit/add or any other 
operation that was inherently a 'write' operation, but doesn't seem like status should be one of those cases.

-- Nathan

On 11/22/17 9:30 AM, Santiago Torres wrote:
> Hi Nathan.
> 
> Do you mean git-status writing an index file? What would you suggest for
> git-status to compute which files have changed without modifying an
> index-file? Or are you suggesting git-status to fail if the index file
> doesn't belong to the user-id who invoked the command...
> 
> Thanks,
> -Santiago
> 

-- 
------------------------------------------------------------
Nathan Neulinger                       nneul@neulinger.org
Neulinger Consulting                   (573) 612-1412
