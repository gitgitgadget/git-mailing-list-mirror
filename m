From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] stash: tighten IS_STASH_LIKE logic
Date: Fri, 19 Apr 2013 11:27:04 +0530
Message-ID: <CALkWK0m_Nt8SFdjGKWWHtBJ+HVsk095ukjZ0N=KBt5q+or5XFQ@mail.gmail.com>
References: <1366270717-19929-1-git-send-email-artagnon@gmail.com> <7vk3nz4h20.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 07:57:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT4KX-0008Pn-0g
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 07:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356Ab3DSF5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 01:57:46 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:37566 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753618Ab3DSF5p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 01:57:45 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so4256284iea.32
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 22:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=RnhOYXyLzYtbFiBsu229hrAQuzNoefsbRw3hFA09U2w=;
        b=ffdvn9Kyjn4o807v2KRJqCAuNmypQxtkGx8/kkzMGvDURtgLbS5SX7Of4o0SDyDEsT
         p3AJCb5Fw+OkJG+Hfig2OM614SDyc9ggzuiJL7aLI9ppIOgXcL1voAwgwHEkcBMWoQwD
         ZK7m7/dV+dqLPT3ZCQBT7FSWa0o/NvaPzxA3bb17vCXmRLsH+qwfB3/ewSVcTAZfnmF8
         XjovGcbYJHkzspg+oy0j9M4ix9OqkH6V/2S5mX2Vb/EB9u/XlSw3nprSYyHWNNHtR0DK
         LHY58r7oA+UTxgNLG0+gplJYiwUg+dMxM11BsjiLattW+FEFR7IpbIi6HZZgooM5j1QT
         UWdA==
X-Received: by 10.50.119.102 with SMTP id kt6mr8645681igb.12.1366351064297;
 Thu, 18 Apr 2013 22:57:44 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 18 Apr 2013 22:57:04 -0700 (PDT)
In-Reply-To: <7vk3nz4h20.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221740>

Junio C Hamano wrote:
> [...]

I'm curious.  Why are you going back on what you said just one day
ago?  What changed?

In a previous email, you wrote:
> You are free to try to think of a way to tighten the implemention to
> reject a random two-or-three parent merge commit that is not a
> product of "stash create".  People already have looked at this code
> since it was written, and didn't find a reasonable way to tighten it
> without triggering false negatives, so I wouldn't be surprised if
> anybody tried it again today and failed.

So, my patch is not a "reasonable" way to achieve this?

> When was the last time you tried to run "git stash apply next"?

My patch is not solving an end-user problem.  Think of it as a source
code comment: to answer the question "what kind of commit does stash
create make?", the reader simple has to look at when IS_STASH_LIKE is
set.  It's helping make the source code clearer.  Previously,
IS_STASH_LIKE might as well have been named IS_MERGE_COMMIT, and
nothing would've changed.  The reader will wonder what IS_MERGE_COMMIT
has to do with stashes, so we named it IS_STASH_LIKE.  This is another
minor improvement in the same spirit.

> Is it worth it?

Is it worth what?  What are we losing?
