From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] Sequencer: Dealing with historical mistakes
Date: Fri, 19 Aug 2011 00:45:28 +0530
Message-ID: <CALkWK0mzhWqsc15ufWPB5_aJmPVmrfmxOFyU33i9XbWvFK0N=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 18 21:16:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu84S-0008Qc-AN
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 21:16:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161Ab1HRTPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 15:15:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60919 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044Ab1HRTPv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 15:15:51 -0400
Received: by wwf5 with SMTP id 5so2411078wwf.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2011 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=B4FXNYp24gSsPHCK5pOwyn38WuHRdzuODSujDOPU9oo=;
        b=xtloQ2ldojvz4/SfxhEO+EmI8LhgQ8Jcw861/BumXisYynm7CYVo5ozPZcRqXyQy1x
         NIZK6XXoZq+xAzq3N0z8oox8EOQEL+7YlcTh8ZrnYjKylX0DiDnqTwTILBFUNdzbB7Iy
         BXcTKkzlz/XxNbPjxWogpsoXOp0sMjKxfXcqc=
Received: by 10.227.120.199 with SMTP id e7mr2295226wbr.63.1313694948293; Thu,
 18 Aug 2011 12:15:48 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Thu, 18 Aug 2011 12:15:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179613>

Hi,

Junio suddenly raised some very disturbing concerns about the overall
UI consistency wrt '--continue'.  I'm really glad he raised it before
we locked ourselves into yet another UI mistake.  Work on the
generalized sequencer series has totally halted since, and I've been
pondering about what to do.  After some thought, I've tried to
untangle the various issues and add something useful to the discussion
[1].  I'm somewhat annoyed that we're stuck with these historical
mistakes, and I hope that our future design isn't constrained too
badly.

Otherwise, I've requested Junio to merge 'rr/cherry-pick-continue'
as-it-is, since it doesn't have any major issues.  The generalized
sequencer series itself will take some more time- we have to decide
the final implementation details at the end of the discussion.  Also,
the GSoC is drawing to a close, and I plan to post a somewhat
elaborate final update.  If there's something in particular you'd like
to see in it, do let me know.

Thanks for reading.

[1]: http://mid.gmane.org/CALkWK0noHBnW-7zZLw=jJdDVFxXmsm2vHHYnUJc9miLLuDRnAg@mail.gmail.com

-- Ram
