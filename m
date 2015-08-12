From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH] http: add support for specifying the SSL version
Date: Wed, 12 Aug 2015 16:10:40 +0200
Message-ID: <CA+EOSBn8xXHEXSwZ3sqcs8AaLQfDNw-5bSJSv-gwwGpaH4VW9w@mail.gmail.com>
References: <1439384456-16335-1-git-send-email-gitter.spiros@gmail.com>
	<950187984.739852.1439386399510.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 12 16:10:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPWju-0007wp-RD
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 16:10:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbbHLOKm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Aug 2015 10:10:42 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33454 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbbHLOKl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Aug 2015 10:10:41 -0400
Received: by vkbc123 with SMTP id c123so6340435vkb.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 07:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CbyfINCDOlpeF14yrGN/9fRgeK/OepABha31W2BxvsA=;
        b=efjO4GMgw2ik9OOIAQUBCtRXZqbMSI5ujFgFHizd4HC0Pb0aMpR5UgirXq676hVYKu
         Q1ANrByVxLM3Ix618UO8XqBxqBiONAEV2UBu6m0nCLXY0i8Z0FND6E4lj5PReV/7v4nM
         D5QNMCHNjK3iTRVeqV0Kni5J9Za4sVBMWozFIDM1rwfB076R+qExaufQoalN8CsH5Ibg
         s8X772qv9Ln1SEMOEDy7IKmjdakrommXM9TEOGwiw/mPzUsuA+LkU5+vXOuIHzss1bCp
         jJsRQKGcr/luZmiJLEQCXRdSIc3iRBQcdiTfD3xDXM+T2WPRRQ859NTs5b5vZwpkFW/R
         dVOw==
X-Received: by 10.52.135.112 with SMTP id pr16mr42470547vdb.53.1439388640663;
 Wed, 12 Aug 2015 07:10:40 -0700 (PDT)
Received: by 10.31.16.146 with HTTP; Wed, 12 Aug 2015 07:10:40 -0700 (PDT)
In-Reply-To: <950187984.739852.1439386399510.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275768>

2015-08-12 15:33 GMT+02:00 Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr>:
> Hello, Elia
>
> Elia Pinto <gitter.spiros@gmail.com> writes:
>> +        if (ssl_version !=3D NULL && *ssl_version) {
>> +                if (!strcmp(ssl_version,"tlsv1")) {
>> +                        sslversion =3D CURL_SSLVERSION_TLSv1;
>> +                } else if (!strcmp(ssl_version,"sslv2")) {
>> +                        sslversion =3D CURL_SSLVERSION_SSLv2;
>> +                } else if (!strcmp(ssl_version,"sslv3")) {
>> +                        sslversion =3D CURL_SSLVERSION_SSLv3;
>> +#if LIBCURL_VERSION_NUM >=3D 0x072200
>> +                } else if (!strcmp(ssl_version,"tlsv1.0")) {
>> +                        sslversion =3D CURL_SSLVERSION_TLSv1_0;
>> +                } else if (!strcmp(ssl_version,"tlsv1.1")) {
>> +                        sslversion =3D CURL_SSLVERSION_TLSv1_1;
>> +                } else if (!strcmp(ssl_version,"tlsv1.2")) {
>> +                        sslversion =3D CURL_SSLVERSION_TLSv1_2;
>> +                } else {
>> +                        warning("unsupported ssl version %s : using=
 default",
>> +                        ssl_version);
>> +#endif
>> +                }
>> +        }
>
> I'm curious about what would happen should 'sslVersion' be set to
> 'tlsv1.0' (or a value that doesn't belong to the possible values) and
> 'LIBCURL_VERSION_NUM' be inferior to '0x072200'.
> Since we wouldn't go through any 'if' and would also skip the 'else'
> case, wouldn't we have a silent 'unsupported ssl version: using
> default' ?
You are right. I will resend. Thank you very much
>
> So I think that the 'else' case should be outside of the '#if [...]
> #endif'.
>
> Thanks,
> R=C3=A9mi
