From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Merge two different repositories (v2.4 + v2.5) into the one (v2.4 -> v2.5). Possible?
Date: Tue, 11 Jan 2011 05:21:48 -0800 (PST)
Message-ID: <m3lj2rbmq5.fsf@localhost.localdomain>
References: <746745466.20110111134101@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?iso-8859-5?b?sNvV2uHV2SDI49za2N0=?= <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Tue Jan 11 14:22:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PceAu-0006c4-Hp
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 14:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755890Ab1AKNWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 08:22:03 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:55889 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755658Ab1AKNWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 08:22:01 -0500
Received: by wwi17 with SMTP id 17so2684578wwi.1
        for <git@vger.kernel.org>; Tue, 11 Jan 2011 05:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=J4e/U2beb6T6xiW0VOsuMRaO81+mWVOi8PxJtIJOXPs=;
        b=BdDXTMjH7LuldiMAXyILdjSraxxbVug92Sx9uZ936PvivfkIiyM4tdaKMu2RVQH3X8
         i+9M0HVgXFAYsDB8QIBznTRq5oomkJGCLKt4zBy1LfgY4KzFNnjwtnD5sWycov2o8ePT
         kJs1rN9U+tVG/ksCEme4VoVwvklbOTKiTCCXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=C3HJSpddj9wnT019Em3RHeSka8tueWorwujwy8RwzXlek1S2zIB6CC8MJHyreSzlG5
         APfWwtJYQH3CKu5oGJ9pbH2o30QsCgSOGH9+MkV2lsfFPs87ij/J+o2MwoEi8mt1//7t
         F1dZRciFdFVPLgDJ6PL0HQ0iGeeSaDqN4z3dc=
Received: by 10.216.186.144 with SMTP id w16mr19406522wem.13.1294752110276;
        Tue, 11 Jan 2011 05:21:50 -0800 (PST)
Received: from localhost.localdomain (abvb25.neoplus.adsl.tpnet.pl [83.8.199.25])
        by mx.google.com with ESMTPS id p49sm13619355wes.18.2011.01.11.05.21.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 11 Jan 2011 05:21:48 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p0BDL1Gp016840;
	Tue, 11 Jan 2011 14:21:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p0BDKos4016836;
	Tue, 11 Jan 2011 14:20:50 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <746745466.20110111134101@mail.ru>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164939>

=?windows-1251?B?wOvl6vHl6SDY8+zq6O0=?= <zapped@mail.ru> writes:

> 1.5 years ago I had sources of a project in a SVN repository (actually it does not
> matter what SCM was used before). And I had two branches: v2.4 and v2.5.
> They differed enough at that moment and (as usual for SVN branches)
> laid in two different folders.
> Then I had known of Git and I decided to try to use this powerful DVCS.
> But as I was a newbie I created two git-repositories: one per each
> branch. So v2.4 has its own git-repo. v2.5 (and above) has another one.
> 
> Now I'd like to merge them as v2.5 was a continuos branch from v2.4,
> but without a rebasing (i.e. without a global changing of v2.5
> repository, which already has another branches)
> It must look like LAST commit of v2.4 should be a PARENT of FIRST commit of v2.5
> 
> Now there's a question: Is it possible to do so (no rebasing!), and If
> "yes" then how to?

As Andreas Ericsson wrote, you can do this using grafts (and you can
make history with grafts permanent using "git filter-branch").

Better solution might be to use more modern replace mechanism, see
e.g. "git replace" manpage.  Below there is untested step-by-step
instruction.

First, you have put history of v2.4 and of v2.5 in a single repository
(e.g. using "git remote add").  Then you need to find FIRST commit of
v2.5 among

  $ git rev-list master --parents | grep -v ' '

The above finds all parent-less commits in 'master' branch; replace it
with branch holding v2.5 history.  Then you need to find LAST commit
of v2.4 and its SHA-1, e.g. via

  $ git rev-parse v2.4

Save current state of FIRST commit of v2.5 to a file

  $ git cat-file -p FIRST > tmp

Edit this file, adding 'parent' line between 'tree' and 'author'
headers, so the header of this file looks like the following:

  tree 13d050266e05f7c66000240814199fcf3b559d43
  parent ada9983c4256f5a7bac1f7f0e29d52011741d6aa
  author Jakub Narebski <jnareb@gmail.com> 1294231771 +0100

(trailing space added for better readibility).

Then you need to add newly created object to repository:

  $ git hash-object -t commit -w tmp

and then use it as replacement

  $ git replace <SHA-1 of FIRST> <SHA-1 returned by hash-object>

Finally check that replacement works, e.g.:

  $ git show FIRST
  $ git log --graph --oneline -3 FIRST

The anyone who would fetch refs/replace/ would get joined history, and
who doesn't would see it not connected.


P.S. This probably should made it into Documentation/howto

-- 
Jakub Narebski
Poland
ShadeHawk on #git
