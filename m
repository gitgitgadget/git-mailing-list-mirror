From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Thu, 22 Sep 2011 15:54:50 -0700 (PDT)
Message-ID: <m3vcskqjcv.fsf@localhost.localdomain>
References: <4E7A3BDE.3040301@alum.mit.edu>
	<7vy5xh1whq.fsf@alter.siamese.dyndns.org>
	<4E7AF1AE.5030005@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 23 00:54:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6sAU-0002uu-Mp
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 00:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab1IVWyy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Sep 2011 18:54:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62482 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560Ab1IVWyx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2011 18:54:53 -0400
Received: by fxe4 with SMTP id 4so3221896fxe.19
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 15:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=bQlDy5q1hTYGSDGHnsAoft5IwSGJR92AEEErV1BF458=;
        b=uRTIntXjuxt3GFvWFN2pBOAZ1QeK7g+2ibKJH7jcD4ralMNC+F2k1U40yXY0vtIV4s
         +7rTTdGlFnzHYGcnk0b/yYrXC4Bwu880Pt0xCk51eoKg2lidt8BnXXKdc8RNzfCiKQSx
         dP6X0eAH7mXGU1zhjpT2Iul00Wg2Y+9wWmew8=
Received: by 10.223.11.23 with SMTP id r23mr3969923far.38.1316732092375;
        Thu, 22 Sep 2011 15:54:52 -0700 (PDT)
Received: from localhost.localdomain (abwe70.neoplus.adsl.tpnet.pl. [83.8.228.70])
        by mx.google.com with ESMTPS id a7sm8961640fam.22.2011.09.22.15.54.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 15:54:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p8MMsFBf013701;
	Fri, 23 Sep 2011 00:54:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p8MMrsEX013696;
	Fri, 23 Sep 2011 00:53:54 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E7AF1AE.5030005@alum.mit.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181932>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Thanks for the reply and for explaining how the index can(not) be use=
d
> for this purpose.  But what you propose is not flexible enough for me=
=2E
> I would like the checking configuration to be *versioned* along with =
the
> code. [...]

[...]

> For this to be possible, I would need to determine the git attributes=
 to
> apply to a particular file in a particular commit; something like
>=20
>     git check-attr check-space-indent $SHA1:path/to/file
>=20
> This does not seem to be possible today without writing my own code t=
o
> crawl and parse the gitattributes files from a particular commit.

Unfortunately it doesn't seem to be there mechanism to query about
state of gitattributes at given commit.

There is a slight problem from the UI point of view of git-check-attr,
namely that there are _three_ pieces of information: a place to read
=2Egitattributes from (working tree, index, commit), list of attributes
to check (or --all) and list of files (list of paths).  You can use
"--" to separate _two_ pieces of information.

Nb. the ability to read gitattributes from given commit would be
useful also for gitweb (the `encoding` gitattribute, etc.).

--=20
Jakub Nar=EAbski
