From: Jon Seymour <jon.seymour@gmail.com>
Subject: git rev-parse --git-dir does report yield relative path to git
 directory, per documentation
Date: Thu, 17 May 2012 19:03:28 +1000
Message-ID: <CAH3Anrrb243zdRJJEqDcWrHBVBDdYkGB=sTG7BbjTzsUHvWY-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 17 11:03:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUwcT-00034C-Ae
	for gcvg-git-2@plane.gmane.org; Thu, 17 May 2012 11:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759588Ab2EQJDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 May 2012 05:03:31 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:53052 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759369Ab2EQJD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2012 05:03:29 -0400
Received: by weyu7 with SMTP id u7so1006161wey.19
        for <git@vger.kernel.org>; Thu, 17 May 2012 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=3FOOcvnJgdzzZ+bserTlprG0ilqMqjTIt5dsLdGfUrc=;
        b=tvqZGNCS4U9w9XjOu8wGTVj+5VZFXQBu6aAZ8GtqrMNtwK9RaV3JpL2O1Suyig5poj
         kcXgw8KGY2L6dXB/ue6DSVq+cfGDtXlgBhzUALu3JLMvvHdgiQ/neAmsTacKse5uQhZa
         9E1+kJtzLL/Jf7pMUYjvmCQkSqxXYx2Er52rV8PytHhevuiTBWxDmIboqwrTY0Mo++r9
         o4JXB12OEa6PGUKHj77aYPYtB3tdOTuBuXq/rNbO+BerjLuzhhPbhxrpbF/EAAnPoB1k
         nWGklHkRCjogNGb4YohP03U3zfI27+G4GM+w6kuqNucWV0QKSKxdq9CbCizRSTnTLIsI
         AMDg==
Received: by 10.180.75.241 with SMTP id f17mr16193952wiw.11.1337245408053;
 Thu, 17 May 2012 02:03:28 -0700 (PDT)
Received: by 10.180.83.131 with HTTP; Thu, 17 May 2012 02:03:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197913>

Per this advice in git-rev-parse(1):

     Show $GIT_DIR if defined. Otherwise show the path to the .git
directory, relative to the current directory.

I had expected this:

cd /tmp &&
rm -rf foobar &&
mkdir foobar &&
cd foobar &&
git init &&
mkdir tmp &&
:> tmp/.gitignore &&
git add tmp &&
cd tmp &&
git rev-parse --git-dir

to report:

Initialized empty Git repository in /tmp/foobar/.git/
../.git

but in actual fact it reports:

Initialized empty Git repository in /tmp/foobar/.git/
/tmp/foobar/.git

git version 1.7.10.1.514.ge33c7ea

Am I misunderstanding the meaning of the term "relative" in quote above?

jon.
