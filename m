From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 23 Apr 2008 09:59:29 +0800
Message-ID: <46dff0320804221859x7641144fua34df89fcc686aa2@mail.gmail.com>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	 <200804221655.11914.Josef.Weidendorfer@gmx.de>
	 <46dff0320804221013m2ff0320am31b7f8beb5f26f1b@mail.gmail.com>
	 <200804222007.03439.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 23 04:00:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoUHV-0004aF-MY
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 04:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759670AbYDWB7e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 21:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759605AbYDWB7e
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 21:59:34 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:15971 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759600AbYDWB7d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 21:59:33 -0400
Received: by yw-out-2324.google.com with SMTP id 5so24492ywh.1
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 18:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=HRrzRXoqqmTZILxs0uwzKNjD42PnHQHM13t9Cw/8+e8=;
        b=ZAVr6WCb+JqaRh9EoCW+w5whRFC//meZM9kT9GISrvjSwLOMaUEYbJt4YL0d0wuoDzxUbA+Fj3uCRHepH+LkDcLgibZ6j84c8II2slc8nvgu2X+9ExFTB9z9BqtNV2iGnVu43KFf11konKxKIw78RhDFLx5UpoGfD6GrhkLxdyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OR0COpuF+qTASD6GnR+/Yo88IjiaVg/kS+V7K7dWW7g1NcWNwto9I23CvQsWOqpvaDoOy/qLORtmXEc2kb2QJGfIZkYKVJnNk2nE+PWyr3XEbDDrwXhYXsz2BAJuTVt95JIJlY1JsSVgLH2YB+tQJK6hdDaeaWzfjGRaDR4FjuE=
Received: by 10.100.249.9 with SMTP id w9mr1713549anh.63.1208915969876;
        Tue, 22 Apr 2008 18:59:29 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Tue, 22 Apr 2008 18:59:29 -0700 (PDT)
In-Reply-To: <200804222007.03439.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80182>

On Wed, Apr 23, 2008 at 2:07 AM, Josef Weidendorfer
<Josef.Weidendorfer@gmx.de> wrote:
> On Tuesday 22 April 2008, Ping Yin wrote:
>
> > >  A reason you did not mention is security:
>  > >  You never want your .git/config to be changed behind your back, which
>  > >  effectivly is the case when using the versioned .gitmodules information
>  > >  (similar problem as with a .gitconfig in-tree).
>  >
>  > As discussed in another thread about in-tree .gitconfig, security
>  > issues only arise on limited configuration entries. However, there are
>  > no entries in .gitmodules falling into any of these entries.
>
>  Hmm... At least, it can be very annoying when git fetches data from repositories
>  you did not expect, only because submodule URLs change via this
>  fallback mechanism. Perhaps it is a little far reached, but suppose a project
>  changes its URL, and the old one becomes occupied by a malicious person.
>  The problem is that the URL with the now malicious repository is bound in the
>  history of the project.

It is always bound now without the fallback patch :)

>  For sure, you do not want to fetch from that old repository
>  by accident, after you did a checkout of an old commit. And there would be no
>  way to protect other people from this malicious repository other than rewriting
>  the whole history.

I wonder how the *malicious* repository can hurt us since only the
commit recorded in commit of the super project will be checked out.

>
>
>  > >  Another one:
>  > >  From a design point of view, submodule URLs are project meta information
>  > >  unrelated to source history. So, actually, I think it was wrong to put
>  > >  submodule URLs (even hints only) into the versioned .gitmodules files (*).
>  >
>  > But now it actually acts as hints and we don't find a better way. I
>  > just propose that the hints become the good default.
>
>  For me this sounds like: Now that we have made this bad decision, it does
>  not matter to make it even worse.

I should be like: Now that we have made a bad decision (if it is), we
have to improve it to make life better before we can find a better
solution.

>
>  What was the motivation for this fallback mechanism?
>
>  In any way, it is preferable to always use the correct URL for submodules.
>  Thus, when the URL ever changes in the projects livetime (covered by
>  git history), you want to have the correct URL in your .git/config
>  (not to accidently use the wrong URL when checking out an old commit).
>  But then, the fallback mechanism does not trigger anyway.

I havn't found yet how an incorrect URL can hurt us. The worst case i
can imagine is the failure of "git submodule update".

Two of the most common cases which can result in an incorrect/stale url is

 * the repository has been moved to another machine
 * the directory structure of upstream repositories has changed

However, there are also cases that the old version of url in
.gitmodules is correct.

Think about the case that the reposotory maintainer has decided to
replace current submodule with a totoally different one. In this case,
when back to the old HEAD, the url in .gitmodules is correct while url
in $GIT_DIR/config is incorrect.

So, when error happens, we can't judge which url is correct. So just
let the user make the decision by refering the change history of
.gitmodules or asking the repository maintainer.


-- 
Ping Yin
