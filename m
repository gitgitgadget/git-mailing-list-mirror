From: Semyon Kirnosenko <semyon.kirnosenko@gmail.com>
Subject: [BUG] diff and blame difference
Date: Tue, 26 Jul 2011 18:10:05 +0400
Message-ID: <4E2ECABD.7050601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 26 16:10:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QliKh-0004CH-5l
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 16:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135Ab1GZOJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 10:09:57 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57476 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab1GZOJ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 10:09:56 -0400
Received: by ewy4 with SMTP id 4so446645ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=7tB99I3Et0ln2kbCl2sp1gIQsCQeHkB77LWWnxnY6ZY=;
        b=Vjanbonnn9KPb8k41IuGXJGVzI+pR0VPwBQRhpwCbpTlJMja+isAYZcUj8mxf8Vaej
         KZC/mVvRQMISDmuZcPz/JcH+TAEyMaRtlDnQSlN0rPSMnexKyqsusCR6ZZDc5bitc/hE
         6RLZzb/yl3qPJ8FU152u5YjLdJd5bpbJfzuWk=
Received: by 10.204.137.76 with SMTP id v12mr24717bkt.136.1311689395201;
        Tue, 26 Jul 2011 07:09:55 -0700 (PDT)
Received: from [188.233.9.111] ([188.233.9.111])
        by mx.google.com with ESMTPS id p24sm42886bkw.41.2011.07.26.07.09.52
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 07:09:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; ru; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177868>

Hi.

Again, I have to post about diff and blame difference problem.
The initial discussion ends here:
http://permalink.gmane.org/gmane.comp.version-control.git/165012

I have the same problem and now it's about non-whitespace lines. The 
problem is some line is marked in diff as added, but in blame it is 
marked as added in some older revision. And vice versa line is not 
marked as added in diff but it is marked in blame. Here are several 
examples from git repo:

Diff error in revision 198b0fb635ed8a007bac0c16eab112c5e2c7995c in file 
date.c.
Line 184: added in diff, but blame say otherwise.
Line 215: added in diff, but blame say otherwise.
Line 219: added in diff, but blame say otherwise.
Line 259: added in diff, but blame say otherwise.
Line 260: added in diff, but blame say otherwise.
Line 193: not added in diff, but blame say otherwise.
Line 212: not added in diff, but blame say otherwise.
Line 222: not added in diff, but blame say otherwise.
Line 300: not added in diff, but blame say otherwise.
Line 315: not added in diff, but blame say otherwise.

To get diff and blame i've used the following commands:
git --git-dir=D:\src\git\.git diff-tree -p 
198b0fb635ed8a007bac0c16eab112c5e2c7995c -- date.c > diff-tree
git --git-dir=D:\src\git\.git blame -l -s 
198b0fb635ed8a007bac0c16eab112c5e2c7995c -- date.c > blame


I have sent this before, but did not receive any response. I just need 
some type of answer. Something like "we will fix it" or "we don't care 
about it".
