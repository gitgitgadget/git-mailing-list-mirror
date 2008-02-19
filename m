From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git push [rejected] question
Date: Tue, 19 Feb 2008 08:09:36 -0500
Message-ID: <76718490802190509k20225092o66853916f48e08b1@mail.gmail.com>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com>
	 <20080219043353.GA23239@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jason Garber" <jgarber@ionzoft.com>, git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:10:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRSEe-0006lY-TB
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 14:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbYBSNJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 08:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbYBSNJh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 08:09:37 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:48901 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbYBSNJg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 08:09:36 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3467237wah.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 05:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qTKNeyNz4gaYysP9+ytBmrTGK0l0z1WnxWbQzPdCD9E=;
        b=loPSm+pD5k/CRU2PV3ydMBTfNLaFtpU+LRKkh7plEdV1bvSpJ2s8zeOeUoZGaUPwVckFVMmuupgZ4eiVU9Nh0GWbg0lcZjfwY976E55vzJPcUIHrDTtl1mUuE17oc3N0xMe/nzfTiwtWHfjoBFRK6zf5QJK2CBCahwA/i3vXwlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wrYTC/OWLybztpKee2ewIo4EsAnXQ77JNxUucuvOSdAagjzDb4Rf75gwAMTljr7BK7jDAwTq8+bTKQnKQu0zfBn5X1NwQ+89RfhnWeaPix/KvBA36depK9duG15eSapH+Uo7oqfMteGYvdjl6aPVNpNN7OvfKT4SeKoyXtz69SQ=
Received: by 10.115.55.1 with SMTP id h1mr4169941wak.69.1203426576260;
        Tue, 19 Feb 2008 05:09:36 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Tue, 19 Feb 2008 05:09:36 -0800 (PST)
In-Reply-To: <20080219043353.GA23239@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74399>

On Feb 18, 2008 11:33 PM, Jeff King <peff@peff.net> wrote:
> I think the user is missing one fundamental aspect of pushing: the
> behavior of "git push" without any refspecs specified is to push all
> matching refs (i.e., if you have branch refs/heads/Issue/Default and so
> does the remote, then it will attempt to push). So no matter what branch
> he is on when doing the push, it tries to push many such branches.
>
> If you want to push just the current branch, try:
>
>   git push origin HEAD

git-push(1) is a bit confusing I think:

  "Note: If no explicit refspec is found, (that is neither on the command line
  nor in any Push line of the corresponding remotes file---see below), then all
  the heads that exist both on the local side and on the remote side are
  updated."

is clear enough, but then:

  "--all Instead of naming each ref to push, specifies that all refs under
  $GIT_DIR/refs/heads/ be pushed."

So what is '--all' needed for then?

It seems like the default should be to push just the current branch
... this would correspond to what a user of git pull expects (even
though the converse of git-push is really git-fetch, for a new user,
that might not be entirely clear).

j.
