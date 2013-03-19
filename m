From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [BUG?] rebase -i: edit versus unmerged changes
Date: Tue, 19 Mar 2013 10:21:20 -0400
Message-ID: <CADeaMWoeRQBbrqLsfieKTE2rRbpzU-Hyp+mv-=CTj+=Znmf=Zw@mail.gmail.com>
References: <CALkWK0n=fb_kq+Ed3rd9MhQUCHY3+_nj=zw4M+GmjbzEO56SOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 15:21:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHxQJ-0003ys-D2
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 15:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756401Ab3CSOVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 10:21:23 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:63777 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756387Ab3CSOVV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 10:21:21 -0400
Received: by mail-pb0-f54.google.com with SMTP id rr4so470555pbb.27
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=2wIEjbX19GGmBzOCoQmqY/6mLrior7oIOMlhyg7qjnE=;
        b=Az3BgR5lo97HQgniPzhGOwjzsADpEUim3jky+T3cChR50qDp+Cg98T1WXW2qB11IiU
         PLgNdcjHfugneNPqV/fL459y+1t1kkSYH3xpOyHioymSccJ4PznuCSRu9W9GuDHMxTqn
         mTJsnpR3nNieV3XOuwsHZC8/iAKtYqN7AY/K2qgpzgKF0qR8z1gq9Jj0X0wVZiqfbv9K
         NwyDDoOx6VWm137CezYUNS1jyHcWcKSVPNHPdRZ8A8dwB2g5ChGHRvoKtac4nzZZunAN
         +7fzWrUGT3BszQjqCdChK28ZvIf9cVZNwEGBCEzHZ+EIgYujrmS8PYBzCJAEUc+84poF
         4UuQ==
X-Received: by 10.68.11.169 with SMTP id r9mr3312048pbb.221.1363702880857;
 Tue, 19 Mar 2013 07:21:20 -0700 (PDT)
Received: by 10.68.235.144 with HTTP; Tue, 19 Mar 2013 07:21:20 -0700 (PDT)
In-Reply-To: <CALkWK0n=fb_kq+Ed3rd9MhQUCHY3+_nj=zw4M+GmjbzEO56SOg@mail.gmail.com>
X-Google-Sender-Auth: 8XdM4GZsBGWfdekKrYiwEjQPsTk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218517>

On 3/19/13, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> I know that this is expected behavior, but is there an easy way to get
> rid of this inconsistency?

You can actually rely on "rebase" to run the appropriate command. In
the first edit commit (the_
no conflict one), I usually run only "git add" to add my changes, then
just run "git rebase --cont"._
And "rebase" will recognize that I'm doing an "edit" and run "git
commit --amend" for me. For the
"unmerged case", I'd do the same "add and continue", and "rebase" will
run "git commit" for__
me.

By doing that, the two scenarios feel a bit more consistent.
