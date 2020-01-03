Return-Path: <SRS0=XQOF=2Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B283C2D0C2
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 14:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D626E22314
	for <git@archiver.kernel.org>; Fri,  3 Jan 2020 14:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgACOCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jan 2020 09:02:17 -0500
Received: from mga04.intel.com ([192.55.52.120]:2842 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbgACOCR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jan 2020 09:02:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 06:02:16 -0800
X-IronPort-AV: E=Sophos;i="5.69,390,1571727600"; 
   d="scan'208";a="222171351"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 06:02:14 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: BUG: sendemail-validate hook is run too early
In-Reply-To: <87sgkwswhs.fsf@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <875zhut5yd.fsf@intel.com> <xmqqk169ehb1.fsf@gitster-ct.c.googlers.com> <87sgkwswhs.fsf@intel.com>
Date:   Fri, 03 Jan 2020 16:02:12 +0200
Message-ID: <87png0sknv.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 03 Jan 2020, Jani Nikula <jani.nikula@intel.com> wrote:
> I think one possible alternative to adding a completely new hook would
> be postponing the sendemail-validate hook, passing the same patch on the
> command-line as before (to ensure current users are unchanged), and
> additionally passing in the recipients.

I realize the validation is done on *all* patches in a series before any
further processing, so the suggestion to postpone the current validation
hook is a bad idea. We'd need a new hook. The other points about having
both the patch contents and the recipients available to the hook remain.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
