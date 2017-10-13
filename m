Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD3A620437
	for <e@80x24.org>; Fri, 13 Oct 2017 12:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbdJMMUP (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 08:20:15 -0400
Received: from forward102j.mail.yandex.net ([5.45.198.243]:54874 "EHLO
        forward102j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753258AbdJMMUO (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Oct 2017 08:20:14 -0400
X-Greylist: delayed 448 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Oct 2017 08:20:14 EDT
Received: from mxback20j.mail.yandex.net (mxback20j.mail.yandex.net [IPv6:2a02:6b8:0:1619::114])
        by forward102j.mail.yandex.net (Yandex) with ESMTP id 039DF560498B;
        Fri, 13 Oct 2017 15:12:45 +0300 (MSK)
Received: from smtp4p.mail.yandex.net (smtp4p.mail.yandex.net [2a02:6b8:0:1402::15:6])
        by mxback20j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id gdb66tTR8q-Ci04VSmp;
        Fri, 13 Oct 2017 15:12:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1507896765;
        bh=g9g9MgzsvwWhFEgSoEF9L9DSjC8Yrhlw5BDyBGqjcoU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=IhBX8nFcQ6X3AuaXsueB1D7sod2S+usrboWSDCRfaRdaJg/LgKJprngPacmT+k8td
         Ok1j1F7D0UdcLoMSTIaDChQue/5uG3u3oVE2KpupgtlI4SnhZ8Pb1rD9QP9koKpfEL
         97UyD3xhLFptU2/aMcjow+JN3VqpwiDyGBXLdiUE=
Received: by smtp4p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id xr7MgVI6lR-Ch8apAET;
        Fri, 13 Oct 2017 15:12:43 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1507896763;
        bh=g9g9MgzsvwWhFEgSoEF9L9DSjC8Yrhlw5BDyBGqjcoU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To;
        b=pHmu8sTxtdt4Nj2x3qm9ALiYkv73UCzZEsSmNXytgh5h7SBZZVXGcCuBoQZYqDIZc
         UdTeMdJJAtXyJuSUewCuWFChuOvKYZifNmUtQP5RSZ24/KzNOKS/FvpGRupn6ZaN4J
         vpBTagsBwm8e3yUc6ux401nsyGnKgqOIMmMzdTv4=
Authentication-Results: smtp4p.mail.yandex.net; dkim=pass header.i=@yandex.ru
Subject: Re: git-clone causes out of memory
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, git <git@vger.kernel.org>
References: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru>
 <20171013100603.5eed26sjjigph2il@glandium.org>
 <CAP8UFD1KuBdUCo=x_q4__s1kW15CWMH1jJkKzXqmf3=T3jcrng@mail.gmail.com>
 <20171013103722.rvr7536mu2hoo4wb@glandium.org>
 <CAP8UFD3vniWZQ9Wb1oMo-bbj8n7CTjTHUNhBRwg6jN9x0+ApAQ@mail.gmail.com>
 <xmqqr2u7uuc8.fsf@gitster.mtv.corp.google.com>
From:   Constantine <hi-angel@yandex.ru>
Message-ID: <2f9b8856-dacc-768d-32c2-985f5f145ba7@yandex.ru>
Date:   Fri, 13 Oct 2017 15:12:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqr2u7uuc8.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13.10.2017 15:04, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
>> Yeah, but perhaps Git could be smarter when rev-listing too and avoid
>> processing files or directories it has already seen?
> 
> Aren't you suggesting to optimize for a wrong case?
> 

Anything that is possible with a software should be considered as a 
possible usecase. It's in fact a DoS attack. Imagine there's a server 
that using git to process something, and now there's a way to knock down 
this server. It's also bad from a promotional stand point.
