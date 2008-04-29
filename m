From: "David Aguilar" <davvid@gmail.com>
Subject: Re: Git Library?
Date: Mon, 28 Apr 2008 23:58:48 -0700
Message-ID: <402731c90804282358i205334b8me56f4390456873b4@mail.gmail.com>
References: <5FCF765E-F3FF-438C-B4C1-FFB3262831A0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Patrick Altman" <paltman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 08:59:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqjoQ-0003id-MP
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 08:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbYD2G6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 02:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbYD2G6v
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 02:58:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:9128 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbYD2G6v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 02:58:51 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1055223ugc.16
        for <git@vger.kernel.org>; Mon, 28 Apr 2008 23:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=bWOtAFKXaqsqX4BDwMugALAFdgnVkadRiIIR2DvL1PA=;
        b=rGiTcrAlOhboj3sKdh6E4fACBgSL5bF7bkrS/ktvlJfDS0xNpOTqcecwxldocnR6bDX88uLZiOE66sETtX+pEVHJap6MYxMakIfSU/2pfQvSdUNxN0gFyJKWDbUYw//DhVG53XqJuDXLGwA6IFqiEW4r1iO9yTnCVTEr7rcpqdw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CzHzrOhkFy/BVQZPMPAS8uJdpifJXXXDG/6NoKQWeByPxctH1SNA0n1bXsU29bOiz6tdbK2p3Q06LtQhZMU5qVYoLV2FzJkno5Wdb/rhE9NePEriJ1SYOPNMh7E+nYM4/CkA1CzDBBZI0m+9CV40UjOr/Cv0AtIgu2oxbZMHXTI=
Received: by 10.67.32.7 with SMTP id k7mr6020603ugj.11.1209452328426;
        Mon, 28 Apr 2008 23:58:48 -0700 (PDT)
Received: by 10.66.236.11 with HTTP; Mon, 28 Apr 2008 23:58:48 -0700 (PDT)
In-Reply-To: <5FCF765E-F3FF-438C-B4C1-FFB3262831A0@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80656>

On Mon, Apr 28, 2008 at 11:55 AM, Patrick Altman <paltman@gmail.com> wrote:
> I want to write a Mac OSX UI for git.
>

git gui works on OSX.
Aside from that, someone's already written one* :-)

    http://repo.or.cz/ugit.git
    http://ugit.sf.net/


>  Is there a documented/undocumented API for interacting with git in process?
> Or would I be better off "shelling out" to the git command line?

Fork/exec.

If you grabbed the ugit modules you could say:

    from ugit import git

    revisions = git.rev_list(all=True).splitlines()

    file = open('msg', 'w')
    file.write("commit message." )
    file.close()

    git.commit(F='msg', s=True)

    etc, etc.

It's pretty much 90%+ of git wrapped in Python.
If a libgit.so did appear one day it would be trivial to swap out the
meta-functions in
git.py and replace them with e.g. swig replacements.  Until then,
forking out works
just fine.

stg also has Python wrapped around git so you could look there too.

-- 
 David


* - okay, I lied. It's PyQt4.  But it does run on OSX and looks just
like any other cocoa app.
