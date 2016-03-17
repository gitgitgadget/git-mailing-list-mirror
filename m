From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: bug: sparse config interpretation incorrectness in 2.8.0-rc2
Date: Thu, 17 Mar 2016 20:20:07 +0700
Message-ID: <CACsJy8DH297aV2pYL7xGNZ5X24rR5PxvrpJQ+15YxpDNvqgS5Q@mail.gmail.com>
References: <56E9F5B3.6030903@fb.com> <20160317005632.GA17778@duynguyen-vnpc.dek-tpc.internal>
 <xmqq37rp35k1.fsf@gitster.mtv.corp.google.com> <CACsJy8A2D8CqeWZ6CFdTVXzXiWdonBE=3tWFPpe7-ZmDtNGYNw@mail.gmail.com>
 <alpine.DEB.2.20.1603171402330.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Durham Goode <durham@fb.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mateusz Kwapich <mitrandir@fb.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 17 14:20:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agXr1-0001PL-Gb
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 14:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966111AbcCQNUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 09:20:40 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33966 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756372AbcCQNUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 09:20:38 -0400
Received: by mail-lf0-f45.google.com with SMTP id e138so41081853lfe.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 06:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zlMzt2waxH3sIIDHDbtfdTV5QxZLtvBQ/qteE0wluWs=;
        b=KnMDNM4LlrQKtNyzMtO63HJPD6qV9gA+g9G4BBZlRkIOwGORHJSWF8XbzmkVBIvWiQ
         B7FO+kw2sHQUMNOQO4kYCFkV40MaC5aKKIUtu3+UW8jz6dhm/g8wdQzhFnXrknyJ5kjf
         IpHxUqZEZl4Sn7mZx2oRkjZBtgXO1RDz6anBRpFkKGtoHGrw/ag/7vEj45O5XcbJVvRC
         ttqG42CD6j1qTz13L9Hjmny7boJPCvmnHKAP27xSdz0qmiuLq+AdIb1KDMdUlqZYBOV5
         +QFeQ8kj+5c6I1/DbjuxJjXt90+a4SRL5poe+iwWfhO6Zh0V96oIzh/0JKfkG4YH2Fjw
         pqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zlMzt2waxH3sIIDHDbtfdTV5QxZLtvBQ/qteE0wluWs=;
        b=SndSsQi1VL8BrrVseZ1V7sD49h9AQpY/jC/Y1qYwt9XSAWDwxKygYCgxRYzwmme6tK
         sN3B2GLlfBTMAdQ2aAtvVOHUO5yCxOsRVrMcvZOTvlSNjHvuOktHDvnVbHtIIos/GyeS
         7quvYoqSAxVLxj/i+HjzHr7DEa4Xu2FcGUoDRee9H3bZtrSQ0scKNvj7pwhCSPuSp/GV
         BqjIyT+2Ks/JDsDpN8fzh/BlGWdBVYbgmyDsENvsYEhNo+X30Ra3B6m4ns7oUit+E2wT
         R9fNBCo/KupL4U0kH/kOTYwq25snlvLtqUg1CwcemmxlfqxKthAFQ3pQZJLQG76LR+/U
         tbrA==
X-Gm-Message-State: AD7BkJJYQlpTyocJ9SyFjsk/QI4+dJt6wYanpLFajAy9Emv0KPbEmAI2NVrjXa2KKDnXlZqNHmwSe1vg7dS1wQ==
X-Received: by 10.25.212.213 with SMTP id l204mr3764835lfg.118.1458220836882;
 Thu, 17 Mar 2016 06:20:36 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 06:20:07 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603171402330.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289112>

On Thu, Mar 17, 2016 at 8:04 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Thu, 17 Mar 2016, Duy Nguyen wrote:
>
>> Good news for you is there's "sparse checkout v2" in the work, that
>> would not rely on exclude engine and should be both faster and more
>> elegant. That should reduce "sparse checkout v1" usage to really small
>> cases.
>
> I dabbled myself with speeding up the entire exclude engine (essentially,
> I use a hash map of the non-wildcard prefixes to the corresponding line
> number). So I am interested to see what your approach is. Could you point
> me to it (I did not see any obvious branch in your GitHub space)?

First of all it's not about speeding up exclude engine. I think I did
that (sort of) already with untracked cache (have you tried it on
Windows?)

It's Junio's idea actually, what I'm implementing. The index contains
a list of _files_ yes?
What if the index contains also _directories_? Of course we can't
"refresh" or check if the whole directory is "dirty" like a file, so
those dirs will stay registered in the index, but be entirely missing
from worktree. The effect is the same as sparse checkout, except that
we keep all "hidden" files of sparse checkout in the index. In fact I
plan to reuse CE_SKIP_WORKTREE (from sparse checkout) to mark those
dirs.

The advantage is obvious: the index can be much smaller, which leads
to faster update and access. Of course now you can only hide either
whole directory, or hide nothing. It's less flexible than sparse
checkout "v1", but you can use "v1" on top of "v2" for that. Changing
checkout regions involves unfolding or folding certain directories,
sparse patterns are not used.

If you are still curious, you can check out my 'narrow-checkout'
branch on github. The basic is working. Folding/unfolding is not. Be
warned that it's even dirtier than your rebase-helper branch (and will
not be released any time soon either, lots of other stuff to be
finished first).
-- 
Duy
