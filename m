From: Andrew J <andj2223@gmail.com>
Subject: Re: Strangeness with git-add and nested repositories
Date: Wed, 27 Apr 2016 23:10:24 -0700
Message-ID: <CAH6n4TfvybZyAYLkzyjfaP=2ZkirpacTgVQApF3bZT-j8=_Qng@mail.gmail.com>
References: <CAH6n4TdG9LQOPaaw_H6vuCgia0-4JXhPsSiAJPa5GtjfduQoSw@mail.gmail.com>
	<CAGZ79kZhATfP1FpXnhivCa_Az-3KADSCReOo68E2Q3s29x5HNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 08:10:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avf9k-0002nb-6A
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 08:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbcD1GK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 02:10:27 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34486 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122AbcD1GK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 02:10:26 -0400
Received: by mail-ig0-f194.google.com with SMTP id qu10so10832660igc.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 23:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=TMfyS+zvpN0O26iP2Ose8VNdbncHCoGRlaU9lpJoKgQ=;
        b=sNidwCEngH3G+KG8KgVtq8OeTYhvVEJTW2yljADnacd4tivIBJdIZOd5lQXpZxET9u
         JFffNVFMRS0cTHIRpeKRwwujbs3VZWbQGapRcms4/E1gHWzBymNXXmgs88giwTgNK7fd
         lS2BRhs0nGmTvLyGaWqRrHzZ4gpjf2hcezBp5hqcXcwBBb4edIkQoclRw1G5hIBCHM9C
         WFIEzngN3nCWJKZeG25JwOgW09tqNS/QG5iF7Cv26uy4hYGxWoewrhYf1fMZ9MdcZDR7
         ySAELgVtYEtmaAla+VK2vKjb9JcedLkW8Hr855wj1iTpWhzxeOXm3d0i5SfwGEItQEbc
         lSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=TMfyS+zvpN0O26iP2Ose8VNdbncHCoGRlaU9lpJoKgQ=;
        b=i3/8MrO83dTELIvzvr6hjoJTWIOJWhwXapcrgxNd8NN+IMIKgplefdqRWYNjJRDBgg
         /ZH1ZQsJE1C5ZaTwe5z/tsp8baTGWSHufs5AxLRNSW1MSR9VCN+S6a+I890plj3LyNQP
         zcEvYjLkSMZU2opzoDWxfYFMdZw5SlW+XYs8EsbqBOVo7JqQNpqADdZImg7HH8V8Oj2M
         Wc7ShLv4UVFI12WEcZ2OXSUhZ1Mjwse0RfDMqx4l1C9jVthXanwbzNOG7qyv12A+tpdN
         cBlk4ahllfODsOvtTD+dI/H8SoF6tok2BohkZyevti4aUijgrYrumLnIo1s/tAYJximK
         nR7Q==
X-Gm-Message-State: AOPr4FUX89uLk46+HXqZhNVo7KbQjOiZSlnTCzNXhRazKX+N67y7Gc0Lqkz7IH/KPP7OTTWKFcJh2OD3v6g9+w==
X-Received: by 10.50.141.193 with SMTP id rq1mr31487868igb.39.1461823825009;
 Wed, 27 Apr 2016 23:10:25 -0700 (PDT)
Received: by 10.107.10.219 with HTTP; Wed, 27 Apr 2016 23:10:24 -0700 (PDT)
In-Reply-To: <CAGZ79kZhATfP1FpXnhivCa_Az-3KADSCReOo68E2Q3s29x5HNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292845>

Hi Stefan,

On Wed, Apr 27, 2016 at 9:08 AM, Stefan Beller <sbeller@google.com> wrote:
> I think (pure speculation), that it the error is in the context
> (repository) switching logic.
> What happens if you alter the order, i.e. give testfile first and then
> the files in the nested
> repos?

Interestingly, reversing the order produces the same result (the
testfile is added, the nested files are not).

I've also noticed that running something like 'git status testfile
nestedfiles' results in the nested files being omitted from the git
status output; I'd expect them to be printed by git-status as
untracked files. So it appears the problem is not isolated to git-add.

To give some context, my use case is that I have a parent project that
links to numerous chromium libraries, thus my parent project needs
access to many of chromium's headers at build time. I wanted to make
these headers available to other developers without them needing to
check out all of chromium.
So I add all the chromium headers to the parent project with something like:
find deps/chromium/src -name "*.h" | xargs git add --
I was weirded out to find that many of the header files weren't being
added, as I've already described.

I ultimately worked around this by doing:
find chromium/src -name "*.h" | xargs -n 1 git add
Since each file gets added separately, this is quite slow. So it'd be
nice if this little bug was fixed someday :)

As you probably know, Chromium is comprised of many hundreds of nested
repos, so that aided in manifesting this issue.

Thanks,
Andrew
