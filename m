Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5467C001DC
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 17:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjGZRHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 13:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGZRHL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 13:07:11 -0400
X-Greylist: delayed 109 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 26 Jul 2023 10:07:09 PDT
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9AF31E73
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 10:07:09 -0700 (PDT)
Received: from [192.168.5.3] (c-73-202-23-161.hsd1.ca.comcast.net [73.202.23.161])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 36QH55Fm025899
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 10:05:20 -0700 (PDT)
        (envelope-from yuri@tsoft.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-202-23-161.hsd1.ca.comcast.net [73.202.23.161] claimed to be [192.168.5.3]
Message-ID: <5fce9c4f-0ea7-9393-4a30-ddd66946661d@tsoft.com>
Date:   Wed, 26 Jul 2023 10:05:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@tsoft.com>
Subject: 'git stash push -- {dir}' puts files in stash that are outside of
 {dir}
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am in the FreeBSD ports repository.

I run this command:

$ git stash push -m "gh-print-tuple" -- Mk

But then 'git show' shows that the top stash entry also has other files:

$ git stash show -p stash@{0} | grep diff
diff --git a/Mk/Scripts/print-submodule-gh_tuple.awk 
b/Mk/Scripts/print-submodule-gh_tuple.awk
diff --git a/Mk/Scripts/print-submodule-gh_tuple.sh 
b/Mk/Scripts/print-submodule-gh_tuple.sh
diff --git a/Mk/bsd.sites.mk b/Mk/bsd.sites.mk
diff --git a/audio/triceratops-lv2/files/patch-synth.cpp 
b/audio/triceratops-lv2/files/patch-synth.cpp
diff --git a/cad/scotch/distinfo b/cad/scotch/distinfo
diff --git 
a/cad/scotch/files/patch-Make.inc_Makefile.inc.i686__pc__freebsd 
b/cad/scotch/files/patch-Make.inc_Makefile.inc.i686__pc__freebsd
diff --git 
a/cad/scotch/files/patch-Make.inc_Makefile.inc.x86-64__pc__freebsd 
b/cad/scotch/files/patch-Make.inc_Makefile.inc.x86-64__pc__freebsd
diff --git a/x11/darktile/Makefile b/x11/darktile/Makefile
diff --git a/x11/darktile/distinfo b/x11/darktile/distinfo
diff --git 
a/x11/darktile/files/patch-vendor_github.com_kr_pty_ztypes__freebsd__arm64.go 
b/x11/darktile/files/patch-vendor_github.com_kr_pty_ztypes__freebsd__arm64.go
diff --git 
a/x11/darktile/files/patch-vendor_github.com_riywo_loginshell_loginshell.go 
b/x11/darktile/files/patch-vendor_github.com_riywo_loginshell_loginshell.go
diff --git a/x11/darktile/pkg-descr b/x11/darktile/pkg-descr


Why do files that are not under Mk get into stash?



Thanks,

Yuri


