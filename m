From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v4 14/14] difftool/mergetool: refactor commands to use
	git-mergetool--lib
Date: Tue, 7 Apr 2009 23:35:58 -0700
Message-ID: <20090408063557.GA14404@gmail.com>
References: <1239145213-76701-1-git-send-email-davvid@gmail.com> <200904080733.01030.markus.heidelberg@web.de> <7vtz4zr80v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: markus.heidelberg@web.de, git@vger.kernel.org,
	charles@hashpling.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 08:37:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrRQ0-0005Fz-90
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 08:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761423AbZDHGgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 02:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761323AbZDHGgQ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 02:36:16 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:18701 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761191AbZDHGgP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 02:36:15 -0400
Received: by wa-out-1112.google.com with SMTP id j5so2287257wah.21
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 23:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZLv/jCNchLQS7qk6MTb3rojZJmkw1Ec20aZ7SAmJVi4=;
        b=IusfDRuMhqxDrRoC4JogGdA19Xl2NzGbD12fPEOUwcJUiaONnDnw2TlAtbD0cHqid2
         +wqvOqY2VgqFXSjzbVOdvUjcq6yux7glcgiq3d6fj2jhIfGQpn2Am1vYuNLgxB3bGMAR
         0RkHHst9t2ZZ2+4qpDmS+Mjr1uaSkt4yMpjHw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AQOVw5Pu0vlb6lSXcNpKk2WqnycyCFdM35ZAkGgUpoh3N0uQVgrdClTID29aMQSgIg
         bnz2CheXt4qxeUt/rgZGp7qjAUw4evgi5Nrb0/bL7gYGsNBrITqnG0gxUvyux/vXGi1P
         yncjwbhMjgGm+pK/0P2iDk2diRR6asna5ioqc=
Received: by 10.114.193.15 with SMTP id q15mr546009waf.199.1239172574352;
        Tue, 07 Apr 2009 23:36:14 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l38sm7987594waf.68.2009.04.07.23.36.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 23:36:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vtz4zr80v.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116048>

On  0, Junio C Hamano <gitster@pobox.com> wrote:
> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> >> +	tools="$(echo "$tools" | sed -e 's/ +/ /g')"
> >
> > Doesn't work for me. For me 's/ \+/ /g' works.
> > ...like this: 's/[ 	]\+/ /g' (space and tab)
> 
> Pleae don't.  "s/  */ /g' should be the most portable (the point being "do
> not use one-or-more +").

v5 14/14.  good stuff.


> > Looks good to me, after these last 2 issues are adjusted.
> > Maybe resend the whole series then, so that Junio can apply them easily?
> 
> Thanks.  I've replaced the series with the following applied on top of the
> 'master', but I won't be merging them to 'next' for tonight, I guess.
> 
> ...
> [PATCH v2 07/14] difftool: add a -y shortcut for --no-prompt
> [PATCH v2 09/14] difftool: move 'git-difftool' out of contrib
> [PATCH v3 10/14] difftool: add various git-difftool tests
> [PATCH v2 11/14] difftool: add support for a difftool.prompt config variable
> [PATCH v4 14/14] difftool/mergetool: refactor commands to use git-mergetool--lib
> 
> It appears that, assuming that up to 13/14 above is what you two expected
> me to pick up, we would perhaps need to only replace 14/14?

Yup

> 
> As the final sanity check, please eyeball the attached interdiff, created
> this way:

That looks right to me.

> 
>  $ git checkout master^0
>  $ git am -s ./+da-fourteen-patches
>  $ A=$(git rev-parse HEAD)
>  $ git reset --hard master
>  $ git merge da/difftool ;# old series
>  $ git diff --stat -p HEAD $A ;# what's new in the new series?
> 
>  Documentation/config.txt               |    3 +-
>  Documentation/git-mergetool.txt        |    2 +-
>  Documentation/merge-config.txt         |    6 +-
>  command-list.txt                       |    1 -
>  contrib/completion/git-completion.bash |    2 +-
>  git-mergetool--lib.sh                  |  237 ++++++++++++++++++--------------
>  t/t7800-difftool.sh                    |    4 +-
>  7 files changed, 144 insertions(+), 111 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> ...

-- 

	David
