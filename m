Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22A720248
	for <e@80x24.org>; Mon, 15 Apr 2019 13:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfDONcK (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 09:32:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43614 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbfDONcK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 09:32:10 -0400
Received: by mail-qt1-f194.google.com with SMTP id v32so19005202qtc.10
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 06:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ppOKPFjC9YYFgmPd9L3NwXkstbZytHqJY7yQSYUvDdM=;
        b=dVVaPz1MM2lz+paGsJQg+2icSA+zgama9dJbh2gsUz+nN+b0NGKs4gFi6nLLg4gSmW
         8uQuV/1/pKyVrIkncvFg8F2NhFzJXlXBlTftgScA3aeOmTeiTsjjnGdGNKw9tiuUztyQ
         JwM06hle5VkVdVdKjfpiXzfKlSxiVxBi2PdSuGURYyu9hPNsuULaWb4lRUKRfaQDezLv
         xFvhyE1QVNJ0+PY/mgS3gs89LRSH1DEnvCKW1bJM7H5JdntHoSJa/BCT74KANePJHKUf
         TSypMzHesGm696gya1bzjRfbKqhj65j1phUP0cXADn7ny/rizducNO3LURzCAqCBjoA/
         0yXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ppOKPFjC9YYFgmPd9L3NwXkstbZytHqJY7yQSYUvDdM=;
        b=G202vAnQcLRvwPBrjmiDK8Q/ccDkt47rRYS+EpniT+U9MyJKlP7IP5ktUcONzzAFXL
         JdcZIXqqxy5Gnv+0X9Lp16xrO7VOrZGAPOtX5SzwAACHJ+3ktaF4z3hIqqPHEzEtbXoG
         A7OINpnA9gIHhHwOzusipTapclLjqT5olna4siifzbILPSkdbwq9ilqKtlRF956jZJzp
         NiQX4128ZqtqVdYYW6jDXbnoC6RBFoOFtnMR9/hmOC3va1Gt3DJz9gBSSfEIU7i/cpdj
         ezV5EfjjyHQlmAMBfZQCGH0MJyAIT06+wimD+Tq8gwwV/FA3FdjuK9Iyy3AiTdJfK43K
         P0HQ==
X-Gm-Message-State: APjAAAV46JzWlYkOhWqVp3qlAAzH/BvLUyr41yJQ8UCNz5j79cyNIUr9
        f1NxDvXtRrDCA9P8OBS7ztPfxQ==
X-Google-Smtp-Source: APXvYqz2+Q9NTQi5QqYypx+PIT8TlBO7kL/f3VM3Sr90cH9Rl5xd/qvgE4+jlG2BHCl3FZyO0Az7ug==
X-Received: by 2002:aed:3e9b:: with SMTP id n27mr59510374qtf.192.1555335128938;
        Mon, 15 Apr 2019 06:32:08 -0700 (PDT)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id w8sm27152786qki.54.2019.04.15.06.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 06:32:08 -0700 (PDT)
Subject: Re: [PATCH v6 1/6] Move init_skiplist() outside of fsck
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, David Kastrup <dak@gnu.org>,
        Jeff King <peff@peff.net>, Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Michael Platings <michael@platin.gs>
References: <20190410162409.117264-1-brho@google.com>
 <20190410162409.117264-2-brho@google.com>
 <877ec1fzqy.fsf@evledraar.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <a742dd62-c84e-1f85-0663-4a3aa4d14989@google.com>
Date:   Mon, 15 Apr 2019 09:32:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <877ec1fzqy.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/19 3:04 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Apr 10 2019, Barret Rhoden wrote:
> 
>> init_skiplist() took a file consisting of SHA-1s and comments and added
>> the objects to an oidset.  This functionality is useful for other
>> commands.
> 
> This change would be much easier to review if you led with a commit
> where you s/Invalid SHA-1/invalid object name/ (lower-case while we're
> at it), s/skip list/object name/ etc, and did that rename of the "hash"
> to "name" variable if you're so inclined.
> 
> Then you'd end up with a small refactoring change that changes the tests
> (or even just make the tests grep for e.g. "Could not open.*:
> does-not-exist" instead), and the moving of the function would be
> entirely caught by the rename detection.
> 

Can do.  I'll split this up in the next round.

Thanks,

Barret


