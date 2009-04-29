From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: git svn errors out with git-cat-file "usage" message
Date: Wed, 29 Apr 2009 17:11:15 +0200
Message-ID: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mihai Sucan <mihai.sucan@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 29 17:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzBRW-0000Jk-DS
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 17:11:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbZD2PLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 11:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752354AbZD2PLS
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 11:11:18 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:42811 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbZD2PLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 11:11:17 -0400
Received: by fxm2 with SMTP id 2so1242363fxm.37
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=yta0zwUtalXzSW8/vQ63HVRjI8P8L9U+NDFIIVqqoi4=;
        b=jvFOAZSUCeP9GCksJaiY01zbi0NYk8Geuf85Hjky0Gsair26Oj42rn1MPfBIxGznay
         1PJaynf9A8fJ9WB8g6ptXwyFSe1gyw5H7RZOauJLp1qQ5P4FrhjNuNL4XRxfIxo5I7sa
         3apYv5ZeMOU38uuNZWK+mDxqJtJg2BtUtbnXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Y+tB5lNp3Yytbd6HisnWt9UktCDw862fYjfXr/qGLhwn4POfbImSh+nYmW1DNSd9i2
         +XabBE2W69QVVp+2aBjBItIimu78iayENUHYVsdcia7kPn8OXziyCSIFV+zacT8OiNqm
         1v6NYLk+IIeKj5IVCcBswVnwUzZQdeziaAf/A=
Received: by 10.223.126.145 with SMTP id c17mr276788fas.16.1241017875579; Wed, 
	29 Apr 2009 08:11:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117895>

There is very small public SVN repo that I'm trying to clone with SVN,
and seems to trigger a big in git-svn.

Steps to repro, and error message:

$  git svn clone -T trunk --ignore-paths releases
http://paintweb.googlecode.com/svn paintweb.git
r3 = 30548c9192aefcde23337f70542ab59e193a1b9e (trunk)
usage: git-cat-file [-t|-s|-e|-p|<type>] <sha1>
fatal: unable to run 'git-svn'
$ git version
git version 1.6.2.4.10.g2254d <== this is maint as of right now

The same problem exists with master as of right now (v1.6.3-rc3-12-gb79376c)

On a different box it succeeded -- this was a Fedora 9 box, with git
from rpms. I did have to drop the '--ignore-paths' paramater though:
$ git --version
git version 1.6.0.6

any hints as to what could be wrong? The repository is small and
pretty vanilla afaics...

cheers,



martin
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
