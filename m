Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0F34206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 20:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932163AbcLLUIx (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 15:08:53 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:12386 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932129AbcLLUIw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 15:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1481573330;
        l=636; s=domk; d=b-i-t.de;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:Subject:
        From:To;
        bh=yNTjHn/vA4XAhVgViXhVyjKq2vzNmK/KoYwibxfXpL4=;
        b=o4/icZzUmy6p0Tq/GrGUrs8hRVNIfQ4M6kWwGovBjP/EKmrYH3vXpNY79wCQSNMtQx
        NWJuOyM/VVbBcR1YmBEq4AannX5WuR6d6K3PVVJSdJMTfA48LoWjM/siqXCWfgf4CAWn
        9QubmxR3zzY557exFUk6i+IfECsLI7F0CQQWI=
X-RZG-AUTH: :O2kGeEG7b/pS1E/0QjKnx+zgSGDobGo6ayyb8wnG7jYw8Shi4OlnUleywpA8nM0=
X-RZG-CLASS-ID: mo00
Received: from office.b-i-t.de (unitoffice.heagmedianet.de [213.157.19.91])
        by smtp.strato.de (RZmta 39.10 AUTH)
        with ESMTPSA id L03439sBCK5kApN
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate)
        for <git@vger.kernel.org>;
        Mon, 12 Dec 2016 21:05:46 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by office.b-i-t.de (Postfix) with ESMTP id D6F745403F;
        Mon, 12 Dec 2016 21:05:45 +0100 (CET)
To:     git@vger.kernel.org
From:   bitjo <jo+github@b-i-t.de>
Subject: [BUG] Git-GUI destroys the author name
Message-ID: <588ac268-0a1b-6787-e6a1-4164e7e9a784@b-i-t.de>
Date:   Mon, 12 Dec 2016 21:05:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git version 2.11, git gui destroys the author name when 'git
commit amend' is executed and the author name contains UTF-8-specific
characters.

This is a known issue from 'Git for Windows' and now a
platform-independent bug.

Please refer
- https://github.com/git-for-windows/git/issues/761
- https://github.com/git-for-windows/git/issues/761#issuecomment-220792200
- https://github.com/git-for-windows/git/issues/761#issuecomment-266519859

From my point of view, this is a severe error since the repostory is
changed incorrectly. Users of git gui will usually not be able to
correct this error with git commands.


