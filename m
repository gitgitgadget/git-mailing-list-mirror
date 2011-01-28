From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Fri, 28 Jan 2011 01:38:58 -0800 (PST)
Message-ID: <m3tygt9xmn.fsf@localhost.localdomain>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com>
	<AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com>
	<15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org
To: Thomas Hauk <tom@shaggyfrog.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 10:39:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiknO-0008EZ-5N
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 10:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003Ab1A1JjE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jan 2011 04:39:04 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58566 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab1A1JjB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jan 2011 04:39:01 -0500
Received: by wwa36 with SMTP id 36so3146939wwa.1
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 01:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=A6I2TQ2h5UAtoc7vKL339nwSEKF93dACbikf+hs+nEg=;
        b=pCdmxJ9Xny1hW4CStP/gQ3Ao+xe89b5NXYgxKv+xoPwBZCTlM6GC8O8nV+jUwB9Py5
         +9rJy0/Z3DobPOMcLXuatJhtJ2/Dgn5AmOmYuJNUWCiQEYCS3myli7jP7c8A6ckRM/4X
         SHVVp9SKP0fr5I8+40Jo1TePRU/3fXxyV9pgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=wUsZI/HT+SIn85o1V2UXuw4PXndSphaGiWa4bbrtUAA3N72iJf6Fch6QfALgWdwLNn
         ck8sowghkCM6idSlEPtiiZwj+BNmBCxdwF2rV68zJenaA/b6T2vg9SzcAbObwTLZemNU
         UT4AIt+rmK/0Wh4O2zRo3zIzlJwzBRfQpSW9Q=
Received: by 10.227.134.129 with SMTP id j1mr2388441wbt.56.1296207540372;
        Fri, 28 Jan 2011 01:39:00 -0800 (PST)
Received: from localhost.localdomain (abwe231.neoplus.adsl.tpnet.pl [83.8.228.231])
        by mx.google.com with ESMTPS id m50sm8915421wek.32.2011.01.28.01.38.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Jan 2011 01:38:58 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p0S9cPbr025885;
	Fri, 28 Jan 2011 10:38:30 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p0S9c9Zh025878;
	Fri, 28 Jan 2011 10:38:09 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165605>

Thomas Hauk <tom@shaggyfrog.com> writes:
> On Jan 27, 2011, at 12:53 PM, =C6var Arnfj=F6r=F0 Bjarmason wrote:

> > You'll be much better off if you have project-specific repositories=
=2E
>=20
> But how often do you have a project that has no external or internal
> dependencies on any other packages or libraries? Any project I've
> ever done, big or small, has relied on some existing
> codebase. Imagine a project that uses liba and libb, which both
> reference libc. To use Git, I'd have to have copies of libc existing
> in three repositories, and copies of liba and lib in two
> repositories each. What a nightmare... and that's only a trivial
> hypothetical example.

That is only if lib{a,b,c} is _internal_ dependency.  In usual case
project A might depend on library B *to be installed*, but it doesn't
mean that source code of library B has to be in repository for project
A.  And in usual case when project A depends on library B, it relies
on library B public stable API (its build system might check if you
have new enough library B installed).  If you depend on specific
version of library, patched, that is your problem...

In the case of internal dependency, where you co-develop both project
A and library B, it makes most sense to have separate repositories for
A and for B, and tie them up using submodules or subtree merge.


In the case you describe you would need three *checkouts* of libc (if
checkout is needed for development, see above), but not necessary
three copies (three clones) of libc *repository* - one copy should be
enough.

>=20
> I understand that Git was designed with a specific feature set in
> mind -- to manage Linux kernel development -- and as such isn't
> going to satisfy everyone. But I'm having trouble figuring out how
> to integrate it as the SCM in my projects, which aren't organized
> any differently than any other projects I've seen.

Well, you are braindamaged by your SCM ;-) ... just kidding.

Take a look how LibreOffice (Go-OOo), KDE, GNOME, GNU SourceMage Linux
distribution organize their repositories -- all of them are highly
modular / componentized.

> Surely I can't be the only person with these difficulties? Git just
> doesn't seem to scale when it comes to componentized projects. Do
> other distributed VCSs work better than Git in this respect?

Perhaps you could abuse Bazaar in that fashion, but I think most DVCS
use branching of whole project (branch in repository) model, rather
than the branching is copying (branch is folder) model that Perforce
and Subversion use.

Whole project branching has just too many advantages, or conversely
branch as folder (directory) has too many disadvantages.
=20
> I'm really trying to get on the Git bandwagon, here.

World domination is not on agenda :-) The main goal of Git is to make
it easy for open-source projects to collaborate.

P.S. There are commercial DVCS: BitKeeper, Vault,...

--=20
Jakub Narebski
Poland
ShadeHawk on #git
