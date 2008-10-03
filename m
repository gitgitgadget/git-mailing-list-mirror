From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Numeric Revision Names?
Date: Fri, 03 Oct 2008 09:07:49 -0700 (PDT)
Message-ID: <m3d4ihr7as.fsf@localhost.localdomain>
References: <19796862.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: marceloribeiro <marcelo@sonnay.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 18:11:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlnF0-0002LL-Sn
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 18:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752424AbYJCQJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 12:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbYJCQJl
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 12:09:41 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:5429 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbYJCQJl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 12:09:41 -0400
Received: by ik-out-1112.google.com with SMTP id c30so1092554ika.5
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=gFGs5aAjd7ac6qumlNqgPhevRf+GCd5kwWSHmEAteFo=;
        b=eB63ZnB69PyThN8uoe6LUS3NQZjvlVSrQ9UvL93ZO+wwq/qEinBmyE5v3SvMTgWbz3
         ytMk+BzUnAnFxXyVsGAF+HHRn8Lb1sEI54ygLCEoTXUWlknh33cRaqEKzXfiT81Hg6Lq
         hanUm7wvAaih83RyYXMBna9mWJjrNnNKHA8W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=QkeSuk0qjKhDBv3UjFUSQgimb5XLUrOnkRKvvvo7GFD6/Y3CSEluQHdi/XYyrzo45r
         Ge1P4yj5oK/lvpK0TMC9vVpLYx6RCvWv0uB9uaMzhll3wRmfmsaao8MISfEZ7dZuCHHN
         M+a59Q5KHMY6GKUnvz2/6wO7zYjdoQvjJifk8=
Received: by 10.210.28.4 with SMTP id b4mr1480563ebb.142.1223050071842;
        Fri, 03 Oct 2008 09:07:51 -0700 (PDT)
Received: from localhost.localdomain (abwi176.neoplus.adsl.tpnet.pl [83.8.232.176])
        by mx.google.com with ESMTPS id b36sm3727404ika.8.2008.10.03.09.07.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 09:07:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m93G7gjo028702;
	Fri, 3 Oct 2008 18:07:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m93G7eE7028699;
	Fri, 3 Oct 2008 18:07:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <19796862.post@talk.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97434>

marceloribeiro <marcelo@sonnay.com> writes:

> I am new to git, and my question may be stupid, but anyway...
> I am used to the numeric revision names on svn, and on Git
> all I get are hexadecimal names.
> 
> Is there any way to configure it to start a projects revisions on
> lets say, revision 0, and keep incrementing it after each commit?
> 
> I tried finding it on git doc but wasnt able to. Maybe I am missing
> something....

First, it is simply not possible to have incremental revision numbers
in distributed version control system like Git, at least not without
some central authority (assigning revision numbers). Other distributed
SCM use simple revision numbers, but either they are local to branch
and local to repository (not shared) as in case of Mercurial, or
require centralized workflow where one uses different merge than in
leaf repositories, as from what I understand is the case with dotted
revision numbers in Bazaar-NG.

Second, in my opinion revision numbers are not that useful for
projects with large number of commits (where revision number might be
something like r4321), and nonlinear history (you don't know how r4555
relates to r4556: they might be on different branches).  Also you
don't have to use full revision numbers: you can use shortened
revision numbers (usually 6-8 characters is enough, e.g. 5f2d4160);
if you use tags to mark released versions you can use git-describe
output to count revisions from given tag (output contains sha-1
because history migh branch after tag, and number of commits since tag
is not enough to determine commit/revision; e.g. v1.6.0-rc3-17-gc14c8ce
which means 17 commits after tag v1.6.0-rc3).

Additionally when using git you usually use transient revision
numbers, counting commits from tip of branch, for example master~5
means 5 commits in first-parent line from what branch 'master' points
to now.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
