From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/10] i18n: mark relative dates for translation
Date: Wed, 25 Apr 2012 18:29:15 +0700
Message-ID: <CACsJy8DEOLTybnmy+_PNdKvR6pVjtxA2+xC8sND8tMfUgw-b4Q@mail.gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 <1335184230-8870-4-git-send-email-pclouds@gmail.com> <xmqqd36wgam5.fsf@junio.mtv.corp.google.com>
 <CACsJy8Ae_9wEoNmP81Gqu5kOMGrEKSN9PMvoRXbKh8TnwGVt0A@mail.gmail.com> <4F97DAE4.4070706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 13:30:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN0QG-0001hd-Db
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 13:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759040Ab2DYL37 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 07:29:59 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:41567 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758992Ab2DYL3r convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2012 07:29:47 -0400
Received: by wibhj6 with SMTP id hj6so4937212wib.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fZ+PPsC0PK6kg29TkraNJhFJ/WaCOTOXpF9cCCjSfhM=;
        b=fbAuQMKpIQCk/53Vi10M1uOEsmXam7IrPRsgn1djY/67cbEKQVVrWuaDxsp85MbPlD
         4ZENLnLslHEww/5I63r87E5lvcEId5sYTgBErGatxXLs9a40BXsofXG5HJfnejbMrNNw
         Y2e6sQaeYzJwtHJq9CchfBl7BfigCr334M3lzL3y3bY73RLhoCiv/P/DdeE7d/PyHpxf
         9SdMcrBVjOZ19GIuv3Xwqq3HEZBkQC69lgTXfat7kBn9my/Bl7VzD4mZ2mJRpo7c2Nwu
         opVAA7MKGOiS9ud0C4Evr78qbq3QfGI7to6Un7rJs6OSZNAcCvDsL9kfGGOkcJfur3Ie
         yK1A==
Received: by 10.216.135.105 with SMTP id t83mr1387135wei.105.1335353385550;
 Wed, 25 Apr 2012 04:29:45 -0700 (PDT)
Received: by 10.223.16.194 with HTTP; Wed, 25 Apr 2012 04:29:15 -0700 (PDT)
In-Reply-To: <4F97DAE4.4070706@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196310>

On Wed, Apr 25, 2012 at 6:07 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 4/25/2012 12:46, schrieb Nguyen Thai Ngoc Duy:
>> 2012/4/25 Junio C Hamano <gitster@pobox.com>:
>>>> =C2=A0 =C2=A0 =C2=A0 /* Give years and months for 5 years or so */
>>>> =C2=A0 =C2=A0 =C2=A0 if (diff < 1825) {
>>>> ...
>>>> =C2=A0 =C2=A0 =C2=A0 }
>>>> =C2=A0 =C2=A0 =C2=A0 /* Otherwise, just years. Centuries is probab=
ly overkill. */
>>>> - =C2=A0 =C2=A0 snprintf(timebuf, timebuf_size, "%lu years ago", (=
diff + 183) / 365);
>>>> - =C2=A0 =C2=A0 return timebuf;
>>>> + =C2=A0 =C2=A0 strbuf_addf(timebuf,
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Q_("%lu year ago=
", "%lu years ago", (diff + 183) / 365),
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(diff + 183) / 3=
65);
>>>> =C2=A0}
>>>
>>> This is just a tangent, but could we possibly come here and say "1 =
year
>>> ago"?
>>
>> Nice catch. Singular form here is unnecessary. If you plan to revert
>> that, please put a comment so nobody will attempt to convert it to
>> Q_() again next time while searching for possible candidates.
>
> I am sure that there are languages (Russian? Polish?) where a variati=
on is
> needed not only for the singular, but also for plural depending on th=
e
> number, so we still want to have this wrapped in Q_().

Slovenian has special case for one and all numbers ending in 2, 3, 4
[1]. Oh my..

[1] http://www.gnu.org/savannah-checkouts/gnu/gettext/manual/html_node/=
Plural-forms.html
--=20
Duy
