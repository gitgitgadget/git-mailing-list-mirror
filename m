Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCDBD1F461
	for <e@80x24.org>; Fri, 23 Aug 2019 08:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390155AbfHWI3F (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 04:29:05 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:53624 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733069AbfHWI3F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 04:29:05 -0400
Received: by mail-wm1-f43.google.com with SMTP id 10so8092698wmp.3
        for <git@vger.kernel.org>; Fri, 23 Aug 2019 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pG9p3Y6tBH+QPq+NHb/e4PqyUtBiZCg4ze28aFDUdQ4=;
        b=kxW9dOf8DytLUPuWYzfrj9cCDLoDGRH9IRebnyYUGhEEUsdyyL73tJDhGY01esYRn+
         4OawdMWsR7otIr/GBCjtGVO3Cr1Sfbo119hR03nUNW4rS0kRrT4QEtesx9WxuuczACRq
         zQhlUrAVfNXQAZ6yA5PP2aQ84phWV8/kERlqkBENObImdsNUNPit5CP+N3G1hOB7OJ76
         0Xb8/XsVIpb7b1g1ZUsb1B85YOLKBOcaDdp5740kcI7lA45lDWYY+bRHRdesGltZqlbM
         k75LTJnnxXw21LaBA8kJGIUkV+WRCKlwh3iFDqg8a/hxUcNqjoxLU4h5iD00Y0AoKALT
         9kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pG9p3Y6tBH+QPq+NHb/e4PqyUtBiZCg4ze28aFDUdQ4=;
        b=qUXgN8IhP+bycMlvVb/3j/bya2jusva1SCDx+jhDhKq8+jrDLL+0Matl+mncQiTXgY
         Wcr+kZaK7C7J4rGO5zzeRnbWx0Sv2dU3L5AI7m3NznLK8XjSxLeyehmgfGh89L3AF2Wf
         i4gEe0UxqbnOLDU96Y9rcwLxWAVjozFQ3ygjK60AMX78pNS5nxjwK+o1ZdNoVmCf8yVf
         p4ECoC2cLo3Q5hReaW7glwfObKJDk6qqnn1R0ZlXmrF2C4GAq36CArZ+wN//hDT+8vZm
         Dl7DugzFzymX2QiC7ZwwrZFflpSVOqZc6DNVL8VQoFgy809TSbrKFY7ysN+lGsZxXxC2
         yXxg==
X-Gm-Message-State: APjAAAUCTSrks/j2vYsqaUmGMJ8lRzXo7n1MQuX7Snwh5oyvcmSXHVXd
        9lnCml2HSCXCt892tI1OXcU=
X-Google-Smtp-Source: APXvYqxZKX5nE9u6sZTd2u8YBjoNW90bouQdesGDG1DtsnJamx9sEiAqBKCRx4HiPKO3oiAa9zllbw==
X-Received: by 2002:a7b:cf3a:: with SMTP id m26mr3741772wmg.111.1566548943274;
        Fri, 23 Aug 2019 01:29:03 -0700 (PDT)
Received: from szeder.dev (x4db558a2.dyn.telefonica.de. [77.181.88.162])
        by smtp.gmail.com with ESMTPSA id l14sm2735229wrn.42.2019.08.23.01.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2019 01:29:02 -0700 (PDT)
Date:   Fri, 23 Aug 2019 10:29:00 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Bryan Turner <bturner@atlassian.com>,
        Giuseppe =?utf-8?B?Q3JpbsOy?= <giuscri@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [BUG] You can't have single quote in your username
Message-ID: <20190823082900.GG20404@szeder.dev>
References: <CAGV3M55WAQOAOiZPPgR+6p2EVzakrbz1gYAMh-BqxCVDeLCq9w@mail.gmail.com>
 <CAGyf7-EdxDn_BwguXNUNg76K9z30X0=C1btMR0dfiHR9bLjhwQ@mail.gmail.com>
 <20190822170817.GB35435@google.com>
 <20190822184312.xhrf2ij3bh3vovrq@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822184312.xhrf2ij3bh3vovrq@localhost.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 23, 2019 at 12:13:12AM +0530, Pratyush Yadav wrote:
> > Does it make more sense to replace this strbuf_addstr_without_crud()
> > setup with something more intelligent (i.e. checking for matching crud
> > on either end, like ^[$crudchars].*\1$? We already check for matched <>.
> 
> Sounds like something easy enough to implement. There are two types of 
> characters that crud() removes: there are the ones which _should_ appear 
> on both the start and end (', ", <, >), and the ones which don't 
> necessarily have to (., ,, :, ;, \).
> 
> So we'd need to handle two cases. For the former type, remove a 
> character both at the start and at the end. For the latter, remove only 
> where they appear.

If we go down this route, then someone might want to write ő as o" or
ű as u", which still supposed to be used in pairs, but what if someone
wants to write ä as a:, ö as o:, ü as u:, ç as "c,", ş as "s,", etc.

What I wonder is whether we really have to remove crud from the user
name if it comes from the configuration.

