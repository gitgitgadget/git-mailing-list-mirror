From: Stefan Beller <sbeller@google.com>
Subject: Re: `-u`/`update-head-ok` unsupported on pull
Date: Thu, 8 Oct 2015 11:13:34 -0700
Message-ID: <CAGZ79kavoUw5tkeABkYXEsa7jt-2aRxjGyOB+=ofnuqpQBGGkA@mail.gmail.com>
References: <CAA5Ydx9ySzEBWcUkmGQKTq93W0HzfEmb3ER7GPKzcnQJ0dbFKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Victor Engmark <victor.engmark@gmail.com>,
	Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 20:13:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkFhE-00014n-Fp
	for gcvg-git-2@plane.gmane.org; Thu, 08 Oct 2015 20:13:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752889AbbJHSNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2015 14:13:36 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34993 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbbJHSNf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Oct 2015 14:13:35 -0400
Received: by ykec126 with SMTP id c126so19573539yke.2
        for <git@vger.kernel.org>; Thu, 08 Oct 2015 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PZde2tYz8JyujIXb6jOMFpizNXidQUsI7lRS21msK08=;
        b=DQPJtP+I7F40O4acoLM3NrM7HUSwn/A7O7AD8uJWz02bKMh8SdsZR7b9B+ZoMMftdp
         t48ll+wMdZHFSIGiQa2tB8ElDNz135pNlrhN6N8Utm/qdHajHzXAoQRAK7QQ+RdKIjRe
         V/Owy917dx2MFwW4uTa+ufUweWbyk4SuAqgaYFGLPBRS67WDbOolxts1eEta98IJyZzr
         U91RVXXfCSHzEsryhvedebshwHu+A4V1jHdCDzNntOR6mBalp1H1IDbvR1EXuh2n1Ei+
         Ee7bKwBPGcyUx3yVviel6XrfIgcLOTuRPUhTBDr5yQwEgvbNSmSBXqH52z12/olDgfc1
         8z6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=PZde2tYz8JyujIXb6jOMFpizNXidQUsI7lRS21msK08=;
        b=SgJYyE7zjkDrr53w1pwq9jPVtpMoG+NZJkpKb/FJprfVMCa4Sj227CAUDf8MBSWQz5
         Fl84oHRI/2mj2jX9sQyh5ndgTDTbVkGQLfwIpKH4vTl07ll4bnBVE6y+2T9VW5enHaur
         RP3VCrTmV+JUBmgjYuM3QWabN+6TmvJ5IbHHYV8KuXt3KnSv6ynELaP2/+zNyvgEkUI8
         m/Wup7s77SSm4o1ekjfuIRZxAgnYpxjSwBv+YioO4FQas4GKhDu2VDCUBWJeOqpSIqa1
         rkF6GtIFWbTYWIgBQmgDarPjrVSWQLKKRiszOeHvk/PbqjeIu88aNCgJLEhXtl2kw6LZ
         jdEA==
X-Gm-Message-State: ALoCoQniqJuuuJE5LJCXPifBvfIk2mVnw3pcto8BZ1CHrpq6wnE4tejUZ+DEHZv2N6986oBr/AnK
X-Received: by 10.129.4.207 with SMTP id 198mr7084139ywe.320.1444328014716;
 Thu, 08 Oct 2015 11:13:34 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 8 Oct 2015 11:13:34 -0700 (PDT)
In-Reply-To: <CAA5Ydx9ySzEBWcUkmGQKTq93W0HzfEmb3ER7GPKzcnQJ0dbFKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279252>

+Paul Tan who rewrote git pull in C recently.

The manpage:
-u, --update-head-ok
           By default git fetch refuses to update the head which
corresponds to the current branch. This flag disables the check. This
is purely for the internal use for git pull to communicate with
           git fetch, and unless you are implementing your own
Porcelain you are not supposed to use it.

I guess we either need to update the manpage to remove that option
then, or add it back in in case somebody actually uses it despite the
warning in the man page?
