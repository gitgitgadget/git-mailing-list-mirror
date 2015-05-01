From: Alangi Derick <alangiderick@gmail.com>
Subject: [Patch] Nice help Output - SmallProjectIdea[1]
Date: Fri, 1 May 2015 19:33:51 +0100
Message-ID: <CAKB+oNvZxueR9PqysPn3khQZL+8tt3NNrgFzNjHnVuBVtyeZ4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 20:34:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoFlt-0001Un-Ga
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 20:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118AbbEASea (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 14:34:30 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:33453 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbbEASdw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 14:33:52 -0400
Received: by qkx62 with SMTP id 62so55382745qkx.0
        for <git@vger.kernel.org>; Fri, 01 May 2015 11:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=y86Zb2oCV5MFydZERxN5RkY6rRobLDsdqqUnbMkJEQ4=;
        b=h0smMwSPzfYzthwCFSftA+F6+Cuz1nfNUOM8FY/nNHcfZqDybhNtiHpFX5VcAXp+7R
         WfSvhQAOdbDjxUsi4/UcaUe70tg3A52j+gKFfggfXytGFSynW7D6SINMBLxKbUxfRqRg
         BYWgBHAEUnNND9ftg53Zo8puQKv1KZ0Hb9n+FDjW1/Tq/F6b4Blh5l9tytuTPS17N0ZA
         sH7BZs3Q6hYUlEBioOuHwDKfrqrQfQCLE0uWSxL6laclYTxV3YgvJ6YHLRaQw4vczDcp
         tIiAbP7dg6zzQ3j+tryt5k0YZrRaKvcFK5XSifKIpUuhuLdeUlkpbYlUWLGW0z3Y0gRz
         ykbA==
X-Received: by 10.55.40.132 with SMTP id o4mr21626879qko.61.1430505231572;
 Fri, 01 May 2015 11:33:51 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Fri, 1 May 2015 11:33:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268171>

This is a patch to fix the problem as given in the site:
https://git.wiki.kernel.org/index.php/SmallProjectsIdeas

diff --git a/help.c b/help.c
index 2072a87..e347bbc 100644
--- a/help.c
+++ b/help.c
@@ -229,9 +229,18 @@ void list_common_cmds_help(void)

  puts(_("The most commonly used git commands are:"));
  for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
- printf("   %s   ", common_cmds[i].name);
- mput_char(' ', longest - strlen(common_cmds[i].name));
- puts(_(common_cmds[i].help));
+ if(i%3 == 1){
+ printf("   %s   ", common_cmds[i].name);
+ mput_char(' ', longest - strlen(common_cmds[i].name));
+ puts(_(common_cmds[i].help));
+ printf("\n");
+ }
+ else {
+ printf("   %s   ", common_cmds[i].name);
+ mput_char(' ', longest - strlen(common_cmds[i].name));
+ puts(_(common_cmds[i].help));
+ }
+
  }
 }


Regards
Alangi Derick Ndimnain
