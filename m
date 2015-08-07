From: Junio C Hamano <gitster@pobox.com>
Subject: Re: wishlist: make it possible to amend commit messages after push to remote
Date: Fri, 07 Aug 2015 09:59:05 -0700
Message-ID: <xmqqd1yzyqzq.fsf@gitster.dls.corp.google.com>
References: <55C3FA66.90805@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jarkko Hietaniemi <jhi@iki.fi>
X-From: git-owner@vger.kernel.org Fri Aug 07 18:59:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNkzE-0008V0-SL
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 18:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945997AbbHGQ7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 12:59:09 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33562 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945898AbbHGQ7G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 12:59:06 -0400
Received: by pabyb7 with SMTP id yb7so59527068pab.0
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ug6vT71s9XnUGdZrM3BUm4YLsgVFAMcND6533oCzIAQ=;
        b=GspX3uejT/evR6/Zyhfa7PzQ5pKVo4aspbiZveofc/anPvp1WCTVzqzptrfZBtiAEr
         UVQq7XFWd7bUIlnYC3jW/MeUFN+DrRr9k2g84du6WCEtnWqjjwnrsQ/OgS6seABQzQw+
         P9uMKJ54/7JLz3dRA3Y2wCCadhEyTyyxtXlTJFzwQhvp35WPKf+vATWgTAA5YyBGVpdP
         FGhyOFIUt4M72juDg/bDGA5QoC6AWolr8rXe3JDGHIFlK4rv03C/Zm1fx6uG0rKU58h5
         2Z2qdRnEin7E843nZ82+z3igqoWl8sxRE5YqKLor5wsTQ97aOvVwGIYioOOkdjauTk//
         gqYw==
X-Received: by 10.68.162.66 with SMTP id xy2mr16841761pbb.13.1438966746494;
        Fri, 07 Aug 2015 09:59:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id ob4sm10678693pbb.40.2015.08.07.09.59.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 09:59:05 -0700 (PDT)
In-Reply-To: <55C3FA66.90805@iki.fi> (Jarkko Hietaniemi's message of "Thu, 06
	Aug 2015 20:23:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275472>

Jarkko Hietaniemi <jhi@iki.fi> writes:

> Not for the first time, and probably not for the last, I pushed a commit
> upstream without adding a link for the bug report as I was meaning to.
>
> Or it could have been...
>
> - Simple typos.
>
> - Broken URLs.
>
> - The following morning / 5 minutes / 5 second later thinking of
> an additional factoid that would've been great to have in the
> commit message.

Unfortunately (or fortunately, depending on your point of view),
these can only be avoided by being careful before you push things
out.  You need to learn to consider the act of publishing as casting
your work in stone to give other people solid foundation to build
on.

> - The impossibility of two consecutive commits referring to each other
> because the older one cannot know what the newer one will be called.

This is fundamental.  You shouldn't be able to "predict"; otherwise
the cryptographic protection of the history would not work.

> In general, I find the fact that once a commit has left the building,
> it goes into your permanent record, and cannot be changed, ever, to be
> very, very annoying. I get the cryptographic "sealing" with all the
> preceding changes, but...

If you really "get" it, you wouldn't be complaining about the
"impossibility" part ;-)

> Not that I've thought this through... but couldn't there be a bunch of
> "aliases" (new SHAs) for a commit?

You could filter-branch, after warning others that you will be
rewinding and rebuilding your history and disrupting their work
(and object replacement with "git replace" and the graft would
be good ways to help you during the filter-branch process, but these
shouldn't be used as a long-term mechanism---it will slow you and
more importantly others down unnecessarily and forever).
