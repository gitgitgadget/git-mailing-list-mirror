From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Sun, 8 May 2016 17:30:11 +0200
Message-ID: <CAP8UFD1PqU+WeuDp0f0_yyrYsGt=qwbkTUXji4_DJiJoGf_nJg@mail.gmail.com>
References: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-1-git-send-email-pranit.bauva@gmail.com>
	<1462546167-1125-2-git-send-email-pranit.bauva@gmail.com>
	<alpine.DEB.2.20.1605080858190.4092@virtualbox>
	<CAFZEwPOy5avk=3WKj0AdP-j7Ump4ie90+CeFTj6K83EMj-pQQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 17:30:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azQf4-0004wL-SL
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 17:30:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbcEHPaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 11:30:15 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36208 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbcEHPaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 11:30:13 -0400
Received: by mail-wm0-f42.google.com with SMTP id n129so109455218wmn.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 08:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=j9KQ/ba0WljXR+9yy3rdq0YDK/6K5WPFV9wD8DZBq8c=;
        b=NYKBtHUH9DsEaEev2M9RWa9X2i83mY9QaxPggcPopqXLaeL6mzzkM2ZvqYRjStzC5B
         wdpbbFx7DJlB6Ou6Bx/c52h9cnIEDyI1B+3Q9fLRK3EleP4u0pioGW2uqpU3+fYpbsoF
         MGb+zVU2+7rims0mz4IqnVxkf63Yrsl6gnm8tQavwgk9tz3wJqVpb2Z+QGVJah+GbY1r
         xQwTVsHxyUcziXdQi8ku+2O4GFRTBpy+6pz29nryLdL2FH+zTmpSoqPblAoHSRISVpl7
         9bFoywkqaiyf7ap2MWoEjOHlGiOFrNZTYiBd/6SnUBTGKJ1s2UahiUbb3NOPKGSEnfIG
         n4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=j9KQ/ba0WljXR+9yy3rdq0YDK/6K5WPFV9wD8DZBq8c=;
        b=e7Ba/GLsl5S+ZWs0eoVOC7Ng4KcvURK1HkonTzwPo1k/lFNEkjiXAgZXpMnilH2eDJ
         uIIbggh3RKEoTZo89viiKilomiNAgcpvr//7/YeBIW0DY+d/3/63S/BYfIVwoyINAytO
         gb+B0awGnKxbnY5OrWpA9WYG9+zd8YbBhAqugjYzkVRimfwuUhJ3iH8hDmqIghPuZYpa
         s9tO0rBmc8PW8no6BJWjW4RHWtc17uJeqYaqkhQe1aFxOR8K8DhEOaU8rPEi9dRSn5o0
         xKf7dNdD2s74nrKhl4torhVsazCjO35WUset/mam/dl63tJM6ABSCY038FA5v2b4VV4e
         O67A==
X-Gm-Message-State: AOPr4FXlLOt/hAZSTG0q7yGu5EpGniOQrN3ERugL4oGMqJgB3lLMAsXahjuMp0wOttiB9N327jwUrFIbqzQK9A==
X-Received: by 10.195.17.166 with SMTP id gf6mr28987585wjd.124.1462721412008;
 Sun, 08 May 2016 08:30:12 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Sun, 8 May 2016 08:30:11 -0700 (PDT)
In-Reply-To: <CAFZEwPOy5avk=3WKj0AdP-j7Ump4ie90+CeFTj6K83EMj-pQQA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293968>

On Sun, May 8, 2016 at 9:17 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Sun, May 8, 2016 at 12:34 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi Pranit,
>>
>> On Fri, 6 May 2016, Pranit Bauva wrote:
>>
>>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>>> index 3324229..d8de651 100644
>>> --- a/builtin/bisect--helper.c
>>> +++ b/builtin/bisect--helper.c
>>> @@ -8,13 +8,17 @@ static const char * const git_bisect_helper_usage[] = {
>>>       NULL
>>>  };
>>>
>>> +enum subcommand {
>>> +     NEXT_ALL = 1
>>> +};
>>
>> I still do not think that this enum needs to have file scope. Function
>> scope is enough.
>
> In the very initial patch I made it in function scope. To which you
> pointed out[1] that in all other examples but for one have file scope
> so then I thought maybe that exception was a wrong example and I
> should stick to the convention of putting it in file scope.

In the message Dscho wrote:

"Interesting. I did not think that Git's source code declares enums inside
functions, but builtin/remote.c's config_read_branches() does, so this
code is fine." So you didn't need to put it back in file scope.

Please don't change things when you are told they are fine unless
there is a good reason like a bug and in this case explain the reason.

> But now I
> also realize that builtin/replace.c uses "cmdmode" instead of
> "subcommand" so I am still wondering what would be the most
> appropriate?
>
>>>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>>>  {
>>> -     int next_all = 0;
>>> +     int subcommand = 0;
>>
>> Since subcommand is not simply an integer, but wants to take on the values
>> defined in the enum above, the type should be changed accordingly. You
>> could do it this way (short and sweet, with the appropriate scope):
>>
>>         enum { NEXT_ALL = 1 } subcommand = 0;
>>
>> See https://github.com/git/git/blob/v2.8.2/builtin/replace.c#L423-L430 for
>> an example (which uses "cmdmode" instead of "subcommand", too).

Yeah, please use "cmdmode" as Junio already suggested and do it like
in the example that Dscho points to.

Thanks,
Christian.
