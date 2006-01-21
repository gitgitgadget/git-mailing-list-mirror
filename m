From: Alexander Litvinov <lan@ac-sw.com>
Subject: Re: What is in git.git
Date: Sat, 21 Jan 2006 16:36:02 +0600
Organization: AcademSoft Ltd.
Message-ID: <200601211636.02340.lan@ac-sw.com>
References: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 11:36:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0G6Q-0004jK-CN
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 11:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWAUKgL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Jan 2006 05:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbWAUKgK
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 05:36:10 -0500
Received: from gw.ac-sw.com ([81.1.223.2]:38327 "EHLO gw.ac-sw.com")
	by vger.kernel.org with ESMTP id S932110AbWAUKgJ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 05:36:09 -0500
Received: from localhost (localhost [127.0.0.1])
	by gw.ac-sw.com (Postfix) with ESMTP id E48A9BD37;
	Sat, 21 Jan 2006 16:36:07 +0600 (NOVT)
Received: from gw.ac-sw.com ([127.0.0.1])
 by localhost (gw.ac-sw.com [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 03408-04; Sat, 21 Jan 2006 16:36:05 +0600 (NOVT)
Received: from lan.ac-sw.lcl (lan.ac-sw.lcl [192.168.0.69])
	by gw.ac-sw.com (Postfix) with ESMTP id A318BBD25;
	Sat, 21 Jan 2006 16:36:05 +0600 (NOVT)
Received: by lan.ac-sw.lcl (Postfix, from userid 65534)
	id 9F4C98DA036F; Sat, 21 Jan 2006 16:36:05 +0600 (NOVT)
Received: from localhost (localhost [127.0.0.1])
	by lan.ac-sw.lcl (Postfix) with ESMTP id 911788DA0360;
	Sat, 21 Jan 2006 16:36:02 +0600 (NOVT)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.8
In-Reply-To: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at gw.ac-sw.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14993>

Somehow first mail was not reached the list, resending it.

> The "bind commit" experiments for subproject support is coming
> along rather nicely. =C2=A0Near the tip of the "pu" branch, there
> are:
=2E..
>
> I think the first four are more-or-less well debugged.
>
> I am reasonably confident that I did not break rev-list for
> repositories without "bind" commits, but I have no clue how
> correct it is when dealing with commits with "bind" lines. =C2=A0This
> is the last major remaining piece of the puzzle, and the rest is
> just the matter of scripting. =C2=A0I'd be sending out a request for
> help on the rev-list in a separate message.
>
> There still is no barebone Porcelainish work done using these
> changes. =C2=A0The attached script demonstrates a superproject that
> binds two subprojects with their own development histories.

I tested this with your script. It works well. But I have found some=20
downsides.

subpro and main are separate projects and master is the join of them. I=
f I=20
want to modify subpro I have to checkout subpro branch, edit files. Whe=
n I=20
have to got to master and bind new version of subpro to it. Worse, if I=
 will=20
edit subpro's files bined to master branch changes will go to master br=
anch=20
instead of subpro's history. As a result all other project (imagine mas=
ter-2)=20
that use subpro will lose this change.

1. Can I bind some branch instead of tag (commit) ?
2. Is it possible to commit changes of subpro's file in master branch i=
nto=20
subpro branch to make this changes visible to master-2 ?

Thanks for attention.
Alexander Litvinov.
