Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 318F11F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfH1PEN (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:04:13 -0400
Received: from mout.gmx.net ([212.227.17.20]:43733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbfH1PEN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:04:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567004644;
        bh=bt0QERkj/OGVFysZL+DAmAQrYtJ8Mw1pNPkky5cK2hA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Kb4kJbQXiqV+w/wSSTQLOEc4DkOTYruBSk+gzwaBUMylJy5OTcSKYc8WJlbgtHBh1
         agP6NaUhcVuAu7qe7F2sPdq4Nzt8taEws3X+qu01e4NfSXPxzbdcNuHd0mIcijmrCT
         mMGSYuTzAVEQZDu4J7su4nmOvlJevprJIg0OiICA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5QF-1hxE3g3rZ1-00F8Et; Wed, 28
 Aug 2019 17:04:04 +0200
Date:   Wed, 28 Aug 2019 17:04:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH 04/11] hashmap_entry: detect improper initialization
In-Reply-To: <xmqqa7bu2r01.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1908281703191.46@tvgsbejvaqbjf.bet>
References: <20190826024332.3403-1-e@80x24.org> <20190826024332.3403-5-e@80x24.org> <nycvar.QRO.7.76.6.1908271108410.46@tvgsbejvaqbjf.bet> <20190827094923.6qhwqosiucsi43td@whir> <xmqqa7bu2r01.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:C9FBEf/lLoUxkt6aJBtiOFWBsBBYwQASPSmda6pW0TY5fc+cugN
 w/HO+Um/9QNsKywiELXVEVCiA+4YEVr9ftbL0sBzgwohdNKzrBwjl/vVKJObqG2yQZi5HrJ
 FnmlyYEZXRWt8bl3KPqkHa47Zg36JptNI/OO7yokqcpJOl22vORB1nYHVL7rQDUxlue0CEe
 zIuad+79Dt8Gue7nftVhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LUTiatLt0jA=:X3UvGBXmvm6DwYZygezgWo
 +KkIkwMxUGNXNFgyNv5x1OZLZ9Zua7Oljlav5krVDrtM4jqIGJtuQtW1aiY/W3G2F6NPvGOvF
 TxPGr8qDzFHkQ+5NSovkU5K42D9QLfpa3ohkhr1GA5LsQjx20JzXKxN7Mb9s8JSBiiGT/dWa7
 hDso+GPKfRcEq9tYccw8MXkfD/ZuPQObSrxHxu+hbURYXFe7JdcSoUMJ1eAbaUNPxig/OfOOd
 oGxZFSqpxXkAOwsRJCoWt4xv3Nc4UaWavdSGf8NbbKw4nqJo0VXhyqeD1t5QDucVyLYbbLnfE
 60ndMKDKOx9SisQ4qd7CwRD29Hv/baBw7VXQCzuc1fazbSyvsLxEh2kGrK6Er46ySOw3BjJ9j
 aso3FB+iZudvIwoUi1FPm5Ghy1uAo3/rfKpskrXSlg8v1GEH6FWrSdqR1+Kz7boGNyJ1CTfSg
 bcbAEMX+dfQmEbxL1IcXvytj/RU4BWhBrltlF231Ph+hqvl6xkA8mFPnR83rp+y5SCMhbIcj0
 rEVWx+2BaN65tGof1JK45m1iKGqfz3AmE41lSyhW9kl/7i655ESAGTcv3fpQ9TZyP+b5puZbJ
 8zlXU/fxPFoDfUMeT8YCADAmzPAuz2WiejZsATcMelsnCxvF+l50scwUFlnq+qsx0+S9S7N+C
 gQQ9Y95Kmce10JIKnjYQh6WsRoU8Ye6YmyfYDOUcIQG4MzfDmjoRrQMuD/TWEQDtMV7WKoLm5
 UITdsVR1Uu0ZWqaAeWIXclITzGG7N2kp7g/8VGZnxdT6YSBxGKsq8z/UjtVQ3vG6Q0m4eWPQL
 MNyYgdha4wC0II/hb1XnVuD3y5Vd7GhdsaezYCXL80NRXPkZjcqUr5J4UCn6nMf/pc+Zpc2Ne
 1+0A7y4bPLeY/EZy5rHbJVhuKZpY3gfMkJP88S0+N2FOgF3dtsqB2MSRTnSvXne8V8TiJQm9Z
 3O8mOwdDbEn3k06GJhuPreMyrMPoLxAh5AikINQYdyPJy3ERLIQblFB9S7MSp90W1RH/In5H2
 C4Yn3nzA5ihbQP+nFXsCvty5F31KDHh7R6K/1AeCXNhHZLQcqYxvWiMQc8t5jVjT1dv8zQnYu
 1P2Mi4vQzfFJWr3jU30/Hiqt4+Aa2871Kx0qjM2nS3AV72bz3GZjC7FJhI1m3FxM0Xsa+R5f8
 w9JWS7BxZpFjzn4opwfOUkm0cuNMiQtjbDALEq1Bd/E5NpLvgXosx+KTwIMn43FiBTgSA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 27 Aug 2019, Junio C Hamano wrote:

> My plan is to have ew/hashmap topic for a few days while ejecting
> the js/add-i topic which semantically conflicts with the changed way
> hashmaps ought to be used temporarily, and when I have enough time
> and concentration, try to see if I can come up with a good semantic
> conflict resolution that I can keep reusing (aka refs/merge-fix/).
> If it happens, we'll see both topics, and if it doesn't, I'll then
> drop ew/hashmap and queue js/add-i and rinse and repeat from there
> ;-)

FWIW I crafted my latest iteration such that you would only need to do
the `hash` => `_hash` rename in one line to merge `js/builtin-add-i`.

Ciao,
Dscho
