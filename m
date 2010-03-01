From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Gitweb: Scan dir for repos & show these other specified repos
Date: Mon, 01 Mar 2010 11:55:54 -0800 (PST)
Message-ID: <m33a0jn7ft.fsf@localhost.localdomain>
References: <4B8C1267.2050301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mike.lifeguard" <mike.lifeguard@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 20:56:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmBiu-00035G-5G
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 20:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581Ab0CAT4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 14:56:06 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:42207 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab0CAT4D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 14:56:03 -0500
Received: by fxm19 with SMTP id 19so1125278fxm.21
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 11:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=+dgZjtFp8QGpZMUAx0X1lYQjRAgyvJMwkvis+f+jMHM=;
        b=Ems78A4gj0UkRJgnBgaEH1Exe/CVx8nPKJgRYqv7hH2GEd8I9KNV/hFRvKOiuqgMg7
         p5RGuLeqm8ikQLXS5byNByeE5xbT2oNwT8HFssjAXuvn/ToxmQ0MxREwwaAQlF6YKJqH
         9pCRHriCs83I91on96vg1JyVBb0kGmxFQ1dEk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=s2FzEpPF2EOvriFpkg6z3z3Eoj9RYOOXTfOoWTRL0/sGEDI0ZZTwsVa9OTqsSmfyn6
         cRMTBcnmM+iW6lf+5hIY7L5n1ZjTTxYK/oYeo7ByIqZq80lEeA7tEguINGoGPT0Dm9cS
         y6+wkDcwMiVd+Itm25Tx8WFerNRv6KNLZAAL4=
Received: by 10.223.77.66 with SMTP id f2mr5471993fak.84.1267473361516;
        Mon, 01 Mar 2010 11:56:01 -0800 (PST)
Received: from localhost.localdomain (abwj97.neoplus.adsl.tpnet.pl [83.8.233.97])
        by mx.google.com with ESMTPS id p17sm5969810fka.39.2010.03.01.11.55.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 11:55:54 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o21JtDTD030999;
	Mon, 1 Mar 2010 20:55:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o21Jt3lX030992;
	Mon, 1 Mar 2010 20:55:03 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4B8C1267.2050301@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141345>

"Mike.lifeguard" <mike.lifeguard@gmail.com> writes:

> Is it possible to have gitweb show all repositories in /path/to/wherever
> and also show some other repositories at particular locations like
> /home/user/git/repo1 and /home/user2/git/repo2 ? Or better yet, scan
> multiple dirs? Currently I can only see how to do one or the other
> within a single gitweb installation. I suppose I could run two of them...

It is not possible with $projects_list being directory (or undefined,
which means to take $projectroot), but I think it is possible with
$projects_list being a file.

You would have to set $projectroot to common prefix (it might be
empty, i.e. '' if there is no common prefix), then list there all
repositories, relative to $projectroot.  See gitweb/README and
gitweb/INSTALL, and comments in gitweb.perl for details on file
format.


P.S. It probably be a good idea to have something like mod_userdir,
but gitweb currently doesn't support something like that.

P.P.S. Alternate solution would be to try to work around it with
automount / autofs or something like that.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
