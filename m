From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: What Features Do I loose With git-svn?
Date: Sun, 1 May 2011 01:08:36 +0200
Message-ID: <BANLkTinEgDSFsOj2uY-2WdridoD1ZhQQKw@mail.gmail.com>
References: <1304096029355-6317576.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: ryanzec <basire@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 01 01:08:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGJHJ-0000WO-Sr
	for gcvg-git-2@lo.gmane.org; Sun, 01 May 2011 01:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757726Ab1D3XIi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Apr 2011 19:08:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:41096 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757699Ab1D3XIh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Apr 2011 19:08:37 -0400
Received: by iwn34 with SMTP id 34so3869859iwn.19
        for <git@vger.kernel.org>; Sat, 30 Apr 2011 16:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rsTTQKLZK469rqRrZTko5dvssSKW14yyejMyuyFSQVw=;
        b=pHDYwx8YlaT1CW5OQI1mB+NWYe1j1citEU0HeIDU1JFs4TM/KkoatihMhnG4ABc50O
         kdEi7Ms4UIR5182xcEB0Jdfb9uHvLob0LctbymNUNPT1d7u9YiYPsWoSmP7teb33a+FS
         e6AQXvwyLg7V6lROE4AIfRHhO7y4BeRhtc1s4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CsaWEsRbJKajIyTgDz4WsQVz+LkQ3W3gH5lcbhp84Of4SB2uUgfSRLuvajfYbNA42K
         Hk02OWgLOk5S+ulgvMgohIyyu+X7q5sRj6m+AXUeAhuOvwxmRl278981ZiuTWlCN6OjH
         KS+bgV9re4NL9QG0o7UJ9tGn/LvaaArEP3qS0=
Received: by 10.231.124.74 with SMTP id t10mr5050201ibr.173.1304204916133;
 Sat, 30 Apr 2011 16:08:36 -0700 (PDT)
Received: by 10.231.159.143 with HTTP; Sat, 30 Apr 2011 16:08:36 -0700 (PDT)
In-Reply-To: <1304096029355-6317576.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172526>

On Fri, Apr 29, 2011 at 6:53 PM, ryanzec <basire@gmail.com> wrote:
> I want to use git for a project I am working on however because the p=
roject
> is going to possibility have a lot of binary content in size and numb=
er of
> files (game project), it is probably going to be hard to convince my =
team to
> make the switch since I have no real solution besides just use git fo=
r the
> code and svn for the binary data. =A0I am hoping git-svn will do the =
trick for
> me. =A0The question is are they any features I loose (like cherry pic=
king) or
> anything that I have to look out for (does updating from svn cause me=
rging
> issues just like working all in SVN does).

Subversion does not grok the semantics of a merge. That means that if
you merge in a branch and do an svn dcommit, the svn log will only
contain the commit message of the merge-commit, and have no trace of
the commits that took place out in the branch.

The tidiest way around this is generally to keep history linear, and
avoid merging by doing rebasing instead.

Have a look at the screencast here, it should explain it pretty well:
http://blog.tfnico.com/2010/10/gitsvn-4-collaborate-with-other-git.html

You can still cherry pick. Actually, cherry-picking has served me very
well for doing traditional SVN "merges" (copying a commit from one
branch to the other, instead of that clunky svn merge -c R url .
stuff).
