Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C63A92090B
	for <e@80x24.org>; Mon, 18 Sep 2017 12:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754465AbdIRMRP (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Sep 2017 08:17:15 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3867 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752502AbdIRMRM (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 18 Sep 2017 08:17:12 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8ICES14020522;
        Mon, 18 Sep 2017 14:16:39 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2d20x03a1a-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Sep 2017 14:16:39 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D86D34;
        Mon, 18 Sep 2017 12:16:37 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6438B26B0;
        Mon, 18 Sep 2017 12:16:37 +0000 (GMT)
Received: from [10.137.2.67] (10.75.127.44) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1178.4; Mon, 18 Sep
 2017 14:16:36 +0200
Subject: Re: RFC v3: Another proposed hash function transition plan
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170307001709.GC26789@aiede.mtv.corp.google.com>
 <xmqqa828733s.fsf@gitster.mtv.corp.google.com>
 <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com>
 <alpine.DEB.2.21.1.1709131340030.4132@virtualbox>
 <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com>
 <CA+55aFwUn0KibpDQK2ZrxzXKOk8-aAub2nJZQqKCpq1ddhDcMQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Keccak Team <keccak@noekeon.org>
From:   Gilles Van Assche <gilles.vanassche@st.com>
X-Enigmail-Draft-Status: N1110
Message-ID: <59BFB95D.1030903@st.com>
Date:   Mon, 18 Sep 2017 14:17:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1709142037490.4132@virtualbox>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG3NODE3.st.com (10.75.127.9) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-09-18_03:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

> SHA-256 got much more cryptanalysis than SHA3-256 […].

I do not think this is true. Keccak/SHA-3 actually got (and is still
getting) a lot of cryptanalysis, with papers published at renowned
crypto conferences [1].

Keccak/SHA-3 is recognized to have a significant safety margin. E.g.,
one can cut the number of rounds in half (as in Keyak or KangarooTwelve)
and still get a very strong function. I don't think we could say the
same for SHA-256 or SHA-512…

Kind regards,
Gilles, for the Keccak team

[1] https://keccak.team/third_party.html

