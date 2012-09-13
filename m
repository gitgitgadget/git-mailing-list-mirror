From: Larry Martell <larry.martell@gmail.com>
Subject: inconsistent behavior on mac with case changes
Date: Thu, 13 Sep 2012 15:24:44 -0600
Message-ID: <CACwCsY4iO2WzXizbG+75OJ096OpHp7KOidn4q11nfxnkJuQg_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 13 23:24:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCGu6-00033h-Tp
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075Ab2IMVYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:24:46 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:39113 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab2IMVYp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:24:45 -0400
Received: by vbbff1 with SMTP id ff1so4070316vbb.19
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 14:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=34mC5XfvTD+NHFHh4ha9sOF7GjWzAlO6CP/YLAcwYs8=;
        b=geVe1zYefD1P0tpqUykPIWBRWoW76PdvPUkEB0pVRHlG8db4X0YnwqfUg3HfO9gEXm
         s7luPOrboCR8KI2PWob9Su1AnQUgVJjm3u9Zj4cFSpVrWT0+6SsNl6XpTV9wLhu9LwXO
         aUrTeZii+Y54wcBM/KZJKXb1U1W/EyMpaswLD2aQRouusLCz4sU+A+Mdsq4v4tqw1W9Q
         3i4Gu1ROQYHxrj/0C2W66mix80W12qu8HHjRZ+WIRf/UU5Y8qByd5im2rEWl0QmWLQin
         RbWDYHfk+Ekp/JMJnbi8DH0onT/EFVAZ1vXuASzmzraCy8Lcd+7NE/xw9clQXUcc9aCw
         23WA==
Received: by 10.52.35.174 with SMTP id i14mr276694vdj.87.1347571484780; Thu,
 13 Sep 2012 14:24:44 -0700 (PDT)
Received: by 10.58.198.112 with HTTP; Thu, 13 Sep 2012 14:24:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205430>

I created a dir on my Mac called Rollup, and pushed it out. Then went
to a CentOS box, pulled it, and realized I wanted to call it RollUp
(capital U). I renamed it, and pushed out the change. Went back to the
Mac and did a pull - it said it created the RollUp dir, but it did not
- it was still called Rollup. I reamed it, but status did not pick up
the change. Then I checked out a branch that had Rollup, but it was
gone there - no Rollup or RollUp. I did a merge and then RollUp was
created.

I know the Mac is somewhat inconsistent with how it deals with case, e.g.:

$ ls
RollUp
$ ls -d Rollup
Rollup
$ ls -d RollUp
RollUp
$ find . -name Rollup -print
$ find . -name RollUp -print
./RollUp

So I guess I can understand git also being inconsistent there. But
what really got me was the dir being gone on the branch.

Is all this expected behavior?

-larry
