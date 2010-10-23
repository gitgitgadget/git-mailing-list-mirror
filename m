From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 01/10] Better "Changed but not updated" message in git-status
Date: Sat, 23 Oct 2010 11:55:13 -0700 (PDT)
Message-ID: <m3k4l8kaeg.fsf@localhost.localdomain>
References: <1287851481-27952-1-git-send-email-Matthieu.Moy@imag.fr>
	<1287851481-27952-2-git-send-email-Matthieu.Moy@imag.fr>
	<20101023181350.GA21040@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com, Thore Husfeldt <thore.husfeldt@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 23 20:55:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9jFV-0001ia-6O
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 20:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758238Ab0JWSzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 14:55:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33946 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758211Ab0JWSzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 14:55:16 -0400
Received: by fxm16 with SMTP id 16so1658747fxm.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=PM3UMBpUrZ8ta5sxY6PBJ7brf91/X8uhdUtTqA21C7g=;
        b=kQJIbRU5ZpeZqssz+Ke2fReY1seILZ5bJ9VMH7etuNvsm7hUP0V2PLKpvO5UtMbCM/
         jmN7X1IzEPOwsYd/sH2lPcSVe7zJO6S+FbwXWdf6ebWdabExn96432XpiC+DhEOemWpA
         YaktvSzt1YpIzMXGe8XeEDlQTpZwh0oYOt3GE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=fxh6c0Kn5BX5bjUW+akXlb2m2Zg7Tvjs03RcPz2KqhwQ/TgxIVlyIP0pKPyf84yJAm
         UQxX3sWhBU42kZ4yiTjaGFxWWW2Y53WPxNiip4HRGMc0M4G4xpr1ACVpriFeofV0KhRB
         vIqc5qFY3NF0tSgLTwtQvyqLfJ53Art9GYMZw=
Received: by 10.103.239.14 with SMTP id q14mr5491303mur.15.1287860114918;
        Sat, 23 Oct 2010 11:55:14 -0700 (PDT)
Received: from localhost.localdomain (abvr155.neoplus.adsl.tpnet.pl [83.8.215.155])
        by mx.google.com with ESMTPS id a16sm2044051fak.43.2010.10.23.11.55.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Oct 2010 11:55:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o9NIsblu023873;
	Sat, 23 Oct 2010 20:54:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o9NIsFH2023867;
	Sat, 23 Oct 2010 20:54:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20101023181350.GA21040@burratino>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159813>

Jonathan Nieder <jrnieder@gmail.com> writes:
> Matthieu Moy wrote:
> 
> > --- a/Documentation/gittutorial-2.txt
> > +++ b/Documentation/gittutorial-2.txt
> > @@ -373,7 +373,7 @@ $ git status
> >  #
> >  #       new file: closing.txt
> >  #
> > -# Changed but not updated:
> > +# Changed but not staged for commit:
> >  #   (use "git add <file>..." to update what will be committed)
> 
> I find this even more confusing, though I admit that may be due to
> habit more than anything else.

Perhaps

     # Changed but changes not staged for commit:
 
> My reading, before:
> 
> 	These files were changed, but the version to be committed has
> 	not been updated to include the latest changes (use "git add
> 	<file>..." to add these changes to the index).
> 
> Afterwards:
> 
> 	These files were changed, but they are not staged for the
> 	next commit.
> 
> If I do
> 
> 	echo hello >hi.c
> 	git add hi.c
> 	echo world >>hi.c
> 	git status
> 
> then what does it mean to say "hi.c" is not staged for commit?
> It actually does have changes ready for committing.
> 
> I would prefer to say something to the effect of
> 
> 	# Has unstaged changes:
> 
> Anyone wordsmiths out there with ideas to make this clearer?

But this might be a better solution.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
