Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34441FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 18:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932894AbdCGSTv (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 13:19:51 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:59192
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932683AbdCGST3 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Mar 2017 13:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1488901691;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=1ifc5AL8Vxvn6RSKQc6y6lQ1i/FiKw5FzOxac3kRVow=;
        b=GnEfRDKL9DPr5ziEtKL5Y8b7xX8xk0ZqIyDLssWkDUdm5uMPJDokqCWoMVkoYQxZ
        cHAuI9HT/3ttOD9HBlbLQ/Qx1JhmP30zK5uQlZ0K63fZMhzC1MABvR7L6Ae636CdZOj
        Ok4GoGoAzVPohtL7+GL2RnxLBWzlJ/RJZdARr9e8=
From:   Sebastian Schuberth <sschuberth@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015aa974d7a6-46afa73b-4378-4b01-9db4-723fb9e41d65-000000@eu-west-1.amazonses.com>
In-Reply-To: <000001529cbe5436-285f0113-5761-49d8-8961-5a9df0180ed7-000000@eu-west-1.amazonses.com>
References: <000001529cbe5436-285f0113-5761-49d8-8961-5a9df0180ed7-000000@eu-west-1.amazonses.com>
Subject: [RESEND PATCH] git-gui--askpass: generalize the window title
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 7 Mar 2017 15:48:11 +0000
X-SES-Outgoing: 2017.03.07-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-gui--askpass is not only used for SSH authentication, but also for
HTTPS. In that context it is confusing to have a window title of
"OpenSSH". So generalize the title so that it also says which parent
process, i.e. Git, requires authentication.

Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
---
 git-gui/git-gui--askpass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui/git-gui--askpass b/git-gui/git-gui--askpass
index 4277f30..1e5c3256 100755
--- a/git-gui/git-gui--askpass
+++ b/git-gui/git-gui--askpass
@@ -60,7 +60,7 @@ proc finish {} {
 	set ::rc 0
 }
 
-wm title . "OpenSSH"
+wm title . "Git Authentication"
 tk::PlaceWindow .
 vwait rc
 exit $rc

--
https://github.com/git/git/pull/195
