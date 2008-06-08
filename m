From: Jakub Narebski <jnareb@gmail.com>
Subject: [BUG] git-branch -m cannot rename remote branches
Date: Sun, 8 Jun 2008 22:57:19 +0200
Message-ID: <200806082257.20833.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 08 22:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Ry1-0005Gj-6o
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 22:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbYFHU51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 16:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754669AbYFHU51
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 16:57:27 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:46723 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383AbYFHU50 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 16:57:26 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1170568ywe.1
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 13:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=KF3/DH3ySfHHS1cAP4iAkXk056yOuApqR+aRBMQ0eNg=;
        b=SRmxWCpaiFS3gMx6B7JyZJsfnrVexhz+ju4n2v8AbVmAM3RZURjGErvUDasefurtuv
         DkU2JWQBcOeqvlme2DglCsKdxIXPBImaJ+iG2A8NHbV9d4mAdkmTY5bXY141RR4rDrGS
         EABv76SBpfjeYvXyx9GLfmQuqD/3M9sCv0rh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=uctLyxhXMiTv6oJnkAc0/4ytI+o6mfiz/0K7JkVYe1x+U3DTuYMn6l94QyHRdefK6t
         jjgDSVZbSFaQfnqTqUQgxyAHfEw61QVXTyBQYZKi/gOh5kU6UZC9r77EM7jcrJ9v3eqN
         u8+cIv2/CFg15ct9BZeN5lFteYMUbmNCNJMzo=
Received: by 10.67.115.17 with SMTP id s17mr1198273ugm.56.1212958644024;
        Sun, 08 Jun 2008 13:57:24 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.161])
        by mx.google.com with ESMTPS id r38sm1135216ugc.67.2008.06.08.13.57.21
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 13:57:23 -0700 (PDT)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84318>

I cannot rename remote branch (possibly packed, and possibly with
reflog) using "git branch"

[gitweb/web@git]$ git branch -m refs/remotes/gitweb-caching/master \
                                refs/remotes/gitweb-kernel.org/master
error: refname refs/heads/refs/remotes/gitweb-caching/master not found
fatal: Branch rename failed
[gitweb/web@git]$ git branch -m gitweb-caching/master \
                                gitweb-kernel.org/master
error: refname refs/heads/gitweb-caching/master not found
fatal: Branch rename failed
[gitweb/web@git]$ git branch -m remotes/gitweb-caching/master \
                                remotes/gitweb-kernel.org/master
error: refname refs/heads/remotes/gitweb-caching/master not found
fatal: Branch rename failed

-- 
Jakub Narebski
Poland
