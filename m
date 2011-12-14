From: Jonathan Nieder <jrnieder@gmail.com>
Subject: tr/pty-all (Re: What's cooking in git.git (Dec 2011, #04; Tue, 13))
Date: Wed, 14 Dec 2011 01:09:16 -0600
Message-ID: <20111214070916.GA14954@elie.hsd1.il.comcast.net>
References: <7vobvcrlve.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 14 08:09:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raiy2-0001jg-5P
	for gcvg-git-2@lo.gmane.org; Wed, 14 Dec 2011 08:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab1LNHJZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Dec 2011 02:09:25 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62779 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab1LNHJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Dec 2011 02:09:25 -0500
Received: by yenm11 with SMTP id m11so391948yen.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 23:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9Bfy2CkCjjT9WV2Z06ta7ZvGhYDzscopNK4tW0FmTqA=;
        b=YorZVrnBfaGpTs2XhDDJYtY4rQbTisLn3mY6Qn3mk6wqMFM4LaX8bLWmZFS6z3yzRb
         Dq0Fbd02YyAS97yg6oDcsjeGi37NDn4AaybmWrw0Ly0vNAPm2GwfxaBEBgvHOJNuGiwz
         KGf1p+7VNFluieg93ie4hUcShMymeumNlpl4k=
Received: by 10.236.176.2 with SMTP id a2mr9461212yhm.12.1323846564469;
        Tue, 13 Dec 2011 23:09:24 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f17sm4862005ang.20.2011.12.13.23.09.22
        (version=SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 23:09:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vobvcrlve.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187096>

Junio C Hamano wrote:

> * tr/pty-all (2011-12-12) 3 commits
>  - t/lib-terminal: test test-terminal's sanity
>  - test-terminal: set output terminals to raw mode
>  - test-terminal: give the child an empty stdin TTY
>
> Will merge to 'next' after taking another look.

The middle commit looks good.  The bottom commit could be improved as
discussed at [1], but I guess that can happen in-tree.

However, the top commit ("test test-terminal's sanity") still does not
seem right to me.

It makes the same test run three times.  Probably I should send an
alternate patch to get that sanity-check to run once, but I am also
not convinced the sanity-check is needed at all --- wouldn't any test
that is relying on output from test_terminal act as a sanity check for
it already?

As an aside, I also still believe that running "git shortlog" without
explicitly passing "HEAD" when testing how it reacts to [core] pager
configuration was a bug and a distraction, hence the patch at [2].  Am
I the only one?  I also find Jeff's patch [3] appealing.

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/186923/focus=186944
[2] http://article.gmane.org/gmane.comp.version-control.git/186932
[3] http://article.gmane.org/gmane.comp.version-control.git/186936
