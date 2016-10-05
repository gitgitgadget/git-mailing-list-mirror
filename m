Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 364091F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 13:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbcJEN7Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 09:59:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34308 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752164AbcJEN7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 09:59:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id b201so19568751wmb.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 06:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ptSFv8JQDSJXR01baksDqdLSCml+czXqEOdS3YeJIJE=;
        b=gCP3TDW3PyAu1HeEUjKytiS8QQ0GOqQLmyRk5Ha768kWefoLRU7dx5raxvgKPH91jH
         M/3hoCuV5tOV3dQfE/4c2eaHPkr/Ya0f81HmYGCGwx+eyVGOIFkchlHZkut4uPXiGNgK
         Uah/qMJbtJS1gWO9dbLDld3h3ptgz/a20vgy+GKvlLl4bYh9naOHTcSKQhtsw03TGiIz
         tnvszl/JZbuzyvNRNKuCo0nFtKbatBv48HFuAcDsRtP4u/81e1xomJDJGfDulqDctO9B
         Lc0HFZaj8SYviFMed3HOlpGrp+Rwjl38sH/GZdbl3cXCzVxIalHkgwBPRj60TA6sk3s/
         lAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=ptSFv8JQDSJXR01baksDqdLSCml+czXqEOdS3YeJIJE=;
        b=moaD2EOuSx35bRdAx+l05urmOkywoOwp8P7EUXeCCvbPnfUDnPhJHuNJa29Gn9AY+4
         bZdys11s8GMg4jcMZJFu7nEWPorcdg1ciPs7uDjoOxjGsWgO8yN/207cK+dlqpysyzXo
         ZTnii5pxKhXOAhPpyKbziMWDYr3hmaw2U7onkJ1ToZgaCt6AGzNmsjVeIC5IEX8azzTH
         0XxIefLUqTxsk5AcfE1dZpLPvmK5uQNo74ghZBRS8WhjDR22ral9C2Bcvs4yBYZu5/J0
         WSY8ezEEO3CtLrLwb4FUgoeSa9+hDD7pDteXWN5SIn8xgE/JJfwPCyUyDiBUkIyvi86b
         TVFA==
X-Gm-Message-State: AA6/9RkieKrgNp2WWQAFSMkYx7OBg/iSKSzG3TF6mQHvNM1Ncr2OJw5Ec3nbj9wd1PqiJw==
X-Received: by 10.194.250.106 with SMTP id zb10mr7471711wjc.99.1475675949425;
        Wed, 05 Oct 2016 06:59:09 -0700 (PDT)
Received: from [192.168.1.26] (acte13.neoplus.adsl.tpnet.pl. [83.11.58.13])
        by smtp.googlemail.com with ESMTPSA id ce6sm9152146wjc.27.2016.10.05.06.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 06:59:08 -0700 (PDT)
Subject: Re: [PATCH 06/18] t5613: clarify "too deep" recursion tests
To:     Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net>
 <CA+P7+xok5PoNKO+8R6zF9SXYfDq6BboDTDz9WZYEczs0pFK+pw@mail.gmail.com>
 <20161004134853.x3zq33ywyyzgbwsy@sigill.intra.peff.net>
 <CA+P7+xok-8vhikxkp+t8pu53YJAyUjZ0NiAwejEW2j3+eP_2Xw@mail.gmail.com>
 <20161004204933.ygfhoy24g6psyf6h@sigill.intra.peff.net>
 <CA+P7+xo3nxy1EOjDqHvKQuK128c=b73XN=6qqn6g6oRGh2VdFg@mail.gmail.com>
 <20161004205510.6bhisw7ixbgcvvwn@sigill.intra.peff.net>
 <CAGZ79kap2ndp=FK4YdqrL4tJ8_VDuuAcSCk1dtX5X2H3aaj6kQ@mail.gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Newsgroups: gmane.comp.version-control.git
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <2ea2f077-ab02-2631-4ce9-93cdd22c3c6b@gmail.com>
Date:   Wed, 5 Oct 2016 15:58:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kap2ndp=FK4YdqrL4tJ8_VDuuAcSCk1dtX5X2H3aaj6kQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 04.10.2016 o 22:58, Stefan Beller pisze:
> On Tue, Oct 4, 2016 at 1:55 PM, Jeff King <peff@peff.net> wrote:
>> On Tue, Oct 04, 2016 at 01:52:19PM -0700, Jacob Keller wrote:
>>
>>>>>>>> +# Note: These tests depend on the hard-coded value of 5 as "too deep". We start
>>>>>>>> +# the depth at 0 and count links, not repositories, so in a chain like:
>>>>>>>> +#
>>>>>>>> +#   A -> B -> C -> D -> E -> F -> G -> H
>>>>>>>> +#      0    1    2    3    4    5    6
>>>>>>>> +#

> 
> Input from a self-claimed design expert for ASCII art. ;)
> What about this?
> 
> #   A  -0->  B  -1->  C  -2->  ...

I would prefer the following:

#   A --> B --> C --> D --> E --> F --> G --> H
#      0     1     2     3     4     5     6

that is, the number below the middle of the arrow
(which could have been even longer)

#   A ---> B ---> C ---> D ---> E ---> F ---> G ---> H
#      0      1      2      3      4      5      6


Let's paint this bikeshed _plaid_ ;-))))
-- 
Jakub Narębski

