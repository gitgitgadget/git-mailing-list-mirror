From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git submodule should honor "-c credential.helper" command line argument
Date: Sun, 7 Feb 2016 19:44:34 -0800
Message-ID: <CA+P7+xpFmZBUwq1h9Xhi7xKYfAyvcouBiV5ujHxuGJQJTMHXZw@mail.gmail.com>
References: <56B0E3AA.30804@syntevo.com> <20160203042554.GA21179@sigill.intra.peff.net>
 <CA+P7+xpGTvbyLOKQ=DHFBLOuVNN8WocraaZQhFD36oDiFrY+sA@mail.gmail.com>
 <CA+P7+xr4gQFPsUiuqSzMsUJP6_W8FnXBwX1Xes=XjksuTs=+hQ@mail.gmail.com> <56B74B17.4040304@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 04:44:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aScl0-00057w-DR
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 04:44:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbcBHDoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Feb 2016 22:44:54 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36624 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754394AbcBHDox (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Feb 2016 22:44:53 -0500
Received: by mail-ig0-f169.google.com with SMTP id xg9so47815008igb.1
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 19:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FslKtjvLXl9Dm+fUBgLNezSbtUR9TB92Oo/aNtSuSyE=;
        b=RZ3v9ln6RXbgNc0HcO5iT+AZPoS6U0xFD02Gdr0w+m67jn9QkEG6DTdWWCBmcYf0db
         ITQnqAmSSsxJujDEyjjjlbxBDux8hzrmwbFCsXHhG1VcKOfFzQgtQS9eriLFiU3tgEXx
         9uJlar1TJ4KwXi1Td6FdDmfAlnpU1nqqp8UmXuTtri59s3aX0IGGe5er8DMAmYJBJWyc
         S89uCmWlmj9BIjUGzlxYsSD91fdhPDNu0buYxiib/rNDsao0oh7xLK+V92gEAn23vHw9
         5rwuz702donEOEtPU0yoNNaTrYogxPByFx4mRK+dtjEA8OAVBg5mQguDI/6SrMjglwet
         p2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=FslKtjvLXl9Dm+fUBgLNezSbtUR9TB92Oo/aNtSuSyE=;
        b=iA6owF92lyeYiiG3zWKu/0kLwTi3sq4FLeznCK9vbzUul/TubAuFc3YzKpkX4JP5RA
         YA5b7+5q61Wt5wWoiJEiOwXn+mpsXx5ZUeOYKVCtBqbASekxmm+ebghCDzYbQAo8y+6E
         yh959u72PWdqJUnjCEj7fx1nRc1kzdd3y7/GIPgJ9vtYGS15wR0IY5aJ24yNBC4mrSN1
         IDYzVQ6tqdBOaAKcrCcvz22oNNDhAtMZrKlXQ16IFCaHqhvK6iEQYmdYtG1DXARVCwyd
         FMK28smisPfuGek8BXCYLzkss0zpeOu1LIQjA/dLDxgPmgPRw9xKnsMnoeXtORvy//xB
         HZ1w==
X-Gm-Message-State: AG10YOQcSjfCsY7hNoVLJn+L/6gKWVVa2gMtuOIxE/c+vGXojJcMyk7vXEDJpexeyiuYCJdwqK4EIEn+wJ2H0g==
X-Received: by 10.50.142.73 with SMTP id ru9mr22135587igb.92.1454903093406;
 Sun, 07 Feb 2016 19:44:53 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Sun, 7 Feb 2016 19:44:34 -0800 (PST)
In-Reply-To: <56B74B17.4040304@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285745>

On Sun, Feb 7, 2016 at 5:48 AM, Marc Strapetz <marc.strapetz@syntevo.com> wrote:
> On 07.02.2016 05:41, Jacob Keller wrote:
>>
>> On Wed, Feb 3, 2016 at 3:44 PM, Jacob Keller <jacob.keller@gmail.com>
>> wrote:
>>>
>>> Ok so I am not sure we even really need to use "-c" option in
>>> git-clone considering that we can just use the same flow we do for
>>> setting core.worktree values. I'll propose a patch with you two Cc'ed,
>>> which I think fixes the issue. There may actually be a set of
>>> configuration we want to include though, and the main issue I see is
>>> that it won't get updated correctly whenever the parent configuration
>>> changes.
>>>
>>> Thanks,
>>> Jake
>>
>>
>> I tried adding the config as part of module_clone in
>> submodule--helper.c but it didn't pass the test I added. I haven't had
>> time to look at this in the last few days, but I am stuck as to why
>> submodule--helper.c appeared to not use module_clone as I thought.
>
>
> I've tried to just comment out clearing of environment variables in
> git-sh-setup.sh, clear_local_git_env(). I've noticed that "-c
> credentials-helper ..." is stored in $GIT_CONFIG_PARAMETERS and with
> existing code is reset there. If not clearing the environment variables, at
> least "git submodule init" is working properly. I didn't try with other
> commands nor to run tests.
>
> -Marc
>
>

I'll have to dig more into this next week.

Regards,
Jake
