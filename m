From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Getting a branch's time of creation
Date: Fri, 19 Mar 2010 13:54:41 -0700 (PDT)
Message-ID: <m3pr30jan6.fsf@localhost.localdomain>
References: <27933166.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jateeq <jawad_atiq@hotmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 19 21:54:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsjDW-0004gq-WE
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 21:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667Ab0CSUyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Mar 2010 16:54:46 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:52403 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0CSUyo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Mar 2010 16:54:44 -0400
Received: by fxm19 with SMTP id 19so1016088fxm.21
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 13:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=K8qhNxZvLmg4v2bLcq8AseSg1fqinGb6ucNipKlVdNw=;
        b=E6TJuQyXtdSdqy6KNrbUCDmUHPtyJKrl2JSYnMTJ3CgY46xObV5/PWT9MBThHAtHHn
         U0ICtTmHMifV1r4GHdZpagCPMdsHGngGmOvmUIOqxgIVJZGN44BOwgivS7/WmIIf8RBg
         1PtFEJcK6Xk8RGP+aTS/1Yu6LrXpFH28bAeJU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=kmCT2iXVHbPy4eYLjHuUJvaswTmsI8UqDmf907RHeulC8wumUonfBBNk2OZVYWAnpl
         LeWgdSD3Q4jJd2KvkHV/3JZLCcL1sbkrHwl77JEQMJ3c5rl2i51w4IYKhY3XBIwr7C3F
         8LK/odO7htykQQ3JQRemofABCRJX3N952R+NA=
Received: by 10.223.5.69 with SMTP id 5mr303752fau.8.1269032082840;
        Fri, 19 Mar 2010 13:54:42 -0700 (PDT)
Received: from localhost.localdomain (abve2.neoplus.adsl.tpnet.pl [83.8.202.2])
        by mx.google.com with ESMTPS id b17sm2699411fka.13.2010.03.19.13.54.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 19 Mar 2010 13:54:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o2JKs9xd018086;
	Fri, 19 Mar 2010 21:54:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o2JKrnG7018080;
	Fri, 19 Mar 2010 21:53:50 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <27933166.post@talk.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142646>

jateeq <jawad_atiq@hotmail.com> writes:

> I am trying to find the time at which a remote branch was created, so that I
> can use the '--since' option in git log to limit the commits to only ones
> that were created for that branch (read below to see why I can't use 'git
> log <branchnname>). So my question: does git remember the time at which a
> branch was created, and how can it be listed?
[...]

> If anyone has suggestions on doing this alternatively, feel free to pitch
> in. Thank you.

It looks like an XY problem to me: you are asking how to get about
specific solution, instead of about how to solve a problem.

If you know what branch was remote branch created from, you can simply
use

  $ git log <base>..<branch>

which translates into

  $ git log <branch> ^<base>

which means everything in <branch> that is not present in <base>.
(Assuming that <branch> is the branch you are interested in, and
<base> is the branch it was branched off).

<base> might be result of "git config --get branch.<branch>.merge"
(if the upstream was correctly configured).

You can also get branching point with

  $ git merge-base --all <base> <branch>

-- 
Jakub Narebski
Poland
ShadeHawk on #git
