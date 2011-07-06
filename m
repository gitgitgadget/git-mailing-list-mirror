From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 11/14] revert: Introduce a layer of indirection over
 pick_commits
Date: Wed, 6 Jul 2011 06:53:23 -0500
Message-ID: <20110706115323.GP15682@elie>
References: <1309938868-2028-1-git-send-email-artagnon@gmail.com>
 <1309938868-2028-12-git-send-email-artagnon@gmail.com>
 <20110706103734.GL15682@elie>
 <CALkWK0=0vBUG_UOLWt+SFMctfW1__OOG-=BAY4WwMGM5OfDj4A@mail.gmail.com>
 <20110706113928.GO15682@elie>
 <CALkWK0mXQszjM57E==YCisUng8buyMmP6EGkcrncJOkNJhK35Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 06 13:53:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeQfl-0004Zf-FU
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 13:53:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752900Ab1GFLx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 07:53:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41532 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752591Ab1GFLx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 07:53:27 -0400
Received: by iyb12 with SMTP id 12so6014973iyb.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FyUO9OKEbIGlbMvsmr8pt9MzgJSu96LCUQaRzOm6KSc=;
        b=q95tJZ2nW1Un5Osmql08/ZVKMjcY3qhDwrw/yt67LX0iqV/UPl85oPZmjpG7gPKEk4
         YEppfU5h3f+kW4Xw/peq798QbzDmOEYMB7YokuQrW93YUHYcfAehKQVpJtXfANnO8Fzt
         y3IrvjKUpFAV7+f00UEnuYj4rQq8wEA3B8sd8=
Received: by 10.43.59.80 with SMTP id wn16mr9414373icb.67.1309953207308;
        Wed, 06 Jul 2011 04:53:27 -0700 (PDT)
Received: from elie (adsl-69-209-76-243.dsl.chcgil.ameritech.net [69.209.76.243])
        by mx.google.com with ESMTPS id hp8sm8716573icc.23.2011.07.06.04.53.25
        (version=SSLv3 cipher=OTHER);
        Wed, 06 Jul 2011 04:53:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0mXQszjM57E==YCisUng8buyMmP6EGkcrncJOkNJhK35Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176697>

Ramkumar Ramachandra wrote:

> Thanks for the elaborate explanation; I can see what's wrong with it
> now.  However, I "start_or_continue_or_stop_or_[insert more options
> here]_replay" isn't a good name.  I want something future-proof,
> because I intend to extend this with more nifty helpers like "skip
> one".  Your earlier "pick_revisions" suggestion doesn't sound like a
> bad alternative now -- let me know if you have any other suggestions.

Sounds like sensible reasoning.  You are free to choose a name; I just
wanted to make sure the effect of that name is clear.

If I were doing it, I would let the API include multiple entry points,
one for each operation ("start", "abort", "skip one", etc).

Side note: I believe a previous patch had a justification of allowing
for multiple entry points, which I had thought was preparation for
this.  It is possible that that patch some other intended positive
effects, too, though.
