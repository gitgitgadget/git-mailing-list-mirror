From: Nathan Collins <nathan.collins@gmail.com>
Subject: Re: defaulting git stash to "--keep-index"
Date: Tue, 19 Nov 2013 18:08:33 -0800
Message-ID: <CAO8RVvdMD+xWrkwk+9Nbm7oyTTkc50PURxJe67ygkkTN-L41zw@mail.gmail.com>
References: <20131119195009.6d4e183b@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Tim Chase <git@tim.thechases.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 03:09:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VixEN-0008KE-OR
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 03:09:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753280Ab3KTCJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 21:09:15 -0500
Received: from mail-ve0-f181.google.com ([209.85.128.181]:48530 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab3KTCJO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 21:09:14 -0500
Received: by mail-ve0-f181.google.com with SMTP id oy12so2686481veb.40
        for <git@vger.kernel.org>; Tue, 19 Nov 2013 18:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kGHVeyGrXvvws83iPd2BPTxBSZOUaFxpxbulW3mTHsQ=;
        b=TXurfUtsI61W9SneLuJ3j4brTBk9jts8sewcsqZQfGtpxbpKNtRptjwjiqMPISyDg8
         nxuHx52NxXf3hixI7uR4A+unIl5k9Fi7cJVIDNdixSz5dMMLqy55ZjGHrhXEYobOe50m
         1cWsbqzosdQF8suPXb/WYXjX8l3vQa4dvaTxa6t05Es+RZxnmrW+DKC7T6hnUCOPu5a1
         b4c2lVbdj+n33ByvqYfqCzIXgp+w7O7LLC+NSFeFGTKJoQC46kY20noQJqMsXswJ2sJj
         I/F8TsGnU47XmxxNg/vuhOVFWQ3wyflEygA1MWQcrdRW+6vgvcEO99Kz7/3qdcfgnra4
         A8JA==
X-Received: by 10.58.39.97 with SMTP id o1mr24086768vek.15.1384913353717; Tue,
 19 Nov 2013 18:09:13 -0800 (PST)
Received: by 10.220.7.202 with HTTP; Tue, 19 Nov 2013 18:08:33 -0800 (PST)
In-Reply-To: <20131119195009.6d4e183b@bigbox.christie.dr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238064>

On Tue, Nov 19, 2013 at 5:50 PM, Tim Chase <git@tim.thechases.com> wrote:
> Having lost "add -p" work enough times when stashing, I finally
> dug into the docs to see how to prevent it, discovering that
> "--keep-index" does exactly what I want.

Note that 'git stash (pop | apply) --index' will reinstate the index
as it was at stash time, regardless of whether '--keep-index' was used
to create the stash.  In other words, your index is not "lost" when
you stash.

Also note: when you 'git stash --keep-index', although your index
remains intact, the changes in the your index still become part of the
stash.  Hence, any changes to the indexed portion of your files after
a stash usually result in a conflict on subsequent 'git stash pop'.
This confuses me quite a lot, since I'd expect a main use case of 'git
stash --keep-index' to be fixing a up a commit, but then any fixes
cause a conflict :P

Cheers,

-nathan
