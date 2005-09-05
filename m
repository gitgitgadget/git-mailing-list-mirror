From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 0/2] Update git-send-email-script with --compose
Date: Tue, 6 Sep 2005 08:06:50 +1200
Message-ID: <46a038f90509051306212d4e93@mail.gmail.com>
References: <11258971871874-git-send-email-ryan@michonline.com>
	 <46a038f905090504166246dc0a@mail.gmail.com>
	 <20050905153705.GD5335@mythryan2.michonline.com>
	 <7vll2b4ake.fsf@assigned-by-dhcp.cox.net>
Reply-To: martin.langhoff@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 05 22:07:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECNF0-0006ub-5q
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 22:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVIEUGv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 16:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbVIEUGv
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 16:06:51 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:13111 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932377AbVIEUGu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 16:06:50 -0400
Received: by rproxy.gmail.com with SMTP id i8so713045rne
        for <git@vger.kernel.org>; Mon, 05 Sep 2005 13:06:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CwSfHR828fzuHkKwbkZuivw7diaQJlI6EuxlDDh1yv9H7/j2aN8ok+eTOHdz2LIakuKVy+p40TZBPH0gnxxkWtS/IFWhO+o/mQrRRQijIgdHgfm7fnASmSVT/TY8QxCQ94lFESYX4QiVL/oYfxqhkmDYisRcLshrmndS/m2gXeQ=
Received: by 10.38.97.56 with SMTP id u56mr319465rnb;
        Mon, 05 Sep 2005 13:06:50 -0700 (PDT)
Received: by 10.38.101.8 with HTTP; Mon, 5 Sep 2005 13:06:50 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll2b4ake.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8114>

On 9/6/05, Junio C Hamano <junkio@cox.net> wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> > Sorry about that - I always export using git-format-patch using --mbox,
> > and those work nicely.  I'm a bit reluctant to do the [PATCH] fixup, but
> > I think I will:

Thanks Ryan for the clarification! I hadn't realized it would work
correctly with --mbox -- unfortunately it doesn't work very well in
the one-file-per-patch (legacy?) mode. Also, telling it _not_ to
prompt when it can guess it, is far better (a confirm y/n can still be
a good thing if you want to ensure the user gets a chance to review
the values guessed).

> Martin, --mbox has the added benefit that it consistently
> preserves the From: and Date: information even for your own
> patches, because it implies --date and --author.  By default
> without --author and --date these are not preserved from the
> original commits for your own patches, primarily because
> format-patch without --mbox was written for reorganizing and
> reordering existing patches (i.e. export, concatenate some, edit
> some hunks, and eventually feed it to applymbox to make commits;
> you do not typically want to keep the original author date for
> this kind of use).

Fair enough -- blame it on my primitive approach of only having 2
working repositories, and having some patches in them that I'm not
pushing upstream. Exporting to mbox would mean that I have to edit the
mbox file to remove the patches I don't intend to publish.

... and on my naive reading of git-send-email documentation -- it
doesn't mention mbox format at all, so I assumed it would expect one
patch per file.

> Martin, is there a reason you do not want --mbox format
> (e.g. format-patch --mbox spits out Subject: line undesirably
> formatted while it does what you want without --mbox)?

Hmmm -- that I am too lazy to keep several heads or several repos, and
organize them to have a "tojunio" branch? So far I've been working on
one or two files (archimport) and customizing a couple of others with
strictly local changes (git-send-email for instance), so it didn't
make sense to formally segregate the heads. A simple review and manual
"cherrypicking" of the patches I wanted to send was enough.

cheers,


martin
