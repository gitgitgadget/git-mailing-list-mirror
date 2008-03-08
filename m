From: "=?ISO-8859-1?Q?Marc-Andr=E9_Lureau?=" <marcandre.lureau@gmail.com>
Subject: [bug] 01bdab8 breaks git-svn show-ignore?
Date: Sun, 9 Mar 2008 00:06:02 +0200
Message-ID: <e29894ca0803081406r129deb68q38c9146d7fd419ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Benoit Sigoure" <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 08 23:06:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY7Bi-0008GM-UH
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 23:06:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbYCHWGF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Mar 2008 17:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752309AbYCHWGF
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 17:06:05 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:31032 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbYCHWGC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 17:06:02 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1390621wah.23
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 14:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=InwaKaVwE5OqhrP+/lj+4UT95jRdJ074EbudEyU8/O0=;
        b=HYxov1fzGAr4K0yG1K9C8jP4wk4nPW24DcDeoey5Qk3eT9tqWrrCV5Xqq67A1xlEjbJE12WfSpb5hUD/oOMsDpTDfsflzs3VJs6laIYHtGKzKl9CTlvCEAKwfA7BaFlDcN3il/9S+yEtkFlAfcJlaqnWsanhJvoe1TqZLsuNEzw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=OcYDQ+GdsYvVilK6Ui1fPqzPHOkaVnLfwvX/iuFAfTZo3/WhwCHlabPsJFTfYsaJLjBLVnHU98Do5mk4TCyYG+MCS57VOJn256PmNrnb6JGfpI0oM48qNfPSTvXIFkfuTIluRAFxPtMvMIn5+TdzdoZ0jCL/1FQpu9DPKdnA6iQ=
Received: by 10.114.152.17 with SMTP id z17mr1031848wad.128.1205013962280;
        Sat, 08 Mar 2008 14:06:02 -0800 (PST)
Received: by 10.114.60.4 with HTTP; Sat, 8 Mar 2008 14:06:02 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76593>

Hi,

Benoit, your 01bdab8 patch seems to break git-svn show-ignore in
subdirectories. Example:

git-svn init svn://svn.gnome.org/svn/gobject-introspection/trunk
git-svn fetch -r 122
git-svn show-ignore

# /
/aclocal.m4
/autom4te.cache
/compile
/config.guess
/config.h
/config.h.in
/config.log
/config.status
/config.sub
/configure
/COPYING
/depcomp
/gobject-introspection.pc
/INSTALL
/install-sh
/libtool
/ltmain.sh
/Makefile
/Makefile.in
/missing
/stamp-h1
=46ilesystem has no item: File not found: revision 122, path '/examples=
'
at /opt/git/bin/git-svn line 1505

(it exits 1)

Regards,

--=20
Marc-Andr=E9 Lureau (ex epita student - cheers :)
