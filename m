From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v2] blame: avoid checking if a file exists on the working
 tree if a revision is provided
Date: Tue, 17 Nov 2015 17:37:45 -0600
Message-ID: <CAOc6etbjCYRp4gbSNRtcngwbh93R67JYZHJn0=D=FeiBm5=FNw@mail.gmail.com>
References: <1447723762-32309-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTjg8yvmLO0uuWZt4nATUnfxJOj4f_AmvRP9mHsGRmEOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Max Kirillov <max@max630.net>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Nov 18 00:37:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zypov-0002gJ-N6
	for gcvg-git-2@plane.gmane.org; Wed, 18 Nov 2015 00:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbbKQXhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 18:37:46 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35562 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbbKQXhq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 18:37:46 -0500
Received: by pacej9 with SMTP id ej9so23495602pac.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 15:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=12wvca4wuSfNZ7GOKfRTlAnUXoJsqjQVrGiwGWIMcyo=;
        b=rBz3n5yRg+XgDuvFOWUphnkJEhRMZWH7L463TPtuS/VskwAm+UZib+yz6dQaBPIKlb
         h4qCyY3DRWCfxicbm4jd8gSVNzouyUAmqn9LjevcWczHGVxQWsDpWenNaeptQZsJTaPC
         0Z8FRIaLuQ5JzGrkM6xXH18zp5vhVuv8uiliDt19vt7ANzOxeab3nXKmQU2x02ULqIlI
         aegyD4G5NT6YEWIeQmO2opvOUqrLJPNx8KlC7/HQB4shvw4BWnolJq35Lgj5FLWY0d51
         SU2InbirvApjL/QyZbxBR5G7ges9rxm59wk6ULPSRvT+xEnqCnlUeJPMEy7I8TBXE4/M
         tABA==
X-Received: by 10.68.165.131 with SMTP id yy3mr22708545pbb.163.1447803465348;
 Tue, 17 Nov 2015 15:37:45 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Tue, 17 Nov 2015 15:37:45 -0800 (PST)
In-Reply-To: <CAPig+cTjg8yvmLO0uuWZt4nATUnfxJOj4f_AmvRP9mHsGRmEOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281430>

On Mon, Nov 16, 2015 at 11:11 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> This subject is a bit long; try to keep it to about 72 characters or less.
>
> More importantly, though, it doesn't give us a high level overview of
> the purpose of the patch, which is that it is fixing blame to work on
> a file at a given revision even if the file no longer exists in the
> worktree.

Sure!

> git-blame documentation does not advertise "blame <file> <rev>" as a
> valid invocation. It does advertise "blame <rev> -- <file>", and this
> case already works correctly even when <file> does not exist in the
> worktree.
>
> git-annotate documentation, on the other hand, does advertise
> "annotate <file> <rev>", and it fails to work when <file> is absent
> from the worktree, so perhaps you want to sell this patch as fixing
> git-annotate instead?

So, do I forget about the blame patch (given that I'm not fixing an
advertised syntax, even if it's supported) and fix annotate instead or
do I fix both? And if I should swing for both, do I create a single
patch or a chain of two patches, one for each builtin?

> This example is certainly illustrative, but an even more common case
> may be trying to blame/annotate a file which existed in an older
> revision but doesn't exist anymore at HEAD, thus is absent from the
> worktree. Such a case could likely be described in a sentence or two
> without resorting to verbose examples (though, not a big deal if you
> keep the example).

K.

>
> A new test or two would be welcome, possibly in t/annotate-tests.sh if
> you consider this also fixing git-blame, or in t8001-annotate.sh if
> you're selling it only as a fix for git-annotate.

I guess I'll wait for feedback about my first question before I decide
what I will do about the tests.

Thank you very much for your comments, Eric.
