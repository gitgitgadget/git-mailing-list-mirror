From: Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH 3/3] builtin/checkout: DWIM with -f -b
Date: Sun, 20 Jun 2010 19:58:53 -0700
Message-ID: <AANLkTildfbJvt15cObc52LvOQRvasL4WYsJq3126bBGd@mail.gmail.com>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
	<1277051592-4552-2-git-send-email-rctay89@gmail.com>
	<1277051592-4552-3-git-send-email-rctay89@gmail.com>
	<1277051592-4552-4-git-send-email-rctay89@gmail.com>
	<7vvd9dtt54.fsf@alter.siamese.dyndns.org>
	<20100620201137.GA8502@coredump.intra.peff.net>
	<7vpqzltnp3.fsf@alter.siamese.dyndns.org>
	<20100620211605.GA2559@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 21 04:59:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQXEN-0008Cd-DX
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 04:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757053Ab0FUC7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jun 2010 22:59:22 -0400
Received: from smtp-out.google.com ([216.239.44.51]:45916 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756485Ab0FUC7V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jun 2010 22:59:21 -0400
Received: from kpbe11.cbf.corp.google.com (kpbe11.cbf.corp.google.com [172.25.105.75])
	by smtp-out.google.com with ESMTP id o5L2xJ5u032377
	for <git@vger.kernel.org>; Sun, 20 Jun 2010 19:59:19 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1277089159; bh=GNq1kE8JtnKpMSm/1TGSvuB8kEA=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type:Content-Transfer-Encoding;
	b=FQZuEK2+tVcMQmy1x4qAAXb604Hmpi8YbDK6tl7Nx2PaYOt8/AXe7uDmseysfIu7K
	 wqv0lfJIuuxXJPq/cEAKg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to:
	cc:content-type:content-transfer-encoding:x-system-of-record;
	b=iic5s85D5hLQeJ3ZtMzDGzIS7Aa4rMrAhY4FvNTSX5kqD/gC7F1/Zm9WlRPNctLgG
	XMFUOJLdBqnBL//MSqwZw==
Received: from qyk2 (qyk2.prod.google.com [10.241.83.130])
	by kpbe11.cbf.corp.google.com with ESMTP id o5L2wref010003
	for <git@vger.kernel.org>; Sun, 20 Jun 2010 19:58:54 -0700
Received: by qyk2 with SMTP id 2so1264223qyk.30
        for <git@vger.kernel.org>; Sun, 20 Jun 2010 19:58:53 -0700 (PDT)
Received: by 10.224.31.18 with SMTP id w18mr2693609qac.22.1277089133256; Sun, 
	20 Jun 2010 19:58:53 -0700 (PDT)
Received: by 10.229.78.11 with HTTP; Sun, 20 Jun 2010 19:58:53 -0700 (PDT)
In-Reply-To: <20100620211605.GA2559@sigill.intra.peff.net>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149411>

On Sun, Jun 20, 2010 at 2:16 PM, Jeff King <peff@peff.net> wrote:
> I'm certainly sympathetic, but as I understand it, with this new patc=
h
> you are doing the equivalent of:
>
> =A0git branch -f jch master
> =A0git checkout -f jch
>
> which is different than what you wrote above. =A0For your workflow, I
> doubt it matters, but it is potentially destructive.

I am frequently trying to do this as well, so I would love the
checkout -f -b option.

However, I think that the desired behavior for checkout -f -b is that
it should be equivalent to:
git branch -f jch master
git checkout jch   (without the -f here)

rationale: git checkout -b normally preserves the index & the working
tree; adding the -f flag to a command that would otherwise succeed
should not change its behavior.

--=20
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
