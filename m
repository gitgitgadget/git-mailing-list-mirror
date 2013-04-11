From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: git log -p unexpected behaviour - security risk?
Date: Thu, 11 Apr 2013 23:19:32 +0800
Message-ID: <CALUzUxrp4+S-Nm-Scb9sT9sBw1mLEb3-CBc_P0KqL20qNmFO3w@mail.gmail.com>
References: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 11 17:20:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQJIC-0003FT-Cy
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 17:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936303Ab3DKPT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 11:19:57 -0400
Received: from mail-ia0-f172.google.com ([209.85.210.172]:43074 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936269Ab3DKPT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 11:19:56 -0400
Received: by mail-ia0-f172.google.com with SMTP id k38so1510435iah.17
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 08:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4nfK6OUw9XqSXNw+VA75BHCF6flIMzXvM6cb8tX7HP4=;
        b=JRNuPy8pp09aEVqQSlXj62EU38kTXnn/tBHgX6vrEEihwEWMAAg/KGn5uWNHRq3yw+
         7AblSWPC/6gBPC3VQBEpFDSnCu+MPLnJL6AShJp6kQHon3XCUoiqo7b3MW/32LG4H8JM
         Yee9bzJqXQavD0V5Sx/+BUVu+z3fJJx36qh3XcyHgP+tptSC3xYkx+mi2cp3Bw8Fw5Tp
         4a46rsoh7KQcNEiJCew297vS5TJr0DATSDt+PzzcbHGKLmxmAemBLwzU2OZauSYuqMac
         MTHCq+waOOPegavBJ/FYiOQX4HQ46SYhn6rQQW2Xp7sHLCi6nKtXHNO1/SiSbiRguC49
         keGg==
X-Received: by 10.50.22.3 with SMTP id z3mr4785914ige.80.1365693593999; Thu,
 11 Apr 2013 08:19:53 -0700 (PDT)
Received: by 10.64.61.70 with HTTP; Thu, 11 Apr 2013 08:19:32 -0700 (PDT)
In-Reply-To: <CAHQ6N+qdA5Lck1_ByOYPOG4ngsztz3HQSw8c_U_K8OnDapj4bQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220881>

On Thu, Apr 11, 2013 at 6:36 PM, John Tapsell <johnflux@gmail.com> wrote:
>   I noticed that code that you put in merge will not be visible by
> default.  This seems like a pretty horrible security problem, no?
>
> I made the following test tree, with just 3 commits:
>
> https://github.com/johnflux/ExampleEvilness.git
>
> Doing "git log -p"  shows all very innocent commits.  Completely
> hidden is the change to add "EVIL CODE MUWHAHAHA".
>
> This seems really dangerous!
>
> The evil code only shows up with the non-default  --cc or -m  option.

For email-based patch workflows (eg. git, linux kernel), then this is
not a problem - the diff doesn't even show up, so nothing is applied
when git-am is run.

For github with pull-requests, a diff is shown between trees, so this
will show up.

--
Cheers,
Ray Chuan
