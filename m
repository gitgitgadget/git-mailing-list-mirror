From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Introduce .git/BRANCH to point to the current branch
Date: Tue, 04 Dec 2007 12:42:43 -0800 (PST)
Message-ID: <m34peyur8r.fsf@roke.D-201>
References: <4755B3B3.80704@gmail.com> <vpqbq96jjrf.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Salikh Zakirov <salikh@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Dec 04 21:43:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Izebo-00011D-5j
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 21:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbXLDUmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 15:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbXLDUmv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 15:42:51 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:64288 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753777AbXLDUms (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 15:42:48 -0500
Received: by nf-out-0910.google.com with SMTP id g13so2982438nfb
        for <git@vger.kernel.org>; Tue, 04 Dec 2007 12:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=1vzQTxK1AtoAHHFrDH8ApWG09O7HEMVQtK5Dq0mJ+BM=;
        b=SRJAn/4ubxFQq3lTCkBoczgbpNnWFFVTcKrgvzIQfMefpql67CGXaVN6s9nzyZfzvTqaoFjyZwlo0QTBY9c2oPmxcLkBlc4UIuzuvVtir5KUJfFR6V7/2kkJXpTl7/sRhjCCBLwpla32gc0oVAES00xudfkdis5LMrcxKNaDFCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=LbKXHOiZBJCngSkKrDv13hvFNdxrokHVnjXYmRqwmZRrj/IVR0vtCsQSzE3q8MprrQIQa2Uzbuy2xh+iarB1gCs3hhVENtxk8Ke5QG5xEsUxGqS1ivO84ognIvUckwK0rQU0gghNUXoCeT8bykgQmDqO5nsD7SDmOyJKRbscMh0=
Received: by 10.86.54.3 with SMTP id c3mr9657353fga.1196800964994;
        Tue, 04 Dec 2007 12:42:44 -0800 (PST)
Received: from roke.D-201 ( [83.8.233.204])
        by mx.google.com with ESMTPS id g28sm735062fkg.2007.12.04.12.42.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Dec 2007 12:42:43 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB4Kgcot019682;
	Tue, 4 Dec 2007 21:42:38 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lB4Kg6nm019672;
	Tue, 4 Dec 2007 21:42:06 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <vpqbq96jjrf.fsf@bauges.imag.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67082>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Salikh Zakirov <salikh@gmail.com> writes:
> 
> > This combination leads to the confusing user experience
> > if the branch changes independently of the working directory.
> > This can happen in following cases:

All those cases are cases of not recommended workflows.

Please search the archives for idea of BASE extension to index
(instead of your separate file under .git/refs), and why it is
not in current git.

BTW. how in your proposal would you detach HEAD?

> There's another thing that your proposal could change: navigating back
> in history without loosing track of the branch you're on.
> 
> Currently, I can do:
> 
> # Oh, what did this look like two commits ago?
> $ git checkout HEAD^^
> # Ah, OK, let's go back to the tip
> $ git checkout branch-name
>                ^^^^^^^^^^^
> But I have to remember and re-type the branch name.

No, you don't have. You can use
  $ git checkout ORIG_HEAD
or
  $ git checkout HEAD@{1}

-- 
Jakub Narebski
ShadeHawk on #git
Poland
