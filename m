Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50BD61F404
	for <e@80x24.org>; Thu,  6 Sep 2018 09:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbeIFNz2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 09:55:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43698 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbeIFNz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 09:55:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id k5-v6so10549708wre.10
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 02:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=0rRkj8+xMXrITEpXE98ngwsTQ0CB11rU0xGrlyZLbKI=;
        b=j8pfa2903oyIoLsJDedt09sqiYLwig6LoRoRfPqCT3IHQCmkZzqU/tqCIaavOSVt5f
         eI5YevZ2mSEA0jmgSmNJCWciw71ylnADH0EtKKondfumuILOkDDrhgZhxKQSWyxC+neb
         ERHibVa7Qf87QCfS6i/is1g97oF+3QF7G6Mc+a8F16G0FiZ3uXGAZttdZ9BcrbZnR0MF
         Sz+H1ooFVsNKB85Kjz5avIF1eMNKIegTuvKl7S1ALS0mmWvViBJLxFvK08tE7E/LJb+f
         ryw/5w3MxTBiSOrOOUH9nsF4OymDmTTazxVZxsJbVBSJfAKSXno0S2b9sF8uD4jK9UuY
         Mmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=0rRkj8+xMXrITEpXE98ngwsTQ0CB11rU0xGrlyZLbKI=;
        b=P0ZOIMNTWTMJKyjg51SlrEEVlafoOx5Danh9HYvaYqgg7eOocHQTeRPZvbgyjNQVwK
         YSo67ctwVuylVzL88WZRfPbKpEhDaVo/9rkMLG9yS0JEeOrgRAVodYw9sJoNYDwM5q5P
         QOQAjCbVnFuqCv579wUoJYq/PuD6kOcPKcczO/t1Nbr5LdeIetFss4gvG46H0STbKMJ5
         +0Yqi0SuN399Yz4nluiNg2Fet36q51bJ7ncnnIVpBwY32a0JUji/OWWu+vYknC5kfc02
         jSEWw+mbGI5dsA/3NXlqpmO1dyTO1qZ4LcXbboXYMXh+JxxAdTmEkHga5kJ+GSBTanp6
         dKRQ==
X-Gm-Message-State: APzg51AVfWu7UCGEd2QqKThsu4XbAOG4G+wY0zYiJeKHfnmiuiyZd6Mh
        0L5RXkWfo8+d2W0fqZZeXrEV0xNH
X-Google-Smtp-Source: ANB0Vdb9OmTz8DOxPs8fxYiw7uoPsaME5HD0uaZDfVdmCTDa+yCzQA4xv+okrqY9ZriqShZ0VrrF7A==
X-Received: by 2002:adf:bb41:: with SMTP id x1-v6mr1518382wrg.24.1536225655006;
        Thu, 06 Sep 2018 02:20:55 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id p11-v6sm5282448wrd.74.2018.09.06.02.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Sep 2018 02:20:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC PATCH 4/5] t1700-split-index: date back files to avoid racy situations
References: <20180906024810.8074-1-szeder.dev@gmail.com> <20180906024810.8074-5-szeder.dev@gmail.com> <871sa7rr30.fsf@evledraar.gmail.com> <20180906091539.GA8805@localhost>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180906091539.GA8805@localhost>
Date:   Thu, 06 Sep 2018 11:20:53 +0200
Message-ID: <87y3cfq8wa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 06 2018, SZEDER Gábor wrote:

> On Thu, Sep 06, 2018 at 10:02:43AM +0200, Ævar Arnfjörð Bjarmason wrote:
>> 
>> On Thu, Sep 06 2018, SZEDER Gábor wrote:
>> 
>> > +# Create a file named as $1 with content read from stdin.
>> > +# Set the file's mtime to a few seconds in the past to avoid racy situations.
>> > +create_file () {
>> 
>> Nit: Would be easier to read in the future as
>> e.g. s/create_file/create_old_file/ or something like that. I.e. so you
>> can see at a glance from the tests themselves what this is doing.
>
> Perhaps; but then I'm not so sure about 'old', because that's just a
> property of the resulting file...  I'm inclined to rename it to
> 'create_non_racy_file' to also imply "why" this function is used
> instead of plain old '>file'.

Yeah, that's much better.
