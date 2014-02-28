From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [PATCH 1/2] t3200-branch: test setting branch as own upstream
Date: Fri, 28 Feb 2014 19:44:10 +0900
Message-ID: <CAN7MxmUUoz-HGFiTfgpvLpkXhvjBn_dYje7unoHE-Y=k3A0aqg@mail.gmail.com>
References: <1393556659-32717-1-git-send-email-modocache@gmail.com>
	<20140228053703.GA32556@sigill.intra.peff.net>
	<531032DD.9000904@viscovery.net>
	<20140228071401.GA1229@sigill.intra.peff.net>
	<20140228072606.GA622@sigill.intra.peff.net>
	<CAN7MxmXOvkrWPDEUH_Bqz5RVZUS7kuWkwi9kWmdwuwySszd=YA@mail.gmail.com>
	<20140228083718.GA11480@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 11:44:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJKvS-0007UE-Id
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 11:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbaB1KoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 05:44:14 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:39259 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751516AbaB1KoN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 05:44:13 -0500
Received: by mail-ig0-f175.google.com with SMTP id y6so1300830igj.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 02:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TZ9jFoC5BgtYrKIDF9UeDMVWSiZPZxQRLMxAHwIXdC0=;
        b=PKLIq/V5SbgVa5xcg7lpBlbEXkA1A69lYFYNDpQ8Vs9aAZeJNOww7vN4vNjTI6di0g
         dybLQZ7uBOfyOW6XlhX4eRnMJNyFfIpnO85vG9vsRQgvAAhAY+b99Smzk3CTMwPit4gi
         iK4F8Xxl6e6Rm6V+T4+EsMTX7Dc5mvUmMfaaarJQao4WQ5l2WOhqin4Z9ClGVXzrsUeD
         +cIALJTUzIVQV8JfYPKKI3lu4YQwLjER5Rln98NOgfGC9nJBvjB4HTJYQbMiTATTl3zf
         +ehnnDfUcMo0ZjT06yE6xVfjZI2CKqa0NG0/KSXeQGdlackEJjtHPrsS5M/xWmuT+vM3
         hsSg==
X-Received: by 10.42.228.65 with SMTP id jd1mr1099963icb.62.1393584250883;
 Fri, 28 Feb 2014 02:44:10 -0800 (PST)
Received: by 10.64.55.161 with HTTP; Fri, 28 Feb 2014 02:44:10 -0800 (PST)
In-Reply-To: <20140228083718.GA11480@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242938>

> If you feel like continuing on this series, converting the warning()
> into a die() would be a much more productive use of time (but if you
> don't, I do not see any reason not to take the patches you've posted).

I'd be happy to keep working on this. In fact, I think I have a patch
for this ready. But just to clarify:

> I notice that the warning comes from install_branch_config, which gets
> used both for "branch -u", but also in the "side effect" case I
> mentioned above. Is it possible to trigger this as part of such a case?
> I think maybe "git branch -f --track foo foo" would do it. If so, we
> should perhaps include a test that it does not break if we upgrade the
> "-u" case to an error.

Do you mean that install_branch_config should continue to emit a
warning in the "side effect" case? I'm not sure I agree--how is "git
branch -f --track foo foo" less erroneous than "git branch -u foo
refs/heads/foo"? Perhaps I'm missing some insight on how "--track" is
used.

The tests appear to already cover all instances in which
install_branch_config is called, and bumping the warning to an error
does not cause any test failures.

- Brian Gesiak
