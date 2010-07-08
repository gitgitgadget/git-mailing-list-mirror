From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: mangle refnames forbidden in git
Date: Thu, 8 Jul 2010 08:58:14 +0000
Message-ID: <20100708085814.GC10779@dcvr.yhbt.net>
References: <4BE3249B.7050100@theblacksun.eu> <20100708084356.GA29856@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten Schmutzler <git-ts@theblacksun.eu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 10:58:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWmw5-0006m4-7c
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 10:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804Ab0GHI6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 04:58:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47875 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754763Ab0GHI6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 04:58:16 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id E27541F52C;
	Thu,  8 Jul 2010 08:58:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20100708084356.GA29856@burratino>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150551>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> t9118-git-svn-funky-branch-names.sh fails for me:
> 
>  [...]
>  3402a8497588142722deb77f6e4f42b6caaabc85
>  refs/remotes/not-a%40{0}reflog
>  fatal: ambiguous argument 'refs/remotes/not-a%40{0}reflog': unknown revision or path not in the working tree.
>  Use '--' to separate paths from revisions
>  not ok - 2 test clone with funky branch names
> 
> More precisely, the failure occurs in the
> 
>  	svn_cmd cp -m "reflog" "$svnrepo/pr ject/trunk" \
> 			"$svnrepo/pr ject/branches/not-a@{0}reflog" &&
> 
> line in that test: I think svn is handling the @ itself here.
<snip>
>  $ svn --version
>  svn, version 1.6.12 (r955767)
>     compiled Jun 21 2010, 20:24:54
>  [...]
> 
> Ideas?

I can't reproduce it with 1.5.1 here, does URI-escaping the "@{0}"
to "%40%7B0%7D" work?

-- 
Eric Wong
