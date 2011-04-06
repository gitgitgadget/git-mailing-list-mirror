From: Pau Garcia i Quiles <pgquiles@elpauer.org>
Subject: blobs (once more)
Date: Wed, 6 Apr 2011 10:09:18 +0200
Message-ID: <BANLkTim3kg1ycGkgWsqaZiqMY9LTKV6DBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 06 10:09:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7NoF-0001Ih-4O
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 10:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458Ab1DFIJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 04:09:41 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60951 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125Ab1DFIJj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 04:09:39 -0400
Received: by fxm17 with SMTP id 17so798552fxm.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 01:09:38 -0700 (PDT)
Received: by 10.223.69.131 with SMTP id z3mr696343fai.91.1302077378185; Wed,
 06 Apr 2011 01:09:38 -0700 (PDT)
Received: by 10.223.96.13 with HTTP; Wed, 6 Apr 2011 01:09:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170953>

Hello,

Binary large objects. I know it has been discussed once and again but
I'd like to know if there is something new.

Some corporation hired the company I work for one year ago to develop
a large application. They imposed ClearCase as the VCS. I don't know
if you have used it but it is a pain in the ass. We have lost weeks of
development to site-replication problems, funny merges, etc. We are
trying to migrate our project to git, which we have experience with.

One very important point in this project (which is Windows only) is
putting binaries in the repository. So far, we have suceeded in not
doing that in other projects but we will need to do that in this
project.

In the Windows world, it is not unusual to use third-party libraries
which are only available in binary form. Getting them as source is not
an option because the companies developing them are not selling the
source. Moving from those binary-only dependencies to something else
is not an option either because what we are using has some unique
features, be it technical features or support features. In our
project, we have about a dozen such binaries, ranging from a few
hundred kilobytes, to a couple hundred megabytes (proprietary database
and virtualization engine).

The usual answer to the "I need to put binaries in the repository"
question has been "no, you do not". Well, we do. We are in heavy
development now, therefore today's version may depend on a certain
version of a third-party shared library (DLL) which we only can get in
binary form, and tomorrow's version may depend on the next version of
that library, and you cannot mix today's source with yesterday's
third-party DLL. I. e. to be able to use the code from 7 days ago at
11.07 AM you need "git checkout" to "return" our source AND the
binaries we were using back then. This is something ClearCase manages
satisfactorily.

I have read about:
- submodules + using different repositories once one "blob repository"
grows too much. This will be probably rejected because it is quite
contrived.
- git-annex (does not get the files in when cloning, pulling, checking
out; you need to do it manually)
- git-media (same as git-annex)
- boar (no, we do not want to use a VCS for binaries in addition to git)
- and a few more

So far the only good solution seems to be git-bigfiles but it's still
in development.

Is there any good solution for my use case, where version = sources
version + binaries version?

Thank you.

If we suceed with git here, the whole corportation (150,000+
employees, Fortune 500) may start to move to git in a year. Many
people are fed up with CC there.

-- 
Pau Garcia i Quiles
http://www.elpauer.org
(Due to my workload, I may need 10 days to answer)
