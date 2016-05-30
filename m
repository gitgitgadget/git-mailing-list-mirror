From: Andreas Lutro <anlutro@gmail.com>
Subject: Fatal bug on revert with --author
Date: Mon, 30 May 2016 16:16:50 +0200
Message-ID: <CAKYJjwgkH5gtQHsV_=4O0SGqb6GEXWC=rdFWO9Jv36dL-NaPcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 30 16:17:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7O00-0001rl-1i
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 16:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbcE3OQw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2016 10:16:52 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36508 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755022AbcE3OQv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2016 10:16:51 -0400
Received: by mail-lf0-f42.google.com with SMTP id b73so50544294lfb.3
        for <git@vger.kernel.org>; Mon, 30 May 2016 07:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=DQJsFPK/JUEaZrFsV2N/V5jSDnpWJTzwKEOfwQRgovA=;
        b=cTW8qDdggp0+Uu522z6wxy3h4ZEEhV3sHx5T9WpIrQ3lC3Yt3NTL5XtmQjJqibHh1o
         F8jEgATnii2BXRXCVRKE/Y1rFSwSyq47kjyFI08pOIJaNi1Ty3N9Ig9JZV16tL+xmbK1
         6rrs4boGq2JN566sa0vYYRVkf2tKOzJLY764+ReaLt9zD+1yzTEUnBuuIKgVrOit0ecs
         twb8M56fcwHh09fb1ELg0Kq4NyRjHGkkG7vzo5hHCbqLCon+fyN2ioy1ySP7OphD437L
         IBhoIZ7jAK4xWq1+/CbBtXFm37kVJx5DNz2SZaG6hfHj3/8b0vD35zlBzh/yDNqhchpd
         5wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=DQJsFPK/JUEaZrFsV2N/V5jSDnpWJTzwKEOfwQRgovA=;
        b=ArHWDsw+ZE/9MeD4diKs/W7fAjlbkhsmpO6iRiuZo68WPrIG+1AkmolozKiewhZ3Mk
         BtEE3hiJu2cwnVJptIw4UDWEXwnFrXveqyiI0TFrlITtamBC2P6sCvezpJDjvgKF1Oa5
         s20LyULd0hvJEl+u23RVa/H+AkqX+KzphqK+e1/cYB2y6iruc8389l9mumuKRhIhU6/r
         emKiEFmpQF20l778BthHydmC0K4j4bkXXtzDcOrO7rHmRzXT/L0SeWxYuTP6zskZfrLP
         0M9Ce97vPaCpThQwrWd9UGY3awzEtdwpQZI0UrDfKtvYWFSEeBq4JiQ99e8B/WOzhKGU
         AOyA==
X-Gm-Message-State: ALyK8tKq14ZcqoooZA3/P2i8/NIXGVlHbe0855BQbziprBSykqy6wmTQOwy7kYJVtURxQSGA3gSLqj46tOV86Q==
X-Received: by 10.46.33.169 with SMTP id h41mr5653235lji.43.1464617810103;
 Mon, 30 May 2016 07:16:50 -0700 (PDT)
Received: by 10.25.144.148 with HTTP; Mon, 30 May 2016 07:16:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295898>

So I learned today that --author is not a supported argument to git
revert. It took me a long time to realize this, though, because the
error I got was very cryptic:

  fatal: BUG: expected exactly one commit from walk

Here's a very simple reproducible case:
https://gist.github.com/anlutro/67e0cec1a6a419e6d44131b0bc1deff6

I was recommended to send this report here by #git on irc.freenode.net.

Thanks,
Andreas
