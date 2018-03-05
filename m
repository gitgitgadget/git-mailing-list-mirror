Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E03D81F404
	for <e@80x24.org>; Mon,  5 Mar 2018 23:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932720AbeCEXqI (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 18:46:08 -0500
Received: from mail-pl0-f54.google.com ([209.85.160.54]:44686 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeCEXqI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 18:46:08 -0500
Received: by mail-pl0-f54.google.com with SMTP id 9-v6so5230320ple.11
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 15:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/Wznz3GNYGkACjIQu5uXc8bAPiaQg9q91YVQd2rrjfI=;
        b=ok/bWZmA1sDglM7wVhguvqdOKNyyy5tJ6cytWElF1XFZtIv4R7jMAiGH4AdzvxAaTo
         OZuv+yFLW7hF1SxeN9y0jLUZuk0BvefPRLjAGcnMo52nEst3pOTtUQ8aIe6nCPqplY2D
         O9hpiWrKD3tu3KDwA6WyZMAleFlRdJfuUr+tWT6H8GDSK/SXQcPqqQ4zt3RODk7zgTB9
         vc9N3aNlvT4Vd/SkGx95GzwkWziIKoKT8wcqdSWojXxlFti3uM7/zvqTz1kJgJhO3OS8
         I3udIrMzwqIwW2kwqNzjqP5fvwJ1gw/SAn8m5UTb6A/Ni6P9oyjGbTEa6MEaz1g7zMK9
         MUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/Wznz3GNYGkACjIQu5uXc8bAPiaQg9q91YVQd2rrjfI=;
        b=mdlgOg2cvhpt933+eMuPAyvqU8jSkC5EGwnsTPIoQPORwsU0Uw/CQnGAoxxid9NvuW
         5S9bDDPL/5UsyQ16fzdCslJVA11Rj5ak8Iz8e9+O4Cby0XsJzG3jVhaArpEkrzo1YQjR
         HGfqnT0kkgApIblfYmzw6eQMCvJ2/c3SDrirb5TaoYMhLsBr74wiuNrLqz96eW03MRT9
         2FisPM0pbxdEl7rkMhpbwVI3SjzoTrTBR8R6GIjJXaXMAUVcTg3FERC0dTthDnmGWIKn
         ozB3tKnrXvcT3CoDjI2FXN8hoW7cpZCmOcglFT0bRpRDR/zm5nwdRCe0NC09xp5NXuCX
         NoqA==
X-Gm-Message-State: APf1xPAbPZautdhyRRZBhu7EH9M5l9HW3hYIPh1UKCc8G+Ouk0p3cAvX
        mB4UE8w2/WjFsfgdvb7q5Wo=
X-Google-Smtp-Source: AG47ELstWyo91r3jy5lhSBMgv/dQnjom/H/kNlrxz883QB+ctCJn6YHLRr5pecOdnNzO2tZfz5GMvQ==
X-Received: by 2002:a17:902:3183:: with SMTP id x3-v6mr14634153plb.383.1520293567523;
        Mon, 05 Mar 2018 15:46:07 -0800 (PST)
Received: from far8gsqyz1.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 12sm27026945pfr.147.2018.03.05.15.46.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Mar 2018 15:46:06 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v9 6/8] convert: check for detectable errors in UTF encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqfu5e8a53.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 6 Mar 2018 00:45:02 +0100
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Content-Transfer-Encoding: 7bit
Message-Id: <55633B6F-EB6E-42D6-8E58-79158A99774A@gmail.com>
References: <20180304201418.60958-1-lars.schneider@autodesk.com> <20180304201418.60958-7-lars.schneider@autodesk.com> <xmqqfu5e8a53.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 05 Mar 2018, at 22:50, Junio C Hamano <gitster@pobox.com> wrote:
> 
> lars.schneider@autodesk.com writes:
> 
>> +static int validate_encoding(const char *path, const char *enc,
>> +		      const char *data, size_t len, int die_on_error)
>> +{
>> +	if (!memcmp("UTF-", enc, 4)) {
> 
> Does the caller already know that enc is sufficiently long that
> using memcmp is safe?

No :-(

Would you be willing to squash that in?

    if (strlen(enc) > 4 && !memcmp("UTF-", enc, 4)) {

I deliberately used "> 4" as plain "UTF-" is not even valid.


Thanks for spotting this,
Lars
