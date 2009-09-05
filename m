From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Sat, 5 Sep 2009 20:45:08 +0200
Message-ID: <20090905184508.GA20124@localhost>
References: <20090902080305.GA11549@neumann> <20090902081917.GA5447@coredump.intra.peff.net> <20090904070216.GA3996@darc.dnsalias.org> <20090905061804.GB29863@coredump.intra.peff.net> <7v8wgt98ms.fsf@alter.siamese.dyndns.org> <20090905084641.GA24865@darc.dnsalias.org> <7veiql1etz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 20:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mk0GP-0004y2-6x
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 20:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbZIESpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 14:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbZIESpO
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 14:45:14 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:45352 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbZIESpN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 14:45:13 -0400
Received: by fxm17 with SMTP id 17so1284317fxm.37
        for <git@vger.kernel.org>; Sat, 05 Sep 2009 11:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=m22i3FMDr8immA9cOwDPXUyk/6E63ulbwYFUIhESOl8=;
        b=DifMFrAJWJHz4NsTotgkPUsuXJPbPcN8J35tNo9219at8QINIX2/9dzC/8k3gU6RLY
         ZnBWi+qJ/cStPzWR71IQkmbg16CW9Bs42IHaNN2qlj5yFMw14MvppIZAhOySVzZ2sjGd
         z736tqcl+PElwqMote3DpWdsIAe5G+NIPkVHc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=Io4dnbeB+M/+FF0BgJD1SGarCRu0ZtheQwXPYxOTZSxW6OmBtGy27jbpbA6lHI9DqA
         jBrR9GkShKbqM8GJKH9Qppb42DrWDa/xFIzMjKb6+StTkBq7pfvWFUJeYyh0MriRNXUz
         lFeNHuNmFMjsuSXdofJ7jrHLj0l1+WTY80a9o=
Received: by 10.204.154.142 with SMTP id o14mr10243023bkw.125.1252176314707;
        Sat, 05 Sep 2009 11:45:14 -0700 (PDT)
Received: from darc.lan (p549A2AE8.dip.t-dialin.net [84.154.42.232])
        by mx.google.com with ESMTPS id 21sm966760bwz.85.2009.09.05.11.45.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Sep 2009 11:45:14 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1Mk0G4-0005QM-NJ; Sat, 05 Sep 2009 20:45:08 +0200
Content-Disposition: inline
In-Reply-To: <7veiql1etz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127826>

On Sat, Sep 05, 2009 at 10:28:08AM -0700, Junio C Hamano wrote:
> But notice that the above is qualified with "personally".  An alternative
> would be to declare that in 1.8.0, all commands run without path argument
> will work on the whole tree and you have to give an explicit '.' when you
> want to limit their effect to the cwd.

That's fine by me.

[...]
>
> Please also see:
> 
>     Message-ID: <7vy6ot4x61.fsf@alter.siamese.dyndns.org> ($gmane/127795)
> 
> think about the three questions there, and help us move the discussion
> forward.

The patch is my way of saying that I'm not just whining, but that I'm
willing to put some effort into getting this done. I am aware of the issues
you raised in the above message and I was hoping that my patch would help us
as a starting point to move the discussion forward.

> The first part of the message has some comments related to your patch, by
> the way.

I can only guess that you mean the "sane way for script writers to defeat
the configuration without much pain" part. But I'm not sure how that's a
problem. If you want the script to continue to work as before you either
configure "workdir scope", or you add a '.' to the affected commands.

Clemens
