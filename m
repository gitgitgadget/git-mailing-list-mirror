From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [1.8.0 RFC] push: start warning upcoming default change for
 push.default
Date: Mon, 14 Feb 2011 17:36:07 -0600
Message-ID: <20110214233607.GA25163@elie>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <201102140036.42197.johan@herland.net>
 <7vfwrrukzq.fsf@alter.siamese.dyndns.org>
 <201102141018.46527.johan@herland.net>
 <7vfwrqtrsk.fsf_-_@alter.siamese.dyndns.org>
 <AANLkTincKapKgcWEE1Z+vQesSjZBFAnfH0uL+a7GhQ6b@mail.gmail.com>
 <AANLkTi=Fpey7e+E1eKOiSaS1hjW2d8eOy9PVLR34Sc5J@mail.gmail.com>
 <AANLkTin5ZcZU8iwPSm4A87bYRrSCcXJVLBFGSr2+j30j@mail.gmail.com>
 <vpqr5bath2z.fsf@bauges.imag.fr>
 <20110214223557.GA13070@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 00:38:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp80K-0005oO-Ax
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 00:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858Ab1BNXis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 18:38:48 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64718 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab1BNXiq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 18:38:46 -0500
Received: by qyk12 with SMTP id 12so4335732qyk.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 15:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=BE+jM504qFbZ6FoQ6rHXYwTdey5JP9RSxQyjQhrOJNM=;
        b=LZ6PfInH9Qa3MekEk64uRGM65ephSZlOre7juDmHcNHBPO3+zazfUvKYnwWUFtd2K4
         XgwOpPbyIy8eJVsrC+oRBTdYdJNkPcx+Q1j46B6IenPxynV0fbg00YSsE/2P1Hq2SxOg
         7Y/uGQ8pQXXrbu30KItE4mJROESJO2HLKOaIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oLUwjDSTtiDYH8fw6e0JWZ8qebCndogofeNUOyMArYOICnTxJMXAjDk9ia2op/Tm6S
         0ca1xxluGX0BumlyKM0rLkBHEhqIN+FJ/hls2LER+jI59KzXMbjmJ7l6TcGbXJA62lPk
         gQsLELV6wp33afoNdyWu9ymQ6KxQoGDhB8o9Y=
Received: by 10.224.11.21 with SMTP id r21mr3881801qar.6.1297726577791;
        Mon, 14 Feb 2011 15:36:17 -0800 (PST)
Received: from elie (adsl-69-209-51-217.dsl.chcgil.ameritech.net [69.209.51.217])
        by mx.google.com with ESMTPS id g28sm2174364qck.13.2011.02.14.15.36.14
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 15:36:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110214223557.GA13070@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166796>

Jeff King wrote:

> Agreed, and put the commands on their own line for simpler
> cut-and-paste, like:
>
>   push.default is unset; its implicit value is changing in 1.8.0 from
>   'matching' to 'current'. To squelch this message and maintain the
>   current behavior post-1.8.0, run:
>
>     git config --global push.default matching
>
>   To squelch this message and adopt the 1.8.0 behavior now, run:
>
>     git config --global push.default current
>
>   See 'git help config' and search for 'push.default' for further
>   information.
>
> I think the whitespace makes it easier to see there are two choices, and
> most people have some kind of triple-click-to-copy-whole-line in their
> terminal.

Yes.  Thank you, and sorry about my previous reply that missed the
point.
