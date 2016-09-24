Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F93C1F935
	for <e@80x24.org>; Sat, 24 Sep 2016 21:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935081AbcIXVWp (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 17:22:45 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35324 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754610AbcIXVWo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 17:22:44 -0400
Received: by mail-wm0-f65.google.com with SMTP id 133so8127059wmq.2
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 14:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=PRK7AAz5e7eE9SIpVwht+HyRij+FLTOQvIAqGD/BGi0=;
        b=x/gTOsE0d64XbHYX2+xzEyec3qVIGKokx5oGz+44wrkgj+8pHKxlWp5LZMxkC+/qlx
         p0TGPa2RmIA+4sYUjURZ6PmuqVMl9JXrFXLJfzv+dw/Rw/1FgAAk7ptuZamNexUDUJbI
         VsmOadfwG8I+u3deqjGHxjkiO4RIye6jpTae7UdEbFaO+iAbLjFNMvlug2E/jmIUUCyk
         QdDsHKaznNgYFB+LU6NXi0r4+JF0mz0S109tK/DJFsAdnp4j4JLT5nx7skReKbRPC80A
         EyCY3VHIUn9S3WisjeOcS3R2/q/EB9a7D9PrugbuOiJIooXfYNLhvMZkcnSrpq2J0cZx
         B1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=PRK7AAz5e7eE9SIpVwht+HyRij+FLTOQvIAqGD/BGi0=;
        b=QaAdXkh1TNN2aihagtBiN6j1R45gVUJh38ZD0q6i4JYY9iSl+i9TXdFJABQX5hyIkU
         0MIqhpIP7m1dD6LAvB0end/Yxak11O4ksBoMtHLo0cP0FEcw8+6n2YYn6SVfYAR2cbY5
         PiY1Uf0nFpIjf+oFWPIMJ7q/Dum/StDZr8zZMa5WCv69hDUi5wjcrr1DwLi5ZqXaw+ti
         Xf0yriPtAXvvI4sTm55VNCoHoySAEsrrqN+FcHFgGodPRFnfojW8HizhfXZtct1cw2Nm
         BhSjFfSPvKDKOyIh1yGADS/FyLIJil71QSNnKZTr1Awldw7V8+9L5+BAb5GGjt8UwTCQ
         SW7g==
X-Gm-Message-State: AA6/9RkGy7CXZ3JPLVawWQFr6N8fve18bZqxKsDTYjB3j3QC0cJ/LHCwMzjCnGhSXlBpkg==
X-Received: by 10.28.229.131 with SMTP id c125mr7712941wmh.97.1474752162979;
        Sat, 24 Sep 2016 14:22:42 -0700 (PDT)
Received: from [192.168.1.26] (dce219.neoplus.adsl.tpnet.pl. [83.23.56.219])
        by smtp.googlemail.com with ESMTPSA id ab9sm13946256wjc.7.2016.09.24.14.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 14:22:41 -0700 (PDT)
Subject: Re: [PATCH v8 02/11] pkt-line: extract set_packet_header()
To:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-3-larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <a5b9a46d-592e-089d-d156-36c4d61902c9@gmail.com>
Date:   Sat, 24 Sep 2016 23:22:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-3-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Subject: [PATCH v8 02/11] pkt-line: extract set_packet_header()
> 
> set_packet_header() converts an integer to a 4 byte hex string. Make
> this function locally available so that other pkt-line functions can
> use it.

Ah. I have trouble understanding this commit message, as the
set_packet_header() was not available before this patch, but it
is good if one reads it together with commit summary / title.

Writing

  Extracted set_packet_header() function converts...

or

  New set_packet_header() function converts... 

would make it more clear, but it is all right as it is now.
Perhaps also

  ... could use it.

as currently no other pkt-line function but the one set_packet_header()
was extracted from, namely format_packet(), uses it.

But that is just nitpicking; no need to change on that account.

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>

