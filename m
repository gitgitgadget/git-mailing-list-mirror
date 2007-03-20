From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: My git repo is broken, how to fix it ?
Date: Tue, 20 Mar 2007 12:55:22 +0600
Message-ID: <200703201255.22701.litvinov2004@gmail.com>
References: <200702281036.30539.litvinov2004@gmail.com> <200703201013.39169.litvinov2004@gmail.com> <Pine.LNX.4.64.0703192212280.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Mar 20 07:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTYG0-00089Y-3h
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 07:55:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752812AbXCTGze convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 20 Mar 2007 02:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbXCTGze
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 02:55:34 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:14524 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbXCTGzd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2007 02:55:33 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1535434uga
        for <git@vger.kernel.org>; Mon, 19 Mar 2007 23:55:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=YbJzru9Nl+HAXVwN5sMUi1+iXUyi32pqVGJz1SzEWGei/C9LzAqamD5H/dKdocDW4IOHe225obwWQY1cXn6YsghLhy+53yOgFEctwioIgbhTA6dDRtxqdEkpzQPK6/imbqtWV8hDE7IInX4/CYvJ2I6vSepAHvyF/Y614FHTmQA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HtebyIG3yDw496FZOhCc2KovxEJcNkM+buhjiwu7QIxaQU+JeqBkjmHu5NbAS+jgW6BqHyJjrYLUm9t1/VPbYIzGgVNy5jzA5YhRRNsz4xSE9CyISR36OWXcwJeEQU5/8D7gs1Pba/1zb1HYt5/TFbuLzg186Jw642Pck6CBOkM=
Received: by 10.67.92.1 with SMTP id u1mr813550ugl.1174373731715;
        Mon, 19 Mar 2007 23:55:31 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [81.1.223.2])
        by mx.google.com with ESMTP id l40sm157485ugc.2007.03.19.23.55.29;
        Mon, 19 Mar 2007 23:55:30 -0700 (PDT)
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.64.0703192212280.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42723>

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=
=82 Tuesday 20 March 2007 11:34 Linus Torvalds =D0=BD=D0=B0=D0=BF=D0=B8=
=D1=81=D0=B0=D0=BB:
> Ok, this is different from what I expected.

I will try to stop using git-gc for some time to find out broken loose=20
objects.

> > I also use autocrlf feature:
> > $ git config core.autocrlf
> > true
>
> More interesting might be if you might be using any of the other flag=
s
> that actually affect internal git object packing: "use_legacy_headers=
" in
> particular? If we have a bug there, that could be nasty.
This is the all my config options:
$ git config -l
user.name=3DAlexander Litvinov
user.email=3DXXX
core.logallrefupdates=3Dtrue
core.filemode=3Dfalse
core.autocrlf=3Dtrue
diff.color=3Dauto
status.color=3Dauto
apply.whitespace=3Dstrip
core.repositoryformatversion=3D0
core.filemode=3Dfalse
core.bare=3Dfalse
remote.origin.url=3D/home/lan/src/XXX
remote.origin.fetch=3D+refs/heads/*:refs/remotes/origin/*
branch.master.remote=3Dorigin
branch.master.merge=3Drefs/heads/master
branch.XXX.remote=3Dorigin
branch.XXX.merge=3Drefs/heads/XXX

> Ok, no problem. I added back the git list (but not your attachments,
> obviously) but as explained above, there is not a lot I can do with t=
he
> unpacked data, I'd like to see the actual "raw" stuff.

I undertand your wish.

> I'm hoping somebody has any ideas. We really *could* check the SHA1 o=
n
> each read (and slow down git a lot) and that would catch corruption m=
uch
> faster and hopefully pinpoint it more quickly where exactly it happen=
s.

I can live with such slowdown as far as cygwin not fast and I am ready =
to wait=20
right now. I don't think the situation become realy worser than now :-)
