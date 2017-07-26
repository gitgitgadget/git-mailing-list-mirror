Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66E932047F
	for <e@80x24.org>; Wed, 26 Jul 2017 15:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdGZPG0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 11:06:26 -0400
Received: from fallback9.m.smailru.net ([94.100.178.49]:39532 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750893AbdGZPGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 11:06:25 -0400
X-Greylist: delayed 3494 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jul 2017 11:06:25 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=gCHU2oI67cAHwGv5CEauOISXkAkR7C5xyNNTix2lMsI=;
        b=CSH9neseFslDFhlggJ5km4Tph5URai1yFMnKEOBAkcjGgsx/TjcvZ2PeEro8u8vk2sEEzimJ1TXi/Cila7lLSNikGvcLbwCdrR/F8qoHcDKkwfZy8OYLRmdmQTL38Jy3vpACrVqWq6n+Y+tIR48fhZjOuTC9ZL+JhdNJBYW4h1A=;
Received: from [10.161.29.31] (port=37168 helo=smtp10.mail.ru)
        by fallback9.m.smailru.net with esmtp (envelope-from <stsp@list.ru>)
        id 1daMyt-0002Yb-Oy; Wed, 26 Jul 2017 17:08:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=list.ru; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=gCHU2oI67cAHwGv5CEauOISXkAkR7C5xyNNTix2lMsI=;
        b=CSH9neseFslDFhlggJ5km4Tph5URai1yFMnKEOBAkcjGgsx/TjcvZ2PeEro8u8vk2sEEzimJ1TXi/Cila7lLSNikGvcLbwCdrR/F8qoHcDKkwfZy8OYLRmdmQTL38Jy3vpACrVqWq6n+Y+tIR48fhZjOuTC9ZL+JhdNJBYW4h1A=;
Received: by smtp10.mail.ru with esmtpa (envelope-from <stsp@list.ru>)
        id 1daMyr-0001KJ-F8; Wed, 26 Jul 2017 17:08:05 +0300
Subject: Re: git gc seems to break --symbolic-full-name
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
References: <234492d7-7fd6-f847-8b85-010732ff43b6@list.ru>
 <xmqqbmodhb5h.fsf@gitster.mtv.corp.google.com>
 <223fa7c7-196d-e4fe-85b5-7d7cc576aa52@list.ru>
 <CA+P7+xrhLf9eS_KkxTmWZgQ+Ho8VN83GS-OvxmboZ=_iY4dY0g@mail.gmail.com>
 <ed1ddfec-5782-d14b-6717-a1532efc0138@list.ru>
 <CA+P7+xock9gpYVtxj2n6L5Y9dO1VV01OEOT5i0MR7ay68yS+WQ@mail.gmail.com>
 <a6738cae-ad8d-cf51-0fbb-428cf0f88703@list.ru>
 <20170726132322.4cfj73tynrko264o@sigill.intra.peff.net>
From:   Stas Sergeev <stsp@list.ru>
Message-ID: <5b86f0e2-b44f-a3ea-bb66-c7826619773b@list.ru>
Date:   Wed, 26 Jul 2017 17:08:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170726132322.4cfj73tynrko264o@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-MW
X-7FA49CB5: 0D63561A33F958A54AD4E8EEFC3DE8A860ECCB9AF2D3C32149D0934BFA5585B5725E5C173C3A84C39472471D10B198B949CD37B04FA45A59A3CCBC2573AEBDE1C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F41B67924A99884D73B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: F1845AB6CCC9920DF7838D61D4D05C42C65248277218CF1C947F3BBC46CE35C5E23BA72BC693BAAB1653177920737CA72999BEE114A20FF4278B2D54D4112F244F0A872F021F905956A8FB0C6EBA5FCCEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: OK
X-7FA49CB5: 0D63561A33F958A5158CE34CBEB7DF13E1BE90109725F5083A25A265ABBF80B8462275124DF8B9C938130EB80001CEACE5BFE6E7EFDEDCD789D4C264860C145E
X-Mailru-Sender: A5480F10D64C90052575E382D1FF78560CDE0412633BB99940CC4A6F3FC69C0CCF113DD4F50517E8BD9A213A94BF4775DDBB79867CC2C1EC5DD9ADBE8243F6ED0252A3EF2865ED2F733E9BFD465368085FEEDEB644C299C0ED14614B50AE0675
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

26.07.2017 16:23, Jeff King пишет:
> In git.git we do something like:
>
> -- >8 --
> other: version
> 	cat $< >$@
>
> .PHONY: FORCE
> version: FORCE
> 	@git rev-parse HEAD >$@+
> 	@if cmp $@+ $@ >/dev/null 2>&1; then rm $@+; else mv $@+ $@; fi
> -- >8 --
Yes, thats a nice recipe that I would be using
if not for the fact that I already switched to
"touch", which requires 1 fewer tmp file and
no comparison.
But I'll keep this in mind if something wrong
happens with my current solution, thanks!
I wonder if git can provide some helper script
for other projects to solve this in a same way.
