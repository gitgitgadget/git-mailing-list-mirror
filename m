From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: remote branches, and branch names in general
Date: Tue, 3 Mar 2009 14:32:00 -0500
Message-ID: <76718490903031132v592b8368p6355ea2bd0cda4ae@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E709F07398@EXCHANGE.trad.tradestation.com>
	 <m3vdqrtp84.fsf@localhost.localdomain>
	 <20090303041631.GB18136@coredump.intra.peff.net>
	 <450196A1AAAE4B42A00A8B27A59278E709F075DF@EXCHANGE.trad.tradestation.com>
	 <20090303161117.GB32079@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Dlugosz <JDlugosz@tradestation.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 20:33:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeaMw-0008OZ-1x
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 20:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbZCCTcG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 14:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbZCCTcE
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 14:32:04 -0500
Received: from rv-out-0506.google.com ([209.85.198.224]:12759 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbZCCTcC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 14:32:02 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2925381rvb.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 11:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6lDwpY6BUQI4vsq5OhyHIWHC9CCSSdvNMzv+S3s6jMU=;
        b=SkANtQvb4kPS2gi8anp9dwnab51bdCI5z8lpRyW+zgJp2rEref6P0NsOgMNTJTrD/0
         JfwAN63Fqa5WlYUn7Z5pReCvBj4WcwQ0GyZSdzP1SJ8LTIVHIMhG01i76BoFtcEKczGv
         U+o060FwVHmkI3eh9RWUKI42xTCB0+1HDga0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=riVcK2LB5YHGMyQqkUFd+uEUVdc42Lwa4lgGMC1ParnXnob0R9iPGrIcdgQUmpxjN9
         WpY+iFjPu9rztUXrqMWrHfdqVJ7FRQU7TwbjGMEdc2YrWsRzW2ao2reLqOC1NWFbBgye
         VTFQB21geQ51U3BFf0VYTDJXaKOjFWf7yqMw0=
Received: by 10.141.180.16 with SMTP id h16mr3698735rvp.68.1236108720138; Tue, 
	03 Mar 2009 11:32:00 -0800 (PST)
In-Reply-To: <20090303161117.GB32079@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112154>

On Tue, Mar 3, 2009 at 11:11 AM, Jeff King <peff@peff.net> wrote:
> Yes, the "branch" command deals only with creating things in refs/heads,

Unless given -r, in which case it looks in refs/remotes, or -a, in
which case it looks in refs/heads and refs/remotes. :-)

> which are your local branches (similarly, "git tag" will only deal with
> stuff in refs/tags). So "git branch origin/foo" will make a ref
> "refs/heads/origin/foo", and "git branch -d origin/foo" will delete
> "refs/heads/origin/foo", not "refs/remotes/origin/foo".

For the latter, use git branch -d -r origin/foo. I'm not sure whether
-r is usable when creating a branch, I haven't tried.

j.
