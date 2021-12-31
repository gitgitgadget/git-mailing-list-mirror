Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928A0C433FE
	for <git@archiver.kernel.org>; Fri, 31 Dec 2021 17:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhLaRQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Dec 2021 12:16:46 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:24487 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhLaRQp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Dec 2021 12:16:45 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1n3LWF-0002tl-5r; Fri, 31 Dec 2021 17:16:43 +0000
Message-ID: <9b13b1d1-8e0f-b5c9-ad66-7a0e63eb0b13@iee.email>
Date:   Fri, 31 Dec 2021 17:16:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: bug: git name-rev --stdin --no-undefined on detached head
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>, John Cai <jcai@gitlab.com>
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
References: <CA+JQ7M-ORVCj6teGjVy01SF=f0=PdKKYdHNU9ruK9XUAX9F8Ag@mail.gmail.com>
 <DA9B4728-C45D-4CA0-A40D-4A81665AB0E6@gitlab.com>
 <xmqqk0ft3i3g.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqk0ft3i3g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks you for the example..

On 24/12/2021 19:42, Junio C Hamano wrote:
> * The sample input was produced with
>
>         $ cat >sample.txt <<EOF
>         A revision that exists $(git rev-parse --short HEAD) is shown here,
>         and its full name is $(git rev-parse HEAD)
>         while its tree object is $(git rev-parse HEAD:)
>         which probably is undescribable hexdigits.
>         EOF
>
> if you want to try it at home ;-)

The ` $(git rev-parse HEAD:) ` technique is serendipitous. 

I'd forgotten that was how to get the commit object's tree  for further
investigation, as I'd need it for my `deadhead` query [1], as used
regularly in the Git-for-Windows merging-rebase (see also [2]).

Philip
[1]
https://lore.kernel.org/git/be7ec330-2b2c-a01f-c7ca-e5e752493ee0@iee.email/
[2]
https://lore.kernel.org/git/nycvar.QRO.7.76.6.2112101528200.90@tvgsbejvaqbjf.bet/
