From: Chris Rorvick <chris@rorvick.com>
Subject: Re: Heads up, an emergency fix for git-cvsimport is coming shortly
Date: Sun, 30 Dec 2012 18:15:41 -0600
Message-ID: <CAEUsAPZ7kzc4qYSvD-YCk9sqQOuW219gOWyxpGqfkxmF2VC-PQ@mail.gmail.com>
References: <20121230192116.C2A2444143@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 01:16:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpT2x-0007iN-8v
	for gcvg-git-2@plane.gmane.org; Mon, 31 Dec 2012 01:16:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab2LaAPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 19:15:44 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:54180 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755200Ab2LaAPn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 19:15:43 -0500
Received: by mail-la0-f44.google.com with SMTP id fr10so3269189lab.3
        for <git@vger.kernel.org>; Sun, 30 Dec 2012 16:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=2u7v5cpz2/BFpCeCrORR4paRvPQs4AyFiOsVQECGK70=;
        b=Z/6h/pxY3K60u6d1mLGJUDz1zs6k46nmyxf986PvJK8BY6tNgomPhdGcmlJMrZD8en
         VMl/fPb+BZJWkXdgtJp3qKN+hNrXNogxCKfFbgdKEh8f6Cllt0c14608oCGlXew2Adlr
         o0iBPfYBpRlC5JAY35ImINwsYzUlCmNOWKem8TeGT3tMeaQriCcKqa4OMKmMVcnTbD0T
         vQ5CL4yDO5oOoX3EP7FG1b7AvpDEsipcoMKpHMEcFDyv3LfcuEu8YKlThRhLT9rF/Tof
         lLuwVeWIOS2mvgQcmF6UiMDnW/QOW5kqGZxerDJz6y9O5CqbxyhhdPR/4FJ47wqfx2rH
         iWCQ==
Received: by 10.152.108.37 with SMTP id hh5mr37715052lab.52.1356912941626;
 Sun, 30 Dec 2012 16:15:41 -0800 (PST)
Received: by 10.114.94.228 with HTTP; Sun, 30 Dec 2012 16:15:41 -0800 (PST)
In-Reply-To: <20121230192116.C2A2444143@snark.thyrsus.com>
X-Google-Sender-Auth: Eeoj22Ocabt0gK2KaAkADviXj-o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212345>

On Sun, Dec 30, 2012 at 1:21 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Bad news: the combination of cvsps and the existing git-cvsimport
> script is seriously broken in both places.  This morning I fixed a
> nasty bug in cvsps's branch detection and shipped 3.3. This is a
> different bug from the broken (and now removed) ancestry-branch
> tracking.

I tried the new version and found I'm unable to import via pserver:

  $ ./cvsps --root :pserver:me@localhost:/cvsroot module
  cvsps: connect error: Connection refused
  cvsps: can't get CVS log data: Connection refused

Running 2.2b1 (the version packaged w/ Fedora 17) with the same
arguments with the addition of --cvs-direct connects OK.  I haven't
taken much time to look into this, so I might be doing something dumb.
 Thought I'd find out if this is a known issue before delving into it.

Also, I'm curious what impact removing the caching from cvsps will
have on incremental imports.  Is there any?

Thanks,

Chris Rorvick
