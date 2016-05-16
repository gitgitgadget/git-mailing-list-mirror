From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 5/5] pathspec: record labels
Date: Mon, 16 May 2016 12:03:06 -0700
Message-ID: <CAGZ79kaV+hQRn6ZraZcG9ZRp1XwPGrEFibBEX5qFJdWDCg0uxQ@mail.gmail.com>
References: <20160513231326.8994-1-sbeller@google.com>
	<20160513231326.8994-6-sbeller@google.com>
	<xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZsVH3mE0zXu9wSWgit3QZ_CiKZqg-TQdyWnZw6D9=Cgw@mail.gmail.com>
	<xmqqlh393nuv.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbN_pzAVeAa-St_KRs60SbURTfKKP0v+do_+MK7orTkTg@mail.gmail.com>
	<xmqq8tz93kf9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 21:03:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2NnO-000293-6M
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 21:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334AbcEPTDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 15:03:09 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34327 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754199AbcEPTDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 15:03:08 -0400
Received: by mail-io0-f169.google.com with SMTP id 190so221881018iow.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 12:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=hVjFCUqKFAISmQi1OLwd+j7pnD0D5PP3xV/wKJIME5s=;
        b=IgsWhTHV0LWJ1CJ+lZbN58ucJPGQ5ZODYEYLjMAPZDyeGkPOSCo8SEBtP1xgZATMJs
         kHQqnSKzsKLx1H05m5gUkXROBqzHu0N3TxCOwSonzwN5z5iWWgWxD6Rtw/KJDk74oPEn
         mXxxh89BuvZ9jPOW5b5szos1r3PNkVkfrRTgG3c5GphLoD63l7+Ds0zqIZd4xqKAivVy
         QOEk/5NRmiPVBv8bv7sYitpeZ842FSPsWYqcqoCsU+pdp4yBmDA7vtRPQCgo2Guq0xMx
         oTLcOv0rGfCpsvfTawvj8f2pnaUc6f6cWKtgut9m+8yduZTf17gQMenNLhRPTW0VDDYQ
         wXyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=hVjFCUqKFAISmQi1OLwd+j7pnD0D5PP3xV/wKJIME5s=;
        b=iJtIDraunk+rs8IXHOlBAz4nt46znLEnWgSfhGrstwzHdiy14gEEH4iTAPwcGuS/sK
         2Yq45a6+d1UfhmMTQrOm/V4uU6NiQCpS9p1Lt4k3cM/AFH9DiVKKgb1ZsPVC9ygLjWuU
         rS5DqbAo3osOS3PVyTHRyBo7zNPODnfSnmRD6gK41Vx8ebwUKjYHjqwPyLVjsLJtao/t
         ikmdn+YxEurFAXTaX7OQNUQY4/Bc6tfNgAwtQxPhesMi5YSj5+Wp/OAwCwsE2Wic9Qw8
         RyzHn19JyKl5N0XC+321Uf3Zm2zLNauSJqzfnYQY8WuXoBcyjfVnr+9gHXf84iEKlw4R
         +0bQ==
X-Gm-Message-State: AOPr4FWMf2UxSd0Y3RZ6SzTxBLIJ7Lt9wWWFlgwJabZDYjLCk7WF0awcigabyuX8zUKskqKW40uWGTIow3mZzJ62
X-Received: by 10.107.53.204 with SMTP id k73mr20186633ioo.174.1463425387060;
 Mon, 16 May 2016 12:03:07 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 12:03:06 -0700 (PDT)
In-Reply-To: <xmqq8tz93kf9.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294778>

On Mon, May 16, 2016 at 11:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So "warn and ignore" for data from .gitattributes and die for
>> commandline arguments? That makes sense.
>
> Yes.
>
> On the "command line" front, because we may want to give different
> meanings to these two entries in the future:
>
>         :(label=-doc)Documentation/
>         :(label=!doc)Documentation/

Yes but both of these already errors out with:

    Label -doc': Label names must start with an
    alphabetic character and use only alphanumeric
    characters, dashes and underscores.
    fatal: Labels in the wrong syntax are prohibited.

The command line arguments are not parsed via the attr system.
Only data from .gitattributes are parsed via the attr system.

I can add tests for those to fail though.

>
> we should diagnose -doc (FALSE) as an error, not treating it as the
> same as !doc (UNSET).  And we should warn and ignore -doc (FALSE) in
> .gitattributes.  Yes, ignoring it would be more or less equivalent
> to treating it as UNSET, but because we may use -doc (FALSE) for a
> better purpose later, we should still warn.
>
>> Ok, so here is the warn-and-ignore code:
>>
>>
>>         if (ATTR_TRUE(check.value))
>>                 ret = 1; /* has all the labels */
>>         else if (ATTR_FALSE(check.value)) {
>>                 warning(_("Path '%s': Label must not be false. Treat
>> as if no label was set"), path);
>>                 ret = 0;
>
> s/Treat as if .../The -label may be used differently in future
> versions of Git, so do not use it/;

"... but for now Git treats it as if it is not set at all" is a valuable
information to the user, still?

That code path is only used for data coming from .gitattributes,
so we can bike shed the best warning message.

>
> But if we are going in the direction of :(attr:crlf=auto), all this
> discussion is moot, isn't it?  I haven't formed a firm opinion on
> this, but it sure does sound tempting, doesn't it?
>

That direction sounds scary as people may use any sort of labels, so
we can no longer add labels later on sanely.

    :(attr:random-attr=foo)

should also fall into the "warn and ignore" space. We only want to allow

    :(attr:known-attr)
    :(attr:label=..)

instead of label= we may want to allow a little bit more, such as
abbreviated  'l='
or 'group=', but not any sort of labeling.
