From: "James Sadler" <freshtonic@gmail.com>
Subject: avoiding committing personal cruft
Date: Sat, 21 Jun 2008 23:20:06 +1000
Message-ID: <e5e204700806210620m35fce27eh8eddaf7cb68f1986@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 21 15:21:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KA32D-0004Sp-02
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 15:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbYFUNUJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jun 2008 09:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbYFUNUJ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jun 2008 09:20:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:2509 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbYFUNUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jun 2008 09:20:07 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1281343wri.5
        for <git@vger.kernel.org>; Sat, 21 Jun 2008 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Lb4Xays4DUVH9G6z3IRAA5ZXLhTf3wtVWDeRH+QeNgM=;
        b=vFLOIGNW8eZWCuwCyNyMreLCx9dnsdWJxHsbBNb9CwAaVaILNY0iGGlzReb9iTX25t
         NwxVr1ZVgsY62XQAbjy5LHq9SHvjqrTXH+EMEIzKqea/+nYhZbQpw8OkXGVm8Tpcm5aH
         j7IskujBM4v+ioQFfCC8ZnoNDwqrJZlHDGebQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=rI1e0KzhDE9SlvA7shUDq+JLFc7zZHzvpmIw4yTccS2F7J4EYVL3E3RGFz+ynB9RyB
         Wn+JQZhhPguHdeBqZErwJbXtXiCknU9lqEOZC0rqsgZMm+SdxBHhJHWDb/8Uj5ysOH4c
         Tq2vx6jAuSI60uoQ4dNVuOUKtBTchFgqZqJyw=
Received: by 10.90.29.17 with SMTP id c17mr6417819agc.9.1214054406714;
        Sat, 21 Jun 2008 06:20:06 -0700 (PDT)
Received: by 10.90.114.9 with HTTP; Sat, 21 Jun 2008 06:20:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85707>

I couldn't think of a better subject, so bear with me while I explain.

Let's say I am contributing to some upstream project, and I am hacking on it
inside my local repo's master branch.  Let's also say that I enjoy
using my favourite IDE
which creates its own project files and whatnot, and I don't want to
commit that stuff with the
rest of the project code.  It has no place being accidentally
pushed/pulled upstream.  It's
my personal cruft, hence the subject line.

However, I *do* want to version control my personal cruft, and I can
do that on a separate
branch.  But I want the content of that other branch to exist in the
working tree alongside my
checkout of master.

My current solution basically involves versioning the IDE files on
another branch (named ide-branch),
and using 'git checkout ide-branch .' to overlay the files on top of
the currently checked-out branch (master).

The ide-branch has nothing in it except the cruft from the IDE and the
paths leading up to that cruft.
The master branch has a .gitignore that ignores the IDE files so I
won't end up polluting master by accident.

It's a manageable solution for now.  I tend to think of it
conceptually as 'layering' two branches: I want the
content of both present in the working tree.

I was just wondering if anyone else has tried something similar.


 James.



-- 
Calvin Coolidge  - "I have never been hurt by what I have not said."
