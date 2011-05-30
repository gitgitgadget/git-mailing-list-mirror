From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: remote helpers: best practices for using the "refspec" capability
Date: Mon, 30 May 2011 13:04:26 -0500
Message-ID: <BANLkTimoQtZLw4NhenR9QbAt6EhSThWj2A@mail.gmail.com>
References: <BANLkTinTuEppMGO16z2sMkjV8FveCbrwEQ@mail.gmail.com>
 <20110529232405.GA8369@elie> <BANLkTinhH7ksP8EZV+Sd4ryCT1_bhVhgaw@mail.gmail.com>
 <20110530145203.GA10879@elie> <BANLkTinRscvPLHbob55pxhXSTKqm+eSF6g@mail.gmail.com>
 <20110530155256.GC10879@elie> <20110530164013.GG10879@elie> <alpine.LNX.2.00.1105301300520.2233@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?SsOpcsOpbWllIE5JS0FFUw==?= <jeremie.nikaes@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sylvain Boulme <Sylvain.Boulme@imag.fr>,
	Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon May 30 20:05:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR6q4-0000Wa-Mi
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 20:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755353Ab1E3SFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 14:05:08 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43710 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754817Ab1E3SFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 14:05:07 -0400
Received: by qwk3 with SMTP id 3so1762390qwk.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=WArudYBA84t8H2gGqfhDIm7pnDK+sAcFpsFuUbXb+Oc=;
        b=sRAeIGIwSxHQteGC80+TscqH4SLFnh1Kiqd1HFErXUi1DOYeqDLNmbfXNxl/EbTDPu
         qZrmH87n9rPQbkG9C6gdw5BllE3eHbFhhO4dwWFiCZM26J1K7BDKZZEh75/2M//uXS6T
         s5tPQjV5f9HKWbszVUMAxoi425WSTmNftr8jk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tDqgvlAOtYMFZcBufHqkP4EzEhUEg7UmV6oSmxln6nAB0BMs5dGbUgVxmRuinAE0Cy
         zRpgvqg1ggFlUGSwegEGv1aR5VIDkFrP3n2ACslrtIx8Vdk2/lZUZYlEZobgafBTs6lQ
         4IQeftTQuW+whN1NknMiPSABIbPBk4+Ho0Y9E=
Received: by 10.229.73.81 with SMTP id p17mr3707605qcj.43.1306778706125; Mon,
 30 May 2011 11:05:06 -0700 (PDT)
Received: by 10.229.20.6 with HTTP; Mon, 30 May 2011 11:04:26 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1105301300520.2233@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174766>

Heya,

On Mon, May 30, 2011 at 12:43, Daniel Barkalow <barkalow@iabervon.org> wrote:
> But the purpose of the namespacing is to be able to continue the correct
> incremental import, so it would make sense to do some arbitrary
> transformation to make your url be a valid ref directory, and use that.
>
> It would make sense to add support for a namespace where fast-import can
> write whatever it wants, and it'll get discarded after the fetch is done,
> if it's the case that anyone can stand not having incremental imports.

I remember a patch series by someone else a lot more that _disabled_
creating of refs during fast-import, and instead allowed for
specifying what refs to update with which values at the end of the
import.

-- 
Cheers,

Sverre Rabbelier
