From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 1/2] Add date formatting and parsing functions relative to 
	a given time
Date: Sun, 30 Aug 2009 11:56:37 +0200
Message-ID: <81b0412b0908300256l13d308d9oc30172a20a9f6108@mail.gmail.com>
References: <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
	 <20090828191521.GA12292@coredump.intra.peff.net>
	 <81b0412b0908281220o1c378d5dn6ed52c8d55a9cdec@mail.gmail.com>
	 <20090828193302.GB9233@blimp.localdomain>
	 <20090828205232.GD9233@blimp.localdomain>
	 <7vk50mz41e.fsf@alter.siamese.dyndns.org>
	 <81b0412b0908300025r4eeee84fyf0bfc3b2e940ff37@mail.gmail.com>
	 <20090830091346.GA14928@blimp.localdomain>
	 <20090830091557.GA28531@coredump.intra.peff.net>
	 <20090830093642.GA30922@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	David Reiss <dreiss@facebook.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Aug 30 11:56:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mhh9W-0003wD-Cv
	for gcvg-git-2@lo.gmane.org; Sun, 30 Aug 2009 11:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbZH3J4h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2009 05:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbZH3J4h
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Aug 2009 05:56:37 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:57676 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbZH3J4g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2009 05:56:36 -0400
Received: by bwz19 with SMTP id 19so2297642bwz.37
        for <git@vger.kernel.org>; Sun, 30 Aug 2009 02:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=CPjrBl1D7C7QAMFjW43yIEHFsnW0hyWdeMe3BsdezkQ=;
        b=Ebebh88e3FcQv6iDnwiFMG+26Y9DjmNiQ9g6yaLwp1OYSQyMYZP73GcCKE/gaj3ZwA
         vgJRvXaE2otQmYA2fZciNs0UrV/k5FdZtZfPSPZ1WuXVbcTcs0htWU/8VC03+1easFAe
         CwSY/2uSlZb7jvnEJnsUY2DfNfpgIDwmdfINk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aPZnooOOwEf6l/eOvD/fal7kd7rzS7mxLwZIAhnC9261rjCbw3iVEQNipzDbuKIbIN
         vp7aedu4cQqIQkMdRo1inEveyNFaJSt3dZssJXtTV/RFMjxUu78RNYoVq3OdK9t+A9tZ
         58YKGsDXNEeeDFsdNDhPLLgbqOwEl+pAksiJo=
Received: by 10.204.161.197 with SMTP id s5mr3021012bkx.8.1251626197859; Sun, 
	30 Aug 2009 02:56:37 -0700 (PDT)
In-Reply-To: <20090830093642.GA30922@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127406>

On Sun, Aug 30, 2009 at 11:36, Jeff King<peff@peff.net> wrote:
> On Sun, Aug 30, 2009 at 05:15:57AM -0400, Jeff King wrote:
>
>> FYI, I am munging test-date to match the test script I am writing, s=
o
>> don't bother with that patch.
>
> Here is what my patch is looking like. Please give any comments, and
> then I will resubmit in a form that will be simpler for Junio, which
> should be a series with:
>
> =C2=A0- your patch to refactor date.c
> =C2=A0- this patch (this version uses the original interface to
> =C2=A0 =C2=A0show_relative; I will tweak to match the new patch you j=
ust sent)

Yes, I think this is the only comment I can make.

> +# arbitrary reference time: 2009-08-30 19:20:00

The world changed since 1980 :) There is already three things
happened at the day (http://en.wikipedia.org/wiki/August_2009),
and it is not evening yet (well, here in Europe)

> +check_show 5 '5 seconds ago'
> +check_show 300 '5 minutes ago'
> +check_show 18000 '5 hours ago'
> +check_show 432000 '5 days ago'
> +check_show 1728000 '3 weeks ago'
> +check_show 13000000 '5 months ago'
> +check_show 37500000 '1 year, 2 months ago'
> +check_show 55188000 '1 year, 9 months ago'
> +check_show 630000000 '20 years ago'

check_show 630000000 '20.years.ago'?
(Arbitrary, non-whitespace delimiters, which was an
advertised feature, to make shell's life easier)
