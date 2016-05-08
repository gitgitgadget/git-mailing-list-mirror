From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v5 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Sun, 8 May 2016 12:47:23 +0530
Message-ID: <CAFZEwPOy5avk=3WKj0AdP-j7Ump4ie90+CeFTj6K83EMj-pQQA@mail.gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-2-git-send-email-pranit.bauva@gmail.com>
	<alpine.DEB.2.20.1605080858190.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 08 09:17:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azIy4-0002kf-3V
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 09:17:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbcEHHRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 03:17:24 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33145 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbcEHHRY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 03:17:24 -0400
Received: by mail-yw0-f196.google.com with SMTP id y6so20859231ywe.0
        for <git@vger.kernel.org>; Sun, 08 May 2016 00:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Vw2YTy4Bjw+cTWsZvtNsJ6P0R3tlNoYQUW7f6FEsOQ8=;
        b=B0tWhjfb0LQmqXmygQ0Iw0CU7O+A3IlTjihGVLhPlwNM8xi9zASibR8DiDt3XNKPJr
         yEYPAkqFTXP/lXBVT8WQof32ZU5kiGGW/kC5zulN/Rbk86RqOOOJoAOMefcsk2dLTAcd
         7YnxjOmC17CDuHqpcUxodOpzCq/E6oQw5bCslYovFHwM1wYbdIrTLfqxipJEFV2k7WQe
         Nv307KfyMmeGs0Zkk8nyP7mmT18hbqqvYa1xx40KClhBCZ9gOP03JDT0sLHk74wOYIt+
         FHeH/SZBWcG4mS+ir5LEJMUYPy0mzbkobBmy4/at2eh//TSPH2B9DAcBn+61PLU3STyc
         LSyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Vw2YTy4Bjw+cTWsZvtNsJ6P0R3tlNoYQUW7f6FEsOQ8=;
        b=eCpJxzj2baEc3J4vfp8WVnSgmOwhxeyluFFWQdz2QtQwB5r14tSu2su+XmMYomc1M5
         p00cyeppJxi3Ceeqp5cVmgX9GH9EHvuWrpGBgPieiJQS4/vww3xad+6T+U0qaMuAUji3
         g2q4JLAfTqBZsRM3ZRxnukrAUCQxC4GH97/SSxLz3OT7U/p76yKf2v0cFtAEtO/WMus7
         2Nl7o+WcO+qwdeu3pLwGSECVxDFUybQbjtufU9ymtopiNMnPmNnY3I1HLskDU7NeHAlM
         K0pQpjExySeHgGOSo1035rirjypMpBhcm2q6ShTExXIQ9kbvT636ZtFk2u75FAEFjOJW
         hjcQ==
X-Gm-Message-State: AOPr4FXVTn5SCnrU0csAEmgHwke+bkhDIQEXILNUfUmLNXIp6wSQsMEjBDUL+6rsXqlUsBVd9GdI/ASa6BTp0Q==
X-Received: by 10.13.221.212 with SMTP id g203mr16873019ywe.68.1462691843304;
 Sun, 08 May 2016 00:17:23 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Sun, 8 May 2016 00:17:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605080858190.4092@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293914>

On Sun, May 8, 2016 at 12:34 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Pranit,
>
> On Fri, 6 May 2016, Pranit Bauva wrote:
>
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 3324229..d8de651 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -8,13 +8,17 @@ static const char * const git_bisect_helper_usage[] = {
>>       NULL
>>  };
>>
>> +enum subcommand {
>> +     NEXT_ALL = 1
>> +};
>
> I still do not think that this enum needs to have file scope. Function
> scope is enough.

In the very initial patch I made it in function scope. To which you
pointed out[1] that in all other examples but for one have file scope
so then I thought maybe that exception was a wrong example and I
should stick to the convention of putting it in file scope. But now I
also realize that builtin/replace.c uses "cmdmode" instead of
"subcommand" so I am still wondering what would be the most
appropriate?

>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>  {
>> -     int next_all = 0;
>> +     int subcommand = 0;
>
> Since subcommand is not simply an integer, but wants to take on the values
> defined in the enum above, the type should be changed accordingly. You
> could do it this way (short and sweet, with the appropriate scope):
>
>         enum { NEXT_ALL = 1 } subcommand = 0;
>
> See https://github.com/git/git/blob/v2.8.2/builtin/replace.c#L423-L430 for
> an example (which uses "cmdmode" instead of "subcommand", too).
>
> Ciao,
> Dscho
[1]: http://article.gmane.org/gmane.comp.version-control.git/289653

Regards,
Pranit Bauva
