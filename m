From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: From P4 to Git
Date: Tue, 28 Jul 2009 14:10:16 -0700 (PDT)
Message-ID: <m3fxcg3473.fsf@localhost.localdomain>
References: <85ljm84lat.fsf@oqube.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arnaud Bailly <abailly@oqube.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 23:10:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVtwO-0005cl-3H
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 23:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbZG1VKV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 17:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754560AbZG1VKU
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 17:10:20 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:41787 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240AbZG1VKT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 17:10:19 -0400
Received: by fxm18 with SMTP id 18so22847fxm.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 14:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=FulEaAYfO8Fan0Ozx3q3iAPfdM3HYbD1UZ3ENmV76Z8=;
        b=EY095O1c+RMaNutuWJMhToDNH4557D6LtWIBKl3J6lTLCCkn+vOCfbBwrNWvFpmHpo
         RWL8em7MLEMUDsJrETy078OMDIt3pvQQ1qy/TmYal5WCfvaQifHPf/t/TAoY767AC5tk
         GB0ZMMsLlmXWUdgQXsLJPm0JNtAbI+/CsdEUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=XKgLfp/fC+FxlthQbNRyqkycCBm5Xp2CletrFndfwwSdLwMaXI3shnuS6LSFa2ZmD9
         Xjypp9rCUc2wOZJu8nXoWrmmrZtT+0vITLaDtaC+IcQ/dYLUWyAEV5T+SqM7vUY7Bpyt
         EXd3vNFmYWWeEbjvXp5j3H4ReISOTxLBZbpHM=
Received: by 10.103.248.17 with SMTP id a17mr4149294mus.97.1248815418178;
        Tue, 28 Jul 2009 14:10:18 -0700 (PDT)
Received: from localhost.localdomain (abvm110.neoplus.adsl.tpnet.pl [83.8.210.110])
        by mx.google.com with ESMTPS id y6sm1266582mug.10.2009.07.28.14.10.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 14:10:16 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6SL9kqF010237;
	Tue, 28 Jul 2009 23:09:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6SL9RUD010233;
	Tue, 28 Jul 2009 23:09:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <85ljm84lat.fsf@oqube.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124275>

Arnaud Bailly <abailly@oqube.com> writes:

> I am investigating the use of Git in a setting where we:
>  1. branches a lot

Git handles large number of branches very well.  

The workflow of topic branches, where each new feature is developed on
separate branch, which can be individually picked to be merged (or
not) is used by git itself, for example.

>  2. have a very large codebase

How large codebase?  What it means "large codebase"?  Large number of
files, or files large in size (usually binary)?


Git can deal comfortably with codebase of the size of Linux kernel.
Perl 5 core was converted from Perforce to Git.

But git is snapshot based, not changeset based, and treats project
(repository) as whole, not as a combination of single file histories.
This means that it would be unproductive to use 'everything in single
repository' approach.  If your codebase is of the size of whole KDE
tree, or the whole GNOME tree, you would need to organize it and split
it into smaller, reasonably sized repositories (you can urganize them
back together in a superproject using submodules).

If ou can't do that, you would probably be better with other version
control system, like Subversion (IIRC both KDE and OpenOffice.org
chosen this free centralized version control system).


Because Git was created to version control source code, it might not
work well with large binary files, meaning that performance would
suffer.  

Partial checkouts (where you check out only part of repository) were
proposed, but are not implemented yet.  Neither did lazy clone /
remote alternates idea.  You can do a bit with undocumented `delta`
gitattribute, and with putting large binary blobs into separate
packfile, which is 'kept' (using *.keep file) against repacking, and
perhaps available on networked filesystem.

I think you can use refs/replace/ mechanizm (IIRC currently in 'pu',
(proposed updates) branch) to have two versions of repository: one
with binary blobs and one without.

> 
> Given Git is developed to handle these 2 issues, I suspect it would be a
> very good choice, but I need to gather some experiments feedback and
> hard figures on how Git performs (storage use, necessary
> bandwidth/resources, maintainance of repositories, cleanup & gc...).
> 
> For the experiment part, I am started working on it but would be
> interested in other people's experiences.

Check out Sam Vilain (?) reports from converting Perl 5 repository
from Perforce to Git.

> 
> For the figures part, I think I read somewhere there exists some
> statistics on Git usage for Linux kernel. Is this correct ? If true,
> where could I find them ? 

There is GitStat project: http://mirror.celinuxforum.org/gitstat/

There was also Git-Statistics project at Google Summer of Code 2008
which repository can be found at http://repo.or.cz/w/git-stats.git
See http://git.or.cz/gitwiki/SoC2008Projects

> 
> Thanks in advance for answering my (maybe pointless) questions and for
> producing such a nice piece of software.
> -- 
> Arnaud Bailly

-- 
Jakub Narebski
Poland
ShadeHawk on #git
