From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: the pager
Date: Mon, 2 Sep 2013 19:57:11 -0700
Message-ID: <20130903025711.GA25617@elie.Belkin>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
 <xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
 <201308281819.r7SIJmnh025977@freeze.ariadne.com>
 <xmqqr4dd8suz.fsf@gitster.dls.corp.google.com>
 <201308291541.r7TFfuJr023110@freeze.ariadne.com>
 <vpqsixsv6dq.fsf@anie.imag.fr>
 <201309030227.r832RmBd013888@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	gitster@pobox.com, Jeff King <peff@peff.net>
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 03 04:57:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGgo2-0002dg-Pa
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 04:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096Ab3ICC5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Sep 2013 22:57:23 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:44849 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab3ICC5W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Sep 2013 22:57:22 -0400
Received: by mail-pd0-f178.google.com with SMTP id w10so5353450pde.23
        for <git@vger.kernel.org>; Mon, 02 Sep 2013 19:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=pKlrtlm7UH7IS+3EXR3JydTlQ5C2J7E/+LY9o9Ai8Co=;
        b=RR/UTBRmfqfbJoVfZUma4MF60iT9wcaotBa8xHxAhubQxsg664MrB5gEgi8cDIEQRO
         sKI6CSjkCTRDNbeqg9kXihXaZ3lYaN3d+V9CLE7fox1Tp1MGJ9n8DDnutGQktGKB1PFL
         kDL3Xr6ghv8/4aLG79NNrx71QPKt43x8BUO/82dlHrtMQZtUAyRY4ot5b0DkVoKJ6/1V
         qT27+RdBzajkDd7vOES5AQ3GLfV0otQho3dPjqmI7irxFcA5Mv2GozgvpRBg93vgyxeh
         F+pPkvisqQ72br2irShTBwcH86BoTqYOxcgHAxdIEgdwu1aF+MeFgmQvs7+W8Fhuc/Dk
         Oy3A==
X-Received: by 10.66.146.199 with SMTP id te7mr29681814pab.106.1378177040924;
        Mon, 02 Sep 2013 19:57:20 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id os4sm19122906pbb.25.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Sep 2013 19:57:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201309030227.r832RmBd013888@freeze.ariadne.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233677>

Hi,

Dale R. Worley wrote:

> That's true, but it would change the effect of using "cat" as a value:
> "cat" as a value of DEFAULT_PAGER would cause git_pager() to return
> NULL, whereas now it causes git_pager() to return "cat".  (All other
> places where "cat" can be a value are translated to NULL already.)
>
> This is why I want to know what the *intended* behavior is, because we
> might be changing Git's behavior, and I want to know that if we do
> that, we're changing it to what it should be.  And I haven't seen
> anyone venture an opinion on what the intended behavior is.

I don't really follow.

For all practical purposes, "cat" is equivalent to no pager at all,
no?  And the git-var(1) manpage describes the intended order of
precedence, as far as I can tell, except that it was written before
v1.7.4-rc0~76^2 (allow command-specific pagers in pager.<cmd>,
2010-11-17) which forgot to update some documentation.

Suggested wording for improving the documentation or its organization
would of course be welcome.  And I agree with Matthieu that the name
of the pager_program global variable is needlessly confusing ---
perhaps it should be called config_pager_program or similar.

Thanks,
Jonathan
