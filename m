From: Amit Bakshi <ambakshi@gmail.com>
Subject: git-archive --worktree-attributes (1.8.2)
Date: Tue, 9 Apr 2013 13:43:32 -0700
Message-ID: <CAFGOX=VXifkn4oNkqLLF_WG5Dzf4rjd15EV7C=9a_H9CTM+w2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 22:43:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPfOD-0008Lg-IK
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 22:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936293Ab3DIUnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 16:43:33 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:54665 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754147Ab3DIUnc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 16:43:32 -0400
Received: by mail-ie0-f170.google.com with SMTP id c11so9157990ieb.15
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 13:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=HQumqMa6LFOWXl4N3r4WrAdkhtKDF12RJ8MhS7Og+uk=;
        b=uUXD4dGZyAp9I4SCe18ncIqNp2Pf+Si7vAyLDpMKGlMq4cBVxezP1g/1fzeKItAq8s
         UZDw2n7SVETuqnkUvP8I/r8KXCgH/tT8JTXXDv/qz845wqapC7VjDiOdmkvn9I53GnK/
         JyuVNNtcT1gQHHwznZ7P8596kEzeE3JfpKH6baWFEO3oVVP6fl0pABKGjhkDuEinQPUq
         g9STn9U6xGUGvFeHjf6dMgKdiH/t97S2VBNi/0tz7sXEUzvKnMWjcu8kcBiPpUs47/2j
         zFbUB9QBmYbzGRJ5q68JvIQ3qNFc05pJkoQy/fv5EiHR1zbJaxrtBa6rS35udXG+Zel8
         UW7g==
X-Received: by 10.50.136.130 with SMTP id qa2mr13093711igb.1.1365540212211;
 Tue, 09 Apr 2013 13:43:32 -0700 (PDT)
Received: by 10.64.250.168 with HTTP; Tue, 9 Apr 2013 13:43:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220632>

Hi,

 In the help for git-archive it states:

       --worktree-attributes
           Look for attributes in .gitattributes in working directory too.

This doesn't seem to be the case. I have a use case where I need to
archive a remote I don't have write access too (via --remote=), and I
wish to ignore certain paths. When I chdir to a temp dir, create a
.gitattributes file, and call git archive --worktree-attributes, the
bevaviour I see is that it is ignoring .gitattributes. I've tried
setting GIT_WORK_TREE to my temp dir, without success. Is the
documentation wrong about 'working directory'? Did it mean to say
'working tree'? Looking at the source for archive.c, it seems to
assume a GIT_WORK_TREE.


Would you accept a patch that either adds an option to explicitly set
the .gitattributes file or would let --worktree-attributes look in
$PWD.

Thanks,
Amit
