From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2011, #09; Sun, 23)
Date: Mon, 24 Oct 2011 17:07:27 -0700 (PDT)
Message-ID: <m3ipne53ze.fsf@localhost.localdomain>
References: <7v39ei4d9o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kato Kazuyoshi <kato.kazuyoshi@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 02:07:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIUYJ-0006yA-SZ
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 02:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab1JYAHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 20:07:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63603 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755774Ab1JYAHa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 20:07:30 -0400
Received: by faan17 with SMTP id n17so195551faa.19
        for <git@vger.kernel.org>; Mon, 24 Oct 2011 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=GRTA5EgyjuLIWLRJ8v4/iiPujqySm1pqvHKdk8k7v6A=;
        b=Y84s2jdg28Q3fTc+TtEI6B2/gPOuTJu/DwM36mIoaXmkg4fTHiuar+zOoYTqSPEPHY
         L8ogCO64FoWwQN32lkKchAzWgdw53sQtmO+0SZ+Rzs1In96ORQz6iyirLNiWyGB6AOul
         RyT7p7517ySESNZgBV+M3bnL/GP/Nb+LXto9g=
Received: by 10.223.64.197 with SMTP id f5mr6837481fai.24.1319501248825;
        Mon, 24 Oct 2011 17:07:28 -0700 (PDT)
Received: from localhost.localdomain (aehn63.neoplus.adsl.tpnet.pl. [79.186.195.63])
        by mx.google.com with ESMTPS id s5sm31365731fab.2.2011.10.24.17.07.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Oct 2011 17:07:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9P074jw010699;
	Tue, 25 Oct 2011 02:07:14 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9P06jR2010694;
	Tue, 25 Oct 2011 02:06:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7v39ei4d9o.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184196>

Junio C Hamano <gitster@pobox.com> writes:

[...]
> By the way, I am planning to stop pushing the generated documentation
> branches to the above repositories in the near term, as they are not
> sources. The only reason the source repository at k.org has hosted these
> branches was because it was the only repository over there that was
> writable by me; it was an ugly historical and administrative workaround
> and not a demonstration of the best practice.
> 
> They are pushed to their own separate repositories instead:
> 
>         git://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
>         git://repo.or.cz/git-{htmldocs,manpages}.git/
>         https://code.google.com/p/git-{htmldocs,manpages}.git/
>         https://github.com/gitster/git-{htmldocs,manpages}.git/

Junio, don't forget to update MaintNotes ("A note from maintainer")
when this happens, though.
 
> * kk/gitweb-side-by-side-diff (2011-10-17) 2 commits
>  - gitweb: add a feature to show side-by-side diff
>  - gitweb: change format_diff_line() to remove leading SP from $diff_class

Nb. I have originally intended to wait for Kato for re-roll with
cleaned up whitespace to be able to apply it and run it before doing
detailed review.  

But then I got sidetracked with noticing inefficiency in diff body
line classification and Junio's proposal to fix it.  Thic change as
written makes first patch in above series unnecessary.  But because of
a bit unnecessary change it was not trivial to resolve Kato's changes
on top of it.  This is 'gitweb/side-by-side-diff' branch

  http://repo.or.cz/w/git/jnareb-git.git/patches/refs/heads/origin..refs/heads/gitweb/side-by-side-diff


Then I have separated adding navigation from other changes, and
basically rewrote layout for side-by-side diff, with adding "filler"
lines instead of box within box as in original submission.  

While at it I have refactored HTML-formatting of chunk header lines
into separate subroutines, making format_diff_line much easier tor
read.

This can be found in 'gitweb/side-by-side-diff-v2' branch

  http://repo.or.cz/w/git/jnareb-git.git/patches/refs/heads/origin..refs/heads/gitweb/side-by-side-diff-v2

Next I went back to Kato's box in box layout idea... kind of, as
context lines are grouped together, and not output line by line.

Also I have added here subtle backround color: separate for pure add,
pure remove, and [supposed] change.  I think this makes side-by-side
diff more readable.

  http://repo.or.cz/w/git/jnareb-git.git/patches/refs/heads/origin..refs/heads/gitweb/side-by-side-diff-v3

> Fun.
> Will keep in 'pu' until the planned re-roll comes.

I am now working on layout using HTML and CSS which would allow to
have a bit of separation between left and right panes in side-by-side
diff, but use pure-CSS "slantalicious"[1] to join background color
markers, e.g. a la http://meld.sourceforge.net/meld_file1.png

More fun!

[1] http://meyerweb.com/eric/css/edge/slantastic/demo.html
  
-- 
Jakub Narebski
