Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE439C433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 05:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B36D920737
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 05:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgGBFc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 01:32:28 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36182 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgGBFc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 01:32:28 -0400
Received: by mail-wr1-f68.google.com with SMTP id k6so26515150wrn.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 22:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BW+LHV9t++Br5fB3whKWGk3tCJeOTliY/nfITn58uXM=;
        b=rxQ58PClHzd3NXNBeH58K6RDskBxKJY6NgNJG1sLA3j2haLwhjhEXyJDGY1QExwXOI
         0LvfMPfW0cAzP7sjQ2HrrJmuA+QkIc+isxLNekFBxiCtZoTFHKZ+eQD3/oZmAislTAA2
         VEb8g99SofPeBx0lsmcutZZW5NzS25yyS2Cqp4Sxfc2JskXbbqIsxCyuLMTxAtPO6lBb
         YSCi22NcedRHmn0I7mOSB0dkXC2ocB6SnEySqXHV2D4507M1owLqX4myGBpDKzsehOTS
         ld0nwzMhTD/gkyp0hLNjjkF71EYIQlV5qoz1lUm2jK1hh9bJWv0UsgGx6H/Vm8kc7l+A
         hVyA==
X-Gm-Message-State: AOAM5316x1WgwyhPiE7fEUKb3gShCq3451uwUM4+EHmCC3+SAaEuVjHB
        6Na/M54bdmnJ5UsLtjTQFyeizpZBHYjbMgSoBqffrw==
X-Google-Smtp-Source: ABdhPJwrXfEQHyd5MzLCwXBIb627516iFR6+hub/r8MzTwsXtEAuVE9+Q3KZgbqYn+zKONnF5KIrVhl5x2r2pK8gTDE=
X-Received: by 2002:adf:fa89:: with SMTP id h9mr29296508wrr.120.1593667946794;
 Wed, 01 Jul 2020 22:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200701093653.3706-1-ben@wijen.net> <20200701093653.3706-2-ben@wijen.net>
 <CAPig+cT+cXuM3Asu6+Z25pGV2uRm6K1iAeYVhic9kqk1mS84-g@mail.gmail.com>
In-Reply-To: <CAPig+cT+cXuM3Asu6+Z25pGV2uRm6K1iAeYVhic9kqk1mS84-g@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Jul 2020 01:32:15 -0400
Message-ID: <CAPig+cQwJKSVMP8G7E62bESERYsAFTUN2PBX32YWMhECjU=qTQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] git clone: check for non-empty directory
To:     Ben Wijen <ben@wijen.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 1, 2020 at 12:00 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> One other observation: To preserve bisectability (git-bisect) of
> git.git itself, we want to ensure that the entire test suite still
> passes at each point in a patch series. Making this change to the test
> in its own patch introduces a failure into the test suite, which is
> undesirable. One way to address this shortcoming would be to
> temporarily change this test from 'test_must_succeed' to
> 'test_must_fail', and then flip it back to 'test_must_succeed' in
> patch 2/2. [...]

And another correction: I meant 'test_expect_success' and
'test_expect_failure', respectively.
