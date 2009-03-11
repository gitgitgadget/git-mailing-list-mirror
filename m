From: Mike Ralphson <mike.ralphson@gmail.com>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when 
	cherry-picking an empty commit
Date: Wed, 11 Mar 2009 17:02:04 +0000
Message-ID: <e2b179460903111002p195628ddka23529d898a2ec1f@mail.gmail.com>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com>
	 <20090308144240.GA30794@coredump.intra.peff.net>
	 <7v8wnflrws.fsf@gitster.siamese.dyndns.org>
	 <20090310181730.GD26351@sigill.intra.peff.net>
	 <AA6A171F-70CE-4CB3-9AE1-27CD69C3202C@pobox.com>
	 <20090311003022.GA22273@coredump.intra.peff.net>
	 <e2b179460903110408i4ab3c9cg3c863b89a2f57cba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Chris Johnsen <chris_johnsen@pobox.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 11 18:04:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhRqx-0006Gp-QZ
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 18:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755265AbZCKRCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 13:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755025AbZCKRCJ
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 13:02:09 -0400
Received: from mail-qy0-f122.google.com ([209.85.221.122]:42177 "EHLO
	mail-qy0-f122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbZCKRCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 13:02:07 -0400
Received: by qyk28 with SMTP id 28so177738qyk.33
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=e1AlLNH9WHeW2+hFKDUYNIGpn/guERJpdWr1frHExsY=;
        b=PYiNbGa6JAOWtIBItLjNmdjI2sUD3Hc7xzQGNfd9RQ9CFg4TOTW/S6sr6/1CibWKm6
         Iyo/93W691S4MBXApOvsv7WovQY6v2kqK4NLqQvigBfsH0NORvLfqeS8tFsCGmfVggfk
         twoERY4GpB/aQ1AfFpDr+sD+I9hZYfe5dhguE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oZS/+mcsC6xoY+tkf6aVm9q4zbKc2L2/X/BIJe6Q2E4mzeHq9MxNt9IPAD4gY2ATDj
         sa+0gP4T+4PkIzSN6GvMycF/bfeSLDbaKq54pl3ZSWTGPuz7LU5+yYY21myFIQtYPNn4
         teSoipIfo8+iku2luPnIpk6V/+UgYbdP3r8TE=
Received: by 10.224.54.12 with SMTP id o12mr11533711qag.13.1236790924918; Wed, 
	11 Mar 2009 10:02:04 -0700 (PDT)
In-Reply-To: <e2b179460903110408i4ab3c9cg3c863b89a2f57cba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112958>

2009/3/11 Mike Ralphson <mike.ralphson@gmail.com>
>
> 2009/3/11 Jeff King <peff@peff.net>:
> > OK, then nothing to worry about there. I have no idea which shell
> > OpenBSD and NetBSD use these days, and I don't have access to a box.
> > Anybody?
>
> OpenBSD uses pdksh in Bourne shell mode for non-root shells (ksh mode
> for root)

... and isn't broken in this instance (OpenBSD v4.1)

Weird test failures though, so now I'm looking at that 8-)
