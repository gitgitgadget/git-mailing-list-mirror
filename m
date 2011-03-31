From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: GSoC questions
Date: Thu, 31 Mar 2011 13:58:23 +0200
Message-ID: <AANLkTi=TOYOj2HWzy62G24Kg=NZC5X1=psA3GDhaH3Hc@mail.gmail.com>
References: <AANLkTinTM8hQpcahGgDyB4UJvGbdN0xyp65wL5PDQGKa@mail.gmail.com>
	<20110328001152.GA11294@elie>
	<AANLkTikGb1=Rtz-T9p=u+X32KpL2AXq0AELdSJ2NMHrW@mail.gmail.com>
	<AANLkTink4wVb6O+yVm=HUh_s1GhKhyL4baqYGe=XFu04@mail.gmail.com>
	<AANLkTinZ2zbhCRAqAYkiAa1=K8aUhcAuEe6Q_gO-v2h_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vicent Marti <vicent@github.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	libgit2@librelist.org, Jeff King <peff@peff.net>
To: Alexandru Sutii <sutii.alex@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 13:58:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5GWF-0001lv-Aq
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 13:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483Ab1CaL6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 07:58:25 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47565 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab1CaL6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 07:58:24 -0400
Received: by qwk3 with SMTP id 3so1420603qwk.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 04:58:24 -0700 (PDT)
Received: by 10.229.42.83 with SMTP id r19mr1985546qce.77.1301572703903; Thu,
 31 Mar 2011 04:58:23 -0700 (PDT)
Received: by 10.229.248.9 with HTTP; Thu, 31 Mar 2011 04:58:23 -0700 (PDT)
In-Reply-To: <AANLkTinZ2zbhCRAqAYkiAa1=K8aUhcAuEe6Q_gO-v2h_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170474>

On Thu, Mar 31, 2011 at 11:36 AM, Alexandru Sutii <sutii.alex@gmail.com> wrote:
> I have also used the original "usage.c" and "git-compat-util.h" for
> error handling.
> Is there a problem if the git2 client will reuse non-gitcore code, such
> as string parsing code, parameter parsing code, etc?

I guess the git2 client will consist solely of non-gitcore code, as
all the gitcore code will be part of libgit2 eventually.

I expect the transition to be not so difficult for many commands, but
the challenge I see is to do it not by 'reusing' git code, but by
'sharing' the code. Otherwise we end up with a second Git and someone
should spend a lifetime to keep the reused code in synchronisation
with the git repo.

This might, however, require some (major) refactorization to the Git
code. I don't know whether that will be supported by everyone.

On the other hand, we will get the bonus that using libgit2 in the
upstream git code is then becoming more trivial.

Maybe I'm aiming at too much here. It could well be that it is worth
writing the minimal git client to just be able to test libgit2 using
the git tests. Does anyone want to comment ?

Vincent
