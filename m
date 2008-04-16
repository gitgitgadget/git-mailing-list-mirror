From: Bob Cotton <bob.cotton@gmail.com>
Subject: git-push: "error: pack-objects died with strange error"
Date: Wed, 16 Apr 2008 12:55:59 -0600
Message-ID: <m11w55wrwg.fsf@boblaptop.clubcotton.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 21:15:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmCof-0006a5-FF
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 20:57:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbYDPS4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 14:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbYDPS4K
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 14:56:10 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:52584 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbYDPS4J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 14:56:09 -0400
Received: by py-out-1112.google.com with SMTP id u52so3518342pyb.10
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 11:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:message-id:user-agent:mime-version:content-type;
        bh=wrj54eYDkp8EUzbqdvLPkge6OljrwyhnnYR8u2a1CC4=;
        b=R8JKIVBRfEP4bG3vG6wID7qz+ZBgKXBxl0CbJJRym4wMBX3ab2TNgu8hxZugnWprjnXLGzhnEzzMlMyaoRRIObzHYWJO64q+pfXY539wZLCOSQ5tELFAY+rFFMzedUE6Zifh1KARukRwa6S2sBgL+V87guTaZURnS9rljwLlce0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:user-agent:mime-version:content-type;
        b=pNQAMexbk5dvmT0/geT1UJIJmm+Q+54+brMY4PFDR611ufAFOnAfO4mxCREtG6dQL3++Tro5ce7shlSQEs1SuDh1Tu9IWqFTR+LSwLjLrHZl6zrKW+bPeQnz37lTx+PW7mAEHMYMdFDn5RBVkHIlBLH0oTGzVZicSJn4OW0eAc0=
Received: by 10.35.44.16 with SMTP id w16mr569660pyj.36.1208372167169;
        Wed, 16 Apr 2008 11:56:07 -0700 (PDT)
Received: from boblaptop.clubcotton.homeip.net.rallydevelopment.com ( [67.88.103.130])
        by mx.google.com with ESMTPS id a22sm12159273pye.33.2008.04.16.11.56.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Apr 2008 11:56:05 -0700 (PDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.1.91 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79725>


So I've got this repo managed by git-svn. I have a topic branch that's
not going into svn, but I wanted a backup.

In a directory managed by git-daemon:

        server          = /usr/bin/git-daemon
        server_args     = --inetd --export-all --base-path=/export/git

I created an empty repo:

  mkdir bcotton.git
  cd bcotton.git
  git --bare init --shared 
  git config daemon.receivepack true

Then from my repo, I tried to push my work into it:

  git remote add backup git://git/bcotton.git
  git remote update backup
  
  git push backup <topic>

  Counting objects: 108733, done.
  Compressing objects: 100% (39375/39375), done.
  error: pack-objects died with strange error
  error: failed to push some refs to 'git://git.f4tech.com/bcotton.git'

git fsck --full is clean.

There is nothing from git-daemon in syslog

Ideas?

 -Bob
