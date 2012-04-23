From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] git-svn: fixes for intermittent SIGPIPE
Date: Mon, 23 Apr 2012 07:44:41 -0700
Message-ID: <xmqqvckqld7q.fsf@junio.mtv.corp.google.com>
References: <cover.1333381684.git.rkagan@mail.ru>
	<CANiYKX5RNb3YXhGWXzpfDz+XK1PM6zyN=zrDKk3_4StCu2ukzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Roman Kagan <rkagan@mail.ru>
X-From: git-owner@vger.kernel.org Mon Apr 23 16:44:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMKVU-0004QI-6b
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 16:44:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753810Ab2DWOon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 10:44:43 -0400
Received: from mail-yw0-f74.google.com ([209.85.213.74]:42641 "EHLO
	mail-yw0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab2DWOom (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 10:44:42 -0400
Received: by yhgm50 with SMTP id m50so1331979yhg.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 07:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=MhnT5YHWY2b1r7Y3pZClbruk13wjENKSDDexrkRI/bM=;
        b=RQoFJDIe0dLiv/5mXIOmYPE449xx+Bg/2OuYkP21ek9dChMeSCH0LAJirmqLTJnsyW
         dQdN6pDwSO0QjtFvO61ve5JF8lqLY/5QIquV0mPVXqrAmoPBQkykjf2r9/qtzBgbOuXm
         to3A7cD397Ry5RcF260BX6lE2e6qZpgVcDEEpdsZ2pFQDMc5u6E5pPQxTnm12mcRhM6U
         aj/n9AxIyuYmmK0zRkYCzLwmlDTmM3qLpY2zLlRGdOiu7+dsRsmXfXHOKxu6mB318osj
         rmj0BdoGZuCCgRXDER5lpTCEGvAL36hvF9whfKx++0o1OvElQPefUQaroyOzoAq5p/4r
         L8DA==
Received: by 10.236.76.133 with SMTP id b5mr20004476yhe.0.1335192282361;
        Mon, 23 Apr 2012 07:44:42 -0700 (PDT)
Received: by 10.236.76.133 with SMTP id b5mr20004457yhe.0.1335192282306;
        Mon, 23 Apr 2012 07:44:42 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id j51si15108795yhi.1.2012.04.23.07.44.42
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 07:44:42 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 358771E00EE;
	Mon, 23 Apr 2012 07:44:42 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id D3406E120A; Mon, 23 Apr 2012 07:44:41 -0700 (PDT)
In-Reply-To: <CANiYKX5RNb3YXhGWXzpfDz+XK1PM6zyN=zrDKk3_4StCu2ukzg@mail.gmail.com>
	(Roman Kagan's message of "Mon, 23 Apr 2012 11:05:37 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQloRvhhHZKur3+pVt95DBAzFCLHMYCaaRRKzAeJrOUhVdCGI0VlBTAWQG+MdEUJWufR3Tve3VOYBbIS3h16BLOlSOt29L+m0Qc1WVI6RBmRbXEaPjEuWCL7rsnSERd3QHQuStOT9nTTgHRM1DjtkfLM62TdSooCzLZQvGsr1neuJk8pr0k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196127>

Roman Kagan <rkagan@mail.ru> writes:

> IIUC the series was approved by Eric.  What do I need to do now to
> have it reviewed for accepting into the master tree?

I see this:

        Date: Tue, 10 Apr 2012 21:11:20 +0000
        From: Eric Wong <normalperson@yhbt.net>
        Message-ID: <20120410211120.GA27555@dcvr.yhbt.net>

        Roman Kagan <rkagan@mail.ru> wrote:
        > +		my $signew = POSIX::SigSet->new(SIGINT, SIGHUP, SIGTERM,
        > +			SIGALRM, SIGPIPE, SIGUSR1, SIGUSR2);

        Considering your 2/2 patch, can we remove SIGPIPE here?
        Otherwise, I think this series is good.  Thanks!

What usually happens after such an intial round of review is for you to
think about the comments like this one given during the review, and
either submit a patch updated accordingly, or discuss why your original
is better than the suggested update, and then the reviewer responds to
it, and repeat the process until everybody involved in the discussion
accepts the outcome.

Then the patch will hit my 'next' branch (or my 'master' branch, for
subsystems like git-svn where the area expert, i.e. Eric in this case,
knows much better than myself) after that.

In short, as far as I can see, the ball is still in your court.

Thanks for a reminder, though.
