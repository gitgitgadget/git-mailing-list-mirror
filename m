From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] Use LDFLAGS instead of ALL_CFLAGS when linking.
Date: Sat, 29 Oct 2005 09:30:20 +0200
Message-ID: <4363250C.8030200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Oct 29 09:31:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVlAb-0006lz-QD
	for gcvg-git@gmane.org; Sat, 29 Oct 2005 09:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbVJ2HaW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 03:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVJ2HaW
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 03:30:22 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:29375 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751376AbVJ2HaV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 03:30:21 -0400
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id C7A926BD0A
	for <git@vger.kernel.org>; Sat, 29 Oct 2005 09:30:20 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10797>

The patch says it all really. It lets users specify their own linking 
options and unclutters the build-output somewhat.

index 5b0306d..f547d45 100644
--- a/Makefile
+++ b/Makefile
@@ -360,7 +360,7 @@ git-cherry-pick: git-revert
         $(CC) -o $*.o -c $(ALL_CFLAGS) $<

  git-%$X: %.o $(LIB_FILE)
-       $(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
+       $(CC) -o $@ $(filter %.o,$^) $(LIBS) $(LDFLAGS)

  git-mailinfo$X : SIMPLE_LIB += $(LIB_4_ICONV)
  $(SIMPLE_PROGRAMS) : $(LIB_FILE)


-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
