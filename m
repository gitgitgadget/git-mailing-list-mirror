From: Ron Garret <ron1@flownet.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 03 Feb 2010 12:34:05 -0800
Organization: Amalgamated Widgets
Message-ID: <ron1-A681F2.12340503022010@news.gmane.org>
References: <ron1-32BD5F.10255403022010@news.gmane.org> <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com> <4B69D897.2060908@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 03 21:34:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nclvu-0004jh-8o
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:34:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932809Ab0BCUe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 15:34:28 -0500
Received: from lo.gmane.org ([80.91.229.12]:40966 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932657Ab0BCUe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 15:34:27 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nclve-0004bY-3F
	for git@vger.kernel.org; Wed, 03 Feb 2010 21:34:26 +0100
Received: from 68-190-211-184.dhcp.gldl.ca.charter.com ([68.190.211.184])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 21:34:26 +0100
Received: from ron1 by 68-190-211-184.dhcp.gldl.ca.charter.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 21:34:26 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 68-190-211-184.dhcp.gldl.ca.charter.com
User-Agent: MT-NewsWatcher/3.5.1 (Intel Mac OS X)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138886>

In article <4B69D897.2060908@pcharlan.com>,
 Pete Harlan <pgit@pcharlan.com> wrote:

> On 02/03/2010 10:48 AM, Avery Pennarun wrote:
> >> [ron@mickey:~/devel/gittest]$ git mv file2 file3
> >> [ron@mickey:~/devel/gittest]$ git commit -m 'letters->numbers'
> >> [master ae3f6d4] letters->numbers
> >>  1 files changed, 0 insertions(+), 0 deletions(-)
> >>  rename file2 => file3 (100%)
> > 
> > Whoops.  You didn't 'git add file2' (before the mv) or 'git add file3'
> > (after the mv), or use commit -a, so what you've committed is the
> > *old* content of file2 under the name file3.  The *new* content of
> > file2 is still uncommitted in your work tree under the name file3.
> 
> It may be reasonable for "git mv foo bar" to print a helpful message to
> the user if foo has un-checked-in changes, similarly to what "git rm" does.
> 
> Unlike "git rm", "git mv" could still perform the operation even without
> "-f", but the semantics of "git mv" differ enough from plain "mv" that a
> short blurb from Git in that case might help.

I think that a simple tweak to the docs would be enough.  Right now it 
says:

"The index is updated after successful completion, but the change must 
still be committed."

I'm pretty sure I would have been less confused if it had said something 
like:

"The index is updated to reflect the new name of the file, but NOT any 
new content that file may contain.  Changed content must be added to the 
index separately with git add, and all changes must still be commited."

rg
