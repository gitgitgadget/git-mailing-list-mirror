From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 24/25] gettextize: git-status basic messages
Date: Thu, 2 Sep 2010 15:47:21 -0500
Message-ID: <20100902204721.GF2531@burratino>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
 <1283456446-22577-25-git-send-email-avarab@gmail.com>
 <20100902202846.GD2531@burratino>
 <AANLkTin1ew1nXLwEoyMqMRkZpr6xq2rebRDmVVgA2BLr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 22:49:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrGil-0005uT-Py
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 22:49:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120Ab0IBUtM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 16:49:12 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49742 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab0IBUtL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 16:49:11 -0400
Received: by mail-fx0-f46.google.com with SMTP id 13so623692fxm.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 13:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xbKjE134vqnoKyqY0ggaSu3/GjewV+fKie0hJLpLQGM=;
        b=tCIIcTnuk3OnlWsb3MX70ckXhfXtbhaduFNONx3QGGZKK2VVacNksb4D6QRZQOqcla
         bB4vUEaBrJJAdKvKmmqQu6knO3STWhK+VCc21INTWtCK2CsrPSj+DgQnVgpGSOUNsjGc
         tla1saskhrHJjxkwZ7nDVNqRWjRqxibHFA4a4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=XWuiOK9eO8xKyFu6t2bF1oVBn/JZir25SsCjfp+gQNjHUk4vdJf7Neo897uYyhUnYO
         CPfMaMvj3ihifXXZ+AgWkusms2mpF2yfgX3f1b6WRk8tCJ+Iiv53zr4FMkSxwvER0JPS
         u+FM5QxyvwK6crjtfTozyq2KqPiA87Xu/3+zs=
Received: by 10.223.112.212 with SMTP id x20mr7730793fap.89.1283460550456;
        Thu, 02 Sep 2010 13:49:10 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u8sm483901fah.12.2010.09.02.13.49.08
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 13:49:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTin1ew1nXLwEoyMqMRkZpr6xq2rebRDmVVgA2BLr@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155205>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Maybe, but my current mode of operation is "do it really simple and
> stupid now, solicit complaints later".
>=20
> Eventually I'd rather just eliminate the need for tweaking stuff like
> that by having some va_args function that spews out "16" for that
> given a bunch of arguments, i.e. (pseudocode):
>=20
>     int width =3D gimme_longest(
>         _("both deleted:"),
>         _("added by us:"),
>         _("deleted by them:"),
>         _("added by them:"),
>         _("deleted by us:"),
>         _("both added:"),
>         _("both modified:")
>     );
>=20
>     char *fmt =3D concat("%-", width + 4, "s%s\n");
>     printf(fmt, ...)

Using %-*s%s like that does sound nice, but then I have to wonder
about the 4.  Maybe the space-constrained translator would want to
decrease the margin to 2.

Which is why "when the output is intended for humans, let translators
do whatever they want" seems to me like the simplest principle to
follow.  But you're right that it doesn't matter much and we can
always wait for bug reports.
