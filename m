From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 00/12] Sparse checkout
Date: Thu, 24 Jul 2008 02:35:45 -0700 (PDT)
Message-ID: <m3tzefvd3q.fsf@localhost.localdomain>
References: <20080723145518.GA29035@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 11:36:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLxFh-0001qW-As
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 11:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbYGXJfu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jul 2008 05:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbYGXJfu
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 05:35:50 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:14625 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754729AbYGXJft convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2008 05:35:49 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1035987nfc.21
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 02:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=v73VitHsvOd/7hqNqSQHGwCwzkCsV8aGPxrFjY/r7v8=;
        b=ncNduiHWjLCUdGPcC4ZviHe8R+WLCVc2P5KC91kcDI9bS/cxO3X2zrn3MKuSbss9b6
         VAK41qFu9lBWVOpFXMruIyL+PxNignUa1iULaiab5A8D711/GC+sLH0+Hds085ilmobt
         Nd23XqMwnDcuHp/cgNEGVMMZIrJ4nSW77jvH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=SrLiPCkAz7wE8TA9GtFUTatylTtKTUk06vXxHMNKJ7kCBymR3GazKAMFKVQKUBNNo2
         pPZmmHr3Rwe4L55h85ZzgC3GBzHTRkbDraWLFr1ZFd9pQy9lFnRgnN/dXKSlp667N2yG
         EB+C6Mjt8xgvQTd1Vh/IJOLcJnpdyxjGRE+dI=
Received: by 10.210.59.14 with SMTP id h14mr56119eba.104.1216892146699;
        Thu, 24 Jul 2008 02:35:46 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.208.47])
        by mx.google.com with ESMTPS id 32sm6473253nfu.10.2008.07.24.02.35.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 02:35:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6O9Zfr7003290;
	Thu, 24 Jul 2008 11:35:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6O9ZbpP003287;
	Thu, 24 Jul 2008 11:35:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080723145518.GA29035@laptop>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89857>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> I have not looked at non-builtin commands yet, but I think it's not
> a big deal. We have several rounds before this series is good enough =
;)
> So in short, sparse prefix will be stored in config, core.sparsecheck=
out.
> you have three new commands to enter/update/leave sparse checkout:
>=20
> git clone --path=3Dprefix       # clone with sparse checkout
> git checkout --path=3Dprefix    # limit/update checkout paths
> git checkout --full           # stop sparse checkout
>=20
> Other operations should be normal. User attempts to do anything outsi=
de
> sparse checkout will get flagged. Git itself should not touch anythin=
g
> outside sparse checkout.
>=20
> One more thing. As files outside sparse checkout will not be checking
> out, .gitignore and .gitattributes from parent directories (outside
> sparse checkout) will be gone too. This may lead to surprise.
>=20
> Comments are welcome.

A note: my comments here reflects what I have remember from reading
comments in this thread; I have not examined the code, though.


=46irst, I think that 'sparse checkout' is a better idea than former
'subtree (partial) checkout'; and I guess it could be easier to code.


Second, I think you can simply special case .git* files (.gitignore,
=2Egitattributes, .gitmodules), and always check them out for all
intermediate directories (unless configured otherwise, of course).
So for example if you have the following directory structure:

  A/.gitignore
  A/a
  A/B1/.gitignore
  A/B1/b
  A/B2/.gitignore
  A/B2/c

and you are checking out only subdirectory 'B1' (and all files in it;
if subdirectories are checked out recursively it depends on
configuration), and if for example there is .gitignore in every
directory, then checked out tree would look like this:

  A/.gitignore
  A/B1/.gitignore
  A/B1/b

The ability to do this is one of advantages of 'sparse' checkout over
'subtree' checkout.


Third, about the place where to store information about which paths
are checked out, and which are not.  There are three possible places
to store this information:

  1. repository configuration, e.g. `core.sparsecheckout' variable
     (multivalued?), like for `core.worktree'

  2. some text file in $GIT_DIR, e.g. '.git/sparse', like for shallow
     clone ("git clone --depth <depth>") it is grafts-like
     $GIT_DIR/shallow (see Documentation/technical/shallow.txt).

  3. in the index itseld ($GIT_DIR/index), as proposed by Johannes
     Schindelin.

While I do think that some information about sparseness should be in
the index, for git to be able to commit from the index for example,
I don't think it is a good place as the only/main place to store
information about which paths are checked out; I think that because
IMVHO git commands should survive hosing (removing) index file.

Just my 2 eurocents.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
