From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cleaning up log messages
Date: Sun, 27 Jul 2008 16:52:07 -0400
Message-ID: <9e4733910807271352h67044045y7576a719d4cc80cd@mail.gmail.com>
References: <9e4733910807271050y7fb5f77coec05bd68421baaab@mail.gmail.com>
	 <7vsktv17wc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 27 22:53:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNDEs-0005YE-RL
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 22:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034AbYG0UwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 16:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757804AbYG0UwJ
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 16:52:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:38261 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbYG0UwI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 16:52:08 -0400
Received: by wr-out-0506.google.com with SMTP id 69so3435188wri.5
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 13:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=TtnvRvoRkPb0a7IMNo/l+lX49Z2ARfJPnee6oHyGcis=;
        b=Akk40rfMJa//x8bBFRZiGH/0WJH9TpclD21U6AienkYcK3Q+u7ynT73cJ5xrBBkb7q
         d31K1f/Ed4Zvj6JML7oJa0CXfw1hYW0KotzSfN6o/zRIgFsv5uk7+TnGSqCEWJp85krZ
         0RvQ5qXr/ObgrN5ptrSwBrQ0m1TqlhzQy3Zcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=jFyIqsrns+5sX6e1PYmld0Smx6C12KHRrUE/0U4WDmQSIBGBs/wfK3eL4qwG1l1Zvp
         dq29F7gjg7sERKAahhqSucd0yJ/oQ2SWLZvBtkjSJgq/dNJQQwITR4SSBshsSNYBw/1N
         B4W9adh8hT/Du3X3be2RP5VDK/tHM74sqAlus=
Received: by 10.90.71.16 with SMTP id t16mr1330719aga.47.1217191927378;
        Sun, 27 Jul 2008 13:52:07 -0700 (PDT)
Received: by 10.150.205.1 with HTTP; Sun, 27 Jul 2008 13:52:07 -0700 (PDT)
In-Reply-To: <7vsktv17wc.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90370>

On 7/27/08, Junio C Hamano <gitster@pobox.com> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
>  > I was playing around with git log for the kernel and observed that
>  > there is a lot of noise when trying to do statistics on the number of
>  > commits.
>  >
>  > For example:
>  >
>  > Author: Greg K-H <gregkh@suse.de>
>  > Author: Greg KH <gregkh@suse.de>
>  > ...
>
> > Author: Greg Kroah-Hartman <greg@kroah.com>
>
>
> We have had .mailmap since a24e658 (git-shortlog: make the mailmap
>  configurable., 2005-10-06); maybe the kernel tree wants a maintainer for
>  the .mailmap file?

This seems to be the main problem. There are so many missing entries
from the .mailmap file that I didn't think this feature was
implemented. I'd guestimate that 300-400 needed entries are missing.

I've made a few attempts at writing a script to fix the easy ones but
I don't have a good solution yet.

-- 
Jon Smirl
jonsmirl@gmail.com
