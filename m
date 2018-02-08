Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A86F1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 01:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750987AbeBHBCf (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 20:02:35 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:53535 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750745AbeBHBCf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 20:02:35 -0500
Received: from homiemail-a23.g.dreamhost.com (sub3.mail.dreamhost.com [69.163.253.7])
        by hapkido.dreamhost.com (Postfix) with ESMTP id BE31F91B05
        for <git@vger.kernel.org>; Wed,  7 Feb 2018 17:02:34 -0800 (PST)
Received: from homiemail-a23.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a23.g.dreamhost.com (Postfix) with ESMTP id 254F24B0084;
        Wed,  7 Feb 2018 17:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=LRW+I
        fVxM2evOvDu8PV+4O9kR5U=; b=UCa0nD/LpS/X5aDy7E8SgJC5NvNYd39Qjsh47
        GXRqqees4fRcp0Xj0zVf2AmVzgeyYsYTnFT/LcMTSvlFjg+qIC4pe1iAfPstM80r
        sPgDot9tDTpQ3FiV82+u2y9hvEYEosMp429r7WlfcVRELqq5eZuqw6lCO4Dj/9jY
        5swBuw=
Received: from corey (207-38-252-131.s11610.c3-0.43d-cbr1.qens-43d.ny.cable.rcncustomer.com [207.38.252.131])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a23.g.dreamhost.com (Postfix) with ESMTPSA id 440494B0058;
        Wed,  7 Feb 2018 17:02:33 -0800 (PST)
Message-ID: <1518051751.15704.476.camel@novalis.org>
Subject: Re: [PATCH v1] name-hash: properly fold directory names in
 adjust_dirname_case()
From:   David Turner <novalis@novalis.org>
To:     Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org
Cc:     prohaska@zib.de, gitster@pobox.com, tboegi@web.de,
        sunshine@sunshineco.com
Date:   Wed, 07 Feb 2018 20:02:31 -0500
In-Reply-To: <20180208004156.36224-1-benpeart@microsoft.com>
References: <20180208004156.36224-1-benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2018-02-07 at 19:41 -0500, Ben Peart wrote:
> Correct the pointer arithmetic in adjust_dirname_case() so that it
> calls
> find_dir_entry() with the correct string length.  Previously passing
> in
> "dir1/foo" would pass a length of 6 instead of the correct 4.  This
> resulted in
> find_dir_entry() never finding the entry and so the subsequent memcpy
> that would
> fold the name to the version with the correct case never executed.
> 
> Add a test to validate the corrected behavior with name folding of
> directories.

Looks good to me.
