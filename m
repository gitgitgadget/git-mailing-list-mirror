Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC31C7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 17:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjDERg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDERg1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 13:36:27 -0400
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF205B9D
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 10:36:26 -0700 (PDT)
Received: from [192.168.42.163] (221-99-142-46.pool.kielnet.net [46.142.99.221])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 2C81E3C0404;
        Wed,  5 Apr 2023 19:36:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1680716184;
        bh=P8qUSk+pjRCcxZArfz+2gd8NUbKMQJVc4SMzRNFimvc=;
        h=Date:To:Cc:From:Subject:From;
        b=mEz5ds4H+uB8UkRj0s2YBcR7hHhJ/CBOXL3bo1aA6FaOXW0MijpvTxohBK9lQU+C5
         t9I0Dg0DyngUyeWGtQrxztuYJzqlC/wSjPnf4S7FjF/1OnrnlSIyjCldYedycr82m0
         jPhFedugLTSVwz91Z+4gz4slbGUWN0zc6DCpp2NSGm0hlGtRvqmxzo+/uLRPgflB52
         sCkL4XeMpHXDZrTwLJMnGI4XNBU9QZYk4euzbEbLZsIXqPZ+AaKucN4jE5JmnWVdF9
         LUXvIGkgkBmTBE/6IaW2zqug4S2eMS8MuWZffrMWERdN4kozQMqa4oHUNz3uzYEURa
         c8vKPiQ7ibufw==
Message-ID: <db535468-c991-df18-61bd-ec312fdb5ca0@haller-berlin.de>
Date:   Wed, 5 Apr 2023 19:36:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
To:     git@vger.kernel.org
Content-Language: de-DE, en-US
Cc:     johannes.schindelin@gmx.de
From:   Stefan Haller <lists@haller-berlin.de>
Subject: Possible bug in git-rebase man page
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: --
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git-rebase documentation has an example for a git-rebase-todo file
when --rebase-merges is used; one of the lines in that file is

  reset refactor-button # Use the Button class for all buttons

From reading the code that parses the file, this doesn't seem to be a
valid line; as far as I can see, comments are not supported for reset or
label. The label is the entire rest of the line after the command.

Just wanted to confirm that I'm not missing anything.

-Stefan

