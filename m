From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH v3] http: add support for specifying the SSL version
Date: Thu, 13 Aug 2015 18:33:26 +0200
Message-ID: <CA+EOSB=i6orXCLC4ZyqO5uhH7JPH_6DXHB0yFeXnH77oHgARew@mail.gmail.com>
References: <1439479731-16018-1-git-send-email-gitter.spiros@gmail.com>
	<55CCBF6F.3070808@web.de>
	<CA+EOSBkzU=6pKkqYdGqRRcbbudTJkRwcXxswP+zMshVrZaM_mw@mail.gmail.com>
	<20150813162454.GA18545@LK-Perkele-VII>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:33:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPvRc-0006Dq-Ou
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 18:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbbHMQd2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Aug 2015 12:33:28 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:33144 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbbHMQd1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Aug 2015 12:33:27 -0400
Received: by vkbg64 with SMTP id g64so6842484vkb.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=dl75pRmz6bKPaxaJD4KAl6InnfKk+jato3bjHJ210gI=;
        b=jY0b0CmDQrEJ/uA1PqtUIS+Jx0YhNULPnCr0CwcXg1q1cm0DflyH1qk52FhYt15GuP
         CJ5Ik9HrJxLM/g2aP0cqSTbkalGBIxJFGyQFfAZh5qh69gmIxsp501qv0PVTv7ARtdKM
         1x8jdVtemk3ToGWO4oajFSGnmYUJOdXf8jbTIBW74q2/GJ36G7d8jn/em47d33Bn8JTz
         yp1zjubYbN7TSmRLDeVTAkU3EHQaIkv4gt+GlEhzU9p+OWRKQnoDEDVdLu70GzWmRc1/
         UTMrRw1IMtROAzP67/wyQfTK/ILMrW8OS0/5+hQkLkqKznMN5Wct+dQWO8DBAdYM9YAa
         0euQ==
X-Received: by 10.53.12.229 with SMTP id et5mr47906301vdd.73.1439483607016;
 Thu, 13 Aug 2015 09:33:27 -0700 (PDT)
Received: by 10.31.16.146 with HTTP; Thu, 13 Aug 2015 09:33:26 -0700 (PDT)
In-Reply-To: <20150813162454.GA18545@LK-Perkele-VII>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275858>

2015-08-13 18:24 GMT+02:00 Ilari Liusvaara <ilari.liusvaara@elisanet.fi=
>:
> On Thu, Aug 13, 2015 at 06:10:48PM +0200, Elia Pinto wrote:
>> 2015-08-13 18:01 GMT+02:00 Torsten B=C3=B6gershausen <tboegi@web.de>=
:
>> >> +
>> > from
>> > https://en.wikipedia.org/wiki/Transport_Layer_Security#SSL_1.0.2C_=
2.0_and_3.0
>> > sslv2 and sslv3 are deprecated.
>> > Should there be a motivation in the commit message why we want to =
support them ?
>> They are those provided by the documentation (TLS in particular). We
>> let the underlying library to say what is deprecated or not. In this
>> case the call fail.
>
> The statement from the relevant SDO is much stronger than "deprecated=
",
> it is "not to be used under any cirmumstances".
>
> Option like this looks only useful for connecting to really broken
> servers, damn security.
I know very well this topic.
https://securitypitfalls.wordpress.com/2015/07/29/july-2015-scan-result=
s/
I prefer that the decision is from the libray not us.


>
> It could be useful for connecting to buggy servers after TLS 1.3
> comes out and is implemented, as there are lots of servers (IIRC, on
> order of 10%) that can't deal with TLS 1.3 properly (but very few, II=
RC
> <<0.1%, that can't deal with TLS 1.2 correctly[1]).
>
> Also, is this option settable globally for all HTTP servers? One
> definitely does not want that to be possible. Configurations like
> this need to be per-server if they exist at all.
>
>
>
> [1] Where correctly includes secure downnegotiation, as TLS
> is intended to do when faced with version mismatch.
>
>
> -Ilari
