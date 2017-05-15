Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2368A201A7
	for <e@80x24.org>; Mon, 15 May 2017 12:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751519AbdEOMCZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 08:02:25 -0400
Received: from s3.sipsolutions.net ([5.9.151.49]:44636 "EHLO sipsolutions.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750822AbdEOMCZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 08:02:25 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1dAEhi-0008P6-HQ
        for git@vger.kernel.org; Mon, 15 May 2017 14:02:22 +0200
Message-ID: <1494849741.3608.5.camel@sipsolutions.net>
Subject: git-send-email smtpEncryption option is case sensitive (silently
 fails if "TLS" is specified)
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     git@vger.kernel.org
Date:   Mon, 15 May 2017 14:02:21 +0200
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just spend some time figuring out that my newly written git-send-
email configuration didn't work because setting

[sendemail]
    smtpEncryption = TLS

has no effect. This is because the option has to be specified as "tls".
Unfortunately there is no warning that "TLS" is unsupported making it
hard to see why authentication is failing in the end.

I think it would be helpful to have a warning. Additionally one could
also normalize the option to lowercase automatically.

Regards,
Benjamin
