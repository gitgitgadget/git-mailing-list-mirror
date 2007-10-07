From: Sam Vilain <sam@vilain.net>
Subject: Re: git-push [--all] and tags
Date: Sun, 07 Oct 2007 14:02:45 +1300
Message-ID: <47083035.7070904@vilain.net>
References: <20071006160506.GA28238@lapse.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sun Oct 07 06:56:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IeKXu-0000TB-Uv
	for gcvg-git-2@gmane.org; Sun, 07 Oct 2007 03:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbXJGBCw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 21:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbXJGBCv
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 21:02:51 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:60049 "EHLO
	magnus.utsl.gen.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbXJGBCv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 21:02:51 -0400
Received: by magnus.utsl.gen.nz (Postfix, from userid 65534)
	id C3C5421CFEE; Sun,  7 Oct 2007 14:02:48 +1300 (NZDT)
Received: from [192.168.69.104] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by magnus.utsl.gen.nz (Postfix) with ESMTP id 414FB21CFC5;
	Sun,  7 Oct 2007 14:02:45 +1300 (NZDT)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <20071006160506.GA28238@lapse.madduck.net>
X-Enigmail-Version: 0.94.2.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.magnus.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=SPF_HELO_FAIL autolearn=no 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60169>

martin f krafft wrote:
> Hello people,
>
> `git-push --all --tags` does not work because git-push ends up
> calling git-send-pack --all refs/tags/*, which the latter does not
> deal with.
>
> Looking at the code, it seems that previously, --all would push
> everything, not just refs/heads/*. What's the reason that this was
> changed? Why aren't tags considered part of --all?
>
> If I wanted to fix this, so that --all pushes heads and --all --tags
> pushes heads and tags, I could do so in two ways:
>
>   1. instead of --all, pass refs/heads/* to git-send-pack
>   2. add --tags to git-send-pack
>
> which of these two would you prefer and why?
>   

Think is, pushing tags is considered to be something that needs to be
done very explicitly; the convention, after all, is that published tags
are forever.  Whereas branches change all the time.  So, pushing tags
should require an extra flag.

Sam.
