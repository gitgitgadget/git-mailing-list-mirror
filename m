Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B416B1F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 20:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933949AbcJQUsb (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 16:48:31 -0400
Received: from mout.web.de ([212.227.15.3]:58552 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932221AbcJQUsa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 16:48:30 -0400
Received: from [192.168.178.36] ([79.197.211.11]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0McFcd-1cD5QK2fyh-00JYAv; Mon, 17 Oct 2016 22:48:11
 +0200
Subject: Re: [PATCH] convert: mark a file-local symbol static
To:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com>
 <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com>
 <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com>
 <B7662EA0-3181-413E-A40B-69C88FC46F96@gmail.com>
 <5a9a1c44-8a3f-1894-c4c5-8f1fa96b63b9@ramsayjones.plus.com>
 <20161017021825.jgpsew7qqfjrirhw@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610171058580.197091@virtualbox>
 <20161017093754.wah5d6cg4qgtw7ln@sigill.intra.peff.net>
 <16298e68-c0f9-b7ff-d4b5-0d4b79306377@ramsayjones.plus.com>
 <xmqqmvi2u4c0.fsf@gitster.mtv.corp.google.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d23ead12-1f63-d598-fe97-80c121de1c29@web.de>
Date:   Mon, 17 Oct 2016 22:48:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqmvi2u4c0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kkAfk06Cy4HNd064DfmwAbW10N7oznHI9mnHpW7s4Ah85pHe8Dp
 uNwtLQ68gJFHU6ES2H9/tsl+kpFMGB72a0BimBPij5h1eSHI//2r0uOdp8rOg4FjreUnQIH
 3ILJK1NsIxYBulxA477FbpFP9dRrK/xF8Lf59Z1ORIUyIwzbibSnJZEFlqP3p+TG1SwmI19
 9qaBWFC5nukO5+qw8fprw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l6fkyNgV3Nw=:iJuxIR2qfr+JQ6H/zJXvsn
 31dgm3bfT3mVVnoh4dHM0CWMAE/q0ingqJfRHdvWkV0nvBe3lGwQH4nY7ZQyngLWCTuZEMnOU
 d/HcLm1KQz0gBWHICa/55sTe7xRobiAJzGi4WdclmxQqrj7f+WJhCtaP7Zb1KSl65LsQoEdRg
 nlSSoNTjyoa35xIrx8LYl+GaG/kQ7B/QxjTetZ0o2nQbAgN6v9TaxG3U2t52xXKCyNtKtupFi
 JS3YU80RuaCDUSxxprs2gNEmp4Mh3H8GZS0N7EsV2O5G5Y3mh4s5Mvaiwcj1e6701HGyA9V3/
 NQTBscXpR8Wy/nD4Y2K8n5sEsOhymlcyvYXnwsFb08zEfYRmB4kBPbFz1BGLglMV4MVHA3mLu
 qMME1obKz6piUUC5/DvXWNSUZvDe/tsdGAk+BsWXVCIB13Rr6YmH/LHPcu3hSXUXH7OT+T7W4
 Nyt0slHNQ5BDdzJ33bQ4Yxo9rrQhw5fHXJGfEyk2+B7SnBH5g7UVszSXDC+3ik5yyFJMIxfxY
 6Fz7WnBzZLjIpjkFn6TbjJej6qBLb6fbclIQB6MEGsfN3UeIM8HwWdqJDnlkCD6rP0YRocjpp
 Ci9FcijuaXwnxUk0kSNXbO9HLzGEyrKg1oH/ug+TP4wLT0rzxWT7skUsnKZXnl49+EQXLSJWq
 8reNJ1E9oQ42GLGR67tgxlqjVDRf8cvhHJTymm8uzooORFsItkHg5cJn7jkTWDuFyRGwKiV2h
 MFs/6wXN55F5uy/SlNN2wljuI817DHNtoZKr3BgsjJLVEaewzypJUyilYcR8ZtxyVGdwdAhp7
 gSxZKdZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.10.2016 um 22:07 schrieb Junio C Hamano:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
>> Heh, I actually have the following in my config.mak already:
>>
>> extra-clean: clean
>> 	find . -iname '*.o' -exec rm {} \;
>>
>> But for some reason I _always_ type 'make clean' and then, to top
>> it off, I _always_ type the 'find' command by hand (I have no idea
>> why) :-D
>
> "git clean -x" anybody?

This removes config.mak as well.

René


