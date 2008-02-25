From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] mergetool: clarify local/remote terminology
Date: Mon, 25 Feb 2008 14:07:11 -0500
Message-ID: <76718490802251107y44ff2d6ahf5446ae0408c67b0@mail.gmail.com>
References: <1203570776-62019-1-git-send-email-jaysoffian@gmail.com>
	 <76718490802250631p262baf1bw23873e5fdbbb7180@mail.gmail.com>
	 <20080225184648.GC15131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 20:07:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTig4-0005vf-Bk
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 20:07:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbYBYTHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 14:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbYBYTHQ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 14:07:16 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:60363 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbYBYTHO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 14:07:14 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2057436wah.23
        for <git@vger.kernel.org>; Mon, 25 Feb 2008 11:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iPmQxcLNPLHQhu64XbTwFTv80c1a+rAS3IO3/F7+52Q=;
        b=kI4Nt4V0a8hH9XPbUndUdtyEmRmTgYtE+on+TCrckcJQ2WRx4RKNb92fx7k3Jusj1Pt7jeR4sTKWA8HgrGPZyA4a6XCUTuQRHLx1gsWoT4Oysj2F3Wg0S8+T5/5/j5RzpG2W6Xag55mMQdvjC0uqiCr4s/COMFaWb3lHpnqW3TU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KbEfZ+m9SqcEA3QeD476jUOe3MaDZJtLKrwE+duXNVdN9FmTdKBI4RDyssnS41zVpUXFoj7qj/l/Yv0N+EZmF0cus8TvnloL6JFBY1oFGTCK08hF4oOt/fDhIYgdx8PWNI2AM7lxHtebOAf9oDhHQPfvhS0iv44hFczq7ev6Rk8=
Received: by 10.114.158.1 with SMTP id g1mr4079970wae.97.1203966432013;
        Mon, 25 Feb 2008 11:07:12 -0800 (PST)
Received: by 10.114.145.13 with HTTP; Mon, 25 Feb 2008 11:07:11 -0800 (PST)
In-Reply-To: <20080225184648.GC15131@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75049>

On Mon, Feb 25, 2008 at 1:46 PM, Jeff King <peff@peff.net> wrote:

>  I have been annoyed by this in the past, too. And I think your change is
>  probably an improvement (though I haven't tried it yet). As a user, what
>  I would _really_ like to see, though, is simply the branch names:
>  "origin/next" versus "next".

I was playing with that, figuring out branch names in the same way that the
code in bashcompletions computes ps1. However, what would you want to see if
you're doing an interactive rebase of say HEAD vs HEAD~5. They are both the
same branch, so what would you want to see?

>  I looked at using the GITHEAD_* mechanism
>  in the past, but that relies on the environment, which can't get
>  directly to mergetool. See this thread:
>
>  http://mid.gmane.org/20070820075318.GA12478@coredump.intra.peff.net
>
>  I think the right thing to do is the oft-discussed-but-never-implemented
>  "what's happening right now" file/command that would say:
>
>   1. there's a rebase happening now
>   2. the upstream branch is X
>   3. the rebased branch is Y
>
>  but that could also of course say
>
>   1. there's a merge happening now
>   2. the first parent is X
>   3. the second parent is Y
>
>  and so on (including "we're in a git-am, git-cherry-pick, etc").

Okay, I'll look into that.

>  I'll try out your patch and comment next time I use it.

Appreciated.

j.
