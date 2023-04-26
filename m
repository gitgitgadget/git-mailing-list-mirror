Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F90C7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 15:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbjDZP5P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 11:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbjDZP5O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 11:57:14 -0400
X-Greylist: delayed 5736 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Apr 2023 08:57:11 PDT
Received: from mail-mahalux.mvorisek.com (mail-mahalux.mvorisek.com [77.93.195.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24934495
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 08:57:11 -0700 (PDT)
Received: from 1b1d91b7628f (10.228.0.213) by mail-mahalux.mvorisek.com (10.228.0.4) with
 Microsoft SMTP Server (TLS); Wed, 26 Apr 2023 16:21:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 26 Apr 2023 16:21:31 +0200
From:   =?UTF-8?Q?Michael_Vo=C5=99=C3=AD=C5=A1ek_-_=C4=8CVUT_FJFI?= 
        <vorismi3@fjfi.cvut.cz>
To:     git@vger.kernel.org
Subject: Non-zero exit code of custom filter process is not handled
Message-ID: <a7cf2f3bbc6dcd8758e188f79d31e6e0bff44ea3e768fce482309ba532205f6b@mahalux.com>
X-Mailer: SAP NetWeaver 7.03
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone,


I would like to report https://github.com/gitgitgadget/git/issues/1516 .

When a custom filter process exits with a non-zero code, the git 
currently tries to decode the response, even if it should fail and let 
the user know the problem is not the payload, but instead of the filter 
process.

You can reproduce this with setting a git filter to "php 
non-existent.php", in this case the filter (php binary) will exit with 
non-zero code. Currently "fatal: protocol error: bad line length 
character: Coul" is printed which is very hard to understand as even not 
the whole error string is shown.

Thank you for looking into this.


With kind regards / Mit freundlichen Grüßen / S přátelským pozdravem,

Michael Voříšek, student
ČVUT FJFI


