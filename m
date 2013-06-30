From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH/RFC 0/4] Perl rewrite of Ruby git-related
Date: Sun, 30 Jun 2013 07:08:28 -0400
Message-ID: <1372590512-21341-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 30 13:10:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtFWk-0000iB-Kc
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 13:10:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751916Ab3F3LK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jun 2013 07:10:26 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:50664 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3F3LKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 07:10:25 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so7486245iea.17
        for <git@vger.kernel.org>; Sun, 30 Jun 2013 04:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=grYK39oRdnNijzpI54R6IUXG58wC/j3avehoCfknjE0=;
        b=00ckWNIjCVipsOlyHHhbHXYBilFfi3AP/wybUoSruHb6qdrpmrLkycpQD/dOecsRiw
         v6NyOYyXnYR+Qyj1bkPJAxAz1fdSTcf5/Wjc8NTlqHTlk4VMWbRzVo7CrvPKT73rZyAR
         GJKpcE+dU1RrZIsj7mExanja76qMWqcWtLgpxFJfc88SJ5gwj4LWLvc1Gp9kv124xwVk
         qI6SFa8z79PPd1tx6W7/KHyBQ90WoVLYKf5IkbSefYvGZcWXYqQ8qg6mQZZHK2MF9hw/
         AqW/Wn+EeN0Zt6jy103gvcGGo/m98oSb9RRgWTYnxuOCRetEgWoT9LT5cfJaRo9ZDXJM
         3U5A==
X-Received: by 10.50.164.197 with SMTP id ys5mr11096966igb.3.1372590624743;
        Sun, 30 Jun 2013 04:10:24 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id ir8sm7931119igb.6.2013.06.30.04.10.22
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 30 Jun 2013 04:10:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229266>

This is a Perl rewrite of Felipe Contreras' git-related v9 patch
series[1] which was written in Ruby. Although that series was ejected
from 'pu'[2], Junio suggested[3,4] that such functionality may be a
useful addition to the official tool-chest, hence this Perl rewrite.

In this submission, the command name has changed to git-contacts since
git-related felt too generic. (git-contacts seemed best of several
possibilities I surveyed: git-people, git-interested, git-mentioned,
git-blame-us.)

This rewrite does not maintain perfect 1-to-1 parity with Felipe's v9
series, however, it is close: minor refactoring was done to eliminate a
small amount of duplicate code; patch files and revision arguments are
allowed in the same invocation rather than being exclusive;
"git cat-file --batch" pipe deadlock is avoided; commit messages are
expanded.

No attempt is made to answer Junio's v9 review[5], as I lack sufficient
insight with '-C' options to be able to respond properly.

My Perl may be rusty and idiomatic usage may be absent.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/226065/
[2]: http://article.gmane.org/gmane.comp.version-control.git/229164/
[3]: http://article.gmane.org/gmane.comp.version-control.git/226425/
[4]: http://thread.gmane.org/gmane.comp.version-control.git/221728/focus=221796
[5]: http://article.gmane.org/gmane.comp.version-control.git/226265/

Eric Sunshine (4):
  contrib: add git-contacts helper
  contrib: contacts: add support for multiple patches
  contrib: contacts: add ability to parse from committish
  contrib: contacts: interpret committish akin to format-patch

 contrib/contacts/git-contacts | 164 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100755 contrib/contacts/git-contacts

-- 
1.8.3.2
