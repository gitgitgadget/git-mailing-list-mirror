Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574B9C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ADAF6127A
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhDZPJM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 11:09:12 -0400
Received: from elephants.elehost.com ([216.66.27.132]:14193 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbhDZPJM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 11:09:12 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 13QF8SPj095191
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 11:08:28 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: Advise request on adding a new SSH variant
Date:   Mon, 26 Apr 2021 11:08:21 -0400
Message-ID: <043101d73aae$026409b0$072c1d10$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adc6rLlrXLyAL6uWTOGkNMGYVU18Kw==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Team,

I am getting a bunch of requests from my team (and customers) to make SSH
configuration easier on the NonStop platform. We are currently using a
wrapper script to drive the variant of SSH on the platform but that is not
convenient for many people. I would like to add an ssh.Variant called
"nonstopssh", or something like that, which takes a few extra parameters.
-Q (quiet), -Z (don't display the banner), -p port (obvious but typically
required), -S (a system process name). The code in connect.c looks pretty
straight forward, but I'm wondering about the best way to pass in a process
name (it would be something like "$ZSSHX" - usually an environment variable
"SSH2_PROCESS_NAME"). The program name for SSH, I assume, could come from
GIT_SSH_COMMAND (typically "/G/system/zssh/sshoss", or I could force it if
not supplied). I'm also wondering about controls for the -Q and -Z
parameters. Should I just use the environment for this and build up args or
is there a more appropriate way of managing these values?

Thanks in advance,
Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.


