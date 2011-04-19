From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Renaming a repo
Date: Tue, 19 Apr 2011 11:02:36 -0700
Message-ID: <BANLkTiknSbWrskhGLWUBEq1=9KV4hC3ttA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:02:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCFG6-0000VA-2m
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 20:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062Ab1DSSCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 14:02:37 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36326 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab1DSSCh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 14:02:37 -0400
Received: by ywj3 with SMTP id 3so1630693ywj.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=xfIK4xL1Q0fbpJ3ClAUh472jbjGQFsGgd7mjXylEvOU=;
        b=ZGX79pqDpzLWcwcmNsb9UcLsXoSlQp7ULVYHv/g2VAlOpDF6cQysQSFc9DCtybDKC5
         GcKzV/WRC3qgeXhJDD0Ea4GndYdvUfY+76bXbKOSZqrrBzLuM0J3k/mh/nDAMFWuMf+n
         Mwt1yJrE8O6G9ZTD/lDDD6F8nl8HPEREEOn28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=lIc88aBcgfphvHnrmao3ZyzMNzi5O8cuPP4rPzHbqgy0QDOo9Mrur76Pfd/wbf7Vv8
         OAVyTqwhVJixXIfM5hZxbv2v4tm5k5RSl3VAYJHMffwZZbKja+VvcyGEj1SzoUHpKoxH
         kRkSyI+p1KUVpOVkkrjnzWGDYQpKPYFPuT34Y=
Received: by 10.236.183.164 with SMTP id q24mr4995204yhm.263.1303236156443;
 Tue, 19 Apr 2011 11:02:36 -0700 (PDT)
Received: by 10.236.111.17 with HTTP; Tue, 19 Apr 2011 11:02:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171806>

Hi all,

I have a hosted Git repo. As such I don't have the ability to touch
the bare repo itself (should that be relevant). I would like to rename
it though. I'd like to know if my approach below is valid.

1. The current repo is 'abc.git'
2. git clone abc.git
3. Create new hosted repo 'xyz.git'
4. git clone xyz.git
5. Copy abc/{.git,*} into xyz/
6. Replace all occurrences of 'abc.git' with 'xyz.git':
6.a. .git/logs/HEAD:00...00 41..53 Hilco Wijbenga <...> 1299100781
-0800      clone: from git@...:abc.git
6.b. .git/logs/refs/heads/master:00...00 41...53 Hilco Wijbenga <...>
1299100781 -0800 clone: from git@...:abc.git
6.c. .git/config:  url = git@...:abc.git
6.d. .git/FETCH_HEAD:41...53              branch 'master' of ...:abc
7. git push origin master

There are no errors or warnings and a subsequent git clone and git log
also seem to work. Is the repo in a consistent state or will I
experience problems in the future?

Cheers,
Hilco
