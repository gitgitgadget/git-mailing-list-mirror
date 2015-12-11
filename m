From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 2/8] update-index: use enum for untracked cache options
Date: Fri, 11 Dec 2015 10:10:40 +0100
Message-ID: <CAP8UFD3AHMEZB+6Ajt8XSsecTp_PSxV_ZxFLbMAYgA3CDhPDng@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-3-git-send-email-chriscool@tuxfamily.org>
	<xmqq1tawlpqw.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3+gsHZuaBweP83or=rEh-LFnz6=ycBCeuhApxp0PzN1A@mail.gmail.com>
	<xmqqh9jqi1ky.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 10:11:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Jjg-0006GO-0p
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 10:11:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754339AbbLKJLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 04:11:18 -0500
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36770 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbbLKJKm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 04:10:42 -0500
Received: by lfed137 with SMTP id d137so23539484lfe.3
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 01:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=l/LrMC/Ew1xhWvH6yVdzymYk7zbQy22+WCOU/CT7QX0=;
        b=0/NHt5AgoaZPbphBSSNKIznb7MfrBt1u6aMeRvcRcmnukOMQl3Ttvz/uLqSfTpgXgn
         unkt1HkKPBq4Sb7PR2n0tzvLLn3xAmT1f1uqtYCGBwrvDKMSkugI/jCj7Czs+qoj3mRN
         zzEWwGTnTquZCqgKfD6ggl1H4UHrXo/VtwXExy+Jp5pwv5iYE05J35tpZUvzV9uDZIQQ
         A/hCwhE/dHXFGQ/WqSl4B6x64Ddav+X0rsDUHO/kzzGN0quXwfAYddA9UkxdzgYn2GSO
         /XINnff4OMCtVf5EJ6TZGU5eSW9LarpoQie5/MHLm9R+XAVUrj6lz10Uft0LLmbYpA+n
         JmIQ==
X-Received: by 10.25.86.9 with SMTP id k9mr7442007lfb.36.1449825040788; Fri,
 11 Dec 2015 01:10:40 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Fri, 11 Dec 2015 01:10:40 -0800 (PST)
In-Reply-To: <xmqqh9jqi1ky.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282254>

On Thu, Dec 10, 2015 at 7:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>>> +/* Untracked cache mode */
>>>> +enum uc_mode {
>>>> +     UNDEF_UC = -1,
>>>> +     NO_UC = 0,
>>>> +     UC,
>>>> +     FORCE_UC
>>>> +};
>>>> +
>>>
>>> With these, the code is much easier to read than with the mystery
>>> constants, but did you consider making UC_ a common prefix for
>>> further ease-of-reading?  E.g.
>>>
>>>     UC_UNSPECIFIED
>>>     UC_DONTUSE
>>>     UC_USE
>>>     UC_FORCE
>>>
>>> or something?
>>
>> Ok, I will use what you suggest.
>
> As you know I am bad at bikeshedding; the only suggestion in the
> above is to have common UC_ prefix ;-)  Don't take what follow UC_
> as my suggestion.

I am bad at finding names too, so I think what you wrote is pretty good.

I thought about the following:

     UC_UNDEF
     UC_DISABLE
     UC_ENABLE
     UC_TEST
     UC_FORCE

but I am not sure it is much better.
