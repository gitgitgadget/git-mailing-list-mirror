From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: stg pull/rebase
Date: Sat, 07 Jun 2008 10:41:41 -0700 (PDT)
Message-ID: <m3y75hw3an.fsf@localhost.localdomain>
References: <20080607172202.GA5179@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: =?iso-8859-15?q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Jun 07 19:44:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K52Sf-0001W6-Tr
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 19:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121AbYFGRnZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Jun 2008 13:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758295AbYFGRnZ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 13:43:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:44988 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297AbYFGRnY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jun 2008 13:43:24 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1014135fgg.17
        for <git@vger.kernel.org>; Sat, 07 Jun 2008 10:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=EVBE5gAWR48fBZueEzuSNOeQt6cMUQXKEc0gzUornS8=;
        b=E6nbjDzBdgBDvs2KZSuVD4Fla59j2+8KtneRKxKlQx1ZHA66ohax1+0S944kdOr5ZE
         eR4BOYbgVDur/odC9Lc+C9i2cpnDzzaHneIwlFpJwGB91lHuCqZqbOhZR6vaJfuJw0kW
         4eVzYwRthBvELCvH87S5FhJiXmU7iJQJ3MAjs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=VPMfvCKSYM2TeqtxZNB2qFf2DXuPigUL0V0Ot/ZUVmDPzSdW0HXUlqN4x71dO7pEyo
         ZCAu0B4y55mx4vuCG0MvhbRecPCrOzQ3bnHazo6ByxVOp5QcihNJjnCFxiVTneXoRXg3
         YBOs2P8pUZ7AJzYtu9fPsBialCWXWaetXNpIA=
Received: by 10.78.179.3 with SMTP id b3mr772883huf.66.1212860602392;
        Sat, 07 Jun 2008 10:43:22 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.218.155])
        by mx.google.com with ESMTPS id o38sm3529040hub.43.2008.06.07.10.41.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Jun 2008 10:41:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m57Hfc6C002292;
	Sat, 7 Jun 2008 19:41:39 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m57Hfbh9002289;
	Sat, 7 Jun 2008 19:41:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080607172202.GA5179@diana.vm.bytemark.co.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84219>

Karl Hasselstr=F6m <kha@treskal.com> writes:

> Currently, there's stg rebase which only does rebasing, and stg pull
> which does either rebase or merge depending on a config option. And o=
n
> top of that there's config stuff like stgit.pullcmd that is invoked i=
n
> some cases but not others.
>=20
> What I think I'd like is the following:
>=20
>   * Just one command, stg pull. stg rebase is removed.

And I would have to learn to use other command (I use very frequently
the following sequence: git remote update && stg rebase <branch>)?
Not nice.
=20
I already have to use two commands: "stg refresh && stg edit" to make
a change which affects how commit message is written, instead of
simplier "stg refresh --edit".

>   * When pull is invoked, the following happens:
>=20
>       1. The branch we pull from may be updated, depending on the
>          configuration. (e.g. git fetch or git svn fetch)
>=20
>       2. Depending on the configuration (overridable by the
>       --fast-forward, --rebase, and --merge options), one of these
>       three things happen:

Couldn't then "stg rebase" be 'internal alias' to "git pull --rebase"?

[...]
>   * The default action is to fast-forward, which is probably what mos=
t
>     users want -- merge is very likely to do the wrong thing, and
>     rebase can lose changes.

Unless you want to rebase on top of different branch, for example
moving stack from 'master' to 'next', or when you work on top of
branch which doesn't fast-forward, like 'pu' in git repository.
=20
--=20
Jakub Narebski
Poland
ShadeHawk on #git
