From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitignore design
Date: Fri, 29 Jul 2011 05:19:51 -0700 (PDT)
Message-ID: <m339hps2is.fsf@localhost.localdomain>
References: <1311934832699-6632987.post@n2.nabble.com>
	<4E329EDB.6040007@hupie.com>
	<1311940877783-6633274.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ferry Huberts <mailings@hupie.com>
To: llucianf <llucianf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 14:20:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qmm2o-0001PA-Lp
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 14:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756061Ab1G2MTy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jul 2011 08:19:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61088 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804Ab1G2MTx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2011 08:19:53 -0400
Received: by fxh19 with SMTP id 19so2245076fxh.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 05:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=JtAEfnA35gVDbz1iiqYAVn2kXk50t/JLAVFaGLnvn0A=;
        b=im1PUsJIDE0kKLrOBzGQREkHf5Ec2bJfc7dZTQabnnofP7l2++gGZYZIMn8MpvoF58
         lcj7Av7V9xMeyIV+NhICGBJQMTxN8wRqmAdaCkvAU16tTU3GKBnY5Wx3qgxD5M7Q9KQg
         UECm2b8At0FnbMauphYdFnz3tC6sETtyFSZgk=
Received: by 10.223.1.207 with SMTP id 15mr1752375fag.9.1311941992636;
        Fri, 29 Jul 2011 05:19:52 -0700 (PDT)
Received: from localhost.localdomain (abwm72.neoplus.adsl.tpnet.pl [83.8.236.72])
        by mx.google.com with ESMTPS id e10sm1061610fak.18.2011.07.29.05.19.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 05:19:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6TCJIv5010130;
	Fri, 29 Jul 2011 14:19:29 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6TCJ8CY010126;
	Fri, 29 Jul 2011 14:19:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1311940877783-6633274.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178142>

llucianf <llucianf@gmail.com> writes:
> Ferry Huberts <mailings@hupie.com> writes:
> > On 07/29/2011 12:20 PM, llucianf wrote:

> > > why gitignore doesnt simply work like in cvs where if you put som=
ething in
> > > the ignore file, those stuff are simply ignored from that point w=
ithout
> > > having to remove them from repo?

Are you sure that cvsignore file makes CVS to ignore changes in
_tracked_ files (in repository)?  CVS manual says:

  Ignoring files via cvsignore
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

     There are certain file names that frequently occur inside your
  working copy, but that you don't want to put under CVS control.
  Examples are all the object files that you get while you compile your
  sources.  Normally, when you run `cvs update', it prints a line for
  each file it encounters that it doesn't know about.

Tracked files (in repository) are by definition not unknown to version
control system, be it CVS or Git.
=20
> > because when it's in the repo you obviously want to track it...
> > tracking trumps ignoring
> >=20
> > if you now suddenly do not want to track it anymore you have to rem=
ove
> > it and ignore it.
>
> sorry but this is not always the case.

But it is _usually_ the case, and that is why gitignore works as it
does, being only about _untracked_ files.

>                                        there are plenty of cases (pro=
ject
> files is most common example) in which i need files in repo but i do =
not
> need git to track them. so why i cant just simply enumerate those pro=
ject
> files into .gitignore and 'persuade'  git to simply forget about them=
?

=46or that you can use 'assume-unachanged' mechanism (note: it is local
to repository).  The gitignore(7) manpage says:

  NOTES
     The purpose of gitignore files is to ensure that certain files not=
 tracked
     by git remain untracked.

     To ignore uncommitted changes in a file that is already tracked, u=
se
     `git update-index --assume-unchanged <file>`.


Or just don't use 'git commit -a' and commit with dirty tree.

--=20
Jakub Nar=EAbski
