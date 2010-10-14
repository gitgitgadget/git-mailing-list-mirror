From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: git-svn clone: file outside trunk
Date: Thu, 14 Oct 2010 12:19:00 +0200
Message-ID: <AANLkTimeGZp_SS2oKy3=h48CBMFHeB3NOPvWKsd8NOvi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 14 12:19:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6KuH-0005wn-CG
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 12:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab0JNKTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 06:19:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53287 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab0JNKTX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 06:19:23 -0400
Received: by iwn41 with SMTP id 41so638089iwn.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 03:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=cb/0KxAlWW055R+y5a0j9+cVjUUS6AFNKUnwsyHmJMY=;
        b=Wk/SmukwQ4Yse2t1gqWzGvlSRuYhRmgx14bJ0My2u3rQodt8KujcYSsuUkOQtjGe9E
         rA2vJ7BHSBwRGSFXCv7+V3UPofG61xzUgx7gPb26W+FjJNmcDhiO4kpbf/GGMdnG5rTj
         uYcEZ1qerj5DrQj6GbfOyzT7vf49e91wBocaI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=qSmhMIWfaMfuCZGg6Kn2H6IW2SZxNJnet0xJnII7aXFFeK1Hj0AqTP/DsO9QCTs4tM
         Zb5fgln9VeyRUh3XcFFw+p2Tkd4dh6238WuSaGKiwD/jNNefEbMWCT6fjCSG72lxRDkd
         ZxzYiiBDSxakoVsmj9PA1VT3vWIhwmDKQpTy4=
Received: by 10.231.191.6 with SMTP id dk6mr8316773ibb.51.1287051563119; Thu,
 14 Oct 2010 03:19:23 -0700 (PDT)
Received: by 10.231.34.72 with HTTP; Thu, 14 Oct 2010 03:19:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159043>

Hi,

  I am trying to use git-svn to import an old svn project. I am not
sure I understand the documentation. For instance I am trying to
import a svn project where a portion of the history was directly at
the root level of the svn server. Eg:

  svnadmin create test
  mkdir out && cd out
  svn co file:///tmp/test
  echo "bla" > bla.c
  svn add bla.c
  svn ci -m"First commit"
  mkdir trunk
  svn add trunk
  svn mv bla.c trunk
  svn ci -m"Second Commit"

Now if I try to import it using git-svn:

$ git svn --no-metadata --stdlayout clone  file:///tmp/test
Initialized empty Git repository in /tmp/git/test/.git/
	A	bla.c
r2 = d40bd2cdcc4208f54b4b092dca0a6b3f2b010fd0 (refs/remotes/trunk)
Checked out HEAD:
  file:///tmp/test/trunk r2

Clearly rev 1 was lost. Is there a way to preserve history before the
re-root operation ?

Thanks a bunch !
-- 
Mathieu
