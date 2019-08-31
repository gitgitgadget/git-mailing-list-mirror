Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E1EF1F461
	for <e@80x24.org>; Sat, 31 Aug 2019 13:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbfHaNca (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Aug 2019 09:32:30 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:31598 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfHaNc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Aug 2019 09:32:29 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i43UR-0000L3-Bt; Sat, 31 Aug 2019 14:32:28 +0100
Subject: Re: How to track history of personal changes in a repository?
To:     Elijah Newren <newren@gmail.com>,
        Matthew McClure <matt@continuousdelta.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CAEV-cEryZZarfz5SQsRphBXeYMPJW7tdSfY8NYnzb_-ra-pGHw@mail.gmail.com>
 <CABPp-BE0ij8zF22xbvjbcq3vG-VwWjUmjNo45Lsm0BEnH=iZ-A@mail.gmail.com>
 <CAEV-cEp19ehfBwHxh7OGsvTxTchNJLSRZGZXqAsDjyQg-W3rFA@mail.gmail.com>
 <CABPp-BEWn1wHdxWM8cVqmvzYo8HDdUzuh4G-XTN51o8JdvkrCw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <2737a9f3-769d-5dc7-ca4e-ef4dbdde70f6@iee.email>
Date:   Sat, 31 Aug 2019 14:32:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEWn1wHdxWM8cVqmvzYo8HDdUzuh4G-XTN51o8JdvkrCw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah, Matt

On 30/08/2019 16:21, Elijah Newren wrote:
> * If the changes are to files that are tracked, AND you aren't making
> changes to those same files that do need to be committed and pushed,
> use the assume-unchanged bit (see git-update-index(1)).
Not sure I parsed that well but...

The `assume-unchanged bit` is commonly miss-construed as a promise by 
Git that it will ignore changes to the file.

That is incorrect. The bit is a promise by the _user_ that they won't 
change the file, so that, in general Git stops checking for updates to 
the file.
However it will check for updates sometimes, leading to unexpected 
effects if the user has the wrong mental model, thinking that Git would 
ignore their changes...

Philip
