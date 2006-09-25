From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/5] gitweb: A few code cleanup patches
Date: Tue, 26 Sep 2006 01:53:08 +0200
Message-ID: <200609260153.08503.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 26 02:00:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS0Mu-0005e8-Tz
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 02:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778AbWIZAAG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 20:00:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751787AbWIZAAG
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 20:00:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:45144 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751778AbWIZAAC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 20:00:02 -0400
Received: by ug-out-1314.google.com with SMTP id o38so538800ugd
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 17:00:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=OwbRSx5PpjPmZK+1uVAmSQDOVKc9JF5/qjF97El/RoNB/h/Q1yULNuYRvK7tWRuu5ECkC3lNXDv8RVCuF8IIK9mdFxIl63gQG6vSesJAPEF/+CcLsWXhGd5ECA78co6tu5fDBovsQPDBfcTGUlC2QGPF5j/w4asxfw17uFG8zoE=
Received: by 10.66.216.6 with SMTP id o6mr88391ugg;
        Mon, 25 Sep 2006 17:00:00 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id s1sm2153117uge.2006.09.25.16.59.59;
        Mon, 25 Sep 2006 17:00:00 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27757>

This series of patches, based on 8391548e5e78677eb81f97334d998418802ea194
adds some code cleanups (including validating input and escaping output).
Most deals with changes introduced in
  [PATCH] gitweb: Consolidate escaping/validation of query string
  commit a2f3db2f5de2a3667b0e038aa65e3e097e642e7d (by Petr Baudis)
  Message-ID: <20060923221841.18063.56589.stgit@rover>

Shortlog:
 [PATCH 1/5] gitweb: Strip trailing slashes from $path in git_get_hash_by_path
 [PATCH 2/5] gitweb: Use "return" instead of "return undef" for some subs
 [PATCH 3/5] gitweb: Split validate_input into validate_pathname and validate_refname
 [PATCH 4/5] gitweb: Add git_url subroutine, and use it to quote full URLs
 [PATCH 5/5] gitweb: Quote filename in HTTP Content-Disposition: header

Diffstat:
 gitweb/gitweb.perl |  100 +++++++++++++++++++++++++++++++++++++---------------
 1 files changed, 72 insertions(+), 28 deletions(-)

-- 
Jakub Narebski
ShadeHawk on #git
Warsaw, Poland
