From: "Brian Foster" <blf@utvinternet.ie>
Subject: Re: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 11:45:39 +0200
Message-ID: <a537dd660804160245q5fd3a0d9jc37802765601b176@mail.gmail.com>
References: <200804161128.04245.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 11:46:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm4Di-0007KM-Fg
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 11:46:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966AbYDPJpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 05:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756107AbYDPJpl
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 05:45:41 -0400
Received: from rv-out-0708.google.com ([209.85.198.250]:18150 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755788AbYDPJpk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 05:45:40 -0400
Received: by rv-out-0506.google.com with SMTP id k29so1109721rvb.1
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 02:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=GsbqKAneHqYxbAU9GqQ7Z6KW9F8XU7fe9f/G8ddO4fk=;
        b=istY3p6XTXDvMHDJMLltA9/YhsXse887cPa4upIi5NUJrK5lw+OuXAeE5WYUOOHFeoD9eytK7xIwuWVU7eEOTujLqKqLL3htreboW/fM+3p4JdYR76KzkVLufhAQ2SSHh4aEaK1JTKacGBeSQgy519A+HFozJ80TROWF0jIjYbM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=BHbHb8sEgKMEluylxphjKVznvFn3e+bWZXYHUNZc7ZqtXe1uBRmi3caKeUDeK6WjJgsaXSLmQpHtSv23U11ty5BNEe5/8gU0HTGS1p2P/ULhhfBv0jvjWpnmnpox3UxMyI7LZ90lKJd9MPR3dpf6rL2k2IdXaMcXahvzCroXgxg=
Received: by 10.140.202.12 with SMTP id z12mr5051031rvf.186.1208339139682;
        Wed, 16 Apr 2008 02:45:39 -0700 (PDT)
Received: by 10.141.123.21 with HTTP; Wed, 16 Apr 2008 02:45:39 -0700 (PDT)
In-Reply-To: <200804161128.04245.brian.foster@innova-card.com>
Content-Disposition: inline
X-Google-Sender-Auth: 810a4a646af15fb9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79689>

David Kastrup <dak@gnu.org> sensibly asks:
>  Brian Foster <brian.foster@innova-card.com> writes:
>  >  I've recently inherited a bare git repository,
>  >  which, as far as I can tell (I'm something of
>  >  a newbie with git), seems Ok: `git fsck --full'
>  >  does not report any problems.    however, any
>  >  clones I make from it are not Ok:
>  >
>  >       $ git-fsck --full   # clone (same command for bare repo is Ok)
>  >       broken link from  commit dd3f3c0636cfd50719c706b030db5473b0270add
>  >                     to  commit 0fed9c2eb14eee47097e1d870fe8e55a6430edeb
>  >       missing commit fb57c018d15005b60f104e57f198ff34a6035b99
>  >       missing commit f8947cb0b5fe605e6cb5f73c89f262424b64ef3c
>  >       missing commit 0fed9c2eb14eee47097e1d870fe8e55a6430edeb
>  >       missing commit dff364d8da15be0b856a174062fb785acb1c363e
>
>  From the git-clone manpage
>         --shared, -s  [ ... ]
>
>  Did you use something like that?

 NO, not for any of the clones I've made.  basically,
 I've tried:

   git clone        git://SERVER/PATH   # on a remote machine
   git clone --bare git://SERVER/PATH   # on a remote machine
   git clone        /FULL/PATH          # on the SERVER
   git clone --bare /FULL/PATH          # on the SERVER

 and possibly a few other variants along similar lines.
 nothing fancy.  just the sort of routine simple stuff
 you'd expect to work, and expect(?) a newbie to use.

 none of my clones, nor the repro on SERVER I'm trying
 to clone, have any .../objects/info/alternates

cheers!
	-blf-
-- 
"How many surrealists does it take to    |  Brian Foster
 change a lightbulb?  Three.  One calms  |  somewhere in south of France
 the warthog, and two fill the bathtub   |     Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools."  |       http://www.stopesso.com
