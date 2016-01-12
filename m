From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 3/3] submodule: extend die message on failed checkout
 with depth argument
Date: Tue, 12 Jan 2016 15:32:15 -0800
Message-ID: <CAGZ79kY-tzhKxYeSe_cknBP0f8hPZJ9e1+AXq88XjJevc_Dteg@mail.gmail.com>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
	<1450653595-22676-4-git-send-email-larsxschneider@gmail.com>
	<CAGZ79ka9+KxqbogbN1UnNxQ_G6U_incYKLiuadTroc90VmEWpA@mail.gmail.com>
	<BCA2C81C-8DB4-4695-8A44-79B51103A684@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 00:32:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ8QH-0007au-FR
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 00:32:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617AbcALXcR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 18:32:17 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:34699 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbcALXcQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 18:32:16 -0500
Received: by mail-io0-f177.google.com with SMTP id 1so353949087ion.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 15:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EMc+A/7mFV4XtbBQB05Qyj5UrlBAU3vRZlzfsZ5oP94=;
        b=G3QcOgtQ3arXL4UruM0AGS51bntJkhQxOsyYY6v2QtEWWQzZlXXLIGaaMmR5ttxPNz
         nK+7jV5SaMQ1sGuJPmMlVPB4uBz/KjDNQVr4aGamEdl6L0pJtW+CxlywzXidk0ErsmaT
         HRT+3zBWnH75550Cskk/gF+56xyO0jylw3J51hb9BE97qk+7p2LOacttZLowcl11gfEv
         md5PYKi50H7JdJD7HWL+a61jzUu3O+L6Oghzo/ogN6rEMMV5ELjNjSfS2oXH2hYpnCIS
         NMDGSs1553/sFHULS4FdE9bEe+jkh1VL8mYhCYbktLBLMyXlG9ayNBW+JtS/XgAseCM0
         k8hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EMc+A/7mFV4XtbBQB05Qyj5UrlBAU3vRZlzfsZ5oP94=;
        b=CWplKM7+LikP+UsuTFQaDNTz2wxoZGNUf8zcPwpcVcG5BCNt5use8rXtsJSdUWk3tr
         70FFt6ltEts8BsFuiKtwzZ/Sqev0bCISqTXCilCACCZEGAvnlHXqsJEV9Uafn4ADrk2p
         ODtejxOeSC8/AcXwqvwqKYj73+E4qOjr9BCd/FYRoaXVgvrK4kYkgwAicds6kt3q0gwz
         6ejzhaG5jXlZKZrfmI1DXwHGwH112CQk+38BTJXPc1bVZgJoKctpNBhZzRahbUdakK6w
         BcZgjieAFj63ZuM1smmjH1boLsO5JoE0a6AphgHxLyI2fVVbV/fwSVn+4KpZ+XVetiN4
         nIuQ==
X-Gm-Message-State: ALoCoQlw2VLIjnb0VU7DBEm1ThV0q5Ytuk9w3R0CRO6I/jKYV1U4waXGtuUzowsbwvT3LVz8LYA39Gez56QANzhhKSjDRJyLHEsIXpxN7VmHHBYl0zS5SiU=
X-Received: by 10.107.129.149 with SMTP id l21mr117533535ioi.174.1452641535864;
 Tue, 12 Jan 2016 15:32:15 -0800 (PST)
Received: by 10.107.8.74 with HTTP; Tue, 12 Jan 2016 15:32:15 -0800 (PST)
In-Reply-To: <BCA2C81C-8DB4-4695-8A44-79B51103A684@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283851>

On Tue, Jan 12, 2016 at 1:29 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> On 11 Jan 2016, at 17:26, Stefan Beller <sbeller@google.com> wrote:
>
>> On Sun, Dec 20, 2015 at 3:19 PM,  <larsxschneider@gmail.com> wrote:
>>
>>> +test_expect_success 'submodule update clone shallow submodule on non-default branch' '
>>> +       git clone cloned super4 &&
>>> +       pwd=$(pwd) &&
>>> +       (cd super4 &&
>>> +        sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
>>> +        mv -f .gitmodules.tmp .gitmodules &&
>>> +        test_must_fail git submodule update --init --depth=3 2>submodule.out &&
>>
>> Why do we choose a depth of 3 here?
> I just copied this code from the test above. Let's change that to "--depth=1" to avoid confusion.
> Should I reroll or can this be fixed in the merge?

I noticed that too after reviewing 1&2 that 3 seems to be the standard
depth in the tests,
so I'd think 3 is fine here, too. Which makes it not worth to reroll,
so I'd be fine with it as is.

>
>>
>>> +        test_i18ngrep --count "Commit is probably not on the default branch." submodule.out
> I was just reading this and wonder if we should remove "--count". My initial intention was to
> make sure this error message only happens once. However, this is not checked here anyways.
>
>>> +    )
>>> '
>>>
>>> test_expect_success 'submodule update --recursive drops module name before recursing' '
>
>
> Thanks,
> Lars
