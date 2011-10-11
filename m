From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: "trying out" gitolite with minimum impact on a system
Date: Tue, 11 Oct 2011 22:49:06 +0530
Message-ID: <CAMK1S_g5CnP+vrE71cqMgcjpj8ocE+wdtA2vPjeaXGCRNt25Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 11 19:19:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDfz1-0008EI-5r
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 19:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab1JKRTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 13:19:08 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56807 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab1JKRTH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 13:19:07 -0400
Received: by qadb15 with SMTP id b15so4907490qad.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 10:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=K3Y71d4gklJT9Cgh/651OmQYct7S5QN1jjsOoNRDV2U=;
        b=oWxQh3/xe3JUH6HqeBn5vI3umGIYgIxbj8IDOfMYIdlLvpi1mEwro+vNdeTLnV6ALy
         qwXuusjAnp9jXrBdVFzEopGnxPq+2ie+9clNo3WinJvPIlSwF6u+K+OQTF9fuwfDR2Ux
         PfdfN9O1Y38RLqcAbdMANHtktII0dy2trqep0=
Received: by 10.224.208.199 with SMTP id gd7mr15602948qab.82.1318353547165;
 Tue, 11 Oct 2011 10:19:07 -0700 (PDT)
Received: by 10.224.20.67 with HTTP; Tue, 11 Oct 2011 10:19:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183307>

(This is kind of a record for me, 2 gitolite related emails to the git
ML in less than a month)

If you were in the position of vaguely thinking gitolite may be useful
to you but lacked the time to actually install it to try things out,
this may help.

----

Some folks want to be able to try gitolite's access control features,
play with the configuration language, and so on, but to actually
*install* it seems like a "commitment" of some kind.

Gitolite has always had the ability to be installed *entirely* within
one Unix userid.  Plus, the homegrown test suite I've been using for a
while now has always simulated different "gitolite users" with a bit
of ~/.ssh/config magic.

So I just combined the two, and made the client also be on the same
Unix userid, resulting in this:
http://sitaramc.github.com/gitolite/t/README.html#_playing_with_gitolite

Briefly, it boils down to this: create a user, log in as that user,
clone gitolite, run *one* command.  Done.

After that, entirely within that user, you have an admin user and six
normal users, to do with as you please.  You emulate different users
simply by using a different username in the URL, like "git clone
u1:reponame" versus "git clone u2:reponame".

This gives you a chance to play with the myriad access control
features gitolite has.

When done, delete that user and your system is back where it was.

-- 
Sitaram
