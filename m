From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 7 Jun 2016 17:20:24 -0400
Message-ID: <20160607212023.GE24676@LykOS.localdomain>
References: <20160607195608.16643-1-santiago@nyu.edu>
 <xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 23:20:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAOQa-0003Eh-Vy
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 23:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161339AbcFGVUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 17:20:40 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34650 "EHLO
	mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933118AbcFGVU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 17:20:26 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Jun 2016 17:20:26 EDT
Received: by mail-qt0-f174.google.com with SMTP id q45so25301173qtq.1
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wATIya8lzayGeG7UhFlPWMbDFOuL37fI12V/hOTOQ18=;
        b=0wsBaV/Lnhxv5umA1E9gS+zmxoYLoj7ekK7wrjlSpqfUIaeqVUk6m0jrEGnv2fukl6
         8PEbdExsZo/48fk0DusZPKaRhoNp1h7FYoPD7OLovGBXqYE/Kb2alsgcCks9hie/Ppob
         ULwD3kDY9NUI3niXh/R6loRR5z01a9j6A4f4Ms8NxebCib97bSfOi2usZmDGjILiO6KI
         xBj3T+yU/okbvTmLOVrwUGtbVJhzTANEKlUq6GIsnlDic6w3Z6g523qzXz0A7SeJRvUm
         SC1sCz/g0s3raUitMfgXp2x7nDDrqfU28LyVV8ajQYXi1SqPMHds8PsnZXizcQ0IYqJn
         2boQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wATIya8lzayGeG7UhFlPWMbDFOuL37fI12V/hOTOQ18=;
        b=Vc2xdGolwErY1G4fTMMNPPxEAMB8FwtRqZ4tXV5QsdllnntGdLFUfiFg3pHXi0pOu6
         cDp6QXVQeTxDoV0xBAvGxOR/WyeuWBwB18QbcOtclVwkIXoxzPKjScZkbqzfzJ4pno10
         /JjMGBk+9Un1VDqW68omKX7UFXme0IOYWTkL+Hvn3qZuAJTQCH0aqDUNwxs7hb9stOHJ
         gLjT+fbGxE5tPVVcoXLagEZ+ZXmqBmRQwqungVknR3wqW5bFSDH1vQAspkJ2eqXyXg8T
         oiAPmLB7zFVC9zfJ7Uwlr0fHHQM5Lq6gWm54jFF+wj7ixalrDWjWiicFSGypXqXHhgFV
         fIkg==
X-Gm-Message-State: ALyK8tLk9H4r8/N3pELpuMNmLn3oEK4DM1Mt26dTcEHfc3V9nzt3a4nfIIHYq+qu7SdfFfLr
X-Received: by 10.200.42.22 with SMTP id k22mr1691487qtk.24.1465334425404;
        Tue, 07 Jun 2016 14:20:25 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-EXP01.NATPOOL.NYU.EDU. [216.165.95.69])
        by smtp.gmail.com with ESMTPSA id r62sm7647414qtd.8.2016.06.07.14.20.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2016 14:20:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296727>

On Tue, Jun 07, 2016 at 02:05:20PM -0700, Junio C Hamano wrote:
> santiago@nyu.edu writes:
> 
> > 1.- Using a tag ref as a check-out mechanism is pretty common by package
> >     managers and other tools. Verifying the tag signature provides
> >     authentication guarantees, but there is no feedback that the
> >     signature being verified belongs to the intended tag.
> 
> Very true.
> 
> The above means that the existing package managers and other tools
> need to be updated with some new code that lets them learn how to
> tell if the tagname (in their refs/tags/ namespace) matches the
> intended "real" tag name, and your --check-name option could be
> that.
> 
> But if you are adding new code to the existing package managers and
> other tools _anyway_, wouldn't it be a more direct solution to let
> them learn how to tell what the intended "real" tag name is with
> that new code?

Yeah, you're right, I didn't consider that. I'm thinking that this kind
of verification could simplify the lives of upstream maintainers if we
do the verification in-house though (i.e., by having them just add the
flag).

> 
> which may be cumbersome.  Perhaps, just like "git tag -v v1.4.11" is
> a way to see if the contents of the tag is signed properly, if you
> add "git tag --show-tagname v1.4.11" that does the above pipeline,
> these package managers and other tools can be updated to
> ...
> make dest=/usr/local/$package/$tag install
> 
> i.e. ignore the refname entirely and use the "real" tagname it reads
> after validating the signature as the name of the resulting version
> getting installed, distributed and/or used.

This is also an alternative, that might be cleaner. I'm wondering if
this is easier to implement than having the --check-name flag.
Intuitively, it seems like that's the case. Would you suggest taking
this path instead?

Thanks!
-Santiago.
