From: He Sun <sunheehnus@gmail.com>
Subject: Re: [PATCH] parse-options.c:parse_options_check() change
 OPTION_NUMBER to OPTION_CMDMODE
Date: Sat, 1 Mar 2014 07:40:18 +0800
Message-ID: <CAJr59C0jKYcee_wfzTrv+pg51DGuBKekeC9iz0TF_wzAuKjs7w@mail.gmail.com>
References: <1393578442-2822-1-git-send-email-sunheehnus@gmail.com>
	<531061D1.2060206@alum.mit.edu>
	<xmqq1tynuiqh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 00:40:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJX2Z-0000o6-Ks
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 00:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbaB1XkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 18:40:22 -0500
Received: from mail-we0-f179.google.com ([74.125.82.179]:53530 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbaB1XkT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 18:40:19 -0500
Received: by mail-we0-f179.google.com with SMTP id x48so1091957wes.24
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 15:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=ukMz9JjLhuqBHTATWZ6aI0VIpWlm3G+jWw2d21z/5Z4=;
        b=RmiZcJBUizrHAYEL4W6DvYh+qHuuEw2xIwzxcME2ns5G0hY+eXJoOhNgkmF33pyy0f
         ClFXfphSQAp6zJDWzEkxrXIYZ+ORS3xU31BhA2HShyk7wZNBOvRykT4FkgDOBRkZaMBZ
         lqgSbaXLFCTr4Ko/lJRKomodxtCNeFQFC23qrNg6vvOwcMvsCUkXd64Khh9OytrVXpac
         PgKK6AhGIZc3zzG2GNTKcZomwumRgD/h8h8xbEog8VuCmd91KZKOb2sgGu8xz+v4ctpY
         yfgAC5+TSa70uoqN6jnsNAZ6lgSxq3nYKqa3tXfGfkWACZNA4KGyOwCja0xdJ7cZpO6a
         FqcQ==
X-Received: by 10.194.63.103 with SMTP id f7mr5261840wjs.38.1393630818834;
 Fri, 28 Feb 2014 15:40:18 -0800 (PST)
Received: by 10.216.203.69 with HTTP; Fri, 28 Feb 2014 15:40:18 -0800 (PST)
In-Reply-To: <xmqq1tynuiqh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243029>

2014-03-01 3:42 GMT+08:00 Junio C Hamano <gitster@pobox.com>:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> On 02/28/2014 10:07 AM, Sun He wrote:
>>> Signed-off-by: Sun He <sunheehnus@gmail.com>
>>> ---
>>>  parse-options.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/parse-options.c b/parse-options.c
>>> index 7b8d3fa..59a52b0 100644
>>> --- a/parse-options.c
>>> +++ b/parse-options.c
>>> @@ -371,7 +371,7 @@ static void parse_options_check(const struct option *opts)
>>>              case OPTION_NEGBIT:
>>>              case OPTION_SET_INT:
>>>              case OPTION_SET_PTR:
>>> -            case OPTION_NUMBER:
>>> +            case OPTION_CMDMODE:
>>>                      if ((opts->flags & PARSE_OPT_OPTARG) ||
>>>                          !(opts->flags & PARSE_OPT_NOARG))
>>>                              err |= optbug(opts, "should not accept an argument");
>>>
>>> --
>>> 1.9.0.138.g2de3478.dirty
>>>
>>> Hi,
>>> When I was reading code yesterday, I came across this protential bug.
>>> parse-options.h says that OPTION_CMDMODE is an option with no arguments and OPTION_NUMBER is special type option.
>
> Please, no overlong line in the text part that makes things
> unnecessarily hard to read.
>
> I agree with all the comments in the message I am responding to.
>

OK, got it. Thanks.

>> BTW, none of my comments should be taken to indicate whether the commit
>> itself makes sense or not.  I haven't checked that far.
>
> While I think it is sensible to make sure CMDMODE is not marked to
> allow arguments, I do not understand why "special type" would imply
> "it is allowed to be marked to take an argument".  Why is it a
> good change to remove "case OPTION_NUMBER:" here?

The comments in parse-options.h (Line 10-16) says that CMDMODE is not
marked to allow arguments. And I am not sure if removing OPTION_NUMBER
is a proper way.
