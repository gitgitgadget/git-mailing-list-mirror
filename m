X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Getting new branches from remote repo.
Date: Mon, 13 Nov 2006 10:17:36 +0100
Message-ID: <20061113091736.GA31693@diana.vm.bytemark.co.uk>
References: <6e1787fe0611122033p49671e13xf5b7f95beeba8b06@mail.gmail.com> <7v8xigar36.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 13 Nov 2006 09:18:00 +0000 (UTC)
Cc: Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v8xigar36.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31293>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjXwq-0000xl-7R for gcvg-git@gmane.org; Mon, 13 Nov
 2006 10:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754098AbWKMJRn convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006 04:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754156AbWKMJRn
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 04:17:43 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:14604 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1753844AbWKMJRm
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 04:17:42 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GjXwe-0002xL-00; Mon, 13 Nov 2006 09:17:36 +0000
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 2006-11-12 20:49:33 -0800, Junio C Hamano wrote:

> "Alexander Litvinov" <litvinov2004@gmail.com> writes:
>
> > I have a trouble I don't know how to solve. When I am cloning
> > remote repo I automatically get all it's branches stored at my
> > repo (they are listed at .git/remotes/origin). When someone adds
> > new branch(es) to remote repo git pull (git fetch) does not
> > automatically add them to my repo. I have a tool to list all
> > remote branches (git ls-remote --heads origin) but I can't find
> > how to add interesting (or all) branches to by repo.
>
> After finding out $that_new_branch's name, add either
>
>       Pull: refs/heads/$that_new_branch:refs/heads/$that_new_branch
>
> or if you are in "separate remote" school, then perhaps
>
>       Pull: refs/heads/$that_new_branch:refs/remotes/origin/$that_new=
_branch
>
> to .git/remotes/origin and running git fetch would give you what you
> want, I think.

There really should be a flag to make git fetch do this job. And if we
use separate remotes, the flag should probably default to "on".

--=20
Karl Hasselstr=F6m, kha@treskal.com
