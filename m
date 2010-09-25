From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC/PATCH 0/3] fast-import: give importers access to the object store
Date: Sat, 25 Sep 2010 02:17:09 +0200
Message-ID: <AANLkTin_DvzhXSaT62Lr7D_CxD9V0vcaYE3u9PoQYZ+o@mail.gmail.com>
References: <20100701031819.GA12524@burratino> <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes> <20100905031528.GA2344@burratino>
 <1284596048.3298.3.camel@wilber> <20100924194313.GA8114@burratino>
 <AANLkTinsotbGpg1LAXA+UchBHQrBK12tkX+o4tOFWUOF@mail.gmail.com> <20100925000156.GA23735@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sam Vilain <sam@vilain.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 02:17:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzISP-0000Ku-AM
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 02:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754281Ab0IYARb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Sep 2010 20:17:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58095 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab0IYARa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Sep 2010 20:17:30 -0400
Received: by ywh1 with SMTP id 1so1143074ywh.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 17:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=gp74uGYfQE5wPNLg1DkUgn08TgP2pgvl92zleru8K5o=;
        b=nC+fmHIUWygTFr1a6hp/jYIg4GZeq/OLOe6CfmcH9bIQoB3x2irwC5b8KCc+5x3pum
         061JzZJEn9NwOaOvjcy2+tiAD9rM6irtWSNytvHQRpIQ7+2XRLPi3OS5c1Razk6jBhNV
         PO6UaL5nSw8OhDZzfYAI06TxDh6QlHTJTSvvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=fJ/d0DOxnzesTNgRrkc/G4+w/RUtI6Pv+qSC2qZyTsxX9USpvnuHT9nAQR3z27u7dQ
         u+mk3J6q7p7lH3Rsal0uWRkKv2TVEyyB+tvna/WMrFLiYUkoFVDjcS10WwyWJ09xfmwC
         D+NG34DVojnQ/FNnu5JqU++3jPq0of9Jc6E9E=
Received: by 10.150.11.20 with SMTP id 20mr5441893ybk.407.1285373850090; Fri,
 24 Sep 2010 17:17:30 -0700 (PDT)
Received: by 10.151.82.3 with HTTP; Fri, 24 Sep 2010 17:17:09 -0700 (PDT)
In-Reply-To: <20100925000156.GA23735@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157105>

Heya,

On Sat, Sep 25, 2010 at 02:01, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> I was thinking of a frontend that reads or writes the marks
> file itself, but import/export-marks features can also be used to jus=
t
> save/restore marks opaquely.

That's exactly what git-remote-hg does :). The hg exporter and
importer doesn't care about where git stores it's marks. As long as
they both use the same marks it all works.

> Thus I have no precedent to fall back on. :)

Seems like it.

> Yep, that would work. =C2=A0Still I don't think it makes a lot of sen=
se to
> allow "feature report-fd=3D4" in the fast-import stream. =C2=A0If I c=
an
> ensure that fast-import has file descriptor 4 mapped to the right
> place, then I am in control of the process that starts fast-import, s=
o
> a command-line option would be easy enough to use, no?

True. Perhaps some more input from others would help.

--=20
Cheers,

Sverre Rabbelier
