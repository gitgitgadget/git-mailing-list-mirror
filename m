From: Christian Couder <christian.couder@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2015, #05; Fri, 28)
Date: Sat, 29 Aug 2015 06:15:11 +0200
Message-ID: <CAP8UFD3-Y4T=dQmBVfRR1DEuuRZLSrUvQid8m1YttOnJc5Fj8w@mail.gmail.com>
References: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 06:15:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVXYG-00045q-JP
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 06:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbbH2EPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 00:15:13 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35688 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbH2EPM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 00:15:12 -0400
Received: by igph8 with SMTP id h8so24644440igp.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 21:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=RJgRnHhrRp2cQ1AQewZpDBkkQHO0wJsaiVFBRiIBqIw=;
        b=Ly+Kh2ns1EsncT06g6QiXHGChgsxygdGzzFUolnln4BTxL2fNgRX87dn8It03wcGxp
         ut1e2OvG5n4mBpkumFQk4zxFwPH/Kmn74pFZ3lkLZCxoFPEouZSENMzJz6aI99csV6ES
         bDMs1P0yOpjeM7YfEeiQgk4jwuK0CYFvqMgDGapSNGPWgzB2xXrns1oPZKgtf2f47IVc
         IB5wKd6mwIgaPcdxcf7NRfZzHeLFzAuUzjAW997pj+kkTyEeWGcB1/oIwhfI6AAsIGdD
         eaRyy0aC7p3ZwVrCTJJUUvFLfUTzWt2+CY9lZA1vO7xGFCldyG/Ap4hy1KUbgD9K8Bng
         5Y5g==
X-Received: by 10.50.59.180 with SMTP id a20mr6477922igr.31.1440821711815;
 Fri, 28 Aug 2015 21:15:11 -0700 (PDT)
Received: by 10.79.93.131 with HTTP; Fri, 28 Aug 2015 21:15:11 -0700 (PDT)
In-Reply-To: <xmqq4mjj15lm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276765>

> * dt/refs-bisection (2015-08-28) 5 commits
>  - bisect: make bisection refs per-worktree
>  - refs: make refs/worktree/* per-worktree
>  - SQUASH???
>  - path: optimize common dir checking
>  - refs: clean up common_list
>
>  Move the refs used during a "git bisect" session to per-worktree
>  hierarchy refs/worktree/* so that independent bisect sessions can
>  be done in different worktrees.
>
>  Will merge to 'next' after squashing the update in.

Sorry if I am missing something or repeating what myself or someone
else like Michael already said, but in the current doc there is:

       Eventually there will be no more revisions left to bisect, and
you will have been left with the first bad kernel revision in
       "refs/bisect/bad".

If we now just use "refs/worktree/bisect/bad" instead of
"refs/bisect/bad", it might break scripts that rely using
"refs/bisect/bad".
