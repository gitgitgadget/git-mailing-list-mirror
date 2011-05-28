From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] Proposal for git-svn: storing SVN metadata (git-svn-id) in notes
Date: Sat, 28 May 2011 18:37:54 +0200
Message-ID: <201105281837.56655.jnareb@gmail.com>
References: <201105281154.25223.jnareb@gmail.com> <BANLkTinorqTQOBw46mYJYfEWTEXC+Myzpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 28 18:38:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQMWj-0003nS-P2
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 18:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab1E1QiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 May 2011 12:38:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:49029 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312Ab1E1QiH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 12:38:07 -0400
Received: by bwz15 with SMTP id 15so1976446bwz.19
        for <git@vger.kernel.org>; Sat, 28 May 2011 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=so7lqa2TABS2nAEOFPORbqffVxFp86XUecl4LUBGras=;
        b=a3/bssx4dpejHbSHdxmyjobZ9VdqxMdsyOrDz+7RZr7MaiASUG3Na/Cqn5KBbuAaam
         439YSzn529mEeJ+sRk2mS/IQhRL/HuwNM6iGiroByB/JhyWpWvYG9HZEd16xSF1/hABi
         bNswkKCx/dXpsrf7qiSLeYCxHIHa+AzC+u4Og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=E0KDrTWSm5p4dJvHGtq5ZPswfBLWP+dhvNCEAi7JiAddimj68reRzFvyVHYYsiF1Xw
         rYmaugIR+hhkqe/s7R/ZQxzeU2mqcs/R0ZsEKtfOFNWGg/TaNMHXDp7QQmbBj4a8IbmI
         ZOBXfQo016l4Ty/qs/9uVBUZEYCW9AyrkCXUI=
Received: by 10.204.75.22 with SMTP id w22mr2927548bkj.65.1306600684984;
        Sat, 28 May 2011 09:38:04 -0700 (PDT)
Received: from [192.168.1.13] (abvz93.neoplus.adsl.tpnet.pl [83.8.223.93])
        by mx.google.com with ESMTPS id ek1sm2108453bkb.9.2011.05.28.09.38.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 May 2011 09:38:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <BANLkTinorqTQOBw46mYJYfEWTEXC+Myzpw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174664>

On Sat, 28 May 2011, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> 2011/5/28 Jakub Narebski <jnareb@gmail.com>:

> > Now that git supports annotating comments with `git notes` utility,
> > could we have an option to git-svn which would make it store SVN
> > metadata, i.e. git-svn-id: lines using git-notes (separate svnmetad=
ata
> > or git-svn notes ref)?
>=20
> One good thing about git-svn's current system is that you can easily
> share your repository with someone else, and they can bootstrap from
> the same commits.

How it works with svn-dcommit rewriting commits?
=20
> Has the sharing of git-notes been improved to the point where that
> could be done similarly transparently?
=20
=46irst, the idea was to do it optionally.  In addition to existing and
discouraged `svn.noMetadata` / `--no-metadata` git-svn would acquire
`svn.metadata` / `--metadata` / `--svn-metadata` =3D none | notes | com=
mits
that would as one option put 'git-svn-id:' lines or their equivalent
to git notes.

Second, from what I understand from the very beginning git-notes=20
was designed in such way that sharing notes is sharing ref.
git-replace shares this feature.

But please take above with a grain of salt, having never used notes
before, and not being developer of this subsystem.
--=20
Jakub Narebski
Poland
