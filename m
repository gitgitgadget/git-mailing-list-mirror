From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] compat: helper for detecting unsigned overflow
Date: Thu, 10 Feb 2011 13:11:17 +0100
Message-ID: <AANLkTinqkSxj0C+GyMVR4a7d=yy_mh+oDuar0moZjZ8_@mail.gmail.com>
References: <1286263450-5372-1-git-send-email-kusmabite@gmail.com> <20110210093536.GB365@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>,
	Jeff King <peff@peff.net>, Nicolas Pitre <nico@fluxnic.net>,
	Pierre Habouzit <madcoder@debian.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 10 13:12:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnVNU-00023n-Tt
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 13:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709Ab1BJML6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Feb 2011 07:11:58 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35937 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755928Ab1BJML6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Feb 2011 07:11:58 -0500
Received: by yxt3 with SMTP id 3so543824yxt.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 04:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=4bO60AugmlGnHsQXY4ga4u7ea9jtG2F+EhO9PD9o7Wo=;
        b=tBIzCJG+9UyX1PE+Qisqa6AcqKgUvnKTfjuNa+lHUwXNxoNFKikYsue4k6QXKEWf0l
         kOeUHqjI1EQzOCXwWV/sygoVyfQ4ov8MAbI/P1GBtGRror7x4cS3TMl7n8pp7ulfKC/N
         McjOGCmjSQqDXIzd4WVaAp7Tb+QjpJC2We49A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ubIUvB0TrkBMyQ+Eg5xrioyOD0T8/tIvpERTT7h/AujrP7m43LsMXMqLP0vBaLKVeI
         H+zfdkRnrv3mcihDI36JBSU/8EJciakToVh5z+WwhETzPAklQabNEIOc0pMmgS5RF+HO
         JnRkxyTA9ruMwaIGIc2XjCoUbUn2zfGXzQz8E=
Received: by 10.150.52.6 with SMTP id z6mr3131939ybz.340.1297339917213; Thu,
 10 Feb 2011 04:11:57 -0800 (PST)
Received: by 10.150.51.6 with HTTP; Thu, 10 Feb 2011 04:11:17 -0800 (PST)
In-Reply-To: <20110210093536.GB365@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166480>

Heya,

On Thu, Feb 10, 2011 at 10:35, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
>        unsigned_add_overflows(a, b)

> Define such a macro, expanding roughly to ((a) < UINT_MAX - (b)).
> Because the expansion uses each argument only once outside of sizeof(=
)
> expressions, it is safe to use with arguments that have side effects.

> +#define unsigned_add_overflows(a, b) \
> + =C2=A0 =C2=A0((b) > maximum_unsigned_value_of_type(a) - (a))

I'm confused, you say you won't use it twice, and then you do use it tw=
ice?

--=20
Cheers,

Sverre Rabbelier
