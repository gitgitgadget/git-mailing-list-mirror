From: James Denholm <nod.helm@gmail.com>
Subject: [PATCH v2 0/5] contrib/subtree/Makefile: Standardisation pass
Date: Tue,  6 May 2014 22:41:44 +1000
Message-ID: <1399380109-3805-1-git-send-email-nod.helm@gmail.com>
Cc: git@vger.kernel.org, James Denholm <nod.helm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 06 21:13:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiQi-0008Bg-UT
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757320AbaEFMmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 08:42:16 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37032 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756361AbaEFMmP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 08:42:15 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so9325356pdi.16
        for <git@vger.kernel.org>; Tue, 06 May 2014 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=xR0QiaIHo46ApiH3bHXS3+uQOk4BnZ82PsG0FUk7Itk=;
        b=QFU6Bdj3zECwrWo0SZhFXxPvMTtavLQcBtRljctfTZdzOBMxNKlryXC5IBzKnhZDTq
         3Q/+TX5u/mqzvMqbw4n1barRQrnfkHFN7eZ2jW1u1IrcMHQk55x5Xi/hhD+9bl39QfLv
         vojznXLyADTyrUn5jzIX0aSJJvB9lCgFpoLnK1rE7sx1jfL+u2+WivM9Y52FLAvixK1U
         ucotuAEDBGOAY/fZ8NRI+8IVrs9wWLwJBCieENdHeCGg5HPQ/Fon70KmXjzJaW7aRVMh
         y04NdCury9GGQmRMJBnNv656O3A/UXYXno5SNUoQAueiFJbKRFX3xCOzb7uGYZYL37l4
         AESg==
X-Received: by 10.66.186.238 with SMTP id fn14mr6021352pac.135.1399380134425;
        Tue, 06 May 2014 05:42:14 -0700 (PDT)
Received: from localhost.localdomain ([101.119.28.162])
        by mx.google.com with ESMTPSA id iv2sm133398pbc.19.2014.05.06.05.42.11
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 May 2014 05:42:13 -0700 (PDT)
X-Mailer: git-send-email 1.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248216>

contrib/subtree/Makefile is a shambles in regards to it's consistency
with other makefiles, which makes subtree overly painful to include in
build scripts.

The main issues are that calls are made to git itself in the build
process, and that a subtree-exclusive variable is used for specifying
the exec path. Patches 1/5 through 3/5 resolve these.

The "cleanup" fixes (4/5 and 5/5) are based on precedents set by other
makefiles across the project.

One problem is foreseen: 3/5 will necessitate that package maintainers
who already have git-subtree included in their packages update their
build-scripts.

Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: James Denholm <nod.helm@gmail.com>
Based-on-patch-by: Dan McGee <dpmcgee@gmail.com>

James Denholm (5):
  contrib/subtree/Makefile: scrap unused $(gitdir)
  contrib/subtree/Makefile: Use GIT-VERSION-FILE
  contrib/subtree/Makefile: s/libexecdir/gitexecdir
  contrib/subtree/Makefile: Doc-gen rules cleanup
  contrib/subtree/Makefile: clean rule cleanup

 contrib/subtree/Makefile | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

-- 
1.9.2
