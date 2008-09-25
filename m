From: "Michael P. Soulier" <msoulier@digitaltorque.ca>
Subject: having to pull twice
Date: Wed, 24 Sep 2008 20:58:20 -0400
Message-ID: <fb6605670809241758r186eef51sc6ed6d334a64495d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 25 02:59:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KifCd-0008V0-64
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 02:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbYIYA6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 20:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752079AbYIYA6W
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 20:58:22 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:37767 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbYIYA6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 20:58:21 -0400
Received: by gxk9 with SMTP id 9so6458995gxk.13
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 17:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=3j8JrQENqHFXmBcVSZ5sPe48vP8EXj3Xg09I3Vz+q1Y=;
        b=M87tqNH5S820lLsa1otT1/yGA92sZfbBV21IrNjm93C3CVUmC7qfM3KB3CdTHM8IXi
         B4RO9DBGjEyhlO+yVK8nWoaxkW1NA7qKIm8x33qSnswyN4ZOafRix9rFhkfLDW3xiY7A
         IZkmNe/gHeseA8dUKDvuLB/GqGlVbg5JHDCN4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=shezAC0X4W1lUYsnN/gqJzbrAoVnnKJE/m9uZMdAHoJQI4Advz/2lJfhcetYERD4gT
         w5gFi2MhHg/oTJVK5Onl/07In3RTBPO1irIrVs7PTuRwiR58kdaw0nT3VDHB79hGBCN+
         PFeKCoZ739sea2P/2DNhC4bvbGunmdih5H0cM=
Received: by 10.151.100.17 with SMTP id c17mr12035855ybm.2.1222304300265;
        Wed, 24 Sep 2008 17:58:20 -0700 (PDT)
Received: by 10.151.142.19 with HTTP; Wed, 24 Sep 2008 17:58:20 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: e2f708da0420093b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96721>

I'm finding this happening from time to time.

soulierm@espresso:~/work/mitel-msl-tug$ git pull
remote: Counting objects: 97, done.
remote: Compressing objects: 100% (54/54), done.
remote: Total 65 (delta 34), reused 0 (delta 0)
Unpacking objects: 100% (65/65), done.
From pa:git/mitel-msl-tug
   92437d6..9c784c8  master     -> origin/master
Updating 92437d6..9c784c8
error: Entry 'mitel-msl-tug.spec' not uptodate. Cannot merge.
soulierm@espresso:~/work/mitel-msl-tug$ git status
# On branch master
# Your branch is behind 'origin/master' by 4 commits, and can be fast-forwarded.
#
nothing to commit (working directory clean)
soulierm@espresso:~/work/mitel-msl-tug$ git pull
Updating 92437d6..9c784c8
Fast forward
 mitel-msl-tug.spec                                 |    7 +-
 .../etc/e-smith/pgsql/init/tugdb.sh/20auth         |    4 +-
 .../etc/e-smith/pgsql/init/tugdb.sh/50apps         |   37 ---
 .../etc/e-smith/pgsql/init/tugdb.sh/90loaddata     |    8 +-
 .../etc/e-smith/pgsql/init/tugdb.sh/95schema       |    2 +-
 root/etc/e-smith/templates/etc/tug/tug.ini/00setup |    2 +
 .../e-smith/templates/etc/tug/tug.ini/10teleworker |   37 +++-
 .../templates/etc/tug/tug.ini/11teleworker_fixed   |    1 -
 .../e-smith/web/django/teleworker/scrc/views.py    |   11 +-
 root/usr/lib/scrc/migrate.pl                       |  322 --------------------
 root/usr/lib/tug/migrate/30_add_scrc               |    2 +-
 root/usr/lib/tug/migrate/31_add_scrc_connections   |   22 ++-
 12 files changed, 77 insertions(+), 378 deletions(-)
 delete mode 100755 root/usr/lib/scrc/migrate.pl
soulierm@espresso:~/work/mitel-msl-tug$ git --version
git version 1.6.0

When I pulled the first time, I was told that one of the files was
 not up-to-date, but status did not note any modified files. The
second pull then worked as expected.

That directory is mounted via NFS, and I'm curious as to
whether some kind of time skew could be the problem. But
then, if it is, why did it go away after the first pull?

Thanks,
Mike
-- 
Michael P. Soulier <msoulier@digitaltorque.ca>
"Any intelligent fool can make things bigger and more complex... It takes a
touch of genius - and a lot of courage to move in the opposite direction."
--Albert Einstein
