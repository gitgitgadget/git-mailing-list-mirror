Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F59EC433E0
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74C92078E
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 21:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbgFOVZ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 17:25:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:13630 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgFOVZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 17:25:26 -0400
IronPort-SDR: w0sDLvXpSChpFPW5D7hQY4a/dI15geA546bfSn9+IpjyGNWy90LRjxMl6nZjsYg91mRhICatfk
 nQug3p7JCQDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 14:25:25 -0700
IronPort-SDR: r4kf13TveuW2zM2PtdpKXcy2KvsTsA0oHfIpLc8raOKgTRVV35JsA4iOIX52k7kOjWFIAm6qtQ
 E0OUoV/2Xh5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,516,1583222400"; 
   d="scan'208";a="276694193"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by orsmga006.jf.intel.com with SMTP; 15 Jun 2020 14:25:22 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 16 Jun 2020 00:25:21 +0300
Date:   Tue, 16 Jun 2020 00:25:21 +0300
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     git@vger.kernel.org
Subject: git log -- <old path> not working
Message-ID: <20200615212521.GT6112@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Patchwork-Hint: comment
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Just ran into a strange case with the Linux kernel repo
when trying to look up the history for a file that was
later renamed.

$ git log -- drivers/acpi/configfs.c
-> nothing

$ git log --follow -- drivers/acpi/configfs.c
$ git log --full-history -- drivers/acpi/configfs.c
-> works

First time I've seen this fail. Expected behaviour for
some reason, or a bug?

$ git --version 
git version 2.26.2

-- 
Ville Syrjälä
Intel
