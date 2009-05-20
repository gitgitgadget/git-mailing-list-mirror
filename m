From: Mark Plaksin <happy@usg.edu>
Subject: Re: Syntax check via update hook?
Date: Wed, 20 May 2009 16:57:01 -0400
Message-ID: <ws8wkrsdb6.fsf@usg.edu>
References: <wsprejtm71.fsf@usg.edu>
	<20090509144711.GA3926@sigill.intra.peff.net> <wsd4aem8rh.fsf@usg.edu>
	<20090514065544.GC10411@coredump.intra.peff.net>
	<wsd4abfonx.fsf@usg.edu> <ws7i0bu7sq.fsf@usg.edu>
	<20090520152224.GB22426@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 22:58:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6ssI-00074P-1Z
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 22:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130AbZETU5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 16:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756041AbZETU5O
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 16:57:14 -0400
Received: from main.gmane.org ([80.91.229.2]:48868 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754037AbZETU5N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 16:57:13 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1M6sqe-0001Rt-0p
	for git@vger.kernel.org; Wed, 20 May 2009 20:57:12 +0000
Received: from stone.tss.usg.edu ([168.24.82.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 May 2009 20:57:12 +0000
Received: from happy by stone.tss.usg.edu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 May 2009 20:57:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: stone.tss.usg.edu
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.93 (gnu/linux)
Cancel-Lock: sha1:Sa7GglTXC34UuskV32W3cMJ1AYc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119633>

Jeff King <peff@peff.net> writes:

> On Wed, May 20, 2009 at 11:13:09AM -0400, Mark Plaksin wrote:
>
>> Well, it's oh so close!  If we make changes that don't pass the syntax
>> check and try to push them the hook rejects the changes.  If we then
>> make a change that will pass the syntax check, leave the others broken,
>> and push, 'git diff-tree' doesn't list the previously rejected files so
>> the hook accepts the push.  Is there any way to get 'git diff-tree' to
>> list all of the files?
>
> Ah, yeah, that was my mistake. If you are looking at the whole tree,
> then you only need to look at what is being pushed, as it contains the
> changes for all of the commits being pushed. But if you are going to ask
> for a diff, you want to see not just the final commit, but the diff
> between what is in the ref now and what you are proposing to push.
>
> The old commit is passed as the second argument to the hook. So you
> should be able to just do:
>
>   git diff-tree "$2" "$3"

That did the trick once we put the '-r' back :)  Thanks very much!
