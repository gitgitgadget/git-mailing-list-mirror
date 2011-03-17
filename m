From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git blame --follow
Date: Thu, 17 Mar 2011 17:47:31 +0100
Message-ID: <201103171747.34452.jnareb@gmail.com>
References: <201103151644.44360.wolfgang@rohdewald.de> <m3tyf25arl.fsf@localhost.localdomain> <201103171116.39411.wolfgang@rohdewald.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Wolfgang Rohdewald <wolfgang@rohdewald.de>
X-From: git-owner@vger.kernel.org Thu Mar 17 17:48:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0GNK-0007Kn-Rc
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 17:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754227Ab1CQQse convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2011 12:48:34 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61164 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab1CQQsd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 12:48:33 -0400
Received: by fxm17 with SMTP id 17so2884662fxm.19
        for <git@vger.kernel.org>; Thu, 17 Mar 2011 09:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=S6YL/4PLM2maGY+ilyd2YyA2ra8ZSNdcsfCSFC38JjM=;
        b=X07xGVSB2/Sx/hVXMcZi1ZzocZy9iylPHGlzrhx8XPY5to14KUCEQJqbW70eRYLCnQ
         OZrznMVfvO6WmPkzLVbYiq3gH2LVOYK0Qvwk6DBFvEagY3y1BoII6mc4fDzJ0NTQ6gCo
         IjUJc/1ifo9r7Od4vBbKYvQ1SxtDdlBhnkSGc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vZwdpsrv1rFdyJvY5W/QgtUI6egYPY8XmdeHk+Hi/Q0nxsAZxR4v6VFP+3JIdvA1uQ
         AkZp2ybD0iQ0HzJKeoDywvr240a5X0Gsp4GJ6z5mOZblok6HJ79kE6EQ+PL08UwIw1hW
         tVCWAqGzf1uYy+I6hLNQrd1FFfRxp1nO5O+lo=
Received: by 10.223.55.201 with SMTP id v9mr209876fag.76.1300380467615;
        Thu, 17 Mar 2011 09:47:47 -0700 (PDT)
Received: from [192.168.1.13] (aeho51.neoplus.adsl.tpnet.pl [79.186.196.51])
        by mx.google.com with ESMTPS id c24sm680674fak.7.2011.03.17.09.47.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2011 09:47:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201103171116.39411.wolfgang@rohdewald.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169249>

Dnia czwartek 17. marca 2011 11:16, Wolfgang Rohdewald napisa=C5=82:
> On Donnerstag 17 M=C3=A4rz 2011, Jakub Narebski wrote:

> > So you probably want to run "git blame -C -C <file>", not "git
> > blame <file>".
>=20
> that does the trick - I only tried "git blame -C"

Hmmm... it is described in git-blame(1) manpage, but you have to read
it carefully.


"git blame" synopsis states:

 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w]=
 [--incremental] [-L n,m]
             [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=3D<date>]
             [<rev> | --contents <file> | --reverse <rev>] [--] <file>

The important thing is to notice '[-C] [-C] [-C]' here.


In the description of '-C' option we have:

  -C|<num>|::
        In addition to `-M`, detect lines moved or copied from other
        files that were modified in the same commit.  This is
        useful when you reorganize your program and move code
        around across files.  When this option is given twice,
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        the command additionally looks for copies from other
        files in the commit that creates the file. When this
        option is given three times, the command additionally
        looks for copies from other files in any commit.

I have underlined important part.
--=20
Jakub Narebski
Poland
