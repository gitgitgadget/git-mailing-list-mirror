From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v2 2/4] xdiff/xprepare: refactor abort cleanups
Date: Thu, 7 Jul 2011 12:05:26 +0800
Message-ID: <CALUzUxoSBVfzEhvKQahhRXCDsFs5nQvfHeohHUJMeJ7QYMv3wA@mail.gmail.com>
References: <1309970337-6016-1-git-send-email-rctay89@gmail.com>
	<1309970337-6016-2-git-send-email-rctay89@gmail.com>
	<1309970337-6016-3-git-send-email-rctay89@gmail.com>
	<7vliwbmgv0.fsf@alter.siamese.dyndns.org>
	<CALUzUxqPf0nReHHhQ3zJoVbPAN7GNuzWeunWoxbzLuoYtuEbUw@mail.gmail.com>
	<7vaacrhtp3.fsf@alter.siamese.dyndns.org>
	<4E152E31.4020105@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Phil Hord <hordp@cisco.com>
X-From: git-owner@vger.kernel.org Thu Jul 07 06:05:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QefqG-0002xS-6H
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 06:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912Ab1GGEF2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jul 2011 00:05:28 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58377 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab1GGEF1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2011 00:05:27 -0400
Received: by eyx24 with SMTP id 24so183184eyx.19
        for <git@vger.kernel.org>; Wed, 06 Jul 2011 21:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=29Shkprjog+lmlO6PpQvm6oW6qCbExJMs5sYPChgs/4=;
        b=lhY4shMO/EUBmiZKR0v0RF1afYFzyfS9/RX73yEJj6HAGKTg1vAY2mBPjSAOTXvlAz
         PYxJV65F7dgfb+jy+I+FpkEVsULW4ZTgaArtwEcD5nBjoHug/8Fmc3dvrYnftS/rHQQ4
         QIYOuCgh8QufIrH/AnBeHRebb/DDfQiBMFdsI=
Received: by 10.14.96.131 with SMTP id r3mr95248eef.101.1310011526179; Wed, 06
 Jul 2011 21:05:26 -0700 (PDT)
Received: by 10.14.37.138 with HTTP; Wed, 6 Jul 2011 21:05:26 -0700 (PDT)
In-Reply-To: <4E152E31.4020105@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176741>

On Thu, Jul 7, 2011 at 11:55 AM, Phil Hord <hordp@cisco.com> wrote:
> Because 'free(NULL)' is handled sanely (as a no-op).
> http://pubs.opengroup.org/onlinepubs/009695399/functions/free.html

Yup, I got what Junio meant after he posted an example. (Thanks Junio.)

> I haven't looked, but I assume xdl_cha_free does the same thing. =A0I=
 only
> assume this because Junio seems to imply it, though.

xdl_cha_(init|free)() do something more complicated, so we don't have
to set xdf->cha to NULL, unlike the others.

--=20
Cheers,
Ray Chuan
