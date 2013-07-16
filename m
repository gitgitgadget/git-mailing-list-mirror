From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 4/5] config: improve support for http.<url>.* settings
Date: Tue, 16 Jul 2013 06:01:37 -0400
Message-ID: <CAPig+cQnm6=YEKLd-LBhsrUH75Lnn9whjS3KeZMaNVRMWAS2RQ@mail.gmail.com>
References: <506e5f642a838b95e0dd5b1f0fa1cfe@f74d39fa044aa309eaea14b9f57fe79>
	<dcbaa11c8595f48814aa39a75ad18ea@f74d39fa044aa309eaea14b9f57fe79>
	<CAPig+cQTNXgPyD4qiQPyQeSHWY0Y=_Qnd2i9LfVqQDA1DJNDxg@mail.gmail.com>
	<4D163C69-2228-4895-AE47-377A5A71FD5E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>,
	Petr Baudis <pasky@ucw.cz>, Junio C Hamano <gitster@pobox.com>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	=?ISO-8859-1?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 12:01:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz24l-0000Pr-Ue
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 12:01:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754260Ab3GPKBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 06:01:40 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36131 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166Ab3GPKBj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 06:01:39 -0400
Received: by mail-lb0-f171.google.com with SMTP id 13so433717lba.2
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 03:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=/oxwhBn6W6pVSbUjJVH6bSt1/dhwplhlNvN3iZ9/D+o=;
        b=0+XlbmKgTGAcAE61VtwRVWfX/Y+fu23wGHP50UjJM7hslUIpIcFoT32vtGziXgasou
         CFAViJFUBz784N5lpA+tSiFK46E6yGdCzVOIoLQw/IergcCcf54thId8bsqGT0ENKm3i
         RTl/f4FFI2b1Zh20VD1lo5L4Ayv8fOitrfQIhWPPBXRkRGEGC+KBAfNQppXtPFsuV1sI
         z05OF5bEvMDa2xa1fXgOfW4pfxSFp25FmptAreTbvvTZTC8mVX6RgBohMH567211RAWN
         HDZb+zM+ICImfxhl6Hm5d78qS695zPoe+j2y4gclblcK7G3lMAMcdlRZwPx+2zHF08af
         vsoQ==
X-Received: by 10.112.19.162 with SMTP id g2mr798063lbe.9.1373968897887; Tue,
 16 Jul 2013 03:01:37 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Tue, 16 Jul 2013 03:01:37 -0700 (PDT)
In-Reply-To: <4D163C69-2228-4895-AE47-377A5A71FD5E@gmail.com>
X-Google-Sender-Auth: nE5X9rOmbFkUY9qNlLqM6_VTnxU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230559>

On Tue, Jul 16, 2013 at 5:53 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
> On Jul 15, 2013, at 16:12, Eric Sunshine wrote:
>>
>> On Mon, Jul 15, 2013 at 5:51 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
>>>
>>> +static int append_normalized_escapes(struct strbuf *buf,
>>> +                                    const char *from,
>>> +                                    size_t from_len,
>>> +                                    const char *esc_extra,
>>> +                                    const char *esc_ok)
>>> +{
>>> +       /*
>>> +        * Append to strbuf buf characters from string from with length
>>> from_len
>>
>>
>> s/from string from/from string/
>
> Hmmm.  Actually it's meant to say "from string <parameter with name from>".
>
> Do quotes make it read better:
>
>   from string `from'
>
> Or do you think it needs to be:
>
>   from string parameter `from'

Ah, I see now. Thanks for clarifying. Quoting 'from' (and the other
arguments) probably would make it sufficiently readable.
