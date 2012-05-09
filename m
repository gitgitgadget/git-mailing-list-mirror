From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] notes: do not accept non-blobs as new notes
Date: Wed, 9 May 2012 15:19:14 +0700
Message-ID: <CACsJy8DHotHhF0ADDwjUZx5m8SGjXFuXV9fY=mfHmswyZxzeSQ@mail.gmail.com>
References: <1336482692-30729-1-git-send-email-pclouds@gmail.com> <20120508160334.GA26838@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 09 10:20:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SS28W-0000qG-QJ
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 10:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757771Ab2EIITv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 04:19:51 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49860 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab2EIITs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 04:19:48 -0400
Received: by wgbdr13 with SMTP id dr13so5237wgb.1
        for <git@vger.kernel.org>; Wed, 09 May 2012 01:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VdIVaJ1LNNnaGURtYcmDnvIKkKDB6hLPNGp2694HsEE=;
        b=OH3toS78EyTRjyCDAIE8/gFAH56k9BF5g0KmkkRgTTvo2k4Dw3pPwBweF27y/DFFb1
         AuvBOBFpjSbsgTBCMhpzIUqhfD29JbyR6Ny+PnMi/P9MmSETRSsvkZW9NS1cLnJ9N+n7
         uGLRnmz7a5drzPGAaUA7YItxxBokNiEB8ZmVMTKhHOMX5Lq7ogGvl0PDmBplQi5q1kuz
         91a1NexdYrHR0VOr4QxH/U3xylFzFd84/MyKoGrYNYrsRb3D90BbB3X5SeIT2fpnFWKN
         37RnIXFR95YdfCOfnDNAa1xVjS9Wn6tZvpRgyxToooRjUjxcEmPaKwMzTHAN3gSYGcOV
         hYSA==
Received: by 10.216.145.153 with SMTP id p25mr14237168wej.112.1336551585015;
 Wed, 09 May 2012 01:19:45 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Wed, 9 May 2012 01:19:14 -0700 (PDT)
In-Reply-To: <20120508160334.GA26838@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197460>

On Tue, May 8, 2012 at 11:03 PM, Jeff King <peff@peff.net> wrote:
> On Tue, May 08, 2012 at 08:11:32PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> While at it, check if current notes are blobs before using them.
>
> Hmm. There has been discussion in the past on whether trees could be
> stored in notes. Here's one such thread:
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/139165
>
> There didn't seem to be any consensus. It might be a useful concept, =
but
> it might introduce some complexity. That discussion is two years old
> now, and notes are even older. So I don't know that there is some
> pressing use case that is cut off by disallowing non-blob notes.
>
> At the same time, is there any reason not to allow experimentation in
> this area? We don't know what other people might be putting in their
> private notes trees, and the current interface does allow this.
>
> Is this fixing some important problem that justifies making such
> experimentation harder?

I was actually thinking about tree notes when I made this patch. I
decided that if new git supports tree notes while old git does not,
the old git should refuse to operate on tree notes so it won't cause
any unintentional damages (e.g. appending a blob note to a tree note).
It's too late to fix released git though, I don't know what to do in
that case.
--=20
Duy
