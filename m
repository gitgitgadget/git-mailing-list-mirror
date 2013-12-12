From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 14:48:44 -0500
Message-ID: <CACPiFCLXeK9DH=f80ReSmYHJ7zjOn-D2zvs3WmdiV-k=wBGgjA@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <20131212171756.GA6954@inner.h.apk.li> <20131212182932.GB16960@thyrsus.com>
 <CACPiFCJ22xiedXAoQktMLd=gASgD0NS24Pya9TvCo9aQP5JaBQ@mail.gmail.com> <20131212193918.GA17529@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 20:49:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrCG2-0001vG-Tz
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 20:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800Ab3LLTtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 14:49:11 -0500
Received: from mail-vc0-f171.google.com ([209.85.220.171]:62888 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608Ab3LLTtI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 14:49:08 -0500
Received: by mail-vc0-f171.google.com with SMTP id ik5so648966vcb.16
        for <git@vger.kernel.org>; Thu, 12 Dec 2013 11:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Oe+xjFxGYHrIhNW6FAzX7Lqo+Kt9r0/yLc93adu/0VQ=;
        b=fYTw2wrY+38sbQi3+y8tdYxN2+z0m7F+bUvNRt18XDpsAr54u5JAp3QaQHy9r+K++3
         /RKVDu2KHzpA+qQdyvYtJHLCeMNszSVXo8tXmaJXt2wCqPdR3JxKkXSWxVn1niroj+2B
         BSflk2VgmK239jIyrZ9Wgv+gT8KOaTNrQpeEXVfCg+sovIUvxPlJ0n4VCSiwEzUzqeS+
         utzXTm6I9gd6s7ImMsQvQXX9/DU3QCEAqjvYILOCqGr8p2cD7dtuuO0GebK1Cb/U+ylJ
         fwgINBCwIdNyZ4dXbs/d8m6D3lBKmXjFnZ+Jcg9Kab0wQj+BSkci3VkngXYEFv7LW/oT
         9Bpg==
X-Received: by 10.58.54.69 with SMTP id h5mr4610330vep.25.1386877747962; Thu,
 12 Dec 2013 11:49:07 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Thu, 12 Dec 2013 11:48:44 -0800 (PST)
In-Reply-To: <20131212193918.GA17529@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239242>

On Thu, Dec 12, 2013 at 2:39 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> Yikes!  That is a much stricter stability criterion than I thought you
> were specifying.

:-) -- cvsps's approach is: if you have a cache, you can remember the
lies you told earlier.

It is impossible to be stable purely from the source data in the face
of these issues.

CVS is truly a PoS.

> I think it would handle 1a in a stable way

that is pretty important. Files added on a branch not affecting HEAD
and earlier branch checkout matters.


> What I think this means is that cvs-fast-export is stable if you are
> using a server/client combination that generates commitids (that is,
> GNU CVS of any version newer than 1.12 of 2004, or CVS-NT). It is
> *not* necessary for stability that the entire history have them.
>
> Here's how the logic works out:
>
> 1. Commits grouped by commitid are stable - nothing in CVS ever rewrites
> those or assigns a duplicate.
>
> 2. No file change made with a commitid can destabilize a commit guess
> made without them, because the similarity checker never tries to put both
> kinds in a single changeset.
>
> Can you detect any flaw in this?

If someone creates a nonsensical tag or branch point, tagging files
from different commits, how do you handle it?

 - without commit ids, does it affect your guesses?

 - regardless of commit ids, do you synthesize an artificial commit?
How do you define parenthood for that artificial commit?

curious,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
