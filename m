From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Sun, 05 Sep 2010 21:48:06 +0200
Message-ID: <i60s5p$vii$1@dough.gmane.org>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com> <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com> <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com> <20100831143839.GC16034@foucault.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 05 21:48:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsLCV-0003yb-TV
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 21:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753064Ab0IETsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 15:48:21 -0400
Received: from lo.gmane.org ([80.91.229.12]:55363 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841Ab0IETsU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 15:48:20 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OsLCM-0003vi-Mp
	for git@vger.kernel.org; Sun, 05 Sep 2010 21:48:18 +0200
Received: from 151.60.179.47 ([151.60.179.47])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 21:48:18 +0200
Received: from giuseppe.bilotta by 151.60.179.47 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 21:48:18 +0200
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 151.60.179.47
User-Agent: KNode/4.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155478>

Casey Dahlin wrote:
> 
> So now our two peers can see each other.
> 
> casey@host_a$ git hive show --branches
> Nguyen Thai Ngoc Duy <pclouds@gmail.com>
> master
> for_casey
> 
> ---
> 
> nguyen@host_b$ git hive show --branches
> Casey Dahlin <cdahlin@redhat.com>
> master
> stable
> v2.1
> 
> And we can exchange them
> 
> casey@host_a$ git hive fetch nguyen for_casey
> casey@host_a$ git branch
> * master
> stable
> for_casey
> 
> Note that the two arguments in fetch are a regex which searches through
> user IDs and a branch name, which is why I can abbreviate to just "nguyen"
> in all lower case.

I may be a little late into the discussion, but I must say I very much like the
idea. I realize that this is mostly intended for local repo sharing (typically
between coworkers), but I suspect the idea could be extended to more general
distributed repository, ehrm, distribution.

The only thing I would object to, so far, is hive fetch bringing stuff
directly into my local repository. I typically prefer content to remain
fenced in its appropriate namespace (e.g. I have issues even with the way tags
and notes are imported from remotes). For hives, it might be a better idea to
have the hive-fetched branches plop into either refs/remotes or maybe even a
new dedicated namespace like refs/hive/ ?
