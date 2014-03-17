From: Quint Guvernator <quintus.public@gmail.com>
Subject: Re: [PATCH v3 1/1] general style: replaces memcmp() with starts_with()
Date: Mon, 17 Mar 2014 16:36:59 -0400
Message-ID: <CALs4jVFFf2cBU920jRcyh1v9KAxkSS+LnycfYo4quuqjNRsp2g@mail.gmail.com>
References: <1394901553-69548-1-git-send-email-quintus.public@gmail.com>
 <1394901553-69548-2-git-send-email-quintus.public@gmail.com> <532722ED.1010500@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 17 21:37:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPeHo-0004AD-Dq
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 21:37:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbaCQUhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 16:37:23 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33264 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbaCQUhW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 16:37:22 -0400
Received: by mail-wg0-f41.google.com with SMTP id n12so5174095wgh.12
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 13:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XNZHXHfCBlyJcozrdxP7CiL1N+sab7EzwAuBt6XCE1Y=;
        b=WDIK2kd6RJYceIXSaTZDpTzSwiWCRWYT+2J/2EZd/O3CecbYiyFdYA0Jf1FOO9lxod
         TIdwtKXPQow68SrTZYrjnfAFCu4JArpW45aCHS+SSYgbe2bdYMfqDL/4dEdCN0i83OV+
         pDz15wnJoxfox71QacNjPE166QWar0LLhtmptSXN5OOf8WA0t1vC1yfVGfN+B9aqhUSm
         +bO9oR24UNXxFUZncgZq0gYdxuvg6ogFS8g2himJmUr/pTWR2zuvjZRIscFVvPa2yYsN
         CpL4wEi9S3wYeXrZwXE26cVg2oi0SDYWOg/lHOhV/Rh4lnvmbAvBxzv82RbhlI5xRNeo
         soCQ==
X-Received: by 10.194.92.38 with SMTP id cj6mr3176338wjb.70.1395088640837;
 Mon, 17 Mar 2014 13:37:20 -0700 (PDT)
Received: by 10.216.231.138 with HTTP; Mon, 17 Mar 2014 13:36:59 -0700 (PDT)
In-Reply-To: <532722ED.1010500@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244280>

2014-03-17 12:29 GMT-04:00 Michael Haggerty <mhagger@alum.mit.edu>:
> This hunk uses the magic number "11" a couple lines later.  Junio (I
> think rightly) objected [1] to rewrites in these circumstances because
> they make it even less obvious where the constant came from and thereby
> make the complete elimination of the hard-coded constant *more* difficult.
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/244005

Sure, I can understand that. I'll look through the hunks again with
more context in the diff to try to look for more cases where magic
numbers are used more than once. One of the goals of this revision is
to minimize that, see the commit message.

> In any open-source project it is important to optimize for the time of
> the reviewer, because code-review is a relatively tedious task and is
> therefore often the bottleneck for progress.  Therefore I suggest that
> you turn your approach on its head.  Don't "remove the most
> objectionable hunks" but rather *include only the best hunks*--the ones
> that you can stand behind 100%, which you think are an unambiguous
> improvement, and that the reviewer can accept without reservations.
...
> It would be much better for you to submit only a handful of changes (or
> even only one!) that is perfect, rather than throwing a bunch at the
> wall and asking the reviewer to pick between the good and the bad.  As
> you gain experience and learn about the preferences of the Git project,
> you will get a better feel for the boundary between
> acceptable/unacceptable patches, and *then* you will be able to start
> submitting patches closer to the boundary.

I see. For v4, I will be more discerning as to what I include. I will
try to keep the scope of future patches down and err on the side of
caution when I review my own changes before submitting. Thank you for
the *pointers.

I'm going to give v4 a shot. It should be on the mailing list in an hour or so.

Quint
