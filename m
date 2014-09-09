From: William Clifford <mr.william.clifford@gmail.com>
Subject: [PATCH/RFC 0/2] custom format for interactive rebase todo
Date: Mon, 8 Sep 2014 21:47:56 -0700
Message-ID: <864mwhi9qu.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 08:34:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRF0D-0004qM-FI
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 08:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877AbaIIGd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 02:33:58 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:42071 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbaIIGd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 02:33:57 -0400
Received: by mail-pa0-f47.google.com with SMTP id ey11so6398457pad.6
        for <git@vger.kernel.org>; Mon, 08 Sep 2014 23:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:mime-version:content-type;
        bh=iKXMyLXJEgXMFBd5C49QlxNEt81OUmRRZWrkqmdgGIM=;
        b=OZq6uyvopwzIMQ+ZJaJPekfoZjCaU7xa4dZ/A85PllIxdadJWmA4Wd5q6GH3p/IDxx
         FQ4dQvkwVHDZKZHebKfnFsai4v0CyqF4b5VYr3jd6mVyvvEqZdEWRs5fXSe6fG0g+QbD
         XywP+Amu15hB5UAuIFzXxAPTm2rAhoX6GR+9giRVv9YgABlL0ouS0yND3xL5MJabwMYX
         3jFs7I0A0VqH05eDA6y6oc6RKPYMh/utJ9Q+/ZoceP6EnJwt+W9Tze/n1r5CiRhEOO3h
         HNnO9tXaJNrIGnu6u1bdAkX3MLWGc813Z+LL3KnwXqztZk5VZHuApcKXqTjoSI7FSD2g
         F6eA==
X-Received: by 10.66.139.106 with SMTP id qx10mr54102787pab.126.1410244436875;
        Mon, 08 Sep 2014 23:33:56 -0700 (PDT)
Received: from LOVE-MACHINE (75-175-34-145.ptld.qwest.net. [75.175.34.145])
        by mx.google.com with ESMTPSA id jc3sm3714467pbd.59.2014.09.08.23.33.55
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Sep 2014 23:33:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256683>

I'm sorry if this shows up twice. I messed up the first time.

I was recently in a situation of rebasing a topic branch with many
commits by several colleagues and I thought it would be useful if I
could see the author of the commit in the commit table in the rebase
todo file. I wanted try to squash commits by the same author where
appropriate. With the help of Matt Boeh, we figured out how to patch in
custom formatting of this line, and I have been trying it out for the
last couple of weeks and it seems to work pretty well.

A couple of examples:

- `git config sequence.format "%<(12,trunc)%ae %s"`
- `git config sequence.format "%s <%aN %aE>"`
- `git config sequence.format "%s%n%%n%b"`

The first one tries to conserve linespace, which is a good idea for
these formats. The second one could be really long but otherwise
harmless. I'm unsure what would happen if I tried to rebase with the
third style unedited or uncommented. I'm wary of casually testing it. It
does not seem like a good idea, and should perhaps be discouraged.

Please let me know what you think.

William Clifford (2):
  Add sequence.format to interactive rebase
  Add documentation of sequence.format to interactive rebase

 Documentation/config.txt   |  9 +++++++++
 git-rebase--interactive.sh | 14 +++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

-- 
William Clifford

Message-ID: <867g1dia81.fsf@gmail.com>
X-Draft-From: ("INBOX")
