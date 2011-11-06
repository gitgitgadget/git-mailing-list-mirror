From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/5] sequencer: revert d3f4628e
Date: Sat, 5 Nov 2011 19:42:57 -0500
Message-ID: <20111106004257.GG27272@elie.hsd1.il.comcast.net>
References: <1320510586-3940-1-git-send-email-artagnon@gmail.com>
 <1320510586-3940-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 06 01:43:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMqpN-00047n-2c
	for gcvg-git-2@lo.gmane.org; Sun, 06 Nov 2011 01:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562Ab1KFAnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 20:43:08 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:32829 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab1KFAnH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 20:43:07 -0400
Received: by ywf7 with SMTP id 7so3906986ywf.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 17:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=W2YHI+LnkZYlPqtDhT3q01qumy/9tEXTXpAlFqMaJaY=;
        b=fkyY1fbGqaHZHcX+WLMTVTeIEkjrv87NQMcnJcAZ8imCB2pHKwyeB20x/VVUbP1dwd
         XWE8RzeskxU4+/IbSRLLDDRb5N3LkNjM0j8LWRR83X0V4mCOkWKNhXVpdEeOI3vEhWcI
         2lm2VGUL3WOaPZFFqmddRwlTjKwNdCPSWqbKQ=
Received: by 10.50.195.233 with SMTP id ih9mr28209161igc.21.1320540186248;
        Sat, 05 Nov 2011 17:43:06 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id hz1sm13950883igc.5.2011.11.05.17.43.05
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 17:43:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1320510586-3940-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184890>

Ramkumar Ramachandra wrote:

> Revert d3f4628e (revert: Remove sequencer state when no commits are
> pending, 2011-06-06), because this is not the right approach.  Instead
> of increasing coupling between the sequencer and 'git commit', a
> unified '--continue' that invokes 'git commit' on behalf of the
> end-user is preferred.

Forgive me for forgetting: what is the problem that d3f4628e was going
to resolve (i.e., right approach to what)?  What is this increased
coupling, and why do we want to avoid it?  Is "to prefer" another word
for "to implement"?  Who is being united by this new --continue
switch?

Is this patch just reverting a previous patch?  If so, why doesn't the
commit message use the usual format

	Revert "<commit message>"

	This reverts commit <unabbreviated object name>.

	<explanation>

?

>  sequencer.c                     |   12 +-----------
>  t/t3510-cherry-pick-sequence.sh |   24 ------------------------
>  2 files changed, 1 insertions(+), 35 deletions(-)

When changing behavior, it's more comforting to modify tests to describe
the new behavior than to just get rid of them. :)

To sum matters up: with a new commit message, patch 1 seems likely to
be ready.  Patches 2-5 seem to need more work --- it's not clear to me
yet what they are supposed to do.

Hope that helps,
Jonathan
