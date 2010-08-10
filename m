From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/10] rr/svn-export reroll
Date: Tue, 10 Aug 2010 18:23:45 +0530
Message-ID: <20100810125317.GB3921@kytes>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 14:56:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OioN3-0007Ce-ID
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 14:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757509Ab0HJMzx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 08:55:53 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59285 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757067Ab0HJMzv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 08:55:51 -0400
Received: by pwj7 with SMTP id 7so1718495pwj.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4RJrHTka6Kkj5pr4QQkp3GcrLi4K4u9t4LRJWz/5124=;
        b=mdAi/VA4havVMNQV2KKUQfxt46eEYyIOZFPXJVeVrOJMDVd8zd8bog2cerySXlxedG
         i/CMB/sNHgf378Osn8Jh6Wb+Ne9ejakjI7AInBz5iQaLJXpbYevevU1B+GePDsWXWP1v
         kM06vVqhpdS2g5pL3TKwh6tNot2BDY9eyR688=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=tWM7rLVKKtOr4asSQd2xeW0Vace4+wlePxPKes8/iPV1JcOZEdkQR18THbXhD1Kvli
         cKpd1cZlxgkLzAFqtNs6Z3zxIzTCMAQzzt+yYYE0wLl191LUqoxgvtuINpzMeo6YjYKA
         SJqLsUsAlHrBI/wnsJuIVpOuAtwoOVCjx+Mco=
Received: by 10.142.192.1 with SMTP id p1mr14775618wff.225.1281444951247;
        Tue, 10 Aug 2010 05:55:51 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id y16sm7763203wff.14.2010.08.10.05.55.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 05:55:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100809215719.GA4203@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153100>

Hi Jonathan,

Jonathan Nieder writes:
> svn-fe has some serious changes on the horizon.  As a preparation,
> let=E2=80=99s round up what we have now.
>=20
> The most controversial change is probably the new svn-fe test, which
> takes about 15 seconds (for the =E2=80=9Csvnadmin load=E2=80=9D, not =
the svn-fe
> step :)).  It is in the t9* series, so hopefully that will not
> dissuade people from running the earlier tests.

I'll comment on this separately.

> The main highlight in the changes is a new
>=20
> 	Input error
>=20
> to stderr if a system call failed in reading in the dump file.
> It still returns status 0 in this and other error situations,
> though.

I'll comment on this separately.

> Based on maint (for no good reason; that=E2=80=99s just where I tried=
 it).
> Intended to replace rr/svn-export in pu (only if Ram likes it, of
> course).

Thanks for re-rolling (again)! You've also added a note to the commit
messages briefly explaining what each contributor has done. I'd
expected some incremental patches instead of a full re-roll, but
whatever works is good :)

> David Barr (5):
>   Add memory pool library
>   Add string-specific memory pool
>   Add stream helper library
>   Infrastructure to write revisions in fast-export format
>   SVN dump parser
>
> Jason Evans (1):
>   Add treap implementation
>
> Jonathan Nieder (4):
>   Introduce vcs-svn lib

All these are good :)

>   Export parse_date_basic() to convert a date string to timestamp

Wasn't this ejected from this series and made a separate patch?

>   Update svn-fe manual

Removed the BUG since we've turned off persistence.

>   svn-fe manual: Clarify warning about deltas in dumpfiles

We have to fix this real soon- I'm waiting for the weekend so I get
some solid chunks of hacking time.

-- Ram
