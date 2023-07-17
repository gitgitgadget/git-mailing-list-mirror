Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8760DEB64DD
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 00:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjGQAQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jul 2023 20:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjGQAQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2023 20:16:28 -0400
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA3791BE
        for <git@vger.kernel.org>; Sun, 16 Jul 2023 17:16:27 -0700 (PDT)
Received: from [192.168.5.3] (c-73-202-23-161.hsd1.ca.comcast.net [73.202.23.161])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 36H0GM68082822
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 16 Jul 2023 17:16:22 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-202-23-161.hsd1.ca.comcast.net [73.202.23.161] claimed to be [192.168.5.3]
Message-ID: <9e5b5818-6107-134f-b4ce-3a6028417838@tsoft.com>
Date:   Sun, 16 Jul 2023 17:16:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Pressing Ctrl-C during 'git checkout <branch-name>' messes up the
 repository
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
References: <fe3c68d5-124e-5a87-881a-21ad8e492f76@tsoft.com>
 <ZLM4sTUjBQt4QMfG@tapette.crustytoothpaste.net>
From:   Yuri <yuri@rawbw.com>
In-Reply-To: <ZLM4sTUjBQt4QMfG@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/15/23 17:24, brian m. carlson wrote:
> If you don't want to interrupt the operation, then don't hit Ctrl-C.


A more comprehensive way to handle this is to offer the user a choice:

Ctrl-C was pressed during a long operation. Please choose:

(1) press Ctrl-C again to stop immediately while likely leaving the 
repository in inconsistent state

(2) press C to continue

(3) press R to roll back the current operation


And if the user would press Ctrl-C again during the rollback - he would 
be presented with choices:

Ctrl-C was pressed during the roll back of a long operation. Please choose:

(1) press Ctrl-C again to stop immediately while likely leaving the 
repository in inconsistent state

(2) press C to continue the rollback


This would be a lot better than to just stop immediately and leave the 
repository damaged.



Yuri




