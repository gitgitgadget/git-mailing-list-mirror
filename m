From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] compat: add a getpass() compatibility function
Date: Thu, 19 May 2011 14:21:30 +0200
Message-ID: <BANLkTinR0F3Pja1DspCGjBsbpgcBhm4=vQ@mail.gmail.com>
References: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Rafael Gieschke <rafael@gieschke.de>
X-From: git-owner@vger.kernel.org Thu May 19 14:21:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN2En-0004Dq-1j
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 14:21:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523Ab1ESMVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 May 2011 08:21:51 -0400
Received: from mail-px0-f173.google.com ([209.85.212.173]:38180 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932345Ab1ESMVu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2011 08:21:50 -0400
Received: by pxi16 with SMTP id 16so1741294pxi.4
        for <git@vger.kernel.org>; Thu, 19 May 2011 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=i2LwHBfI5H3Tj6leEIa0a8jKU9g1lo7DlIlHYl20Mfo=;
        b=oB6O/NUVjTB//xTgaaD3KtqoA/wf9Vv2LJzh7oXDifx8PXCREyQryCuN5sBwWMkakD
         y2NV6Z22JTOvbpidFSoBDT2JmWNXmS/lDRDSoqT/nmon//x+h2zjLSdLKI6ufnoodfR0
         y70al4Gl3/sGgpoGNR/YiQ1syb0J+03R9ODaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=Mt07xb48AZv1bhUBUQELvjMto54BJsL1DyMTFQbbB/SRBVJkuq9/d4NrhWjXBXEXwa
         4HQ3vg/+omEWMViebn4waFSifdOXDyFtjNU1xkfZh21fJ6/CegSHzf0bhwvOdATMBUKw
         WqFXBNBYoobPxy+Jhuj/spxSLlQt5iADld/aI=
Received: by 10.68.29.228 with SMTP id n4mr4499010pbh.500.1305807710365; Thu,
 19 May 2011 05:21:50 -0700 (PDT)
Received: by 10.68.64.229 with HTTP; Thu, 19 May 2011 05:21:30 -0700 (PDT)
In-Reply-To: <563395AE-A3E5-45FF-9063-F807C2CE3AD0@gieschke.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173956>

On Thu, May 19, 2011 at 1:37 PM, Rafael Gieschke <rafael@gieschke.de> w=
rote:
> diff --git a/compat/getpass.c b/compat/getpass.c
> new file mode 100644
> index 0000000..e13f29f
> --- /dev/null
> +++ b/compat/getpass.c
> @@ -0,0 +1,114 @@
> +/* =A0 =A0 $NetBSD: getpass.c,v 1.15 2003/08/07 16:42:50 agc Exp $ *=
/
> +
> +/*
> + * Copyright (c) 1988, 1993
> + * =A0 =A0 The Regents of the University of California. =A0All right=
s reserved.
> + *
> + * Redistribution and use in source and binary forms, with or withou=
t
> + * modification, are permitted provided that the following condition=
s
> + * are met:
> + * 1. Redistributions of source code must retain the above copyright
> + * =A0 =A0notice, this list of conditions and the following disclaim=
er.
> + * 2. Redistributions in binary form must reproduce the above copyri=
ght
> + * =A0 =A0notice, this list of conditions and the following disclaim=
er in the
> + * =A0 =A0documentation and/or other materials provided with the dis=
tribution.

How do we plan to adhere to this clause? I guess all
package-maintainers could explicitly add this to their release notes /
documentation, but they will have to know that they should. I don't
think every package maintainer read every patch in-depth enough to
notice this.
