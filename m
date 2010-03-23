From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: git rev-list formatting
Date: Tue, 23 Mar 2010 13:40:50 +0100
Message-ID: <40aa078e1003230540o40f551b2re8fbf1e70ae9ddbe@mail.gmail.com>
References: <m3iq8opp8u.fsf@winooski.ccs.neu.edu>
	 <4BA7A75A.6060909@lsrfire.ath.cx>
	 <m31vfbpzol.fsf@winooski.ccs.neu.edu>
	 <4BA89D88.7080803@drmicha.warpmail.net>
	 <m3ocifnvpd.fsf@winooski.ccs.neu.edu>
	 <20100323122603.GA2053@coredump.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 23 13:41:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu3Pn-0006O4-2g
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 13:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab0CWMkx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 08:40:53 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:39198 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147Ab0CWMkw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 08:40:52 -0400
Received: by wwe15 with SMTP id 15so4035516wwe.19
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 05:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MTuGlxOlZfreBnLMEs6HKt5GJPUa/BgMWYwfqmUzZ3Y=;
        b=F629czGoOkHTjXgy6h2K7CPZne+q0rTXq/r4aCOFIXcwqzcJs8/Ew+imIsOGQ3yp/v
         CPut3J702mTXC17K4+CPo34BaS8+MnTHdLDtPYi0Xx6ab+dRFg8WS0MHG/8+DU7NN+d0
         dT/trXic681xwo4Rwp8uQuL6fDsZLquZaVir4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=ioyJOaD6yT1kMPbE4Qr0cDmRahsJrC/w5qXj5c1Tp+xkZBCGzDDGl+2h90/HFuvR+H
         OuPmp+MGDs+vXTHD6hVvpywjhAL+yJfrpAk9AtWAGwLmxw3uChPraJ/0V8e6+U1JTEcc
         XeLKceGXvlFmP0KXpPxEfUoypZY8VupCXk5Us=
Received: by 10.216.162.3 with SMTP id x3mr996137wek.21.1269348050717; Tue, 23 
	Mar 2010 05:40:50 -0700 (PDT)
In-Reply-To: <20100323122603.GA2053@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143012>

On Tue, Mar 23, 2010 at 1:26 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 23, 2010 at 07:06:38AM -0400, Eli Barzilay wrote:
>
>> > [...]
>>
>> I've made a copy of the repository at
>>
>> =A0 http://tmp.barzilay.org/testing.git.tgz
>>
>> which shows what I said when I run
>>
>> =A0 git rev-list --pretty=3D"%b" 267d60518
>> =A0 git rev-list --pretty=3D"%b" 84482
>
> The problem is that most of those commits don't _have_ bodies. Rememb=
er
> that "%b" is about everything in the commit message after the first
> first paragraph.
>
> Now one might argue that rev-list should still put in the extra newli=
ne
> separator in this case. I haven't been paying attention, but hasn't t=
hat
> been discussed in another thread recently?
>

If you're thinking of the stuff I've been working on, that's about
multiple commits ending up at the same line with --pretty=3Doneline, an=
d
not _really_ about unconditionally adding that new-line. But it is
closely related, and it looks like it's the same code that is
responsible for the current behavior. Commit 55246aa is what made then
new-line conditional in the first place.

--=20
Erik "kusma" Faye-Lund
