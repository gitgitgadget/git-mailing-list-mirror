From: Chris Kees <cekees@gmail.com>
Subject: Re: --progress for git submodule update?
Date: Mon, 12 Mar 2012 21:17:29 -0500
Message-ID: <CAOVFbFhMfpFa5=a0Z50H7nHdQFHn9Y4ApUnQJq6GCOFP+AKy5A@mail.gmail.com>
References: <CAOVFbFiBOH2MyC3HUtf=hA_PssSRENW7uwpBVxh0TwnO7h90XA@mail.gmail.com>
	<4F5D0FFD.1020509@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 13 03:18:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7HJL-0006Vn-V7
	for gcvg-git-2@plane.gmane.org; Tue, 13 Mar 2012 03:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248Ab2CMCRb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 22:17:31 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:50218 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756113Ab2CMCRb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 22:17:31 -0400
Received: by wejx9 with SMTP id x9so38646wej.19
        for <git@vger.kernel.org>; Mon, 12 Mar 2012 19:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Cd9e7bEznSpBRqQ8ORFQYdwkGlpsZvrgt9fvjGII7po=;
        b=jWzJpG63Cww+Rlfei5vaRN9NNKAKOjIBiiVuHfwdeV1SWwZsa4H0T0wKvrO4acEfkB
         2Q0DuTxZkzpI+UxBqfNUhtjlsHW9ru/4TBCNoL0SDBZbC+RZFS15f42w24ME0YeTqkEk
         Dv5+CoDGuTlDRfShs43V+YpT0IAQKpqo+HzHTQsLOS+iopvTbl5AWbyOtQKNoX52qQCf
         yT0SrdN25gYSeE0cCc0qX7JoJPTz324lzm0RPhFKU4dL8nFP71tes0fANBRynbBVEH/5
         Lu62cnIEXrmPIjHHV0QgAMZfuW/aUtGU1t8DTa6gMQnpKyNBG5hlzMcjwhkWrFNLKFul
         Xj6A==
Received: by 10.180.80.40 with SMTP id o8mr2957000wix.10.1331605049892; Mon,
 12 Mar 2012 19:17:29 -0700 (PDT)
Received: by 10.216.178.8 with HTTP; Mon, 12 Mar 2012 19:17:29 -0700 (PDT)
In-Reply-To: <4F5D0FFD.1020509@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192969>

It's 'git submodule update --recursive' that is taking so long
silently.  The problem is mainly on the first time. There are about 10
submodules that together have taken more than 30 minutes. It's not
really just the amount of data, I think there are also network traffic
issues that slow things down on some systems.

Chris

On Sun, Mar 11, 2012 at 3:50 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 10.03.2012 08:17, schrieb Chris Kees:
>> Would it be reasonable to have a --progress option for 'git submodule
>> update'? I'm using buildbot with a git repository containing large
>> submodules, and buildbot times out on the submodule update
>> occasionally because there is no output for long periods of time.
>> Adjusting buildbot's timeout factor will do for me in the short run.
>
> As cloning a submodule talks a lot about its progress am I right
> suspecting it is the checkout part that is taking so long for you?
> The submodule script always uses the -q option for git checkout
> (which also gets rid of the unwanted "detached HEAD" messages). So
> AFAICS before a --progress option could be added to the submodule
> script, git checkout would have to learn an option to show progress
> but not the detached HEAD message (or to just suppress that advice).
>
> What times are we talking about here?
