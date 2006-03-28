From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: git pull fails
Date: Tue, 28 Mar 2006 17:38:27 +0300
Message-ID: <20060328173827.3d64d91e.tihirvon@gmail.com>
References: <20060328162831.af1bd4c0.tihirvon@gmail.com>
	<20060328141140.GC3113@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 16:38:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOFLA-0005cb-Tz
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 16:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbWC1OiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 28 Mar 2006 09:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWC1OiT
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Mar 2006 09:38:19 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:1421 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932282AbWC1OiT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Mar 2006 09:38:19 -0500
Received: by zproxy.gmail.com with SMTP id m22so1628892nzf
        for <git@vger.kernel.org>; Tue, 28 Mar 2006 06:38:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Hx8n9SFvxmlWIuRqjPvrJ0KC5972DF9TssO0YpMEKUdQ60X2gN5AFGsRIWFCBnKffwRerMmFG4+CyVXppIGTIwwHAdcFTfEZjzculUCuW971uN0RehXPfGf+6gKqOZgE5cTFF9HTSR/VsTIyXxkQn3xUS/5rS27ngSEp3hjuE5I=
Received: by 10.65.51.4 with SMTP id d4mr3578386qbk;
        Tue, 28 Mar 2006 06:38:18 -0800 (PST)
Received: from garlic.home.net ( [82.128.200.167])
        by mx.gmail.com with ESMTP id e16sm605611qba.2006.03.28.06.38.16;
        Tue, 28 Mar 2006 06:38:17 -0800 (PST)
To: Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20060328141140.GC3113@linux-mips.org>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.15; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18122>

Ralf Baechle <ralf@linux-mips.org> wrote:

> Continuing to walk after breaking a leg isn't a good idea, but that's
> basically what your change did.  What has happened to you is the norm=
al
> thing with branches that have been re-based or otherwise re-created.
> The better way to handle this kind of branches is to add a `+=B4 sign=
 to
> the refspec for the pu branc in .git/remote/origin like:
>=20
> [ralf@blah git]$ cat .git/remotes/origin
> URL: git://www.kernel.org/pub/scm/git/git.git
> Pull: master:master
> Pull: todo:todo
> Pull: +next:next
> Pull: maint:maint
> Pull: +pu:pu
> Pull: html:html
> Pull: man:man
> [ralf@blah git]$
>=20
> The next branch is handled the same way, so another `+=B4 sign.

Thanks, but forcing everyone to edit their git/remotes/origin file
is not very nice solution.  I think git-fetch should update refs for th=
e
other non-'broken' branches and leave "pu" and "next" refs untouched.

--=20
http://onion.dynserv.net/~timo/
