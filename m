From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH] git-pull: fix fetch-options.txt to not document --quiet and 
	--verbose twice
Date: Sat, 8 Aug 2009 12:09:52 +0200
Message-ID: <9f50533b0908080309n15c195b7of9d82bc86041ab88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 08 12:10:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZisR-0004Ts-0f
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 12:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933851AbZHHKJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 06:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754079AbZHHKJx
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 06:09:53 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:38038 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbZHHKJx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 06:09:53 -0400
Received: by fxm28 with SMTP id 28so185997fxm.17
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=ktiFQKLdvbP937fwNNDFvicvW40kUsBcrIZrNwYwMX4=;
        b=Go4PmGf26KyeyqSRysBbApJhLziSuZ3oVwwksaz0dBuYlqGBaScuUxWrNbTEVeITm9
         WAwOH8tl5my5HmMBN1k/to1ZFtRI6i7IsFxZ0aJUVpNRPkoOi4y1emRo2D9eY67OPGlu
         MaKhQYL3xNICFFqD0QL6pLfsauj3MMOjGOBbc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=OSlbPPcs7lnaNf3IZTg2lwm4AoJ5FsOCu1FuRJ726mWuSIenacd1o96AYvgT3RNGw8
         ssoFePITtWDFoXpULZYW4jEfqmjN55YfMa81/JYplg5hxTMlx0xwg05GRihwV1pGuugO
         Z64cnjaG4x3SysPTMAum1n8bTP4W1LrrFV3oM=
Received: by 10.204.113.208 with SMTP id b16mr2821746bkq.57.1249726192775; 
	Sat, 08 Aug 2009 03:09:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125274>

git-pull.txt includes fetch-options.txt and merge-options.txt which both
document the --quiet and --verbose parameters. So we supress the
--quiet and --verbose paragraphs if fetch-options.txt is included by
git-pull.txt
---
 Documentation/fetch-options.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index d313795..525ce88 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,3 +1,6 @@
+//git-pull.txt includes merge-options.txt which documents --quiet and
+//--verbose
+ifndef::git-pull[]
 -q::
 --quiet::
 	Pass --quiet to git-fetch-pack and silence any other internally
@@ -6,6 +9,7 @@
 -v::
 --verbose::
 	Be verbose.
+endif::git-pull[]

 -a::
 --append::
-- 
1.6.4
