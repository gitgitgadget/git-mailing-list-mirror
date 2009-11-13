From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH 2/2] git-svn: handle SVN merges from revisions past the
 tip of the branch
Date: Fri, 13 Nov 2009 13:47:24 +1300
Message-ID: <4AFCAC9C.9020305@vilain.net>
References: <871vk35o86.fsf@navakl084.mitacad.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Toby Allsopp <toby.allsopp@navman.co.nz>
X-From: git-owner@vger.kernel.org Fri Nov 13 01:47:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8kKD-0003Cv-Vl
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 01:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097AbZKMArX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 19:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754840AbZKMArX
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 19:47:23 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:54535 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbZKMArW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 19:47:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 616543227A;
	Fri, 13 Nov 2009 13:47:26 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zbTZ0ftDLEES; Fri, 13 Nov 2009 13:47:25 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 153523212A;
	Fri, 13 Nov 2009 13:47:25 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <871vk35o86.fsf@navakl084.mitacad.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132807>

Toby Allsopp wrote:
> When recording the revisions that it has merged, SVN sets the top
> revision to be the latest revision in the repository, which is not
> necessarily a revision on the branch that is being merged from.  When
> it is not on the branch, git-svn fails to add the extra parent to
> represent the merge because it relies on finding the commit on the
> branch that corresponds to the top of the SVN merge range.

I thought, "that sounds like he's repeating himself, wait a sec..."

> -test_expect_failure 'represent svn merges with intervening commits' "
> +test_expect_success 'represent svn merges with intervening commits' "
>  	[ `git cat-file commit HEAD | grep parent | wc -l` -eq 2 ]
>  	"

So you made a failing test and then added the implementation for it?
Interesting strategy :).  I'd probably not repeat the same sentence
twice though.

Thanks for contributing this.  There might be other bugs too, especially
when upstream has a more complicated merge hierarchy ... apparently svn
tends to get it wrong, so checking for all commits might not work in
that case.

It would be nice if "dcommit" could make these commits, too...

Sam
