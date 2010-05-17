From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add git format-patch produced patches to .gitignore
Date: Sun, 16 May 2010 21:22:44 -0500
Message-ID: <20100517022244.GA19141@progeny.tock>
References: <1273958566-7328-1-git-send-email-avarab@gmail.com>
 <4BEFFBB5.7010808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 17 04:22:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODpyZ-0007W7-MG
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 04:22:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab0EQCWe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 22:22:34 -0400
Received: from mail-yw0-f187.google.com ([209.85.211.187]:44505 "EHLO
	mail-yw0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab0EQCWd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 22:22:33 -0400
Received: by ywh17 with SMTP id 17so2346816ywh.22
        for <git@vger.kernel.org>; Sun, 16 May 2010 19:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Di6HCffVIyxMAbsn93SJoA/b5DtwH+tYqLvoEIuuoA4=;
        b=bIm/AMPt9fGNEuHM5ZcYn02gBR+Vqm1ktzBOxy59dYXr0bCh9jLCjHbGsUhnv/divi
         VEH3Ck/pm3RYoHkBD0mM3GbXvAYHLpYsR+pmYVsWSjsXmwSqe9W64ho39Wwjf9XhvaTy
         q00ceOVv0sJYZegqztyWvMmO0OsXM59m4e+0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=RsvPKv0ZTUVfE1ErXcg+tAQFG07v+J4JOvSwM+595HWXh0CXqRbldzesLDlL402ma0
         tFLJgoRPLk+lu1dqG1kevwtLphp8fx6EaBJ3+JrbQCaC9903FZYz/jZUXEf9o5i5mXLG
         uYnOr63UpE9C5dQ9HppQoK+HFOc9ApHCkq/ek=
Received: by 10.101.105.22 with SMTP id h22mr5187734anm.35.1274062951903;
        Sun, 16 May 2010 19:22:31 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3697368ywh.4.2010.05.16.19.22.29
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 16 May 2010 19:22:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BEFFBB5.7010808@drmicha.warpmail.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147205>

Michael J Gruber wrote:

> If you want to ignore format patch output, simply use .git/info/exclu=
des
> or a global excludes file, but please don't force everyone else to li=
ve
> with that or work around it.

Side note: I said with similar intent that this allows developers to
work =E2=80=9Cwithout interference=E2=80=9D.  This was a poor choice of=
 words on my
part: a too-long .gitignore only prevents me from noticing and
tracking files that others considered not worth tracking.

=46rom the thread I faintly remembered and then linked to[1]: ;-)

  I earlier said that "*~" should not be in project-wide .gitignore
  file because use of Emacs vs vi is a matter of personal taste, and
  Emacs specific "*~" pattern does not belong to a project policy,
  just like vim "*.swp" pattern doesn't.

  But I think that reasoning is flawed.  The right criteria should not
  be about "use of Emacs vs vi", but about "do we in this project ever
  want to track files that match *~ or *.swp as legitimate contents".
  If a project expects not to have a tracked file whose name ends with
  ".swp", even if it does _not_ mean to encourage use of vim over
  Emacs or any other editor, I think it is fine to add such to its
  tracked .gitignore file for its developer's benefit.

This does not change my conclusion: there are many other reasons to
leave files produced outside the build process unlisted:

 . consistency: to keep the file intuitive and avoid a lot of
   patch churn, it is nicest to choose one rule and stick to it

 . simplicity: shorter .gitignore.  Making the appropriate content
   of .gitignore depend on the behavior of too many text editors
   (and IDEs, and foreign VCSes, and debugging tools, and ...)
   makes it hard to maintain.  See qt=E2=80=99s .gitignore for an examp=
le
   of this.

 . correctness: for the case of format-patch, it is hard to say
   "we will never want to track files that match ????-*.patch as
   legitimate contents".  In fact, it is likely such files may need
   to be added to the test suite.

And unlike .o files and company, it does not seem likely that
formatted patches need to be kept around during development.

I hope that is a little clearer.  Sorry for the ramble.
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/96220/focus=3D=
96294
