From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 1/2] worktree: add 'for_each_worktree' function
Date: Mon, 31 Aug 2015 10:56:52 -0700
Message-ID: <xmqqd1y3wdcr.fsf@gitster.mtv.corp.google.com>
References: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
	<1440961839-40575-2-git-send-email-rappazzo@gmail.com>
	<CAPig+cTHZrQn8LpfftcsAQhFAykgDorbR97tkcuSCFYD_ngs9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 19:57:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWTKF-0006Kr-3i
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 19:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbbHaR4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 13:56:55 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:36440 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbbHaR4z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 13:56:55 -0400
Received: by pabpg12 with SMTP id pg12so13878927pab.3
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2HmeMphKe9ps3EXoLq9PrIRdxi8IzfLA+7q9HHSSuD8=;
        b=sog7QM18UwrMlMlnLIAJ9RlK056rOR5PrwaRI2aTSNru7o4htCAnsLZgalhoJjdGOu
         5aJp90tcJpD99yKT/kjnGimNLf401O07x9l6k+4yXx8svGRo0ZKhLr/cFSpaiUyrLTeB
         hkSbU9WYGJwLVBrfB7qCfKRwQUQDr4JsP4QazqQbazi+ZPXqMujnOLv9WyVTOb3pWpi8
         T2pKBT+Io5DmzMhbZUeolnJDxBayAmPXYROzKmehWVUI9y2sbGxRVC05JsG0y6j8vmnY
         srKNN33gNG+TLVfLSUhtMgY+6mExtIgMm1UfV2VvUVxbxzecYUgVbKtOKUt/DEEtWcht
         vpIg==
X-Received: by 10.68.88.130 with SMTP id bg2mr38897322pbb.129.1441043814759;
        Mon, 31 Aug 2015 10:56:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id v6sm15332663pdp.18.2015.08.31.10.56.53
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 10:56:54 -0700 (PDT)
In-Reply-To: <CAPig+cTHZrQn8LpfftcsAQhFAykgDorbR97tkcuSCFYD_ngs9g@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 31 Aug 2015 01:11:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276899>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Thanks for working on this....

<aol>metoo</aol>

> Stepping back a bit, is a for-each-foo()-style interface desirable?
> This sort of interface imposes a good deal of complexity on callers,
> demanding a callback function and callback data (cb_data), and is
> generally (at least in C) more difficult to reason about than other
> simpler interfaces. Is such complexity warranted?
>
> An alternate, much simpler interface would be to have a function, say
> get_worktrees(), return an array of 'worktree' structures to the
> caller, which the caller would iterate over (which is a common
> operation in C, thus easily reasoned about).

Nice.
