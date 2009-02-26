From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: checkout vs reset
Date: Thu, 26 Feb 2009 09:15:20 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngqcnd8.t1u.sitaramc@sitaramc.homelinux.net>
References: <76718490902252308r474b193yba21b14e14a3baa@mail.gmail.com>
 <76718490902252312h6a08f5a6x972523e7c7e4af16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 10:17:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LccMX-00019b-Pq
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 10:17:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbZBZJPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 04:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbZBZJPd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 04:15:33 -0500
Received: from main.gmane.org ([80.91.229.2]:53625 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752610AbZBZJPc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 04:15:32 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LccL2-00052r-UP
	for git@vger.kernel.org; Thu, 26 Feb 2009 09:15:29 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 09:15:28 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Feb 2009 09:15:28 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111542>

On 2009-02-26, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Thu, Feb 26, 2009 at 2:08 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
>> Is there any different between the following two commands?
>>
>> git reset <commit> -- <paths>...
>> git checkout <commit> -- <paths>...
>>
>> As far as I can tell from the man pages, they are equivalent. To wit:
>> both update the index and working copy for the given paths to the
>> state that they were in in <commit>.
>
> Doh, answering my own question. reset only touches the index, not the
> working copy. checkout updates both.

However, if the <commit> doesn't even _have_ the <path> in
question, it leaves the index alone (doesn't remove it, for
instance):

Using HEAD as the <commit> in question for this example:

    echo hi > abc       # new file, untracked so far
    git add abc
    git status          # it's staged
    git reset HEAD -- abc
    git status          # untracked

    # now with checkout
    git add abc
    git status          # staged
    git checkout HEAD -- abc
    git status          # still staged
