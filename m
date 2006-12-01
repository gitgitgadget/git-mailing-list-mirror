X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: selective git-update-index per diff(1) chunks
Date: Fri, 1 Dec 2006 12:33:48 +0100
Message-ID: <slrnen04os.a5.Peter.B.Baumann@xp.machine.xx>
References: <b6fcc0a0612010323x7554e47m5e6bdafe85fc8224@mail.gmail.com>
NNTP-Posting-Date: Fri, 1 Dec 2006 11:35:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 28
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32900>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq6fu-0001oV-6W for gcvg-git@gmane.org; Fri, 01 Dec
 2006 12:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936467AbWLALfX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 06:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936469AbWLALfX
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 06:35:23 -0500
Received: from main.gmane.org ([80.91.229.2]:54403 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S936467AbWLALfW (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 06:35:22 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gq6fe-0001k8-9Y for git@vger.kernel.org; Fri, 01 Dec 2006 12:35:10 +0100
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Fri, 01 Dec 2006 12:35:10 +0100
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with
 local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>;
 Fri, 01 Dec 2006 12:35:10 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On 2006-12-01, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> Pretty often I end up with a file with two simple orthogonal fixes in it.
> git-diff shows me both, that's OK.
>
> Now I want to commit them as two separate commits. So far, it's
> * getting full diff
> * cp(1)
> * hand-edit both diffs
> * commit first
> * commit second
>
> Has anyone thought about aggregating this into git-update-index or
> somewhere?
>
>     git-update-index -C1,3    #chunks 1, 3
>     git commit
>     git-update-index -C1,3    # chunks 2,5 in original numbering
>     git commit
>
> Relying on diff(1) definition of chunks is sorta hacky, though... I admit it.

I don't think it belongs in the plumbing, the git-update-index but I
think something like this would be very usefull.

AFAIR darcs has this functionality. It selectively ask for each hunk if
it should be commited. This would be awfull to have in git.

-Peter
