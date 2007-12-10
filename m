From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 0/2] [RFT] git-svn: more efficient revision -> commit
	mapping
Date: Sun, 09 Dec 2007 17:04:06 -0800
Message-ID: <1197248646.7185.25.camel@brick>
References: <1197185262-16765-1-git-send-email-normalperson@yhbt.net>
	 <1197233768.7185.6.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Dec 10 02:04:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1X4M-0006t0-S0
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 02:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754044AbXLJBEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 20:04:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbXLJBEF
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 20:04:05 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:7724 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523AbXLJBED (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 20:04:03 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1424592rvb
        for <git@vger.kernel.org>; Sun, 09 Dec 2007 17:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=Z70y0p5C/s9VOwZMTAhJUIbTiJOqsP6rIAtYpbqLE3I=;
        b=I8Toli71y8uhyNP/s1hgAC/Q11XKrUduF21dTvtn+pS6iW5jJv/naqNLyUNfvn8o9pwe2XnG+DUQ4YyPZodRIzzsla+qCxWQIY2Eh2Ju8EP8RryenzfTV8pYSb86vthRyNH2MMpBRAcbsc8/0vJ1svwEpY2GHMPbvsp/qUw6sBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=VLII80BQdZXKACP3Rk0r6Xbg4Zj0i2CSNjNFDu6TQwzdYioy+RK8rZdIx3ETrqX7CHcJ+BjHOfA4OGJS6sOejkPYQZ2jUhQzBV2XQ1C1bez6xdBk1pT5LOhEJfznIomg0haPmLK9v6QtFIpoHQ2+i5FFO6GQJ2ZwC0ErCAzBEyk=
Received: by 10.141.50.17 with SMTP id c17mr3933813rvk.1197248641871;
        Sun, 09 Dec 2007 17:04:01 -0800 (PST)
Received: from ?192.168.1.124? ( [216.19.190.48])
        by mx.google.com with ESMTPS id c14sm4598058rvf.2007.12.09.17.04.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Dec 2007 17:04:01 -0800 (PST)
In-Reply-To: <1197233768.7185.6.camel@brick>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67666>

On Sun, 2007-12-09 at 12:56 -0800, Harvey Harrison wrote:
> On Sat, 2007-12-08 at 23:27 -0800, Eric Wong wrote:
> > This is very lightly tested, but describes the format I described in:
> > 
> >   http://article.gmane.org/gmane.comp.version-control.git/67126
> > 
> >   (more in the commit messages)
> > 
> > I'll be out of town the next few days and I'm not sure how much I'll be
> > able to follow up on it while I'm gone.  Please test, especially if
> > you're dealing with a repository where large .rev_db files are a
> > problem.
> > 
> > Junio: not intended for master just yet, but if you hear nothing but
> > good things about it, feel free :)
> Preliminary tests against the gcc repo are going swimmingly.
> 
> Successful git svn rebase against trunk, doing a full git svn fetch
> now to build rev_maps for all svn branches/tags.  At halfway through
> space has decreased from ~2GB to 17MB for about half of the needed
> metadata.
> 

Eric,

I'm very happy with these patches.  For the gcc repo, git-svn metadata
has gone from over 5GB to 33MB.  git-svn fetch/rebase are working fine,
will shout if I see any odd behavior.

Harvey
