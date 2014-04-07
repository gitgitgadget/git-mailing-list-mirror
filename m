From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v9 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Mon, 7 Apr 2014 11:39:01 +0200
Message-ID: <CAP8UFD38TE=5zxvkDvLRsDTpC6zDo6EN5q_HJMQPbUBcfJVsSg@mail.gmail.com>
References: <20140401191831.353.99271.chriscool@tuxfamily.org>
	<20140401192023.353.34477.chriscool@tuxfamily.org>
	<20140402003938.GE6851@google.com>
	<CAP8UFD1hrXDdwKokLH_j=vwWoViC9sSJHf0gTFubh-oFQao4MA@mail.gmail.com>
	<xmqqob0gohc2.fsf@gitster.dls.corp.google.com>
	<xmqqk3b4ogwu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Josh Triplett <josh@joshtriplett.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 07 11:39:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WX61F-0008RB-QI
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 11:39:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbaDGJjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 05:39:04 -0400
Received: from mail-we0-f172.google.com ([74.125.82.172]:41806 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755149AbaDGJjD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 05:39:03 -0400
Received: by mail-we0-f172.google.com with SMTP id t61so6535874wes.31
        for <git@vger.kernel.org>; Mon, 07 Apr 2014 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jhvXKXl7w1myWuKAiEMtEIW8HNICo4tYkXmsAvX1Ybg=;
        b=JBLarU0QmEpVcCIiVPs2tfY7rvsrFyoVSTnnDjVnrsSgQxmQ+c4zR7A18W1cwxDDAC
         Q9U+/14UeFbNiNOKAFiCgm4Kk5Wa6SJuz4VgH4qgSCbg1zhEtiUViBrxTzpVSX9+6dgD
         ff/VS49aC6wvvRh3pyz5OY/+CsHAKRMNaSAJdgwaJb3cXVnV8J8FMIZtOKqQiKuCgzdf
         sJPEO0lQM+4lYr767m+WJHmdkLyGqy5GE+5Gtv8U6jLLaYIF0WTbm6JwPrpwIAU9ycSS
         8TVHMQFXA9oy0Vp5W1lqk4tbX5GwJKbjzOZw2I3avq01PqSJK93Wqvd0xFNnCqNvkhdq
         0I5A==
X-Received: by 10.180.7.133 with SMTP id j5mr24044537wia.55.1396863541550;
 Mon, 07 Apr 2014 02:39:01 -0700 (PDT)
Received: by 10.216.174.68 with HTTP; Mon, 7 Apr 2014 02:39:01 -0700 (PDT)
In-Reply-To: <xmqqk3b4ogwu.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245829>

On Sat, Apr 5, 2014 at 12:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Christian Couder <christian.couder@gmail.com> writes:
>> "The following features are planned but not yet implemented:
>>         - add more tests related to commands
>>         - add examples in documentation
>>         - integration with "git commit""
>
> I was planning to merge the series to 'next', but perhaps we should
> wait at least for the first two items (I do not think the third one
> is necessary to block the series).

I will send soon a new version of the series with more tests and fixes.
It will also contains a patch that adds an empty line before the
trailers in the output if there is not already one.
After that I plan to work on adding examples to the documentation.

>>> Why support both '=' and ':'?  Using just one would make it easier to
>>> grep through scripts to see who is adding signoffs.
>>
>> That was already discussed previously.
>
> I do recall it was discussed previously, but given that a new reader
> posed the same question, I am not sure if the end result in this
> patch under discussion sufficiently answers the question in a
> satisfactory way.
>
>> The reason is that people are used to "token=value" for command line
>> arguments, but trailers appears in the result as "token: value", so it
>> is better for the user if we support both.
>
> While I do understand the part before ", so" on the second line, I
> do not see why that leads to the conclusion at all.
>
> Yes, because it is a well-established convention to separate option
> name with its parameter with '=', accepting "--option=parameter"
> makes sense.  That may result in a string "Option: parameter" added
> to the output from the command.  I am not sure why that output has
> anything to do with how the command line should be specified.

First accepting both ':' and '=' means one can see the "git
interpret-trailers" as acting on trailers only. Not just on trailers
from the intput message and option parameters from the command line.
But from trailers both from the input message and being passed as
arguments.
In my opinion it is good if it can be seen this way, as it may
simplifies the user's mental model of how the command works.

And second there is also a practical advantage, as the user can
copy-paste trailers directly from other messages into the command line
to pass them as arguments to "git interpret-trailers" without the need
to replace the ':' with '='. Even if this command is not often used
directly by users, it might simplify scripts using it.

Third there is a technical advantage which is that the code that
parses arguments from the command line can be the same as the code
that parses trailers from the input message.

Thanks,
Christian.
