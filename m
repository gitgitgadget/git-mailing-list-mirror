From: Lea Wiemann <lewiemann@gmail.com>
Subject: perl/Makefile if MakeMaker is not installed (NO_PERL_MAKEMAKER)
Date: Sat, 14 Jun 2008 00:35:41 +0200
Message-ID: <4852F63D.802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 14 00:36:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7Hss-0002ye-9R
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 00:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbYFMWfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 18:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755028AbYFMWfl
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 18:35:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:53015 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755189AbYFMWfk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 18:35:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2893151fgg.17
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 15:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:subject:content-type:content-transfer-encoding:from;
        bh=e3Sjla1VSzB2HxEuOMMGrArShI0sw2ApATNYOaimGfg=;
        b=YTu3461KQMn69aVH82Zx7CN2nx2uVIULOfg9yZi3FODDkw4AIL8JDUTaAUQP3x/xxA
         bOyjvJU3ELHpRAtY9AtdgAh9l7kM85GPFWyiIC1aspcuSq04jdeWOGko/q+qdMVNOiQj
         VUOrgXkfgBzTHyuRE+9FxOiyrHizZt4agrNH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding:from;
        b=FYzIO/SwJvXthtYZmKvKhyNntFNtYwJQ/KOqMGkkmWYtGM+bvCba1rwfidAcWuImkp
         XX73AgQg72bhsPR9Pj2iGecDlMHl7Z9XCZYhCasO4y20MfjZai3XesXtKyMSFtuy8aHb
         9hHAxO+A3pb/1fRDN9APabGr0FfVC4d8PBezg=
Received: by 10.86.52.6 with SMTP id z6mr4703245fgz.48.1213396537284;
        Fri, 13 Jun 2008 15:35:37 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.222.17])
        by mx.google.com with ESMTPS id e11sm6091015fga.4.2008.06.13.15.35.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Jun 2008 15:35:36 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84947>

I just wanted to report that Git.pm is installed to $(prefix)/lib if 
NO_PERL_MAKEMAKER is set, which doesn't seem right.

$ make NO_PERL_MAKEMAKER=yes prefix=$HOME/tmp/git-install install
[...]
$ find ~/tmp/git-install -name \*.pm
/home/lea/tmp/git-install/lib/Git.pm
/home/lea/tmp/git-install/lib/Error.pm

Without NO_PERL_MAKEMAKER, it works fine:

$ make clean
$ rm ~/tmp/git-install -r
$ make prefix=$HOME/tmp/git-install install
[...]
$ find ~/tmp/git-install -name \*.pm
/home/lea/tmp/git-install/share/perl/5.10.0/Git.pm

-- Lea
