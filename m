From: Elijah Newren <newren@gmail.com>
Subject: Re: make test Unexpected passes
Date: Fri, 22 Apr 2016 15:19:51 -0700
Message-ID: <CABPp-BFdzu4stEfbGAiqDwRAXt7EcvYBEVz1kChJaR4udC5SXA@mail.gmail.com>
References: <571A8404.5030200@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ben.woosley@gmail.com, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 00:20:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atjQk-0004Mj-4b
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 00:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbcDVWTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 18:19:54 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:36225 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753539AbcDVWTw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 18:19:52 -0400
Received: by mail-ig0-f193.google.com with SMTP id kb1so3858687igb.3
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 15:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=MwDburt91gm1rBnuSizMWM3e04aPJ9032xhuakIldOM=;
        b=k6rcigJ+HB5OJJNWBaJBUjICRRBIVJKQTUCoB92LeszPWJJfDGw6LlDaCkQPrjVlca
         ptVvA2YQ6/cBsZ9hzTI3xnyGC6NYY/WcpkrBF+fkE6EQftHZiqQVD0kBriaQOPX0WC2w
         PG+cMQ422gi2ZjF/3lmXgo8E71VTzOWR82F/re3GUY5ihqlYNypZnJjKWpmGdYcxrwE1
         znGS4hH7yl95if+wBZXRotX24fP+RhTNiHb+qKoGjfR6IPhGa058wgw1SpyfY8k7U6g5
         Ks43PgJzrNVY7xca1joNmK3tnjBVSLBr8IPaJnHDpkxHpH7+jRUb/lksguqqbHy8+lBC
         KrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=MwDburt91gm1rBnuSizMWM3e04aPJ9032xhuakIldOM=;
        b=Of8ADLGmYhBAjUP3mqGmvA4+YZTFlCnkExErC4QFcJzkIdyi1TkvwcND+pt2ywKL1j
         mxIoJYTYDkFCIpYWsmGlyXfblm1PKlOOGslY2GuxemEzMPs1XqoboH9NauvpJ4O9EOfR
         V/ORj+x2pdAQYX+Ffwp3glQOVjV9UXsHrsba9tEy2s/RhEN2kOoCuvCmZ5kre0b9xEUk
         6G13tpDrg5/5YnE5LnPN8toYQUtmhdahYMq39FRG9F4jztBY6wnyXXoDMHYw0pPQmX4M
         kvHbR3UVmwWPbivBYbDVRu4tyNxsLjRJ+4qy0yLl54yf3qjS610qrsKZWxU3Wnk0AXxp
         wNPA==
X-Gm-Message-State: AOPr4FWwX6FvDwCclb2rtu3vJGD4AWgxoDtJHJI9ffBcju28Z4VfFBCh57pNK4ZbEK8zyJ2VciCp/tFIB2EdMQ==
X-Received: by 10.50.160.3 with SMTP id xg3mr7373819igb.87.1461363591793; Fri,
 22 Apr 2016 15:19:51 -0700 (PDT)
Received: by 10.64.0.173 with HTTP; Fri, 22 Apr 2016 15:19:51 -0700 (PDT)
In-Reply-To: <571A8404.5030200@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292285>

On Fri, Apr 22, 2016 at 1:05 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
> Hi Ben, Junio,
>
> In the second case, t6036-*.sh, git bisect fingered commit b61f9d6e
> ("ll-merge: use a longer conflict marker for internal merge", 14-04-2016).

Yeah, the t6036 testcase 'git detects conflict w/
criss-cross+contrived resolution' could be made to pass by tweaking
the conflict markers.  In fact, any tweak would make it appear to
pass, but the test could be updated to still fail by updating the
contrived resolution of a previous merge to use the newer conflict
marker style as well.

The test is kind of fragile in this way, and is really there just to
document this slightly weird and never seen in practice corner case.
I don't think we'll ever fix the underlying "problem"; not even sure
if it's possible without fundamentally re-thinking our merge strategy
altogether.  I just thought that when I was writing all those tests
that documenting this particular behavior as a testcase had some
value, but if the conflict markers are going to be updated
periodically, then the cost of the test may outweigh its value and we
should just toss this one test from that file.

Elijah
