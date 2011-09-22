From: Michael Witten <mfwitten@gmail.com>
Subject: [PATCH v2] Docs: Clarify the --tags option of `git fetch'
Date: Thu, 22 Sep 2011 04:17:48 -0000
Message-ID: <872e5c09ebf24edc8ebd4351e99864c2-mfwitten@gmail.com>
References: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
            <1316649176-32352-1-git-send-email-anatol.pomozov@gmail.com>
            <CAMOZ1BuSd52woX0utOQ84gbCzBkZg3ATKnE+7G_BrD5_hUQSiQ@mail.gmail.com>
            <7vwrd1z9it.fsf@alter.siamese.dyndns.org>
            <CAMOZ1Bvxc+vcofb_KyeLS7Gy=KOtX1SKv72cXA2NtwgYCWA31A@mail.gmail.com>
            <7vsjnpz0ng.fsf@alter.siamese.dyndns.org>
Cc: Anatol Pomozov <anatol.pomozov@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Daniel Johnson <computerdruid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 06:25:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6arF-0002pR-Ee
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 06:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999Ab1IVEW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 00:22:56 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:61374 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab1IVEWz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 00:22:55 -0400
Received: by yib18 with SMTP id 18so1623775yib.19
        for <git@vger.kernel.org>; Wed, 21 Sep 2011 21:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:cc:message-id:in-reply-to:references;
        bh=ddrT1BIoiTDS6ms9uaNST9HpPo10sG+hKbigKo1Yn7k=;
        b=LhGjfeS/Bvye/DvgFFuz8OOw3I04smnWofP2i+Ekz7KNuGd5PavkATijcen3ww9N4r
         QAB6p7aHk+qqjwJ6m9Bn9fCasz5Uey0634UDidhEu+V8RCW79LlETDMB7vOfoK3ijcDC
         DiWPBH3OE1ep90hEbSRQYC0s9KycgaVnIgXAY=
Received: by 10.236.75.194 with SMTP id z42mr10835222yhd.10.1316665374898;
        Wed, 21 Sep 2011 21:22:54 -0700 (PDT)
Received: from gmail.com (politkovskaja.torservers.net. [77.247.181.165])
        by mx.google.com with ESMTPS id f24sm9311310yhk.5.2011.09.21.21.22.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 21 Sep 2011 21:22:54 -0700 (PDT)
In-Reply-To: <7vsjnpz0ng.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181883>

On Wed, 21 Sep 2011 21:00:51 -0700, Junio C Hamano wrote:

> Michael Witten <mfwitten@gmail.com> writes:
>
>>   That is,
>>
>>     git fetch origin frotz --tags
>>
>>   is equivalent to:
>>
>>     git fetch origin frotz 'refs/tags/*:refs/tags/*'
>
> No matter what you do, please do not introduce a bad example that violates
> the usual command line syntax convention to have subcommand (e.g. fetch),
> options meant for the subcommand (e.g. --tags) and then other arguments.

Too bad; I think it really supplements the description well.

In any case:

  * The example has been changed as per your wish.
  * `short-hand' has been changed to `shorthand'.
  * Trailing whitespace has been removed from a line.

8<-----------8<-----------8<-----------8<-----------8<-----------8<-----------

See the discussion starting here:

  [PATCH] Clarify that '--tags' fetches tags only
  Message-ID: <1314997486-29996-1-git-send-email-anatol.pomozov@gmail.com>
  http://thread.gmane.org/gmane.comp.version-control.git/180636

Suggested-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/fetch-options.txt |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 39d326a..da594bd 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -61,9 +61,24 @@ ifndef::git-pull[]
 	objects reachable from the branch heads that are being
 	tracked will not be fetched by this mechanism.  This
 	flag lets all tags and their associated objects be
-	downloaded. The default behavior for a remote may be
-	specified with the remote.<name>.tagopt setting. See
-	linkgit:git-config[1].
+	downloaded.
++
+This option is merely a shorthand for writing the
+refspec `refs/tags/\*:refs/tags/\*'; consequently,
+using this option overrides any default refspec that
+would be used if no refspec were provided on the
+command line. That is,
++
+	git fetch origin --tags
+	git fetch origin --tags frotz
++
+are equivalent to:
++
+	git fetch origin 'refs/tags/*:refs/tags/*'
+	git fetch origin 'refs/tags/*:refs/tags/*' frotz
++
+The default behavior for a remote may be specified with
+the remote.<name>.tagopt setting. See linkgit:git-config[1].
 
 --recurse-submodules[=yes|on-demand|no]::
 	This option controls if and under what conditions new commits of
-- 
1.7.6.409.ge7a85
