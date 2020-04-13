Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1803CC2BBC7
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 07:35:08 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC62020776
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 07:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="h3GKiaSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC62020776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgDMHfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgDMHfC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 03:35:02 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C87C008679
        for <git@vger.kernel.org>; Mon, 13 Apr 2020 00:35:02 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4910kr10frz9sSY; Mon, 13 Apr 2020 17:35:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1586763300; bh=JDeN06MZ1G5yEZ6NMe/Yupomwf2wunpm9FFB95edkIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3GKiaSSkLFeZcJHrHTSMg4YOOZMJKGLstfapdug7BmaAQPCRwldA6AbYaC9DH1Qm
         SKUvpkbAQjfjgigSoznQDVSNm1oe4P6iAvqGxulc1RyzTm/K7apR2f9fGlSO2on77B
         pNedOmhPfhxG0Nh95Pel6U6WmciDN1+XtTUfNeYagEgoLYX6Eyi8CQproWbWpJ+peB
         HwkCfblgD+XhKwh/pRhUhBBSn41D/a2kOAPdSoo0tHSuKwmh5H6l20lbP9XKmpsB19
         i0Lh0Fo15rHhenkcJGmeMqRfRlUdf2vv9i/fN94i4Bs5XpAOIKKU/6tNh/kibnvwTF
         pfnsDfxO2KqGw==
Date:   Mon, 13 Apr 2020 17:34:56 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Christian Stimming <christian@cstimming.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] gitk: re-generate German po file from current source
 code
Message-ID: <20200413073456.GC14888@blackberry>
References: <2527491.s4PuAgMcOf@ckiste>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2527491.s4PuAgMcOf@ckiste>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 10, 2020 at 10:57:05PM +0100, Christian Stimming wrote:
> So that subsequent translation updates have an up-to-date
> starting point.
> 
> Signed-off-by: Christian Stimming <christian@cstimming.de>

I tried to apply this and the following patch, but this patch had a
lot of rejects.  For example, in this hunk:

> @@ -21,11 +21,11 @@ msgstr ""
>  msgid "Couldn't get list of unmerged files:"
>  msgstr "Liste der nicht zusammengeführten Dateien nicht gefunden:"

the u with umlaut appears as a single 0xfc byte, but in the file
po/de.po, it appears as a sequence of two bytes: 0xc3 0xbc, and so
patch considers that the lines don't match.  I have my locale set to
en_AU.UTF8.  Any ideas why the context in your patch would be
different to what I see in the checked-out file?

Paul.
