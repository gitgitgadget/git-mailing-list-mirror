From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/3] Re: cherry-pick/revert error messages
Date: Sun, 20 Nov 2011 03:46:50 -0600
Message-ID: <20111120094650.GB2278@elie.hsd1.il.comcast.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net>
 <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 20 10:47:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RS3zu-0005mB-DB
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 10:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab1KTJrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 04:47:04 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38829 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab1KTJrC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 04:47:02 -0500
Received: by iage36 with SMTP id e36so5853295iag.19
        for <git@vger.kernel.org>; Sun, 20 Nov 2011 01:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DzV3k0uD+Z2nORfStF8JdXaeuA/PCKOKvoHDswwWAqs=;
        b=fIZQRqhWvLYEWMnwmkfw29dCwR8liTWTMYUqv6Is8Z9+sYsJBLlKaImlmSGdTIISRp
         q0zL0Hmnmb6Ct17rsdzLFgZsr5xc7AfoySW8D2z5h8x3EpjccD0BeDidAIzU99+OFnJN
         /gbswGL2oavNgLfUFdviPbQuXdYkyfhB8iyNo=
Received: by 10.50.189.231 with SMTP id gl7mr10620056igc.44.1321782421892;
        Sun, 20 Nov 2011 01:47:01 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id p16sm29643412ibk.6.2011.11.20.01.47.00
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Nov 2011 01:47:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185720>

Ramkumar Ramachandra wrote:

> Looks much better!  Yes, a series pretty'fying error messages would be
> really nice.

Good to hear.  Here's a rough one.

I realize patch 1/3 might not be conservative enough, even though
there hasn't been much time for people to get used to --reset yet.  So
I might be sending a second version that treats --reset as a synonym.
But please forget I said that when judging this version (i.e., if it
looks like a problem, I do want to know).

Thoughts?

Jonathan Nieder (3):
  revert: rename --reset option to --quit
  revert: restructure pick_revisions() for clarity
  revert: improve error message for cherry-pick during cherry-pick

 Documentation/git-cherry-pick.txt |    2 +-
 Documentation/git-revert.txt      |    2 +-
 Documentation/sequencer.txt       |   10 +++---
 builtin/revert.c                  |   71 ++++++++++++++++++-------------------
 sequencer.h                       |    2 +-
 t/t3510-cherry-pick-sequence.sh   |   10 +++---
 t/t7106-reset-sequence.sh         |    2 +-
 7 files changed, 49 insertions(+), 50 deletions(-)
