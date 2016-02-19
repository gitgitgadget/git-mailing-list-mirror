From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git submodule should honor "-c credential.helper" command line argument
Date: Thu, 18 Feb 2016 17:15:54 -0800
Message-ID: <CA+P7+xpHNHVSJnVg3HwiBjWxRdSpLXCsm3GpWst=BNyhLMVd5A@mail.gmail.com>
References: <56B0E3AA.30804@syntevo.com> <20160203042554.GA21179@sigill.intra.peff.net>
 <CA+P7+xpGTvbyLOKQ=DHFBLOuVNN8WocraaZQhFD36oDiFrY+sA@mail.gmail.com>
 <CA+P7+xr4gQFPsUiuqSzMsUJP6_W8FnXBwX1Xes=XjksuTs=+hQ@mail.gmail.com>
 <56B74B17.4040304@syntevo.com> <CA+P7+xpFmZBUwq1h9Xhi7xKYfAyvcouBiV5ujHxuGJQJTMHXZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 02:16:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWZgC-0000Tn-Cd
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 02:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948927AbcBSBQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2016 20:16:16 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36093 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947768AbcBSBQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2016 20:16:14 -0500
Received: by mail-ig0-f173.google.com with SMTP id xg9so25410696igb.1
        for <git@vger.kernel.org>; Thu, 18 Feb 2016 17:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ssxY+6tFlXwjAZxjuN8ckS85VtNMTv94Blx3zDZVG2w=;
        b=ddxQzmQCDjhMgxTbUNjbShpXd/yY8L8zrfdhYYSpyKLCxLKfT2x85h0M19Cs5e++NP
         pa5bzbw2/wh3+6EbeP1Hc74Y37tSSg4a7g0Sb4mvTRAszbxtm37EF+10Rs1/+tf4N/Es
         4DeqEBSOZKeA+0f4Yokb8PWQlG+I21DJkXZUrxhUZ2QDptE8pzC3wn7Vx0Oaw+uhq/MI
         +26EvD7+SfqbKlRpx4y5xQIdrPZ5tylUn+BaJ8m+PphVKI5v3rJvlZ1PQFYkxZdZ44O/
         gXGBUTb2v7rg5wK+z6GukqiPGsWIudxjm5kgL/BFX/6Int0++dE+mnhhwyjZTI65DH5t
         TEWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ssxY+6tFlXwjAZxjuN8ckS85VtNMTv94Blx3zDZVG2w=;
        b=CaGRnYQhNQy6PDcJjtrRrH070Lwk6RTbzNBlwioymZOPpZIY6nMr8bTA9um+g6nvAW
         B8Zi/D4Q8o0vesFOOMM71Xi5D1PKclagC065nabLQXBaN/j3HlvFoxtub4qv7kBtiO+l
         25lugvzOKIB5jLVIHSJrb2hza0w7783xL0JLlkYCzuXq/BPPItE+4tSeDKrHnGLpoeET
         QtN7y6lFg9pvfVzuE1qffLQvpV57Nageh6NU57/OQOprQGx8eDlqWODzXyxc8bkc9aCU
         hKjvnp2ivwPbhCLKP8wdpo5iymrfIcGs8eeuFreQZ2KwCbUbDdgFiN3d1UIA6WhZXw59
         gnLA==
X-Gm-Message-State: AG10YOR3zWp1dd7tYB91xsFQV6Znexxg1Ugs2c+M52QoUOzEQ9KfWz8Lg31sPJBZlKrI5aoTjmjEovXx+FvtHQ==
X-Received: by 10.50.137.35 with SMTP id qf3mr6630969igb.92.1455844574412;
 Thu, 18 Feb 2016 17:16:14 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Thu, 18 Feb 2016 17:15:54 -0800 (PST)
In-Reply-To: <CA+P7+xpFmZBUwq1h9Xhi7xKYfAyvcouBiV5ujHxuGJQJTMHXZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286651>

On Sun, Feb 7, 2016 at 7:44 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sun, Feb 7, 2016 at 5:48 AM, Marc Strapetz <marc.strapetz@syntevo.com> wrote:
>> On 07.02.2016 05:41, Jacob Keller wrote:
>>>
>>> On Wed, Feb 3, 2016 at 3:44 PM, Jacob Keller <jacob.keller@gmail.com>
>>> wrote:
>>>>
>>>> Ok so I am not sure we even really need to use "-c" option in
>>>> git-clone considering that we can just use the same flow we do for
>>>> setting core.worktree values. I'll propose a patch with you two Cc'ed,
>>>> which I think fixes the issue. There may actually be a set of
>>>> configuration we want to include though, and the main issue I see is
>>>> that it won't get updated correctly whenever the parent configuration
>>>> changes.
>>>>
>>>> Thanks,
>>>> Jake
>>>
>>>
>>> I tried adding the config as part of module_clone in
>>> submodule--helper.c but it didn't pass the test I added. I haven't had
>>> time to look at this in the last few days, but I am stuck as to why
>>> submodule--helper.c appeared to not use module_clone as I thought.
>>
>>
>> I've tried to just comment out clearing of environment variables in
>> git-sh-setup.sh, clear_local_git_env(). I've noticed that "-c
>> credentials-helper ..." is stored in $GIT_CONFIG_PARAMETERS and with
>> existing code is reset there. If not clearing the environment variables, at
>> least "git submodule init" is working properly. I didn't try with other
>> commands nor to run tests.
>>
>> -Marc
>>
>>
>
> I'll have to dig more into this next week.
>
> Regards,
> Jake

I am looking at this more and I am stuck as to how best to provide a test case.

I think the problem as stated above is pretty straight forward, we
just want to stop clearing GIT_CONFIG_PARAMETERS but I can't find an
easy way to test that we've done the right thing. There are no current
tests for using a credential helper with submodule update right now.

Regards,
Jake
