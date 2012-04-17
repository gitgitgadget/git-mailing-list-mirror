From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH i18n 01/11] Add three convenient format printing functions
 with \n automatically appended
Date: Tue, 17 Apr 2012 10:12:20 +0200
Message-ID: <CABPQNSbnGKFW=Lf0nnLEOAZf4iOGsmfiMqoioitH3Ps6ZWV7FA@mail.gmail.com>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com> <1334580603-11577-2-git-send-email-pclouds@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 10:13:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK3XB-00065o-Np
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 10:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147Ab2DQIND convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Apr 2012 04:13:03 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47152 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748Ab2DQINC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Apr 2012 04:13:02 -0400
Received: by pbcun15 with SMTP id un15so7358011pbc.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 01:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=86vT7vn5EUTjcbe+pYxedMkrCL6zqHHTIVQu8wFk90I=;
        b=w4KXq6RdC69oeg5Aj0lVcMSPUgpvHtaZeHaWvzwKwossfVWDHE2G+1zjC1KB7hhFcM
         R1jxWB/3x9glrXs0PK3GfYBCKSoop+yJPvQr9/47NpBRvsvVQVmdSDS6OQ9rS3E7gN8a
         hKdERTxLpYsxeOPO0Gkr26CXhv3DtHC0fU3tzLePXcalnyRy4lLZ0zpvZ1eOdyDewbC0
         91LX3J01j1JWVgQYd+SPvECJzjSeVHqzVc3RR3q+F7zpuOMEfrrjxS1G1DC2tsJsFT9U
         A1xMADowCVDnXAqmeYrop3m9VUXDouUpj0YmVJIiswNlbQYeudIl3DUeXTbvp9OYIFu2
         11uA==
Received: by 10.68.216.6 with SMTP id om6mr35048622pbc.117.1334650381152; Tue,
 17 Apr 2012 01:13:01 -0700 (PDT)
Received: by 10.68.129.67 with HTTP; Tue, 17 Apr 2012 01:12:20 -0700 (PDT)
In-Reply-To: <1334580603-11577-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195743>

2012/4/16 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> +int printf_ln(const char *fmt, ...)
> +{
> + =C2=A0 =C2=A0 =C2=A0 int ret;
> + =C2=A0 =C2=A0 =C2=A0 va_list ap;
> + =C2=A0 =C2=A0 =C2=A0 va_start(ap, fmt);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D vprintf(fmt, ap);
> + =C2=A0 =C2=A0 =C2=A0 va_end(ap);
> + =C2=A0 =C2=A0 =C2=A0 if (ret >=3D 0)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D printf("\=
n");
<snip>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret +=3D fprintf(f=
p, "\n");

Apart from Jonathan's comment, isn't [f]printf a big hammer for this?
Wouldn't putchar / fputc be a tad more light-weight (and perhaps
clearer)?
