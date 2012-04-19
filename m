From: =?UTF-8?B?QW5kcsOpIENhcm9u?= <andre.l.caron@gmail.com>
Subject: git-archive and submodules
Date: Thu, 19 Apr 2012 16:10:52 -0400
Message-ID: <CALKBF2gwVr0rPn0y8=cvwqOsUb7eQPH7EdK5U+gfZMzh=RpiKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 22:11:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKxgw-0001Uu-EW
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 22:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623Ab2DSUKy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 16:10:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:48615 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab2DSUKx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 16:10:53 -0400
Received: by pbcun15 with SMTP id un15so189311pbc.19
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=FqnyakMJcTbGV5oyoF5ps043Ec/lXimP2uyl9nrZ5BI=;
        b=GccR+Jlxwps79GP60TwHHjfslJoHr6WR7JS8NdhANGUld8ayVYRmliKZnjESkjzMtD
         EUZqcA5HPdqwvfcEA/nFBXHnZcWmH5cRGf6f+6QVAQfPcGZP+mw8vNMxcW5eiEr2QnwP
         LjZlvm2a08scXuln/FU5hLrss6buftFKSkvNSCaxYubI83eg+ZZNetWMoMngILppiKST
         P1PO7ZOUxGEqZFFlSJPh+OIV1hTLmU+u+0nUv0YrfSuD38KT4nPXMlg1dXMoo11UiBqx
         4SC0GcsU792td8BU6m5krwAEt45KjJP3LRl8s3IFS/I2woOJOjI+ryeL2OEBmqF81xnP
         PkBg==
Received: by 10.68.219.34 with SMTP id pl2mr1071763pbc.56.1334866252705; Thu,
 19 Apr 2012 13:10:52 -0700 (PDT)
Received: by 10.68.194.34 with HTTP; Thu, 19 Apr 2012 13:10:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195967>

Hi,

I've recently needed to create a source code archive as part of a
custom build target.  This repository uses submodules and I need to
include the submodlule's source code in the archives too.  However,
git-archive does not have any option to do so.

I've taken a quick look at the GMANE mailing list archives and it
seems this provoked quite a discussion in 2009 and that Lars Hjemli
even wrote a patch (in several flavors) for archive.c to include
submodule-aware processing.  The lastest source code at
`git.kernel.org` does not contain any traces of this patch (or
submodule aware logic for that matter).  The mailing list archives are
not very convenient to browse and I can't figure out what the status
on this submodule-aware git-archive idea is.  Has this idea been
completely rejected, or is it still work in progress?

In case you're wondering, I don't seem to be the only one needing to
do this.  I found at least two scripts on GitHub that implement this
logic with various levels of accuracy/completeness[1][2] and I've
hacked an icky Windows batch file version [3] for minimal Windows
support until this feature can be implemented in Git itself.  I don't
mind putting in some time into a real patch if I need to, but I'm
curious about the fact that this has been requested before, a patch
was proposed and yet this is still not merged 4 years later.

So, what's the status on a submodule-aware git-archive command?

Thanks,
Andr=C3=A9

[1]: https://github.com/meitar/git-archive-all.sh
[2]: https://github.com/Kentzo/git-archive-all
[3]: https://github.com/AndreLouisCaron/git-archive-all.bat
