From: Igor Lautar <igor.lautar@gmail.com>
Subject: commit gone after merge - how to debug?
Date: Mon, 26 Nov 2012 14:06:09 +0100
Message-ID: <CAO1Khk_eugH--wp3s-gr4HTvuRyL=SaWHWtEXCRZ_Ak7+s5U=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 14:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TcyOI-0007p1-Kv
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 14:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018Ab2KZNGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 08:06:11 -0500
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52654 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab2KZNGK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 08:06:10 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so5564590vbb.19
        for <git@vger.kernel.org>; Mon, 26 Nov 2012 05:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=scoTAbUYwmfinWPzHfYxvXaLJfav42JForLQl1J9wHY=;
        b=KSd476o9pI3o6Rbsv0IrgoR6mjEOhryfxRRgYQuXcS/pxpqj0d0DHtSuaRUDeMFIDg
         +v3+XiMtaoROoGYGLxZQo//bBSuE0jd9XwK5Y6HliDPUcMosMITPYnrczcJP25niNbMq
         j50BUXXhkZNkrP79NhBjzVWzIj5OdrJKBj4IA9yx/k3l6ny8Wz0bYIebnxFydwoOlMVP
         VDObO5F9EDVuuuk+KHAPat1k7RYOqxhPKIzuq0YJ7b2nC57kT8Q43iI8echbFDm+cO7J
         o0vbsYrheLYkrhNEYOmtwRor/FIvpTxacC85lLwkb11gvnoUzd0yVUCFXnUdn23MQ134
         9m+Q==
Received: by 10.52.70.8 with SMTP id i8mr16435651vdu.24.1353935169653; Mon, 26
 Nov 2012 05:06:09 -0800 (PST)
Received: by 10.58.69.112 with HTTP; Mon, 26 Nov 2012 05:06:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210438>

Hi,

This looks really weird and I cannot explain why it occurs.

Setup is as follows:
 - origin
 - mirror
 - local clone

Reference repository is origin from where builds are done etc.
Parallel to that, we keep a mirror that is synced manually
(fetch/merge/push).

I do this from my local clone (which is mostly just tracking origin
and mirror, no local branches).

What happened is that after a merge of mirror/master into local
master, a commit (that also exists on origin/master) is lost.

Lost as in:
pre-merge:
git log <file modified by commit>
 - commit shown in history
git merge mirror/master
 - no conflicts
git log <file modified by commit>
 - commit NOT shown in file history any more and file does not have this change

Doing git log shows commit as being present in repository history. One
interesting point is that one of the parents is previous merge commit
of same branches.

Unfortunately, I cannot open up repository for public access, but
would appreciate any pointers how to debug this.

git fsck finds some dangling blobs/commits, but no other
warnings/errors, I can clone repo just fine, everything seams in
order.

How can I debug what the merge is doing?

git version 1.7.12.1 on mac:
Darwin 12.2.0 Darwin Kernel Version 12.2.0: Sat Aug 25 00:48:52 PDT
2012; root:xnu-2050.18.24~1/RELEASE_X86_64 x86_64

Regards,
Igor

PS. please keep me in CC, I'm not on list
