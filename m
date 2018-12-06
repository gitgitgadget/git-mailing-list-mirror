Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84859211B3
	for <e@80x24.org>; Thu,  6 Dec 2018 13:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbeLFNK1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 08:10:27 -0500
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21343 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbeLFNK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 08:10:26 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1544101824; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=gggad6d/f5yhrec1j1oNZBRtxx5+yxn/SUEdko8TP+u1j3bH06YF8ZDNUdM6vGzvNoUytEw2BXanMOo7VkVN9QhdLXIKQtGN0p4gTD8aN7sXu3vlqsfwMpWDlI/HbYi4D940w/anm4xxYlTt7BttMnMG78gp8Yo0u3tcpuePcRU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1544101824; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=+r53KpwZpV2LCmhYMZZ679flQ4wBhVa9xYo2o05knP8=; 
        b=VHltOvyOen2Z85w97/cihzd0Y8PH+nd1OFmVY9+wympEs0PsiHqudVZzDZhUpv/CzD+J9a21ybU7jWkZh+yy5TNlPY8eiPsuhILZpC2OMebARl+wyXZ9QZhFlPCl/myoagUSWvEjBMFdyiiXtkJN4L53bf+pfmYw5dISULCUCRA=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=ovsienko.info;
        spf=pass  smtp.mailfrom=denis@ovsienko.info;
        dmarc=pass header.from=<denis@ovsienko.info> header.from=<denis@ovsienko.info>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1544101824;
        s=zohomail; d=ovsienko.info; i=denis@ovsienko.info;
        h=Date:From:To:Message-ID:In-Reply-To:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=1271; bh=+r53KpwZpV2LCmhYMZZ679flQ4wBhVa9xYo2o05knP8=;
        b=B10vxKo6EFyGxY7so7Lqdlis7wZtmlGdumL+bsKeR0Fi/ImZDpSAO4IyU/M3MZE9
        YgbUeh0ClKbQLuxUQluipXbutEyL7+NJAFzSj7gYL6O9GPVjenPNla1h9KP9DnWMfAz
        9hNUbJYTYfONknjnVmEUkBf9ap+oGQoQLF3bXvDo=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1544101824107294.7684060229201; Thu, 6 Dec 2018 05:10:24 -0800 (PST)
Date:   Thu, 06 Dec 2018 13:10:24 +0000
From:   Denis Ovsienko <denis@ovsienko.info>
To:     "git" <git@vger.kernel.org>
Message-ID: <16783a4066a.b4d8e56f230791.2246508654645522430@ovsienko.info>
In-Reply-To: 
Subject: [PATCH] docs: fix $strict_export text in gitweb.conf.txt
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Priority: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The section used to discussed $gitweb_export_ok and $gitweb_list, but
gitweb Perl code does not have such variables (this likely hangs over
from GITWEB_EXPORT_OK and GITWEB_LIST respectively). Fix the section to
spell $export_ok and $projects_list like the rest of the document.

Signed-off-by: Denis Ovsienko <denis@ovsienko.info>
---
 Documentation/gitweb.conf.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index c0a326e38..83b4388c2 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -207,8 +207,8 @@ subsection on linkgit:gitweb[1] manpage.
 
 $strict_export::
 	Only allow viewing of repositories also shown on the overview page.
-	This for example makes `$gitweb_export_ok` file decide if repository is
-	available and not only if it is shown.  If `$gitweb_list` points to
+	This for example makes `$export_ok` file decide if repository is
+	available and not only if it is shown.  If `$projects_list` points to
 	file with list of project, only those repositories listed would be
 	available for gitweb.  Can be set during building gitweb via
 	`GITWEB_STRICT_EXPORT`.  By default this variable is not set, which
-- 
2.17.1


