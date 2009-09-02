From: Emmanuel Trillaud <etrillaud@gmail.com>
Subject: [PATCH] git-pull: fix fetch-options.txt to not document --quiet and 
	--verbose twice in git-pull.txt
Date: Wed, 2 Sep 2009 16:38:26 +0200
Message-ID: <9f50533b0909020738l153c928auc4ecbadfaceeea5f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 02 16:38:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miqyr-0000g9-Gf
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 16:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbZIBOi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 10:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbZIBOi0
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 10:38:26 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:45946 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752329AbZIBOiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 10:38:25 -0400
Received: by bwz19 with SMTP id 19so757768bwz.37
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 07:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=ddVFLZ79tjQ3kTJr2dPHT5ZefgeRVi60ZjOeYz2tQQY=;
        b=oZXteKGa0MSAU8rqsBVMBHUYP8sNLDHj9Qe4k9SdS6/VLkQ06aV+umO2Vk/1A3myVT
         TEFoew1Ib2iGv1lLow+dtOkYlHChEMxZW0z/DzveUqQFmsOpGitvKMWFzIvzLi/h1G+n
         NvFMYLG4IrOpbxRRf1IEMrorjFlWMPuDg1FUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WxpQVUYhz1ydcG4uUgTC0XIqgDfrzBD0lmdH00XMYj2EgvPvXc4pGNA5vc2V/q2/8S
         yeptpSHpg5CDR3hP6TSq5GHo86VVQh7RjFEd64HyqlVr44JTrcNsrjgHqhI4UuoiCcaH
         lstohw3QX2CtSo6V+GZgjMm9UCW52raO977Sc=
Received: by 10.216.11.210 with SMTP id 60mr174287wex.188.1251902306247; Wed, 
	02 Sep 2009 07:38:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127607>

Hello all!
the current man page of git-pull documents twice the --quiet and
--verbose options. fetch-options.txt and merge-options.txt which both
documents these options.
I choose to "ifndef" the paragraphs in fetch-options.txt because IMHO
they give too much details on the --quiet option (see the patch
below). Of course we could modify merge-options.txt instead (the
--quiet paragraph just says : "operate quietly"), I can provide a
patch if you want.

Best regards

-----------------

git-pull.txt includes fetch-options.txt and merge-options.txt which both
document the --quiet and --verbose parameters. So we supress the
--quiet and --verbose paragraphs if fetch-options.txt is included by
git-pull.txt.

Signed-off-by: Emmanuel Trillaud <etrillaud@gmail.com>
---
 Documentation/fetch-options.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index ea3b1bc..5eb2b0e 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,3 +1,4 @@
+ifndef::git-pull[]
 -q::
 --quiet::
 	Pass --quiet to git-fetch-pack and silence any other internally
@@ -6,6 +7,7 @@
 -v::
 --verbose::
 	Be verbose.
+endif::git-pull[]

 -a::
 --append::
-- 
1.6.4.2.253.g0b1fac
