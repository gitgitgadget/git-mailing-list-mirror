From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 1/8] test-lib: allow negation of prerequisites
Date: Wed, 14 Nov 2012 23:46:58 -0800
Message-ID: <20121115074658.GA8429@elie.Belkin>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003325.GA17819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 08:47:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYuAU-00014T-MR
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 08:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278Ab2KOHrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 02:47:08 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59593 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab2KOHrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 02:47:07 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so898834pad.19
        for <git@vger.kernel.org>; Wed, 14 Nov 2012 23:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=d8R/v/YjCFPoMG07qgGuDS3U4KcgN5Zg2JT4RSFLBe8=;
        b=HsikVkYsrdFfnZ9/xXgMPoKvxtatBJBEDtoOtCjdEmZFP3FZd7LIXXAgtlfHMWeFvZ
         hFckbjExKhHvib2zzhNNFTyQpKG1icx3wJaQHnyQue2ACGLF41Me1rMJk4US1n3bSTrx
         iHmy3JkUMCvt/xCUigMAdE2Fg8PZA2Y6iEAdL9P6wZI9W6PjgkkExZs6bLqrkfG3GLHs
         keGI+HVOxwen81ANUWBCPa8YXAzkpZX4crApE0kR6vOGax9lKDmQ11DtlvK7sGlWe1m8
         G+fWWSoHL1FXTkBJB4+29UbIgcYi+XN6M6R22YN+LovkM9vy8yqhs3aOEjynz3g0wZbN
         PTCg==
Received: by 10.66.87.165 with SMTP id az5mr853755pab.46.1352965626548;
        Wed, 14 Nov 2012 23:47:06 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id j10sm9324044pax.8.2012.11.14.23.47.05
        (version=SSLv3 cipher=OTHER);
        Wed, 14 Nov 2012 23:47:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121115003325.GA17819@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209801>

Jeff King wrote:

> +test_expect_success !LAZY_TRUE 'missing lazy prereqs skip tests' '

I have a visceral nervousness when reading this code, from too much
unpleasant experience of bash's csh-style !history expansion.  Luckily
bash does not treat ! specially in the '-o sh' mode used by tests.

Does this feature work when running a test explicitly using
"bash <name of test>"?  That's something I do from time to time to
figure out whether a weird behavior is shell-specific.

If it works everywhere, this patch would help me conquer my fear of
exclamation points in git's tests, which would be a comfort to me and
a very good thing.
