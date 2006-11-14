X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 21:46:28 +0100
Message-ID: <20061114204628.GA14741@diana.vm.bytemark.co.uk>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 14 Nov 2006 20:47:05 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87hcx1u934.wl%cworth@cworth.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31372>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk5BH-0002qA-NN for gcvg-git@gmane.org; Tue, 14 Nov
 2006 21:46:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966341AbWKNUqw convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006 15:46:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966343AbWKNUqw
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 15:46:52 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1553 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S966341AbWKNUqv
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 15:46:51 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1Gk5Ar-0003yS-00; Tue, 14 Nov 2006 20:46:29 +0000
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On 2006-11-14 11:22:39 -0800, Carl Worth wrote:

> So, the fact that conflict resolution still requires the use of
> update-index would just be the next thing to fix. A name for a
> replacement to use there could be "git resolve <paths>", (since the
> old git-resolve is now officially deprecated). That's a name that
> matches what hg uses in this situation, (another option is
> "resolved" which is what stg uses, but I think verbs for commands
> work better in general).

Yes, "resolve" sounds better than "resolved". The latter is arguably
more correct, since you're telling git that you have already resolved
the file and not asking it to resolve it for you, but I still prefer
"resolve".

> And then, the next phase of my evil plan would be to introduce a -i
> option for git-commit making it commit the state in the index. Then
> git-commit with no options could work like "git-commit -a" does now,
> (with the additional protection of not committing any unmerged
> files---that is the new "git resolve" would be required before "git
> commit" would work after a conflict). Users who really, really like
> the current behavior of git-commit could use the new alias support
> to pass the new -i option in order to maintain compatible behavior.

Seems very sane. Default to simple behavior, and provide a switch to
get more complicated behavior.

> Then, the last thing I'd really like to fix is to allow a usage of
> "git merge <branch>" instead of the awkward "git pull . <branch>".

This should reduce newbie confusion a lot.

--=20
Karl Hasselstr=F6m, kha@treskal.com
