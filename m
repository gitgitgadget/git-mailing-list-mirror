From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Multiple SVN remote branches listed in "git branch -r" after "git-svn 
	fetch"
Date: Fri, 30 Apr 2010 14:59:23 -0400
Message-ID: <v2q2f0f6ced1004301159z21c3539av4983488df963ddf0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Wage <jonwage@gmail.com>,
	Chap Lovejoy <chap.lovejoy@clickscape.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 30 21:00:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7vRt-0001JZ-PV
	for gcvg-git-2@lo.gmane.org; Fri, 30 Apr 2010 21:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758909Ab0D3S7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Apr 2010 14:59:32 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52266 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933143Ab0D3S7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Apr 2010 14:59:24 -0400
Received: by mail-pw0-f46.google.com with SMTP id 9so336019pwj.19
        for <git@vger.kernel.org>; Fri, 30 Apr 2010 11:59:24 -0700 (PDT)
Received: by 10.115.132.31 with SMTP id j31mr3053927wan.114.1272653963781; 
	Fri, 30 Apr 2010 11:59:23 -0700 (PDT)
Received: by 10.114.159.7 with HTTP; Fri, 30 Apr 2010 11:59:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146045>

So I did a conversion to Git using git-svn.

git init <svn_url>
# updated the .git/config file to reference a few different locations
for branches:
[svn-remote "svn"]
        url = <svn_url>
        fetch = cascade/trunk:refs/remotes/trunk
        branches =
cascade/branches/{hibernate-upgrade,spring-upgrade}}:refs/remotes/*
        branches = cascade/branches/{6.x,5.x,4.x,3.x}/*:refs/remotes/*
        tags = cascade/tags/{3.7.x,4.x,5.x,6.x,old-releases}/*:refs/remotes/tags/*
git svn fetch

Now, I'm seeing branches/tags listed multiple times with: git branch -r

  6.x/6.0.2.1
  6.x/6.0.2.1@12401
  6.x/6.0.2.1@12422
....
  tags/4.x/rel_4_22
  tags/4.x/rel_4_22@4093
  tags/4.x/rel_4_22@4384

What do these other branches with the @ sign mean? Did I do something wrong?

Thanks,
Bradley
