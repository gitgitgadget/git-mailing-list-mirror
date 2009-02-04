From: Harry Vangberg <ichverstehe@gmail.com>
Subject: git-svn doesn't fetch anything
Date: Thu, 5 Feb 2009 00:49:10 +0100
Message-ID: <941ff7dd0902041549y238f8460m3e1173cee6f44328@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 05 00:50:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUrWA-000637-FO
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 00:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755774AbZBDXtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 18:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757988AbZBDXtP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 18:49:15 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:22920 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759251AbZBDXtO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 18:49:14 -0500
Received: by fk-out-0910.google.com with SMTP id f33so2286257fkf.5
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 15:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=NzMRE4u8lV4p/CSIXigvfckAvhzDNgN96M6rmnSzZ6k=;
        b=w01mSYv/3umJRXa8DDp3j0BET897yq7umWE6USRQMSSxDWZunpZGPK/fEaQ0cEfeR3
         OTXlO4s9e/Tk6HYZawU6DMfeFd74Jp6ENv0p8iHv4pmgPUHBZA/mYUFN1Eyk3QKnzXaZ
         EQbff4p2w0rRO09pxaNwoskFIBeiBBL+eDA9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=rEO1v1DUak9fZ2Kgx8aJqNwWqS144GSBYvLI5grycAPgaue+awmUxGDeF6i1rjLi0i
         awUwHlgpTC3swQrZfZI4hryZcdFBjOB73+romyD67MM1CXAwBOv6k+WyulRsQfZSWhhy
         Us9UtzvJBl0ZnTTgemlUzG4p8vjnr8RzYyzTc=
Received: by 10.180.244.19 with SMTP id r19mr77872bkh.9.1233791350238; Wed, 04 
	Feb 2009 15:49:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108469>

Hello

I have read access to a Subversion repo with standard layout at
https://svn.turntool.com/svn/turntool/plantool

Using git version 1.6.1.2 I would like to use git-svn, so I do a clone:

$ git svn clone https://svn.turntool.com/svn/turntool/plantool -s
--username=harry
Initialized empty Git repository in /Users/h/work/projsvn/plantool/.git/
Error validating server certificate for 'https://svn.turntool.com:443':
 - The certificate is not issued by a trusted authority. Use the
   fingerprint to validate the certificate manually!
Certificate information:
 - Hostname: svn.turntool.com
 - Valid: from Mon, 19 Nov 2007 11:16:34 GMT until Sat, 14 Aug 2010 11:16:34 GMT
 - Issuer: Subversion Repositories, TurnTool ApS, Aarhus C, Jylland, DK
 - Fingerprint: e5:fd:0e:0a:5a:b3:8b:2d:a0:77:16:ac:16:ca:94:a0:ad:1e:15:6c
(R)eject, accept (t)emporarily or accept (p)ermanently? p
Authentication realm: <https://svn.turntool.com:443> TurnTool
Subversion Repository
Password for 'harry':
Authentication realm: <https://svn.turntool.com:443> TurnTool
Subversion Repository
Password for 'harry':
Authentication realm: <https://svn.turntool.com:443> TurnTool
Subversion Repository
Password for 'harry':
W: Ignoring error from SVN, path probably does not exist: (160013):
Filesystem has no item: '/svn/turntool/!svn/bc/100/plantool' path not
found
W: Do not be alarmed at the above message git-svn is just searching
aggressively for old history.
This may take a while on large repositories

I've been told that it is supposed to tell me a lot about fetched
revisions, but there's nothing. And the directory is completely empty
except for .git - here's my config:

$ cd plantool/
$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
        ignorecase = true
[svn-remote "svn"]
        url = https://svn.turntool.com/svn/turntool/plantool
        fetch = trunk:refs/remotes/trunk
        branches = plantool/branches/*:refs/remotes/*
        tags = plantool/tags/*:refs/remotes/

I would really like this to work, so if anybody has some pointers, please.
