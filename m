Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81FE71F597
	for <e@80x24.org>; Fri, 27 Jul 2018 19:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389372AbeG0VNj (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 17:13:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34940 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389268AbeG0VNj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 17:13:39 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so6724135wmc.0
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=PaXrCUvUbvC1561MldVrASjX8puonaZ+o6nEcevsX4I=;
        b=elk4ZurR+m0quvarNrHtR3F54vH2IQtfAPmoXBO31JuvPsWosr9KNBcvNK/gclFjCK
         YWLyl3KR1mbxzOdGghGHKup4XgVC2vqhVB2rY3ECTOhpbUXB45w0bk4mYXAgNXdsSs5W
         km7d370f/l4PNCq+cej+HkvCDQwr3PCgLk4QCjKU1erJvkzECmAMWM9ygWS9n8ZXhMI+
         tyZK60+7+VVu7xiQv0qR5jKNKfIH19LeevLgyBe8eXc0li7xpOL8GBzMognB5cg0Zr8p
         ITJlfu2Y6gqkvB5AE9J/pWnGPz0pFiKmimFkxEU3W++UXQxLe9sHWzOLSCPh8luADkTv
         tMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=PaXrCUvUbvC1561MldVrASjX8puonaZ+o6nEcevsX4I=;
        b=ipdk5ZH7vnDjDp8f0WBEQaHzAFUiHGgnzOEYZoAWKHcztnF03g3av6wxZOgzoYNWGQ
         Q/W40pH0ijFwIolUa/6ZomAA3Kdpt6vdUHgz8PyTsNClcyxLFKMNQTUj4DpOuZGkLLpL
         1KPW/c9frRVe0e2jA8JwGXZhL8Bl1bDfaRZpDZ2G+y6xFp8GZsIauKrsRx35ru6zwXvL
         ZnCiRXGfxtWjApIZ6mU9tYUtQAXeF3lzaRzaYjo/F9/9zf/nL+aGsybVv0VcIxj6PbFN
         oPYk3GZ9qeuUpTZEfvDCmnkFt1hIGTSU0nj/iDB3qwr52A77HPSZ+4/R3ww+WEakdoAN
         trRw==
X-Gm-Message-State: AOUpUlHq6c9L9BJI5B7u8U6Sllo2PaSEFz8a/agZWmUzGNJKquHPnO9d
        taadcxFoEMruIY54BagAE7LJztg8s04=
X-Google-Smtp-Source: AAOMgpeLahbXNW3ZzMthBr9yue2KEOfQ5i0nt9uiHG589EcP5aTU7Kve5x8ovHUrICQRBcHn/+6sGA==
X-Received: by 2002:a1c:58cb:: with SMTP id m194-v6mr5844940wmb.64.1532721015188;
        Fri, 27 Jul 2018 12:50:15 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id g125-v6sm3762822wmf.16.2018.07.27.12.50.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 12:50:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 10/10] fsck: test and document unknown fsck.<msg-id> values
References: <20180525192811.25680-1-avarab@gmail.com> <20180727143720.14948-11-avarab@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180727143720.14948-11-avarab@gmail.com>
Date:   Fri, 27 Jul 2018 21:50:13 +0200
Message-ID: <87bmas5uh6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

a
On Fri, Jul 27 2018, Ævar Arnfjörð Bjarmason wrote:

> When fsck.<msg-id> is set to an unknown value it'll cause "fsck" to
> die, but the same is not rue of the "fetch" and "receive"

s/rue/t&/. Looks like we're headed for a v4. I'll fix this typo.
