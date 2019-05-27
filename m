Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F191F609
	for <e@80x24.org>; Mon, 27 May 2019 19:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfE0TfR (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 15:35:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51438 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbfE0TfR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 15:35:17 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 3E2951F462;
        Mon, 27 May 2019 19:35:17 +0000 (UTC)
Date:   Mon, 27 May 2019 19:35:17 +0000
From:   Eric Wong <e@80x24.org>
To:     Chris Mayo <aklhfex@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email: remove documented requirement for
 Net::SMTP::SSL
Message-ID: <20190527193517.GA22013@dcvr>
References: <20190526172242.13000-1-aklhfex@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526172242.13000-1-aklhfex@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Mayo <aklhfex@gmail.com> wrote:
> git-send-email uses the TLS support in the Net::SMTP core module from
> recent versions of Perl. Documenting the minimum version is complex
> because of separate numbering for Perl (5.21.5~169), Net:SMTP (2.34)
> and libnet (3.01). Version numbers from commit:
> bfbfc9a953 ("send-email: Net::SMTP::starttls was introduced in v2.34",
> 2017-05-31)

No disagreement for removing the doc requirement for Net::SMTP::SSL.

But core modules can be split out by OS packagers.  For
Fedora/RH-based systems, the trend tends to be increasing
granularity and having more optional packages.

So I think documenting Net::SMTP (and Net::Domain) as
requirements would still be good, perhaps with a note stating
they're typically installed with Perl.

Fwiw, I recently ran into some issues where core modules such as
Devel::Peek, Encode, and autodie were separate packages on CentOS 7.
