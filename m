From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [PATCH RFC 1/6] Re: send-email: Add --delay for separating emails
Date: Wed, 8 Apr 2009 00:08:54 +0200
Message-ID: <20090407220854.GA12908@vidovic>
References: <1239139522-24118-1-git-send-email-mfwitten@gmail.com> <20090407215143.GA18144@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 00:11:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrJV5-0000Nm-8q
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 00:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757332AbZDGWJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 18:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757199AbZDGWJA
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 18:09:00 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:43582 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756901AbZDGWI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 18:08:59 -0400
Received: by mu-out-0910.google.com with SMTP id g7so861974muf.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=U1Ba50cZfnuPW8WhyAm+kXQIrAaEOcIVy/rZmDPC4Cg=;
        b=rM//wSNMbYfGLjZBDjArGK65TIwMYDxfnjpA4GdBu3NvmqFeq8GQLOBvXC1x12ZIBe
         Bqwl8QR0yuPaLUpJq03Rsmc6JPnvPxsSPHaAj+ESB47FNaQUqqRQivp800Xr2IuT1Un5
         JtYpn1F16LroRUT5dB5fG3euNa6zxTikCE6Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=X71YCagijSiWpXUY/PsmK8iR5lJlwRYtcQNzd4jz/0M7egKE4qwWDx55OiPZcZG9dV
         KqbzdA20a5kBIcKEdC4Ucoa9Txf8pL41iN2CRXys4rSej7WgtIyd2mXyZr3d1s+2zeda
         qLy5/BYAzneTnwLdd31lvqbi+BO9i1Rt+DTyc=
Received: by 10.103.49.12 with SMTP id b12mr186164muk.81.1239142138091;
        Tue, 07 Apr 2009 15:08:58 -0700 (PDT)
Received: from @ (91-165-135-177.rev.libertysurf.net [91.165.135.177])
        by mx.google.com with ESMTPS id y6sm10164725mug.57.2009.04.07.15.08.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 15:08:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20090407215143.GA18144@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116002>

On Tue, Apr 07, 2009 at 05:51:43PM -0400, Jeff King wrote:

> > When sending a patch series, the emails often arrive at the final
> > destination out of order; though these emails should be chained
> > via the In-Reply-To headers, some mail-viewing systems display
> > by order of arrival instead.
> > 
> > The --delay option provides a means for specifying that there
> > should be a certain number of seconds of delay between sending
> > emails, so that the arrival order can be controlled better.
> > 
> > Signed-off-by: Michael Witten <mfwitten@gmail.com>

> I think it may still be reasonable to implement a solution that only
> covers some of the cases, but I what I am asking is if we know what
> percentage of the cases that is. If we are preventing only 1% of
> out-of-order deliveries with this, I question whether it is worth the
> bother.

IMHO, this improvement is broken by design. We try to fix a
receiver-only issue by a sender side fix.

If the receiver wants the patch series be in a good ordered _for sure_, he
has to switch to a client mail supporting the In-Reply-To chains.

-- 
Nicolas Sebrecht
