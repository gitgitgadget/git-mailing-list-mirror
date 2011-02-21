From: lists@haller-berlin.de (Stefan Haller)
Subject: Re: Issue with GitGUI losing file permissions on merge
Date: Mon, 21 Feb 2011 08:25:24 +0100
Message-ID: <1jx15l9.1taq59z1rcvgbxM%lists@haller-berlin.de>
References: <79ec6c5b-eb2e-4f19-90c6-00e3af72797e@q14g2000vbf.googlegroups.com>
Cc: git@vger.kernel.org
To: lion.hopkins@gmail.com (Lyle), msysgit@googlegroups.com (msysGit)
X-From: git-owner@vger.kernel.org Mon Feb 21 08:25:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrQ9E-0007fK-3N
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 08:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442Ab1BUHZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 02:25:27 -0500
Received: from mail.ableton.net ([62.96.12.117]:37374 "EHLO mail.ableton.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751922Ab1BUHZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 02:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=haller-berlin.de; s=mail_2009081900;
	h=Message-ID:Date:From:Subject:In-Reply-To:Cc:To; bh=y9b3Hu7hxb5zfjzIeMEz6HQ29NdGjEhUXhz7KVEGgQQ=;
	b=ZZg7P6bkwm0dXcr1Ybtypzx5NWlb/vsCB93OLBfFUIFJpzAJ84nR524M6jxMOrrISfWedfjKK5cwUc7/Z+W6kptj30u0VGifxm3wuvKfUYuXa9k5t22Xmzr0/BJ/0pTDEETjlk4oSH99GYFbLozEFHcw/0XcCZJP07oiRKes0fY=;
Received: from dslb-088-074-017-003.pools.arcor-ip.net ([88.74.17.3] helo=[192.168.42.92])
	by mail.ableton.net with esmtpsa (SSLv3:AES128-SHA:128)
	(Exim 4.72)
	(envelope-from <lists@haller-berlin.de>)
	id 1PrQ96-0000Zx-OZ; Mon, 21 Feb 2011 08:25:24 +0100
In-Reply-To: <79ec6c5b-eb2e-4f19-90c6-00e3af72797e@q14g2000vbf.googlegroups.com>
User-Agent: MacSOUP/2.8.3 (Mac OS X version 10.6.6 (x86))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167446>

Lyle <lion.hopkins@gmail.com> wrote:

>   I've had an odd issue pop up a few times. After chatting with some
> people on #git and doing some further testing I finally managed to
> narrow down what's causing the issue. The git command line behaves
> properly, but GitGUI changes the file permission on the merge, losing
> the execute permission. So 0755 files become 0644, causing problems
> when pushed back to origin and pulled down to a Linux repo.

I've run into this too.  It has little to do with git gui though, and
nothing with msysgit.

It's a bug in git-update-index (which git gui happens to call when you
stage a file).  Here's some more information about it:

   <http://thread.gmane.org/gmane.comp.version-control.git/159716/focus=159888>

It is still on my to-do list to try and fix the problem, but I have
never gotten around to it yet.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
