From: Mika Fischer <mika.a.fischer@googlemail.com>
Subject: Re: [msysGit] Git unable to access https repositories due to
 curl/OpenSSL 1.0.0 handshake issues
Date: Wed, 26 Jan 2011 23:18:09 +0100
Message-ID: <AANLkTimSd6QmwGfuk44ga=YG3TT7wuwLJQMP=eghhttu@mail.gmail.com>
References: <0aa77107-bb31-4f74-90e2-02ce5155b0a0@l17g2000yqe.googlegroups.com>
 <AANLkTi=UQR3cEbTj4N0W_4CLG9T1F+rmkLEew+WO4w5f@mail.gmail.com>
 <AANLkTinGLMcRJ9EuZY_k4GoKyg+r7hxcgnq3z0=qOemA@mail.gmail.com>
 <AANLkTimJznExH8N9fcgSC88HOPfaFDF7jFMTZUJauL9+@mail.gmail.com>
 <alpine.DEB.2.00.1101261422550.20831@tvnag.unkk.fr> <AANLkTi=Gey75oo-iaELVWg87cP+HgM3RQ60vPgwaEMpS@mail.gmail.com>
 <alpine.DEB.2.00.1101262244550.14066@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: kusmabite@gmail.com, msysGit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Wed Jan 26 23:18:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiDhE-0000wl-Kn
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 23:18:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753545Ab1AZWSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 17:18:31 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55591 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab1AZWSa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 17:18:30 -0500
Received: by iyj18 with SMTP id 18so839999iyj.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 14:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=svFEUA2pG+19C71wQPL7UIlMavit8qfljbmOAZYyaMI=;
        b=qEAgiSRMZRaS2ml6LR0PPq3Yh/5LAUnRsV2jAE3yDVeaFoI8D+AOwNcJ6VFHN7jDOm
         F+y1Ny0MRVwx9OMZD6i/BHYNYi7FIFhwogWVRgfy0QJgCKiFE7kvrbzAOEn/xLZnP3iV
         FaK2nVXip9+FnAxmvdLHRbhog/R+gEs36Ayrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=LG9bqxb+zCjeIh/UbJT8CIzgkGuSBGgTRiSKGkjOO4OA9Afw6L8fDFgF0vD/qEFcSm
         HORgCHDtI9w+FroLcsoc0Klj8FnY+XmFvT1lITFHzO00bJQSLJdcJxZhb/lTjHWyThim
         6NvCyoOqHldcHb9OlX0dmuHTWplRghAjI7pHI=
Received: by 10.231.12.131 with SMTP id x3mr19389ibx.76.1296080309885; Wed, 26
 Jan 2011 14:18:29 -0800 (PST)
Received: by 10.231.8.215 with HTTP; Wed, 26 Jan 2011 14:18:09 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1101262244550.14066@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165558>

On Wed, Jan 26, 2011 at 23:00, Daniel Stenberg <daniel@haxx.se> wrote:
>> curl/openssl 0.9.8k <-> apache/openssl 1.0.0 -> error
>
>> I'm not sure what to take away from this. Maybe it's a problem that is
>> partly caused by both apache and curl?
>
> Could be. I just have a hard time to see why code in curl that has worked
> for so many years suddenly would stop working. It just so feels like else
> changed.

Well, it's definitely a possibility that neither Apache nor Curl are
at fault but OpenSSL. The strange thing is that I could not produce
any failure with the OpenSSL command line tool. But that doesn't mean
that openssl is completely innocent.

> This error (or something similar to it) is often seen when we try to talk
> plain HTTP to a HTTPS server or vice versa. Did you verify that HTTPS was
> working fine on that port when you ran the OpenSSL 1.0.0 version of the
> server?

No, it definitely worked before with curl/openssl 1.0.0 and all kinds
of browsers. Also, as I wrote, it worked with the OpenSSL 0.9.8k
command line tool.

> Perhaps it is possible to add verbose level and further debug log stuff in
> the server to see what makes it suddenly decide the handshake is bad.

I didn't find much in this direction in the apache docs, unfortunately...
http://httpd.apache.org/docs/2.2/mod/mod_ssl.html

Next thing I'll try is to check whether I can reproduce this using a
different distribution that also uses OpenSSL 1.0.0. I'll let you know
when I have the results...

Best,
 Mika
