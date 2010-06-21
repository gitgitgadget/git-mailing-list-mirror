From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] builtin/checkout: DWIM with -f -b
Date: Mon, 21 Jun 2010 09:08:27 +0800
Message-ID: <AANLkTik3QZBpOjwZHGwIXphXnaHLaBV4pUSb1OVAau9V@mail.gmail.com>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
	<1277051592-4552-2-git-send-email-rctay89@gmail.com>
	<1277051592-4552-3-git-send-email-rctay89@gmail.com>
	<1277051592-4552-4-git-send-email-rctay89@gmail.com>
	<7vvd9dtt54.fsf@alter.siamese.dyndns.org>
	<20100620201137.GA8502@coredump.intra.peff.net>
	<7vpqzltnp3.fsf@alter.siamese.dyndns.org>
	<20100620211605.GA2559@sigill.intra.peff.net>
	<7vfx0htfer.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 21 03:08:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQVV4-0007cm-QS
	for gcvg-git-2@lo.gmane.org; Mon, 21 Jun 2010 03:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362Ab0FUBIa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Jun 2010 21:08:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60864 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756741Ab0FUBI3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Jun 2010 21:08:29 -0400
Received: by iwn36 with SMTP id 36so330144iwn.19
        for <git@vger.kernel.org>; Sun, 20 Jun 2010 18:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rUynYSzeW8kkekq/1AlH8XMk1z4OCXtHw7bOn6xYPU8=;
        b=HC2JAe8YjW27i69+odXD6UU7GoKNJgB6wN61XPT5t0j/y/SxaOP4NxwYX/R/BwNEA8
         GeuaLGumh/SXDG6hg3SLb70fFEutHB1R4lrF6pFfSLvo4ehnOtCYmeZ04sJ+2PNDZPA1
         BTxg78F4M4rjKJsdcFqF6mA7PBi7GcPedKL8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZTQ2xqeTHiCdbZwPnKqTLFIVg6TY+a/LoKvLvose+OwMoUEqmZJ2UeVuSSGWylYiqp
         7faIkwkV86iW9WJ/bQt16GPUmii2+BcLOYyN82mrFPVK6ek/7XFNlezk/SJb+RKA4Aot
         fuB/2pvXWVi0jA5merrw4aG89cZwSupMyATUg=
Received: by 10.231.178.162 with SMTP id bm34mr4316962ibb.86.1277082507806; 
	Sun, 20 Jun 2010 18:08:27 -0700 (PDT)
Received: by 10.231.17.193 with HTTP; Sun, 20 Jun 2010 18:08:27 -0700 (PDT)
In-Reply-To: <7vfx0htfer.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149410>

Hi,

On Mon, Jun 21, 2010 at 8:09 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Jeff King <peff@peff.net> writes:
>
>> ... =A0For your workflow, I
>> doubt it matters, but it is potentially destructive.
>
> Yes; I thought the implication of "-f" to be destructive would be a
> justification enough, but I agree with you that conflating the two ma=
y be
> a bad idea. =A0When a user says "git checkout -f -b jch" after seeing=
 the
> command without "-f" fail due to existing "jch", it is quite clear th=
at
> the user wants to clobber the history of existing "jch" branch (why e=
lse
> would he giving "-f"), but it is not a justification to clobber local
> changes he has in the index and the work tree.

How about doing

  git checkout -f -f -b <branch>

?

By having the user to specify "-f" twice, we're can be really sure
that the user wants to

  1) throw away local changes, which is what the current "-f" is
supposed to do, and
  2) reset an existing branch - new behaviour.


--=20
Cheers,
Ray Chuan
