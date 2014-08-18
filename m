From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Location of git config on Windows
Date: Mon, 18 Aug 2014 17:51:56 +0200
Message-ID: <CABPQNSZGYDnSfyS7X+MdskhUrmFx5Kzoi+A5+pgoBiX5kPruyg@mail.gmail.com>
References: <ygfvbpqooog.fsf@corbe.net> <CABPQNSZDizccths0b_RZ5FXYYq=+4_2N35DMj9h4Rha_2voekw@mail.gmail.com>
 <53F135F8.60508@gmail.com> <ygflhqlvni7.fsf@corbe.net> <CABPQNSZ=BKqNPCWUmaCSz+gJtBRhjkWtpcDbirsV+KJX=c0kpg@mail.gmail.com>
 <ygf7g25vm9v.fsf@corbe.net> <CABPQNSZayAr0jf9C55wtEH_AJ_hSUkwFsGV4ZxVixizthojkRA@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <karsten.blees@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Daniel Corbe <corbe@corbe.net>
X-From: git-owner@vger.kernel.org Mon Aug 18 17:52:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJPEf-0004sj-MN
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 17:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733AbaHRPwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 11:52:37 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:55183 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbaHRPwh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 11:52:37 -0400
Received: by mail-ig0-f174.google.com with SMTP id c1so8515057igq.13
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ldOo0Avgo3gboKWPfJHBZWApnRgj9vGt1w5RhAZX3uQ=;
        b=mnPXoSE5IeWY7UgrbBlBwVO0OHcqm1KLIvPR34QJnwVAD5atYLwm4r59/Q4ogJUTSz
         dQGNafgkCqdkU8DE3bDfLtFfCrpVGHPhI3HEBkf8NQnITPbRg0ZHU3ePJGVC3pzzJhG/
         jJaTFplKWL1uWj0B5o+D0HIFhwvlUQT/D8d1WDp4KEo3De9rpNy+q6gu339CcL1rUDrT
         yb0X8xKDXRyhI01+BDwr/YI9TDAjnULNN/VraYgPrUFpk4P6kd8O1qW5mLuKhVZgyfQe
         L0jDHouG/yIctPD/vmrx1WDBMAXc8OUmudk/FiPNeniGNgmpXCIBt84Oe+18/azr06fd
         JHtA==
X-Received: by 10.50.4.9 with SMTP id g9mr42474053igg.42.1408377156314; Mon,
 18 Aug 2014 08:52:36 -0700 (PDT)
Received: by 10.64.123.5 with HTTP; Mon, 18 Aug 2014 08:51:56 -0700 (PDT)
In-Reply-To: <CABPQNSZayAr0jf9C55wtEH_AJ_hSUkwFsGV4ZxVixizthojkRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255394>

On Mon, Aug 18, 2014 at 5:47 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Mon, Aug 18, 2014 at 5:40 PM, Daniel Corbe <corbe@corbe.net> wrote:
>>
>> Erik Faye-Lund <kusmabite@gmail.com> writes:
>>
>>> Or you could just restart your shell when you disconnect...
>>
>> Well I'm not that daft.  I tried that and if it had resolved my problem
>> I wouldn't have posted.
>
> Hm, but isn't that what Karsten explains in his last paragraph? What
> shell are you running msys or cmd?

Our /etc/profile does this:

https://github.com/msysgit/msysgit/blob/master/etc/profile#L38

...however, our git-wrapper only does this:

https://github.com/msysgit/msysgit/blob/master/src/git-wrapper/git-wrapper.c#L71

So yeah, we don't seem to actually check if %HOMEDRIVE%%HOMEPATH%
exists. Perhaps fixing this is the right thing to do then? Since the
git-wrapper is run for *every* invokation of git, you wouldn't even
have to restart the shell in this case.
